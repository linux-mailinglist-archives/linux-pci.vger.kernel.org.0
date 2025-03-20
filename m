Return-Path: <linux-pci+bounces-24248-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A2AA6ACFF
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 19:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE63166B02
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 18:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429DB224B13;
	Thu, 20 Mar 2025 18:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjgVx/uR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4D0192B86
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 18:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742494659; cv=none; b=NBq7DkCIaZcBDyvIpzv1hA0h+aUwF/qtPYqixf+x8he6dynUtkj5qkWPHMaDtMEUBfYezi4ogfSWCmLMOcezc0906OEEFLCWohA+RM2zplmN9rlWeqLsYe8/0E582avYgCQaYUvlybdar5PsRROSuq946Jcjm27aywTxrfJQrDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742494659; c=relaxed/simple;
	bh=eoxqZD5D9o6udhSpDocLB6kFH21O7mwV6JIRLKIVDvM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PB+C9HW3UwOOxCBS/0tQrg6RbNVzJSHVbPOSngEiMgTH4wHevIZvL+ZZTlVdpU63Do6UkJhlZlPcYMhmZn9P9bx7epr70mn9XRBsem+U1/CuYQ9lS0yR+pc6zTS3Oh9SW60x0lTMuLP8Uxbkgw3VgKiVcJ1uy/gF4RXMcV690jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjgVx/uR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3E9C4CEDD;
	Thu, 20 Mar 2025 18:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742494658;
	bh=eoxqZD5D9o6udhSpDocLB6kFH21O7mwV6JIRLKIVDvM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fjgVx/uR+IwgVw0FEnBmYhinF80H9P7W92ukAQDCvLCt+jWFtkgiBtwy79DvqlW3d
	 IIScAmeP50wGrGDBqqda6chvwUS+PZdkTwdYfRBcPD/Y5wO3rtnxmlgbndfUuaZBTi
	 A6lwhWG3fhNvgFtazxANrcQlZGLiB2815DzlDwIlZJfAg1H/V0/7jku2RKyFReTLux
	 9sA7WG3LvA1/UhX47tsCpdGPwV6ohyC1DNwdgX1gbwiyN/L3bs3240+pMPJ+WuqaO0
	 hZM5vro8Xu86qNBDlX8I8kQ/XQ/DiYNCu4Y/9V1dkka1NHqSdhtX0MxVJAOvFc/sT7
	 dYyhUfteTsFUQ==
Date: Thu, 20 Mar 2025 13:17:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Jon Pan-Doh <pandoh@google.com>,
	Terry Bowman <terry.bowman@amd.com>, Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Liu Xinpeng <liuxp11@chinatelecom.cn>,
	Darren Hart <darren@os.amperecomputing.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] PCI/AER: Consolidate CXL and native AER reporting paths
Message-ID: <20250320181736.GA1091349@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b919c39e-bb0f-40f6-84c9-f712404c0ac0@oracle.com>

On Thu, Mar 20, 2025 at 04:14:04PM +0100, Karolina Stolarek wrote:
> On 19/03/2025 23:21, Bjorn Helgaas wrote:
> > On Mon, Mar 17, 2025 at 10:14:46AM +0000, Karolina Stolarek wrote:
> > > Make CXL devices use aer_print_error() when reporting AER errors.
> > > Add a helper function to populate aer_err_info struct before logging
> > > an error. Move struct aer_err_info definition to the aer.h header
> > > to make it visible to CXL.
> > 
> > Previously, pci_print_aer() was used by both CXL (via
> > cxl_handle_rdport_errors()) and by ACPI GHES via aer_recover_queue()
> > and aer_recover_work_func(), right?
> > 
> > And after this patch, they would use aer_print_error() like native
> > AER, native DPC, and the ACPI EDR DPC path?
> 
> That is correct.

> > I think this consolidation is a good thing, because I don't think we
> > should log errors differently just because we learned about them via a
> > different path.
> > 
> > But I think this also changes the text we put in dmesg, which is
> > potentially disruptive to users and scripts that consume it, so I
> > think we should include a comparison of the previous and new text in
> > the commit log.
> 
> Like I said in a comment to the patch, I tested CXL error reporting in QEMU
> with and without my patch, and the output is the same:
> 
> pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0c:00.0
> pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0c:00.0
> pcieport 0000:0c:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
> pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00004000/0000a000
> pcieport 0000:0c:00.0:    [14] CorrIntErr

Maybe there's CXL magic that I missed.  It looks like Terry's series
changes some of this path.  And GHES also currently uses
pci_print_aer().  Some sample logs at [1,2].

Looking at v6.14-rc1, only aer_print_error() logs the "error status"
string, and only pci_print_aer() logs "aer_status", "aer_layer", etc.

The previous path is:

  pci_print_aer
    pci_err("aer_status: 0x%08x, aer_mask: 0x%08x\n")    <--
    __aer_print_error
    pci_err("aer_layer=%s, aer_agent=%s\n")              <--
    pcie_print_tlp_log

New path is:

  aer_print_error
    pci_printk("PCIe Bus Error: severity=%s, type=%s, (%s)\n")
    pci_printk("  device [%04x:%04x] error status/mask=%08x/%08x\n)
    __aer_print_error
    pcie_print_tlp_log

So I expected that the lines I marked in pci_print_aer() would be
different.

Bjorn

[1] https://lore.kernel.org/lkml/2149597.8uJZFlvqrj@xrated/T/
[2] https://lore.kernel.org/all/e8a58616-aeae-ad78-d496-6dfcef4ddcaa@arm.com/T/

