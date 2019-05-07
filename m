Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F22D716B8C
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2019 21:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfEGTkp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 May 2019 15:40:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbfEGTkp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 May 2019 15:40:45 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75E5620578;
        Tue,  7 May 2019 19:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557258044;
        bh=q4p8BSBd7boB2NNiicg9dMmmMuiglR8h4wTorhca6oI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oU2zu9f6uOqjoXgFnMjBRGcqHDid1yHNQsDHfbzP9LQXyc0C2yZKc6d2fryqlXs09
         K5qKCEPtYtOfCS0IQikDrSqFoydscmazV0wMPLgz8cm1Dgvn1lbHRRjeN/nfNLKRx4
         pbNzzq/S3BYN5uYpbsjlwEvKlNrN9ShGQmSnWtYY=
Date:   Tue, 7 May 2019 14:40:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Oliver O'Halloran <oohall@gmail.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Add a comment for the is_physfn field
Message-ID: <20190507194037.GE156478@google.com>
References: <20190410074455.26964-1-oohall@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410074455.26964-1-oohall@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Oliver,

On Wed, Apr 10, 2019 at 05:44:55PM +1000, Oliver O'Halloran wrote:
> The meaning of is_physfn and how it's different to is_virtfn really
> isn't clear unless you do a bit of digging. Add a comment to help out
> the unaware.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---
>  include/linux/pci.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 77448215ef5b..88bf71bfa757 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -393,6 +393,10 @@ struct pci_dev {
>  	unsigned int	is_managed:1;
>  	unsigned int	needs_freset:1;		/* Requires fundamental reset */
>  	unsigned int	state_saved:1;
> +	/*
> +	 * is_physfn indicates that the function can be used to host VFs.
> +	 * It is only set when both the kernel and the device support IOV.
> +	 */

The comment is certainly accurate, no question there, but it sounds
like the reason for adding it is because you stumbled over something
in the confusing SR-IOV/PF/VF infrastructure.  If we can, I'd really
like to improve that infrastructure so it's less confusing in the
first place.

It seems like part of the problem is that "is_physfn" is telling us
more than one thing: "CONFIG_PCI_IOV=y" and "pdev has an SR-IOV
capability" and "pdev is a PF".

Many of the uses of "is_physfn" are in powerpc code that tests
"!pdev->is_physfn", and the negation of those multiple things makes it
a little confusing to figure out what the real purpose it.

Maybe we should cache the PCI_EXT_CAP_ID_SRIOV location in the
pci_dev.  That would simplify some drivers slightly, and if we had
"pdev->sriov_cap" and "pdev->is_virtfn", I think we could drop
"is_physfn".  But I don't understand the powerpc uses well enough to
know whether that would make things easier or harder.

>  	unsigned int	is_physfn:1;
>  	unsigned int	is_virtfn:1;
>  	unsigned int	reset_fn:1;
> -- 
> 2.20.1
> 
