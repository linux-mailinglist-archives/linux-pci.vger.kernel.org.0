Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08A37B250B
	for <lists+linux-pci@lfdr.de>; Thu, 28 Sep 2023 20:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjI1SPA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Sep 2023 14:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjI1SO7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Sep 2023 14:14:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FFD19F
        for <linux-pci@vger.kernel.org>; Thu, 28 Sep 2023 11:14:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A038CC433CA;
        Thu, 28 Sep 2023 18:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695924896;
        bh=oowhAj1uCr1HIs9YKJnkg80Mwe8iLkU+3+VQVOIRrZg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uz06RGRwdeqgmmmN2oO1udkr0DCERXHJXQ7gQl6jNNbRQbPDS4jD8LnwyWP+upi4K
         RXJWZCGLX6V+1/SQeU+PWDikvcm77PS+sTWkjWPmqKArAaNYUZnKZP798q7WdfgLd8
         qoKiRf5r/C6fddAlXDX5FDwMEGomSpdt+sDRAZRRMspfq1yN32nHonbIkIYs3VzKbV
         4VkzLtCrls90QPpKAP9A8RwXryoNbI1GEVbtdMupTajxRur6j0SEOKUo567wXdYuzX
         spuq1WGxXQwArXj7SKVL4dF8CYNT2xcIPEQi8ccnKR0mjQtiIRZ7d1UkKE6FnCXfKh
         2C/954cgkbc6w==
Date:   Thu, 28 Sep 2023 13:14:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Chad Schroeder <CSchroeder@sonifi.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Lengthen reset delay for VideoPropulsion Torrent
 QN16e card
Message-ID: <20230928181454.GA492348@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47727e792c7f0282dc144e3ec8ce8eb6e713394e.1695304512.git.lukas@wunner.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 21, 2023 at 04:23:34PM +0200, Lukas Wunner wrote:
> Commit ac91e6980563 ("PCI: Unify delay handling for reset and resume")
> shortened an unconditional 1 sec delay after a Secondary Bus Reset to
> 100 msec for PCIe (per PCIe r6.1 sec 6.6.1).  The 1 sec delay is only
> required for Conventional PCI.
> 
> But it turns out that there are PCIe devices which require a longer
> delay than prescribed before first config space access after reset
> recovery or resume from D3cold:
> 
> Chad reports that a "VideoPropulsion Torrent QN16e" MPEG QAM Modulator
> "raises a PCI system error (PERR), as reported by the IPMI event log,
> and the hardware itself would suffer a catastrophic event, cycling the
> server" unless the longer delay is observed.
> 
> The card is specified to conform to PCIe r1.0 and indeed only supports
> Gen1 speed (2.5 GT/s) according to lspci.  PCIe r1.0 sec 7.6 prescribes
> the same 100 msec delay as PCIe r6.1 sec 6.6.1:
> 
>  "To allow components to perform internal initialization, system software
>   must wait for at least 100 ms from the end of a reset (cold/warm/hot)
>   before it is permitted to issue Configuration Requests"
> 
> The behavior of the Torrent QN16e card thus appears to be a quirk.
> Treat it as such and lengthen the reset delay for this specific device.
> 
> Fixes: ac91e6980563 ("PCI: Unify delay handling for reset and resume")
> Closes: https://lore.kernel.org/linux-pci/DM6PR16MB2844903E34CAB910082DF019B1FAA@DM6PR16MB2844.namprd16.prod.outlook.com/
> Reported-by: Chad Schroeder <CSchroeder@sonifi.com>
> Tested-by: Chad Schroeder <CSchroeder@sonifi.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v5.4+

Applied to reset for v6.7, thanks.

> ---
>  drivers/pci/quirks.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index eeec1d6f9023..91a15d79c7c4 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6188,3 +6188,15 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
> +
> +/*
> + * Devices known to require a longer delay before first config space access
> + * after reset recovery or resume from D3cold:
> + *
> + * VideoPropulsion (aka Genroco) Torrent QN16e MPEG QAM Modulator
> + */
> +static void pci_fixup_d3cold_delay_1sec(struct pci_dev *pdev)
> +{
> +	pdev->d3cold_delay = 1000;
> +}
> +DECLARE_PCI_FIXUP_FINAL(0x5555, 0x0004, pci_fixup_d3cold_delay_1sec);
> -- 
> 2.40.1
> 
