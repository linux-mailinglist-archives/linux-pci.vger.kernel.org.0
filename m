Return-Path: <linux-pci+bounces-38914-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCD1BF7696
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 17:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D902B354442
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 15:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43ACC32549C;
	Tue, 21 Oct 2025 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWOXUtcu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0295533F8BD;
	Tue, 21 Oct 2025 15:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061004; cv=none; b=DZ0vSfmkKQGDW9QNdFiywAe6rtn2v+WD9pjyIwMJLTXivRG82psr5pzGugcJSvOvokPF/yKIP+ouYDSnkB51ULbF7QtUEQsRwVXuV66Bq+/yNW8x4JCgvv3r5zFASzBW0AFv+CH/2YlIIidXxDhoi3X3OGJHYElmkjw9e4Suwj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061004; c=relaxed/simple;
	bh=l/nHB5cvBHr9/vJ9m/YMzvnA/T+J58ql+kq+FxEMVk8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jE3WpCirx4obqMbPbtI3Un8O/RQG79nb+mU/HnjTkOTcpJyg0wwWF0xeRvqtLC52zZApgjImZk2SsSh1tHAfnZ0TCIPh/Jdvy9G+Ncned3GySp6BjQM7vlvmtGLQF7aR0Un68X+BmORS5ghWMMFgqVYMwGvhRVh7IdqTAZWkPkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWOXUtcu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1A6C4CEF5;
	Tue, 21 Oct 2025 15:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761061003;
	bh=l/nHB5cvBHr9/vJ9m/YMzvnA/T+J58ql+kq+FxEMVk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZWOXUtcuEW6gI0qe8gxmyqTHD1K6ButdVP2ciXaBqFzpNbvqWZQ1vejigb+ZxMKaE
	 ma6FXLrUoTtgDmDep+PXcn8EML4DUo3rSZFa6Az4ao+ZNbjLU7NVDCSzaSAIkYDmcY
	 qfm7cw+Q7VOzQquPGbje/3uwWFdO126pgyw/gPOMK7m+cftwY+FYT4Sb47cGSllwcb
	 185PsfdHJywBTg2sBc1qTXdy2K3r/M5tCAZNs4Wxe+hUU/t7pMTQ8b5g53v0BW7mpb
	 5zo38KhjGDXXP10GpZA++5E28GM28289KHQdsgXKvKeG1IPS66LsKltKF46QmGQiiC
	 24UCkaTe85OlQ==
Date: Tue, 21 Oct 2025 10:36:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Christian Zigotzky <chzigotzky@xenosoft.de>,
	FUKAUMI Naoki <naoki@radxa.com>, linux-rockchip@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/ASPM: Enable only L0s and L1 for devicetree platforms
Message-ID: <20251021153642.GA1190961@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lmkrtyq6uzhzlz5ttvajnmojegrbfgaz3e3kkwej5qar2lkeof@r5gdlvesm6xl>

On Tue, Oct 21, 2025 at 09:31:22AM +0530, Manivannan Sadhasivam wrote:
> On Mon, Oct 20, 2025 at 05:12:07PM -0500, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree
> > platforms") enabled Clock Power Management and L1 Substates, but that
> > caused regressions because these features depend on CLKREQ#, and not all
> > devices and form factors support it.
> 
> I believe we haven't concluded that CLKREQ# is the cluprit here. It
> is probably the best bet, but there could be the device specific
> issues as well.

Yes.  There might be things in addition to CLKREQ#, but Clock PM and
L1SS definitely can't work without CLKREQ#.  I'll try to convey that
somehow.

> > Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> > Link: https://lore.kernel.org/r/db5c95a1-cf3e-46f9-8045-a1b04908051a@xenosoft.de/
> 
> Closes?

Yes, makes sense.  I didn't use Closes yet because I didn't want to
presume that it actually fixed the issue.  Will change if we get
testing results.

> > +	/* For devicetree platforms, enable L0s and L1 by default */
> >  	if (of_have_populated_dt()) {
> > -		link->aspm_default = PCIE_LINK_STATE_ASPM_ALL;
> > +		if (link->aspm_support & PCIE_LINK_STATE_L0S)
> > +			link->aspm_default |= PCIE_LINK_STATE_L0S;
> > +		if (link->aspm_support & PCIE_LINK_STATE_L1)
> > +			link->aspm_default |= PCIE_LINK_STATE_L1;
> 
> Not sure if it is worth setting these states conditionally. Link
> state enablement code should make use of the cached ASPM cap in
> 'link->aspm_capable'.

I wanted to avoid mentioning an ASPM state that is not advertised in
Link Capabilities, even if later code would ignore it.

> > +			pci_info(pdev, "ASPM: DT platform, enabling%s%s\n",
> 
> I think you added the 'DT platform,' prefix while applying my patch
> earlier.  This is somewhat redundant since the print implies that
> the platform is based on devicetree.

I think "DT platform" is probably unnecessary clutter.  I'll drop it
next time.

