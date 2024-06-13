Return-Path: <linux-pci+bounces-8743-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0E39077FE
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 18:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D957281E48
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 16:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385B112FB0B;
	Thu, 13 Jun 2024 16:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LMsG6gWg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2398C12F5BB
	for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 16:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718295285; cv=none; b=GdYwhgzD1ahL4k/aYu+ahdS/ywcl+nK7VMiEWhWVMof5pbcKi84me1WDxCXG6BsH1DS6A6uQWXxOKqqYoE2+IJK1/OmLpV5H/6lfktuglW1fkHyHSH6CexIBA3pgN8hf5x/BTKfVQ4aj2PjWq3hPUA3xD2MDCE7JiTCiNqIa1ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718295285; c=relaxed/simple;
	bh=xZUKuNK/05GqnER6znF7IUcOsq1LP4oq4SEbTBMc8lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daVEO5PpTJidGJHLx6xjSh9f+r7zbB8lRjrb8jFkxLEPWJRdgpdlAcDbeyfYo9NgH4sxWTfl+3bNQ1gsv8HYL0RD7xF/R9S7tpSVNVrQks/tWU1/Rx56A8blV2niaji6v0J5Km0FJ+xIRzpowVIzXY9YkNTfUKfucCE+/svVC18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LMsG6gWg; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c315b569c8so1028243a91.0
        for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 09:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1718295281; x=1718900081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ki1pukFXg9FD3s9nvZHyz8xthzZ2jpAqUVpMBtWgQpg=;
        b=LMsG6gWgjb/eYpoV0rsSWqLaE1+yXpikJ+mLlzDrHyUgN7Ids+RcEKBlfA1nhj0t6v
         PZtLnis8wELYWD4fbLJAEn/vuzSlEu5QX8u6G7mTS/z8ndKyx1MkpANHQCcb+oa9w99Q
         hntJngZTGOWOb4RxOWWQC9RNJogxCwAAhSBjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718295281; x=1718900081;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ki1pukFXg9FD3s9nvZHyz8xthzZ2jpAqUVpMBtWgQpg=;
        b=wg3aZMry4QJGAKQpoiJ8hCr4OOfahxcDJ3OH7joRFX+qttUhLNdVA+5bRaF5tjYUCU
         aRwQM6ydnRZPTkSfaE6JEj3DEI54qwxUmobOSbPzZd7cdjeuegypWmQGjGqLJX7bFOfj
         zs/ExwFQ3YNFWqBQ4L+VM6nR8fg3uAGNGbM8b1vQ3VBTLGHg3u7dBWOS7GWI4PEEzQfK
         EXu2gh60NBLTVf+otNgSdiijSvrhuTgZeQwfMrCsT4AwTi6XWzseGPUqegBM/rTwflFC
         57K1dTGRigymUjYDSq7T9MhrOrnzRIM4jr2KnBGqRkgCAfQ9Kt9kTrKbtoveJCEfMLt8
         0h4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPxrQH534qTlQpbZad1/Eo36H0nYDhO96lfQgL2vsOx4yMLpWKNi1SIxYO6nGLIW4htUBUUt880xrekjXQqhUXWEXWDWKFce7u
X-Gm-Message-State: AOJu0YwOJTMuSD/pIhIEftjmTIAGbpeCokKNKE3qWMvg/fcMDWfchYy8
	kTv8U/aACs02x7s6D2Pbfi4rKDsn4R3hzcV3zOtjPIuVOFzub+0ERIdNmjt46ZE=
X-Google-Smtp-Source: AGHT+IHNeAVLfT/rwvAbwcJ/5NnF8ILii5IRJoNkKp/d71qMpHqZQ2hpEIXsUo2DT9mTfdQqhptamg==
X-Received: by 2002:a17:90a:ab07:b0:2bd:f708:7b40 with SMTP id 98e67ed59e1d1-2c4db134d28mr247216a91.1.1718295281458;
        Thu, 13 Jun 2024 09:14:41 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a769be25sm4169034a91.35.2024.06.13.09.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 09:14:41 -0700 (PDT)
Date: Thu, 13 Jun 2024 09:14:38 -0700
From: Joe Damato <jdamato@fastly.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, horms@kernel.org,
	kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
	linux@armlinux.org.uk, hfdevel@gmx.net, naveenm@marvell.com,
	bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next v10 0/7] add ethernet driver for Tehuti Networks
 TN40xx chips
Message-ID: <Zmsa7vMjQ67zKI1F@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	andrew@lunn.ch, horms@kernel.org, kuba@kernel.org, jiri@resnulli.us,
	pabeni@redhat.com, linux@armlinux.org.uk, hfdevel@gmx.net,
	naveenm@marvell.com, bhelgaas@google.com, linux-pci@vger.kernel.org
References: <20240611045217.78529-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611045217.78529-1-fujita.tomonori@gmail.com>

On Tue, Jun 11, 2024 at 01:52:10PM +0900, FUJITA Tomonori wrote:
> This patchset adds a new 10G ethernet driver for Tehuti Networks
> TN40xx chips. Note in mainline, there is a driver for Tehuti Networks
> (drivers/net/ethernet/tehuti/tehuti.[hc]), which supports TN30xx
> chips.
> 
> Multiple vendors (DLink, Asus, Edimax, QNAP, etc) developed adapters
> based on TN40xx chips. Tehuti Networks went out of business but the
> drivers are still distributed under GPL2 with some of the hardware
> (and also available on some sites). With some changes, I try to
> upstream this driver with a new PHY driver in Rust.
> 
> The major change is replacing the PHY abstraction layer in the original
> driver with phylink. TN40xx chips are used with various PHY hardware
> (AMCC QT2025, TI TLK10232, Aqrate AQR105, and Marvell MV88X3120,
> MV88X3310, and MV88E2010).
> 
> I've also been working on a new PHY driver for QT2025 in Rust [1]. For
> now, I enable only adapters using QT2025 PHY in the PCI ID table of
> this driver. I've tested this driver and the QT2025 PHY driver with
> Edimax EN-9320 10G adapter and 10G-SR SFP+. In mainline, there are PHY
> drivers for AQR105 and Marvell PHYs, which could work for some TN40xx
> adapters with this driver.
> 
> To make reviewing easier, this patchset has only basic functions. Once
> merged, I'll submit features like ethtool support.

Just a note for future feature support: it would be really great if
you also included the new netdev-genl APIs. For most drivers, it is
pretty easy to include and it allows userland to get more useful
information about the RX and TX queues.

Here's an example implementation for mlx4 to give you an idea of how
to use it:

  https://lore.kernel.org/netdev/20240513172909.473066-1-jdamato@fastly.com/

specifically:

  https://lore.kernel.org/netdev/20240513172909.473066-3-jdamato@fastly.com/

  and

  https://lore.kernel.org/netdev/20240513172909.473066-4-jdamato@fastly.com/
 
> v10:
> - Add Edimax Vendor ID to pci_ids.h (cleanup for wireless drivers later)
> - rename functions for mdio (use _c45 suffix for read/write and mdio_wait_nobusy)
> - clean up some tn40_rxdb_ functions
> - use unsinged int for static, nelem, and top in tn40_rxdb struct instead of int
> - return -ENODEV instead of -1 when PHY isn't found
> - remove the function to re-setting mdio speec to 1MHZ in tn40_priv_init()
> - cleanup tn40_mdio_set_speed()
> v9: https://lore.kernel.org/netdev/20240605232608.65471-1-fujita.tomonori@gmail.com/
> - move phylink_connect_phy() to simplify the ndo_open callback
> v8: https://lore.kernel.org/netdev/20240603064955.58327-1-fujita.tomonori@gmail.com/
> - remove phylink_mac_change() call
> - fix phylink_start() usage (call it after the driver is ready to operate).
> - simplify the way to get the private struct from phylink_config pointer
> - fix netif_stop_queue usage in mac_link_down callback
> - remove MLO_AN_PHY usage
> v7: https://lore.kernel.org/netdev/20240527203928.38206-7-fujita.tomonori@gmail.com/
> - use page pool API for rx allocation
> - fix NAPI API misuse
> - fix error checking of mdio write
> v6: https://lore.kernel.org/netdev/20240512085611.79747-2-fujita.tomonori@gmail.com/
> - use the firmware for TN30xx chips
> - move link up/down code to phylink's mac_link_up/mac_link_down callbacks
> - clean up mdio access code
> v5: https://lore.kernel.org/netdev/20240508113947.68530-1-fujita.tomonori@gmail.com/
> - remove dma_set_mask_and_coherent fallback
> - count tx_dropped
> - use ndo_get_stats64 instead of ndo_get_stats
> - remove unnecessary __packed attribute
> - fix NAPI API usage
> - rename tn40_recycle_skb to tn40_recycle_rx_buffer
> - avoid high order page allocation (the maximum is order-1 now)
> v4: https://lore.kernel.org/netdev/20240501230552.53185-1-fujita.tomonori@gmail.com/
> - fix warning on 32bit build
> - fix inline warnings
> - fix header file inclusion
> - fix TN40_NDEV_TXQ_LEN
> - remove 'select PHYLIB' in Kconfig
> - fix access to phydev
> - clean up readx_poll_timeout_atomic usage
> v3: https://lore.kernel.org/netdev/20240429043827.44407-1-fujita.tomonori@gmail.com/
> - remove driver version
> - use prefixes tn40_/TN40_ for all function, struct and define names
> v2: https://lore.kernel.org/netdev/20240425010354.32605-1-fujita.tomonori@gmail.com/
> - split mdio patch into mdio and phy support
> - add phylink support
> - clean up mdio read/write
> - use the standard bit operation macros
> - use upper_32/lower_32_bits macro
> - use tn40_ prefix instead of bdx_
> - fix Sparse errors
> - fix compiler warnings
> - fix style issues
> v1: https://lore.kernel.org/netdev/20240415104352.4685-1-fujita.tomonori@gmail.com/
> 
> [1] https://lore.kernel.org/netdev/20240415104701.4772-1-fujita.tomonori@gmail.com/
> 
> FUJITA Tomonori (7):
>   PCI: add Edimax Vendor ID to pci_ids.h
>   net: tn40xx: add pci driver for Tehuti Networks TN40xx chips
>   net: tn40xx: add register defines
>   net: tn40xx: add basic Tx handling
>   net: tn40xx: add basic Rx handling
>   net: tn40xx: add mdio bus support
>   net: tn40xx: add phylink support
> 
> MAINTAINERS                             |    8 +-
>  drivers/net/ethernet/tehuti/Kconfig     |   15 +
>  drivers/net/ethernet/tehuti/Makefile    |    3 +
>  drivers/net/ethernet/tehuti/tn40.c      | 1768 +++++++++++++++++++++++
>  drivers/net/ethernet/tehuti/tn40.h      |  231 +++
>  drivers/net/ethernet/tehuti/tn40_mdio.c |  142 ++
>  drivers/net/ethernet/tehuti/tn40_phy.c  |   76 +
>  drivers/net/ethernet/tehuti/tn40_regs.h |  245 ++++
>  include/linux/pci_ids.h                 |    2 +
>  9 files changed, 2489 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/tehuti/tn40.c
>  create mode 100644 drivers/net/ethernet/tehuti/tn40.h
>  create mode 100644 drivers/net/ethernet/tehuti/tn40_mdio.c
>  create mode 100644 drivers/net/ethernet/tehuti/tn40_phy.c
>  create mode 100644 drivers/net/ethernet/tehuti/tn40_regs.h
> 
> 
> base-commit: 2ebb87f45b3c6adc97b29291102ecb97274f913f
> -- 
> 2.34.1
> 

