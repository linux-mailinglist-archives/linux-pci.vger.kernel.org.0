Return-Path: <linux-pci+bounces-31531-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6609FAF947F
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 15:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BE241CA7E66
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 13:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845243074B2;
	Fri,  4 Jul 2025 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y9yeLqe6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44C9307489;
	Fri,  4 Jul 2025 13:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751636636; cv=none; b=aJG7rfO3IBXMu7upV0MHIRlVYZIaIn8ncRkUjmg9QdmEMW6fNcYYhqq7zsMco9vK1DSNwufI0U2BTuJ6soQPEbkAu2meB7uZaqZaC7LN+9jhcmlg5LveThtzWtlFy+TFswSB6coWAdnU5EHbBLur4iH/wBTuEvi5BWleDEVHW80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751636636; c=relaxed/simple;
	bh=KmpX5zxlGsQARhawRN1W4dV47zBrJ2MU4Gpq1Itt2mE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MpGS2wI7ZFfOBwoc+5PY4qp3RBOoZw9lY2NUrN9bpUPx7YKZvbcbJxs4UCMg8Dj1lFw3x8sKFIh8+T1Xl0LK8BQNEjpD4w2KZATT6QvGwPZc5aMni+VjtAyhySVviKAr6Mfhl8QlVQMHOalCb3WeXF85j+hFTEwk2conUmJn7Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y9yeLqe6; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751636635; x=1783172635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KmpX5zxlGsQARhawRN1W4dV47zBrJ2MU4Gpq1Itt2mE=;
  b=Y9yeLqe6MVlKuwK9w2KkuyWgmqljXZIO8JIQCjtHar6A93uGzi4q1xwd
   jYIdtzbG5yWxL6fX5GZqdhr4NTk1WbdCEv8cYBYma1XU0DOU8sMX7cTjk
   NIE4nGumlBGlYmVoA3YBrXZ6/864Hl2UPleC0hS2kxuOgiTI6pJ13/+wr
   RVP3yeVECMqnOhKw2urlNwJEcCpl4k/tExJukkSHSQDpAH05K4RLLr1Rj
   BjOYgBmQRcy4DAhioehuyrZBSrUUoK4GUIfyDJNJyNvB8lRr1yK9HP3VY
   rBsSrZPRzHBADq7bwcL1SDhwDnk9+xC2agr1EWdpdQDi6W+wM5F+9bRsX
   g==;
X-CSE-ConnectionGUID: j/z16jrERcqXnCm9ncKNdg==
X-CSE-MsgGUID: qn7oUZ5MQQ+uZV1HRfZTnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11484"; a="57745979"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="57745979"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 06:43:53 -0700
X-CSE-ConnectionGUID: Xlct5SpASzGOsWnvRo5+Cg==
X-CSE-MsgGUID: al4pzX24RQSY0KYIv3BFLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="155408398"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.112])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 06:43:46 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 linux-edac@vger.kernel.org,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject:
 Re: [PATCH 3/3 v4] ACPI: extlog: Trace CPER CXL Protocol Error Section
Date: Fri, 04 Jul 2025 15:43:43 +0200
Message-ID: <2114182.IDvDuAF1LB@fdefranc-mobl3>
In-Reply-To: <20250701140503.00006a48@huawei.com>
References:
 <20250623145453.1046660-1-fabio.m.de.francesco@linux.intel.com>
 <20250623145453.1046660-4-fabio.m.de.francesco@linux.intel.com>
 <20250701140503.00006a48@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, July 1, 2025 3:05:03=E2=80=AFPM Central European Summer Time Jo=
nathan Cameron wrote:
> On Mon, 23 Jun 2025 16:54:20 +0200
> "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com> wrote:
>=20
> > When Firmware First is enabled, BIOS handles errors first and then it m=
akes
> > them available to the kernel via the Common Platform Error Record (CPER)
> > sections (UEFI 2.10 Appendix N). Linux parses the CPER sections via one=
 of
> > two similar paths, either ELOG or GHES. The errors managed by ELOG are
> > signaled to the BIOS by the I/O Machine Check Architecture (I/O MCA).
> >=20
> > Currently, ELOG and GHES show some inconsistencies in how they report to
> > userspace via trace events.
> >=20
> > Therefore, make the two mentioned paths act similarly by tracing the CP=
ER
> > CXL Protocol Error Section (UEFI v2.10, Appendix N.2.13).
> >=20
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>
> > Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.=
com>
> > ---
> >  drivers/acpi/acpi_extlog.c | 62 ++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/core/ras.c     |  6 ++++
> >  include/cxl/event.h        |  2 ++
> >  3 files changed, 70 insertions(+)
> >=20
> > diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> > index cefe8d2d8affc..9a37b08aacfea 100644
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
> > @@ -160,6 +161,60 @@ static void extlog_print_pcie(struct cper_sec_pcie=
 *pcie_err,
> >  	pci_dev_put(pdev);
> >  }
> > =20
> > +static void
> > +extlog_cxl_cper_handle_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> > +				int severity)
> > +{
> > +	struct cxl_cper_prot_err_work_data wd;
> > +	u8 *dvsec_start, *cap_start;
>=20
>=20
> A bunch of this is identical to cxl_cper_post_prot_err()
> Can we factor that stuff out for common use?
>=20
> > +
> > +	if (!(prot_err->valid_bits & PROT_ERR_VALID_AGENT_ADDRESS)) {
> > +		pr_warn_ratelimited("CXL CPER invalid agent type\n");
> > +		return;
> > +	}
> > +
> > +	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
> > +		pr_warn_ratelimited("CXL CPER invalid protocol error log\n");
> > +		return;
> > +	}
> > +
> > +	if (prot_err->err_len !=3D sizeof(struct cxl_ras_capability_regs)) {
> > +		pr_warn_ratelimited("CXL CPER invalid RAS Cap size (%u)\n",
> > +				    prot_err->err_len);
> > +		return;
> > +	}
> > +
> > +	if ((prot_err->agent_type =3D=3D RCD || prot_err->agent_type =3D=3D D=
EVICE ||
> > +	     prot_err->agent_type =3D=3D LD || prot_err->agent_type =3D=3D FM=
LD) &&
> > +	    !(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))
> > +		pr_warn_ratelimited(FW_WARN
> > +				    "CXL CPER no device serial number\n");
>=20
> Whilst some of this check isn't present in cxl_cper_post_prot_err(), it s=
hould
> be harmless.
>
Maybe all these checks should go to a static helper in cxl/core/ras.c which
cxl_cper_handle_prot_err can call? But I'm not entirely sure yet it would=20
really be worth. Anyway, I'll look into it.

Thanks,

=46abio




