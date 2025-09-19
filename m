Return-Path: <linux-pci+bounces-36466-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89381B88686
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 10:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DC7A567AEC
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 08:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759C02F28EB;
	Fri, 19 Sep 2025 08:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jc1G9Gh9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438342C0266;
	Fri, 19 Sep 2025 08:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270363; cv=none; b=n9EiiVDb6U33JqyL9j8ZOH+rxnWN7GXhAzNO+f4WbASpXSeIefxJOUJB4ZpknOmM/O13Cs4D1ObSOTB/cDLW1bT8/do/pCBorKmfr3XYqNTzPU8sqkmWR/09EmRkCM013cDLzzgmHBfMqO0w9P7PdIbcdHqdAaAYQ5u1PPJK8MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270363; c=relaxed/simple;
	bh=94XJgyA9heUKGaNQHHvoXRU6/+9lv/JiUASGkCrs2sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ha55g/yffvKboLLFc/9TsHsjulT4dWKGqvlUb3k/aQxk8BmaqJ4G+3fjkl2HHbRTvW3TQ4runzLVcD8ruarJaXm9x3rrO526AbmxiUYrLaR2fwGs37vmXAF2oRVk9c0jut9ftdsTrE4PLOsR+B0CflWkyEulNsBb8XM1DRq4cMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jc1G9Gh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8886BC4CEF0;
	Fri, 19 Sep 2025 08:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758270362;
	bh=94XJgyA9heUKGaNQHHvoXRU6/+9lv/JiUASGkCrs2sA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jc1G9Gh9G9MUDfv02eB8f66vHm/pTD3oBEghnT8jfZnaSBfuYevs9E1aFWZSQIgz4
	 Oei6unoME5dYatMYUzkhwTYB91ailhf/tFZw+YwTUbGsd/TkO8y0YdHvS1n/oMxHi7
	 15fiMqI4Ix0oxHgqjkywhSBLV0BOqvGNvpMPIN+whapbnJBtmFX8lbdm4tfSj6L11a
	 KlKrpc0yl4Nh2/YJDxb+H5RyCAV3aTZWK7IURNwW7XOXHw3j+EWNgVnPHUMdKrlzdo
	 G0DDBXLcPKPUZxZmSWqafP0T3SoTaDnR2SH62qsLrpalJMvAwOkc5p1oKeB4WNcKfO
	 c7Q5E43MopcMw==
Date: Fri, 19 Sep 2025 13:55:53 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, bhelgaas@google.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, magnus.damm@gmail.com, p.zabel@pengutronix.de, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v4 4/6] arm64: dts: renesas: rzg3s-smarc-som: Update
 dma-ranges for PCIe
Message-ID: <lunqwki2orbf5gjyo4a5kz6ko3rs5w6fspbantqcv7b2vxe5ku@734remr6z4lp>
References: <20250912122444.3870284-1-claudiu.beznea.uj@bp.renesas.com>
 <20250912122444.3870284-5-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdWP638eB_p9xMAqZmOnuc6n7=n31h6AqV+287uvqQEdww@mail.gmail.com>
 <c2fc5f6b-0e7c-464e-89a6-35dc76177d18@tuxon.dev>
 <CAMuHMdWeHoUe-=7TDetnDQbLQsKGf4pDGpSdz3xEVLs_Rst9qQ@mail.gmail.com>
 <0a20c765-ff72-4c03-af84-dff3f4850fa4@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a20c765-ff72-4c03-af84-dff3f4850fa4@tuxon.dev>

On Fri, Sep 19, 2025 at 10:38:52AM +0300, Claudiu Beznea wrote:
> Hi, Geert,
> 
> On 9/18/25 13:00, Geert Uytterhoeven wrote:
> > Hi Claudiu,
> > 
> > On Thu, 18 Sept 2025 at 11:47, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> >> On 9/18/25 12:09, Geert Uytterhoeven wrote:
> >>> On Fri, 12 Sept 2025 at 14:24, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> >>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>>>
> >>>> The first 128MB of memory is reserved on this board for secure area.
> >>>> Secure area is a RAM region used by firmware. The rzg3s-smarc-som.dtsi
> >>>> memory node (memory@48000000) excludes the secure area.
> >>>> Update the PCIe dma-ranges property to reflect this.
> >>>>
> >>>> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>>
> >>> Thanks for your patch!
> >>>
> >>>> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> >>>> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> >>>> @@ -214,6 +214,16 @@ &sdhi2 {
> >>>>  };
> >>>>  #endif
> >>>>
> >>>> +&pcie {
> >>>> +       /* First 128MB is reserved for secure area. */
> >>>
> >>> Do you really have to take that into account here?  I believe that
> >>> 128 MiB region will never be used anyway, as it is excluded from the
> >>> memory map (see memory@48000000).
> >>>
> >>>> +       dma-ranges = <0x42000000 0 0x48000000 0 0x48000000 0x0 0x38000000>;
> >>>
> >>> Hence shouldn't you add
> >>>
> >>>     dma-ranges = <0x42000000 0 0x48000000 0 0x48000000 0x0 0x38000000>;
> > 
> > Oops, I really meant (forgot to edit after copying it):
> > 
> >     dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0x0 0x40000000>;
> > 
> >>>
> >>> to the pcie node in arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi
> >>> instead, like is done for all other Renesas SoCs that have PCIe?
> >>
> >> I chose to add it here as the rzg3s-smarc-som.dtsi is the one that defines
> >> the available memory for board, as the available memory is something board
> >> dependent.
> > 
> > But IMHO it is independent from the amount of memory on the board.
> > On other SoCs, it has a comment:
> > 
> >      /* Map all possible DDR as inbound ranges */
> > 
> >>
> >> If you consider it is better to have it in the SoC file, please let me know.
> > 
> > Hence yes please.
> > 
> > However, I missed you already have:
> > 
> >     /* Map all possible DRAM ranges (4 GB). */
> >     dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0x1 0x0>;
> > 
> > in r9a08g045.dtsi, so life's good.
> > 
> > +
> >>>> +};
> >>>> +
> >>>> +&pcie_port0 {
> >>>> +       clocks = <&versa3 5>;
> >>>> +       clock-names = "ref";
> >>>> +};
> >>>
> >>> This is not related.
> >>
> >> Ah, right! Could you please let me know if you prefer to have another patch
> >> or to update the patch description?
> > 
> > Given the dma-ranges changes is IMHO not needed,
> 
> I kept it here as the driver configures the PCIe registers for the inbound
> windows with the values passed though the dma-ranges. This is done through
> rzg3s_pcie_set_inbound_windows() -> rzg3s_pcie_set_inbound_window(). The
> controller will be aware that the secure area zone is something valid to
> work with. In that case, if my understanding of PCIe windows is right, I
> added this in the idea that an endpoint (a malicious one?) could DMA
> into/from secure area if we don't exclude it here?
> 

That's true. But do you really have an usecase to setup inbound window for the
endpoints? What does the endpoint do with this memory?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

