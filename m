Return-Path: <linux-pci+bounces-20556-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3575A225AA
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 22:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F0893A19AC
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 21:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7001E3DCD;
	Wed, 29 Jan 2025 21:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMN7eKQH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85C51E3DC6
	for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2025 21:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738186154; cv=none; b=q4oZm98my1S/iZBr6pZ9lp8oRmkyj4cbtJQCbQYf0n6reuNdQhPykOeY3ywDmQdc5/yoYXRkE/lFkkj57d2l1L75YZ/Q6ZSFQv5xQjHc9K4puRkzeW2VIyY9c4ywDcrHouEgsW+yRytg+ZmFmBsdHcci8NcBjsEfv2GRGw6GsNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738186154; c=relaxed/simple;
	bh=P+h3+WMMqW1h+Os3rDcyrKh6SzSIMqvFhL3sJMTZ7PM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=V4gWmaGkL3/zS5uQqh3XLRt1vN5oUOszSUjUabHyqibMWHsvyiAlTNzOrvEo1YmyTfQYc25SGK1qAVM4wxpTavUe1CYDV7ZiR/YngaUIOMoRHU+jZc4RlDZhnoYC5m/HAP/xArJ+iG3Ne9OYFUVhOSolOjF/78Ydi+4P3F9J67A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMN7eKQH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F885C4CED1;
	Wed, 29 Jan 2025 21:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738186154;
	bh=P+h3+WMMqW1h+Os3rDcyrKh6SzSIMqvFhL3sJMTZ7PM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bMN7eKQHsezazzvdmU1fXf4NDkIU2cPvpXHEOGCsV1yCug2H2kz02mC4H/hdlrcCV
	 DgHVnBaF/+meWOXHj0AYMUYiwVuXxnlBuX5c8aQ4bWwQjikoCSJMyC9W7sThsnMpoQ
	 lvNrXZkNKlUKeVYwmp6y02DVrPYz2oTdY3l8OCFv2xthTGkCCVtxfqjfKpLYI7iEyc
	 9W1EOEvqxKfsCKJ9YFYMrm/spqKkU7+I2klrE4UcViaZCsCR3jdMO4oOYMuck7RKmV
	 5e4TWv63FUbWfeGwNeE6mI2Pl8rzCsexZmjb0CgMLqo2yU5N+jycoNKUAdSR+wieTC
	 /FB9ZvwkA7RHg==
Date: Wed, 29 Jan 2025 15:29:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Daniel Stodden <dns@arista.com>
Cc: dinghui@sangfor.com.cn, Daniel Stodden <daniel.stodden@gmail.com>,
	bhelgaas@google.com, david.e.box@linux.intel.com,
	kai.heng.feng@canonical.com, linux-pci@vger.kernel.org,
	michael.a.bottini@linux.intel.com, qinzongquan@sangfor.com.cn,
	rajatja@google.com, refactormyself@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, vidyas@nvidia.com
Subject: Re: [PATCH 1/1] PCI/ASPM: fix link state exit during switch upstream
 function removal.
Message-ID: <20250129212912.GA502577@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e12898835f25234561c9d7de4435590d957b85d9.1734924854.git.dns@arista.com>

On Sun, Dec 22, 2024 at 07:39:08PM -0800, Daniel Stodden wrote:
> From: Daniel Stodden <daniel.stodden@gmail.com>
> 
> Before change 456d8aa37d0f "Disable ASPM on MFD function removal to
> avoid use-after-free", we would free the ASPM link only after the last
> function on the bus pertaining to the given link was removed.
> 
> That was too late. If function 0 is removed before sibling function,
> link->downstream would point to free'd memory after.
> 
> After above change, we freed the ASPM parent link state upon any
> function removal on the bus pertaining to a given link.
> 
> That is too early. If the link is to a PCIe switch with MFD on the
> upstream port, then removing functions other than 0 first would free a
> link which still remains parent_link to the remaining downstream
> ports.

Is this specific to a Switch?  It seems like removal of any
multi-function device might trip over this.

> The resulting GPFs are especially frequent during hot-unplug, because
> pciehp removes devices on the link bus in reverse order.

Do you have a sample GPF?  If we can include a few pertinent lines
here it may help people connect a problem with this fix.

> On that switch, function 0 is the virtual P2P bridge to the internal
> bus. Free exactly when function 0 is removed -- before the parent link
> is obsolete, but after all subordinate links are gone.

I agree this is a problem.

IIUC we allocate pcie_link_state when enumerating a device on the
upstream end of a link, i.e., a Root Port or Switch Downstream Port,
but we deallocate it when removing a device on the downstream end of
the link, i.e., an Endpoint or Switch Upstream Port.  This asymmetry
seems kind of prone to error.

Also, struct pcie_link_state contains redundant information, e.g., the
pdev, downstream, parent, and sibling members basically duplicate the
hierarchy already described by the struct pci_bus parent, self, and
devices members.  Redundancy like this is also error prone.

This patch is attractive because it's a very small fix, and maybe we
should use it for that reason.  But I do think we're basically
papering over a pretty serious design defect in ASPM.

I think we'd ultimately be better off if we allocated pcie_link_state
either as a member of struct pci_dev (instead of using a pointer), or
perhaps in pci_setup_device() when we set up the rest of the
bridge-related things and made it live as long as the bridge device.

Actually, if we removed all the redundant pointers in struct
pcie_link_state, it would be smaller than a single pointer, so there'd
be no reason to allocate it dynamically.

Of course this would be a much bigger change to aspm.c.

> Fixes: 456d8aa37d0f ("PCI/ASPM: Disable ASPM on MFD function removal to avoid use-after-free")

Do we have any public problem reports we could mention here?  I'm
actually a little surprised that this hasn't been a bigger problem,
given that 456d8aa37d0f appeared in v6.5 in Aug 2023.  But maybe there
is some unusual topology or hot-unplug involved?

> Signed-off-by: Daniel Stodden <dns@arista.com>
> ---
>  drivers/pci/pcie/aspm.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index e0bc90597dca..8ae7c75b408c 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1273,16 +1273,16 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
>  	parent_link = link->parent;
>  
>  	/*
> -	 * link->downstream is a pointer to the pci_dev of function 0.  If
> -	 * we remove that function, the pci_dev is about to be deallocated,
> -	 * so we can't use link->downstream again.  Free the link state to
> -	 * avoid this.
> +	 * Free the parent link state, no later than function 0 (i.e.
> +	 * link->downstream) being removed.
>  	 *
> -	 * If we're removing a non-0 function, it's possible we could
> -	 * retain the link state, but PCIe r6.0, sec 7.5.3.7, recommends
> -	 * programming the same ASPM Control value for all functions of
> -	 * multi-function devices, so disable ASPM for all of them.
> +	 * Do not free free the link state any earlier. If function 0
> +	 * is a switch upstream port, this link state is parent_link
> +	 * to all subordinate ones.
>  	 */
> +	if (pdev != link->downstream)
> +		goto out;
> +
>  	pcie_config_aspm_link(link, 0);
>  	list_del(&link->sibling);
>  	free_link_state(link);
> @@ -1293,6 +1293,7 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
>  		pcie_config_aspm_path(parent_link);
>  	}
>  
> + out:
>  	mutex_unlock(&aspm_lock);
>  	up_read(&pci_bus_sem);
>  }
> -- 
> 2.47.0
> 

