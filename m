Return-Path: <linux-pci+bounces-15566-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FBE9B5D19
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 08:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAF1AB21909
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 07:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45BF1DFE0D;
	Wed, 30 Oct 2024 07:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFQHKEWn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC3954BD4;
	Wed, 30 Oct 2024 07:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730274101; cv=none; b=RnWnjg/iZD+I8rPZiHcm6HiHYaB0CdqS3y7RAmsAHKOVK9PkX0F2lUZ/yg5vRK0OcUDC5ltznIjUSv9TkSC3RZmqsy1EbJzFgwOd4BGVBsNQzommHoiJSvtidVlYfnjmoR3tjGF7uWdtnoSJTCwd9ryMgjxAjzQS2TDL7t3Wzl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730274101; c=relaxed/simple;
	bh=FsOVZqSRJU7cZMV54PKXbTGF5CocTT15s1Oyg7KJL6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdvIeuSGJleFpRxdiWb7TwbYwuyDjCRr9DeqBqsyUiMMBNa8FpT6TOdxWpR6eZl7sdedxCoq9QA7MB4Flf58sDPorByZa2JeI+zRKcFmGImkpg6T2kL03JATuaB1ehisBgAmnPcdZQ9rihtvjXpp1bXwzqY9ErLIdWnahiZsh18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFQHKEWn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DB0C4CEE4;
	Wed, 30 Oct 2024 07:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730274100;
	bh=FsOVZqSRJU7cZMV54PKXbTGF5CocTT15s1Oyg7KJL6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BFQHKEWnVjk42ISHNCC4SuQvjKoQJ52XE4I39Xi6QUgp2APgmzTAwQbZ895OHemqq
	 OalGvu4zbNRq54ND0010sOsTloLBSXpH6cMqm5LqjylXXGZuInbgYhWLNjaCzoIW2F
	 XL7Aa4Bym7PDTYzu3MiOd0/Y/hgze35cIKyWDp+Wv7Eu2RCUcRqX5aYVGTt9cZ2oLB
	 Qkipq4Bm/I/QCSOdbwCo72bIlhOGjl52YoJqGCam3+jf3olBtrKMWSHPvGFpwMkl7d
	 S1f35A2qAuFf+NeCno1I0ZhH3eET9rJ8NuHXn90Usqo+Me7OjPO0ZyINoouvtRsPe7
	 NQMr0nAMZGW4w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t63L6-000000007fm-1iFO;
	Wed, 30 Oct 2024 08:42:00 +0100
Date: Wed, 30 Oct 2024 08:42:00 +0100
From: Johan Hovold <johan@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Qiang Yu <quic_qianyu@quicinc.com>, vkoul@kernel.org, kishon@kernel.org,
	robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, abel.vesa@linaro.org, quic_msarkar@quicinc.com,
	quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org,
	kw@linux.com, lpieralisi@kernel.org, neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	johan+linaro@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v7 6/7] PCI: qcom: Disable ASPM L0s and remove BDF2SID
 mapping config for X1E80100 SoC
Message-ID: <ZyHjSCWGYLDu27ys@hovoldconsulting.com>
References: <20241017030412.265000-1-quic_qianyu@quicinc.com>
 <20241017030412.265000-7-quic_qianyu@quicinc.com>
 <ZxJrUQDGMDw3wI3Q@hovoldconsulting.com>
 <91395c5e-22a0-4117-a4b5-4985284289ab@quicinc.com>
 <250bce05-a095-4eb3-a445-70bbf4366526@quicinc.com>
 <ZyHc-TkRtKxLU5-p@hovoldconsulting.com>
 <20241030071851.sdm3fu6ecaddoiit@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030071851.sdm3fu6ecaddoiit@thinkpad>

On Wed, Oct 30, 2024 at 12:48:51PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Oct 30, 2024 at 08:15:05AM +0100, Johan Hovold wrote:

> > Also, are there any Qualcomm platforms that actually support L0s?
> > Perhaps we should just disable it everywhere?
> 
> Most of the mobile chipsets from Qcom support L0s. It is not supported only on
> the compute ones. So we cannot disable it everywhere.
> 
> Again, it is not the hw issue but the PHY init sequence not tuned support L0s.

Right, this should be mentioned in the commit message.

Johan

