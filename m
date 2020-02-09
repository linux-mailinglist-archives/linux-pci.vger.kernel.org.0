Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9B2156AEF
	for <lists+linux-pci@lfdr.de>; Sun,  9 Feb 2020 16:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgBIPDb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Feb 2020 10:03:31 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:51627 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbgBIPDb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Feb 2020 10:03:31 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 1BABC3000469E;
        Sun,  9 Feb 2020 16:03:29 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E5810129957; Sun,  9 Feb 2020 16:03:28 +0100 (CET)
Date:   Sun, 9 Feb 2020 16:03:28 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Keith Busch <kbusch@kernel.org>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, narendra_k@dell.com
Subject: Re: [PATCH v3] PCI: pciehp: Make sure pciehp_isr clears interrupt
 events
Message-ID: <20200209150328.2x2zumhqbs6fihmc@wunner.de>
References: <20200207195450.52026-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207195450.52026-1-stuart.w.hayes@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 07, 2020 at 02:54:50PM -0500, Stuart Hayes wrote:
> +/*
> + * Set a limit to how many times the ISR will loop reading and writing the
> + * slot status register trying to clear the event bits.  These bits should
> + * not toggle rapidly, and there are only six possible events that could
> + * generate this interrupt.  If we still see events after this many reads,
> + * there is likely a bit stuck.
> + */
> +#define MAX_ISR_STATUS_READS 6

Actually only *three* possible events could generate this interrupt
because pcie_enable_notification() only enables DLLSC, CCIE and
either of ABP or PDC.


> -	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
> +	if (status) {
> +		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, status);

Writing "events" instead of "status" would seem to be more advantageous
because it reduces the number of loops.  Say you read PDC in the first
loop iteration, then DLLSC in the second loop iteration and shortly
before writing the register, PDC transitions to 1.  If you write
"events", you can make do with 2 loop iterations, if you write "status"
you'll need 3.


> +
> +		/*
> +		 * Unless the MSI happens to be masked, all of the event
> +		 * bits must be zero before the port will send a new
> +		 * interrupt (see PCI Express Base Specification Rev 5.0
> +		 * Version 1.0, section 6.7.3.4, "Software Notification of
> +		 * Hot-Plug Events"). So, if an event bit gets set between
> +		 * the read and the write of PCI_EXP_SLTSTA, we need to
> +		 * loop back and try again.
> +		 */
> +		if (status_reads++ < MAX_ISR_STATUS_READS)
> +			goto read_status;

Please use "pci_dev_msi_enabled(pdev)" as conditional for the if-clause,
we don't need this with INTx.


Using a for (;;) or do/while loop that you jump out of if
(!status || !pci_dev_msi_enabled(pdev)) might be more readable
than a goto, but I'm not sure.

Thanks,

Lukas
