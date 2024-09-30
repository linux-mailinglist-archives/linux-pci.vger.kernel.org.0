Return-Path: <linux-pci+bounces-13654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C2C98AA5A
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 18:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4CF71F217FF
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 16:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156BE7DA79;
	Mon, 30 Sep 2024 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQwjoA9e"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78D154765;
	Mon, 30 Sep 2024 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727715322; cv=none; b=WBbv2OB1IpIAMCQLOr+9lTe4b853c6kD7WE30a0mjPhasMgOKUHThelH5DJgUOju2sRaiaapSEmNMgCoLEkn1kmF/6J8McwmdmsWNVz7cPpFL8BTSDA0TpOtqugeVXSQEk+C+K6CmDbgNjnySN9w0a8Yvmhodozsi3KLSS3Cczk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727715322; c=relaxed/simple;
	bh=lKkKQadWVPapLPl0MlMu2HzP7Z4Ceg67nGL1ywiXY7M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=alS/r1ZHwUz8oBVtvIcgYPZ0p98XwzfZkvMRX2ZDmm7I8kTLsCvgRC5ufZeHriAuH8bnAQMZZYPuFkrs6QyqZ+3bGfeobMst71U+1S0LAbq16FvJ6B6R3wvY9DctW9ypBFQZdBEXCrtYogM7jIOUjOCJ1AUusYxkCf8BGkdI9CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQwjoA9e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA4BC4CEC7;
	Mon, 30 Sep 2024 16:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727715321;
	bh=lKkKQadWVPapLPl0MlMu2HzP7Z4Ceg67nGL1ywiXY7M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dQwjoA9eeHBE3fmrsULX3e0egQ8Z/eh4DApr3uilts5DfJ2tZbzQybk/XJfFz+qrc
	 UIV+G18V2t7XJTbV12A9S/ioPDi62oJK09x0GFfmtEambwbMvSnuG7p2D5ACWnsdWx
	 c5ui1j8kXaDHHTsAa3UwqyBnhXnRrfZYgwz7eiVszrMH4H+/pBIcUAjNBH0uUMorKf
	 E8M7C9wYKJQ8/R6dQ4P9A58NqUQ7QNcoB5fGUfa6w2NQ2fOQFpO0Z8NTbpMx+Pk0pJ
	 HWIhA2qZtSl0unrrEk8Y8ssbsMkImp7bZ+Wme+IfQCNqMH8sxZzux0d8/VT/qF2WdO
	 4pJOW370UTatg==
Date: Mon, 30 Sep 2024 11:55:19 -0500
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
Subject: Re: [PATCH V6 0/5] PCIe TPH and cache direct injection support
Message-ID: <20240930165519.GA179473@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927215653.1552411-1-wei.huang2@amd.com>

On Fri, Sep 27, 2024 at 04:56:48PM -0500, Wei Huang wrote:
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
> 
> This series introduces generic TPH support in Linux, allowing STs to be
> retrieved and used by PCIe endpoint drivers as needed. As a
> demonstration, it includes an example usage in the Broadcom BNXT driver.
> When running on Broadcom NICs with the appropriate firmware, it shows
> substantial memory bandwidth savings and better network bandwidth using
> real-world benchmarks. This solution is vendor-neutral and implemented
> based on industry standards (PCIe Spec and PCI FW Spec).
> 
> V5->V6:
>  * Rebase on top of pci/main (tag: pci-v6.12-changes)
>  * Fix spellings and FIELD_PREP/bnxt.c compilation errors (Simon)
>  * Move tph.c to drivers/pci directory (Lukas)
>  * Remove CONFIG_ACPI dependency (Lukas)
>  * Slightly re-arrange save/restore sequence (Lukas)

Thanks, I'll wait for the kernel test robot warnings to be resolved.

In patch 2/5, reword commit logs as imperative mood, e.g.,
s/X() is added/Add X()/, as you've already done for 1/5 and 3/5.

Maybe specify the ACPI _DSM name?  This would help users know whether
their system can use this, or help them request that a vendor
implement the _DSM.

In patch 4/5, s/sustancial/substantial/.  I guess the firmware you
refer to here means the system firmware that would provide the _DSM
required for this to work, i.e., not firmware on the NIC itself?
Would be helpful for users to have a hint as to how to tell whether to
expect a benefit on their system.

The 5/5 commit log could say what the patch *does*, not what *could*
be done (the subject does say what the patch does, but it's nice if
it's in the commit log as well so it's complete by itself).  Also, a
hint that using the steering tag helps direct DMA writes to a cache
close to the CPU expected to consume it might be helpful to motivate
the patch.

Bjorn

