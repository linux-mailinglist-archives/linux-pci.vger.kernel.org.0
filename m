Return-Path: <linux-pci+bounces-24009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1FAA66A60
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 07:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A723A516F
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 06:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA96C1DDC30;
	Tue, 18 Mar 2025 06:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nSDn/H02"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309DF1714B2
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 06:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742279285; cv=none; b=d44r/MczAzis51b4YznHy/brfV+yycxXt4pLM4cSiUut6Yn7mfDwSzd3Q3iAya/ZW9UteUp7YZxFntOKjlagEZUTnv1N9/iXwrmcxb3GU3aPFj+V3JwCSFL9YLNHvjERl+Q5NqeE+NLqGzittdxx2LTXL0CWUa5pxWjy6AL5Zsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742279285; c=relaxed/simple;
	bh=BKMVTQqz3RsMwgJiObS9tQZ/rouwlRUpINy4oDngqVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDqyPe8rrJ6QzuUXO9b9UQYWP+3MmKUKL71OGpY49T47681MoFIjylOmndbxZ5PWOLt3EH4PGIomDzLzmMSgyIDLS3ky19LkS3+uYlFCMBFavY/IErix7z0zo38+RPZb92hwFTbIgA++KrODcIOOCU4sTb2JKX/0GGL1KZ5pAIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nSDn/H02; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-224341bbc1dso96714885ad.3
        for <linux-pci@vger.kernel.org>; Mon, 17 Mar 2025 23:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742279283; x=1742884083; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BSXIkkDh3qUjQU6JXyu8jEZBeTmc92jcPbpiryIBFW0=;
        b=nSDn/H02NITiW5l+fuBdoG/uvKANZCal+SirTwmTYjtHkNiuhBi0vQf9BUEwfsTc+P
         Lpt6Qbty3m5Bz+BxNTBOO59WirgLrAvvtKBunJlDszh0RB/YQGEKq5e432dHGdmld+pw
         gLLdcjui1NvfKARuaQGDm5VCI2/RfYVuizEVfmrhgM2v45s6L0IK6DR3Y0nLik3c3oZ0
         kbXso3d6XgXc3gsgKaCyaJNKnuoe/Ian1vfIY0Cy+BSaAul1fR8iJVKVvZ0RCbEimXtg
         esTANh97A+yVY34M8EzkVkE+RBt5rKtmilIjFcM5y2lkERsloJT9om+vgV3O9VUbGPKb
         BPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742279283; x=1742884083;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BSXIkkDh3qUjQU6JXyu8jEZBeTmc92jcPbpiryIBFW0=;
        b=dPW2S0U0NUVaaq9GWencJszMtLuEdB1WxjH9MXe68HwGi6tYH6bL+bwV2KpIVoi2nK
         6gRDzgfUeIgiHX4l4VBVSSlCdlMzmbO/ZZtg8g+0QKQAVrt9RP2d+tLbMjiH/2iENf67
         3AfVms+DGRVTeDqGF0PH+w4EJzWa36DlP4tCfEAA4gmiWi/SUcSrdbBigRSz7ILZlzV5
         q2dnztBefocL8f/t43385rWYcza5eIkMLHJcxu3ZSiecQHFdSt+zqV+E9JzBGJ162InZ
         5T1gYSJFarpqcge+oJp/n10Oh1fa1BhhYISkl85ohEQ9ruO9mdVNeJXwBxdRGpIdp8xt
         LKYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx27JvY9B2S0kYt6PSf3S/dXIG7GaTKbbjsB+pfV9eiRF4e+byngFp9PIp6pCscI2lWixZV0ak440=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0TsODi/47tR/u0GVDmBDEPQWO+lB/g2wE+GFxqvzLJ2qtGN5u
	/2aq+2lus2C8rwUGE4CjM9GhjEiPIX7WdYKZP9iRfv5k4bq9nmV2b40VSR4xSw==
X-Gm-Gg: ASbGnctSbDfeYgpAvOed86CR1wkMTtPbwCfk1bMdYbMRI+hcBJb5vHEx8fxdWp92LTP
	i993NJ8NMxR+qe/+4pe0RkhN6DsmWhnqVKl4WWPUm4hoEGC/qHUncs/ht/xylOq9n6sCliRDrWJ
	Ehizia8OHmwWNNdg/n6uyemKAk+MVARJxXZKrYi86TTZi5yD1zaZ335zwYbXzBPP583N1h1WJAK
	NBOy5x/vNr+JjipGnTMXnnLK2A0YOQTAU79lDMFEcN9lYW1Cbajw2MtRr1qGHjIVbpiE6OB2Z4G
	OSCKbzrImE9ZNtTcb/AT65ZP8/5goekKRaPLV1iQm26VVo5g3LSSyd21
X-Google-Smtp-Source: AGHT+IE9Ipx8e8hi6l851M8ECjjGxpURnuc//kCtsTCbalD6OxbQYJGW4eIjPuy+9CqCFihdVq7D0A==
X-Received: by 2002:a17:902:ecc7:b0:224:1220:7f40 with SMTP id d9443c01a7336-2262c51bcb7mr23881445ad.3.1742279283447;
        Mon, 17 Mar 2025 23:28:03 -0700 (PDT)
Received: from thinkpad ([120.56.195.170])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301536326f6sm7277131a91.35.2025.03.17.23.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 23:28:02 -0700 (PDT)
Date: Tue, 18 Mar 2025 11:57:58 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bo Sun <Bo.Sun.CN@windriver.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Vidya Sagar <vidyas@nvidia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kevin Hao <kexin.hao@windriver.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Forcefully set the PCI_REASSIGN_ALL_BUS flag
 for Marvell CN96XX/CN10XXX boards
Message-ID: <20250318062758.hrquo3xhkt4kgt6g@thinkpad>
References: <20250311135229.3329381-1-Bo.Sun.CN@windriver.com>
 <20250311135229.3329381-2-Bo.Sun.CN@windriver.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250311135229.3329381-2-Bo.Sun.CN@windriver.com>

On Tue, Mar 11, 2025 at 09:52:28PM +0800, Bo Sun wrote:
> On our Marvell OCTEON CN96XX board, we observed the following panic on
> the latest kernel:
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000080
> CPU: 22 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc6 #20
> Hardware name: Marvell OcteonTX CN96XX board (DT)
> pc : of_pci_add_properties+0x278/0x4c8
> Call trace:
>  of_pci_add_properties+0x278/0x4c8 (P)
>  of_pci_make_dev_node+0xe0/0x158
>  pci_bus_add_device+0x158/0x228
>  pci_bus_add_devices+0x40/0x98
>  pci_host_probe+0x94/0x118
>  pci_host_common_probe+0x130/0x1b0
>  platform_probe+0x70/0xf0
> 
> The dmesg logs indicated that the PCI bridge was scanning with an invalid bus range:
>  pci-host-generic 878020000000.pci: PCI host bridge to bus 0002:00
>  pci_bus 0002:00: root bus resource [bus 00-ff]
>  pci 0002:00:00.0: scanning [bus f9-f9] behind bridge, pass 0
>  pci 0002:00:01.0: scanning [bus fa-fa] behind bridge, pass 0
>  pci 0002:00:02.0: scanning [bus fb-fb] behind bridge, pass 0
>  pci 0002:00:03.0: scanning [bus fc-fc] behind bridge, pass 0
>  pci 0002:00:04.0: scanning [bus fd-fd] behind bridge, pass 0
>  pci 0002:00:05.0: scanning [bus fe-fe] behind bridge, pass 0
>  pci 0002:00:06.0: scanning [bus ff-ff] behind bridge, pass 0
>  pci 0002:00:07.0: scanning [bus 00-00] behind bridge, pass 0
>  pci 0002:00:07.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>  pci 0002:00:08.0: scanning [bus 01-01] behind bridge, pass 0
>  pci 0002:00:09.0: scanning [bus 02-02] behind bridge, pass 0
>  pci 0002:00:0a.0: scanning [bus 03-03] behind bridge, pass 0
>  pci 0002:00:0b.0: scanning [bus 04-04] behind bridge, pass 0
>  pci 0002:00:0c.0: scanning [bus 05-05] behind bridge, pass 0
>  pci 0002:00:0d.0: scanning [bus 06-06] behind bridge, pass 0
>  pci 0002:00:0e.0: scanning [bus 07-07] behind bridge, pass 0
>  pci 0002:00:0f.0: scanning [bus 08-08] behind bridge, pass 0
> 
> This regression was introduced by commit 7246a4520b4b ("PCI: Use
> preserve_config in place of pci_flags"). On our board, the 0002:00:07.0
> bridge is misconfigured by the bootloader. Both its secondary and
> subordinate bus numbers are initialized to 0, while its fixed secondary
> bus number is set to 8. However, bus number 8 is also assigned to another
> bridge (0002:00:0f.0). Although this is a bootloader issue, before the
> change in commit 7246a4520b4b, the PCI_REASSIGN_ALL_BUS flag was set
> by default when PCI_PROBE_ONLY was not enabled, ensuing that all the
> bus number for these bridges were reassigned, avoiding any conflicts.
> 
> After the change introduced in commit 7246a4520b4b, the bus numbers
> assigned by the bootloader are reused by all other bridges, except
> the misconfigured 0002:00:07.0 bridge. The kernel attempt to reconfigure
> 0002:00:07.0 by reusing the fixed secondary bus number 8 assigned by
> bootloader. However, since a pci_bus has already been allocated for
> bus 8 due to the probe of 0002:00:0f.0, no new pci_bus allocated for
> 0002:00:07.0. This results in a pci bridge device without a pci_bus
> attached (pdev->subordinate == NULL). Consequently, accessing
> pdev->subordinate in of_pci_prop_bus_range() leads to a NULL pointer
> dereference.
> 
> To summarize, we need to set the PCI_REASSIGN_ALL_BUS flag when
> PCI_PROBE_ONLY is not enabled in order to work around issue like the
> one described above.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7246a4520b4b ("PCI: Use preserve_config in place of pci_flags")
> Signed-off-by: Bo Sun <Bo.Sun.CN@windriver.com>
> ---
> Changes in v2:
>  - Added explicit comment about the quirk, as requested by Mani.
>  - Made commit message more clear, as requested by Bjorn.
> 
>  drivers/pci/quirks.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 82b21e34c545..cec58c7479e1 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6181,6 +6181,23 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1536, rom_bar_overlap_defect);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537, rom_bar_overlap_defect);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538, rom_bar_overlap_defect);
>  
> +/*
> + * Quirk for Marvell CN96XX/CN10XXX boards:
> + *
> + * Adds PCI_REASSIGN_ALL_BUS unless PCI_PROBE_ONLY is set, forcing bus number
> + * reassignment to avoid conflicts caused by bootloader misconfigured PCI bridges.
> + *

Do we really need to care about PCI_PROBE_ONLY in the quirk? Why can't we make
it unconditional?

> + * This resolves a regression introduced by commit 7246a4520b4b ("PCI: Use
> + * preserve_config in place of pci_flags"), which removed this behavior.

I don't think mentioning the commit is really needed here.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

