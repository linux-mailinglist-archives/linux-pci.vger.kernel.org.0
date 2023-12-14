Return-Path: <linux-pci+bounces-1016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC45813B82
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 21:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE782813E5
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 20:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EBC6A03C;
	Thu, 14 Dec 2023 20:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N33HgyIL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91133399F;
	Thu, 14 Dec 2023 20:28:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A21C433C9;
	Thu, 14 Dec 2023 20:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702585738;
	bh=OaiTbbrvZXCtjfNH5fz9wg1DzywuRnjlIJFtRbNr8AU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=N33HgyILK6ugvQdbWmmacvvP0QbZZPodEK4aqwKSO++CMA2t9be3pHegxU27A/3P8
	 ME0JcW1ZCX/lVM7T/WILas734s5Ql/DmCWO0Z7NdlR28npx5SqYtKSVNMLcM12JDVL
	 gpBwUyAHb8OVeQtrNIqLjySek5k7p1kdDXRUwUDCVB+8CdS6WaxJMkcm9DX5AY9ZYv
	 3qZWRBVt/BQ3GotHU7Pf53CHfCyWHmVGquNQsvDnh5sMfou5PeRmcPD9CZe00n0rJ3
	 xaNHK3WveWjraWXLvuNZpoB+uZyeB9vepWDB21Fio53sLvm6wdF1TOfnmeES87ooa6
	 FS3B2T9nGzMxw==
Date: Thu, 14 Dec 2023 14:28:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Matthew W Carlis <mattc@purestorage.com>
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, mika.westerberg@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v3] PCI/portdrv: Allow AER service only for Root Ports &
 RCECs
Message-ID: <20231214202856.GA1101963@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214063717.992-1-mattc@purestorage.com>

On Wed, Dec 13, 2023 at 11:37:17PM -0700, Matthew W Carlis wrote:
> Hello Any Interested
> 
> Recently found that this patch had the affect of requiring us to set
> pcie_ports_dpc_native in order to use the kernel DPC driver with PCIe switch
> downstream ports. The kernel check for the DPC capability in portdrv.c has;
> if pci_aer_available() and (dpc-native or using AER port service driver on
> the device). I wonder if we couldn't do away with the requirement of the
> AER service being used on the port if pci_aer_available() & host->native_aer
> don't lie. I'm still trying to decide exactly what the condition ought to
> look like, but it might draw from the AER service check above it. For example:
> 
>         if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
> -           pci_aer_available() &&
> -           (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
> +           dev->aer_cap && pci_aer_available() &&
> +           (pcie_ports_dpc_native || host->native_aer))
>                 services |= PCIE_PORT_SERVICE_DPC;

This sounds like it might be a regression report for d8d2b65a940b
("PCI/portdrv: Allow AER service only for Root Ports & RCECs"), which
appeared in v6.2.  Is that true?

If d8d2b65a940b requires you to use the "pcie_ports=dpc-native" kernel
parameter when you didn't need it before, that sounds like a
regression.

Looking at the code, that "services & PCIE_PORT_SERVICE_AER"
definitely looks like a problem.  We added that with 
https://git.kernel.org/linus/4e5fad429bd1 ("PCI/DPC: Do not enable DPC
if AER control is not allowed by the BIOS"), but I think your
suggestion of checking host->native_aer is better.

Do you want to post a formal patch for it?

Bjorn

