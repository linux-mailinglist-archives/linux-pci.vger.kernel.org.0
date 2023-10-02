Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CDF7B567E
	for <lists+linux-pci@lfdr.de>; Mon,  2 Oct 2023 17:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237981AbjJBPPA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Oct 2023 11:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238009AbjJBPO6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Oct 2023 11:14:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7405B8
        for <linux-pci@vger.kernel.org>; Mon,  2 Oct 2023 08:14:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E0FC433C7;
        Mon,  2 Oct 2023 15:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696259694;
        bh=1VTrfh1MNmbJgYqDDXWkOX/7atAp/neVph6B2W03f9I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MGCXcpuONjwqKCAQvsLqn9qibThhBeGTIo6IlK1SGG/fiFZR3blbeCJw+Q0/UUkJ6
         IDF2UcLaiJx+qzkG86fc6urzFLfdJ976kAF/chaNOu7wpNQuuSzteEcStsDXBzipuW
         eg22/avZRl2NZ078Hy2M6TgDbveKaRdmd/RzmqMQYtqLjJmVT6EYhJUKXukMgLeOEZ
         1vTmHcfSkpkIIR8tD7dSaaClNbKAMbdUW0PRRJ6n/8vDFpLN2la7oqXdk9PxfncI+4
         +EZWBVNzwi9zemAF+o0gp7MBe1xSa8AkkzokGJVj5utw85WF3GEAZOdpSSHy1YtzlD
         jgw6wGBERYLZA==
Date:   Mon, 2 Oct 2023 10:14:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Ajay Agarwal <ajayagarwal@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI/ASPM: fix unexpected behavior when re-enabling L1
Message-ID: <20231002151452.GA560499@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99e1891d-cd15-5e7b-6ac8-8c6dc5d138ec@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Sathy, Lukas]

On Sat, Aug 26, 2023 at 01:10:35PM +0200, Heiner Kallweit wrote:
> After the referenced commit we may see L1 sub-states being active
> unexpectedly. Following scenario as an example:
> r8169 disables L1 because of known hardware issues on a number of
> systems. Implicitly L1.1 and L1.2 are disabled too.
> On my system L1 and L1.1 work fine, but L1.2 causes missed
> rx packets. Therefore I write 1 to aspm_l1_1.
> This removes ASPM_STATE_L1 from the disabled modes and therefore
> unexpectedly enables also L1.2. So return to the old behavior.
> 
> A comment in the commit message of the referenced change correctly points
> out that this behavior is inconsistent with aspm_attr_store_common().
> So change aspm_attr_store_common() accordingly.

I think we should split this into a pure revert of fb097dcd5a28 with
the description of the unintended consequence, followed by another
patch to change aspm_attr_store_common().

I guess the existing aspm_attr_store_common() behavior allows a
similar unexpected behavior?  For example, in this sequence:

  - Write 0 to "l1_aspm" to disable L1
  - Write 1 to "l1_1_aspm" to enable L1.1

does L1.2 get implicitly enabled as well even though that's clearly
not what the user intended?

There's also the separate question of how the sysfs file and the
pci_disable_link_state() API should interact.  Drivers use that API
when they know about a defect in their device, but the user can
override that via syfs.

In [1], we have a similar situation with D3cold support, where we're
thinking that we should not allow a user to use sysfs to override that
driver knowledge.

Bjorn

[1] https://lore.kernel.org/r/b8a7f4af2b73f6b506ad8ddee59d747cbf834606.1695025365.git.lukas@wunner.de

> Fixes: fb097dcd5a28 ("PCI/ASPM: Disable only ASPM_STATE_L1 when driver disables L1")
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/pci/pcie/aspm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 3dafba0b5..6d3788257 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1063,7 +1063,7 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
>  	if (state & PCIE_LINK_STATE_L0S)
>  		link->aspm_disable |= ASPM_STATE_L0S;
>  	if (state & PCIE_LINK_STATE_L1)
> -		link->aspm_disable |= ASPM_STATE_L1;
> +		link->aspm_disable |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
>  	if (state & PCIE_LINK_STATE_L1_1)
>  		link->aspm_disable |= ASPM_STATE_L1_1;
>  	if (state & PCIE_LINK_STATE_L1_2)
> @@ -1251,6 +1251,8 @@ static ssize_t aspm_attr_store_common(struct device *dev,
>  			link->aspm_disable &= ~ASPM_STATE_L1;
>  	} else {
>  		link->aspm_disable |= state;
> +		if (state & ASPM_STATE_L1)
> +			link->aspm_disable |= ASPM_STATE_L1SS;
>  	}
>  
>  	pcie_config_aspm_link(link, policy_to_aspm_state(link));
> -- 
> 2.42.0
> 
