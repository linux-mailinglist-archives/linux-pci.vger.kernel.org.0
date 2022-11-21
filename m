Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303A1632676
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiKUOkg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiKUOiw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:38:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460E1C8CA1;
        Mon, 21 Nov 2022 06:38:20 -0800 (PST)
Message-ID: <20221121091327.922123028@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=IEK08cS7O6Uv3gBo3cg3kU1MfAmms/KMIPye21Vs0c0=;
        b=FOjNyluwYTVfgbUlUqvSpufgSPqPWBkjwYPpLU0srHbeiYCTZSwo7lp5CK1h5FxATnNEAo
        4vCpTPc0Br1TqaIk/94fe/heYvuRWm2RayisFudNKNyYRCi9DFxnnDx5pHRrI4PmtLyktt
        XtLnWmZIAaM3JEXu9SGcOAAOiYxQgjOS5OnS/9maUcsIWCvlHoEh5GJukurohD9GCK1xpb
        2EwBMLzcv1npoHqA+jBBKEpOpRlKm42sySIHvCjuA/myYZSW1a7zDjtUOm15Aq9ctqFOfp
        7MnxHN1ZQWZv7nSLLh2sTznP9CFekTYRhAvYAiPwpR6naKlvuGEYAtVP5pxhew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=IEK08cS7O6Uv3gBo3cg3kU1MfAmms/KMIPye21Vs0c0=;
        b=VC1cKWs2sBNafNezyRr5qwKNgCj2GyUHsobAOCxlVslC+hu/v3pASNRv4wDoPBHbOwsoq3
        pK26hIf97k96nODg==
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
        Allen Hubbe <allenbh@gmail.com>
Subject: [patch V2 26/33] x86/apic/msi: Enable MSI_FLAG_PCI_MSIX_ALLOC_DYN
References: <20221121083657.157152924@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:38:18 +0100 (CET)
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

