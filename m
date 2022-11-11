Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD98625C9C
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbiKKOJf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbiKKOHq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:07:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9359B56F;
        Fri, 11 Nov 2022 06:00:23 -0800 (PST)
Message-ID: <20221111135206.744090813@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=IEK08cS7O6Uv3gBo3cg3kU1MfAmms/KMIPye21Vs0c0=;
        b=IAhJ5osT2t16lOQAonBG82NQzMxg4Tq5cCzOL0d1amv+X4espll+mE7YvTH4Y5xXw6bupX
        q/KgfAJH6ZNCa4jIESyiDja5Dz7txX50u1+hsRiEClO+tKje9ygtagpp/WgToCefPX8CAU
        gT1vFgReh4O/xruAHCXPPbmXZIxTB3zwXnU7uc+gdmOmkmVyTIMV5t77rWv/lWLSxj0vS5
        5TC3kcvpOaUeWm5yyGFg8RT+WeSN+hgby8aY/E1lJADEsBlSTUWZ/W0dy0wAtDxVkY8MS0
        dxL5uKYwNNlv1TulVL8chqpW2EkFWQ6uyUjVXGGdD6/f2KWr7MjiOV4zAXforA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=IEK08cS7O6Uv3gBo3cg3kU1MfAmms/KMIPye21Vs0c0=;
        b=RmDxjYptyA0usCvYz11VZfEM+CrBHgHy7PuUXVexROTc6damGBuyrDxnYoyMWYAdEoV60p
        l7j5wDBFGwlamFDw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [patch 26/33] x86/apic/msi: Enable MSI_FLAG_PCI_MSIX_ALLOC_DYN
References: <20221111133158.196269823@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:58:52 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

x86 MSI irqdomains can handle MSI-X allocation post MSI-X enable just out
of the box - on the vector domain and on the remapping domains,

Add the feature flag to the supported feature list

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/msi.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/include/asm/msi.h
+++ b/arch/x86/include/asm/msi.h
@@ -63,7 +63,7 @@ struct msi_msg;
 u32 x86_msi_msg_get_destid(struct msi_msg *msg, bool extid);
 
 #define X86_VECTOR_MSI_FLAGS_SUPPORTED					\
-	(MSI_GENERIC_FLAGS_MASK | MSI_FLAG_PCI_MSIX)
+	(MSI_GENERIC_FLAGS_MASK | MSI_FLAG_PCI_MSIX | MSI_FLAG_PCI_MSIX_ALLOC_DYN)
 
 #define X86_VECTOR_MSI_FLAGS_REQUIRED					\
 	(MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS)

