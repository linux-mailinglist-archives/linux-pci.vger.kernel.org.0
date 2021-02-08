Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E5B313B3F
	for <lists+linux-pci@lfdr.de>; Mon,  8 Feb 2021 18:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbhBHRny (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Feb 2021 12:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbhBHRnD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Feb 2021 12:43:03 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F0CC061797
        for <linux-pci@vger.kernel.org>; Mon,  8 Feb 2021 09:41:39 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id es14so7325455qvb.3
        for <linux-pci@vger.kernel.org>; Mon, 08 Feb 2021 09:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lYKXVdnh/PO9XjtD5IgPdqemjTdpcMN6jzVdD0HqOds=;
        b=LySTcV8v08xg3n6sD04f5XU2Wwh15eukNDmnjeNYGfAF06hM2BlbfExiOLGaPIGKW7
         InKbZdUtvbEyo+3ToKAEsfDuRPEyMhZVoRagegoaV2Ep/YNv2bn+BD6INRkwnxRQuA37
         KWNAw39/80SX9iVbriz6CKOxZvBELz6MiLbOV65qSPY7eDsk1IJMi2p8EQvPrGvZoWao
         IeyFc8npDXD2lKwUc1K6siIGfIO7fFJWhNnPkYuLr/2PlUjPGYJ7/CtSSuXebHLIa8z7
         TSOoDG9ayXTE438VJKTB9Ef2EdzU1Ycc4hWZyfso16ZHlvuDDC3WBjqoqjbuMuLx6EOM
         yvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lYKXVdnh/PO9XjtD5IgPdqemjTdpcMN6jzVdD0HqOds=;
        b=jzqsonSVipXVy6wBYjY6dl03D4jtOyFNrzWdBy304nd/mE6WXAXpKgJPREjD2Rn8ip
         5nwed7lsL+1lnEXPdoGmTTjcT+THzSaj1lPavNVeF3563bR2hrXqX1aw7gFZ4Y88dl2J
         gSRTKyBN4Cnk6PfA9eGVqfn3W3ZYVkcSArSeR1RnPRgTuVjf0rEgY00xIngSn/UMQdin
         mofOYMYl0M4h5rwVQ2q+ng3Uy6fzXYzlYPvgdkDdHJwStf2AX35ALmGDc3NBkvLPvkzQ
         lZk9jmaWJ41Lwokj7sSn7stjWLowQnirmwOCVih2vdUe6IKkwVc6JK9mmsgcZmxv/+Zm
         PTTA==
X-Gm-Message-State: AOAM530sKCvFeE+k/YeqvaWb6T1A5awkhYvkd2NyYagVFJs/MguCoAgF
        bg2uvOqWOQBLUjcltB6GmYk=
X-Google-Smtp-Source: ABdhPJx9aIGk3y7k4n1/4ueMj7NTptTd+Kt0s9n2df3ZaY04d1fk8C/VPRXlAtuibrQnIZNLlPx07Q==
X-Received: by 2002:a0c:b617:: with SMTP id f23mr16808161qve.44.1612806098478;
        Mon, 08 Feb 2021 09:41:38 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:482:919::1001])
        by smtp.gmail.com with ESMTPSA id q20sm2629468qke.26.2021.02.08.09.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 09:41:37 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     bhelgaas@google.com
Cc:     jingoohan1@gmail.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        linux-pci@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH] PCI: dwc: exynos: Check the phy_power_on() return value
Date:   Mon,  8 Feb 2021 14:41:14 -0300
Message-Id: <20210208174114.615811-1-festevam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

phy_power_on() may fail, so we should better check its return
value and propagate it in the error case.

This fixes the following Coverity error:

	CID 1472841:  Error handling issues  (CHECKED_RETURN)
	Calling "phy_power_on" without checking return value (as is done elsewhere 40 out of 50 times).
	phy_power_on(ep->phy);
	phy_init(ep->phy);
           
Reported-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/pci/controller/dwc/pci-exynos.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index c24dab383654..eabedc0529cb 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -254,13 +254,17 @@ static int exynos_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct exynos_pcie *ep = to_exynos_pcie(pci);
+	int ret;
 
 	pp->bridge->ops = &exynos_pci_ops;
 
 	exynos_pcie_assert_core_reset(ep);
 
 	phy_reset(ep->phy);
-	phy_power_on(ep->phy);
+	ret = phy_power_on(ep->phy);
+	if (ret < 0)
+		return ret;
+
 	phy_init(ep->phy);
 
 	exynos_pcie_deassert_core_reset(ep);
-- 
2.25.1

