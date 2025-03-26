Return-Path: <linux-pci+bounces-24785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EC2A71C87
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 17:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7AF1646D5
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 16:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2221F4E25;
	Wed, 26 Mar 2025 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJmHmHqV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BD11F95C;
	Wed, 26 Mar 2025 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743008250; cv=none; b=eZi+gCL8AwtV5h7z1B+2SGznPNv42dYPEW7+Wv0r+tqCBubSx+tTE5NQ+FcLabefaGZ9VYqSERapdMe54o/Ao+dhDsEq/O/hpEUb+qNxFMwu5CphvcCzrVQB6x5swZVy3GJrNjGBZqpvpvnBrWRuWugvn/I5ekmrYe3tHw26YrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743008250; c=relaxed/simple;
	bh=doUGU7qVE0nBslUip4rBHGXcaNRqYNLVIEXEA4QLHQA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tedSUquQGt/fWLzJ5dHxesXQPNjseXa3O6h1Hniu5qafCepZUvj0zttb/VCtrp4wMQGDRXFwy/GB8It+PpgHlKMy4Mqp2MTQGuSXYdwf0y8yF6h/YulNoCVNxWJDffuw9RIPcaFjy1+y7FCERPj0LkWuQLZco76wT41ogi2rzwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJmHmHqV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE67C4CEE2;
	Wed, 26 Mar 2025 16:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743008249;
	bh=doUGU7qVE0nBslUip4rBHGXcaNRqYNLVIEXEA4QLHQA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UJmHmHqVI3uYPPPWwZz7PXpzmD9dQ/ucfsM7V7xxc5q13C8Rwio5uuH4TjbFn8O2M
	 G4Z2l0eXdzlB5lfeG+bNdnWMgXiMC7Odzgy2vYwgjRtJ6W7hH0NWJQ18YFdPsq46yj
	 WbWr4eusBPxPD6uHupuMQDorBHriEtOuHZV0AOPPeAXGdoi20pHFI8qmdsv+MXy8MA
	 MfbRdz+dCsni9WuPBZtxDHgsmPfVueqlUKrPKficvchGgIhZ2OqTug4P/h4Xn9jxwz
	 hu520cCH7UoblQQeZ1dmNORLokqOLHmBjl+5gVTs5apTbK7vt8a0O6x24SL4Y7cwkZ
	 nsqwOY0X9SrUQ==
Date: Wed, 26 Mar 2025 11:57:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yibo Dong <dong100@mucse.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add MUCSE vendor ID to pci_ids.h
Message-ID: <20250326165728.GA1339144@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325065718.333301-1-dong100@mucse.com>

On Tue, Mar 25, 2025 at 02:57:18PM +0800, Yibo Dong wrote:
> Add MUCSE as a vendor ID (0x8848) for PCI devices so we can use
> the macro for future drivers.
> 
> Signed-off-by: Yibo Dong <dong100@mucse.com>

Please post this in the series where you add the future drivers.

We don't add new things to pci_ids.h unless they are actually used by
more than one driver because it complicates life for people who
backport things (there's a note at the top of the file about this).

> ---
>  include/linux/pci_ids.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index de5deb1a0118..f1b4c61c6d3c 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -3143,6 +3143,8 @@
>  #define PCI_VENDOR_ID_SCALEMP		0x8686
>  #define PCI_DEVICE_ID_SCALEMP_VSMP_CTL	0x1010
>  
> +#define PCI_VENDOR_ID_MUCSE		0x8848

https://pcisig.com/membership/member-companies?combine=8848 says this
Vendor ID belongs to:

  Wuxi Micro Innovation Integrated Circuit Design Co.,Ltd

I suppose "MUCSE" connects with that somehow.

It's nice if people can connect PCI_VENDOR_ID_MUCSE with a name used
in marketing the product.  Maybe "MUCSE" is the name under which
Wuxi Micro Innovation Integrated Circuit Design Co.,Ltd markets
products?

>  #define PCI_VENDOR_ID_COMPUTONE		0x8e0e
>  #define PCI_DEVICE_ID_COMPUTONE_PG	0x0302
>  #define PCI_SUBVENDOR_ID_COMPUTONE	0x8e0e
> -- 
> 2.25.1
> 

