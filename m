Return-Path: <linux-pci+bounces-39075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 469FCBFF370
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 07:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E0D34F87B6
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 05:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584F1261B98;
	Thu, 23 Oct 2025 05:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1+u62lR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB46258EE1;
	Thu, 23 Oct 2025 05:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761195854; cv=none; b=qOAGer7y8g9qvFxMkrZbFCbUXpeeseMacgBXcm1UqxvQbYfMBbO7h59Xtwo78Alj42YGWm0aJZEoj8NwGrKXhne2c+5b4Lnny3dFzlx4djTvjrYkyZpPNVreN8FvX8cd1Dspc8HLYey8Mk89F0jqsmfdETO6hp4sjHQ3jG0M7ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761195854; c=relaxed/simple;
	bh=t3OAdB3SgIr/YlxzjXfZjt6KdaLAA44NHXh9J0+xHyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpX5+xH3/inhHk+5fEen9yO1qxu4qVkFNnt7X+okc55AupO0kuxjLf7KcNN+c9ssxc04y6tPMJxOg+u5V/PRD1/EKiviMdtDO4DouhYAKhBXhYnoQI+3zPRkCMSEr58BGVU32LwUSDN3d+KowzWfh5r9GF0NdDYADz7O/MX/X2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1+u62lR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E82EC4CEE7;
	Thu, 23 Oct 2025 05:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761195853;
	bh=t3OAdB3SgIr/YlxzjXfZjt6KdaLAA44NHXh9J0+xHyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A1+u62lRZcYfPfgflaKYZZo9MzED0KC+AEO0GtQVbguxDNI06HLRwhdBQJk4HMjOB
	 KpPGskFPFguPeEPK9PiWHlkZ7FlZV/JTTm4e5AkEEcGs+ZMCn0ImZh9M6YsnDUe4In
	 FD4Z7Y8su9E3EGrXSfAtLdYzymjUQA7wkQnP7ClTdEjBf75IIwdPQh34E86AVaWGwz
	 JUPDqMHtoBz9rtkTtT5/8oArppFlU+EKu2PlGi5a8i8FwEYiAe+CW7rxPWZW4F32B4
	 WJP/NxmFF66txLwN486vqbtLr0HtLxDc6aTdwVsNQzLCTTPWNHGOzv5P3/U3fIjUxh
	 Ip5CM1ktKDUfg==
Date: Thu, 23 Oct 2025 10:33:59 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Christian Zigotzky <chzigotzky@xenosoft.de>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-rockchip@lists.infradead.org
Subject: Re: [RESEND] Re: [PATCH] PCI/ASPM: Enable only L0s and L1 for
 devicetree platforms
Message-ID: <2liqc4r7t4vhdok6u6g32g2su4irnb5o467byub3a2omfl3kqd@m2rpf5edhqhf>
References: <20251022191313.GA1265088@bhelgaas>
 <340D76D438E6105B+58e7f834-75f7-40c5-a46a-677cb279a02d@radxa.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <340D76D438E6105B+58e7f834-75f7-40c5-a46a-677cb279a02d@radxa.com>

On Thu, Oct 23, 2025 at 01:25:17PM +0900, FUKAUMI Naoki wrote:
> # Fixes the ML address for linux-rockchip
> # Please resend the original patch to linux-rockchip@lists.infradead.org
> 
> Hi Bjorn,
> 
> On 10/23/25 04:13, Bjorn Helgaas wrote:
> > Christian, Naoki, any chance you could test this patch on top of
> > v6.18-rc1 to see whether it resolves the problem you reported?
> > 
> > I'd like to verify that it works before merging it.
> 
> I'll be testing now. May I test on v6.18-rc2 without the following patch?
> 
>  "PCI: dw-rockchip: Prevent advertising L1 Substates support"
> 

Yes, you should revert the above mentioned commit if you have applied it. It
will remove the L1ss CAP altogether making *this* patch irrelevant.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

