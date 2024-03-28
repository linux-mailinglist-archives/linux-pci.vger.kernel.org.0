Return-Path: <linux-pci+bounces-5351-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 425D6890805
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 19:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B868B22049
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 18:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E36F131E2B;
	Thu, 28 Mar 2024 18:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSQmZLzN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EA712F38B;
	Thu, 28 Mar 2024 18:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711649382; cv=none; b=Wk7Nfm8uf3upeOiivZXJDNaX4XZyUJhRNYZlSIuSFH842KV23ymwaj3mcmyCtXTA7KjyKykqU7bRSqG8uYik8DlVIVDGWLHGgHzkk05bDCW80jusB1iPrmnLkNRKtjOp5e39+epraritoQ631dGIzriC/4iQeyVy5rVihqdKoTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711649382; c=relaxed/simple;
	bh=He0L7am/V5CNl3ns9fu9G7ieIRAiLhmsEOwrMaSCWFo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lhzol7vvuB9y8Ozet7QYN3S/RtkZPVV0cQQKs7NTi/h8AvLMk5eetpiraKXOYmPtzVE+XoIfDlVG+gF1PEH60gXZtXO6dRvPYt4B5i4cxU4IQnBHHuIDfq/CdZI9T/5L5TyCjwQHp0VCVUNVyOmopBYQYc861U8Kfio7y4K5n8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSQmZLzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC21C433C7;
	Thu, 28 Mar 2024 18:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711649381;
	bh=He0L7am/V5CNl3ns9fu9G7ieIRAiLhmsEOwrMaSCWFo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VSQmZLzN3F4Id6PkBByDxRYNwwmIAroujPN5YkCElzd/mjXqvezyVpjkeRliiYSCW
	 EJLp7TuXhHEmBTAKBNJu1B9IUjKnEC+85kL4hSc0r8m2CAo1/G/Sz1oaylVAIsco+y
	 MXE+kom41uvsAFX4q9OOIaEyyYyWWYZyOlgPekP4mrpsMhx/NmIJcw3+n+509pYJMn
	 2fVkvEbiqwg0Z8Tn5UxmR6kgwXMiIIy4OFhAMU3BvPy7+ibQvQhjtRUsHYu8HZ2ULz
	 6SBGwKNGO0yeWeQSVqE7IIGT/rJNyd42pE14ztptszfNeF09E5rM2q6/GPk9Oq1qbG
	 siXvNn7gagnXA==
Date: Thu, 28 Mar 2024 13:09:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v2] PCI: dwc: Use the correct sleep function in
 wait_for_link
Message-ID: <20240328180940.GA1575046@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215-topic-pci_sleep-v2-1-79334884546b@linaro.org>

On Wed, Mar 27, 2024 at 07:24:49PM +0100, Konrad Dybcio wrote:
> According to [1], msleep should be used for large sleeps, such as the
> 100-ish ms one in this function. Comply with the guide and use it.
> 
> [1] https://www.kernel.org/doc/Documentation/timers/timers-howto.txt
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Thanks for fixing this up!

No need to repost, but whoever applies this, please update the subject
to be more specific:

s/the correct sleep function/msleep()/
s/wait_for_link/dw_pcie_wait_for_link()/

Also update the doc link to something like this since timers-howto.txt
no longer exists, and even timers-howto might be renamed or moved in
the future:

https://docs.kernel.org/6.8/timers/timers-howto.html

> ---
> Tested on Qualcomm SC8280XP CRD
> ---
> Changes in v2:
> - Rename the define
> - Sleep for 90ms (the lower boundary) instead of 100
> - Link to v1: https://lore.kernel.org/r/20240215-topic-pci_sleep-v1-1-7ac79ac9739a@linaro.org
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>  drivers/pci/controller/dwc/pcie-designware.h | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 250cf7f40b85..62915e4b2ebd 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -655,7 +655,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>  		if (dw_pcie_link_up(pci))
>  			break;
>  
> -		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
> +		msleep(LINK_WAIT_SLEEP_MS);
>  	}
>  
>  	if (retries >= LINK_WAIT_MAX_RETRIES) {
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 26dae4837462..b17e8ff54f55 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -63,8 +63,7 @@
>  
>  /* Parameters for the waiting for link up routine */
>  #define LINK_WAIT_MAX_RETRIES		10
> -#define LINK_WAIT_USLEEP_MIN		90000
> -#define LINK_WAIT_USLEEP_MAX		100000
> +#define LINK_WAIT_SLEEP_MS		90
>  
>  /* Parameters for the waiting for iATU enabled routine */
>  #define LINK_WAIT_MAX_IATU_RETRIES	5
> 
> ---
> base-commit: 26074e1be23143b2388cacb36166766c235feb7c
> change-id: 20240215-topic-pci_sleep-368108a1fb6f
> 
> Best regards,
> -- 
> Konrad Dybcio <konrad.dybcio@linaro.org>
> 

