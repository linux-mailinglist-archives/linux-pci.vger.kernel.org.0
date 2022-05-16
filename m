Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75121529220
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 23:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242969AbiEPUyI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 16:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348731AbiEPUyA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 16:54:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675D65549A;
        Mon, 16 May 2022 13:28:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 364F261320;
        Mon, 16 May 2022 20:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C59C385AA;
        Mon, 16 May 2022 20:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652732908;
        bh=gKKKp2IFlKGmu4OzI8+KOncEkeS2si8oUBWbBkn/28M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pGGDSo5lKN8IWry3pLK3c3Dxn8xdlGhp+HBX/A99quXoYoYQt9gzSIZuaxSrFiA47
         TcgNTt+AapxXzkci2C7wTUWmg1iMGmArpfrINsy/7M/LWsAkawoBJ5OHm56AkfJD0e
         iSx/2nAm6s9H3ZsNG9E+qm7F+Kmbfvx7xNY7TnGBv5tASX0bS4GlHbZpn2/FLIhg/E
         wdCpBgpiK38Xv0CQNoZY3LvsqgSCkYlmZkni6FEZRBb2YUjKg2K41t59i60QFGAzAV
         DGDIByQwuSYItNtYXMWk/SHTB2JzHkj4HKqoklLoO8ELmhkvznMjBiBekBhqASGbKk
         XT7KOVwk/bwAw==
Date:   Mon, 16 May 2022 15:28:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "windy.bi.enflame" <windy.bi.enflame@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] drivers/pci: wait downstream hierarchy ready instead of
 slot itself ready, after secondary bus reset
Message-ID: <20220516202825.GA1047972@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516173047.123317-1-windy.bi.enflame@gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Lukas, pciehp expert; Alex, reset person]

Thanks for the testing, analysis, and patch!

Run "git log --oneline drivers/pci/pci.c" and make your subject line
similar.

On Tue, May 17, 2022 at 01:30:47AM +0800, windy.bi.enflame wrote:
> While I do reset test of a PCIe endpoint device on a server, I find that
> the EP device always been removed and re-inserted again by hotplug module,
>  after secondary bus reset.
> 
> After checking I find:
> 1> "pciehp_reset_slot()" always disable slot's DLLSC interrupt before
>    doing reset and restore after reset, to try to filter the hotplug
>    event happened during reset.
> 2> "pci_bridge_secondary_bus_reset()" sleep 1 seconad and "pci_dev_wait()"
>    until device ready with "PCIE_RESET_READY_POLL_MS" timeout.
> 3> There is a PCIe switch between CPU and the EP devicem the topology as:
>    CPU <-> Switch <-> EP.
> 4> While trigger sbr reset at the switch's downstream port, it needs 1.5
>    seconds for internal enumeration.

s/seconad/second/
s/devicem/device/
s/sbr/SBR/
s/"pciehp_reset_slot()"/pciehp_reset_slot()/ also for other functions

> About why 1.5 seconds ready time is not filtered by "pci_dev_wait()" with
> "PCIE_RESET_READY_POLL_MS" timeout, I find it is because in
> "pci_bridge_secondary_bus_reset()", the function is operating slot's
> config space to trigger sbr and also wait slot itself ready by input same
> "dev" parameter. Different from other resets like FLR which is triggered
> by operating the config space of EP device itself, sbr is triggered by
> up slot but need to wait downstream devices' ready, so I think function
> "pci_dev_wait()" works for resets like FLR but not for sbr.
> 
> In this proposed patch, I'm changing the waiting function used in sbr to
> "pci_bridge_secondary_bus_wait()" which will wait all the downstream
> hierarchy ready with the same timeout setting "PCIE_RESET_READY_POLL_MS".
> In "pci_bridge_secondary_bus_wait()" the "subordinate" and
> "subordinate->devices" will be checked firstly, and then downstream
> devices' present state.
> 
> Signed-off-by: windy.bi.enflame <windy.bi.enflame@gmail.com>

See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v5.17#n407
regarding pseudonyms.

> ---
>  drivers/pci/pci.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9ecce435fb3f..d7ec3859268b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5002,6 +5002,29 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
>  	}
>  }
>  
> +int pci_bridge_secondary_bus_wait(struct pci_dev *bridge, int timeout)
> +{
> +	struct pci_dev *dev;
> +	int delay = 1;
> +
> +	if (!bridge->subordinate || list_empty(&bridge->subordinate->devices))
> +		return 0;
> +
> +	list_for_each_entry(dev, &bridge->subordinate->devices, bus_list) {
> +		while (!pci_device_is_present(dev)) {
> +			if (delay > timeout) {
> +				pci_warn(dev, "secondary bus not ready after %dms\n", delay);
> +				return -ENOTTY;
> +			}
> +
> +			msleep(delay);
> +			delay *= 2;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  void pci_reset_secondary_bus(struct pci_dev *dev)
>  {
>  	u16 ctrl;
> @@ -5045,7 +5068,7 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
>  {
>  	pcibios_reset_secondary_bus(dev);
>  
> -	return pci_dev_wait(dev, "bus reset", PCIE_RESET_READY_POLL_MS);
> +	return pci_bridge_secondary_bus_wait(dev, PCIE_RESET_READY_POLL_MS);
>  }
>  EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
>  
> -- 
> 2.36.1
> 
