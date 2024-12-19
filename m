Return-Path: <linux-pci+bounces-18777-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD239F7C0A
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 14:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111811886298
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 13:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63812223E6A;
	Thu, 19 Dec 2024 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcZyqE/8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAC62236E4;
	Thu, 19 Dec 2024 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734613687; cv=none; b=Feu7/nJVTAHHiqtDJEFhXf84EMbrqSmFWR/9hgrNSA2Ou6CNo0fSBpCsylGdypaZfoevj3oFlv6kooE2Qu2McoJrlImo1S4s0vVcVMMdGYPvw+fOp+uNRdgDRWKqvOGvWkwqPnZMqMdene1NO4NlsZcMvhpu49+cUHRxH5y5l3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734613687; c=relaxed/simple;
	bh=9JZOY6GfofMF9pnKPHnGr70UB4um6MLw4jpedDY8Z+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJw9olKMXOoOTPL69rUmehNy0RKnA7v+VQEfE0xWtSqcsIJ7QM6WCQZHoxT/6psf9BdIbqPM03e1piO1uwk9Zmfy4rM3h3Za6Sb2hmyBivHS4mjcQyPNfjLr/2NHbezxiwa2D638ZlqSSXYZPJQlRpwmAnvHjcgWBGp72L4l0xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcZyqE/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68264C4CECE;
	Thu, 19 Dec 2024 13:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734613686;
	bh=9JZOY6GfofMF9pnKPHnGr70UB4um6MLw4jpedDY8Z+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PcZyqE/8Bea6wioeytxqYdRvBj6x8BesimpkBji0/yoUur8NqS0FNu9JLcB0PYTfU
	 t5oPe4eAgoQY25LBaZiDPQNWW3dlEy51bKXMlYIDfJKACadsCeyioEoJfoIdtHj/Nb
	 7IC6Gefl35d6XM5OkAkun7Cy0Oe4BUZaTO6dKYqkYz4TbmwOhEXGFI9yv3Jj6kLoQH
	 mCZdUVNMf8w6/j2pSB8XDyeOM78qlLfNsulnI9y1QY9DRlFaZmbcd3F+572956pYKw
	 xpu5DT4wH+RGhZ/tiA48jFzOcgW2fPx6R5kJ1I+uDThvCJLAR2Z67BmXa2/K1cSbZE
	 OfNRalr+0PY9Q==
Date: Thu, 19 Dec 2024 14:08:01 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] misc: pci_endpoint_test: Set reserved BARs for each
 SoCs
Message-ID: <Z2QasXs0c9jQY8RL@x1-carbon>
References: <20241216073941.2572407-1-hayashi.kunihiko@socionext.com>
 <20241216073941.2572407-2-hayashi.kunihiko@socionext.com>
 <Z2E0EDC3tV76303d@ryzen>
 <56f1a6cf-40ad-4452-bce1-274eb3d124a9@socionext.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56f1a6cf-40ad-4452-bce1-274eb3d124a9@socionext.com>

On Thu, Dec 19, 2024 at 08:17:50PM +0900, Kunihiko Hayashi wrote:
> On 2024/12/17 17:19, Niklas Cassel wrote:
>
> > If you simply add code that disables all BARs by default in am654, you
> > should be able to remove these ugly is_am654_pci_dev() checks in the host
> > driver, and the host driver should not be able to write to these reserved
> > BARs, as they will never get enabled by pci-epf-test.c.
>
> However, dw_pcie_ep_reset_bar() only clears BAR registers to 0x0. BAR
> doesn't have any "disabled" field, so I think that it means "32-bit, memory,
> non-prefetchable".

From the DWC databook, 4.60a, section "6.1.2 BAR Details",
heading "Disabling a BAR".

"To disable a BAR (in any of the three schemes), your application can
write ‘0’ to the LSB of the BAR mask register."

dw_pcie_ep_reset_bar() calls __dw_pcie_ep_reset_bar(), which will
write a zero to the LSB of the BAR mask register:
https://github.com/torvalds/linux/blob/v6.13-rc3/drivers/pci/controller/dwc/pcie-designware-ep.c#L50


>
>
> https://github.com/torvalds/linux/blob/v6.13-rc3/drivers/pci/controller/dwc/pcie-designware-ep.c#L47-L52
>
> And even if each endpoint driver marks "BAR_RESERVED" to the features, it is
> only referred to as excluded BARs when searching for free BARs. So the host
> will recognize this "reserved" BAR.

A BAR that has been disabled on the EP side, will not have a size/
be visible on host side.

Like I said, rk3588 calls dw_pcie_ep_reset_bar() on all BARs in EP init,
like most DWC based EPC drivers, and marks BAR4 as reserved.
This is how it looks on the host side during enumeration:

[   25.496645] pci 0000:01:00.0: [1d87:3588] type 00 class 0xff0000 PCIe Endpoint
[   25.497322] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x000fffff]
[   25.497863] pci 0000:01:00.0: BAR 1 [mem 0x00000000-0x000fffff]
[   25.498400] pci 0000:01:00.0: BAR 2 [mem 0x00000000-0x000fffff]
[   25.498937] pci 0000:01:00.0: BAR 3 [mem 0x00000000-0x000fffff]
[   25.499498] pci 0000:01:00.0: BAR 5 [mem 0x00000000-0x000fffff]
[   25.500036] pci 0000:01:00.0: ROM [mem 0x00000000-0x0000ffff pref]
[   25.500861] pci 0000:01:00.0: supports D1 D2
[   25.501240] pci 0000:01:00.0: PME# supported from D0 D1 D3hot

Likewise the looping in pci_endpoint_test.c will skip disabled BARs, e.g.:
https://github.com/torvalds/linux/blob/v6.13-rc3/drivers/misc/pci_endpoint_test.c#L940-L943

Since test->bar[bar] will be NULL for BARs that are disabled.


Kind regards,
Niklas

