Return-Path: <linux-pci+bounces-15017-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C64A9AB21A
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 17:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D55171F24165
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 15:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD48114C5A1;
	Tue, 22 Oct 2024 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GR5r2rQG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26311E481;
	Tue, 22 Oct 2024 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729611014; cv=none; b=mP6tMs4vhd6xEHJVLHBZhS5FL3MGUB8R+dqeSmQwxYCLPCuD/OCIMCcuu4lhqizw+lBW7cw9LjNmc25ZfhszjA0s1eVW73JoACdVbwTC+qhN+kwjly6gMzYjc5tb5Xmw31Gj8Fl/sMzD3BJUrErZ1A4LLDi8caM9CdAvw3pfWM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729611014; c=relaxed/simple;
	bh=zceIEQN8I+p0xAl4kzZLSkT/NpJoXIDwU7PTGdQu+3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lTAA710P1cNAl/WG0vdwpFXoROBAv0tv21AuPTbvUBMMDPqtTaO3xyqBgLtu3cimlTF5wB/MzJgfzb/jxbNzU3cE9ujRRFgDn2dFUmDhevZCWPgCxSx1qi7YLLrCvWbZOhyf46YIjjrv7L6II6/0vnEYCt7whXlbL6X90V2mQUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GR5r2rQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B47C4CEC3;
	Tue, 22 Oct 2024 15:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729611014;
	bh=zceIEQN8I+p0xAl4kzZLSkT/NpJoXIDwU7PTGdQu+3Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GR5r2rQGcz3kWRMkhRBxkVDsBowDqL/D3jPXqzTAMrVJY5L8m+87iQJvCGqh/8tiz
	 zprXVzYzbTOCUgr4Lnjr7vIzTaNnU79+4iZJvR68ICFqrVsdM7mGk0W/yhheG4iGTf
	 qAZQbIQ6KW5OMs8kGaKdGHB8AQiVARTAT0Ci2RByYgQXAwLOrbDCGDDj8Uj5Bha+Fe
	 Wha/ofuuAqb/z52yPVuJYnahMKtAutX5dv8jCw1CsHk61b/OFydFougss76XlzFSiy
	 SuvtfP0dObfYAqUkC+dz3eUEwSsTMeschewXTrRn7P56iwkUL8UXHBV1FZ77zhpGd5
	 QWU1zRPEo7e6g==
Date: Tue, 22 Oct 2024 10:30:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 1/2] PCI: Add
 PCI_VDEVICE_SUB helper macro
Message-ID: <20241022153011.GA879691@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021144654.5453-1-piotr.kwapulinski@intel.com>

On Mon, Oct 21, 2024 at 04:46:54PM +0200, Piotr Kwapulinski wrote:
> PCI_VDEVICE_SUB generates the pci_device_id struct layout for
> the specific PCI device/subdevice. Private data may follow the
> output.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

This looks OK to me but needs to be included in a series that uses it.
I looked this message up on lore but can't find the 2/2 patch that
presumably uses it.

If 2/2 uses this,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/linux/pci.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 573b4c4..7d1359e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1050,6 +1050,20 @@ struct pci_driver {
>  	.vendor = PCI_VENDOR_ID_##vend, .device = (dev), \
>  	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID, 0, 0
>  
> +/**
> + * PCI_VDEVICE_SUB - describe a specific PCI device/subdevice in a short form
> + * @vend: the vendor name
> + * @dev: the 16 bit PCI Device ID
> + * @subvend: the 16 bit PCI Subvendor ID
> + * @subdev: the 16 bit PCI Subdevice ID
> + *
> + * Generate the pci_device_id struct layout for the specific PCI
> + * device/subdevice. Private data may follow the output.
> + */
> +#define PCI_VDEVICE_SUB(vend, dev, subvend, subdev) \
> +	.vendor = PCI_VENDOR_ID_##vend, .device = (dev), \
> +	.subvendor = (subvend), .subdevice = (subdev), 0, 0
> +
>  /**
>   * PCI_DEVICE_DATA - macro used to describe a specific PCI device in very short form
>   * @vend: the vendor name (without PCI_VENDOR_ID_ prefix)
> -- 
> 2.43.0
> 

