Return-Path: <linux-pci+bounces-6186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D6B8A2FA6
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 15:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00158B237A5
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 13:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E381D83CD1;
	Fri, 12 Apr 2024 13:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXeKwuen"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B921D1DFD9;
	Fri, 12 Apr 2024 13:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929074; cv=none; b=sMhe2lseVgyl6s0ShnZewntoXZRWOpG9S2yR8J+Akz3nwuCuTNZocS8XciUlnrl1KDaA4AbqTIACOwmxWC3WcCohjMQ0rKYJ7MENY6X5pY0BKBmo5/BhRBdRgqaQTe4unC/Ygrtj5bmw5YmbyLv4HWcFkf7G1jDMEclFVjjYcog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929074; c=relaxed/simple;
	bh=BtXw/kQS9H2R5Z9NHOeu97SUGojR8hmFg+yh11PQUcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXrCGu4ki9la631m0siHNlUnfWlu/XYSMTt0rhwjIgn4//zmJDa6rJpoc/cbfN9imRIjDwEmlRhBOCTrN61OL7uJlROzPRnsS2qd+j9DRITm0NrHEVsOkhJhBN3MQERj4GIM11J5F4XH0e43M8CjstcaYUW1yUcxuyJSyV2QILk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXeKwuen; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69051C3277B;
	Fri, 12 Apr 2024 13:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712929074;
	bh=BtXw/kQS9H2R5Z9NHOeu97SUGojR8hmFg+yh11PQUcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DXeKwuencmMy8ddA+0WHxID67LX0wCavx41hTotgshniEDU9JeRGoUaiJlQtLxQa7
	 t9sALtTijN1Rg3DJpT3+48FRvUnsmzdySfXaNfS1yV3HeJA2UMuS5jQzaO6FqjeSfs
	 KA9Pz4MsIZtsINxAe6bUuNaEvxKGRLgfXN1p0X3qtZS8jQ9k9JdUXSn5yn1ufLxnfr
	 neXrCOi0YEez7QJZa+kGtCeXK81uHxtYsRYNiTYJ3e8H249Bd+l6OacxSC3ombOl1h
	 A8x/WhkZWirauZOSH5FEgWNivzSg0Xk9j7QqKpcjeabgYuwsiI4xI8lKQw6e1eEBq2
	 6KoTgp6yhNVSA==
Date: Fri, 12 Apr 2024 15:37:48 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, helgaas@kernel.org,
	bhelgaas@google.com, gustavo.pimentel@synopsys.com,
	imx@lists.linux.dev, jdmason@kudzu.us, jingoohan1@gmail.com,
	kw@linux.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org, robh@kernel.org
Subject: Re: [PATCH v3 1/1] PCI: dwc: Fix index 0 incorrectly being
 interpreted as a free ATU slot
Message-ID: <Zhk5LERFKTFkPl4b@ryzen>
References: <20240326193540.3610570-1-Frank.Li@nxp.com>
 <ZhPFmFYorWa-sfLp@ryzen>
 <20240410180341.GF16629@thinkpad>
 <ZhbXlOMNxc2nMIW8@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhbXlOMNxc2nMIW8@lizhi-Precision-Tower-5810>

On Wed, Apr 10, 2024 at 02:16:52PM -0400, Frank Li wrote:
> On Wed, Apr 10, 2024 at 11:33:41PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Apr 08, 2024 at 12:23:20PM +0200, Niklas Cassel wrote:
> > > On Tue, Mar 26, 2024 at 03:35:40PM -0400, Frank Li wrote:
> > > > When PERST# assert and deassert happens on the PERST# supported platforms,
> > > > the both iATU0 and iATU6 will map inbound window to BAR0. DMA will access
> > > > to the area that was previously allocated (iATU0) for BAR0, instead of the
> > > > new area (iATU6) for BAR0.
> > > 
> > > Nit: If we want additional clarity, we could also add:
> > > ""
> > > Right now, we dodge the bullet because both iATU0 and iATU6 should currently
> > > translate inbound accesses to BAR0 to the same allocated memory area. However,
> > > having two separate inbound mappings for the same BAR is a disaster waiting to
> > > happen.
> > > ""
> > 
> > Since Bjorn asked for the above info, it should get added.
> > 
> > With that,
> > 
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Mani:
> 
> Do you need me rework patch? Or you can handle it by yourself when apply?

It appears that Krzysztof is the one picking up patches for:
drivers/pci/controller/dwc/

Since he has the bottommost Signed-off-by on patches in:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=controller%2Fdwc

So I don't think that Mani can amend it, since he is most likely not the
one picking up this patch.

The fastest way is probably just to send out a v4.
(But I feel you... this patch has already taken too long :P)


Kind regards,
Niklas

