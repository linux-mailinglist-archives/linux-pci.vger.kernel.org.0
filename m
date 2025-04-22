Return-Path: <linux-pci+bounces-26393-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D111A96909
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 14:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A489217CAFA
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 12:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA5427CB15;
	Tue, 22 Apr 2025 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/m/uQvR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7821FDA94;
	Tue, 22 Apr 2025 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324662; cv=none; b=f7DoVa4/PMYvHPsl9+i5A4rNaGaL1V5W7sG6/Qg1InVGxEgrs0PMFOrriaDDwFTE+Dh7Jb4rGQv94TSweDJiQEDFg8JosrG0wVnGiF+tgmpTEt7gZZr9vcgf6mMWw8BuDwji2kIfyRfEztNAYot6Z7P2vUCcZpbxCCTohx6+HZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324662; c=relaxed/simple;
	bh=6lAJVPvmo2XgWRsTDsBUFYz7y/erMMDcUT4+f0mJuRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RV4HD/5vOTZWyoOQZ9FfWAjGeo7KNec+IFUQ5qHst7r6E0zZyWQZAtLrTHPLIuRYAHc0IsCYkrN/G9gXunxvxpIZyYKgdDKEUx1EsKKQ3r56Nt76W07QTusgdun5wsegKwNXUFRO1sMBooJWvQ7upB/IliZ2g0L9gP3fwC2uozI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/m/uQvR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D802C4CEE9;
	Tue, 22 Apr 2025 12:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745324661;
	bh=6lAJVPvmo2XgWRsTDsBUFYz7y/erMMDcUT4+f0mJuRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r/m/uQvRqVetV4Wbr86FwQTCQCXiFVajeQr/1G7gINX+6c4hqaBo3jYN9hsvFg2Yi
	 Lry3kUT+H4E4quTSiaXZWQfcyjfBfEOULifEGrQIUkNYovEpD39EomESvEih2na2Ju
	 dEH9il/JO71ioD/9QZYKvISd2R+at9e4sVIoIpZvc7/CSnFdrHebzeP2X7/VcYTqm0
	 lQ46+RhSwOQ7bLN1w75FLKBFIwp/wgv4FPfCrEaCxleY23ZPvNF9xo4IiHuL91OuQw
	 2o5WOfuw1AlT8Sunjnk5Ir4ltfK22LUqJJTNtZ2tGLJoWsySvNQntcbO7LqaMunQUM
	 GFvhCTW/eUh6Q==
Date: Tue, 22 Apr 2025 14:24:16 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	heiko@sntech.de, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	jingoohan1@gmail.com, shawn.lin@rock-chips.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 3/3] PCI: dw-rockchip: Unify link status checks with
 FIELD_GET
Message-ID: <aAeKcEfyDS1ImynJ@ryzen>
References: <20250422112830.204374-1-18255117159@163.com>
 <20250422112830.204374-4-18255117159@163.com>
 <aAeAAhb4R8ya_mBO@ryzen>
 <7716b76f-be79-4ed1-b8d2-29258cb250ab@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7716b76f-be79-4ed1-b8d2-29258cb250ab@163.com>

On Tue, Apr 22, 2025 at 07:50:50PM +0800, Hans Zhang wrote:
> 
> 
> On 2025/4/22 19:39, Niklas Cassel wrote:
> > On Tue, Apr 22, 2025 at 07:28:30PM +0800, Hans Zhang wrote:
> > > Link-up detection manually checked PCIE_LINKUP bits across RC/EP modes,
> > > leading to code duplication. Centralize the logic using FIELD_GET. This
> > > removes redundancy and abstracts hardware-specific bit masking, ensuring
> > > consistent link state handling.
> > > 
> > > Signed-off-by: Hans Zhang <18255117159@163.com>
> > > ---
> > >   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 15 +++++----------
> > >   1 file changed, 5 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > index cdc8afc6cfc1..2b26060af5c2 100644
> > > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > @@ -196,10 +196,7 @@ static int rockchip_pcie_link_up(struct dw_pcie *pci)
> > >   	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> > >   	u32 val = rockchip_pcie_get_ltssm(rockchip);
> > > -	if ((val & PCIE_LINKUP) == PCIE_LINKUP)
> > > -		return 1;
> > > -
> > > -	return 0;
> > > +	return FIELD_GET(PCIE_LINKUP_MASK, val) == 3;
> > 
> > While I like the idea of your patch, here you are replacing something that
> > is easy to read (PCIE_LINKUP) with a magic value, which IMO is a step in
> > the wrong direction.
> > 
> 
> Hi Niklas,
> 
> Thank you very much for your reply. How about I add another macro
> definition?
> 
> #define PCIE_LINKUP 3

Yes, adding another macro for it is what I meant.


Kind regards,
Niklas

