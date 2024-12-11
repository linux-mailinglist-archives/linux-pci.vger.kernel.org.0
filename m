Return-Path: <linux-pci+bounces-18176-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 368F59ED718
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 21:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC062167431
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 20:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2C51C4A02;
	Wed, 11 Dec 2024 20:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZxjaqpH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1302594BF
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 20:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733948303; cv=none; b=lVGX+MIsSSjLxi1HeWgFhxm74I3mxoKR613E6t8lQQP9kcJTl/TJoR2ugTZ8oCTWfb0SjH8bp2YAMVpJ0B79JR+YH/TcIs1YXvza27DOyBlhRraECjQEMbkaGo1ctmhSFnr/OtNM3v8Fpx2hRjE+joIwZVNggISrh9BFOUw+ypg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733948303; c=relaxed/simple;
	bh=mTAHPubh95eKrie7K+yxUJ78qpxSikuHn/5Rhu90CdE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ioh9CBNElXjvhny7lU7gIF1CzdWibSRbHwsP7eB793Tek3bNV8R+wRUd5bTobQHSh+ZeBYZueQ0Ss1VC1AkogeDWrKvIDP4wXrPMpWbIlU7vXnbYS0yC96wPM0mlsiJg7n/ZuK400imf5PBAUpFH6t9bmoalsDHAQoomrpwe+sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZxjaqpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8094AC4CED2;
	Wed, 11 Dec 2024 20:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733948303;
	bh=mTAHPubh95eKrie7K+yxUJ78qpxSikuHn/5Rhu90CdE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BZxjaqpHrgv1XnABJmuVR8qIWmLoHT9g9hxC3uOs+ceBu8Vw15ZXKGf31rdvcZ99B
	 431jKdCo9ymPS70JuNB7pz5WqJiOAQar+B7BwSMj/j04dZpzGqIvcG0YB2u1M92oDp
	 eDZtrJiSDJP6fHYNMw4q+gRbbnDXewBVrWujcVV+ScyuyVyPSuMALrUi5luPqjriTg
	 7I66OQ3DJwiaCptgDx/xBmw853DfI+n8SEM9hD4F9xYKJYRed8jDvtEMKmI4g9K51C
	 PPrWOqByJNN0DjeRHY/N8JHoLQK14HOwzW49e7EoyTCuKkt/RsRMidCO2zsepd4CbT
	 bCWmWFT1JOfRQ==
Date: Wed, 11 Dec 2024 14:18:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Add Rockchip vendor ID
Message-ID: <20241211201822.GA3305340@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1733900293-169419-1-git-send-email-shawn.lin@rock-chips.com>

On Wed, Dec 11, 2024 at 02:58:12PM +0800, Shawn Lin wrote:

Needs a commit log.  It's OK to repeat the subject line.

Also, per the note at the top of pci_ids.h, needs a list of multiple
places this will be used.  This series only adds one place, which
isn't enough to justify adding this to pci_ids.h.

But this *could* also be used in drivers/misc/pci_endpoint_test.c and
drivers/pci/controller/pcie-rockchip-host.c, so if you want to update
them as well, this would be fine.

> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v2: None
> 
>  include/linux/pci_ids.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index d2402bf..6f68267 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2604,6 +2604,8 @@
>  
>  #define PCI_VENDOR_ID_ZHAOXIN		0x1d17
>  
> +#define PCI_VENDOR_ID_ROCKCHIP		0x1d87
> +
>  #define PCI_VENDOR_ID_HYGON		0x1d94
>  
>  #define PCI_VENDOR_ID_META		0x1d9b
> -- 
> 2.7.4
> 

