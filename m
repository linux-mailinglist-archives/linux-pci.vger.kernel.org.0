Return-Path: <linux-pci+bounces-44720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA1FD1D97D
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 10:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C128F3042926
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 09:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBF1389441;
	Wed, 14 Jan 2026 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqVOfbC4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A32037F730;
	Wed, 14 Jan 2026 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768383414; cv=none; b=lIE+XuPLNpcmTG9GCXpEanrfszToaqnGLeRi5QD3U/LTmslgY+dcX+bv0/vB/mzZgldlc9noWOB0MdKxSZ20dz+GtcrKCRE5TeWNmRu83byr6XNutBiBoynPGFxqC55rLJa2uNFMy22jt//tSopu25q+fpLSGmQXEBcoRrqoNoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768383414; c=relaxed/simple;
	bh=Vd4jldM+sSvbw3Qs+faOiMfuX6C/rjZRaR+/l4tHfHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpMUPKhkuiGjWJcnLsTsXrEN74u7wo2td6osAMP3CWstxor04JIwYoa9GzIhAJ4UNBLzOS8pDUlq5sP953lq4QlVzk28xVuVmGPQsmR6D34ksM0J1XVKrVvDEc8+tLJFAI0A/fFpb7l8rPxXeAg/MGsTKlw8QtCN/PAJ8kR4zNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqVOfbC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DFBC4CEF7;
	Wed, 14 Jan 2026 09:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768383414;
	bh=Vd4jldM+sSvbw3Qs+faOiMfuX6C/rjZRaR+/l4tHfHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HqVOfbC46Uz/3VEhEysg9Z6Qh0ocLgMei+0QndPuf8J/aQ9JqBmm9xT/ObY/0gZ+J
	 rpF7MptLiTMCDmZPQFbSr5OKMStMdawjfhkvvmNRiAVu6JDC91t8ZdmzF6oyj1xZu8
	 ePty8JFMbbXjazbIT07+odyE589qUa6oUyebKw6pM+hayhXEpOLMyR6OCrLm6tjTGz
	 i39lkXMN0HW1hfWh8a12fbgf8/uKF9xv6FaT9PJJywNk3fTaQiTAUJkXd/6WDEc5Gq
	 7Wm5XwOjqcZjalGUZbWO/oLf527NMvtypUQ9sc05+fBwUie3VJ2Q1j7Ll9n3pIccLh
	 eHBr6YS47PnbQ==
Date: Wed, 14 Jan 2026 15:06:50 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/5] phy: qcom: qmp-pcie: Skip PHY reset if already up
Message-ID: <aWdjsvAPjyJkplMD@vaman>
References: <20260109-link_retain-v1-0-7e6782230f4b@oss.qualcomm.com>
 <20260109-link_retain-v1-1-7e6782230f4b@oss.qualcomm.com>
 <nmle3y6nb4kjcwstzqxkqzaokeyjoegg6lxtmji57kxwh5snxa@p76v6dr7rgsg>
 <53f0c45f-7f5c-4abd-af84-cbb82d509872@linaro.org>
 <cvxvq7f2ku6aq5gbbqav42ckqk2raesbxq2bx46mxvapcza5v4@5zuyjdtn5us2>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cvxvq7f2ku6aq5gbbqav42ckqk2raesbxq2bx46mxvapcza5v4@5zuyjdtn5us2>

On 09-01-26, 16:03, Dmitry Baryshkov wrote:
> On Fri, Jan 09, 2026 at 02:10:49PM +0100, Neil Armstrong wrote:
> > On 1/9/26 14:08, Dmitry Baryshkov wrote:
> > > On Fri, Jan 09, 2026 at 12:51:06PM +0530, Krishna Chaitanya Chundru wrote:
> > > > If the bootloader has already powered up the PCIe PHY, doing a full
> > > > reset and waiting for it to come up again slows down boot time.
> > > 
> > > How big is the delay caused by it?
> > > 
> > > > 
> > > > Add a check for PHY status and skip the reset steps when the PHY is
> > > > already active. In this case, only enable the required resources during
> > > > power-on. This works alongside the existing logic that skips the init
> > > > sequence.
> > > 
> > > Can we end up in a state where the bootloader has mis-setup the link? Or
> > > the link going bad because of any glitch during the bootup?
> > 
> > Good question, can we add a module parameter to force a full reset of the PHY in case
> > the bootloader is buggy ?
> 
> I'd suggest a simpler thing: if the reset was skipped, reset the PHY in
> case of an error and retry. That's also one of the reasons why I asked
> for skip_reset not to be the persistent value.

That is a better suggestion. Helps skips if it is configured and way to
recover if buggy

-- 
~Vinod

