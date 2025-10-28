Return-Path: <linux-pci+bounces-39587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 578ECC17390
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 23:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C9E343566A5
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 22:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9D4359F9C;
	Tue, 28 Oct 2025 22:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiKsLr3j"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476F623D289;
	Tue, 28 Oct 2025 22:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761691517; cv=none; b=ZrCfTb6jtC7eov7qzeYvjzj1TE9ZcqArcUGjje52xJNLJh8HSj0SJBF9YPXzqAtSuXbCwDJlaPsh11CwavTuMqakgvjVZSo8aSaKTwmdKn/a3V6xoot91zmweBDWC4LnxiSlurlx8SVG/CRvmAYU9oHzWCJiEUBYojQT2UIyHU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761691517; c=relaxed/simple;
	bh=Fqz8FI2y5Z4GN6ikcEbMujGZJV35fmvZ7UWTqlo4Du4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fdklhwdFy2RujYZYeT8R0eNcKUb5cQVi51mvvxRGX4tsJg+Xv6Nbe8ePpi/Wyp/YSKMIl9rgO+1VUmJncuDKjdmSDuGCWGgfi6NFP7RwTZohsjEaeMKLm6OOfyspzEpfOJbdK0Qzcls9Y5mPf4o+mmKEuuaJhSkXtHErxChANVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiKsLr3j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B3EC4CEE7;
	Tue, 28 Oct 2025 22:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761691516;
	bh=Fqz8FI2y5Z4GN6ikcEbMujGZJV35fmvZ7UWTqlo4Du4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oiKsLr3jcHe2kgtd61Y0ud9HRhXJnwrpVlsRnzMVTYpIrFfQf4IY9Z9B6D0sPYNOD
	 QvRRf6UuvUORB4bUy1l2KDh1YjiEMc/WLRv2FZg97Kqzsai5Vle8N50KUuJcqawjs1
	 YIhdZnvtxyPDekkOkx8BgKsuHL66GSKOH0UH8CfS/T+AstkwX2bsgUBrA7yzMPBSyD
	 P04n4JomSCAu+Cj83956gF+rmgPS9lMQKVDyaDkACYLXo5MK5vINnTTDQ7OMxKN/sO
	 VqFxo5m42cvcPancywkMmZmpEmlB4AGxFOWHLZY4nhKH1OuXFP5S1LYF+C7Z/9QaDY
	 qT7Q1unw4PZcg==
Date: Tue, 28 Oct 2025 17:45:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	regressions@lists.linux.dev
Subject: Re: [PATCH v2 03/24] MIPS: PCI: Use pci_enable_resources()
Message-ID: <20251028224515.GA1538987@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251013210236.GA864224@bhelgaas>

On Mon, Oct 13, 2025 at 04:02:36PM -0500, Bjorn Helgaas wrote:
> On Mon, Oct 13, 2025 at 12:54:25PM -0700, Guenter Roeck wrote:
> > On Fri, Aug 29, 2025 at 04:10:52PM +0300, Ilpo Järvinen wrote:
> > > pci-legacy.c under MIPS has a copy of pci_enable_resources() named as
> > > pcibios_enable_resources(). Having own copy of same functionality could
> > > lead to inconsistencies in behavior, especially now as
> > > pci_enable_resources() and the bridge window resource flags behavior are
> > > going to be altered by upcoming changes.
> > > 
> > > The check for !r->start && r->end is already covered by the more generic
> > > checks done in pci_enable_resources().
> > > 
> > > Call pci_enable_resources() from MIPS's pcibios_enable_device() and remove
> > > pcibios_enable_resources().
> > > 
> > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > 
> > This patch causes boot failures when trying to boot mips images from
> > ide drive in qemu. As far as I can see the interface no longer instantiates.
> > 
> > Reverting this patch fixes the problem. Bisect log attached for reference.
> ...

> > # first bad commit: [ae81aad5c2e17fd1fafd930e75b81aedc837f705] MIPS: PCI: Use pci_enable_resources()
> 
> #regzbot introduced: ae81aad5c2e1 ("MIPS: PCI: Use pci_enable_resources()")

#regzbot fix: 1d5d1663619d ("MIPS: Malta: Fix PCI southbridge legacy resource reservations")
#regzbot fix: f294a5fd34db ("MIPS: Malta: Use pcibios_align_resource() to block io range")



