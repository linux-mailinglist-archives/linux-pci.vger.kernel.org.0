Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C3D51F314
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 05:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiEIDxp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 May 2022 23:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiEIDqQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 May 2022 23:46:16 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BD83CA40
        for <linux-pci@vger.kernel.org>; Sun,  8 May 2022 20:42:23 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id DE64E30002AAA;
        Mon,  9 May 2022 05:42:16 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id C94442B1988; Mon,  9 May 2022 05:42:16 +0200 (CEST)
Date:   Mon, 9 May 2022 05:42:16 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, pali@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 06/18] PCI: pciehp: Enable DLLSC interrupt only if
 supported
Message-ID: <20220509034216.GA26780@wunner.de>
References: <20220220193346.23789-1-kabel@kernel.org>
 <20220220193346.23789-7-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220220193346.23789-7-kabel@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Feb 20, 2022 at 08:33:34PM +0100, Marek Behún wrote:
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -788,6 +788,7 @@ static int pciehp_poll(void *data)
> @@ -800,12 +801,17 @@ static void pcie_enable_notification(struct controller *ctrl)
>  	 * next power fault detected interrupt was notified again.
>  	 */
>  
> +	pcie_capability_read_dword(ctrl_dev(ctrl), PCI_EXP_LNKCAP, &link_cap);
>  	/*
> -	 * Always enable link events: thus link-up and link-down shall
> -	 * always be treated as hotplug and unplug respectively. Enable
> -	 * presence detect only if Attention Button is not present.
> +	 * Enable link events if their support is indicated in Link Capability
> +	 * register: thus link-up and link-down shall always be treated as
> +	 * hotplug and unplug respectively. Enable presence detect only if
> +	 * Attention Button is not present.
>  	 */
> -	cmd = PCI_EXP_SLTCTL_DLLSCE;
> +	cmd = 0;
> +	if (link_cap & PCI_EXP_LNKCAP_DLLLARC)
> +		cmd |= PCI_EXP_SLTCTL_DLLSCE;

The Data Link Layer Link Active Reporting Capable bit is cached
in ctrl_dev(ctrl)->link_active_reporting.  Please use that
instead of re-reading it from the register.

According to PCIe r6.0, sec. 7.5.3.6, "For a hot-plug capable
Downstream Port [...], this bit must be hardwired to 1b."

That has been part of the spec since PCIe r1.1, sec. 7.8.6.

PCIe r1.0 did not contain the sentence because it did not support
DLLLARC (it defined bit 20 as RsvdP).

In other words, what you're doing here is add support for PCIe r1.0.
I'm not opposed to that, but I'd assume that aardvark supports a
more recent spec version.  More likely it doesn't comply with the spec?

What is the user-visible issue that you're experiencing without this
commit?  Does aardvark somehow misbehave if the DLLLARC bit is set to 1?
Since the bit is RsvdP, setting it shouldn't have any negative side
effects.


> --- a/drivers/pci/hotplug/pnv_php.c
> +++ b/drivers/pci/hotplug/pnv_php.c
> @@ -840,6 +840,7 @@ static void pnv_php_init_irq(struct pnv_php_slot *php_slot, int irq)
>  	struct pci_dev *pdev = php_slot->pdev;
>  	u32 broken_pdc = 0;
>  	u16 sts, ctrl;
> +	u32 link_cap;
>  	int ret;
>  
>  	/* Allocate workqueue */

pnv_php.c is a driver for PowerNV, yet this patch is for a series
targeting an ARM PCIe controller.  That doesn't make sense,
changes to pnv_php.c seem wrong here.

Thanks,

Lukas
