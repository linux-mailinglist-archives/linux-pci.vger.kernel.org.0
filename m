Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2D243654F
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 17:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhJUPOG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 11:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbhJUPOG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 11:14:06 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FC2C0613B9;
        Thu, 21 Oct 2021 08:11:50 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id np13so720170pjb.4;
        Thu, 21 Oct 2021 08:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ldCoPF9oxZH7/MigxipjFPAj1P91oCyhQC/cTDGjKcc=;
        b=dmsTt7gGeZ6Ingdes9k0K/kmiQqhxigkNRkb4fM8rPc//CHJ6S1lhobnI2ASG5RA59
         U4zHipA9ZkqLZ3DidNSBfVxOhnfNe16jV6HGfYnamT17BVR9WJhw0KuuSncsNQrQqrG9
         JQJmgda1aXD1LAv3U8RK5+ZGlkK4Wy1nGbrIQJydOEWBJx5PvmTsqEZ7ik8MCmOubHch
         QKAqXBRVW/FvQ4YTmanCW03kvGkmJ2+eaIhqJenfPzetkg2Ey72FGPeVhRxTY4WcsU4A
         aDU3N+XStHq+6tgoE8+KjiBIGQlIMLuh+DR3B7bPsiwVBB6L7w400MyvOhWsx2MZs5BL
         0T6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ldCoPF9oxZH7/MigxipjFPAj1P91oCyhQC/cTDGjKcc=;
        b=YEzGWj2sfSpMnb1wB4BqsXKS5mMKZiPQ6ygav3AJwueT+YBaGsyaDEIu2eSzOw9G6u
         8h13Fo3wFShigmXcfS0Gp9CjHxCXZnj4EB6hYA/GcJi5K/ZHM4cUVL1IuG5yo3/A1Ymd
         UOyMb8pA/jz+nJ3lbM/JbrhpZVPfJCdidGZ8GD7UtWFoWIlX+6+HJXHPJqLUy9l/87vu
         CNlzj3t37HfpTlpsogCgl/W35C7xNnwT88OwaEEBTjvEJYL34yp8TXLFrBkvu4FfX8Ll
         iSaHygMvqiUauQUSD//i8QLsSljNQr/XWbd68t/+iDP5OsDa9fsHlVhD2A44WpFb7Bj5
         HMFA==
X-Gm-Message-State: AOAM530u4vUhe37eI5G27rbEKIvpdaFpxrYfW95qQmB4wiw6xLU7eqVJ
        LZvOVQNFAC/dj0bz6fkIpWk=
X-Google-Smtp-Source: ABdhPJyPgn/QIIvhGMqguNzG74oSUTcbRqNd45tTyGuD2qwvaXrsopqL74oqLf9t++azxrVtjEwCCg==
X-Received: by 2002:a17:902:6bc8:b0:13f:8a54:1188 with SMTP id m8-20020a1709026bc800b0013f8a541188mr5677468plt.49.1634829109761;
        Thu, 21 Oct 2021 08:11:49 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:29a4:d874:a949:6890:f95f])
        by smtp.gmail.com with ESMTPSA id c9sm5508027pgq.58.2021.10.21.08.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:11:49 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH v3 10/25] PCI: kirin: Remove redundant error fabrication when device read fails
Date:   Thu, 21 Oct 2021 20:37:35 +0530
Message-Id: <f194865c4e4bcfed2debe05370748b6841687853.1634825082.git.naveennaidu479@gmail.com>
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
 drivers/pci/controller/dwc/pcie-kirin.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 026fd1e42a55..56ccc5ceee50 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -330,10 +330,8 @@ static int kirin_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
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

