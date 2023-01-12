Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CAA668701
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jan 2023 23:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjALWcU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 17:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240256AbjALWbz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 17:31:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEACC7
        for <linux-pci@vger.kernel.org>; Thu, 12 Jan 2023 14:31:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E004E62138
        for <linux-pci@vger.kernel.org>; Thu, 12 Jan 2023 22:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F21C433D2;
        Thu, 12 Jan 2023 22:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673562712;
        bh=mXHpn08S6EHCHo8cNBcz3BXtKlEnqzpeLZmV2ASFLoQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bQY/p22BcK8x9gmKJxKKJASl3pACu1G0ltLRQTgR0z/S3IVal3VAnBV245Li0A2Bz
         88/ASvrjcBG4Cf/bRd02RKGpcUV77CF5S9XNK8Coitta345QAMvjpcWX+HtxALF8tG
         +g3vwT77Y1bSu4c4AuhkOTdruuQQDDRSAikfH1xhhaQiGiK3jHzN+Czjt7zdCrzP3A
         Jr5r0gvs4Vnuf9/wU8vSPHPTBaqJ4YGiLong7PFkzyvAVVQtuW+nTV9+kndAzS16TA
         1EDgrGvSOkdNOqGoAFd1+4RQ3b5kiqrn4vPdWU8RDCeGsueePQheVgMOCFCq6/IU0e
         Lrv47DfUxXWlA==
Date:   Thu, 12 Jan 2023 16:31:50 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>
Subject: Re: [PATCH 2/3] PCI: Unify delay handling for reset and resume
Message-ID: <20230112223150.GA1798426@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd6ac49d60c1ca6fe5c27c2fa54b78d70a8ba07b.1672511017.git.lukas@wunner.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Dec 31, 2022 at 07:33:38PM +0100, Lukas Wunner wrote:
> Sheng Bi reports that pci_bridge_secondary_bus_reset() may fail to wait
> for devices on the secondary bus to become accessible after reset:
> 
> Although it does call pci_dev_wait(), it erroneously passes the bridge's
> pci_dev rather than that of a child.  The bridge of course is always
> accessible while its secondary bus is reset, so pci_dev_wait() returns
> immediately.
> 
> Sheng Bi proposes introducing a new pci_bridge_secondary_bus_wait()
> function which is called from pci_bridge_secondary_bus_reset():
> 
> https://lore.kernel.org/linux-pci/20220523171517.32407-1-windy.bi.enflame@gmail.com/
> 
> However we already have pci_bridge_wait_for_secondary_bus() which does
> almost exactly what we need.  So far it's only called on resume from
> D3cold (which implies a Fundamental Reset per PCIe r6.0 sec 5.8).
> Re-using it for Secondary Bus Resets is a leaner and more rational
> approach than introducing a new function.
> 
> That only requires a few minor tweaks:
> 
> - Amend pci_bridge_wait_for_secondary_bus() to await accessibility of
>   the first device on the secondary bus by calling pci_dev_wait() after
>   performing the prescribed delays.  pci_dev_wait() needs two parameters,
>   a reset reason and a timeout, which callers must now pass to
>   pci_bridge_wait_for_secondary_bus().  The timeout is 1 sec for resume
>   (PCIe r6.0 sec 6.6.1) and 60 sec for reset (commit 821cdad5c46c ("PCI:
>   Wait up to 60 seconds for device to become ready after FLR")).
> 
> - Amend pci_bridge_wait_for_secondary_bus() to return 0 on success or
>   -ENOTTY on error for consumption by pci_bridge_secondary_bus_reset().
> 
> - Drop an unnecessary 1 sec delay from pci_reset_secondary_bus() which
>   is now performed by pci_bridge_wait_for_secondary_bus().  A static
>   delay this long is only necessary for Conventional PCI, so modern
>   PCIe systems benefit from shorter reset times as a side effect.
> 
> Fixes: 6b2f1351af56 ("PCI: Wait for device to become ready after secondary bus reset")
> Reported-by: Sheng Bi <windy.bi.enflame@gmail.com>
> Tested-by: Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v4.17+
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pci/pci-driver.c |  2 +-
>  drivers/pci/pci.c        | 50 ++++++++++++++++++----------------------
>  drivers/pci/pci.h        |  3 ++-
>  3 files changed, 25 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index a2ceeacc33eb..02e84c87f41a 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -572,7 +572,7 @@ static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
>  
>  static void pci_pm_bridge_power_up_actions(struct pci_dev *pci_dev)
>  {
> -	pci_bridge_wait_for_secondary_bus(pci_dev);
> +	pci_bridge_wait_for_secondary_bus(pci_dev, "resume", 1000);

It sounds like this 1000 ms value is prescribed by sec 6.6.1, so we
should have a #define for it.  I know we didn't use one even before,
but this seems like a a good opportunity to add it.

>  /**
>   * pci_bridge_wait_for_secondary_bus - Wait for secondary bus to be accessible
>   * @dev: PCI bridge
> + * @reset_type: reset type in human-readable form
> + * @timeout: maximum time to wait for devices on secondary bus

I think we should mention here that the timeout is in milliseconds.

Bjorn
