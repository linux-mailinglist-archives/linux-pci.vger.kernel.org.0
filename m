Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBC86381AB
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiKXXa3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiKXX3x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:29:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210484B748;
        Thu, 24 Nov 2022 15:27:55 -0800 (PST)
Message-ID: <20221124232326.787373104@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=IEK08cS7O6Uv3gBo3cg3kU1MfAmms/KMIPye21Vs0c0=;
        b=GWJDmfgqlPDlcLgKShBue/3ax/oc97kX1RgHr8iv9Zn2f2/PLSJ6s632PjSyOq3Rd7qieL
        fDTGqW0xUpCzOiO/sX6NYComheclNwtAaMgvsit/evGkb/PXnXNkGkQ+Hc3U3H2YxMSFWQ
        nbY+0XlXGXNu5cy0tQt3gg1NhdNXDz7ANC2fOnsyj8SpybTiB7yYE8Mg0l07dzqWrAX8Yo
        YP23ghg/OlZcrSmaZr2CQtAvSWKIwLLfVN5XLiLLkrxLW4Lzg6qVc0j4dsBNa9RRmUKH6K
        f38fM5eIdJcqAHkcYGTHo3EKvReXZRTXqnjgIbl6s+MSGyel+jvRyOaKFnHnDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=IEK08cS7O6Uv3gBo3cg3kU1MfAmms/KMIPye21Vs0c0=;
        b=ZRY48GSY8X2TF4+9ZB5PNWBha3Rgy0GzxB9q2DxXum7yebn3F09iLhLaxmuk2Q4WKMRPN9
        BlLD0c2ZIWQMn/AQ==
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
Subject: [patch V3 26/33] x86/apic/msi: Enable MSI_FLAG_PCI_MSIX_ALLOC_DYN
References: <20221124230505.073418677@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:26:26 +0100 (CET)
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

