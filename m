Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF75625C83
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbiKKOIB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbiKKOHO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:07:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4558B2F6;
        Fri, 11 Nov 2022 06:00:02 -0800 (PST)
Message-ID: <20221111135206.290494880@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=cFx6dbaS3ynUGuWTq2v8hXwBFa/HBDy+17s0E2mkPoM=;
        b=atG8rpd91NRpYl0NcH3GpRv2SRHF9L0DV9zTaUTQygN/9IVAw8kBeJ/h3+Q6JoD9m+pDzG
        18AbMEcrH0KOIC1wjok4L8NVBeIM5xELaH0dRvPqTk/s9uITGMgvIgeW92DA98VNmbFWjX
        d4OA6MVm3mctMwNhNJxkICPjI4zwPbN7rM9bgrmNRmIew80vGUo4KHvgQfT1VRl7nkWZLZ
        SFPsvz8HmY1JC26BoKp+C92Lz+BmBhIvJmWDvqUJSXrDpEsE5C6cglJPFV5zFINMVWJSWu
        PY+kHXhRLRGFtgl63wtuZiH6r6AruhL4BdWLPclzhxRf7141xvhdcsOKIXM1Yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=cFx6dbaS3ynUGuWTq2v8hXwBFa/HBDy+17s0E2mkPoM=;
        b=dHMvsZJX+lBhFbmVFdWB6D0JYLbBOOJSI/elEezyZn7Lp1N3KffCA7mzwQwNeuWNCLNd2d
        sK48C1TObUNP0CBw==
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
Subject: [patch 18/33] genirq/msi: Provide struct msi_map
References: <20221111133158.196269823@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:58:39 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A simple struct to hold a MSI index / Linux interrupt number pair. It will
be returned from the dynamic vector allocation function and handed back to
the corresponding free() function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi_api.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/include/linux/msi_api.h
+++ b/include/linux/msi_api.h
@@ -18,6 +18,19 @@ enum msi_domain_ids {
 	MSI_MAX_DEVICE_IRQDOMAINS,
 };
 
+/**
+ * msi_map - Mapping between MSI index and Linux interrupt number
+ * @index:	The MSI index, e.g. slot in the MSI-X table or
+ *		a software managed index if >= 0. If negative
+ *		the allocation function failed and it contains
+ *		the error code.
+ * @virq:	The associated Linux interrupt number
+ */
+struct msi_map {
+	int	index;
+	int	virq;
+};
+
 unsigned int msi_domain_get_virq(struct device *dev, unsigned int domid, unsigned int index);
 
 /**

