Return-Path: <linux-pci+bounces-13889-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E02A991E32
	for <lists+linux-pci@lfdr.de>; Sun,  6 Oct 2024 13:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8191C20A9F
	for <lists+linux-pci@lfdr.de>; Sun,  6 Oct 2024 11:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEB016191B;
	Sun,  6 Oct 2024 11:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuUV/pZh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89434EC5
	for <linux-pci@vger.kernel.org>; Sun,  6 Oct 2024 11:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728215290; cv=none; b=fEu64eKbo2z5ssl/E660MFo6hipwdy+S23KXHeyiBWUMDaCsWPM6Ez5kTumtzwQwy9tj26Kdu0ByFcZi1kWQsXh+ilM6c2NybI7nf0GbEgo7kGFj8B4hoRlfE4S9/84gILM0Vo+Mpm9uRrOXswxNLquyolNe4l1DDMIPNFkfMzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728215290; c=relaxed/simple;
	bh=Zw7TEIe6kqrLZ2zCO3KR28WOp0C+IKtWsiFpVZ0It2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlEpj0jzczTsz3RGKacvE0yfOHiviLfjRr5D5RRGEWl3IOcz0KBMH5GA73zUc0Z7PM7ieTGeoKbYV+hM/YBo/03iqXeMYpUygwQZRTn5J5b8b/CWbTMcgEF0Xr828l6GmJqCp1CsK4snji+21gEm/FBfgMQ40qktYDxgBZ+xEEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuUV/pZh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B4FC4CEC5;
	Sun,  6 Oct 2024 11:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728215290;
	bh=Zw7TEIe6kqrLZ2zCO3KR28WOp0C+IKtWsiFpVZ0It2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PuUV/pZhQrW0eoRxcNwHbAVEsYqWXpQrFKLPINjnm260BMf5y02QLSnbXVzdMMePa
	 sYwaCaCSTuIZYMNVxFvHCfhwF0elS5cgbuPpX8zJO045AFeeD9s5P9VaVy7x+zk7vX
	 Sv9IHpzp/G3/PjNwveaGs3znMc10SgDao6AWhs56wrtsEX4XqkqpGhQTTShH0NbvhN
	 GQeYbzed5wSoF6/TpqGUZahB2fvEBJKCrOOkFHdMRye42ZbjfQAjX6W4el2gl/Xlmo
	 pcnEzAIiIj7dY2cb0Zzg83TZJIULWfFsJXJQ7YG9PLmqLaeoroFHSRgibdijt3eyN2
	 FsH/onOw8sNyQ==
Date: Sun, 6 Oct 2024 13:48:04 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: [PATCH v3 6/7] PCI: endpoint: test: Use pci_epc_mem_map/unmap()
Message-ID: <ZwJ49NkwhKpeuwKa@ryzen.lan>
References: <20241004050742.140664-1-dlemoal@kernel.org>
 <20241004050742.140664-7-dlemoal@kernel.org>
 <Zv_bdtrQFSDulOkA@ryzen.lan>
 <a3c93ede-adc8-4f4d-9da1-da8241ddeffc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3c93ede-adc8-4f4d-9da1-da8241ddeffc@kernel.org>

On Fri, Oct 04, 2024 at 10:47:01PM +0900, Damien Le Moal wrote:
> On 10/4/24 21:11, Niklas Cassel wrote:

(snip)

> > I think that you need to also include the patch that implements map_align()
> > for rk3399 in this series (without any other rk3399 patches), such that the
> > API actually makes sense.
> 
> This is coming in a followup series. Note that the Cadence controller also look
> suspiciously similar to the rk3399, so it may need the same treatment.

I strongly think that you should continue to include patch:
"PCI: rockchip-ep: Implement the map_align endpoint controller operation"
(that was part of your V2) in this series.

(Just do not include any of the other random fixes for rockchip-ep that
were part of your V2.)

Because without an implementer of the API that can actually return a size
smaller than requested, the current API makes no sense.

We do send out a series that provides a complex API if there is no implementer
(in that same series) which require the complexity. The single implementer in
this series (DWC PCIe EP), does not require the complexity of the API.

(The reason for this is that it is possible (for whatever reason) that the
intended follow up series which adds an implementer which actually requires
this complex API, may never materialize/land, and in that case we are left
with technical debt/an overcomplicated API for no reason.)


> As for the need for the loop, let's not kid ourselves here: it was already
> needed because some controllers have limited window sizes and do not allow
> allocating large chunks of memory to map. That was never handled...

I agree.

For controllers which have a window size that is very small, the pci-epf-test
driver will currently not handle buffer sizes larger than the window size.
Adding a loop would solve that limitation.

But this information is currently completely missing for the commit log.

May I suggest that you:
1) Include a preparatory patch in this series, which adds the loop using the
   existing map functions. With the proper motivation in the commit log.
2) Add this patch which converts the pci-epf-test driver to use the new map
   API. The number of changed lines in this patch will thus be much smaller
   than it currently is, and it will be easier to review.


> > I understand that certain EPF drivers will need to map buffers larger
> > than that. But perhaps we can keep pci-epf-test.c simple, and introduce
> > the more complex logic in EPF drivers that actually need it?
> 
> But then it would not be much of test driver... We need to exercise corner cases
> as well.

Yes, your argument does make a lot of sense.


> > More complicated EPF drivers can then choose if they want to support only
> > the simple case (no looping case), but can also choose to support buffers
> > larger than pci_epc_max_mapping_for_address(), using looping (I assume that
> > each loop iteration will be able to map (at least) the same amount as the
> > first loop iteration).
> 
> How can they "choose" if the controller being used gives you a max mapping size
> that completely depend on the PCI address used by the RC ? Unless the protocol
> used by that function driver imposes constraint on the host on buffer alignment,
> the epf cannot choose anything here. E.g. NVMe epf needs to be able to handle
> anything.

What I meant was that PCI EPF drivers could simply (continue) to return error
if the buffer size was larger than the window size. But you have successfully
changed my mind, let's just add the loop.

(As my previous suggestion of letting an EPF driver call
pci_epc_max_mapping_for_address()/pci_epc_map_align(), and then based on if
the returned size being either smaller or larger than the window size, call
either a function that does no looping, or a function that does looping, might
actually be more error prone and more confusing compared to just having a
single transfer function which includes a loop.)


Kind regards,
Niklas

