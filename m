Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87DC042F5FB
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 16:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240689AbhJOOrX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 10:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240681AbhJOOrW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 10:47:22 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6916EC061764;
        Fri, 15 Oct 2021 07:45:16 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id f5so8792711pgc.12;
        Fri, 15 Oct 2021 07:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oxis35XdZSIgJr6mklaAXMEQHUEVDMfz+GZuoz2m4I8=;
        b=bHF3MVmMD4KZ3VipJ6gbsgTAs58lBf7KZekNmTmtHSVziT8Bj5Q4nj6WoGR4JJh1X9
         ptoYV/uKzVs7KLN79M4K1dzreOtUNb3OmhKFeQMusup3PG8bmgu8CiNw3FPEYJaSgecw
         F5KNxdHmHmbQmrDwWHdIJMc7EQMypxSo+ZckstpfprL10QAqD5Wu4hVtllulE6qOjIsU
         Gre2jphM64b+ETzcdr5HAuHIgCP1bUlletjTOtO96cvW+D60ab9ERHcl8PWksUIWxawH
         WdMcMIrisLQeK8YuWhXYZGSySNUvCWKsXceWP6SViEtyTw1woJ5paAWojSijJnSA54OM
         FpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oxis35XdZSIgJr6mklaAXMEQHUEVDMfz+GZuoz2m4I8=;
        b=J9tnTqElRf49xt2KiCAWCSocULQy6ihZtjRmkkndM3TvpsPB/USr5zzzvVAfnm1BaR
         vraTa58kT91qa39Jg93jLU+ks6elBKoFap3jQRGGlpyyQknaPoz0H4i8XSIBk4qhDMLY
         dOLeFRgdvZoSogLEtRCvWdgmAhRyuSZZbiOTF+AxTjM/y+L+wMr4ubmR89yysC4gXa+k
         i/Gg64pNE7yoZqmeII4TlvHsmdGqyyDxJB5gvSHdntt+FzLdlIaJZvK50cAOcOmMyssk
         G89UeVjT54d/oqLh1SKg3wysAJvi2A7iL8mBAgQdj1QYyDWvPCuzUTU9eer0B6334D6D
         Qang==
X-Gm-Message-State: AOAM532FBJ2wEYhbN1fpUpHMiBuimZcmJSKlkLj1PwPmvY/0UdtIMbch
        PMZKPlFUYGgUwUGZlBVj4Yg=
X-Google-Smtp-Source: ABdhPJyRQZ0uhDDsgFuUWNaw1Mmhj5b/guuZItbpnQb9Eb1O9szMMGggSfvh5Z8HkGi9Z+VXPCBt6g==
X-Received: by 2002:a63:f346:: with SMTP id t6mr9505513pgj.345.1634309115853;
        Fri, 15 Oct 2021 07:45:15 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:4806:9a51:7f4b:9b5c:337a])
        by smtp.gmail.com with ESMTPSA id f18sm5293491pfa.60.2021.10.15.07.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:45:15 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joyce Ooi <joyce.ooi@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH v2 13/24] PCI: altera: Remove redundant error fabrication when device read fails
Date:   Fri, 15 Oct 2021 20:08:54 +0530
Message-Id: <178022540498862f4d16e5738b5d5c1fac008afe.1634306198.git.naveennaidu479@gmail.com>
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
 drivers/pci/controller/pcie-altera.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 2513e9363236..a6bdf9aff833 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -510,10 +510,8 @@ static int altera_pcie_cfg_read(struct pci_bus *bus, unsigned int devfn,
 	if (altera_pcie_hide_rc_bar(bus, devfn, where))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	if (!altera_pcie_valid_device(pcie, bus, PCI_SLOT(devfn))) {
-		*value = 0xffffffff;
+	if (!altera_pcie_valid_device(pcie, bus, PCI_SLOT(devfn)))
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
 
 	return _altera_pcie_cfg_read(pcie, bus->number, devfn, where, size,
 				     value);
-- 
2.25.1

