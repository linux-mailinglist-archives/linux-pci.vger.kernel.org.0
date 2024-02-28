Return-Path: <linux-pci+bounces-4185-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 496C286B290
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 16:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE4FAB26482
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 15:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8978815B113;
	Wed, 28 Feb 2024 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRcwuPkZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7B215B10B;
	Wed, 28 Feb 2024 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709132534; cv=none; b=eq8rUs7GFX6pn4c4mBc/OqfXHafHzqvIhRrYAZjxo1dmUv6e/3uGnoze6mc4Pz3Tj9YFAdl9u5Cjj9R4YWZbQYIFsrUhq1bhkOvG2yWh46VPn/3P38iaPNukdrD4pF46+x/t/vR54T6HHevly16GtePwVeqdmwWZyqhudWQNjUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709132534; c=relaxed/simple;
	bh=1h0tpGxcynD1O0R4NRR/i+De45HCdF5xEsAzG7MDeMU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FOcci6OTF8KgZN8Q32fQBQmXvXv0eEco2Sm/rSRzt3vq1x/4xuCVaw8gXpV5bDKoaAF2ZmjlfxQuoBwMu82yOeD/JreDC9WHyAr9RDuqWkStOXfuvlRmvjE5b9fs75fHD9jrlYwXlqkkFkxrzoQA0leoN/3c/FxK9o4DPYM9rMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRcwuPkZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E083C433F1;
	Wed, 28 Feb 2024 15:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709132533;
	bh=1h0tpGxcynD1O0R4NRR/i+De45HCdF5xEsAzG7MDeMU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rRcwuPkZWbNDhlstKgewJW1iuTveAeETmAIIn/Cyjn53mKuBU+wIpzejaQhxX4gCI
	 qjIpsUmLKEceub+UmV79SnSPh0OPLihS5bKkrHixbjeiy7JO3z7jPydN96yFD2NtDH
	 WEWle1LV1qZaTpwKxz4LFHBwmuiuH2bEX5M7vA90zfZNJjO3w3kkd576aWaZxRBx+p
	 S66f14HEbwznBf0fHgi3qF2bBq9Ox7YY1MrsZmBe39ZnhCc594iW3y9NUL9OcpXI3C
	 xkbCJbGrGP5/ZZxkC5BcppKi0peDrareJDI/PU1fSBMGjochi09rFPEBGaGSfcZ3UL
	 5n7pv7Lu7Y4cw==
Date: Wed, 28 Feb 2024 09:02:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, konrad.dybcio@linaro.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
	quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
	dmitry.baryshkov@linaro.org, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com, quic_schintav@quicinc.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 1/3] PCI: qcom: Enable cache coherency for SA8775P RC
Message-ID: <20240228150211.GA271700@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02e44f17-39cd-46ec-b236-bc4f502d705e@quicinc.com>

On Wed, Feb 28, 2024 at 06:34:11PM +0530, Mrinmay Sarkar wrote:
> On 2/24/2024 4:24 AM, Bjorn Helgaas wrote:
> > On Fri, Feb 23, 2024 at 07:33:38PM +0530, Mrinmay Sarkar wrote:
> > > Due to some hardware changes, SA8775P has set the NO_SNOOP attribute
> > > in its TLP for all the PCIe controllers. NO_SNOOP attribute when set,
> > > the requester is indicating that there no cache coherency issues exit
> > > for the addressed memory on the host i.e., memory is not cached. But
> > > in reality, requester cannot assume this unless there is a complete
> > > control/visibility over the addressed memory on the host.
> > 
> > Forgive my ignorance here.  It sounds like the cache coherency issue
> > would refer to system memory, so the relevant No Snoop attribute would
> > be in DMA transactions, i.e., Memory Reads or Writes initiated by PCIe
> > Endpoints.  But it looks like this patch would affect TLPs initiated
> > by the Root Complex, not those from Endpoints, so I'm confused about
> > how this works.
> > 
> > If this were in the qcom-ep driver, it would make sense that setting
> > No Snoop in the TLPs initiated by the Endpoint could be a problem, but
> > that doesn't seem to be what this patch is concerned with.
>
> I think in multiprocessor system cache coherency issue might occur.
> and RC as well needs to snoop cache to avoid coherency as it is not
> enable by default.

My mental picture isn't detailed enough, so I'm still confused.  We're
talking about TLPs initiated by the RC.  Normally these would be
because a driver did a CPU load or store to a PCIe device MMIO space,
not to system memory.

But I guess you're suggesting the RC can initiate a TLP with a system
memory address?  And this TLP would be routed not to a Root Port or to
downstream devices, but it would instead be kind of a loopback and be
routed back up through the RC and maybe IOMMU, to system memory?

I would have expected accesses like this to be routed directly to
system memory without ever reaching the PCIe RC.

> and we are enabling this feature for qcom-ep driver as well.
> it is in patch2.
> 
> Thanks
> Mrinmay
> 
> > > And worst case, if the memory is cached on the host, it may lead to
> > > memory corruption issues. It should be noted that the caching of memory
> > > on the host is not solely dependent on the NO_SNOOP attribute in TLP.
> > > 
> > > So to avoid the corruption, this patch overrides the NO_SNOOP attribute
> > > by setting the PCIE_PARF_NO_SNOOP_OVERIDE register. This patch is not
> > > needed for other upstream supported platforms since they do not set
> > > NO_SNOOP attribute by default.
> > > 
> > > 8775 has IP version 1.34.0 so intruduce a new cfg(cfg_1_34_0) for this
> > > platform. Assign enable_cache_snoop flag into struct qcom_pcie_cfg and
> > > set it true in cfg_1_34_0 and enable cache snooping if this particular
> > > flag is true.
> > s/intruduce/introduce/
> > 
> > Bjorn

