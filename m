Return-Path: <linux-pci+bounces-8563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B275902C69
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 01:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A0E1C21429
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 23:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016EB1514C8;
	Mon, 10 Jun 2024 23:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rJepUrle"
X-Original-To: linux-pci@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B8954FAD
	for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 23:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718061643; cv=none; b=CwFlTqKcccdYeNy6UKgZPq2lqeitEU2xDlom9GlifiW216bSZ+iuY5KPaJx1jp7dhN5UV7/nBJuhTYcWJBn1DoZuUPoaSiIZOLb4rr4gJlDB7+ZxOGttdAt8nebuYeHgzeZjM34zQfGyJKfN+KGLtQn74cEuhB18nITuVf3FLdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718061643; c=relaxed/simple;
	bh=YGTvdQZwDOzgzfVvjWe9z+/k5IhE22IUsz8NO0h/L5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QwUUXLrUXmJAmprZ95SJA+lBJxbQ8ZNHRQdnx8eaaH3+V4QL6ehlrbBl0ryEk7p0Kuwx7B3joKxezDoBXxYexL/N0eHN+Qkea6vTynq3sCzVDs8T7YseADYbtUaEAff3W36O3YCW8987sYNlNf5kkZY1yJGzJSAGwQUe8UhFC8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rJepUrle; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from thinkpad-p16sg1.vs.shawcable.net (S010600cb7a0d6c8b.vs.shawcable.net [96.55.224.203])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9A40620693EF;
	Mon, 10 Jun 2024 16:20:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9A40620693EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1718061641;
	bh=cV7+VpHLkN83sahtfG2wP5xElGeAE5ABlPUTJ7Sj6IY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rJepUrleCdnW1of5xG6NMwgB0r4HeVrCY0iyrvJVMs6yVMI1IywXOB3nni5JSs1wV
	 txiJHONe/OAgkiDx4A0bOjF4XT4uEG4uuBKrMTm7OXc0rz7x7dO67GWMclW6DFpwAd
	 iPpZ1j2zhbwkx0Jps8iqQMr/o5QxD9rq3rBleD20=
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: fancer.lancer@gmail.com
Cc: Sergey.Semin@baikalelectronics.ru,
	apais@linux.microsoft.com,
	bboscaccy@linux.microsoft.com,
	code@tyhicks.com,
	gustavo.pimentel@synopsys.com,
	jingoohan1@gmail.com,
	linux-pci@vger.kernel.org,
	okaya@kernel.org,
	shyamsaini@linux.microsoft.com,
	srivatsa@csail.mit.edu,
	tballasi@linux.microsoft.com,
	vijayb@linux.microsoft.com
Subject: [PATCH] drivers: pci: dwc: dynamically set pci region limit
Date: Mon, 10 Jun 2024 16:20:19 -0700
Message-Id: <20240610232019.299410-1-shyamsaini@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <hxluc6qth4temdyxloekbhoy4iielyvxmmhp3u47qwtcxb5t5v@v5hdzvqmrsyv>
References: <hxluc6qth4temdyxloekbhoy4iielyvxmmhp3u47qwtcxb5t5v@v5hdzvqmrsyv>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Serge,

On Wed, May 22, 2024 at 05:10:46PM -0700, Shyam Saini wrote:
> commit 89473aa9ab26 ("PCI: dwc: Add iATU regions size detection procedure")
>> hardcodes the pci region limit to 4G.

> In what part does it _harcode_ the region limit to 4G? The procedure
> _auto-detects_ the actual iATU region limits. The limits aren't
> hardcoded.  The upper bound is 4G for DW PCIe IP-core older than
> v4.60. If the IP-core is younger than that the upper bound will be
> determined by the CX_ATU_MAX_REGION_SIZE IP-core synthesize parameter.
> The auto-detection procedure is about the CX_ATU_MAX_REGION_SIZE
> parameter detection.

>> This causes regression on
>> systems with PCI memory region higher than 4G.

> I am sure it doesn't. If it did we would have got multiple bug-reports
> right after the patch was merged into the mainline kernel repo. So
> please provide a comprehensive description of the problem you have.
> 
Sorry, I am certainly not a PCI expert but here is how I got here:

With [1] this change I started to see PCI driver throwing "Failed to set MEM range" error messages
and as consequence the driver probe fails with " error -22"

When I tracked the code, I found [1] this check was causing the driver probe failure 
and pci->region_limit was set to 4G in [2] this commit

So, to fix this issue I prepared this patch and it solves the problem I was having.
Based on your reply it seems problem is some where else.

I didn't see any problem with PCI memory <= 4G

>> 
>> Fix this by dynamically setting pci region limit based on maximum
>> size of memory ranges in the PCI device tree node.

> It seems to me that your patch is an attempt to workaround some
> problem you met. Give more insight about the problem in order to find
> a proper fix. The justification you've provided so far seems incorrect.
> 
> Note you can't use the ranges DT-property specified on your platform
> to determine the actual iATU regions size, because the later entity is
> a primary/root parameter of the PCIe controller. The DT-node memory
> ranges could be defined with a size greater than the actual iATU
> region size. In that case the address translation logic will be broken
> in the current driver implementation. AFAICS from the DW PCIe IP-core
> HW-manuals the IO-transaction will be passed further to the PCIe bus with
> no address translated and with the TLP fields filled in with the data
> retrieved on the application interface (XALI/AXI):
> 
> "3.10.5.6 No Address Match Result Overview: When there is no address
> match then the address is untranslated but the TLP header information
> (for fields that are programmable) comes from the relevant fields on
> the application transmit interface XALI* or AXI slave."
> 
> That isn't what could be allowed, because it may cause unpredictable
> results up to the system crash, for instance, if the TLPs with the
> untranslated TLPs reached a device they weren't targeted to.

> If what you met in your system was a memory range greater than the
> permitted iATU region limit, a proper fix would have been to allocate
> a one more iATU region for the out of bounds part of the memory range.

based on your suggestions I have prepared a new patch, which i will send shortly.
Thank you for the reviews.

[1] https://elixir.bootlin.com/linux/v6.9.1/source/drivers/pci/controller/dwc/pcie-designware.c#L480
[2] https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=89473aa9ab261948ed13b16effe841a675efed77

