Return-Path: <linux-pci+bounces-16914-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD599CF341
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 18:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6281E288398
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 17:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C09017BB38;
	Fri, 15 Nov 2024 17:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMo/I0Or"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC302165F1E
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 17:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731692938; cv=none; b=sMzv4Uumc82Cl6cC8vwF3SM30xHHvs6dOnAmThdPH0MPukU/YP/E4OoZP2xfOtIaJrrb0uxszMRWhVWJTznDCuC8aWXpNvIr6IedChJdru28fb23kWzklQ9nztTJWkp8Atn3ZG8sqCexDZSRfEX+0KADK2WfB3CdkPIJoW7erbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731692938; c=relaxed/simple;
	bh=O27L0SGHdtu0sx6HdwxZUE0Q/9DQPVH2WaNyB1DKels=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=A/AEZlHpSoDVbPpLBGsA7+Rl9GXb4aEmuP4aPxpRLRIDlN0tNy/Y2rcf3d+Z3g/PUnz7jwBgOpaD6aqNeiAfRm1AwgWSK9oxY2SYlTmnimjWEFYnLUiXodVgSfpN+zRh5c0yG3T6nLfqWXuJ98CvLjWQvRvHkT9avpWi52ihVWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMo/I0Or; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D5FC4CECF;
	Fri, 15 Nov 2024 17:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731692938;
	bh=O27L0SGHdtu0sx6HdwxZUE0Q/9DQPVH2WaNyB1DKels=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JMo/I0OrGMZun1tEXOzctq04kJsJgwZxehK0B1Ut0WRG+ZVJm0BBp3CcA0CCcbzZt
	 nF0G2sAWZqFDX2l7tpTHZPwat2SaRkTxhFpeV3o60WR1eJ03qfFsifN0SttxOolM+Y
	 hWFwaZj7M+hl3/h0N/pXkWN2EUbHExjFi7kZPQnQIwThibyJEYfEbAI+2rxtuN6SJI
	 mmvPQQJG4yxrb56CdeeFaEOOBGaSSn9VJ4oGVbkPEOk67/z3ddy7XJ4HYxMGvjGKGW
	 BThSZDosQ7q9aolfwlHD6Gx/kwM2OIbSGyc4N0mUcpapctxIsPAWIU13FJVPSHpxRy
	 ITVOLO6X94Jbg==
Date: Fri, 15 Nov 2024 11:48:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Szymon Durawa <szymon.durawa@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Subject: Re: [PATCH v2 0/8] VMD add second rootbus support
Message-ID: <20241115174855.GA2045200@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115092256.2525264-1-szymon.durawa@linux.intel.com>

On Fri, Nov 15, 2024 at 10:22:48AM +0100, Szymon Durawa wrote:
> This patch series implements second rootbus support inside Intel VMD module.
> Current implementation allows VMD to take ownership of devices only on first
> bus (Rootbus0). Starting from Intel Arrow Lake, VMD exposes second bus 
> (Rootbus1) to allow VMD to own devices on this bus as well. VMD MMIO BARs
> (CFGBAR. MEMBAR1 and MEMBAR2) are now shared between Rootbus0 and Rootbus1.
> Reconfiguration of 3 MMIO BARs is required by resizing current MMIO BARs ranges.
> It allows to find/register Rootbus1 and discovers devices behind it.
> 
> Patches 1 to 6 introduce code refactoring without functional changes.
> Patch 7 implements VMD Rootbus1 and patch 8 provides workaround for rootbus
> number hardwired to fixed non-zero value. Patch 8 is necessary for correct 
> enumeration attached devices behind Rottbus1. Without it user cannot access
> those devices.
> 
> Changes from v1:
> - splitting series into more commits, requested by Bjorn
> - adding helper functions, suggested by Bjorn
> - minor typos and unclear wording updated, suggested by Bjorn
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: linux-pci@vger.kernel.org
> Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Reviewed-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
> Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
> 
> Szymon Durawa (8):
>   PCI: vmd: Add vmd_bus_enumeration()
>   PCI: vmd: Add vmd_configure_cfgbar()
>   PCI: vmd: Add vmd_configure_membar() and
>     vmd_configure_membar1_membar2()
>   PCI: vmd: Add vmd_create_bus()
>   PCI: vmd: Replace hardcoded values with enum and defines
>   PCI: vmd: Convert bus and busn_start to an array
>   PCI: vmd: Add support for second rootbus under VMD
>   PCI: vmd: Add workaround for rootbus number hardwired to fixed
>     non-zero value
> 
>  drivers/pci/controller/vmd.c | 467 ++++++++++++++++++++++++++---------
>  1 file changed, 357 insertions(+), 110 deletions(-)
>  mode change 100644 => 100755 drivers/pci/controller/vmd.c

It looks like only the cover letter was sent to linux-pci, and the
actual patches weren't.  Can you repost this with the correct cc list?
You might as well address the nits below at the same time and make it
a v3 to avoid confusion.

When you do, can you rephrase these to say they add support for a
second *Root Port*, which I think is what they do.

The additional root bus is just a consequence of having another Root
Port.  The root bus has no existence by itself, so it doesn't really
make sense to talk about "finding" or "registering" the root bus.

Also rewrap commit logs to fill 75 columns.  Include the names of new
helpers in the commit log.

Add blank lines between paragraphs (noticed in 8/8 comment, might be
elsewhere as well).

In 6/8, replace "Bus and busn_start are converted ..." with "Convert
..." as you did in the subject.

In 7/8,
s/enhacement/enhancement/
s/This patch add/Add/
s/workaraund/workaround/ (also in 8/8 comment)
Replace "rootbus" here with "Root Port".  "Devices behind rootbus"
doesn't really make sense.

In 8/8 comment, I'm not sure what "It assigns setup as broken" means.
Recast "... are updated to the same value" to imperative mood ("update
x to the same value").

The "BUS0" nomenclature seems heavily embedded in the vmd driver but
is really a misnomer.  Maybe that reflects similar terminology in an
internal spec?  Any hard-wiring of bus numbers reflects a property of
the way a *Root Port* works, so using the right name will make this
easier to understand, especially since there are other Root Ports with
the same hard wiring.

Bjorn

