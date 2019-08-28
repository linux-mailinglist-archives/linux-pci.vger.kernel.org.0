Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B32CA0776
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 18:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfH1Qgn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 12:36:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43398 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfH1Qgn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 12:36:43 -0400
Received: by mail-ed1-f65.google.com with SMTP id h13so692683edq.10
        for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2019 09:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3JNWpHXZU/aa0aBL4bmI4Ioqw08cqJCb7QH5Ooq5hac=;
        b=qo8W2T7IeuJlGyxV79T2P+Ga3XkXd6ke7e1RMFpzmqs5UZn01y/3dEW7aos24HRDfL
         j8v6PLRohyLdiOufNThqCa7b3pMa61k4BZBW9BVa2qD4XUqxSkDrxAUtmPGyNEWs7nnB
         ypRLgRNPBTgu2CBB2MmtNfv6mrL60cDmNaTxbN2y5x23tzvJ2kfoIzrj9N+zj3+u/QXk
         7zbFU3hqB9L0MNAGEX0TEMd+vehefoRms2bfwySlCVeCMZoltlMvR4ZvvJqpomsO2fkI
         QJrqaBkhAgifIIso3SRIAs5NB1UwyVT6VNKT7nhiMWyGqFEUvYuN2UGmrAw1gpH4S0Qb
         8ysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3JNWpHXZU/aa0aBL4bmI4Ioqw08cqJCb7QH5Ooq5hac=;
        b=LSi0JrcQGNom56XBBONJzD/auPyXXfe83O7mGpWF2YZYC6sAgCYjlmmoR15VUi/OFI
         J7xk8sO7FBJ5QEqWN5sQnoasKl3SWSOare9rUnKyX/mKG7SK+8GT7nzUUzYMVYlHPMPZ
         zfnBGDfD6DsZPE7ZLNDrqUnIrI8aJO/X+1N0+J57fild3CxWM7Y5Epsq917XSBz0IWmo
         a9EZhhJo5h0OJZEEZVsmZEN0yBY5rj8t8xFqccv8AfERgF8TxjaEpnmBuIZ+9s0oGlez
         JY7PX44xusTZev75ip0eDbhN0rhV6HZzMv/XWwLVq9rH6u8EHMDNjzHh3i40X8qV949F
         HnVw==
X-Gm-Message-State: APjAAAXyBewHO7jOhy7YkoDPyAU8CFj9SKR1DEGwsuv/VPIPVHi174q6
        1zqXb38eMbqbs5qBbphGnU0=
X-Google-Smtp-Source: APXvYqzu1Brl59dFQAGAWDUJm53TeL7ZP+Xh/kidXo+mABEOlS3Fk3Azq20RtWGS9bpOTKoQPqknnQ==
X-Received: by 2002:a50:9127:: with SMTP id e36mr4940140eda.219.1567010201644;
        Wed, 28 Aug 2019 09:36:41 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id w14sm558550eda.69.2019.08.28.09.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 09:36:40 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Murray <andrew.murray@arm.com>, linux-pci@vger.kernel.org,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH 2/5] PCI: imx6: Properly handle optional regulators
Date:   Wed, 28 Aug 2019 18:36:33 +0200
Message-Id: <20190828163636.12967-2-thierry.reding@gmail.com>
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

Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: kernel@pengutronix.de
Cc: linux-imx@nxp.com
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 8b8efa3063f5..acfbd34032a8 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1174,8 +1174,8 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 
 	imx6_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
 	if (IS_ERR(imx6_pcie->vpcie)) {
-		if (PTR_ERR(imx6_pcie->vpcie) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+		if (PTR_ERR(imx6_pcie->vpcie) != -ENODEV)
+			return PTR_ERR(imx6_pcie->vpcie);
 		imx6_pcie->vpcie = NULL;
 	}
 
-- 
2.22.0

