Return-Path: <linux-pci+bounces-4629-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDCC875A56
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 23:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A149A1F22AD3
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 22:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864E93309C;
	Thu,  7 Mar 2024 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLQs7YzG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6213E1E86E
	for <linux-pci@vger.kernel.org>; Thu,  7 Mar 2024 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709850968; cv=none; b=nRXlSVLxq5x5pw775yvB0R/+2YjEFeVRCdpCwKrzNUFBL8PGUrOsoVdjI5m+nYPxm7G9zUY30tp3S/swNPPf4U0nUIzSdrlCIeWINcm59w1CeL7115GKUfS5YkbO1RVpdhc6fyKSl3AW9Aq07LbEMCLMDVJSw8PZewQWyfXFNvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709850968; c=relaxed/simple;
	bh=8UvGOKqhQdFPexuRHbg+fjBKuw2ZvcBL5hJ+fKLjdEY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MqCf1zB7SlJ1Y8xSD3mrhVZJeTZj7usnIkfhhAJjxLDZDGAyIUY4LDgFDwoL+Vel97PnyZwXb+7YwHr7pXYXAqZPbGOr1bkmTzT3JL1egjfHR7VUDoZ9cOOeEBHSoX27Imhdl+qhm9NIoCVKF5m5vENoqsGOhBlbED7WYirm17I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLQs7YzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8E9C433C7;
	Thu,  7 Mar 2024 22:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709850967;
	bh=8UvGOKqhQdFPexuRHbg+fjBKuw2ZvcBL5hJ+fKLjdEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kLQs7YzGhp1cRuQIwLz43bt/dlzVbT8GtDC7hcNQyBdNO+ZYT7QMqheEF2eGgHVWU
	 wD36InsL8omImpJW7/VScrGS/X86eYaWRJuPUK/yQR8jf9Lrrvzx6BqLcQRWdbPm4Z
	 8gN3QvIy9rk9O0d0RyQQLfAJdTHRcgFdpH5pwKwuJqhnirC6UbghoNgIPRgw1EoHH5
	 vPrqFSW49WZ/7zYauNb4BbBHdFcMCFPCOoGCVruMQNNZq3GZRiMBr/wetizNfF5uIt
	 1HLkKwQmd9fR00iITvWj07cw4+PKMv75p3/gHtYhuLvyPtRii6Q3u3IHRTOPUD9QOP
	 6pvOpHaaHyP/Q==
Date: Thu, 7 Mar 2024 16:36:06 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Josselin Mouette <josselin.mouette@exaion.com>
Cc: linux-pci@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/2] Revert "PCI/VPD: Allow access to valid parts of VPD
 if some is invalid"
Message-ID: <20240307223606.GA658427@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0132edfec66a6bd413823d43ccdf1c4d6aae2b60.camel@exaion.com>

[+cc Hannes, who did a lot of related VPD work and reviewed the
original posting at
https://lore.kernel.org/r/20210715215959.2014576-6-helgaas@kernel.org/]

On Thu, Mar 07, 2024 at 05:09:27PM +0100, Josselin Mouette wrote:
> When a device returns invalid VPD data, it can be misused by other
> code paths in kernel space or user space, and there are instances
> in which this seems to cause memory corruption.

More of the background from Josselin at
https://lore.kernel.org/r/aaea0b30c35bb73b947727e4b3ec354d6b5c399c.camel@exaion.com

This is a regression, and obviously needs to be fixed somehow, but I'm
a bit hesitant to revert this until we understand the problem better.
If there's a memory corruption lurking and a revert hides the
corruption so we never fix it, I'm not sure that's an improvement
overall.

> There is no sensible reason why the kernel would provide userspace
> or drivers with invalid and potentially dangerous data.
> 
> This reverts commit 5fe204eab174fd474227f23fd47faee4e7a6c000.
> ---
>  drivers/pci/vpd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index 485a642b9304..daaa208c9d9c 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -68,7 +68,7 @@ static size_t pci_vpd_size(struct pci_dev *dev)
>                         if (pci_read_vpd_any(dev, off + 1, 2,
> &header[1]) != 2) {
>                                 pci_warn(dev, "failed VPD read at
> offset %zu\n",
>                                          off + 1);
> -                               return off ?: PCI_VPD_SZ_INVALID;
> +                               return PCI_VPD_SZ_INVALID;
>                         }
>                         size = pci_vpd_lrdt_size(header);
>                         if (off + size > PCI_VPD_MAX_SIZE)
> @@ -87,13 +87,13 @@ static size_t pci_vpd_size(struct pci_dev *dev)
>                                 return off;
>                 }
>         }
> -       return off;
> +       return PCI_VPD_SZ_INVALID;
>  
>  error:
>         pci_info(dev, "invalid VPD tag %#04x (size %zu) at offset
> %zu%s\n",
>                  header[0], size, off, off == 0 ?
>                  "; assume missing optional EEPROM" : "");
> -       return off ?: PCI_VPD_SZ_INVALID;
> +       return PCI_VPD_SZ_INVALID;
>  }
>  
>  static bool pci_vpd_available(struct pci_dev *dev, bool check_size)
> -- 
> 2.39.2
> 

