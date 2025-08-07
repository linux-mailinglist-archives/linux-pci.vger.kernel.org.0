Return-Path: <linux-pci+bounces-33594-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD1BB1DF7B
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 00:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54AE558633A
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 22:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26449227E83;
	Thu,  7 Aug 2025 22:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Slj/xICQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0561E520E;
	Thu,  7 Aug 2025 22:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754607213; cv=none; b=mft6L8xlpZQuX0QhmZCgba4QFyFxBRg2Sg+/jLHAJ1rHDgbTX64qQstAGrAVflhj8dKC6jYSphr0ZfG4r0wO46LHWs7A5VFw2HRVyaz7M93o+WOWxZAzame8NxMEY81WgHLX11yiGkxS+8Mun/teycC7lpXQ9JluVrN+ku5pJ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754607213; c=relaxed/simple;
	bh=npo8HOKabjnzoyZHxs8R+ap98bWNiJjNcSptwtye2Go=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=USfWgY6Jgp+CSc6VVSRp7hdZCaoaJpd443XvCvfVPXIELYdc/eeEnvosEvUDawHTX4qYO6lSSuiTjj7zx3pb/qOlKiMtuf3XU/G+LGiGwLF/BLrRgJsEafVxVoAUrcIIrTsgB04NQeTiW9DN5QB00vk+28VpA/DkFlLcQZ2Idr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Slj/xICQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601DBC4CEEB;
	Thu,  7 Aug 2025 22:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754607212;
	bh=npo8HOKabjnzoyZHxs8R+ap98bWNiJjNcSptwtye2Go=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Slj/xICQcDwA0jKt76iQr0PjUgnpB+SxoUtZXyZ/thkhQZnkdKaGg/S9A39hLdFF4
	 N6tajjI5iHljG/iFMyUQs8W+e+8C4S7jaHcW+IQszabKdFjh9fMxGMEahTWA4IpgqI
	 IbTaSQNhjR41SoSEFLXPirCO0qnre1ucGUO0JeYztpaO7MW26hc5UyBEaBX4EILfv1
	 DKQNtgfGKGnFzQGZgUHzggmqjbJd/OYbVJbOaxMQNh6+JFQsn5Ne2IM3niSkHnDiCm
	 SSYzeY+reP/T53ocO4rJfXpiperHbEaZh2N8KMAoiTnGB6/lIVxDUtRdmkNQ4p4OCD
	 cVvIbi1st1NtQ==
Date: Thu, 7 Aug 2025 17:53:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: dan.j.williams@intel.com
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com, aik@amd.com,
	lukas@wunner.de, Yilun Xu <yilun.xu@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Subject: Re: [PATCH v4 02/10] PCI/IDE: Enumerate Selective Stream IDE
 capabilities
Message-ID: <20250807225331.GA67035@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68952ab060b6d_cff9910033@dwillia2-xfh.jf.intel.com.notmuch>

On Thu, Aug 07, 2025 at 03:37:36PM -0700, dan.j.williams@intel.com wrote:
> Bjorn Helgaas wrote:
> > On Thu, Jul 17, 2025 at 11:33:50AM -0700, Dan Williams wrote:
> > > Link encryption is a new PCIe feature enumerated by "PCIe 6.2 section
> > > 7.9.26 IDE Extended Capability".
> > 
> > > +++ b/drivers/pci/ide.c
> > > @@ -0,0 +1,93 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> > > +
> > > +/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */
> > > +
> > > +#define dev_fmt(fmt) "PCI/IDE: " fmt
> > > +#include <linux/pci.h>
> > > +#include <linux/bitfield.h>
> > 
> > Trend is to alphabetize these.  And I think there should be more
> > #includes here instead of using other things pulled in indirectly:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submit-checklist.rst?id=v6.16#n17
> 
> In this case I think it was only missing a:
> 
> #include <linux/pci_regs.h>
> 
> ...but more includes are needed in follow-on patches. Added those and
> alphabetized.

I assumed dev_fmt was used by dev_printk(), but didn't go back to
look.

