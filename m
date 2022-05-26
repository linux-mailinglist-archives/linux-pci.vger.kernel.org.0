Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88019535256
	for <lists+linux-pci@lfdr.de>; Thu, 26 May 2022 18:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241505AbiEZQy3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 May 2022 12:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238069AbiEZQy2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 May 2022 12:54:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0026DFC5;
        Thu, 26 May 2022 09:54:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 675EFB82176;
        Thu, 26 May 2022 16:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5603C385A9;
        Thu, 26 May 2022 16:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653584065;
        bh=3G1ExpudxEkUKLGdVnrmwJ/uiFkyw5RF02cjHtBsAW8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RL+NcvCPbWw9Ew0REV/3asS3GSQ91R0RFFIQDTW2/7YiDe7+ndSzzBvAQHsLBzTqH
         8oxv6oGTahVLDIg1gRGspWvSqpyexhEaK0st9HYBNV0Ly52hayPOv4n097H61Jdm45
         w6h6eWXkj6doRHPeNw/Ytirs3yK+1eSfJxt86uL7YBU8qq6fNIKCuLFgbWcQdKqH1N
         HR6vs2B+3KmlHGg+SlKFhafJEXh9XzVrdzrfaUitrnHZy9C17S+4IpBQ0504Vwlr7f
         Gz4MOWPJeylHPSbWa7NOvQEN7BZMi+2cKYYP9u67Z8w22ClK4L/8Fo/cFk7A847mBx
         Q+/W8cOsirSww==
Date:   Thu, 26 May 2022 11:54:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH v1 06/11] PCI/PM: Write 0 to PMCSR in pci_power_up() in
 all cases
Message-ID: <20220526165422.GA338382@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5748066.MhkbZ0Pkbq@kreacher>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 05, 2022 at 08:10:43PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make pci_power_up() write 0 to the device's PCI_PM_CTRL register in
> order to put it into D0 regardless of the power state returned by
> the previous read from that register which should not matter.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/pci/pci.c |   11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> Index: linux-pm/drivers/pci/pci.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci.c
> +++ linux-pm/drivers/pci/pci.c
> @@ -1230,15 +1230,10 @@ int pci_power_up(struct pci_dev *dev)
>  	}
>  
>  	/*
> -	 * If we're (effectively) in D3, force entire word to 0. This doesn't
> -	 * affect PME_Status, disables PME_En, and sets PowerState to 0.
> +	 * Force the entire word to 0. This doesn't affect PME_Status, disables
> +	 * PME_En, and sets PowerState to 0.
>  	 */
> -	if (state == PCI_D3hot)
> -		pmcsr = 0;
> -	else
> -		pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
> -
> -	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr);
> +	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 0);

Can you reassure me why this is safe and useful?

This is a 16-bit write that includes (PCIe r6.0, sec 7.5.2.2):

  0x0003 PowerState     RW
  0x0004                RsvdP
  0x0008 No_Soft_Reset  RO
  0x00f0                RsvdP
  0x0100 PME_En         RW/RWS
  0x1e00 Data_Select    RW, VF ROZ
  0x6000 Data_Scale     RO, VF ROZ
  0x8000 PME_Status     RW1CS

We intend to set PowerState to 0 (D0), apparently intend to clear
PME_En, and PME_Status is "write 1 to clear" to writing 0 does
nothing, so those look OK.

But the RsvdP fields are reserved for future RW bits and should be
preserved, and it looks like clearing Data_Select could potentially
break the Data Register power consumption reporting (which I don't
think we support today).

It seems like maybe we should do this instead:

  pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL,
                        pmcsr & ~PCI_PM_CTRL_STATE_MASK)

to just unconditionally clear PowerState?
