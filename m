Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EE742F5EA
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 16:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240643AbhJOOqM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 10:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240633AbhJOOqJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 10:46:09 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAD2C061762;
        Fri, 15 Oct 2021 07:44:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so9521546pjw.0;
        Fri, 15 Oct 2021 07:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MJKYZ0DmEpP1c+Cyc4zstBHahVie6foEwa+j6qM9UhA=;
        b=PB5yktV/ub7HqC20LufS0j08yKPnVALPVgzyvDwsxvrVrVcQixB/EB6YPc+JIMu+ar
         yoENAo4stX/Y6X2yBLrRWo9YWjJo+AQ/CGhVh88rXCrlyusLG8mADi0TLW37tnEKWKXV
         ZDZPwyHP+DjuY+La534/Rdb5RXEzZbdjDEIm+dCCMLyFbDYkAIgwBL5eMIPKLynktEv+
         MdPiMm9RTNI6/inp3ScRrGDXxmyNbkqwmS+l0+X2OrlW716XPJ1Hjxx7rdbjEFzyAwk9
         HI20wPgr7JmeLpb5drVfenrAS1th9QPRhhpk/XKcsO9mRK0pM5FXtTrqOBdZAKk1cSjy
         tm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MJKYZ0DmEpP1c+Cyc4zstBHahVie6foEwa+j6qM9UhA=;
        b=sXYq5jAEG1uPt0p3VPm6eJ/7OokPp/agOpPud5D1eY/21gQVPTxAJZiRc0ISfRpW6I
         Q4SXrNyZ8Cd8rwvcSo/R7sZN7upyR5+UYJt20hpYdqU1lQRC4qJ9C0Ixtj5+YEqMBFkr
         mX+6CrUKOLjoswoYNLJVyG2OXeg8emBIgZs5ehHsjBLseU8zEytFFMZ/f2a/1+9YWQz0
         NIKhbnb0+T7/Gf3f0L+EFjAlAZ4EX/uKZerMg08KDNsIW9p7fdHXnp/rB94eXMKYH72j
         ESmmTVh7kA0bjd92fjvVVNQzbRqme3lCDVAebHUPh+4F4MpI/GNbn7D59Bo/mTPV7Yw5
         i48w==
X-Gm-Message-State: AOAM531PNFXw8/te6ZTN77QolRK/BfqYVDUL2s6wyFQ3zi+WEat9vEmI
        e9opM/j0lQQMujulZR/sz48=
X-Google-Smtp-Source: ABdhPJwFF4cjJO6JehPcfRawKHCZyqAMPX+66Ii/ds5YGW7OM7k+bLu2mTJzx+lW8crVIAUkT/oqmg==
X-Received: by 2002:a17:90b:1644:: with SMTP id il4mr28408623pjb.179.1634309042196;
        Fri, 15 Oct 2021 07:44:02 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:4806:9a51:7f4b:9b5c:337a])
        by smtp.gmail.com with ESMTPSA id f18sm5293491pfa.60.2021.10.15.07.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:44:01 -0700 (PDT)
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
Subject: [PATCH v2 08/24] PCI: exynos: Remove redundant error fabrication when device read fails
Date:   Fri, 15 Oct 2021 20:08:49 +0530
Message-Id: <c576d5ab04e2f4d79c5eaa8f3564c3053c079716.1634306198.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634306198.git.naveennaidu479@gmail.com>
References: <cover.1634306198.git.naveennaidu479@gmail.com>
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

