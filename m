Return-Path: <linux-pci+bounces-3532-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C468485694B
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 17:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624311F265B4
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 16:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE92134730;
	Thu, 15 Feb 2024 16:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWbFqy/D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E686D134726;
	Thu, 15 Feb 2024 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013477; cv=none; b=d802kP1J25BQfiDMyoX4MVFtCvdqBh6jf5Zmj0Mj9SaQWVsJu8E1BF5ofxFuOOi4xyM4bjE/Zity8Kd5qJ4OYB7soB7BUQ2XMf1Emixo4V77i+g3mBTjEeZtnuDuWaw5BpTCr7i4TgMhZqSIpLqlsC4832vMHt/i/hd0wjAdjr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013477; c=relaxed/simple;
	bh=Vyz7IOzA7aW6XCnyElzhzRzZbzPNLX4vzNsg70hxADU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mHGG3iimXpbx9nOg5Eze/dMyEWaPw2w+RVtUipCaEndVZv2M8cY9k5CoOim+23EwHGPg2Yxj3+4tQZ2Lwr05BreDBtSjdVTAxo/yjOPGj4NC7zwlR28vw++RM6p5yfuZLWCXEup8zvOnjMrrqXLvjg4NbYTDeXE5hds28x9yp1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWbFqy/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78264C433F1;
	Thu, 15 Feb 2024 16:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708013476;
	bh=Vyz7IOzA7aW6XCnyElzhzRzZbzPNLX4vzNsg70hxADU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aWbFqy/D3RnbyH3500/cXNNqMzmiwGjw6LQ3lpdWgGZveLcZg11qlfPRX7VOV1yBP
	 14MlTw0KxRzs3A5nXExZ6o40P5c3h6l1d8SCyoFGyXFFmdf1EEllel0mtQ8j6UNmn0
	 JoJgR8bMzfGw+x5dP7/Xk9WvzTEfgp5jtpu4LoX3HMnSJvcAJWkDtES+slim97yBz7
	 d0BZAaCQLFAQhb/WLhSba04eJt+2XcI/4Erj7S/fe4E0eqEqs/rpIAPeLukD3cK9d0
	 i6n+LT+4c/2EU+in3WuGbrVzML2aKr53Pk5gXF66yBClAiBuLffgHORIUoda2TMP9e
	 86GWeyU3KKHPg==
Date: Thu, 15 Feb 2024 10:11:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v2 2/3] PCI: qcom: Read back PARF_LTSSM register
Message-ID: <20240215161114.GA1292081@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a040d65-4843-4e7d-818e-2523d112c74a@linaro.org>

On Thu, Feb 15, 2024 at 11:21:45AM +0100, Konrad Dybcio wrote:
> On 14.02.2024 23:28, Bjorn Helgaas wrote:
> > On Wed, Feb 14, 2024 at 10:35:16PM +0100, Konrad Dybcio wrote:
> >> On 12.02.2024 22:17, Bjorn Helgaas wrote:
> >>> Maybe include the reason in the subject?  "Read back" is literally
> >>> what the diff says.
> >>>
> >>> On Sat, Feb 10, 2024 at 06:10:06PM +0100, Konrad Dybcio wrote:
> >>>> To ensure write completion, read the PARF_LTSSM register after setting
> >>>> the LTSSM enable bit before polling for "link up".
> >>>
> >>> The write will obviously complete *some* time; I assume the point is
> >>> that it's important for it to complete before some other event, and it
> >>> would be nice to know why that's important.
> >>
> >> Right, that's very much meaningful on non-total-store-ordering
> >> architectures, like arm64, where the CPU receives a store instruction,
> >> but that does not necessarily impact the memory/MMIO state immediately.
> > 
> > I was hinting that maybe we could say what the other event is, or what
> > problem this solves?  E.g., maybe it's as simple as "there's no point
> > in polling for link up until after the PARF_LTSSM store completes."
> > 
> > But while the read of PARF_LTSSM might reduce the number of "is the
> > link up" polls, it probably wouldn't speed anything up otherwise, so I
> > suspect there's an actual functional reason for this patch, and that's
> > what I'm getting at.
> 
> So, the register containing the "enable switch" (PARF_LTSSM) can (due
> to the armv8 memory model) be "written" but not "change the value of
> memory/mmio from the perspective of other (non-CPU) memory-readers
> (such as the MMIO-mapped PCI controller itself)".
> 
> In that case, the CPU will happily continue calling qcom_pcie_link_up()
> in a loop, waiting for the PCIe controller to bring the link up, however
> the PCIE controller may have never received the PARF_LTSSM "enable link"
> write by the time we decide to time out on checking the link status.
> 
> It may also never happen for you, but that's exactly like a classic race
> condition, where it may simply not manifest due to the code around the
> problematic lines hiding it. It may also only manifest on certain CPU
> cores that try to be smarter than you and keep reordering/delaying
> instructions if they don't seem immediately necessary.

Does this mean the register is mapped incorrectly, e.g., I see arm64
has many different kinds of mappings for cacheability,
write-buffering, etc?

Or, if it is already mapped correctly, are we confident that none of
the *other* register writes need similar treatment?  Is there a rule
we can apply to know when the read-after-write is needed?

Bjorn

