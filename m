Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3431F632706
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiKUOzs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiKUOze (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:55:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52873CFBB1;
        Mon, 21 Nov 2022 06:45:16 -0800 (PST)
Message-ID: <20221121140048.849246242@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=UZS11zTOR4JGS38C/7fpGOXRWJz4E7s7evBEbCg06U4=;
        b=IWtyqOfanQvxMKLKPN7fGmW0o2xzn3gxDdqo42IMVg9Go9jVble5nrAW32WLYffMsexzIe
        6xZqA8JwqEwxsd5s+n34HYkK4IQE/I7b5mubvR1xwecgbiLsWt+LqUXg+Nm6hAA2gZEW9l
        eYaVC9A321U0BFH4+X+7frVNI8v+mymmOD2j6yvTyjiMo/N9GSjfxTg2nkBR8tdcplOKXY
        V/FnCfBUHON7jcCpS0UpPjeSSog9cxOizd4H2nuU2F58W6IaOHoCccVypBg+JbuXx/Jbon
        c1qX/CWJeig/KNzt2AtIBaVjFMwfnCknfMtszTsI8iJeJCuRmA0fc3MdXtiEoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=UZS11zTOR4JGS38C/7fpGOXRWJz4E7s7evBEbCg06U4=;
        b=OrC9JZmx1rLqXQ93KbSuzak2wSNsDqJQEtHxMHymOfW7NHPiReiyEOeokmJ7IE84OTcH94
        HsxU9DQJTVOibgDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: [patch V2 09/40] genirq/msi: Extend msi_parent_ops
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:39:39 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Supporting per device MSI domains on ARM64 and the zoo of interrupt
mechanisms needs a bit more information than what the initial x86
implementation provides.

Add the following fields:

  - required_flags: 	The flags which a parent domain requires to be set
  - bus_select_token:	The bus token of the parent domain for select()
  - bus_select_mask:	A bitmask of supported child domain bus types

This allows to provide library functions which can be shared between
various interrupt chip implementations and avoids replicating mostly
similar code all over the place.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -556,6 +556,14 @@ enum {
  * struct msi_parent_ops - MSI parent domain callbacks and configuration info
  *
  * @supported_flags:	Required: The supported MSI flags of the parent domain
+ * @required_flags:	Optional: The required MSI flags of the parent MSI domain
+ *			Mandatory for ARM_GIC_MSI_LIB users
+ * @bus_select_token:	Optional: The bus token of the real parent domain for
+ *			irq_domain::select()
+ *			Mandatory for ARM_GIC_MSI_LIB users
+ * @bus_select_mask:	Optional: A mask of supported BUS_DOMAINs for
+ *			irq_domain::select()
+ *			Mandatory for ARM_GIC_MSI_LIB users
  * @prefix:		Optional: Prefix for the domain and chip name
  * @init_dev_msi_info:	Required: Callback for MSI parent domains to setup parent
  *			domain specific domain flags, domain ops and interrupt chip
@@ -563,6 +571,9 @@ enum {
  */
 struct msi_parent_ops {
 	u32		supported_flags;
+	u32		required_flags;
+	u32		bus_select_token;
+	u32		bus_select_mask;
 	const char	*prefix;
 	bool		(*init_dev_msi_info)(struct device *dev, struct irq_domain *domain,
 					     struct irq_domain *msi_parent_domain,

