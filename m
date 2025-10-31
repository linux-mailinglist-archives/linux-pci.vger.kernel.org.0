Return-Path: <linux-pci+bounces-39881-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD83EC22DBA
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 02:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 978A94E1C75
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 01:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27151D5146;
	Fri, 31 Oct 2025 01:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnqcGCEf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACCD225762;
	Fri, 31 Oct 2025 01:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761873616; cv=none; b=jVEnT5xu6XPNGL6v9cbF+qjrbD78QAGDZQbuhxRAM/1LtmBZh7u4v4MDUb3kWk4v3H5wnBSGlxAEg/ZaVTh409xwjvMO+ZXGsTgNsJttwdzqZqttQ+9/neN0zcZJNoqTB7/JRZJ10+sfZvb8AmB4QHaJr2FoDbq7PAqeFdAdmNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761873616; c=relaxed/simple;
	bh=XBpqrNWYLXGxZhlBTre3kVLERg3/jVkEfRPIH9FEfyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aEVzGYuD0Zj3RRrWIeff/aInzduI4rYrlFx4yTy1v9eDEAO28GOwXh35QZQvhsa3koxSVoqHjbWxEBvwSARQgZA18AZXowBK/gID+lWYdIHpRq1aHPc//Y+X2VGwUcgcHrtofeYesBA93bA4y9CWVCbn7wyKaMwY3zy+gzFFvJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnqcGCEf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4936C4CEF1;
	Fri, 31 Oct 2025 01:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761873616;
	bh=XBpqrNWYLXGxZhlBTre3kVLERg3/jVkEfRPIH9FEfyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TnqcGCEfCfAdD1JgaiTRfUGK4jIlpm2JsZr9Zct3Q204ryDpfUf9t/flGTCpfZsxx
	 fLZZLCR0J5BTwne/5tmGTtSpj4Cmw2sOA/Ckg2CXKWEGaIRKvEfpbq+aPAhrTcp0k4
	 0hzqol49WZ7+9sn8DACQBNWorXavoKwRtvRvWOmllxZxSqCWGeGzOrtr5djuMvGYQ1
	 b/UlS41OiAIZAMWFCLtPgYM6YEaeWjI7vfo9V8stvwLnqQ5rvsbLXVLjwK3MAnideS
	 6oyqGNTB45Rw23B5otFEp7Qw4KGlHqeSHM6DqDx6+7XlC6efa72PgrU1QliADuQYK1
	 in7+oFREE586g==
Date: Thu, 30 Oct 2025 20:20:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, yilun.xu@linux.intel.com,
	aneesh.kumar@kernel.org, bhelgaas@google.com,
	gregkh@linuxfoundation.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v7 2/9] PCI/IDE: Enumerate Selective Stream IDE
 capabilities
Message-ID: <20251031012014.GA1663371@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96cba9e4-ad1d-4823-b30b-f693c05824d4@amd.com>

On Fri, Oct 31, 2025 at 10:56:27AM +1100, Alexey Kardashevskiy wrote:
> On 31/10/25 08:37, Bjorn Helgaas wrote:
> > On Thu, Oct 30, 2025 at 11:59:30AM +1100, Alexey Kardashevskiy wrote:
> > > On 24/10/25 13:04, Dan Williams wrote:
> > > > Link encryption is a new PCIe feature enumerated by "PCIe r7.0 section
> > > > 7.9.26 IDE Extended Capability".
> > > ...
> > 
> > > > +#define PCI_IDE_CAP			0x04
> > > > +#define  PCI_IDE_CAP_LINK		0x1  /* Link IDE Stream Supported */
> > > > +#define  PCI_IDE_CAP_SELECTIVE		0x2  /* Selective IDE Streams Supported */
> > > > +#define  PCI_IDE_CAP_FLOWTHROUGH	0x4  /* Flow-Through IDE Stream Supported */
> > > > +#define  PCI_IDE_CAP_PARTIAL_HEADER_ENC 0x8  /* Partial Header Encryption Supported */
> > > > +#define  PCI_IDE_CAP_AGGREGATION	0x10 /* Aggregation Supported */
> > > > +#define  PCI_IDE_CAP_PCRC		0x20 /* PCRC Supported */
> > > > +#define  PCI_IDE_CAP_IDE_KM		0x40 /* IDE_KM Protocol Supported */
> > > > +#define  PCI_IDE_CAP_SEL_CFG		0x80 /* Selective IDE for Config Request Support */
> > > > +#define  PCI_IDE_CAP_ALG		__GENMASK(12, 8) /* Supported Algorithms */
> > > > +#define   PCI_IDE_CAP_ALG_AES_GCM_256	0    /* AES-GCM 256 key size, 96b MAC */
> > > > +#define  PCI_IDE_CAP_LINK_TC_NUM	__GENMASK(15, 13) /* Link IDE TCs */
> > > > +#define  PCI_IDE_CAP_SEL_NUM		__GENMASK(23, 16) /* Supported Selective IDE Streams */
> > > > +#define  PCI_IDE_CAP_TEE_LIMITED	0x1000000 /* TEE-Limited Stream Supported */
> > > 
> > > Since you are referring to PCIe r7.0 (instead of my proposal to use
> > > r6.1 ;) ), it has XT now here and in the stream control registers.
> > 
> > I haven't been following this, but is there an advantage to referring
> > to r6.1 instead of r7.0?  I assume newer revisions of the spec only
> > add useful things and don't remove anything.
> 
> We are adding here a bunch of macros for all the flags defined in
> the spec but we are not using many of them yet (or ever). And we are
> not adding the XT _support_ (which came in r7.0) right now, only the
> flags.
> 
> So what is the rule -
> 1) we add only bare minimum of the flags which we have the user for right now?
> 2) we add everything defined by the spec which the commit log refers to?
> 
> Right now it is neither but if the commit log said "r6.1" - then
> this patch is a complete set of flags.
>
> I do not care all that much, just noticed some inconsistency when I
> recently touched "lspci" so feel free to ignore the above :) Thanks,

I don't see a need to add #defines for things we don't use.

lspci is a little different because it should be able to decode
everything defined by the spec, whether somebody uses it or not.

My rule of thumb is to cite the most recent revision of the spec or
at least the most recent major version.  It's not as important as it
once was because the PCI-SIG has been trying hard not to change
section numbers in new revisions, but I don't really see the point of
citing an old revision unless there's something useful in it that
isn't in the current revision.

