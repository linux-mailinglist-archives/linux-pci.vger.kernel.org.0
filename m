Return-Path: <linux-pci+bounces-42167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DDDC8C0DE
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 22:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6CDA835ADC1
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 21:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09384304BB2;
	Wed, 26 Nov 2025 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uns+OFKR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09162E9729;
	Wed, 26 Nov 2025 21:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764193293; cv=none; b=I/vIQ1k3RaqZpJnBRQpqtaA7bvEJP77yrp6SIKA4wVpjd/WYT2mC+39fjfirWpkkWVv9BEa8fsKpE50NWpLqtZXzFUhXUfh+0kwa0/fIJj1mmEZIeD+Fl5PUTFAeqMkvckMgkdVoGGahaPw5txqXPjLb/9+Sxmk5DMO8wtd3ft0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764193293; c=relaxed/simple;
	bh=VKmA/6mAURUWzEVcZzYO7/+r+cvqBLcFui3VsZzeq5E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BX6xKQJvwxmB63hrlgQHeAsYSMn4rrjBi1BCb1n5W84+hqM17++dm3hKbHR/fRR8yhm5VyUwr6M550KC+G7GD98quoRE4dqFv9p5trNlNqcrItcefYC3HnyYGm+hXeIqmaKFaEMj4Dj2yWDolm0mEFwmPD3Qh3Xx6v5tqcuBROc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uns+OFKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057E7C4CEF7;
	Wed, 26 Nov 2025 21:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764193293;
	bh=VKmA/6mAURUWzEVcZzYO7/+r+cvqBLcFui3VsZzeq5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uns+OFKRel+FuTsKfHkbDzNE1hZXYrMcqFMDExplp/C29jVUpES+Osyp92ZmcK8d9
	 fPE87c5VtNVjjqPvM6B9/5uZeU/YtuZEh8MW2NATGIt5F2omL8gSk5wwFJJ3Nex4UB
	 5lbGQr6gCY2S5XfjnG0dZSPpeJMga/fOTN6csWcs+K2FZlGDBxWOcvqAHs/iQkX7SB
	 CKjx507RNExmTvkVFMjxFFEsQ6MtzOiw/J7ZLBkAC4oJu2JDBScX/9eX0AcwtPRCu0
	 wYazpiGdXgBpgp0v2Ed8Vm87xhgDo2kyIwzD+UCVOJhPeY9xSsm8/3aRQiQa7VCmvX
	 g1wNrWabfRBwg==
Date: Wed, 26 Nov 2025 15:41:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: chester62515@gmail.com, mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, bhelgaas@google.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com,
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com, Frank.li@nxp.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, cassel@kernel.org,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: Re: [PATCH 4/4 v6] MAINTAINERS: Add MAINTAINER for NXP S32G PCIe
 driver
Message-ID: <20251126214131.GA2852425@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121164920.2008569-5-vincent.guittot@linaro.org>

[+cc Ciprian @oss.nxp.com, see email addr question below]

On Fri, Nov 21, 2025 at 05:49:20PM +0100, Vincent Guittot wrote:
> Add a new entry for S32G PCIe driver.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e64b94e6b5a9..bec5d5792a5f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3137,6 +3137,15 @@ F:	arch/arm64/boot/dts/freescale/s32g*.dts*
>  F:	drivers/pinctrl/nxp/
>  F:	drivers/rtc/rtc-s32g.c
>  
> +ARM/NXP S32G PCIE CONTROLLER DRIVER
> +M:	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>

I'd be happy to change to
Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
per https://lore.kernel.org/r/f38396c7-0605-4876-9ea6-0a179d6577c7@oss.nxp.com

I notice that most nxp.com addresses in MAINTAINERS use "@nxp.com"
addresses, not "@oss.nxp.com".

Let me know your preference.

Bjorn

