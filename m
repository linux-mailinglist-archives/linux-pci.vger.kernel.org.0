Return-Path: <linux-pci+bounces-4206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C02586B83F
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 20:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB0E71C22E00
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 19:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630297443F;
	Wed, 28 Feb 2024 19:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONizTd9f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335EE74413;
	Wed, 28 Feb 2024 19:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709148884; cv=none; b=ebiTdHPPGCLKIm01ldq5g/09dsEgTjCKJ3bbadczR0uBnW/DquCDd+FzYOjA9wL7rFBI9d4LFZ+kJREbXSxdP98tvf7hlWB5TVqm95sY152b//aFZHE8U6TN908LTZwNDqHMtkx7u6z40foKx9MASh+SITnluXSAP7Em79s6yRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709148884; c=relaxed/simple;
	bh=ujxqpsiB8kloyn6Q+smiAFJZkT6a3RT0SS487iYx5MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VCiEufZpCt+WFzlfQO+RCR8C9ufv+MnfOdziYmsIMnR4jvSk9//MJoDaj5/iX7Q4eDAH5bqU4piFsrey8jsc2Lmk61UN5cZ4tEkik7vjwGmDZhtWMPcWEMqINqO8td03hTiXKcDLO7fwkvGyNKO2jbP2RaNUN+WSScVglwqkk7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONizTd9f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5C0C433F1;
	Wed, 28 Feb 2024 19:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709148883;
	bh=ujxqpsiB8kloyn6Q+smiAFJZkT6a3RT0SS487iYx5MQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ONizTd9fOBBTTIYYSTSo0bA6ptYN/3zgzAOB0L54HgdqhDXVThK45Fu7b0BHHBdqG
	 AQyRVUoxCmtWMwRisYB1W5UwwMpBGBZmkXlKQNQsT2BAWFRr/rb0CD1Nf5D79hzOmA
	 n5QsafqBgkvluMqqzApLyaUhvoFsqMdshc2MCOT8VyKIVndo8vALLuqAnvBR8YhzJg
	 EPoNSemf0D9KeuImWkzH7BhL5yeM3jeu/B+NBxhs/dBnQZMUsoa+LNLKKQc7tJ0miq
	 L25HAgUd+ixe+mbuI086n3tnCjwchFvaYJ8MVkYOnWqE5AFHm+9vWlgee3SGkek6CP
	 tx8cC5uIlsNxg==
Date: Wed, 28 Feb 2024 13:34:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Mrinmay Sarkar <quic_msarkar@quicinc.com>, andersson@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	konrad.dybcio@linaro.org, robh@kernel.org,
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
Message-ID: <20240228193441.GA281471@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240228184502.GC21858@thinkpad>

On Thu, Feb 29, 2024 at 12:15:02AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Feb 28, 2024 at 11:39:07AM -0600, Bjorn Helgaas wrote:
> > On Wed, Feb 28, 2024 at 10:44:12PM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, Feb 28, 2024 at 09:02:11AM -0600, Bjorn Helgaas wrote:
> > > > On Wed, Feb 28, 2024 at 06:34:11PM +0530, Mrinmay Sarkar wrote:
> > > > > On 2/24/2024 4:24 AM, Bjorn Helgaas wrote:
> > > > > > On Fri, Feb 23, 2024 at 07:33:38PM +0530, Mrinmay Sarkar wrote:
> > > > > > > Due to some hardware changes, SA8775P has set the
> > > > > > > NO_SNOOP attribute in its TLP for all the PCIe
> > > > > > > controllers. NO_SNOOP attribute when set, the requester
> > > > > > > is indicating that there no cache coherency issues exit
> > > > > > > for the addressed memory on the host i.e., memory is not
> > > > > > > cached. But in reality, requester cannot assume this
> > > > > > > unless there is a complete control/visibility over the
> > > > > > > addressed memory on the host.
> > > > > > 
> > > > > > Forgive my ignorance here.  It sounds like the cache
> > > > > > coherency issue would refer to system memory, so the
> > > > > > relevant No Snoop attribute would be in DMA transactions,
> > > > > > i.e., Memory Reads or Writes initiated by PCIe Endpoints.
> > > > > > But it looks like this patch would affect TLPs initiated
> > > > > > by the Root Complex, not those from Endpoints, so I'm
> > > > > > confused about how this works.
> > > > > > 
> > > > > > If this were in the qcom-ep driver, it would make sense
> > > > > > that setting No Snoop in the TLPs initiated by the
> > > > > > Endpoint could be a problem, but that doesn't seem to be
> > > > > > what this patch is concerned with.
> > > > >
> > > > > I think in multiprocessor system cache coherency issue might
> > > > > occur.  and RC as well needs to snoop cache to avoid
> > > > > coherency as it is not enable by default.
> > > > 
> > > > My mental picture isn't detailed enough, so I'm still
> > > > confused.  We're talking about TLPs initiated by the RC.
> > > > Normally these would be because a driver did a CPU load or
> > > > store to a PCIe device MMIO space, not to system memory.
> > > 
> > > Endpoint can expose its system memory as a BAR to the host. In
> > > that case, the cache coherency issue would apply for TLPs
> > > originating from RC as well.
> > 
> > What PCIe transactions are involved here?  So far I know about:
> > 
> >   RC initiates Memory Read Request (or Write) with NO_SNOOP==0
> >     ...
> >   EP responds with Completion with Data (for Read) 
> 
> The memory on the endpoint may be cached (due to linear map and
> such). So if the RC is initiating the MWd TLP with NO_SNOOP=1, then
> there would be coherency issues because there is no guarantee that
> the memory is not cached on the endpoint. So, not snooping the
> caches and directly writing to the DDR would cause coherency issues
> on the endpoint as well.

I don't know what linear map is, but I'll take your word for it that
endpoints are allowed to cache things internally.  So I guess in the
ideal world there might be a way for a driver to specify no-snoop for
accesses to its device if it knows there is no caching.

The commit log for this patch refers to caching on the *host*, though,
and IIUC you're saying this patch clears NO_SNOOP on TLPs from the RC
because of potential coherency issues on the *endpoint*.

> > But I guess you're saying the EP would initiate other transactions in
> > the middle related to snooping?  I don't know what those are.
> > 
> > > > But I guess you're suggesting the RC can initiate a TLP with a system
> > > > memory address?  And this TLP would be routed not to a Root Port or to
> > > > downstream devices, but it would instead be kind of a loopback and be
> > > > routed back up through the RC and maybe IOMMU, to system memory?
> > > > 
> > > > I would have expected accesses like this to be routed directly to
> > > > system memory without ever reaching the PCIe RC.
> > > > 
> > > > > and we are enabling this feature for qcom-ep driver as well.
> > > > > it is in patch2.
> > > > > 
> > > > > Thanks
> > > > > Mrinmay
> > > > > 
> > > > > > > And worst case, if the memory is cached on the host, it may lead to
> > > > > > > memory corruption issues. It should be noted that the caching of memory
> > > > > > > on the host is not solely dependent on the NO_SNOOP attribute in TLP.
> > > > > > > 
> > > > > > > So to avoid the corruption, this patch overrides the NO_SNOOP attribute
> > > > > > > by setting the PCIE_PARF_NO_SNOOP_OVERIDE register. This patch is not
> > > > > > > needed for other upstream supported platforms since they do not set
> > > > > > > NO_SNOOP attribute by default.
> > > > > > > 
> > > > > > > 8775 has IP version 1.34.0 so intruduce a new cfg(cfg_1_34_0) for this
> > > > > > > platform. Assign enable_cache_snoop flag into struct qcom_pcie_cfg and
> > > > > > > set it true in cfg_1_34_0 and enable cache snooping if this particular
> > > > > > > flag is true.
> > > > > > s/intruduce/introduce/
> > > > > > 
> > > > > > Bjorn
> > > 
> > > -- 
> > > மணிவண்ணன் சதாசிவம்
> 
> -- 
> மணிவண்ணன் சதாசிவம்

