Return-Path: <linux-pci+bounces-12781-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F18396C6B9
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 20:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C347280C07
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 18:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7131E4123;
	Wed,  4 Sep 2024 18:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MK0Z2LM2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACE41E4114;
	Wed,  4 Sep 2024 18:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725475753; cv=none; b=i7d2Au7xkE2PGMhTOfEkDZVtrngBdMMfTxrkGxPP82lXODzmEO5AZmTvFqsL1XdmEvwNsIanvJjnLXk8VJwq58jiT8xej4jiM6LLKz3NcgrGntUxpRhguH2aK/QMrNhhBK8GIJRK8yhKEDauWRArFdX1GgAcrjDLevZrfi5FVm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725475753; c=relaxed/simple;
	bh=NVJy7a9hzOZfICfnRGCKRFnKJQ0Sx2x47tJN20jKhus=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AqqzVrdqioJlw8kriynTgKAlKRhfjFkJtK1zQ9wjDQ9/gbw5cW2C5wB+MP6hjfgdo0An0Cluk/0w8R1/sM7O1qVCCnwMM493n1EAAModyldhzlmPkjAyzSAiqRK22RmZCsUwWxo4MGOJ5+mCprWLTPWYV7fPdM2UUVrLlor895k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MK0Z2LM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F56EC4CEC2;
	Wed,  4 Sep 2024 18:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725475753;
	bh=NVJy7a9hzOZfICfnRGCKRFnKJQ0Sx2x47tJN20jKhus=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MK0Z2LM2sEoLcQactCH04EZbfL3YQrPNmkMnQfRli1kjLn19utVIF5SsnOIfLLdD9
	 YuV6PtJudoDvx/I3pUM3R/c1xlDZDEmRpSifttS4E0xURO48r05aPPdhzOaK6RkD9B
	 auJRS4e0+nQ4mqmac2i9k0v1XRyxq0//h6KwvM5VXVVuBatIwODFTJkSm3Y/TbkIWq
	 dxZ4H/vuJt1/5YdH7JXlDLWmGmjWr1PZ8LizWsOD3cRruvZy4H7Uxwzt3wL5YdhhUk
	 Dd98E9B8UkavLodhAvshLgKygAu488ry8gDMUzDHmibWbqqYMkerAlXVuHDxemmaMt
	 2DruypS2JYrwA==
Date: Wed, 4 Sep 2024 13:49:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan.Cameron@huawei.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com,
	bhelgaas@google.com, lukas@wunner.de, paul.e.luse@intel.com,
	jing2.liu@intel.com
Subject: Re: [PATCH V4 00/12] PCIe TPH and cache direct injection support
Message-ID: <20240904184911.GA340610@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822204120.3634-1-wei.huang2@amd.com>

On Thu, Aug 22, 2024 at 03:41:08PM -0500, Wei Huang wrote:
> Hi All,
> 
> TPH (TLP Processing Hints) is a PCIe feature that allows endpoint
> devices to provide optimization hints for requests that target memory
> space. These hints, in a format called steering tag (ST), are provided
> in the requester's TLP headers and allow the system hardware, including
> the Root Complex, to optimize the utilization of platform resources
> for the requests.
> 
> Upcoming AMD hardware implement a new Cache Injection feature that
> leverages TPH. Cache Injection allows PCIe endpoints to inject I/O
> Coherent DMA writes directly into an L2 within the CCX (core complex)
> closest to the CPU core that will consume it. This technology is aimed
> at applications requiring high performance and low latency, such as
> networking and storage applications.

Thanks for this example, it's a great intro.  Suggest adding something
similar to a patch commit log, since the cover letter is harder to
find after this appears in git.

> This series introduces generic TPH support in Linux, allowing STs to be
> retrieved and used by PCIe endpoint drivers as needed. As a
> demonstration, it includes an example usage in the Broadcom BNXT driver.
> When running on Broadcom NICs with the appropriate firmware, it shows
> substantial memory bandwidth savings and better network bandwidth using
> real-world benchmarks. This solution is vendor-neutral and implemented
> based on industry standards (PCIe Spec and PCI FW Spec).
> 
> V3->V4:
>  * Rebase on top of the latest pci/next tree (tag: 6.11-rc1)

No need to rebase to pci/next; pci/main is where it will be applied.
But it currently applies cleanly to either, so no problem.

>  * Add new API functioins to query/enable/disable TPH support
>  * Make pcie_tph_set_st() completely independent from pcie_tph_get_cpu_st()
>  * Rewrite bnxt.c based on new APIs
>  * Remove documentation for now due to constantly changing API

I'd like to see this documentation included.  And updated if the API
changes, of course.

>  * Remove pci=notph, but keep pci=nostmode with better flow (Bjorn)

This seems backward to me.  I think "pci=notph" makes sense as a way
to completely disable the TPH feature in case a user trips over a
hardware or driver defect.

But "pci=nostmode" is advertised as a way to quantify the benefit of
Steering Tags, and that seems like it's of interest to developers but
not users.

So my advice would be to keep "pci=notph" and drop "pci=nostmode".

Bjorn

