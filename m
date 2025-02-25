Return-Path: <linux-pci+bounces-22374-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D208A448DF
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 18:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F0F8188600F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 17:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC8619882F;
	Tue, 25 Feb 2025 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBu8XFIc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AE818E34A;
	Tue, 25 Feb 2025 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740505846; cv=none; b=KIYgvyUjA6S9Leu5/nsarZhpi7Fo0lnYRGXhPBXT3/W3mzrCt8l18MLndUib87B2ySsYDWei6NzRlThZJtJrpt3TTBvExSyElmic88hqo1zLwUT75/vYJy/b7HAd9POj14FuO1+USdiICuZ+0v4u88ABwu8GNxRqBHi71VL2hhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740505846; c=relaxed/simple;
	bh=O7jDYX7iRfrB1UVmAe+E/vNwrykYgFudqrrJuLaSk8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gJpw9DOis9q8HV4pdNJeEOjyov2qZU0Hy6+whGLXBPfq9x0Uua5WutyTRnuRj3HlkWAgsTeFZPK0K5Na4SxqUgqsquA4CVulCSHEoJsGbBVINvW+8nFK9rdbtCjTDN8ZT84xLbUVV4ZJ25w8TVqgHCaMrTtlsmxd6C+7wkssKqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBu8XFIc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE98C4CEDD;
	Tue, 25 Feb 2025 17:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740505846;
	bh=O7jDYX7iRfrB1UVmAe+E/vNwrykYgFudqrrJuLaSk8Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fBu8XFIcBwXzPCuLucy0C2svFoYEU7W3Qe5lu2eqGEffvvnNv0C0iCPp8VORRutU3
	 5uyHQFGoNTYDjQkY4fY31ezuZEtnFIihih/DII6i2X52enZ7LkErjBNUKOpLMy8u7p
	 BBNv7jZ5EEcnVdWHgvufYa0XyFu+HBSQxbPrGkqH7boD0AFZOtAi4aty6G02iNg0fv
	 WNnftdTe3QrC/vx7KxIjB5UaGeorD5QutGt+yqSlrfYUQHZueIRyA8p+KBtjzxix9T
	 WvBbJVXxSJS7G2onhV18w40avekUuD0Z1KNoWMH9wx8OakVnqoHyk2c4SVpzeNV7Ye
	 CMl9laZL1JrSQ==
Date: Tue, 25 Feb 2025 11:50:44 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frediano Ziglio <frediano.ziglio@cloud.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] xen: Add support for XenServer 6.1 platform device
Message-ID: <20250225175044.GA511149@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225140400.23992-1-frediano.ziglio@cloud.com>

On Tue, Feb 25, 2025 at 02:03:53PM +0000, Frediano Ziglio wrote:
> On XenServer on Windows machine a platform device with ID 2 instead of
> 1 is used.
> This device is mainly identical to device 1 but due to some Windows
> update behaviour it was decided to use a device with a different ID.
> This causes compatibility issues with Linux which expects, if Xen
> is detected, to find a Xen platform device (5853:0001) otherwise code
> will crash due to some missing initialization (specifically grant
> tables).
> The device 2 is presented by Xapi adding device specification to
> Qemu command line.

Add blank lines between paragraphs.

A crash seems unfortunate.  And it sounds like a user mistake, e.g., a
typo in the Qemu device specification, could also cause a crash?

If the crash is distinctive, a hint here like a dmesg line or two
might help users.

> Signed-off-by: Frediano Ziglio <frediano.ziglio@cloud.com>
> ---
>  drivers/xen/platform-pci.c | 2 ++
>  include/linux/pci_ids.h    | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/xen/platform-pci.c b/drivers/xen/platform-pci.c
> index 544d3f9010b9..9cefc7d6bcba 100644
> --- a/drivers/xen/platform-pci.c
> +++ b/drivers/xen/platform-pci.c
> @@ -174,6 +174,8 @@ static int platform_pci_probe(struct pci_dev *pdev,
>  static const struct pci_device_id platform_pci_tbl[] = {
>  	{PCI_VENDOR_ID_XEN, PCI_DEVICE_ID_XEN_PLATFORM,
>  		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
> +	{PCI_VENDOR_ID_XEN, PCI_DEVICE_ID_XEN_PLATFORM_XS61,
> +		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
>  	{0,}
>  };
>  
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 1a2594a38199..e4791fd97ee0 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -3241,6 +3241,7 @@
>  
>  #define PCI_VENDOR_ID_XEN		0x5853
>  #define PCI_DEVICE_ID_XEN_PLATFORM	0x0001
> +#define PCI_DEVICE_ID_XEN_PLATFORM_XS61	0x0002

If this is the only place PCI_DEVICE_ID_XEN_PLATFORM_XS61 is used, we
would put this in platform-pci.c, per the pci_ids.h comment:

 *      Do not add new entries to this file unless the definitions
 *      are shared between multiple drivers.

>  #define PCI_VENDOR_ID_OCZ		0x1b85
>  
> -- 
> 2.48.1
> 

