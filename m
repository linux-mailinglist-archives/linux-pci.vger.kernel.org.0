Return-Path: <linux-pci+bounces-37989-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECE8BD663E
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 23:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E90140263B
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 21:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89662EACF9;
	Mon, 13 Oct 2025 21:41:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3386246778;
	Mon, 13 Oct 2025 21:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760391681; cv=none; b=BvYSQARx8cQNtSvIuRQRuhKZ12x/l6T3HT+Hex565F8HiRJ913fGlB1HLkf9a3drYBO7HkxhiNHFAnS4IxFtEOCgmLx64/wAl1NO95LG8HOQVJNnQv/h9bWYR29+RetFv1JpcKORNXLA36OO5M50WtKQ0h7vv4L1hWzkePBaCeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760391681; c=relaxed/simple;
	bh=VINIqmrGcK4Q5kNGL6kTupqRoKpcr1/Zsu3Lhu78K8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeDVAnml6zLNnHrc8T++NruQXuCt1rpH691/y6q+9sJ+znTNG5yuy9cfZDWukSI7ou3aP2bxgJFVXc1dyJlPcoAW7+qKLQF6BCxrqushXAKEyqsziBcAHukkAYQUE1hJInvgD/kgqPLtiJqiSfrorymw+MdR4PAwpIE4D+mRrQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1v8Pv4-0000sq-00; Mon, 13 Oct 2025 23:17:26 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 5C1B0C0256; Mon, 13 Oct 2025 23:17:13 +0200 (CEST)
Date: Mon, 13 Oct 2025 23:17:13 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, macro@orcam.me.uk
Subject: Re: [PATCH v2 03/24] MIPS: PCI: Use pci_enable_resources()
Message-ID: <aO1sWdliSd03a2WC@alpha.franken.de>
References: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
 <20250829131113.36754-4-ilpo.jarvinen@linux.intel.com>
 <9085ab12-1559-4462-9b18-f03dcb9a4088@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9085ab12-1559-4462-9b18-f03dcb9a4088@roeck-us.net>

On Mon, Oct 13, 2025 at 12:54:25PM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Fri, Aug 29, 2025 at 04:10:52PM +0300, Ilpo Järvinen wrote:
> > pci-legacy.c under MIPS has a copy of pci_enable_resources() named as
> > pcibios_enable_resources(). Having own copy of same functionality could
> > lead to inconsistencies in behavior, especially now as
> > pci_enable_resources() and the bridge window resource flags behavior are
> > going to be altered by upcoming changes.
> > 
> > The check for !r->start && r->end is already covered by the more generic
> > checks done in pci_enable_resources().
> > 
> > Call pci_enable_resources() from MIPS's pcibios_enable_device() and remove
> > pcibios_enable_resources().
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> 
> This patch causes boot failures when trying to boot mips images from
> ide drive in qemu. As far as I can see the interface no longer instantiates.
> 
> Reverting this patch fixes the problem. Bisect log attached for reference.

Patch below fixes my qemu malta setup. Now I'm wondering, why this is
needed. It was added with commit

aa0980b80908 ("Fixes for system controllers for Atlas/Malta core cards.")

Maciej, do you remember why this is needed ?

Thomas.

diff --git a/arch/mips/pci/pci-malta.c b/arch/mips/pci/pci-malta.c
index 6aefdf20ca05..e0270b818b03 100644
--- a/arch/mips/pci/pci-malta.c
+++ b/arch/mips/pci/pci-malta.c
@@ -229,10 +229,6 @@ void __init mips_pcibios_init(void)
 		return;
 	}
 
-	/* PIIX4 ACPI starts at 0x1000 */
-	if (controller->io_resource->start < 0x00001000UL)
-		controller->io_resource->start = 0x00001000UL;
-
 	iomem_resource.end &= 0xfffffffffULL;			/* 64 GB */
 	ioport_resource.end = controller->io_resource->end;
 
-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

