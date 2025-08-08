Return-Path: <linux-pci+bounces-33639-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 361A9B1ECB3
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 17:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA402A07768
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 15:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2039B286419;
	Fri,  8 Aug 2025 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbrripIs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A0A286411;
	Fri,  8 Aug 2025 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668758; cv=none; b=ltzYzvbdohwNMysCGPIf6iTHGKab+FkiLxYzQXq7eq9lopfDjF3HjfdymJRXl+yxYVEYhvjQlXRGQ2mX6AGFsoMuqyKPOk2bZIRt4C1HdvfFFy0e8tWg2UzM5C3it1KGbmwP3c1U9GhRe2vlYyUpg05hHG1ymeoe1HFOW+/dp9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668758; c=relaxed/simple;
	bh=PVQKFnJjPudW7qzUzLqz1ZVsKh2g/sMt031iV+UjNN8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nE0MlL6CP0tNuQK3xrqhX4oJslMa1bZXItsbCCAbEuSdUN+0/8v34MvVtDx9/VA1B8ZBQoBHL3yFy4FNXxXl2KxFcQcf5rwUWdrsyJlU/tRHeMiNAYOO2UTJXP+Q3zcG1JwEeHaMgXP83QY/WYUSVz9axlg/ci2tONw7FdVc2lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbrripIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50EC1C4CEED;
	Fri,  8 Aug 2025 15:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754668758;
	bh=PVQKFnJjPudW7qzUzLqz1ZVsKh2g/sMt031iV+UjNN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XbrripIsMXp1UFZAXlz7BhATumAF1z+EywORkdb/xs0N4kvXWTU5FzXuWVwk+wlN/
	 w/EWjJ1es4y5rz7Nh+WPyCAEvRE+QdkfsIeeIHvptB7hS66DtS/CJoxTCDdTS5Tgl/
	 xMwti+P4Kc8TnroV0qCMdCrAndiiLd2fJA8YyZanYee7iP7BbevcfO9JeHo53c9BpN
	 okzZijZ3Umgl/8dq0VdBP30WhDoPHYfzU9mC7DG+/ssfYwuYSISwdTaGVFU0/ZJNFM
	 3OQwagcJ6VLy7xtTR+0NOea2SpQi5UZNgjhM6179yavgxg1GYf9TCL6KPbQD+QBwwV
	 k3yNVEWnPx72w==
Date: Fri, 8 Aug 2025 10:59:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: dan.j.williams@intel.com
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com, aik@amd.com,
	lukas@wunner.de, Yilun Xu <yilun.xu@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Subject: Re: [PATCH v4 02/10] PCI/IDE: Enumerate Selective Stream IDE
 capabilities
Message-ID: <20250808155916.GA91340@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68955e275b7a8_184e1f10070@dwillia2-xfh.jf.intel.com.notmuch>

On Thu, Aug 07, 2025 at 07:17:11PM -0700, dan.j.williams@intel.com wrote:
> Bjorn Helgaas wrote:
> > On Thu, Aug 07, 2025 at 03:37:36PM -0700, dan.j.williams@intel.com wrote:
> > > Bjorn Helgaas wrote:
> > > > On Thu, Jul 17, 2025 at 11:33:50AM -0700, Dan Williams wrote:
> > > > > Link encryption is a new PCIe feature enumerated by "PCIe 6.2 section
> > > > > 7.9.26 IDE Extended Capability".
> > > > 
> > > > > +++ b/drivers/pci/ide.c
> > > > > @@ -0,0 +1,93 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> > > > > +
> > > > > +/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */
> > > > > +
> > > > > +#define dev_fmt(fmt) "PCI/IDE: " fmt
> > > > > +#include <linux/pci.h>
> > > > > +#include <linux/bitfield.h>
> > > > 
> > > > Trend is to alphabetize these.  And I think there should be more
> > > > #includes here instead of using other things pulled in indirectly:
> > > > 
> > > >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submit-checklist.rst?id=v6.16#n17
> > > 
> > > In this case I think it was only missing a:
> > > 
> > > #include <linux/pci_regs.h>
> > > 
> > > ...but more includes are needed in follow-on patches. Added those and
> > > alphabetized.
> > 
> > I assumed dev_fmt was used by dev_printk(), but didn't go back to
> > look.
> 
> Yes, but it is interesting from a "include what you use" perspective.
> This file is only using pci_info() defined in pci.h. It just so happens
> that pci_info() is a wrapper for dev_info(). So it is a bit of a
> layering violation to know that dev_fmt can be used to prefix
> pci_<level> messages and must be defined before any include.
> 
> I could add a pci_fmt, but it would need to accommodate these too:
> 
> drivers/pci/pcie/aer.c:15:#define pr_fmt(fmt) "AER: " fmt
> drivers/pci/pcie/aer.c:16:#define dev_fmt pr_fmt
> drivers/pci/pcie/dpc.c:9:#define dev_fmt(fmt) "DPC: " fmt
> drivers/pci/pcie/edr.c:9:#define dev_fmt(fmt) "EDR: " fmt
> drivers/pci/pcie/err.c:13:#define dev_fmt(fmt) "AER: " fmt
> drivers/pci/pcie/pme.c:10:#define dev_fmt(fmt) "PME: " fmt

Seems like too much.  You used pci_info(), which is supplied by
<linux/pci.h>, so I think that's enough.  I would say it's pci.h's
responsibility to include things *it* depends on.  I didn't realize
how little was actually in ide.c at this point.

Bjorn

