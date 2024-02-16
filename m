Return-Path: <linux-pci+bounces-3570-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5952685761F
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 07:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0191F252A2
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 06:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BEC14290;
	Fri, 16 Feb 2024 06:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5SkEpmS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42682134CE;
	Fri, 16 Feb 2024 06:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708066312; cv=none; b=TcSdWADhG7oEUIapLrrnxSPf+L/GiRMo/R6//X1DfkMIA87jJYes/VaK7w58iTdymDli8Ux7PIQWlhOA8M3TQ3Br85+Zs3o1y7B6DrRUHqtMKQEOO7OaDo2Rk6JloRqW/+Nq8YEX7iEM02DLFUwcD/OUpQw08D63/iMOq05yNr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708066312; c=relaxed/simple;
	bh=4OniHEQYYYMWlJOoq5xp/Wu7H+JX44MheQBlaOy9geY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZT/6dobgSWtbJRfICLJNCiSJd0o+5LyjkFJe3A3NFRbI6t+7Rxpg3zErjDYO2t1PIdev1kksyI3seDi7W6Q/PLD5BisYFFxUJwvgywuhSFm9HeNKBolYmDKoSa+ukePm0tJNGnSzIsgtziUBkIve3CG3jTQPB2ONFuk9on+RnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5SkEpmS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF1CC433F1;
	Fri, 16 Feb 2024 06:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708066311;
	bh=4OniHEQYYYMWlJOoq5xp/Wu7H+JX44MheQBlaOy9geY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r5SkEpmSkvHJjtN0pXMbqeQbvvLOZWiU6SX10TYjnAR4E0d137coRNoroy0bgvjoo
	 K7qXj04Hf7rVExj1f9qFr/2n7yop6TZcl5/hETHQV6bXWBpz+09ubCKwC4a8TKhh00
	 4+Kg5Qqbd7h7a8mRkO0AChYmogH80Sh604QF06SbvTXJUpPZb0iSLv7vClO2s7piM9
	 vMfcVvPZKEG1DL37nZarqDAlrZen0pRqY186KK2pt9xkQs8Vz6kIDLc5tDBceNv4ir
	 YOjMg+/rLkvr5A3nc7XnQBQjHYTfNWAHw3CnYNp3kPvfk1syeqx1QCEFhJDwuhjQ7a
	 WYIfakEiaWQpg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1ras50-000000004Cl-2tMr;
	Fri, 16 Feb 2024 07:52:15 +0100
Date: Fri, 16 Feb 2024 07:52:14 +0100
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v2 2/3] PCI: qcom: Read back PARF_LTSSM register
Message-ID: <Zc8GHrgdF7jJBgyu@hovoldconsulting.com>
References: <20240215161114.GA1292081@bhelgaas>
 <bc7d9859-f7ec-41c5-8a9e-170ccdfff46a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc7d9859-f7ec-41c5-8a9e-170ccdfff46a@linaro.org>

On Thu, Feb 15, 2024 at 07:44:27PM +0100, Konrad Dybcio wrote:
> On 15.02.2024 17:11, Bjorn Helgaas wrote:
> > On Thu, Feb 15, 2024 at 11:21:45AM +0100, Konrad Dybcio wrote:
> >> On 14.02.2024 23:28, Bjorn Helgaas wrote:
> >>> On Wed, Feb 14, 2024 at 10:35:16PM +0100, Konrad Dybcio wrote:
> >>>> On 12.02.2024 22:17, Bjorn Helgaas wrote:
> >>>>> Maybe include the reason in the subject?  "Read back" is literally
> >>>>> what the diff says.
> >>>>>
> >>>>> On Sat, Feb 10, 2024 at 06:10:06PM +0100, Konrad Dybcio wrote:
> >>>>>> To ensure write completion, read the PARF_LTSSM register after setting
> >>>>>> the LTSSM enable bit before polling for "link up".
> >>>>>
> >>>>> The write will obviously complete *some* time; I assume the point is
> >>>>> that it's important for it to complete before some other event, and it
> >>>>> would be nice to know why that's important.
> >>>>
> >>>> Right, that's very much meaningful on non-total-store-ordering
> >>>> architectures, like arm64, where the CPU receives a store instruction,
> >>>> but that does not necessarily impact the memory/MMIO state immediately.
> >>>
> >>> I was hinting that maybe we could say what the other event is, or what
> >>> problem this solves?  E.g., maybe it's as simple as "there's no point
> >>> in polling for link up until after the PARF_LTSSM store completes."
> >>>
> >>> But while the read of PARF_LTSSM might reduce the number of "is the
> >>> link up" polls, it probably wouldn't speed anything up otherwise, so I
> >>> suspect there's an actual functional reason for this patch, and that's
> >>> what I'm getting at.
> >>
> >> So, the register containing the "enable switch" (PARF_LTSSM) can (due
> >> to the armv8 memory model) be "written" but not "change the value of
> >> memory/mmio from the perspective of other (non-CPU) memory-readers
> >> (such as the MMIO-mapped PCI controller itself)".
> >>
> >> In that case, the CPU will happily continue calling qcom_pcie_link_up()
> >> in a loop, waiting for the PCIe controller to bring the link up, however
> >> the PCIE controller may have never received the PARF_LTSSM "enable link"
> >> write by the time we decide to time out on checking the link status.

This makes no sense. As Bjorn already said, you're just polling for the
link to come up (for a second). And unless you have something else that
depends on the write to have reached the device, there is no need to
read it back. It's not going to be cached indefinitely if that's what
you fear.

> Generally, it's a good idea to add such readbacks after all timing-
> critical writes, especially when they concern asserting reset,
> enabling/disabling power, etc., to make sure we're not assuming the
> hardware state of a peripheral has changed before we ask it to do so. 

Again no, there is no general need to do that. It all depends on what
the code does and how the device works.

Johan

