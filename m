Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0BE66873A
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jan 2023 23:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjALWsN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 17:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjALWsL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 17:48:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B37C34;
        Thu, 12 Jan 2023 14:48:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A1D6621D5;
        Thu, 12 Jan 2023 22:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E1DC433EF;
        Thu, 12 Jan 2023 22:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673563689;
        bh=DDpvlr2GS0X+OPHCJ5aEaoqpj2oWYg/kS2LrC/ulgO4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=q8KM8fKPqRXaEVf6Nhkp0nbY2m6hr6xTaD8FPSMeaEGJERjRqCAAKwHGAZ3XrgAv/
         iOXXYX2fJfbmyJXe0y7lPznvL9aOruJArTgb+KFcQera+jNN3NOsEjIrN0rFff/knR
         xpBZxnURCENHYZxx5W5qfsK8BfaoT0gPeUB2gh6T3Nf1phYH8XCZNZGIr3ESKio+Mx
         XniVAKyAQ1G7u+p1sdhXXgh5Qx0U+mMp9iZ6JOtScgtQvRz274fCtQziGRXhn2TuXz
         GcT5HB1rtXGnlUX9CIdYQ/RxmFff1SvDrvtk0VZCGUPRgqwCP53H3L2AA8pbBQACRi
         NyE2rs/90jl3g==
Date:   Thu, 12 Jan 2023 16:48:08 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yang Su <yang.su@linux.alibaba.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        alex.williamson@redhat.com, matthew@wil.cx,
        jbarnes@virtuousgeek.org, rjw@sisk.pl, greg@kroah.com,
        patchwork-bot@kernel.org, andrew.murray@arm.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/1] PCI: Tune secondary bus reset time for PCIe
Message-ID: <20230112224808.GA1799425@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230101092233.vztb_lr0suMH4WASooIbGmfszl_HFnozGSIcu3ycowA@z>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Lukas, Mika]

Hi Yang Su,

Thank you for your patch!

On Sun, Jan 01, 2023 at 05:22:33PM +0800, Yang Su wrote:
> On PCI Express, there will be cases where the new code sleeps far less
> than the 1s being replaced by this patch. This should be okay, because
> PCI Express Base Specification Revision 5.0 Version 1.0 (May 22, 2019)
> in Section 6.6.1 "Conventional Reset" only notes 100ms as the minimum
> waiting time. After this time, the OS is permitted to issue
> Configuration Requests, but it is possible that the device responds
> with Configuration Request Retry Status (CRS) Completions, rather than
> Successful Completion. Returning CRS can go on for up to 1 second after
> a Conventional Reset (such as SBR) before the OS can consider the device
> broken. This additional wait is handled by pci_dev_wait. Besides,
> this patch also cover PCI and PCI-X after device reset waiting Tpvrh 1000ms.
> 
> Currently, the only callchain that lands in the function modified by
> this patch which invokes one out of two versions of pcibios_reset_secondary_bus
> that both end with a call to pci_reset_secondary_bus.
> 
> Afterwards, pci_reset_secondary_bus always invokes pci_dev_wait
> which wait for the device to return a non-CRS completion.
> 
> Signed-off-by: Yang Su <yang.su@linux.alibaba.com>
> ---
>  drivers/pci/pci.c | 36 +++++++++++++++++++++++++++++++++---
>  1 file changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index fba95486caaf..8e4899755718 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5063,10 +5063,40 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
>  	 * Trhfa for conventional PCI is 2^25 clock cycles.
>  	 * Assuming a minimum 33MHz clock this results in a 1s
>  	 * delay before we can consider subordinate devices to
> -	 * be re-initialized.  PCIe has some ways to shorten this,
> -	 * but we don't make use of them yet.
> +	 * be re-initialized.
> +	 *
> +	 * For conventional PCI needing 1s delay after bus reset.
> +	 * Using pci_is_pcie to judge the bus is pci or pcie.
> +	 * If the bus is pci, sleeping 1s to wait device is ready.
> +	 *
> +	 * And if the bus is pcie, PCI Express Base Specification Revision 2.0
> +	 * (December 20, 2006) in Section 6.6.1 "Conventional Reset" only notes
> +	 * 100ms as the minimum waiting time, the same as the newer PCIe spec
> +	 * PCI Express Base Specification Revision 3.0 Version 1.a (December 7, 2015)
> +	 * and PCI Express Base Specification Revision 5.0 Version 1.0 (May 22, 2019).
> +	 * With a Downstream Port that supports Link speeds greater than 5.0 GT/s,
> +	 * software must wait a minimum of 100 ms after Link training completes before
> +	 * sending a Configuration Request to the device immediately below that Port.
> +	 * After this time, the OS is permitted to issue Configuration Requests,
> +	 * but it is possible that the device responds with Configuration Request
> +	 * Retry Status (CRS) Completions, rather than Successful Completion.
> +	 * Returning CRS can go on for up to 1 second after a Conventional Reset
> +	 * (such as SBR) before the OS can consider the device. This additional
> +	 * wait is handled by pci_dev_wait.
> +	 *
> +	 * Currently, the only callchain that lands in the function modified by
> +	 * this patch starts at pci_bridge_secondary_bus_reset which invokes
> +	 * one out of two versions of pcibios_reset_secondary_bus that both end
> +	 * with a call to pci_reset_secondary_bus.
> +	 * Afterwards, pci_bridge_secondary_bus_reset always invokes pci_dev_wait.
>  	 */
> -	ssleep(1);
> +	if (pci_is_pcie(dev))
> +		if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT)
> +			msleep(100);
> +		else
> +			pcie_wait_for_link(dev, true);
> +	else
> +		ssleep(1);

This code is also updated by Lukas' patch at
https://lore.kernel.org/r/bd6ac49d60c1ca6fe5c27c2fa54b78d70a8ba07b.1672511017.git.lukas@wunner.de,
which is pretty much ready to go.

Can you take a look at that series and see whether it solves the same
problem you're solving here?  And if not, can you provide feedback on
what would still be needed?

If you do need something on top of Lukas' series, please CC him if you
post a revised patch.

Bjorn
