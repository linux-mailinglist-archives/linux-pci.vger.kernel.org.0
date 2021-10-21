Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849E543653F
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 17:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhJUPNd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 11:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbhJUPNa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 11:13:30 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32110C0613B9;
        Thu, 21 Oct 2021 08:11:14 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so770357pjb.3;
        Thu, 21 Oct 2021 08:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MJKYZ0DmEpP1c+Cyc4zstBHahVie6foEwa+j6qM9UhA=;
        b=H4WUq0TumzKIrsU3f7we9d8X7+IyqHU4jplezDVQHUebClWZ8Sfpfw9LhKAHVGUsAi
         jHdjcN+5HCh2rqngRQoWC08Yg1wzbLuwqNLntQctfnqRMjj84sMt4cnpDBhiya0mOSEK
         jJ7p/uNIEs1enX2Vp1dnjSCHqw4lsmA4lVyPLqvGe1g8YDkY14sItHlIE2kKpn8OU23n
         MV4axwNg8ldJVAh9ymaosTErkjbiQqrotMDu/udwIJ+sYyt+TIbpzsUpfYIro6mYrHC7
         CCD8JTLqjNaM7/CIxHUaM+XE3EWvWb3rg1uD+nS/ECKyDut6aF1cawI+x3+5LTEDWMoH
         mFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MJKYZ0DmEpP1c+Cyc4zstBHahVie6foEwa+j6qM9UhA=;
        b=jb2w6ZD4ywfQ+G25yZRsN9wK6Z2jXv8S5gVTCLCervdrmnw5zFUSO/frzk+3mrXmvO
         IFvkmPv8/kAelsCfEVDBEOpQXU6YEVny7e938krveXkzluYI7krtrmf0kZXx5qcS/UKI
         aLa+7qY6+MaMW+/Ppd/ArSwKokKShejVriuJweUVnAzRaDPv2HDZR3ZnPY1d4m+YrFue
         GwzMLmh4xh70R54ooQlHg/O98Ztk/lvqNPT+eGjYuubOhZiKjWGbHhElt4DKFq6nZxzZ
         X253Fu6leBwLBEzzC3VZ01J5V4+BJn1xkA6k/0SrtCfl68JUmrTX951YsYy2DyxklI6U
         y09w==
X-Gm-Message-State: AOAM531k7QEzSsm7+RJu+BbeHFtfVQmbYzDVRVZeI2XuTZvL7lrJx8Ci
        DtkEvPXSNSd1Y0LnzjVbeq0=
X-Google-Smtp-Source: ABdhPJxw6qmA4H9CuGRZSM2OTsKwx51IquIR23m9cD6LZfrtpp5Q60JEsUQ6WsWkmRkbHW74buIRmg==
X-Received: by 2002:a17:902:aa02:b0:13a:6c8f:407f with SMTP id be2-20020a170902aa0200b0013a6c8f407fmr5543484plb.59.1634829073661;
        Thu, 21 Oct 2021 08:11:13 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:29a4:d874:a949:6890:f95f])
        by smtp.gmail.com with ESMTPSA id c9sm5508027pgq.58.2021.10.21.08.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:11:13 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR
        SAMSUNG EXYNOS),
        linux-samsung-soc@vger.kernel.org (open list:PCI DRIVER FOR SAMSUNG
        EXYNOS)
Subject: [PATCH v3 08/25] PCI: exynos: Remove redundant error fabrication when device read fails
Date:   Thu, 21 Oct 2021 20:37:33 +0530
Message-Id: <397cccc97eadc2a21924457e7ab8be1800bcb0c2.1634825082.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634825082.git.naveennaidu479@gmail.com>
References: <cover.1634825082.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error. There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

The host controller drivers sets the error response values (~0) and
returns an error when faulty hardware read occurs. But the error
response value (~0) is already being set in PCI_OP_READ and
PCI_USER_READ_CONFIG whenever a read by host controller driver fails.

Thus, it's no longer necessary for the host controller drivers to
fabricate any error response.

This helps unify PCI error response checking and make error check
consistent and easier to find.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/dwc/pci-exynos.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index c24dab383654..f9526d6de160 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -216,10 +216,8 @@ static int exynos_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
 
-	if (PCI_SLOT(devfn)) {
-		*val = ~0;
+	if (PCI_SLOT(devfn))
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
 
 	*val = dw_pcie_read_dbi(pci, where, size);
 	return PCIBIOS_SUCCESSFUL;
-- 
2.25.1

