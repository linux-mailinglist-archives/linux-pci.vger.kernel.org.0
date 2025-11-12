Return-Path: <linux-pci+bounces-40967-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF59C5125A
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 09:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 64C4434CEBE
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 08:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530022F4A0A;
	Wed, 12 Nov 2025 08:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvaW3kwl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2F32874F1;
	Wed, 12 Nov 2025 08:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762936813; cv=none; b=GAonX9iOAKAjDp2mrtGA+re6m/AFOyRbXGVEYsXUbP00omAzrks7DpOe8HzBLDSjL20yjCEmLzE1l62GEw1qddZ3R8NHvQCpoodYlfWxiW4xzuWFqy+9XQCzJoxq57ZKERtIZMk29b2wwZyzikj12OsJk3eBh3YzCw9ZIrX8FyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762936813; c=relaxed/simple;
	bh=24AR814wLA55Qc7z3MU0tNwo9drr/C1xImdNGy5q2O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+3c2+fKHl4aCoyV23ZIAejIO5TDbhdiu9FpnMjpQkQbLappwbUdcrLUWvmTzVNqOf4Wjhmudb4t2/CE+QTbcN6+uWzxQloGCg1mIVTxrC5kMjlBOiMC0aQltDDtd7aHYihN/hjK93lpNPRcklHZZq8iHDiUWNPt1bUhPPTztaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvaW3kwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F370CC19421;
	Wed, 12 Nov 2025 08:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762936812;
	bh=24AR814wLA55Qc7z3MU0tNwo9drr/C1xImdNGy5q2O0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UvaW3kwlNSnW6HuOEIaJ/EsL2sNWRr/khWI8ueFg+45xLnNr6VEwJKymoqQcdxYcb
	 NsrjK5c9QT0AJOITRlsKoSbw18w5uVEUKGPXCprJZylbKbkMPMHptIGkY/ru10J8o4
	 AiogQZmLOHr0aOrDBK7NErbcj0SPg+I0w/rL/3ppYId+x0lIqyJPipebEW/xFYlWoI
	 v9BKwVOWhQt1k6y8Eu1joGAUX28fQkfz3uNK4V3sHJpVJXL5fQuC3nB2WtfbVqt248
	 gKp2uhiU1xgu7T6lyq8ayY/7rMCOkP8JMRq1cWbQcheQxa6WP+YYcPeOg9+ikgHm/Q
	 QgqAGbyUxTCJA==
Date: Wed, 12 Nov 2025 09:40:06 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, Damien Le Moal <dlemoal@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki <naoki@radxa.com>,
	Diederik de Haas <diederik@cknow-tech.com>, stable@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3] PCI: dw-rockchip: Prevent advertising L1 Substates
 support
Message-ID: <aRRH5i2oq1FBSs_7@ryzen>
References: <aRM1VOodnSpaob3P@ryzen>
 <20251111214336.GA2190667@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111214336.GA2190667@bhelgaas>

On Tue, Nov 11, 2025 at 03:43:36PM -0600, Bjorn Helgaas wrote:
> On Tue, Nov 11, 2025 at 02:08:36PM +0100, Niklas Cassel wrote:
> > On Tue, Oct 21, 2025 at 08:05:17AM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, 17 Oct 2025 18:32:53 +0200, Niklas Cassel wrote:
> > > > The L1 substates support requires additional steps to work, namely:
> > > > -Proper handling of the CLKREQ# sideband signal. (It is mostly handled by
> > > >  hardware, but software still needs to set the clkreq fields in the
> > > >  PCIE_CLIENT_POWER_CON register to match the hardware implementation.)
> > > > -Program the frequency of the aux clock into the
> > > >  DSP_PCIE_PL_AUX_CLK_FREQ_OFF register. (During L1 substates the core_clk
> > > >  is turned off and the aux_clk is used instead.)
> > > > 
> > > > [...]
> > > 
> > > Applied, thanks!
> > > 
> > > [1/1] PCI: dw-rockchip: Prevent advertising L1 Substates support
> > >       commit: 40331c63e7901a2cc75ce6b5d24d50601efb833d
> > 
> > Last update in this thread was "Applied, thanks!"
> >
> > and the patch was applied to pci/controller/dw-rockchip
> > 
> > since then it seems to have been demoted to
> > pci/controller/dw-rockchip-pend
> 
> That was Oct 20, and we had some conversation about a more generic
> approach after that, so I moved it to dw-rockchip-pend while we worked
> that out.
> 
> I fleshed it out the generic approach and will post it soon.

Ok, thank you!


Kind regards,
Niklas

