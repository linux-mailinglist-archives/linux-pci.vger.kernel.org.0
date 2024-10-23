Return-Path: <linux-pci+bounces-15118-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F659ACB50
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 15:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4236E1F21193
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 13:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08081ADFF5;
	Wed, 23 Oct 2024 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="igL3GbwH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A5914A609;
	Wed, 23 Oct 2024 13:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690543; cv=none; b=rXxBFT2TYA656fKxPmm9WoTDyWuOJXuTS77ZH4KWinmdfUzdmlJ8WvNFN9MGNA7Vyaf4zYTZ0LxJGka8V9czUomoyVUQgOXtF885lgyu2Ro49/UPR4vmGYfeHqOBnvaPpWgVyQrnhnqEFsOendHPmB702Bp/oxx+IL3XJ/vMJ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690543; c=relaxed/simple;
	bh=c12i6YS3Zu5lw62vyhst8XtuMC8q5uxDihPxDU8KoDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chw50waMsM2U21inrbXNB0lTOHB1GWXvyY56QpoAVGNMfmiykQ64KPrrvkh0sscTPgEEpzm8ThrycA6j3D8SWoJDMbfC2ZqXZ6JLEHV6WwrePCTZPQr2l8/Ka/hABzhCmsMPRMmsGnysrJomvyg4sXHQTlOrjz82jDo3XEjDpX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=igL3GbwH; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729690542; x=1761226542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c12i6YS3Zu5lw62vyhst8XtuMC8q5uxDihPxDU8KoDc=;
  b=igL3GbwHEYCkmFub7tiA7J3fcNQCV/aaGTyOL73s9C14wr06wz7zD6Hr
   0BPFkGP2ezwR9ViI7HkwGxGunmrgjfYOrsW0t5Bz4TJxG8bsIDSTkY1Rn
   B/ve28F+LNeo7m//U+2dmsTd82jRtlO0eSsxxT0zd9ulStWx1TghQAk2X
   YFFLsdtNyGtcqTI0edqtnuc89NOUZw8ucxuZAp+UJaH4jRAkyKqvYC9JB
   YjzYIxTcwJUEUs9yb4egoXxV4jI7513+CcVwqESRWg4ZduZZ6qCH89xc5
   XzESt4/hNBYzkJN7lkNVCMG4vwS/fJ8Xh0tDpuFsK+ArjSG5kSo2m7Yhn
   w==;
X-CSE-ConnectionGUID: JfYsp20aTJCTlzB7hqAOyg==
X-CSE-MsgGUID: DHC3RciWQIK9MhkcJPHzfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="29387861"
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="29387861"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 06:35:39 -0700
X-CSE-ConnectionGUID: w7cd642VS+SvjDE8PG9fBA==
X-CSE-MsgGUID: tnMxC2zGRQOz496M7vXC2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="85316221"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.245.109])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 06:35:34 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-acpi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 2/2] ACPI: extlog: Trace CPER PCI Express Error Section
Date: Wed, 23 Oct 2024 15:35:18 +0200
Message-ID: <8286502.jJDZkT8p0M@fdefranc-mobl3>
In-Reply-To: <66b27fe8d73fe_c144829438@dwillia2-xfh.jf.intel.com.notmuch>
References:
 <20240527144356.246220-1-fabio.m.de.francesco@linux.intel.com>
 <20240527144356.246220-3-fabio.m.de.francesco@linux.intel.com>
 <66b27fe8d73fe_c144829438@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, August 6, 2024 9:56:24=E2=80=AFPM GMT+2 Dan Williams wrote:
> Fabio M. De Francesco wrote:
> > Currently, extlog_print() (ELOG) only reports CPER PCIe section (UEFI
> > v2.10, Appendix N.2.7) to the kernel log via print_extlog_rcd().
>=20
> I think the critical detail is is that print_extlog_rcd() is only
> triggered when ras_userspace_consumers() returns true. The observation
> is that ras_userspace_consumers() hides information from the trace path
> when the intended purpose of it was to hide duplicate emissions to the
> kernel log when userspace is watching the tracepoints.
>
> Setting aside whether ras_userspace_consumers() is still a good idea or
> not, it is obvious that this patch as is may surprise environments that
> start seeing kernel error logs where the kernel was silent before.
>
> I think the path of least surprise would be to make sure that
> pci_print_aer() optionally skips emitting to the kernel log when not
> needed wanted.

Sorry for replying so late...

I'm not entirely sure that users would not prefer to be surprised by=20
_finally_ seeing kernel error logs for failing PCIe components. I suspect=20
that users might have been confused by not seeing any output.
=20
> So perhaps first do a lead-in patch to optionally quiet the print
> messages in pci_print_aer() and then pass in KERN_DEBUG from the
> extlog_print() path. Then we can decide later what to do about
> ras_userspace_consumers().

Anyway, I'll do it.

> > the similar ghes_do_proc() (GHES) prints to kernel log and calls
> > pci_print_aer() to report via the ftrace infrastructure.
> >=20
> > Add support to report the CPER PCIe Error section also via the ftrace
> > infrastructure by calling pci_print_aer() to make ELOG act consistently
> > with GHES.
>=20
> You might also want to explain a bit about the motivation for this which
> is that I/O Machine Check Arcitecture events may signal failing PCIe
> components or links. The AER event contains details on what was
> happening on the wire when the error was signaled.

Yes, I agree.

> >=20
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Fabio M. De Francesco=20
<fabio.m.de.francesco@linux.intel.com>
> > ---
> >  drivers/acpi/acpi_extlog.c | 30 ++++++++++++++++++++++++++++++
> >  drivers/pci/pcie/aer.c     |  2 +-
> >  include/linux/aer.h        | 13 +++++++++++--
> >  3 files changed, 42 insertions(+), 3 deletions(-)
> >=20
> > [...]
> >
> > +		pci_print_aer(pdev, aer_severity, aer);
>=20
> ...per above this would become:
>=20
>     pci_print_aer(KERN_DEBUG, pdev, aer_severity, aer);
>=20
> [..]
>=20
> Rest of the changes look good to me.

I need to be sure that I understood...

void pci_print_aer(char *level, struct pci_dev *dev, int aer_severity,
                   struct aer_capability_regs *aer)
{
        [...]

        if (printk_get_level(level) <=3D console_loglevel) {
                pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n",
                        status, mask);
                __aer_print_error(dev, &info);
                pci_err(dev, "aer_layer=3D%s, aer_agent=3D%s\n",
                        aer_error_layer[layer], aer_agent_string[agent]);

                if (aer_severity !=3D AER_CORRECTABLE)
                        pci_err(dev, "aer_uncor_severity: 0x%08x\n",
                                aer->uncor_severity);

                if (tlp_header_valid)
                        __print_tlp_header(dev, &aer->header_log);
        }

        [...]
}=09

It would require changing a couple of call sites, like in   =20
aer_recover_work_func():

pci_print_aer(KERN_ERR, pdev, entry.severity, entry.regs);
=20
Would you please confirm that the code shown above is what
you asked for?

Thanks,

=46abio



