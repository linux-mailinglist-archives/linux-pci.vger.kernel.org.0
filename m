Return-Path: <linux-pci+bounces-26711-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1DBA9B531
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 19:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 643F41BA45E1
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 17:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD4C288C8D;
	Thu, 24 Apr 2025 17:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vt9WYs58"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E85D502BE;
	Thu, 24 Apr 2025 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745515692; cv=none; b=MOaXQwrv5Jhr3hd+uY2yfj9MqtPBLPGE9ZxWZNJLkd3KTsotzo8Mr8w4+Uvi7X+OBx2iogn7pr4tbmOX099EUscfjm7k2poVfoZH4KBmu2yU0CHLUNAQXkkxp5nLZRGYlN7Uh5fPYvd+ocXLLKoiv2blLrJlchYHo+mPMDnu85s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745515692; c=relaxed/simple;
	bh=2kjHhC3dxG5BHNkLf48Njg6bM4No+8qiawuMt1tj/nE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ilzN9NlpEOOlF3+4W808oK7K68s/AjvXDBuFKpavVKPsix5EOeaIhKmpH4FyaOWKs8+DMPr6IVedIPYfrVunn5v+TLR0GIRKJ0sR3CsTJ5xz+K4XxI2yo2K5V1wP/UJHirXm8f7pLs5AIXPBSdKcmjZBfvicLmVLrQjHigG163g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vt9WYs58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E64C4CEE3;
	Thu, 24 Apr 2025 17:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745515691;
	bh=2kjHhC3dxG5BHNkLf48Njg6bM4No+8qiawuMt1tj/nE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Vt9WYs58G+zD+pVPzuTfYiH3UACzBDZu9vmwRBwBMJCXEQ6Y6w7htIBy4O1Uy0wmi
	 NxMD9T+UM7lfumJDZNm9VLQVIn3CZHgc6smqZDZgJ46BBxjRc3iaac0wFq0TfaNTcT
	 cCfOpgEyO++cXAXadJ0l/bMIUJ/wWDCy2Hq/VfSzJ3QK56/Li6Vz83pw0MgdVT4P1e
	 teZkNVzoKDJbW5K4Zc2xeQ6+20kVY49RDfg4kJR9XBCVJgtFprUFJ0RaZ/48kYPzbJ
	 QGFgkwWy43NYJ61QAetemj4FGqkg2eTjPa59946BwJXTkvRxw4fGMixrmbaQp9ITO/
	 1vyuNv8T0Yj8g==
Date: Thu, 24 Apr 2025 12:28:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Karolina Stolarek <karolina.stolarek@oracle.com>,
	"Shen, Yijun" <Yijun.Shen@dell.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Jon Pan-Doh <pandoh@google.com>,
	Terry Bowman <terry.bowman@amd.com>, Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Liu Xinpeng <liuxp11@chinatelecom.cn>,
	Darren Hart <darren@os.amperecomputing.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI/AER: Consolidate CXL, ACPI GHES and native AER
 reporting paths
Message-ID: <20250424172809.GA492728@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a92a75f-4348-4578-9b61-45682edaa514@oracle.com>

[+to Yijun @Dell in case there's some testing opportunity, thread at
https://lore.kernel.org/r/81c040d54209627de2d8b150822636b415834c7f.1742900213.git.karolina.stolarek@oracle.com]

On Thu, Apr 24, 2025 at 11:01:11AM +0200, Karolina Stolarek wrote:
> On 23/04/2025 22:31, Bjorn Helgaas wrote:
> > On Wed, Apr 23, 2025 at 03:52:27PM +0200, Karolina Stolarek wrote:
> > > 
> > > I wasn't able to produce logs for the CXL path (that is, Restricted CXL
> > > Device, as CXL1.1 devices not supported by the driver due to a missing
> > > functionality; confirmed by Terry) and faced issues when trying to inject
> > > errors via GHES. Is the lack of logs a blocker for this patch? I tested
> > > other CXL scenarios and my changes didn't cause regression, as far as I
> > > know.
> > 
> > Yes, I do think we need to say something about the output format
> > changes.
> 
> I understand.
> 
> > I assume you're trying GHES on machines that actually do
> > firmware-first error handling, right?  I found several GHES logs by
> > searching the web for "APEI Generic Hardware Error Source" "PCIe
> > error".  The majority were Dell boxes.
> 
> The only way to inject GHES errors I'm aware of is Mauro's patch for
> qemu[1], so I went down the virtualization path. As for working with the
> actual hardware, I'd need to ask around and learn more about the platform.

I'd be surprised if the qemu firmware supports firmware-first
handling, so I wouldn't expect to be able to exercise this path that
way.  I think there are some bits in HEST and similar tables that tell
us about this, e.g., ACPI r6.5, sec 18.3.2.4.

Unfortunately there are some typos in the spec (FIRMWARE_FIRST,
FIRMWAREFIRST in 18.4), so it's a little hard to find all the
references.

It's a long shot, but I added Yijun as a Dell contact that who might
have a pointer to someone who could possibly test GHES logging on a
Dell box with and without your patch so we could have a concrete
comparison of the dmesg log differences.

> > If you can't produce actual logs for comparison, I think we can take
> > info from a sample log somebody has posted and synthesize what the
> > changes would be after this patch.
> 
> I also found some logs at some point, mostly from 2021 and 2023, but I felt
> bad about mocking up the messages and tried to produce actual logs. If I
> can't find a way to get this working in two weeks, I'll revisit this idea.
> 
> All the best,
> Karolina
> 
> -------------------------------------------------------------
> [1] - https://lore.kernel.org/lkml/76824dfc6bb5dd23a9f04607a907ac4ccf7cb147.1740653898.git.mchehab+huawei@kernel.org/

