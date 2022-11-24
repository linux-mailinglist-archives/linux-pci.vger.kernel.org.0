Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2926A638192
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiKXX2r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiKXX2f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:28:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ACDBFF64;
        Thu, 24 Nov 2022 15:26:54 -0800 (PST)
Message-ID: <20221124232326.326410494@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=cFx6dbaS3ynUGuWTq2v8hXwBFa/HBDy+17s0E2mkPoM=;
        b=31K5q8uMuBncINZnLxPkhytuZEEXrW9lk0LdW6v3qDdvlw2PUjFKemzgH5YU8uEMr6zOCz
        mQQgK/1O//+uOU9hKmvMuo3lRgaisQFZC/qyQVHnfUZA7nhR0aUxf2n5GdcJuRqlOa8Pzx
        HzF+S8MFzbZnZp4F7vket2pvkCZxlRcwHQDn9ENI9xi7hLjgL5rfXBKJz0qqVoffFhPYYH
        BeJVbFixw9uMF+IYOEhAk5da3hIkuoXvEICPY/q2cQGRG4SLuDRAervbnrlziMQ+8/1jfc
        KanIfjMThPO9/ciqXi7uVCWKveu2lzPaw+wKZ3rJxOTj/k6blJN8C3TWSpLf/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=cFx6dbaS3ynUGuWTq2v8hXwBFa/HBDy+17s0E2mkPoM=;
        b=kicHVkBwhMOxAjBHtI5ZkgE0oos+EEIN5rtJ/aaOwuNNNa3ML2NdxyuZ+k0klKqWjbRLZd
        t0xNj4Vu7AN/BdAw==
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
Subject: [patch V3 18/33] genirq/msi: Provide struct msi_map
References: <20221124230505.073418677@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:26:13 +0100 (CET)
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

