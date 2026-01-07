Return-Path: <linux-pci+bounces-44186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B338CFDD44
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 14:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C97D30D5CB0
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 13:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AC13128CA;
	Wed,  7 Jan 2026 12:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZrpPSJP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8623231C9F;
	Wed,  7 Jan 2026 12:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767790377; cv=none; b=cLMmzqPWMmL+SessOfZN594UJ65PGh4SneYrJzUA90YB0Nz69keCf4M1bkB4VHWoFOkjOl53wt6V4TTjfJj6pS677fVrOWby2R2P5N7MXqbEs/voCuDXbKrGbyPsM4sGPBWQv3jdi49hZvpG6B8GHdcuxxoZKt+SzLUiLgANID0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767790377; c=relaxed/simple;
	bh=l/aXYjzgkQLxG4XeWrT77fM1m3iBRAiwCUesJ3zFM7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAwNvj8FV04AcmBclqRSET1P4JzdbEFpe9GhHf/52vX3yQ1MldvARXpGeP4pQH+P1iUZ8b5GQetwmt0Z1X3x68akKPsnmo7fVHhRGLBQGTMY3xdjVjCyh2HwLDVlokYAmHAZOnTUZeeUZEqT1T0qrSWiVSWiuZf2eQVZX4hEBAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZrpPSJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A858C4CEF7;
	Wed,  7 Jan 2026 12:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767790377;
	bh=l/aXYjzgkQLxG4XeWrT77fM1m3iBRAiwCUesJ3zFM7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CZrpPSJPcv0culqgGiUp2EGov7jPC+aT6oIja1QR4eLLT88X/rx1Z3ERr+Ggipm82
	 ZtY8aadhXHJsL0NNKYH+H6Il6ON5twS6Q1r6YM4hc/VH1PIBalK6FPUA1YxtCO7HY+
	 zdCtKgtdUAyFX3AuQuF7SAw8UlVDfkQhrER6gZh3M9HtTcEkBiQmQeRx8gJuwvxcss
	 wI7+km8IxOctKg6Q0GFRwzuUQr6flRRvVvfvQ092FTU/gFxCPJ6Yw+rSOciQyXNJER
	 CIkwyrF5REOav4xkUWX4XjPwrQlu0wjUzoLYBz1X3SUNKlx13xn8Oyz+U2IIERktHR
	 J6Frc/njotjcw==
Date: Wed, 7 Jan 2026 13:52:51 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com,
	Shawn Lin <shawn.lin@rock-chips.com>, dlemoal@kernel.org
Subject: Re: [PATCH v3 0/4] PCI: dwc: Rework the error handling of
 dw_pcie_wait_for_link() API
Message-ID: <aV5XI_e3npXHsxk7@ryzen>
References: <20251230-pci-dwc-suspend-rework-v3-0-40cd485714f5@oss.qualcomm.com>
 <aVezfq-8bTKczYkp@ryzen>
 <mrm7yif2tg7trvsof3jiqbevfldkf7ckkfswtabrnkc4dlgmae@qyp4s23utlid>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mrm7yif2tg7trvsof3jiqbevfldkf7ckkfswtabrnkc4dlgmae@qyp4s23utlid>

On Mon, Jan 05, 2026 at 05:11:42PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Jan 02, 2026 at 01:01:02PM +0100, Niklas Cassel wrote:
> > On Tue, Dec 30, 2025 at 08:37:31PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> 
> What could be happening here is that since the endpoint is physically connected
> to the bus, the receiver gets detected during Detect.Active state and LTSSM
> enters the Polling state. I think the reason why it ended up staying in
> Poll.Compliance could be due to (as per the spec):
> 
> a. Not all Lanes from the predetermined set of Lanes from above have
> detected an exit from Electrical Idle since entering Polling.Active.
> 
> b. Any Lane that detected a Receiver during Detect received eight consecutive
> TS1 Ordered Sets (or their complement) with the Lane and Link numbers set to
> PAD, the Compliance Receive bit (bit 4 of Symbol 5) is 1b, and the Loopback bit
> (bit 2 of Symbol 5) is 0b that the Compliance Receive bit (bit 4 of Symbol 5) is
> set.
> 
> So this is perfectly legal from endpoint perspective.
> 
> > Perhaps a Kconfig or module param? Suggestions?
> > 
> 
> There is a DIRECT_POLCOMP_TO_DETECT bit (bit 9) in DBI SD_CONTROL2 register.
> This bit will ensure that the LTSSM will not stuck in Poll.Compliance and will
> return back to Detect state. Could you set it on the EP before starting LTSSM
> and see if it helps?

I will test and get back to you.


Kind regards,
Niklas

