Return-Path: <linux-pci+bounces-42240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F1EC90E47
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 06:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7686A4E1BB7
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 05:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C93361FFE;
	Fri, 28 Nov 2025 05:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsWOVwho"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604F535979;
	Fri, 28 Nov 2025 05:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764308074; cv=none; b=BVu6oJ80bty51iF+HxR0yqpltTrkcVMotuYLHl3x6gjsi2b5yrpFJGEXH/9zobHDX6Lhvvy8GsRoBiY7iJ/ffEQc89pphgJLlGbhZ/Aa8f92z7IOEn/Ty2AG03W7+yrZY+9KQVR8Sccked9RANczfNWZXSXzKD/s2a7IL4zlCIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764308074; c=relaxed/simple;
	bh=olnhcKJPXjotw9MWUbQP+asLAvOtuozbVFnAjBvTurs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Il3caWdEepJfdFJckK8zhUzWxiEcVnxGahOiala95DkuUilxD9TKuxnuxFyow03Bl3hNWQixsY31RbnrJUv9HhyHC5mb0RT6y0xzv4nfcCOzCi+uN4dBS0w7UCLvdMHTAapIyKCesQ7GuZ0rwUC41Os6ICtt1pWDAYNVHSFxvX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsWOVwho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFBEC4CEF1;
	Fri, 28 Nov 2025 05:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764308072;
	bh=olnhcKJPXjotw9MWUbQP+asLAvOtuozbVFnAjBvTurs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qsWOVwho2u7GvII3tw6luK4JNQG/lTFnllj2lsF2ZIWnBLyDvYR67dfXg9bLeANWK
	 m3tmO9ftT/LM4Posf6H3F2wtB7IgqKppFLwFibmgVPM72yaGXfxvmTo46WnuKKwt2U
	 4jA8h5eDImpQQFeiZqcnOy9qBLfGGUvLz3nkCBfijjaID1gCk2NZ0wWZIOFFGCPOvX
	 uD5eoHrPaeTGHioZCoi/uU4CC3Kw6tEAXIQh+6mOPZ/+y1p+/NYjH0jtvA2vbJnxjG
	 /WE03zXh1Nki1jHkAAhqKGphivYCADUkoiwbJmn28YyuBZt+Rz9frGP7Z8qtjPpc0b
	 vKmyUcTGIwAFw==
Date: Fri, 28 Nov 2025 06:34:27 +0100
From: Niklas Cassel <cassel@kernel.org>
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/6] PCI: dwc: Revert Link Up IRQ support
Message-ID: <aSk0Y74kPnsX0fGe@ryzen>
References: <20251111105100.869997-8-cassel@kernel.org>
 <mt7miqkipr4dvxemftq6octxqzauueln252ncrcwy6i2t7wfhi@jtwokeilhwsi>
 <aSRli_Mb6qoQ9TZO@ryzen>
 <585D6D29DF1A6436+9b5db091-8d6e-42a5-ab8f-4b152f82ac54@radxa.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <585D6D29DF1A6436+9b5db091-8d6e-42a5-ab8f-4b152f82ac54@radxa.com>

On Fri, Nov 28, 2025 at 02:15:28PM +0900, FUKAUMI Naoki wrote:
> Hi Niklas,
> 
> Should I try
>  "PCI: dwc: Make Link Up IRQ logic handle already powered on PCIe switches"
>  https://lore.kernel.org/r/20251127134318.3655052-2-cassel@kernel.org
> 
> instead of below approaches/patches?
> 
> > Neither my suggested approach:
> > https://lore.kernel.org/linux-pci/aRHdeVCY3rRmxe80@ryzen/
> > 
> > nor Shawn's suggested approach:
> > https://lore.kernel.org/linux-pci/dc932773-af5b-4af7-a0d0-8cc72dfbd3c7@rock-chips.com/

Yes please, your Tested-by would be very helpful.

It is basically the same as my patch above, I just sent it as a formal patch.

Since you said that it does indeed work for you, it does seem like a much
better solution. (Because if we would have reverted the patches, we would
have wanted to reapply them some time in the future.)


Kind regards,
Niklas

