Return-Path: <linux-pci+bounces-32631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6B7B0BFC5
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 11:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B07037A712D
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 09:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F5D1CAA6D;
	Mon, 21 Jul 2025 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZlIBiSZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6B61A3155;
	Mon, 21 Jul 2025 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753089361; cv=none; b=qoAxA2mC+BfFj0TM3oiISjPrmqSaN1KqUTpltWrSFLsa5ZTPxn1/2AZ4J0ceNvHn8lkbhYUQ6f+nePoRrPI0JVhGOMtGj39T4f2TrXDteRwS0x5vymo63PGnzUyseGtpdxUtLcjyEzPHO3R9LSCoao57yYMJBCtr7emcJy9s/aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753089361; c=relaxed/simple;
	bh=iw+0frTPEpJ/43nXvIJZK8kcvyxLrqS32VG0riYHUn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iqc7BW1WCKHp8AMyqscCDRMplNShdhm6Fsow+RhtG05Mb0z5odX/rNQWQYlGLZKNz1BaNHuG3ROVyL0HTUAZ8/PPnERGVWXAnCdZS4MteG0wyIwCoN8P0HsekIyXIqTCXBBH7JXfrbttGJV2qd2VAkOa3zHlbVp2fo8e870CnR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZlIBiSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E112BC4CEED;
	Mon, 21 Jul 2025 09:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753089360;
	bh=iw+0frTPEpJ/43nXvIJZK8kcvyxLrqS32VG0riYHUn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bZlIBiSZ2HtXzsW9X0Tia1nwaoLNlkqpvbSywwBNERzDhElrlLM1PnFZbdNahNKXM
	 UjA3pA4saAMITJwX1dbuWPcJ+CwgVt6zuZ25sFSOJpV/C6JJmz5b+wukoyTEJ8tf8n
	 dcXBLrXY6NFKofAqZYlTrKRV1IRbN5NX/4J+ZaekEViX9lFwIWL0i4OYzrF5shDFa+
	 7FoypM41Z2+0Eb7XlGasN7IsleLqFMzpkPQ0Bii8FTPcFoaYN9pVujTllpGfxO4II4
	 Min7xH2FbnACW/lhRiRCafVqSD8A3a1U+imUN3VPV/WxIuU3uymWvfVWnrDVptEh4J
	 CfBdLghbOF9jg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1udmce-000000000P8-2R1J;
	Mon, 21 Jul 2025 11:15:49 +0200
Date: Mon, 21 Jul 2025 11:15:48 +0200
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] PCI: qcom: Move qcom_pcie_icc_opp_update() to
 notifier callback
Message-ID: <aH4FRGIq0oCLMQqB@hovoldconsulting.com>
References: <20250714-aspm_fix-v1-0-7d04b8c140c8@oss.qualcomm.com>
 <20250714-aspm_fix-v1-2-7d04b8c140c8@oss.qualcomm.com>
 <b2f4be6c-93d9-430b-974d-8df5f3c3b336@oss.qualcomm.com>
 <jdnjyvw2kkos44unooy5ooix3yn2644r4yvtmekoyk2uozjvo5@atigu3wjikss>
 <55f2e014-044c-4021-8b01-99bdf2a0fd7f@oss.qualcomm.com>
 <kyu4bpuqvmc3iyqekmqvbpxqpbbxbq7df725dcpiu3dnvcztyy@yyqwm2uqjobj>
 <e0553625-2864-4d9e-89ef-fab44fb18be4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0553625-2864-4d9e-89ef-fab44fb18be4@oss.qualcomm.com>

On Wed, Jul 16, 2025 at 12:33:48PM +0200, Konrad Dybcio wrote:
> On 7/16/25 7:28 AM, Manivannan Sadhasivam wrote:
> > On Tue, Jul 15, 2025 at 12:45:36PM GMT, Konrad Dybcio wrote:
> >> On 7/15/25 12:36 PM, Manivannan Sadhasivam wrote:
> >>> On Tue, Jul 15, 2025 at 11:54:48AM GMT, Konrad Dybcio wrote:
> >>>> On 7/14/25 8:01 PM, Manivannan Sadhasivam wrote:
> >>>>> It allows us to group all the settings that need to be done when a PCI
> >>>>> device is attached to the bus in a single place.
> >>>>>
> >>>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> >>>>> ---
> 
> [...]
> 
> >>> Let me think of other ways to call these two APIs during the device addition. If
> >>> there are no sane ways, I'll drop *this* patch.
> >>
> >> Would it be too naive to assume BUS_NOTIFY_ADD_DEVICE is a good fit?
> > 
> > BUS_NOTIFY_ADD_DEVICE is not currently a good fit as ASPM link state
> > initialization happen after all the devices are enumerated for the slot. This is
> > something to be fixed in the PCI core and would allow us to use
> > BUS_NOTIFY_ADD_DEVICE.
> > 
> > I talked to Bjorn H and we both agreed that this needs to be revisited. But I'm
> > just worrried that until this happens, we cannot upstream the ASPM fix and not
> > even backport it to 6.16/16.
> > 
> > So maybe we need to resort to this patch as an interim fix if everyone agrees.
> 
> I'm not opposed if there's going to be an improved solution next cycle.
> Having ASPM 99.9% of the time is much better than not having it at all

This has been broken since 6.15 (not 6.13 as the commit message of patch
1/2 suggests) so there's no rush to get it sorted in 6.16.

The current approach also works for everything but devices using pwrctrl
(read: anything but ath11k/ath12k).

It seems like adding an enable_device() callback can be used as minimal,
backportable fix for the ath11k/ath12k regression on Qualcomm platforms,
while working on something more general (e.g. also handling the OPPs) if
that turns out to be more invasive.

Johan

