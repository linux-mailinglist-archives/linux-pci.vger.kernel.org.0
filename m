Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2917A0778
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 18:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfH1Qgt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 12:36:49 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35474 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfH1Qgt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 12:36:49 -0400
Received: by mail-ed1-f66.google.com with SMTP id t50so755788edd.2
        for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2019 09:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=80ZrKgSivSW8WuAEFrIJj/qoImkkT28I8bgQGgM3b5k=;
        b=LrM+ynsYR7GYORsfwTv8c7QKitpkwJN75gF+hRzbK+Vgo/MXzNKqSvS8vLWW1xMtG8
         ET7L0yqhjluQecCxHpxpVaqGVJawp76CRaT84IXVxTKiRPVKdQ3S6Ogzqg7jMU1xZhOM
         SIPioVekpDg3RQmj553WXzEsmzrFKEKoL9nEIkeQHBPPltinhlKiG18EqheA1YQCX203
         uVIhpo0/ADDCr97CQtLqENWzGjI4fGEGriI8+9RnxMFIRCGma7S7ZX4nnP3PhtwvLdoz
         L3sIeK/2sJGU5rO6LAQuiJnldi7ZIpoRkLlgdUUH7VNTMWGE5kWFwGDDXVZtjfBy2LEe
         FRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=80ZrKgSivSW8WuAEFrIJj/qoImkkT28I8bgQGgM3b5k=;
        b=dQDVRyR1rw57YBksd459kTXV90WPPj0v2SF3TS+4OaAzfP0qqFbDokoBlaQWENjXbr
         y6JUFTjCKJFoH8dpNKfS9EuPHyxxGFZl2Hty8vgjqk7zMmUJDvWgXO2pn33OnTo3oi9r
         Qj6zmNfURY1ODMldg3Jvku7urpCCAOVnPRnjZ28RGsGRfEwe763+dcTNv9oC+lmuWwGN
         +s18uIg2DU3STNQ/klfrXqVlcmW+xuhIJ2Hrid27TA/s5VxrwApZoc+tUrjdlEw2hO+B
         WAIutYDdqCarbJbfIn4pSYMSfqe1xSgDC+DJCgoAY5a2w4OkiOkQh2rTASYLsPZCf44U
         C/Bg==
X-Gm-Message-State: APjAAAUMjTFujpG+5xd+egeBNqfZ/JTTWEXdwg3/hifkzD585vVkBx+Q
        J8CTEIPo9h9SrvYXRH0d+qs=
X-Google-Smtp-Source: APXvYqzjoRSE84BDLem3z/1CwoRMcw5726zQzh7WEENOVFsbq/kJwYtrSyuBh2TYolObPQ8xmkdlNQ==
X-Received: by 2002:a05:6402:789:: with SMTP id d9mr4884877edy.25.1567010207110;
        Wed, 28 Aug 2019 09:36:47 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id b3sm447457ejl.55.2019.08.28.09.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 09:36:45 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Murray <andrew.murray@arm.com>, linux-pci@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 4/5] PCI: histb: Properly handle optional regulators
Date:   Wed, 28 Aug 2019 18:36:35 +0200
Message-Id: <20190828163636.12967-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190828163636.12967-1-thierry.reding@gmail.com>
References: <20190828163636.12967-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

regulator_get_optional() can fail for a number of reasons besides probe
deferral. It can for example return -ENOMEM if it runs out of memory as
it tries to allocate data structures. Propagating only -EPROBE_DEFER is
problematic because it results in these legitimately fatal errors being
treated as "regulator not specified in DT".

What we really want is to ignore the optional regulators only if they
have not been specified in DT. regulator_get_optional() returns -ENODEV
in this case, so that's the special case that we need to handle. So we
propagate all errors, except -ENODEV, so that real failures will still
cause the driver to fail probe.

Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-histb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index 954bc2b74bbc..811b5c6d62ea 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -340,8 +340,8 @@ static int histb_pcie_probe(struct platform_device *pdev)
 
 	hipcie->vpcie = devm_regulator_get_optional(dev, "vpcie");
 	if (IS_ERR(hipcie->vpcie)) {
-		if (PTR_ERR(hipcie->vpcie) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+		if (PTR_ERR(hipcie->vpcie) != -ENODEV)
+			return PTR_ERR(hipcie->vpcie);
 		hipcie->vpcie = NULL;
 	}
 
-- 
2.22.0

