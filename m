Return-Path: <linux-pci+bounces-41924-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C4EC7E462
	for <lists+linux-pci@lfdr.de>; Sun, 23 Nov 2025 17:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DEBFC347DB3
	for <lists+linux-pci@lfdr.de>; Sun, 23 Nov 2025 16:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37C7229B36;
	Sun, 23 Nov 2025 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDkHaJr8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BC319C546
	for <linux-pci@vger.kernel.org>; Sun, 23 Nov 2025 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763916166; cv=none; b=oRlUBVIB3H1haNne9CjjPniOkspzn5+LOxsvARBzcFj3npF9hx/mFHJ4XA9PMRva0eUwl6ccV3Iy4rT8p4KuwYaGmxOjdEgVLuE7VLymAqco5TTfQf6cJYLORDuN6f3xGhI/BKYpQAHHUyNncMDwQ2Wx3VC5Gow2fPj1kxDiiOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763916166; c=relaxed/simple;
	bh=cSYsTc9rurDaCIOyxSlxp078tfD177G4C6LbUYLDv0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABdL4ANapLxd6JxEJJnVOT2YDJHCi32+DMtkSC9e9MWBp7Lgnea4ep7z13/AasnypmQBNqWBaDyqN0kPaHWh8rkhe2uJxFccpSSPiFFm5Yo/092IgvrrL+5ii4VyoS9u6Y/RlYIrFHLnfD7rGTBBW83W03iGSSwDoIWDSkXPlMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDkHaJr8; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-bc0e89640b9so2279987a12.1
        for <linux-pci@vger.kernel.org>; Sun, 23 Nov 2025 08:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763916163; x=1764520963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d0j1F7QCP+4D9igowWdEVkA8R7gqxJbBFhGcJ/oVN5w=;
        b=UDkHaJr8FqzfLPqHrkAazWysjgU8Bq2vpb3dB8rsvJjRUPWTUWPcmdE3ZjPMLbUewl
         kmngDOWFzaJ6BxyBH7ulGc4dfOPLVGPvRvY7fLGbJNoZ7xsZ2blAo14Zj5kGZI51Zgt+
         knzeVhRxZZlcQn/dGazFok5rqbYIy+b3YCQWEiruxa1N9LrNFjSkejMXdBmUcvh4gOrD
         KE5d5qVK+pwR1WADPAFPTN+RF3DqKrG1QhwLKpwMAj0Wwi7wwiDmk7YpNZ0fQweJtpL2
         GXajrkykBD5DRMIEblGYDabb4quRh8ZHQXB9pzXEuYwQsx8tUBAABv1qF8dohdwJb1F7
         H/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763916163; x=1764520963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d0j1F7QCP+4D9igowWdEVkA8R7gqxJbBFhGcJ/oVN5w=;
        b=EE2ZFB3/5q89H8fDTCGE7wfUDPpf4BZA5Wgkb1JohzV0ayVTAywnUmvH5Xm4Orwk9u
         uu+LjYWSGK+Tib5WoMr+nF0kg1v2abeP3Q62g8sXi2CKqmCHtci02l2RXpnY+Lg2wiXT
         Cx2YH7oVc2ySjWwH5ORxBrg6tP92MI/1EeDcvLyxx5oEBEogbobUe/+EzxagA/pAbLaW
         Omam9s5mfp+NnKtoqLFqz3YThiDfWK8ARCOqdkj3yEHI9yWOWognWgHNHrdY/g0vgN0b
         Sxb+3ZKV8toVHBNw2QSfaMDjReEl4/CzJdmH9+5fTAvNnomVsCXPJ7dBbSVEN5SM6ZNS
         BV0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVeNmJlE0pb0ECWipWxVcEO3CHooc1EOlF3lBVhGlvTFPmFqDJPF0ubsEpIyA5TYtN7eUklXYMhvZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWXWZgacu5dr4MtYhbwbaFfe6m7TOI1yDXtr6WdKcR1XL5Vfmz
	pY/OGAUbQCO1b8I7MNMOzC4MI1Y6516/rvsfGOfyqIRmTtXH8bIw8j44
X-Gm-Gg: ASbGncsN++cikl+QbBFWPEmTn7ldAi2FIg3kXPt9FtUeBSwKysZrixAD4y7MGNaOaSl
	l/zmfQz1OmHrrfjElRdWI74Qz2a1/wqME2vCjj2BlH12wyJCGwKnTDVMpPdZoBFG/IjTOnikzcj
	Yg8AkAdigf5fmCjXcXCpDR70ow+ZI9m75+w0vI+mVSyqt06/wNYqvczjUrTcsBzd7+g+K/0wcZT
	adQTQqfrkKGgQEq7dCZA40niYa1x2SwtmoKCLeE37qOGQFmKh6At0+McqY0zHyK6zVxSc0ciN5+
	lpBSBU3cwV8ACpLfUdAp8whSPFTgQWPL/W6CZjNqYAtYIJAIProPFPjE8xJOea3nMp5KKkwFBaB
	Qz/LPQCctWhq3rJjvGHS4pJ/k2D8X52yJUlUy4rIxMirLkFeXaKJcWJ7bZ/HiZ6yLjkUTduJanz
	bMBuhvHRrUZ2uzJyFErsmXvfg=
X-Google-Smtp-Source: AGHT+IE13jqQnGMBUZ2qpPc1TDhmtseXk7/7dxNiq5aM2ZmAaTpjpGFXTOpMGpzVp9MUYxu7Pd26Pg==
X-Received: by 2002:a05:7022:2509:b0:119:e56c:18a1 with SMTP id a92af1059eb24-11c9d60f0a7mr5105569c88.9.1763916162816;
        Sun, 23 Nov 2025 08:42:42 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93cd457dsm56769583c88.0.2025.11.23.08.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 08:42:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 23 Nov 2025 08:42:39 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>, dakr@redhat.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-parisc@vger.kernel.org,
	Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v9 02/13] PCI: Add devres helpers for iomap table
 [resulting in backtraces on HPPA]
Message-ID: <16cd212f-6ea0-471d-bf32-34f55d7292fe@roeck-us.net>
References: <20240613115032.29098-1-pstanner@redhat.com>
 <20240613115032.29098-3-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613115032.29098-3-pstanner@redhat.com>

Hi,

On Thu, Jun 13, 2024 at 01:50:15PM +0200, Philipp Stanner wrote:
> The pcim_iomap_devres.table administrated by pcim_iomap_table() has its
> entries set and unset at several places throughout devres.c using manual
> iterations which are effectively code duplications.
> 
> Add pcim_add_mapping_to_legacy_table() and
> pcim_remove_mapping_from_legacy_table() helper functions and use them where
> possible.
> 
> Link: https://lore.kernel.org/r/20240605081605.18769-4-pstanner@redhat.com
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> [bhelgaas: s/short bar/int bar/ for consistency]
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/devres.c | 77 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 58 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> index f13edd4a3873..845d6fab0ce7 100644
> --- a/drivers/pci/devres.c
> +++ b/drivers/pci/devres.c
> @@ -297,6 +297,52 @@ void __iomem * const *pcim_iomap_table(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL(pcim_iomap_table);
>  
> +/*
> + * Fill the legacy mapping-table, so that drivers using the old API can
> + * still get a BAR's mapping address through pcim_iomap_table().
> + */
> +static int pcim_add_mapping_to_legacy_table(struct pci_dev *pdev,
> +					    void __iomem *mapping, int bar)
> +{
> +	void __iomem **legacy_iomap_table;
> +
> +	if (bar >= PCI_STD_NUM_BARS)
> +		return -EINVAL;
> +
> +	legacy_iomap_table = (void __iomem **)pcim_iomap_table(pdev);
> +	if (!legacy_iomap_table)
> +		return -ENOMEM;
> +
> +	/* The legacy mechanism doesn't allow for duplicate mappings. */
> +	WARN_ON(legacy_iomap_table[bar]);
> +

Ever since this patch has been applied, I see this warning on all hppa
(parisc) systems.

[    0.978177] WARNING: CPU: 0 PID: 1 at drivers/pci/devres.c:473 pcim_add_mapping_to_legacy_table.part.0+0x54/0x80
[    0.978850] Modules linked in:
[    0.979277] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.18.0-rc6-64bit+ #1 NONE
[    0.979519] Hardware name: 9000/785/C3700
[    0.979715]
[    0.979768]      YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI
[    0.979886] PSW: 00001000000001000000000000001111 Not tainted
[    0.980006] r00-03  000000000804000f 00000000414e10a0 0000000040acb300 00000000434b1440
[    0.980167] r04-07  00000000414a78a0 0000000000029000 0000000000000000 0000000043522000
[    0.980314] r08-11  0000000000000000 0000000000000008 0000000000000000 00000000434b0de8
[    0.980461] r12-15  00000000434b11b0 000000004156a8a0 0000000043c655a0 0000000000000000
[    0.980608] r16-19  000000004016e080 000000004019e7d8 0000000000000030 0000000043549780
[    0.981106] r20-23  0000000020000000 0000000000000000 000000000800000e 0000000000000000
[    0.981317] r24-27  0000000000000000 000000000800000f 0000000043522260 00000000414a78a0
[    0.981480] r28-31  00000000436af480 00000000434b1680 00000000434b14d0 0000000000027000
[    0.981641] sr00-03  0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    0.981805] sr04-07  0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    0.981972]
[    0.982024] IASQ: 0000000000000000 0000000000000000 IAOQ: 0000000040acb31c 0000000040acb320
[    0.982185]  IIR: 03ffe01f    ISR: 0000000000000000  IOR: 00000000436af410
[    0.982322]  CPU:        0   CR30: 0000000043549780 CR31: 0000000000000000
[    0.982458]  ORIG_R28: 00000000434b16b0
[    0.982548]  IAOQ[0]: pcim_add_mapping_to_legacy_table.part.0+0x54/0x80
[    0.982733]  IAOQ[1]: pcim_add_mapping_to_legacy_table.part.0+0x58/0x80
[    0.982871]  RP(r2): pcim_add_mapping_to_legacy_table.part.0+0x38/0x80
[    0.983100] Backtrace:
[    0.983439]  [<0000000040acba1c>] pcim_iomap+0xc4/0x170
[    0.983577]  [<0000000040ba3e4c>] serial8250_pci_setup_port+0x8c/0x168
[    0.983725]  [<0000000040ba7588>] setup_port+0x38/0x50
[    0.983837]  [<0000000040ba7d94>] pci_hp_diva_setup+0x8c/0xd8
[    0.983957]  [<0000000040baa47c>] pciserial_init_ports+0x2c4/0x358
[    0.984088]  [<0000000040baa8bc>] pciserial_init_one+0x31c/0x330
[    0.984214]  [<0000000040abfab4>] pci_device_probe+0x194/0x270

Looking into serial8250_pci_setup_port():

        if (pci_resource_flags(dev, bar) & IORESOURCE_MEM) {
                if (!pcim_iomap(dev, bar, 0) && !pcim_iomap_table(dev))
                        return -ENOMEM;

This suggests that the failure is expected. I can see that pcim_iomap_table()
is deprecated, and that one is supposed to use pcim_iomap() instead. However,
pcim_iomap() _is_ alrady used, and I don't see a function which lets the
caller replicate what is done above (attach multiple serial ports to the
same PCI bar).

How would you suggest to fix the problem ?

Thanks,
Guenter

