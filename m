Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951D27AA0A6
	for <lists+linux-pci@lfdr.de>; Thu, 21 Sep 2023 22:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjIUUoZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Sep 2023 16:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjIUUoN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Sep 2023 16:44:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794F5469A0
        for <linux-pci@vger.kernel.org>; Thu, 21 Sep 2023 13:19:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FFFC433C9;
        Thu, 21 Sep 2023 20:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695327587;
        bh=xWEIRWXj05GUTaD8qirv/QkW2FL2c9FXXdrXuuhf1C8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=u+yrhG2icnDf4urB1Qsl6vbI2Lye4JaQj8ijGAq0kHJxImiRcXlMychggzJQP2zYT
         wNJYhfVUezXtHQJZk2d8Zm11gsfyLyLnlaCIU8Wjn/5cJteNG6fFk71Um80cEjGHeE
         rn6tU+SuJNy9/DjRreJlzShSG3yjUxQ4pYqH5RXm9F3XMprNqiFLbrz2V5R36Pmdeh
         FVY9I8ud2KwDiqn/t3zx93AXdxkQRtVvozTobKYzskpU0KqkiXUvmF5lNqUNOWzSZy
         C6LUFBcojNsKzvfcLUh93WXxLEIGNogUCuq6q4Dcjz/vB9XZQAiyYhDElZfw1ZtDDY
         0jbmjaC/uzMHg==
Date:   Thu, 21 Sep 2023 15:19:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mark Blakeney <mark.blakeney@bullet-systems.net>,
        Kamil Paral <kparal@redhat.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Mark devices disconnected if their upstream PCIe
 link is down on resume
Message-ID: <20230921201945.GA343804@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918053041.1018876-1-mika.westerberg@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Kamil, Chris]

On Mon, Sep 18, 2023 at 08:30:41AM +0300, Mika Westerberg wrote:
> Mark Blakeney reported that when suspending system with a Thunderbolt
> dock connected and then unplugging the dock before resume (which is
> pretty normal flow with laptops), resuming takes long time.
> 
> What happens is that the PCIe link from the root port to the PCIe switch
> inside the Thunderbolt device does not train (as expected, the link is
> upplugged):
> 
> [   34.903158] pcieport 0000:00:07.2: restoring config space at offset 0x24 (was 0x3bf12001, writing 0x3bf12001)
> [   34.903231] pcieport 0000:00:07.0: waiting 100 ms for downstream link
> [   36.140616] pcieport 0000:01:00.0: not ready 1023ms after resume; giving up
> 
> However, at this point we still try the resume the devices below that
> unplugged link:
> 
> [   36.140741] pcieport 0000:01:00.0: Unable to change power state from D3cold to D0, device inaccessible
> ...
> [   36.142235] pcieport 0000:01:00.0: restoring config space at offset 0x38 (was 0xffffffff, writing 0x0)
> ...
> [   36.144702] pcieport 0000:02:02.0: waiting 100 ms for downstream link, after activation
> 
> And this is the link from PCIe switch downstream port to the xHCI on the
> dock:
> 
> [   38.380618] xhci_hcd 0000:03:00.0: not ready 1023ms after resume; waiting
> [   39.420587] xhci_hcd 0000:03:00.0: not ready 2047ms after resume; waiting
> [   41.527250] xhci_hcd 0000:03:00.0: not ready 4095ms after resume; waiting
> [   45.793957] xhci_hcd 0000:03:00.0: not ready 8191ms after resume; waiting
> [   54.113950] xhci_hcd 0000:03:00.0: not ready 16383ms after resume; waiting
> [   71.180576] xhci_hcd 0000:03:00.0: not ready 32767ms after resume; waiting
> ...
> [  105.313963] xhci_hcd 0000:03:00.0: not ready 65535ms after resume; giving up
> [  105.314037] xhci_hcd 0000:03:00.0: Unable to change power state from D3cold to D0, device inaccessible
> [  105.315640] xhci_hcd 0000:03:00.0: restoring config space at offset 0x3c (was 0xffffffff, writing 0x1ff)
> ...
> 
> This ends up slowing down the resume time considerably. For this reason
> mark these devices as disconnected if the link above them did not train
> properly.
> 
> Fixes: e8b908146d44 ("PCI/PM: Increase wait time after resume")
> Reported-by: Mark Blakeney <mark.blakeney@bullet-systems.net>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217915
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied with Lukas' Reviewed-by to pm for v6.7.

e8b908146d44 appeared in v6.4.  Seems like maybe a candidate for
stable?  IIUC, resume actually does work, but takes 65+ seconds longer
than it should?

Kamil also bisected a 60+ second resume delay to e8b908146d44
(https://lore.kernel.org/r/CA+cBOTeWrsTyANjLZQ=bGoBQ_yOkkV1juyRvJq-C8GOrbW6t9Q@mail.gmail.com),
but IIUC at
https://lore.kernel.org/linux-pci/20230824114300.GU3465@black.fi.intel.com/T/#u
you concluded that Kamil's issue was related to firmware and actually
had nothing to do with e8b908146d44.

Do you still think Kamil's issue is unrelated to e8b908146d44 and this
patch?  If so, how do we handle Kamil's issue?  An answer like "users
of v6.4+ must upgrade their Thunderbolt firmware" seems like it would
be kind of a nightmare for users.

> ---
>  drivers/pci/pci-driver.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index a79c110c7e51..51ec9e7e784f 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -572,7 +572,19 @@ static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
>  
>  static void pci_pm_bridge_power_up_actions(struct pci_dev *pci_dev)
>  {
> -	pci_bridge_wait_for_secondary_bus(pci_dev, "resume");
> +	int ret;
> +
> +	ret = pci_bridge_wait_for_secondary_bus(pci_dev, "resume");
> +	if (ret) {
> +		/*
> +		 * The downstream link failed to come up, so mark the
> +		 * devices below as disconnected to make sure we don't
> +		 * attempt to resume them.
> +		 */
> +		pci_walk_bus(pci_dev->subordinate, pci_dev_set_disconnected,
> +			     NULL);
> +		return;
> +	}
>  
>  	/*
>  	 * When powering on a bridge from D3cold, the whole hierarchy may be
> -- 
> 2.40.1
> 
