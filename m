Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D376625B90
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 14:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbiKKNyY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 08:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbiKKNyX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 08:54:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849DD6B380;
        Fri, 11 Nov 2022 05:54:22 -0800 (PST)
Message-ID: <20221111122013.831151822@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=hXGyAAuT/IU9qjkYv54P57CF8Kg9D2gsGu3taE3+4kw=;
        b=Q+w7rfhi1CD/id8ozBrg2Q21W5nVKor55fq9WBt8lCSQOVHcaMdncE2KL8ROw5Fn3DJ9Wy
        C6Gq/MFoG/TdPdL4180NCcfok/4hREfFzaUBJ2BmjZ4CE+WN7WxTwWtSOLaJ3+LD9kYY1j
        TeMFKUGxFAbHhfzCAwnA3C119hea+KSW+lcpY1H4pdCjjM97PrlqTIGom3CT1l9I0ocFXD
        G10ovxb7yJ25ZsdRupfmuMU0Sra+dE3GF4bYWQ/7cPGDS+UTUyJkHMxazfENu7wjY2KpoV
        n9hEYT+9jQQ5Lr1oLQSUrUgQfs9mO1k5gyzHqyjF8kOdb1h0q7MIXG+o1lSBMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=hXGyAAuT/IU9qjkYv54P57CF8Kg9D2gsGu3taE3+4kw=;
        b=cdP8Z8xVU6B5EEH8jHzk7TfeiPxnZMmWed+TgxJS3tdmgdVHc4X28EdbDT2icsz8tJCHaq
        CTp0kZmpTRg7YJAA==
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [patch 04/39] genirq/msi: Use MSI_DESC_ALL in msi_add_simple_msi_descs()
References: <20221111120501.026511281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:54:20 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are no associated MSI descriptors in the requested range when the MSI
descriptor allocation fails. Use MSI_DESC_ALL as the filter which prepares
the next step to get rid of the filter for freeing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/msi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -120,7 +120,7 @@ static int msi_add_simple_msi_descs(stru
 fail_mem:
 	ret = -ENOMEM;
 fail:
-	msi_free_msi_descs_range(dev, MSI_DESC_NOTASSOCIATED, index, last);
+	msi_free_msi_descs_range(dev, MSI_DESC_ALL, index, last);
 	return ret;
 }
 

