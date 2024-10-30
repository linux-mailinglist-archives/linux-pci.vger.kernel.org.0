Return-Path: <linux-pci+bounces-15562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FA79B5CA9
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 08:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E7D01C226AD
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 07:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8F31E0DAC;
	Wed, 30 Oct 2024 07:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tX+cyevV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1541DF754;
	Wed, 30 Oct 2024 07:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730272487; cv=none; b=Dk20DDkWlSv+jgpSH25x+x3YSYIWAKaNGvKz8t7VRwxbNPc9lJNhfM0kvgl5GsjGJAAEeGok4nNEgXyoVWbLMJ1p4Sqw+FESKKRfK0rm5/66c58lO3qg+SiHAW1ivtyk+OQGZpJoD4X6j5T9Sl78bcLEn8WNwbeutp5ME+GbPOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730272487; c=relaxed/simple;
	bh=pBcIAnmp4npGjLTIppDJ8lCcHYRQBXuCVUIIlJStpJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jO7Ya9GdxPlXjOzvYhvDtMGgv+w0MInGFErav2X2SPnmRY242xXtC7kjWRV93pQZvYFszQ0OhMna+g+eGQLtJW2aF8ZzXBvjxo2guBKz1YA+y32u2EEylt2yg9HeDd6BIFhiwVfqHKObW5wD4nnN9qkx1YxkaOHQs1GuuudBwUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tX+cyevV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58687C4CEE4;
	Wed, 30 Oct 2024 07:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730272486;
	bh=pBcIAnmp4npGjLTIppDJ8lCcHYRQBXuCVUIIlJStpJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tX+cyevVKxLt3SNEBU1M6/peN6I5GFIHcheZ8LlR7lVBsqz7034FK8eEqzKfD65EZ
	 nB74/ohR0s9Gb9YejzMxasf7JV2mP/AXcwBhLGaiBsF7wI+WERGpIahU7Zkt03YMOV
	 C+HxsF/Of82M9HayOKi3p1AzTwpBYrnQrbTxcX+V7rr4BpvGPlplB9IYP9oenhzYR/
	 e3Fa5gRiZss4PpjP/1024W18aZSrc94apmXJ7ddAhv+nj+u+cUtfna11+W3T35C3jr
	 OCzQghqdSSq6pUVhSljfTOx0Tck23XSc5FYROyn/sGkJdB387LQRLemwTYWgU1Pg1s
	 ZsifqVsLMjSGg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t62v3-000000006PK-3LQY;
	Wed, 30 Oct 2024 08:15:05 +0100
Date: Wed, 30 Oct 2024 08:15:05 +0100
From: Johan Hovold <johan@kernel.org>
To: Qiang Yu <quic_qianyu@quicinc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
	andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	abel.vesa@linaro.org, quic_msarkar@quicinc.com,
	quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org,
	kw@linux.com, lpieralisi@kernel.org, neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	johan+linaro@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v7 6/7] PCI: qcom: Disable ASPM L0s and remove BDF2SID
 mapping config for X1E80100 SoC
Message-ID: <ZyHc-TkRtKxLU5-p@hovoldconsulting.com>
References: <20241017030412.265000-1-quic_qianyu@quicinc.com>
 <20241017030412.265000-7-quic_qianyu@quicinc.com>
 <ZxJrUQDGMDw3wI3Q@hovoldconsulting.com>
 <91395c5e-22a0-4117-a4b5-4985284289ab@quicinc.com>
 <250bce05-a095-4eb3-a445-70bbf4366526@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <250bce05-a095-4eb3-a445-70bbf4366526@quicinc.com>

On Wed, Oct 30, 2024 at 01:54:59PM +0800, Qiang Yu wrote:
> On 10/24/2024 2:42 PM, Qiang Yu wrote:
> > On 10/18/2024 10:06 PM, Johan Hovold wrote:

> >> Also say something about how L0s is broken so that it is more clear what
> >> the effect of this patch is. On sc8280xp enabling L0s lead to
> >> correctable errors for example.

> > Need more time to confirm the exact reason about disabling L0s.
> > Will update if get any progress

> I confirmed with HW team and SW team. L0s is not supported on X1E80100, 
> it is not fully verified. So we don't want to enable it.

Thanks for checking. A word about what can happen if not disabling it
may still be in place (e.g. the link state transition stats in debugfs
on x1e80100 looked pretty erratic with L0s enabled IIRC).

Also, are there any Qualcomm platforms that actually support L0s?
Perhaps we should just disable it everywhere?

Johan

