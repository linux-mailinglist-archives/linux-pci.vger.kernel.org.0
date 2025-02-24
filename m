Return-Path: <linux-pci+bounces-22255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB71A42C36
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 20:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86C63AA59C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 19:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0161EA7FA;
	Mon, 24 Feb 2025 19:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRG3NEaj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F28F1EA7F5;
	Mon, 24 Feb 2025 19:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423615; cv=none; b=Hwnj1JRkjeH6I0nCkHjpMqYYQB4HOZG4jmcSr8SK02qe7nD5dBoJF7M6asXZuL8mD8PNyrpHIMQBu8GkhSPpEWGZ0I8dhr2+QHkSrAbGqzKuMDRz3clonsu391Y/OJBbHkM9X/zMPaGLtOTsz8mPDdv7bd8Z0a0K10NXmnP3e8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423615; c=relaxed/simple;
	bh=rRzI+z2ajIxRRUGlvU9sCaGc7lpzj0vAIq9Bs546a34=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VRQ8jL1gitwD81rUSanjj5m1eTLD0loD7LhRLSYMQvRbRmi2KYB1v0KVcW6tqoYADWZ2l5U7xCjIo1eC8+edPA8Ti2fGeT48ruFIzQ8VT+F0KQJn7UkyYw2+YxHDZ+4uEAk4YR8RvKzAjdVWXn3vyQn+JAQzd9pA81rk6pVx8pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRG3NEaj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CACC4CED6;
	Mon, 24 Feb 2025 19:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740423614;
	bh=rRzI+z2ajIxRRUGlvU9sCaGc7lpzj0vAIq9Bs546a34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pRG3NEajpiumXR6hcxs0jbECWDvqIbeir6FHSoIC/RFiuomiqRhLZtSq+ErPxDhey
	 C6bnEnWDwdd+BhsyEx6HCghdlQTQBJ34dzqkQ5pa+jQPeOLs0CUQzAo48NsVfGpYV0
	 rbNZMODQQmfV84VPoepOTK6cMDFtU2ir0cRGb01flNvx2WpxKibBW0suAEVOFilKcc
	 Ob9wjmb1qxTE6YO09A1x81F1yGNNJdYheyztRn+Q3+ZHVE+wU9kUhd1DX472ma41yp
	 YiCbssvfGG9urnDhKCoZeTq3iDv7+Gp9GYVTmOs/Lyq5CA4RotLe4BPY9a4ZBg7VBL
	 +J6GHK1MIj1Rw==
Date: Mon, 24 Feb 2025 13:00:13 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hau <hau@realtek.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd <nic_swsd@realtek.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH net-next 2/3] r8169: enable
 RTL8168H/RTL8168EP/RTL8168FP/RTL8125/RTL8126 LTR support
Message-ID: <20250224190013.GA469168@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544e50b9e4c4ee6a6d8ba6a777c2f07@realtek.com>

On Mon, Feb 24, 2025 at 04:33:50PM +0000, Hau wrote:
> > On 21.02.2025 08:18, ChunHao Lin wrote:
> > > This patch will enable RTL8168H/RTL8168EP/RTL8168FP/RTL8125/RTL8126
> > > LTR support on the platforms that have tested with LTR enabled.
> > 
> > Where in the code is the check whether platform has been tested with LTR?
> > 
> LTR is for L1,2. But L1 will be disabled when rtl_aspm_is_safe()
> return false. So LTR needs rtl_aspm_is_safe() to return true.
> 
> > > Signed-off-by: ChunHao Lin <hau@realtek.com>
> > > ---
> > >  drivers/net/ethernet/realtek/r8169_main.c | 108
> > > ++++++++++++++++++++++
> > >  1 file changed, 108 insertions(+)
> > >
> > > diff --git a/drivers/net/ethernet/realtek/r8169_main.c
> > > b/drivers/net/ethernet/realtek/r8169_main.c
> > > index 731302361989..9953eaa01c9d 100644
> > > --- a/drivers/net/ethernet/realtek/r8169_main.c
> > > +++ b/drivers/net/ethernet/realtek/r8169_main.c
> > > @@ -2955,6 +2955,111 @@ static void rtl_disable_exit_l1(struct
> > rtl8169_private *tp)
> > >       }
> > >  }
> > >
> > > +static void rtl_set_ltr_latency(struct rtl8169_private *tp) {
> > > +     switch (tp->mac_version) {
> > > +     case RTL_GIGA_MAC_VER_70:
> > > +     case RTL_GIGA_MAC_VER_71:
> > > +             r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);
> > > +             r8168_mac_ocp_write(tp, 0xcdd2, 0x8c09);
> > > +             r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);
> > > +             r8168_mac_ocp_write(tp, 0xcdd4, 0x9003);
> > > +             r8168_mac_ocp_write(tp, 0xcdda, 0x9003);
> > > +             r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);
> > > +             r8168_mac_ocp_write(tp, 0xcddc, 0x9003);
> > > +             r8168_mac_ocp_write(tp, 0xcde8, 0x887a);
> > > +             r8168_mac_ocp_write(tp, 0xcdea, 0x9003);
> > > +             r8168_mac_ocp_write(tp, 0xcdec, 0x8c09);
> > > +             r8168_mac_ocp_write(tp, 0xcdee, 0x9003);
> > > +             r8168_mac_ocp_write(tp, 0xcdf0, 0x8a62);
> > > +             r8168_mac_ocp_write(tp, 0xcdf2, 0x9003);
> > > +             r8168_mac_ocp_write(tp, 0xcdf4, 0x883e);
> > > +             r8168_mac_ocp_write(tp, 0xcdf6, 0x9003);
> > > +             break;
> > > +     case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_66:
> > > +             r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);
> > > +             r8168_mac_ocp_write(tp, 0xcdd2, 0x889c);
> > > +             r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);
> > > +             r8168_mac_ocp_write(tp, 0xcdd4, 0x8c30);
> > > +             r8168_mac_ocp_write(tp, 0xcdda, 0x9003);
> > > +             r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);
> > > +             r8168_mac_ocp_write(tp, 0xcddc, 0x9003);
> > > +             r8168_mac_ocp_write(tp, 0xcde8, 0x883e);
> > > +             r8168_mac_ocp_write(tp, 0xcdea, 0x9003);
> > > +             r8168_mac_ocp_write(tp, 0xcdec, 0x889c);
> > > +             r8168_mac_ocp_write(tp, 0xcdee, 0x9003);
> > > +             r8168_mac_ocp_write(tp, 0xcdf0, 0x8C09);
> > > +             r8168_mac_ocp_write(tp, 0xcdf2, 0x9003);
> > > +             break;
> > > +     case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_53:
> > > +             r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);
> > > +             r8168_mac_ocp_write(tp, 0xcdda, 0x9003);
> > > +             r8168_mac_ocp_write(tp, 0xcddc, 0x9003);
> > > +             r8168_mac_ocp_write(tp, 0xcdd2, 0x883c);
> > > +             r8168_mac_ocp_write(tp, 0xcdd4, 0x8c12);
> > > +             r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);
> > > +             break;
> > > +     default:
> > > +             break;
> > > +     }
> > > +}
> > > +
> > > +static void rtl_reset_pci_ltr(struct rtl8169_private *tp) {
> > > +     struct pci_dev *pdev = tp->pci_dev;
> > > +     u16 cap;
> > > +
> > > +     pcie_capability_read_word(pdev, PCI_EXP_DEVCTL2, &cap);
> > > +     if (cap & PCI_EXP_DEVCTL2_LTR_EN) {
> > > +             pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL2,
> > > +                                        PCI_EXP_DEVCTL2_LTR_EN);
> > > +             pcie_capability_set_word(pdev, PCI_EXP_DEVCTL2,
> > > +                                      PCI_EXP_DEVCTL2_LTR_EN);
> > 
> > I'd prefer that only PCI core deals with these registers
> > (functions like pci_configure_ltr()). Any specific reason for this
> > reset? Is it something which could be applicable for other devices
> > too, so that the PCI core should be extended?
> > 
> It is for specific platform. On that platform driver needs to do
> this to let LTR works.

This definitely looks like code that should not be in a driver.
Drivers shouldn't need to touch ASPM or LTR configuration unless
there's a device defect to work around, and that should use a PCI core
interface.  Depending on what the defect is, we may need to add a new
interface.

This clear/set of PCI_EXP_DEVCTL2_LTR_EN when it was already set could
work around some kind of device defect, or it could be a hint that
something in the PCI core is broken.  Maybe the core is configuring
ASPM/LTR incorrectly.

Bjorn

