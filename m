Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35003508B1
	for <lists+linux-pci@lfdr.de>; Wed, 31 Mar 2021 23:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhCaVBP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Mar 2021 17:01:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhCaVAr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 31 Mar 2021 17:00:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 659F86101D;
        Wed, 31 Mar 2021 21:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617224446;
        bh=jwo0lYrOcLekMANRh66UNDJoD6tIlqIOovtZxHmKaOk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NMRqM6HJD8CjG0s15N0tx/0dwEsvETtFrBXkL3pYKAI2POBUob//ZMMavgVdDVYUH
         WYu5F8ivbmPt1bRP3Cxx3TQpWmhUVKCB4TPstfAFlNgrH8N6ZUAMnrj2x3twjsJraS
         Bc0Ow+wPRV0WJrWqkcp7T6WxAcGxpaX2glVG1aYM7asd8USuGnTc9/0TeSvYMeIpLB
         qoPnCzRk+qUuvc987Vl7FL5/dmaKPeohcetfLAhleiDsfFYmKfcdHUXf/bwU79puBG
         xIHEenvMch77vKyWn5Gil9ss9Yf18NNcdbwqDWypFZu+6drPpwb+Rijtif3j9Q0xzr
         uUbcjOw9aHpDw==
Date:   Wed, 31 Mar 2021 16:00:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Don't try to read CLS from PCIe devices in
 pci_apply_final_quirks
Message-ID: <20210331210044.GA1421276@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5b1456c-d5ff-d1d1-ba95-b9a12eda8ae7@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 08, 2020 at 02:26:46PM +0100, Heiner Kallweit wrote:
> Don't try to read CLS from PCIe devices in pci_apply_final_quirks().
> This value has no meaning for PCIe.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/pci/quirks.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index d9cbe69b8..ac8ce9118 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -163,6 +163,9 @@ static int __init pci_apply_final_quirks(void)
>  	pci_apply_fixup_final_quirks = true;
>  	for_each_pci_dev(dev) {
>  		pci_fixup_device(pci_fixup_final, dev);
> +
> +		if (pci_is_pcie(dev))
> +			continue;

This loop tries to deduce the platform's cache line size by looking at
the CLS of every PCI device.  It doesn't *write* CLS for any devices.

IIUC skipping PCIe devices would only make a difference if a PCIe
device had a non-zero CLS different from the CLS of other devices.
In that case we would print a "CLS mismatch" message and fall back to
pci_dfl_cache_line_size.

The power-up value is zero, so if we read a non-zero CLS, it means
firmware set it to something.  It would be strange if firmware set it
to something other than the platform's cache line size.

Skipping PCIe devices probably doesn't hurt anything, but I don't
really see a benefit either.  What do you think?  In general I think
we should add code to check PCI vs PCIe only if it makes a difference.

>  		/*
>  		 * If arch hasn't set it explicitly yet, use the CLS
>  		 * value shared by all PCI devices.  If there's a
> -- 
> 2.29.2
> 
