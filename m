Return-Path: <linux-pci+bounces-28820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE324ACBAD7
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 20:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09331189585F
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 18:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EB9227B9A;
	Mon,  2 Jun 2025 18:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fmSQW/5Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E166EAF9;
	Mon,  2 Jun 2025 18:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748887872; cv=none; b=Iw1PfzlIpbWW2nq5xiVxGssu64okMRlooilb/nE7/vGv8CS1a13VMVVdwP2cKQyB27G4Y5/08p/DxJ6gjnVvu6wW9dySlaLjemU5rkZKCVJctHYelYv6Lz7hZn+lWqPSF1F2tN+yzUgchAVXDIqnx+E1oNy/eHMIqD41bmOcpqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748887872; c=relaxed/simple;
	bh=30U5FrzZe477PkMourbldSSCDpz4fRDaC700uOnf3C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FV1qs+I8v7408En5xYve6KejJtMYw+9+POj8dNFMRQW4y6WF9pyoo1N5DCYVvjOMcA0ny2OjXaJNUPhWubN/QcCiDXj3ECj34ZrtUSKChyUfRZkkABwPd/I2xJ7WE12BT22832FNpYWPY0Xv4XA+dx60MEmMf/6GvCUYdvI1o0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fmSQW/5Z; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748887871; x=1780423871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=30U5FrzZe477PkMourbldSSCDpz4fRDaC700uOnf3C0=;
  b=fmSQW/5ZVmnMp5slep4QinOaqcZjzpm4c4TKX1SinJezIVG/Z/aOJJZW
   C3k0xzSKuvArrDK70JCWs4AXwUdRd7GGqCULxHnjs0xzX5+a+DvbegBuC
   JpK1tTojevQjKbi070x6IXBqxLcD7ZMmWqWQ+53Nn/BVjj/+CrRo4KRp9
   lZGHi0Bbn5z8viq+1BsxZQhNXck99FQ8heEvzyL6CAV9itYegZ74l1JR3
   zDZfHc7rqhBdmu2DUEXd7jxZQ7W0cG75UWk/baTbLBHhNegXoIeW757mx
   O/MH/BCtyYsSnAO7m+XOanmOt2M9XkWSxvqe9HDWLjgnZKUzHNji3zH8j
   g==;
X-CSE-ConnectionGUID: DFLFctPOQiSFkgCBQxHYnA==
X-CSE-MsgGUID: X6wdajwUS/yz3qxThmtmtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="50770704"
X-IronPort-AV: E=Sophos;i="6.16,204,1744095600"; 
   d="scan'208";a="50770704"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 11:11:10 -0700
X-CSE-ConnectionGUID: rmcKHSDgT8WBm+xG+YxC8w==
X-CSE-MsgGUID: OZrs+IS/S4yOMpwDesH9+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,204,1744095600"; 
   d="scan'208";a="148467703"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.244])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 11:11:04 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-cxl@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH 4/4 v2] ACPI: extlog: Trace CPER CXL Protocol Errors
Date: Mon, 02 Jun 2025 20:06:28 +0200
Message-ID: <2947754.vYhyI6sBWr@fdefranc-mobl3>
In-Reply-To: <20250429182055.GB76257@yaz-khff2.amd.com>
References:
 <20250429172109.3199192-1-fabio.m.de.francesco@linux.intel.com>
 <20250429172109.3199192-5-fabio.m.de.francesco@linux.intel.com>
 <20250429182055.GB76257@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, April 29, 2025 8:20:55=E2=80=AFPM Central European Summer Time =
Yazen Ghannam wrote:
> On Tue, Apr 29, 2025 at 07:21:09PM +0200, Fabio M. De Francesco wrote:
> > When Firmware First is enabled, BIOS handles errors first and then it
> > makes them available to the kernel via the Common Platform Error Record
> > (CPER) sections (UEFI 2.10 Appendix N). Linux parses the CPER sections
> > via one of two similar paths, either ELOG or GHES.
> >=20
> > Currently, ELOG and GHES show some inconsistencies in how they report to
> > userspace via trace events.
> >=20
> > Therfore make the two mentioned paths act similarly by tracing the CPER
> > CXL Protocol Error Section (UEFI v2.10, Appendix N.2.13) signaled by the
> > I/O Machine Check Architecture and reported by BIOS in FW-First.
> >=20
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.=
com>
> > ---
> >  drivers/acpi/acpi_extlog.c | 60 ++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/core/ras.c     |  6 ++++
> >  include/cxl/event.h        |  2 ++
> >  3 files changed, 68 insertions(+)
> >=20
> > diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> > index 7d7a813169f1..8f2ff3505d47 100644
> > --- a/drivers/acpi/acpi_extlog.c
> > +++ b/drivers/acpi/acpi_extlog.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/ratelimit.h>
> >  #include <linux/edac.h>
> >  #include <linux/ras.h>
> > +#include <cxl/event.h>
> >  #include <acpi/ghes.h>
> >  #include <asm/cpu.h>
> >  #include <asm/mce.h>
> > @@ -157,6 +158,60 @@ static void extlog_print_pcie(struct cper_sec_pcie=
 *pcie_err,
> >  	}
> >  }
> > =20
> > +static void
> > +extlog_cxl_cper_handle_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> > +				int severity)
> > +{
> > +#ifdef CONFIG_ACPI_APEI_PCIEAER
>=20
> Why not apply this check on the function prototype?
>=20
This function is static.
>
> Reference: Documentation/process/coding-style.rst
> 	   Section 21) Conditional Compilation
>=20
> > +	struct cxl_cper_prot_err_work_data wd;
> > +	u8 *dvsec_start, *cap_start;
> > +
> > +	if (!(prot_err->valid_bits & PROT_ERR_VALID_AGENT_ADDRESS)) {
> > +		pr_err_ratelimited("CXL CPER invalid agent type\n");
> > +		return;
> > +	}
> > +
> > +	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
> > +		pr_err_ratelimited("CXL CPER invalid protocol error log\n");
> > +		return;
> > +	}
> > +
> > +	if (prot_err->err_len !=3D sizeof(struct cxl_ras_capability_regs)) {
> > +		pr_err_ratelimited("CXL CPER invalid RAS Cap size (%u)\n",
> > +				   prot_err->err_len);
> > +		return;
> > +	}
> > +
> > +	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))
> > +		pr_warn(FW_WARN "CXL CPER no device serial number\n");
>=20
> Is this a requirement (in the spec) that we should warn users about?
>=20
> The UEFI spec says that serial number is only used if "CXL agent" is a
> "CXL device".
>=20
> "CXL ports" won't have serial numbers. So this will be a false warning
> for port errors.
>=20
I'll add a test and print that warning only if agent is a device (RCD,
DEVICE, LD, FMLD).
>
> > +
> > +	switch (prot_err->agent_type) {
> > +	case RCD:
> > +	case DEVICE:
> > +	case LD:
> > +	case FMLD:
> > +	case RP:
> > +	case DSP:
> > +	case USP:
> > +		memcpy(&wd.prot_err, prot_err, sizeof(wd.prot_err));
> > +
> > +		dvsec_start =3D (u8 *)(prot_err + 1);
> > +		cap_start =3D dvsec_start + prot_err->dvsec_len;
> > +
> > +		memcpy(&wd.ras_cap, cap_start, sizeof(wd.ras_cap));
> > +		wd.severity =3D cper_severity_to_aer(severity);
> > +		break;
> > +	default:
> > +		pr_err_ratelimited("CXL CPER invalid agent type: %d\n",
>=20
> "invalid" is too harsh given that the specs may be updated. Maybe say
> "reserved" or "unknown" or "unrecognized" instead.
>=20
> Hopefully things will settle down to where a user will be able to have a
> system with newer CXL "agents" without *requiring* a kernel update. :)
>
I'll replace "invalid" with "unknown".
>=20
> Thanks,
> Yazen
>=20
Thanks,

=46abio




