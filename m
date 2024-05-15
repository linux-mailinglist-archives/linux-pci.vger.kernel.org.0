Return-Path: <linux-pci+bounces-7534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2CE8C6D9D
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 23:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A822B281F98
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 21:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8586715B144;
	Wed, 15 May 2024 21:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8BA31QH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5808A155A57;
	Wed, 15 May 2024 21:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715807632; cv=none; b=LJcL4LGQyd2zhfmv6EMUJsAttA/v+3i7HB+hYCRVUtxExHGXZKofW6IrWaiMxoh0UwqBbdT7p6pDUGqBNcenDLnZH2/u6WZodPlxk0Wk4dKbY7XdceeXCP7vNc5X9VNgv5rOB3XOS8guIhfWSNSdyFpTGuDK4Taklj+EY+aUpRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715807632; c=relaxed/simple;
	bh=92Bg9W1jfudPogCMHlnwGwZOFXqjwzrhqg+gfddCvgc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fgCUxqSoF9NTkRBfO9sc3evTmZPajhqf/FDchCjO80CDX2Zx53wfr16DY8fVal+e/XgYzVIqxKRIwo6j08sekf5tnnkrs+as/PyXLxuD7eZyJgzZ9Gh891xZhBaUJHVu98CS8Ie42JJgVlMkw1VaIf5GeTHlc7U3VCHWsm9hn8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8BA31QH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990FAC32781;
	Wed, 15 May 2024 21:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715807631;
	bh=92Bg9W1jfudPogCMHlnwGwZOFXqjwzrhqg+gfddCvgc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=S8BA31QH7LK+QVdeB6Mu1tL7+oDDrVuB4pRkhH06CYUtwMegzUFlB095Sb4Zwbpxw
	 VCTDALqX31X7kPYjnVtfuNvBOfAMqp4H+tFZ51c8ck9ZLD/PZJon2wzFZUaVnmgwPf
	 VymrE+aaYcnRQ18OYFpYbHeRsJvbpYkdkY0+nSbVdVAXVDHlPcV27HTs0JBMc1e9lE
	 Kmnw5ArBPlB1/loKB0GII383RGiB5aqWOZEhmn0bP2SaYXt6Jobj78xGr5ImNgYquk
	 tWoxD5bSzr/EzVgKknGN1ep3dhmHUtvGcD+NiTrtSTfBHHnmmCL3IrgrobAWP4w3yG
	 ZWxO6cM77OF/g==
Date: Wed, 15 May 2024 16:13:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: rick.wertenbroek@heig-vd.ch, dlemoal@kernel.org, stable@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: rockchip-ep: Remove wrong mask on subsys_vendor_id
Message-ID: <20240515211350.GA2139074@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515205547.GA2137633@bhelgaas>

On Wed, May 15, 2024 at 03:55:49PM -0500, Bjorn Helgaas wrote:
> On Wed, Apr 03, 2024 at 04:45:08PM +0200, Rick Wertenbroek wrote:
> > Remove wrong mask on subsys_vendor_id. Both the Vendor ID and Subsystem
> > Vendor ID are u16 variables and are written to a u32 register of the
> > controller. The Subsystem Vendor ID was always 0 because the u16 value
> > was masked incorrectly with GENMASK(31,16) resulting in all lower 16
> > bits being set to 0 prior to the shift.
> > 
> > Remove both masks as they are unnecessary and set the register correctly
> > i.e., the lower 16-bits are the Vendor ID and the upper 16-bits are the
> > Subsystem Vendor ID.
> > 
> > This is documented in the RK3399 TRM section 17.6.7.1.17
> > 
> > Fixes: cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
> > Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> > Cc: stable@vger.kernel.org
> 
> Applied to pci/controller/rockchip by Krzysztof, but his outgoing mail
> queue got stuck.  I added Damien's Reviewed-by.  Trying to squeeze
> into v6.9.

Sorry, I meant v6.10.  v6.9 is already done.

> > ---
> >  drivers/pci/controller/pcie-rockchip-ep.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> > index c9046e97a1d2..37d4bcb8bd5b 100644
> > --- a/drivers/pci/controller/pcie-rockchip-ep.c
> > +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> > @@ -98,10 +98,9 @@ static int rockchip_pcie_ep_write_header(struct pci_epc *epc, u8 fn, u8 vfn,
> >  
> >  	/* All functions share the same vendor ID with function 0 */
> >  	if (fn == 0) {
> > -		u32 vid_regs = (hdr->vendorid & GENMASK(15, 0)) |
> > -			       (hdr->subsys_vendor_id & GENMASK(31, 16)) << 16;
> > -
> > -		rockchip_pcie_write(rockchip, vid_regs,
> > +		rockchip_pcie_write(rockchip,
> > +				    hdr->vendorid |
> > +				    hdr->subsys_vendor_id << 16,
> >  				    PCIE_CORE_CONFIG_VENDOR);
> >  	}
> >  
> > -- 
> > 2.25.1
> > 

