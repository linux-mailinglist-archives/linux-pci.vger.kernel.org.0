Return-Path: <linux-pci+bounces-40822-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF5FC4B952
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 07:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226DE3B744F
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 06:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BEF1A317D;
	Tue, 11 Nov 2025 06:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z95UwU2F"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C9C16EB42
	for <linux-pci@vger.kernel.org>; Tue, 11 Nov 2025 06:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762840893; cv=none; b=H2u/98r64OZeCNhV7q8byxiJxQ6SzMVSXMfasFuKSmoaDxAEQAiMtjgNHY6KCe1pK+maBTs0G+6zAb2ISpbIaMMfDade1DCuOuA+8v9M4ipetgPFD4ubmC1JOCjHKaqpoehHIuTny+7r7qWyiUXYx64tu8D5Zv649YLQDKu/P4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762840893; c=relaxed/simple;
	bh=wd+AiYAHruPjJQSTOB4mXmdXpJNcgLiNv7nMibMjNiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNq3ecOZ3mgOUp94/r6bzJsWtjql0TsO6dCCR7pUllyY7SpUmXkPopwQTOLAKEgIqgKLioOS5EL/LNGmj4huKndy7CrfrFM26sHKpuvyL6mW3OOxRPfaoggYJxZS5hWbVUmNBzviijiLQeR7SeteCjLI48TLhzC8alEmoYqFywQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z95UwU2F; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762840891; x=1794376891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wd+AiYAHruPjJQSTOB4mXmdXpJNcgLiNv7nMibMjNiw=;
  b=Z95UwU2FxCZsaOWtvbgRPjWl1i7Y+7FkifisEETDZkMOKDaeYPvlFWok
   Hz4pL28TI2PaEmHVMwtoFHUm4rVj2K7K3wTkAxxi9cYVnSVejrDF2oEsY
   U3nGvNMr8Tehrva65WqJn+8zER4eTTDWmF8sUxnvvHZ0XXBMX/218Rc9v
   X8BQbw/o4rG2S0wc8yW2zVqOAaaBVOeq6D7CEab/AW3BKa8B0qpSQDs+y
   gvl8WcH8FhMV+8r8Yi7NTlhO+vVI4MkjJsdFuByO3krgP83bXAj+Sq8+0
   4oYKUygfiL9zwcJiPNnAWhLMqPToY3gF+g+3eI3bHxlP8ZUneGNiH/rsX
   g==;
X-CSE-ConnectionGUID: sII7yUfZRFOcKSJZu1uKuw==
X-CSE-MsgGUID: NIzKyku3SoqSzXUaT/zBPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="52455204"
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="52455204"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 22:01:30 -0800
X-CSE-ConnectionGUID: RNsA4MWKSIa9STGDCfVipw==
X-CSE-MsgGUID: B/itmVGYThab9Qn1waruCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="193876964"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 10 Nov 2025 22:01:29 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 8D45495; Tue, 11 Nov 2025 07:01:28 +0100 (CET)
Date: Tue, 11 Nov 2025 07:01:28 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3] PCI/PTM: Do not enable PTM solely based on the
 capability existense
Message-ID: <20251111060128.GU2912318@black.igk.intel.com>
References: <20251031060959.GY2912318@black.igk.intel.com>
 <20251111001023.GA2143615@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251111001023.GA2143615@bhelgaas>

On Mon, Nov 10, 2025 at 06:10:23PM -0600, Bjorn Helgaas wrote:
> On Fri, Oct 31, 2025 at 07:09:59AM +0100, Mika Westerberg wrote:
> > On Thu, Oct 30, 2025 at 03:59:37PM -0500, Bjorn Helgaas wrote:
> > > On Thu, Oct 30, 2025 at 02:46:05PM +0100, Mika Westerberg wrote:
> > > > It is not advisable to enable PTM solely based on the fact that the
> > > > capability exists. Instead there are separate bits in the capability
> > > > register that need to be set for the feature to be enabled for a given
> > > > component (this is suggestion from Intel PCIe folks, and also shown in
> > > > PCIe r7.0 sec 6.21.1 figure 6-21):
> > > 
> > > Can we start with a minimal statement of what's wrong?  Is the problem
> > > that 01:00.0 sent a PTM Request Message that 00:07.0 detected as an
> > > ACS violation?
> > 
> > The problem is that once the PCIe Switch is hotplugged we get tons of AER
> > errors like below (here upstream port is 2b:00.0, in the previous example
> > it was 01:00.0):
> > 
> > [  156.337979] pci 0000:2b:00.0: PTM enabled, 4ns granularity
> > [  156.350822] pcieport 0000:00:07.1: AER: Multiple Uncorrectable (Non-Fatal) error message received from 0000:00:07.1
> > [  156.361417] pcieport 0000:00:07.1: PCIe Bus Error: severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Receiver ID)
> > [  156.372656] pcieport 0000:00:07.1:   device [8086:e44f] error status/mask=00200000/00000000
> > [  156.381041] pcieport 0000:00:07.1:    [21] ACSViol                (First)
> > [  156.387842] pcieport 0000:00:07.1: AER:   TLP Header: 0x34000000 0x00000052 0x00000000 0x00000000
> 
> If I read this right:
> 
>   0x34000000 is 0011 0100 0...0
>     Fmt  001    4 DW header, no data (PCIe r7.0, sec 2.2.1.1)
>     Type 10100  Message Request, Local - Terminate at Receiver (2.2.1.1, 2.2.8)
> 
>   0x00000052 is 0...0 0101 0010
>     0x0000     Requester ID
>     0101 0010  PTM Request (2.2.8.10)
> 
> The fact that the Request ID is 0x0000 and the error is an ACS
> Violation looks like the implementation note in sec 6.12.1.1:
> 
>   Functions are permitted to transmit Upstream Messages before they
>   have been assigned a Bus Number. Such messages will have a Requester
>   ID with a Bus Number of 00h. If the Downstream Port has ACS Source
>   Validation enabled, these Messages (see Table F-1, Section 2.2.8.2,
>   and Section 6.22.1) will likely be detected as an ACS Violation
>   error.

Okay thanks for looking.

> So I assume 2b:00.0 sent a PTM Request with Requester ID of 0, and
> 00:07.1 logged the ACS violation.  It's odd that 2b:00.0 would send a
> PTM request if it doesn't advertise the PTM Requester role.  Also odd
> that it doesn't seem to know its Bus Number.  It's supposed to capture
> that from every config write request (sec 2.2.9.1), and I would think
> it should have seen several by now including the one that enable PTM.

Indeed but for some reason the flood of AER ACS violations start
immediately after we enabled it. Even if it has the bus number already
assigned.

> But I think your fix is right even if we don't understand exactly how
> we got there.  Are you planning an update, or ...?  Just wanted to
> make sure we're not waiting for each other.

Yes, I have the new version ready. Tested it yesterday and was planning to
send it out today.

