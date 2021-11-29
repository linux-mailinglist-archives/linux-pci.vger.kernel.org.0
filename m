Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDFB46248F
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 23:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbhK2WVM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 17:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbhK2WTp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 17:19:45 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D8BC07CA0E
        for <linux-pci@vger.kernel.org>; Mon, 29 Nov 2021 11:53:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6231DCE13D3
        for <linux-pci@vger.kernel.org>; Mon, 29 Nov 2021 19:53:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496A8C53FAD;
        Mon, 29 Nov 2021 19:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638215584;
        bh=n47dNt59W6WpMo8TT6WALBm96tMUEZDnXE0HKS2FnS8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JMCFC1/UBqhD5ulVOfnc2t8wCKz4oP2i32PSFrnQatAFVBHduOSMp1jKblbFHbImL
         /sEbFN+WcuuYHw2NVSoTJyJcIU6pbtztmmv/5ni15AqNp05cQsl7RNcJIUPNaCqQT6
         fLoCsIZk8AvId1VYo5hhrBLSFtKuXfsPcqHp/PdF7dPDti6vYpKF3Ex+8O8Cj4Q2YO
         FEaG7QOfk+pOk6MMFx24TvaEZ71Ei8bXqBw0eRI8QG7aMweuZs2p6YDT005Spkv/A+
         SQYzywsPLz53xynBnPtKTW/gqQAGzB0Iw44rh4GWyisjmFAwA0g/qG843Uql6F4bo5
         N7dm+P3aH2stg==
Date:   Mon, 29 Nov 2021 13:53:02 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     francisco.munoz.ruiz@linux.intel.com
Cc:     linux-pci@vger.kernel.org, jonathan.derrick@intel.com,
        dan.j.williams@intel.com, nirmal.patel@linux.intel.com,
        Karthik L Gopalakrishnan <karthik.l.gopalakrishnan@intel.com>
Subject: Re: [PATCH] PCI: vmd: Add device id for VMD device 8086:A77F
Message-ID: <20211129195302.GA2686292@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129190232.24375-1-francisco.munoz.ruiz@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 29, 2021 at 11:02:32AM -0800, francisco.munoz.ruiz@linux.intel.com wrote:
> From: Karthik L Gopalakrishnan <karthik.l.gopalakrishnan@intel.com>
> 
> Add support for this VMD device which supports the bus rectriction mode.
> The feature that turns off vector 0 for MSI-X remapping is also enabled.

s/rectriction/restriction/

Is there any product name or code name you could put something in the
subject line to connect this to the hardware?

Maybe you could also add the relevant details to the PCI ID database
here?  https://pci-ids.ucw.cz/read/PC/8086  This will help lspci show
the correct name.

> Signed-off-by: Karthik L Gopalakrishnan <karthik.l.gopalakrishnan@intel.com>
> Signed-off-by: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
> ---
>  drivers/pci/controller/vmd.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index a45e8e59d3d4..0e6ca6cae2c7 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -953,6 +953,10 @@ static const struct pci_device_id vmd_ids[] = {
>  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
>  				VMD_FEAT_HAS_BUS_RESTRICTIONS |
>  				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xa77f),
> +		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> +				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> +				VMD_FEAT_OFFSET_FIRST_VECTOR,},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
>  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
>  				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> -- 
> 2.25.1
> 
