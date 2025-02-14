Return-Path: <linux-pci+bounces-21492-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC4EA3647E
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 18:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3FD0188158E
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8048D267F75;
	Fri, 14 Feb 2025 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+kvZXJU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58982267AE8;
	Fri, 14 Feb 2025 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553808; cv=none; b=lp5ZDio7+7jrYZEt5oi/3AdtYhUSVHc/Pxsn+acrB/CNOT3KrrsUIbYKgKwr1RvcAAwQ95UKXt2Csh0c27rjYBIz9ONKr/AMf4GVqZV6WCh4f8a9bTMLTuTfZ2+Twz9Cwe18uXkp73PWjYA6Dip6JmxdFmwS7zvEDDc/SG3ELKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553808; c=relaxed/simple;
	bh=qDkUNhX/Rn7fSQraeHpJ9SA2nMmPahHqFq1sQwcBXTk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=E5CftY6K8WWV5oKvympy+Xzz2H/dsPh8qxXyrfrBOm5LPTOElH3SdFiixB5bX+nki/rnAvuTqPiveO5xR7EWFdPyuA6zbdawGV9ijGndsEkEYyB8/LNGI5sY0xwrv9c5UJNmvXTqD5JiHrXTsYESAncK4rYT73als19igOxI6cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+kvZXJU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB6FC4CED1;
	Fri, 14 Feb 2025 17:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739553807;
	bh=qDkUNhX/Rn7fSQraeHpJ9SA2nMmPahHqFq1sQwcBXTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=f+kvZXJU39TAI1G6q3q4TIghG3mediJi+TNmQ+V6MPa0XU7A19FUva1045Sx2gJdu
	 3ysOMAKfY0kg98jzVMKdXjSPLOYTxMc+HdzgrnMpgD7Gq+N0oyMKxuG9wNEE4csgrm
	 vnwNIXdEwJdz1wv76Fa7ZCHFJwfBOE6pwEHAvk/beGLCE929yRoQEU5cmyvdZT0i1a
	 c54/+5LiyBHiy3GJe8j87PmUWian2LgV+cTxS0xE7KEb1tQt3EYO4Qxh01MaGrVHlt
	 lA5MoE6g55YnHcDpSyPCGbhnujzC8duljAgTtrIGskZZ0gh5eatg9eWYzPF8qjenBT
	 WCM0xw9WDHn0w==
Date: Fri, 14 Feb 2025 11:23:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Roger Pau Monne <roger.pau@citrix.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-pci@vger.kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 2/3] vmd: disable MSI remapping bypass under Xen
Message-ID: <20250214172324.GA157438@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250114103315.51328-3-roger.pau@citrix.com>

The subject line convention for this file is:

  PCI: vmd: Disable MSI remapping ...

On Tue, Jan 14, 2025 at 11:33:12AM +0100, Roger Pau Monne wrote:
> MSI remapping bypass (directly configuring MSI entries for devices on the
> VMD bus) won't work under Xen, as Xen is not aware of devices in such bus,
> and hence cannot configure the entries using the pIRQ interface in the PV
> case, and in the PVH case traps won't be setup for MSI entries for such
> devices.
> 
> Until Xen is aware of devices in the VMD bus prevent the
> VMD_FEAT_CAN_BYPASS_MSI_REMAP capability from being used when running as
> any kind of Xen guest.
> 
> The MSI remapping bypass is an optional feature of VMD bridges, and hence
> when running under Xen it will be masked and devices will be forced to
> redirect its interrupts from the VMD bridge.  That mode of operation must
> always be supported by VMD bridges and works when Xen is not aware of
> devices behind the VMD bridge.
> 
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> ---
> Changes since v1:
>  - Add xen header.
>  - Expand comment.
> ---
>  drivers/pci/controller/vmd.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 264a180403a0..33c9514bd926 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -17,6 +17,8 @@
>  #include <linux/rculist.h>
>  #include <linux/rcupdate.h>
>  
> +#include <xen/xen.h>
> +
>  #include <asm/irqdomain.h>
>  
>  #define VMD_CFGBAR	0
> @@ -965,6 +967,23 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	struct vmd_dev *vmd;
>  	int err;
>  
> +	if (xen_domain())
> +		/*
> +		 * Xen doesn't have knowledge about devices in the VMD bus
> +		 * because the config space of devices behind the VMD bridge is
> +		 * not known to Xen, and hence Xen cannot discover or configure
> +		 * them in any way.
> +		 *
> +		 * Bypass of MSI remapping won't work in that case as direct
> +		 * write by Linux to the MSI entries won't result in functional
> +		 * interrupts, as it's Xen the entity that manages the host

"... as Xen is the entity that ..." ?

> +		 * interrupt controller and must configure interrupts.
> +		 * However multiplexing of interrupts by the VMD bridge will
> +		 * work under Xen, so force the usage of that mode which must
> +		 * always be supported by VMD bridges.
> +		 */
> +		features &= ~VMD_FEAT_CAN_BYPASS_MSI_REMAP;

Since the comment is so long, I would add braces even though it's only
a single statement.  Or maybe moving the comment above the "if" would
make more sense.

>  	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
>  		return -ENOMEM;
>  
> -- 
> 2.46.0
> 

