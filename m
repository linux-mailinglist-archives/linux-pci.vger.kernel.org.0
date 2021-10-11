Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267C6429618
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 19:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhJKRzT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 13:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbhJKRzS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 13:55:18 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A90C061570;
        Mon, 11 Oct 2021 10:53:17 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q5so3469429pgr.7;
        Mon, 11 Oct 2021 10:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yQY7aUvtndoZpeI7zcTbeBS93aZ1xaTka3k7e0Wv25o=;
        b=QkiTAm9P7MyDTYthlnv6Fsv4494VNNpFET/VlZ4X0ml22KRH/CVG2AJTy18X6ONylK
         XMJwrUynxHJ3xfJisz4ulwyAghlZSkkIAPRHkKUm6cX3r17oZGxtA9EoLNVdLLiW2DOo
         h9GjDZF6L18K6Wnm+4KhQw36dGXR5IoyGxhwzhC5OuOUksfTPu7pjrVVhW1zFCq/ATad
         51Wa3+ERB6sVngwa+KZfU+1OUADRML6SJHUFztc7uiS0aS74Sn2Tjc1MlXnuCy81g5jh
         abqyOf9GU/13vReJoaixiXD4U9ckKbWYfJbOSQKP2EnddXipXtyhYYG9aoOI/y+ZT/Kc
         AuPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yQY7aUvtndoZpeI7zcTbeBS93aZ1xaTka3k7e0Wv25o=;
        b=1lNJannp9ltet9TEvbzKZZMrECuSbTMnXV8J6sfcC5jODMSVUC/lnEwjd2ZivFgzWQ
         49h40qYoy5HB6QVRP6lFwSwpEJ2Opd456BtS7ZC35Q2p/7zeXAKKiLdWtU+oGlIuFNBx
         HbTEKmiA1M4i7THo5GZfKvD+9aPLDjzhIaNcrTJdRi4SOwEvGpfBhxf9IEoLbYTUUx6A
         hIZedV0SbtEs+vAd7gxEArfnC8XEzZrWdIeuQEqqrThIU/k5wja3T2BycPPt/0Q+VLUi
         EzyvBFTa1eAVRhxbA23eKDXfLjjyCCqbFUcAJvlpP3iVEYWbF8n9quhhCUZExhQrgYJE
         hmaQ==
X-Gm-Message-State: AOAM531GDGYUxzRL2zy06euqyl0ZUo8tBKYcEoE0xdRtjuSUDB2f2OLq
        iNf9Hxa19zm9r7YprVU+DfOBV+LfvHboNOST
X-Google-Smtp-Source: ABdhPJwLy/3c/gEUvOtMpB3SxbWuiPUUEKkZasnDVajspjgXahcgNTfVCtvZiErGXhfpVvww6Q7tkA==
X-Received: by 2002:a63:c4b:: with SMTP id 11mr19018518pgm.214.1633974797410;
        Mon, 11 Oct 2021 10:53:17 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:9f95:848b:7cc8:d852:ad42])
        by smtp.gmail.com with ESMTPSA id o4sm7876249pfb.48.2021.10.11.10.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 10:53:17 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR
        SAMSUNG EXYNOS),
        linux-samsung-soc@vger.kernel.org (open list:PCI DRIVER FOR SAMSUNG
        EXYNOS)
Subject: [PATCH 06/22] PCI: exynos: Use SET_PCI_ERROR_RESPONSE() when device not found
Date:   Mon, 11 Oct 2021 23:22:48 +0530
Message-Id: <c6093448693d9623d66ba3f1d7b9ce990494410c.1633972263.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633972263.git.naveennaidu479@gmail.com>
References: <cover.1633972263.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error.  There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

Use SET_PCI_ERROR_RESPONSE() to set the error response, when a faulty
read occurs.

This helps unify PCI error response checking and make error check
consistent and easier to find.

Compile tested only.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/dwc/pci-exynos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index c24dab383654..1fdbef184532 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -217,7 +217,7 @@ static int exynos_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
 	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
 
 	if (PCI_SLOT(devfn)) {
-		*val = ~0;
+		SET_PCI_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
-- 
2.25.1

