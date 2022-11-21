Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E27B632640
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiKUOiu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbiKUOhx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:37:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF5875DAB;
        Mon, 21 Nov 2022 06:37:52 -0800 (PST)
Message-ID: <20221121091326.714126704@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+EnVp4kAb6M4W1pf5Y3h6BpyD9pQdSwPS/mCr1aM3ww=;
        b=Zw1WnrzAhW2up7twI+QxubPCa4I1ZK2c3o5rGU6fH4IYZUd/1rEWW1gHXFNBfsYp805KzJ
        1tB9TRT1vGnUCqeSAaX5uNniKyDknyfJXOTtPRjVwK+WDLc3JkjNtOaKelsrLDH7HyO4iP
        +MaZf+Zp4qbyY5LkleRNHMfT8OD3biFFuHNkahjK6YzcpOV/oeibxArFfS3lElaAgUO/qX
        WiPsT3uT5vxWiTm5RbsZLWKdbXY0Usgyi6rU25PK1CQ3xNgqwlP6xCQUaXd97FuqyTnd+C
        EcIf08lYKDL5c8A6XD8vWDZqTN+QR7uJim0I2zhoIka84UTGeEjK0senCcQWYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+EnVp4kAb6M4W1pf5Y3h6BpyD9pQdSwPS/mCr1aM3ww=;
        b=ELjM57HbrvBL5+yH7YAMmSzY8RlotfKMsHr7QVOlEx/lM61n/mY523aTsbT2U0eHOphGAq
        lLyAGCdaanIuhTAQ==
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
Subject: [patch V2 04/33] genirq/msi: Add size info to struct msi_domain_info
References: <20221121083657.157152924@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:37:51 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

To allow proper range checking especially for dynamic allocations add a
size field to struct msi_domain_info. If the field is 0 then the size is
unknown or unlimited (up to MSI_MAX_INDEX) to provide backwards
compability.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -414,6 +414,7 @@ struct msi_domain_ops {
  * struct msi_domain_info - MSI interrupt domain data
  * @flags:		Flags to decribe features and capabilities
  * @bus_token:		The domain bus token
+ * @hwsize:		The hardware table size (0 if unknown/unlimited)
  * @ops:		The callback data structure
  * @chip:		Optional: associated interrupt chip
  * @chip_data:		Optional: associated interrupt chip data
@@ -425,6 +426,7 @@ struct msi_domain_ops {
 struct msi_domain_info {
 	u32				flags;
 	enum irq_domain_bus_token	bus_token;
+	unsigned int			hwsize;
 	struct msi_domain_ops		*ops;
 	struct irq_chip			*chip;
 	void				*chip_data;

