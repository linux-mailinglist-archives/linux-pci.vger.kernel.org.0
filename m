Return-Path: <linux-pci+bounces-34134-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3DAB29084
	for <lists+linux-pci@lfdr.de>; Sat, 16 Aug 2025 22:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF4187AD1AF
	for <lists+linux-pci@lfdr.de>; Sat, 16 Aug 2025 20:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37853231A24;
	Sat, 16 Aug 2025 20:13:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6AD21765B;
	Sat, 16 Aug 2025 20:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755375202; cv=none; b=cQFEFQJkue6StxGs5GZghrsEqwKyAGdcxfvatXx+2ZRZPNZptDST+yVvumfSrS9FBwfcSV2GXrAJ7OGvNrfHpHaAgNzTBT/kTSPyUDbdjfbFzexOzfBGjgOGROiLBhnJFVegKCF0gMPQN6zcBPzbHlc993oq3LjK36Q8UK0w/rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755375202; c=relaxed/simple;
	bh=32EDBW6JsStoD0JtZoUET0Pc/hwmACsbEMHh4qorgnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ls8j6IN8mUVTofX3BKeR1mR54obqsteNM2gEZ23VETkENpU4NpZzJrz4rWBrTzaNVV1H7nVZIDyNoU9yedi3icNTs+1ntSH/krVbjCkOc8TDxGBfhG5NQjlKRuhbQ9DVnu1LEaVELoHeLmpUn1HZ/wz7DbECsWqouSQXeX6qrTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id C66672C06E32;
	Sat, 16 Aug 2025 22:13:15 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id BC4B01F0F34; Sat, 16 Aug 2025 22:13:15 +0200 (CEST)
Date: Sat, 16 Aug 2025 22:13:15 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	kwilczynski@kernel.org, mani@kernel.org,
	ilpo.jarvinen@linux.intel.com, jingoohan1@gmail.com,
	robh@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] PCI/bwctrl: Replace legacy speed conversion with
 shared macro
Message-ID: <aKDmW6l6uxZGr1Wl@wunner.de>
References: <20250816154633.338653-1-18255117159@163.com>
 <20250816154633.338653-4-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816154633.338653-4-18255117159@163.com>

On Sat, Aug 16, 2025 at 11:46:33PM +0800, Hans Zhang wrote:
> Remove obsolete pci_bus_speed2lnkctl2() function and utilize the common
> PCIE_SPEED2LNKCTL2_TLS() macro instead.
[...]
> +++ b/drivers/pci/pcie/bwctrl.c
> @@ -53,23 +53,6 @@ static bool pcie_valid_speed(enum pci_bus_speed speed)
>  	return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
>  }
>  
> -static u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
> -{
> -	static const u8 speed_conv[] = {
> -		[PCIE_SPEED_2_5GT] = PCI_EXP_LNKCTL2_TLS_2_5GT,
> -		[PCIE_SPEED_5_0GT] = PCI_EXP_LNKCTL2_TLS_5_0GT,
> -		[PCIE_SPEED_8_0GT] = PCI_EXP_LNKCTL2_TLS_8_0GT,
> -		[PCIE_SPEED_16_0GT] = PCI_EXP_LNKCTL2_TLS_16_0GT,
> -		[PCIE_SPEED_32_0GT] = PCI_EXP_LNKCTL2_TLS_32_0GT,
> -		[PCIE_SPEED_64_0GT] = PCI_EXP_LNKCTL2_TLS_64_0GT,
> -	};
> -
> -	if (WARN_ON_ONCE(!pcie_valid_speed(speed)))
> -		return 0;
> -
> -	return speed_conv[speed];
> -}
> -
>  static inline u16 pcie_supported_speeds2target_speed(u8 supported_speeds)
>  {
>  	return __fls(supported_speeds);
> @@ -91,7 +74,7 @@ static u16 pcie_bwctrl_select_speed(struct pci_dev *port, enum pci_bus_speed spe
>  	u8 desired_speeds, supported_speeds;
>  	struct pci_dev *dev;
>  
> -	desired_speeds = GENMASK(pci_bus_speed2lnkctl2(speed_req),
> +	desired_speeds = GENMASK(PCIE_SPEED2LNKCTL2_TLS(speed_req),
>  				 __fls(PCI_EXP_LNKCAP2_SLS_2_5GB));

No, that's not good.  The function you're removing above,
pci_bus_speed2lnkctl2(), uses an array to look up the speed.
That's an O(1) operation, it doesn't get any more efficient
than that.  It was a deliberate design decision to do this
when the bandwidth controller was created.

Whereas the function you're using instead uses a series
of ternary operators.  That's no longer an O(1) operation,
the compiler translates it into a series of conditional
branches, so essentially an O(n) lookup (where n is the
number of speeds).  So it's less efficient and less elegant.

Please come up with an approach that doesn't make this
worse than before.

Thanks,

Lukas

