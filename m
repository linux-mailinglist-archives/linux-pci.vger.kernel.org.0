Return-Path: <linux-pci+bounces-7929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2568D249A
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 21:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6686628B793
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 19:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1C0171E49;
	Tue, 28 May 2024 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWunVjVa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A53B171679;
	Tue, 28 May 2024 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716924581; cv=none; b=kRMyxRmrFtf/xRyd7NwFYptyGpiREwhtX1AFzFZCGC5tGFCqCUEbxo/QHEE0a6iu8TMj5uEQzzM/7+QdW+P5BaM2LYHRvG6MEYzs/rwJyDfdozH8kw8ARQNOQF4FXh2q7fwj2zdAKtlxGcvRnfsX/jkfnpFfXe3/pu9ILvH7isU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716924581; c=relaxed/simple;
	bh=Kwt6etvMVjtgUaPiijw3zPlQdj7waZdvWPWf+Kny3Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dTiRa/IhSk4J6zHFBkOpx0TW5jz/nRoxbPGvP8czea2MsjsWaF0eBkiuWg1yavuyhvOdvvzAmGPJVEV/n6yrjyg7OXXnxpLzmuqy+IcDp8mFPwMX6wbsbyeUAoBURZbRo34S1N3+QhkYE8t3a424cViXR1tUCYaWAUZuQRSSV9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWunVjVa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92877C32781;
	Tue, 28 May 2024 19:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716924580;
	bh=Kwt6etvMVjtgUaPiijw3zPlQdj7waZdvWPWf+Kny3Pc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nWunVjVageoV1ic3+TmdrTLcKJSn4vdX8fpd69lrmV+7hHSlAiZUtYYSNY+kyWVV7
	 GokpIHX4LD8NfrvGi5O9lOHLj8VBaxm5ZES3fdjpdtozxo1B8KDJlHrdniNz1SFUBY
	 O+BNCyXQ+6QUnnZxQU+h96r1vxvAfJclNASpLE+6hytW4qSvjIB2Y54RpVcB6pbw3r
	 vSbPzz9Bi7RmK5eRP8gwE1ufzcs0kUASS9WlunI2LIHDnim9tdEOsxo5JsqaNfHpEi
	 U7PGw6V6qziIxn9EVIAwkZu667Y7hKOM0UgzrCI6YObR6fz6LnhRZl8Isui/7wO8En
	 2A3Q+T1g+IEGw==
Date: Tue, 28 May 2024 14:29:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 0/3] Make pci/endpoint branch buildgg
Message-ID: <20240528192938.GA458848@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlYpAGFgwgxnnBhZ@ryzen.lan>

On Tue, May 28, 2024 at 08:57:04PM +0200, Niklas Cassel wrote:
> On Tue, May 28, 2024 at 09:44:52AM -0500, Bjorn Helgaas wrote:
> > On Tue, May 28, 2024 at 03:00:36PM +0200, Niklas Cassel wrote:
> > > The pci/next branch has currently not merged the latest pci/endpoint
> > > branch.
> > > 
> > > Perhaps this delay in creating a new pci/next branch is because the
> > > pci/endpoint branch currently fails to build.
> > 
> > The topic branches have things queued on them for build testing, but
> > they haven't been merged to pci/next yet.  It's standard practice that
> > we don't add v6.11 content to -next until v6.10-rc1 is tagged:
> > https://lore.kernel.org/linux-next/20240523111023.7ade2aa4@canb.auug.org.au/
> > 
> > v6.10-rc1 was tagged 5/26, and 5/27 was a US holiday.  The topic
> > branches will be merged to pci/next today.
> 
> Ok, great!
> 
> Although, perhaps you would want to defer merging pci/endpoint to pci/next
> until the linker error has been fixed.
> 
> We have already gotten a bunch of reports of this on the linux-pci list:
> https://lore.kernel.org/linux-pci/202405270544.yKgcokbA-lkp@intel.com/T/#u
> https://lore.kernel.org/linux-pci/202405130815.BwBrIepL-lkp@intel.com/T/#u
> https://lore.kernel.org/linux-pci/202405140344.glj9WfzM-lkp@intel.com/T/#u
> 
> Merging the branch to pci/next is guaranteed to have even move people hit
> and complain about this error.

I included pci/endpoint but dropped the "PCI: endpoint: Introduce
'epc_deinit' event and notify the EPF drivers" patch until we fix that
issue.

Bjorn

