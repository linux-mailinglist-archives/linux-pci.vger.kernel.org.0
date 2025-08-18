Return-Path: <linux-pci+bounces-34164-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40E1B298D8
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 07:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712E54E3BDE
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 05:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120C3202F9F;
	Mon, 18 Aug 2025 05:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZOZ3Nhh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE8C1EF38F;
	Mon, 18 Aug 2025 05:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755494489; cv=none; b=OVTYuixngFKZflyuRdBJOwI4b76V4zgRcnuEbrpBTHDXaOlngM3h9yeHBXPqE6lTQf96upAEeIQThpsNpiYSUIoGhMPDZZJLc6LPkuzO6ZZfQosH8TIaM9w0+iZuzHQj2Djx9lLuR4DCAjEUiKrYjOiBYl/AzXAxVQdDUvS+IWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755494489; c=relaxed/simple;
	bh=HApxKvm284DacfzNAPVw61LznOvwguaK6IzEWAXgmVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jh/BO/ULRJ+Vnn8kNAksWN5sCnbfOvliUOCWn5x90r/U7JpMn28RTpwJeDpGrntAOfoEy2gMqxiYgbxpJrTLDr5ErBs9WZVkbsDJPf6od58ECEgeGOoM0I6KHFhBYwF44qNUiHBeiQWKpvyn62Aip0vBDlYH+KvqQa7laeUwHrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZOZ3Nhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71984C4CEEB;
	Mon, 18 Aug 2025 05:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755494488;
	bh=HApxKvm284DacfzNAPVw61LznOvwguaK6IzEWAXgmVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tZOZ3NhhyhQxyKUX5tQoNazkynSZPioocRJV3Sw58sOqOqA/fBJ/h+mIa0+kMv0np
	 M0+tIKt4TZsomSYtEbk+QnrOGjFczejUhUGtkQlfX/Nwv0raiBoeNvQLBirN+PNQ/P
	 JXubaOmyM4TtfUmcsQwh+uYvrLf32ybWXDxwiv/ioJFgKnjya0ZUDFVwitAqM8d+yv
	 zp/UnD32ErIkUe8hU4f/qXAVOR+R61eRMFmjKYToRfO7zAxu0xMLl1bTXJhjZASUJI
	 0LFuEwlZN+sCP7gnKUxUb+cJ6laPZSL8UywJHagX2uQgtpbkTI2yuOHziRPuzghXDH
	 9O7U8z1UbD6fg==
Date: Mon, 18 Aug 2025 10:51:19 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: Lukas Wunner <lukas@wunner.de>, bhelgaas@google.com, 
	lpieralisi@kernel.org, kw@linux.com, kwilczynski@kernel.org, 
	ilpo.jarvinen@linux.intel.com, jingoohan1@gmail.com, robh@kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] PCI/bwctrl: Replace legacy speed conversion with
 shared macro
Message-ID: <cm35xzxgdepgxe3swq3q7pu6ikj7oqn7oihooldaj6dehzozng@ddyr7q3q55d2>
References: <20250816154633.338653-1-18255117159@163.com>
 <20250816154633.338653-4-18255117159@163.com>
 <aKDmW6l6uxZGr1Wl@wunner.de>
 <35f6d6f3-b857-48cc-b3cb-11a27675adfd@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35f6d6f3-b857-48cc-b3cb-11a27675adfd@163.com>

On Sun, Aug 17, 2025 at 11:02:10PM GMT, Hans Zhang wrote:
> 
> 
> On 2025/8/17 04:13, Lukas Wunner wrote:
> > On Sat, Aug 16, 2025 at 11:46:33PM +0800, Hans Zhang wrote:
> > > Remove obsolete pci_bus_speed2lnkctl2() function and utilize the common
> > > PCIE_SPEED2LNKCTL2_TLS() macro instead.
> > [...]
> > > +++ b/drivers/pci/pcie/bwctrl.c
> > > @@ -53,23 +53,6 @@ static bool pcie_valid_speed(enum pci_bus_speed speed)
> > >   	return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
> > >   }
> > > -static u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
> > > -{
> > > -	static const u8 speed_conv[] = {
> > > -		[PCIE_SPEED_2_5GT] = PCI_EXP_LNKCTL2_TLS_2_5GT,
> > > -		[PCIE_SPEED_5_0GT] = PCI_EXP_LNKCTL2_TLS_5_0GT,
> > > -		[PCIE_SPEED_8_0GT] = PCI_EXP_LNKCTL2_TLS_8_0GT,
> > > -		[PCIE_SPEED_16_0GT] = PCI_EXP_LNKCTL2_TLS_16_0GT,
> > > -		[PCIE_SPEED_32_0GT] = PCI_EXP_LNKCTL2_TLS_32_0GT,
> > > -		[PCIE_SPEED_64_0GT] = PCI_EXP_LNKCTL2_TLS_64_0GT,
> > > -	};
> > > -
> > > -	if (WARN_ON_ONCE(!pcie_valid_speed(speed)))
> > > -		return 0;
> > > -
> > > -	return speed_conv[speed];
> > > -}
> > > -
> > >   static inline u16 pcie_supported_speeds2target_speed(u8 supported_speeds)
> > >   {
> > >   	return __fls(supported_speeds);
> > > @@ -91,7 +74,7 @@ static u16 pcie_bwctrl_select_speed(struct pci_dev *port, enum pci_bus_speed spe
> > >   	u8 desired_speeds, supported_speeds;
> > >   	struct pci_dev *dev;
> > > -	desired_speeds = GENMASK(pci_bus_speed2lnkctl2(speed_req),
> > > +	desired_speeds = GENMASK(PCIE_SPEED2LNKCTL2_TLS(speed_req),
> > >   				 __fls(PCI_EXP_LNKCAP2_SLS_2_5GB));
> > 
> > No, that's not good.  The function you're removing above,
> > pci_bus_speed2lnkctl2(), uses an array to look up the speed.
> > That's an O(1) operation, it doesn't get any more efficient
> > than that.  It was a deliberate design decision to do this
> > when the bandwidth controller was created.
> > 
> > Whereas the function you're using instead uses a series
> > of ternary operators.  That's no longer an O(1) operation,
> > the compiler translates it into a series of conditional
> > branches, so essentially an O(n) lookup (where n is the
> > number of speeds).  So it's less efficient and less elegant.
> > 
> > Please come up with an approach that doesn't make this
> > worse than before.
> 
> 
> Dear Lukas,
> 
> Thank you very much for your reply.
> 
> I think the original static array will waste some memory space. Originally,
> we only needed a size of 6 bytes, but in reality, the size of this array is
> 26 bytes.
> 

This is just one time allocation as the array is a 'static const', which is not
a big deal.

> static const u8 speed_conv[] = {
> 	[PCIE_SPEED_2_5GT] = PCI_EXP_LNKCTL2_TLS_2_5GT,
> 	[PCIE_SPEED_5_0GT] = PCI_EXP_LNKCTL2_TLS_5_0GT,
> 	[PCIE_SPEED_8_0GT] = PCI_EXP_LNKCTL2_TLS_8_0GT,
> 	[PCIE_SPEED_16_0GT] = PCI_EXP_LNKCTL2_TLS_16_0GT,
> 	[PCIE_SPEED_32_0GT] = PCI_EXP_LNKCTL2_TLS_32_0GT,
> 	[PCIE_SPEED_64_0GT] = PCI_EXP_LNKCTL2_TLS_64_0GT,
> };

[...]

> drivers/pci/pci.h
> #define PCIE_LNKCAP_SLS2SPEED(lnkcap)					\
> ({									\
> 	u32 lnkcap_sls = (lnkcap) & PCI_EXP_LNKCAP_SLS;			\
> 									\
> 	(lnkcap_sls == PCI_EXP_LNKCAP_SLS_64_0GB ? PCIE_SPEED_64_0GT :	\
> 	 lnkcap_sls == PCI_EXP_LNKCAP_SLS_32_0GB ? PCIE_SPEED_32_0GT :	\
> 	 lnkcap_sls == PCI_EXP_LNKCAP_SLS_16_0GB ? PCIE_SPEED_16_0GT :	\
> 	 lnkcap_sls == PCI_EXP_LNKCAP_SLS_8_0GB ? PCIE_SPEED_8_0GT :	\
> 	 lnkcap_sls == PCI_EXP_LNKCAP_SLS_5_0GB ? PCIE_SPEED_5_0GT :	\
> 	 lnkcap_sls == PCI_EXP_LNKCAP_SLS_2_5GB ? PCIE_SPEED_2_5GT :	\
> 	 PCI_SPEED_UNKNOWN);						\
> })
> 
> /* PCIe link information from Link Capabilities 2 */
> #define PCIE_LNKCAP2_SLS2SPEED(lnkcap2) \
> 	((lnkcap2) & PCI_EXP_LNKCAP2_SLS_64_0GB ? PCIE_SPEED_64_0GT : \
> 	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_32_0GB ? PCIE_SPEED_32_0GT : \
> 	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_16_0GB ? PCIE_SPEED_16_0GT : \
> 	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_8_0GB ? PCIE_SPEED_8_0GT : \
> 	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_5_0GB ? PCIE_SPEED_5_0GT : \
> 	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_2_5GB ? PCIE_SPEED_2_5GT : \
> 	 PCI_SPEED_UNKNOWN)
> 
> #define PCIE_LNKCTL2_TLS2SPEED(lnkctl2) \
> ({									\
> 	u16 lnkctl2_tls = (lnkctl2) & PCI_EXP_LNKCTL2_TLS;		\
> 									\
> 	(lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_64_0GT ? PCIE_SPEED_64_0GT :	\
> 	 lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_32_0GT ? PCIE_SPEED_32_0GT :	\
> 	 lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_16_0GT ? PCIE_SPEED_16_0GT :	\
> 	 lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_8_0GT ? PCIE_SPEED_8_0GT :	\
> 	 lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_5_0GT ? PCIE_SPEED_5_0GT :	\
> 	 lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_2_5GT ? PCIE_SPEED_2_5GT :	\
> 	 PCI_SPEED_UNKNOWN);						\
> })

No, these macros are terrible. They generate more assembly code than needed for
a simple array based lookup. So in the end, they increase the binary size and
also doesn't provide any improvement other than the unification in the textual
form.

I have to take my Acked-by back as I sort of overlooked these factors. As Lukas
rightly said, the pci_bus_speed2lnkctl2() does lookup in O(1), which is what we
want here.

Code refactoring shouldn't come at the expense of the runtime overhead.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

