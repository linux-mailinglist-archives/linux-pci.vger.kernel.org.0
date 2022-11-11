Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BCF625C5A
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbiKKOF2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbiKKOFE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:05:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A2889FB6;
        Fri, 11 Nov 2022 05:59:04 -0800 (PST)
Message-ID: <20221111135205.486390836@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=wvq/UAWBnWLIn373I3iZtaQ+G1F0GV+IlK6QQPaFqcU=;
        b=Oi5Fm2esocx23HpZQOPMAz84HbKkki4TfiPD2o+PYIJeY+Q3tFA9Ao+RfshJWWoNuc+u83
        bKF5cP8o156ZnFlGZkUhlEUrC9Y4fZESVghFE6K/Cnny8Cy34pBdT0U96HrURFPZaAkUdC
        KzJkWiwshMmaxz8rSSvZMvJ4GmZld0YC6orJF+DI5Ysvov4AhNEKvAom8RVUMUtdRdKewQ
        c95eHw09X2ramu0QIwfUTXmwbzokyWT3IA44aD9+mt25iUbhmGcHVyhC+6Ed1PedgbU1/g
        TY12GFZoi3OhRO6QqmPnmREhT1shvepahKntwBqgjuOfgp98yC+K+Uc+0sv/hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=wvq/UAWBnWLIn373I3iZtaQ+G1F0GV+IlK6QQPaFqcU=;
        b=L0f1/AJbwQ15elJ92Io5gqA0ZWGqy0dco6cbPo5Pk3o4px+alA0hfzKHSG4K/nGQJDbBtL
        UExpj31mr8BvYLDw==
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
Subject: [patch 04/33] genirq/msi: Add size info to struct msi_domain_info
References: <20221111133158.196269823@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:58:17 +0100 (CET)
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
@@ -410,6 +410,7 @@ struct msi_domain_ops {
  * struct msi_domain_info - MSI interrupt domain data
  * @flags:		Flags to decribe features and capabilities
  * @bus_token:		The domain bus token
+ * @hwsize:		The hardware table size (0 if unknown/unlimited)
  * @ops:		The callback data structure
  * @chip:		Optional: associated interrupt chip
  * @chip_data:		Optional: associated interrupt chip data
@@ -421,6 +422,7 @@ struct msi_domain_ops {
 struct msi_domain_info {
 	u32				flags;
 	enum irq_domain_bus_token	bus_token;
+	unsigned int			hwsize;
 	struct msi_domain_ops		*ops;
 	struct irq_chip			*chip;
 	void				*chip_data;

