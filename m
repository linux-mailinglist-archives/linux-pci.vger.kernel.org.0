Return-Path: <linux-pci+bounces-37217-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65968BAA1CD
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 19:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7E427A2564
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 17:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479F4303A2F;
	Mon, 29 Sep 2025 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIWQ5XK+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A2EE555;
	Mon, 29 Sep 2025 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759166049; cv=none; b=Nlz4oYpmgMmwgx2Y3kEl49418BSk8XumrFZRA996KBjz5FF1d3XsPe+VU77Wsnafafda2us8KqvTiz7LUbtyDwXvmW4MmPk+ipDyQiHBZvbi4UTRrUQBKltOGGfJot3qjQ4Li6btUoHEH/twqW6MRmVpP0WXizZAIWfOY31kXUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759166049; c=relaxed/simple;
	bh=/d3YDoclVIlotjgBNpaaRR/z5leUIlKIPL2Fbh02IS0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=N9iAR6Yxk8z+qjD1Iwuo33CTslaQ6IQHeltMGYemjWMydppTBa6//yZaD3HywGbmkaoWIITBLxGHstdGx63lEzOqQoHrxIS+e/bl/if/mL3XGRffEQ8mE7Xjx2g6kx41REy1j3YnhaC0th4hv0w7Och9j4oDtFmQWAAM/LTnR5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIWQ5XK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5ABC4CEF4;
	Mon, 29 Sep 2025 17:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759166048;
	bh=/d3YDoclVIlotjgBNpaaRR/z5leUIlKIPL2Fbh02IS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cIWQ5XK+sJVQ4JPDDmMvNFShMRkkjBzGA+dZGLnibe9k69UGY5dB+dbuJppS9xMDV
	 DKQKoCj8NfywFTn+1tu1Z1aYOFLqPLJ2lt6tzBq+A7/IifvxTWse4/+x5UQxemJnZW
	 xi3c3pPcJX5j8zvVJlbuabWOKKN9QsSABeP672iD2FnA50rhfRZxDaxRm3Wzv/mgZ7
	 qGdJKfqpj0CQorjULZk48n2GAUSGN/6jaYzOmzMMB8Q9yFqD/y+goyBvpWY77AY3cs
	 PgNbGKFImlE2juCHY7HckaQZQfhODu/xWVgylrPj3HNLYCGBZgF8ghRALH7nqWkRji
	 FxbwEM3gHJM0Q==
Date: Mon, 29 Sep 2025 12:14:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chris Li <chrisl@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 09/10] PCI/LUO: Avoid write to bus master at boot
Message-ID: <20250929171406.GA116545@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-luo-pci-v2-9-c494053c3c08@kernel.org>

On Tue, Sep 16, 2025 at 12:45:17AM -0700, Chris Li wrote:
> If the liveupdate flag has LU_BUSMASTER or LU_BUSMASTER_BRIDGE, the
> device is participating in the liveupdate preserving bus master bit in the
> PCI config space command register.
> 
> Avoid writing to the PCI command register for the bus master bit during
> boot up.
> 
> Signed-off-by: Chris Li <chrisl@kernel.org>
> ---
>  drivers/pci/liveupdate.c | 6 ++++++
>  drivers/pci/pci.c        | 7 +++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index 1b12fc0649f479c6f45ffb26e6e3754f41054ea8..a09a166b6ee271b96bce763716c3b62b24f3edbb 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -377,6 +377,12 @@ static void pci_dev_do_restore(struct pci_dev *dev, struct pci_dev_ser *s)
>  	pci_info(dev, "liveupdate restore flags %x driver: %s data: [%llx]\n",
>  		 s->flags, s->driver_name, s->driver_data);
>  	list_move_tail(&dev->dev.lu.lu_next, &probe_devices);
> +	if (s->flags & (LU_BUSMASTER | LU_BUSMASTER_BRIDGE)) {
> +		u16 pci_command;
> +
> +		pci_read_config_word(dev, PCI_COMMAND, &pci_command);
> +		WARN_ON(!(pci_command & PCI_COMMAND_MASTER));
> +	}
>  }
>  
>  void pci_liveupdate_restore(struct pci_dev *dev)
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9e42090fb108920995ebe34bd2535a0e23fef7fd..2339ac1bd57616a78d2105ba3a4fc72bbf49973e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2248,7 +2248,8 @@ static void do_pci_disable_device(struct pci_dev *dev)
>  	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
>  	if (pci_command & PCI_COMMAND_MASTER) {
>  		pci_command &= ~PCI_COMMAND_MASTER;
> -		pci_write_config_word(dev, PCI_COMMAND, pci_command);
> +		if (!(dev->dev.lu.flags & (LU_BUSMASTER | LU_BUSMASTER_BRIDGE)))
> +			pci_write_config_word(dev, PCI_COMMAND, pci_command);

I think changing the semantics of interfaces like this is a problem
because callers rely on the existing semantics, and it's hard to
reason about how this change would affect them.  How would you update
the kernel-doc to reflect this change?

do_pci_disable_device() is used in the PM suspend, freeze, and
poweroff paths.  I suppose those paths are allowed even when devices
have been marked with LU_BUSMASTER/LU_BUSMASTER_BRIDGE?  And I assume
you probably would want the existing semantics there?

I.e., if a device has been marked with LU_BUSMASTER, you want to keep
its bus mastering enabled across a liveupdate kexec.  But if we
suspend before doing the kexec, I assume we would still want to clear
bus mastering on suspend and restore bus mastering on resume?

The other path that uses do_pci_disable_device() is
pci_disable_device(), which is primarily used in driver .remove()
methods.  You have to modify drivers to support liveupdate anyway, so
if we call driver .remove() methods during a liveupdate kexec, I think
you should change the .remove() method so it only calls
pci_disable_device() when you want bus mastering disabled.

>  	}
>  
>  	pcibios_disable_device(dev);
> @@ -4276,7 +4277,9 @@ static void __pci_set_master(struct pci_dev *dev, bool enable)
>  	if (cmd != old_cmd) {
>  		pci_dbg(dev, "%s bus mastering\n",
>  			enable ? "enabling" : "disabling");
> -		pci_write_config_word(dev, PCI_COMMAND, cmd);
> +
> +		if (!(dev->dev.lu.flags & (LU_BUSMASTER | LU_BUSMASTER_BRIDGE)))
> +			pci_write_config_word(dev, PCI_COMMAND, cmd);
>  	}
>  	dev->is_busmaster = enable;
>  }
> 
> -- 
> 2.51.0.384.g4c02a37b29-goog
> 

