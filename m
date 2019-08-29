Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0895A1726
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2019 12:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfH2Kxc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Aug 2019 06:53:32 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39917 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbfH2Kxc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Aug 2019 06:53:32 -0400
Received: by mail-ed1-f66.google.com with SMTP id g8so3559473edm.6
        for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2019 03:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2SPOMFKgZSTVee5kDDmgM7l3ZhbxI3d8WmC/5XcLiLc=;
        b=YKOZFIrQeN3tIdyHoUuG0xTIgTA2UOioYfcT9S2ZkPdkzLl+CddK6+K+Kp6XIDepjA
         ts8wSGO+C7aOjZh1s98oKhwhfAU1hUV2LhzXFT3PjqEfKWaD4I3Z3bWKOgBJ7ZwxuN3t
         ow40vlg5VSIbIBIeEL801akAkGGOVTLGAjIHmU1LAe8wCCj60tNY3nqF18twngJ6b2+6
         0MyUm0EGe8rJ6R2hGJ/n9Bx/vhnr5QUSOYKyfvF5AU8eVzZfWAt53VkZFZNt9tkW15F2
         xYB/Z0FXBMZrIeQJg3DGJ1ksCngTvoCTgY10j++gvE86eM5iFz/GScZdf1Sp6FB7zF2u
         +s8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2SPOMFKgZSTVee5kDDmgM7l3ZhbxI3d8WmC/5XcLiLc=;
        b=H7lzdVbtcvDVoB6v3He+O8tlRhywMo7b6Bqo0s9qNkoEwMb6oQqnzX6qWCoi47kin4
         xvlM1R9DsWyn08SFshm1+RSIUPF4++muDIITeASxSJiMCux9yedXeorQ528yYpU3YDyc
         Z6AvvMYCXL5A1SffPybAPnOC1+PyvnDOPcMxHhUHzRuHjIA+gRGWnfHJaUF1heRYPTvV
         P2FF0LeMvd5ddKT+ARkFtePZK9v3O7k+WVvvF3w3o756MgIhRHpPw/UHIC90Q52ZXyUU
         SXjZ8MK3h0fJ6bVpXJcfi5uB8b1fS1RFiVPclfDzWFMzgSQluXzt6vj4dyD50yIRFLql
         8niw==
X-Gm-Message-State: APjAAAXOuzbiwLNZM7aoAyGD3B5kmp+s9EO6e0BcktYydey/VT8s9Bxd
        G1d1srcFw6GTpIkQFmKSjmQ=
X-Google-Smtp-Source: APXvYqwf/9wMdyWKiW+fgDSDwaKXsbKilFVOwkDy6OJtvmHc7KH2/FhCsUMDTDQgsQtGIkUZPTgs7A==
X-Received: by 2002:a17:906:1e8c:: with SMTP id e12mr7529320ejj.135.1567076010292;
        Thu, 29 Aug 2019 03:53:30 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id f6sm378777edv.30.2019.08.29.03.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 03:53:29 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Murray <andrew.murray@arm.com>, linux-pci@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 5/6] PCI: histb: Propagate errors for optional regulators
Date:   Thu, 29 Aug 2019 12:53:18 +0200
Message-Id: <20190829105319.14836-6-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829105319.14836-1-thierry.reding@gmail.com>
References: <20190829105319.14836-1-thierry.reding@gmail.com>
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
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
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

