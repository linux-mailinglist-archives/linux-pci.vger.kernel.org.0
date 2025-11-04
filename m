Return-Path: <linux-pci+bounces-40259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96E6C32673
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 18:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F683B2DDC
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 17:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CE9303C9C;
	Tue,  4 Nov 2025 17:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fE9suEnc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D28E2DCC1B;
	Tue,  4 Nov 2025 17:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278082; cv=none; b=pM6p3BP6Njw4wQjIud4yjMj/x3XLZRhpJSz363M7W6Qxrq9tbddnWDSFo9PLKQ1iNGpUXKvuM8yh4+85RiPsreK+gQH0VJ2YZ9s9emZtZ3DeNGNVvczUWBR4MeamCSIkKEaAFz4nwelbZR1ryets+06LegmZjiYvx7lEkO73lvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278082; c=relaxed/simple;
	bh=umIjh2hxElKZEt0hMfWdEeuXiD8zOf8YcvUahdfvxcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GPI8bTts5YTz28WldjQZR5H6eY5v47ymYRceNrCTlNtRT4cwe2SWfHm56A0T7ykaN/opeSHkiJ1SuBJLF/aJ0UlCCwXLP1+2k3wHXFZ3wvZDsHNwTy1CI+OiXyNqDjlPiL58csDQrAUaf7sE+1lZKha2g5LJsRUBzvUHUusVshQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fE9suEnc; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762278080; x=1793814080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=umIjh2hxElKZEt0hMfWdEeuXiD8zOf8YcvUahdfvxcI=;
  b=fE9suEncE9bwVi1Xg6tlWNTn/QfzjUHg99k6xYyIzFmEZLsv+cNBmRfl
   TgdtbG2hLfa/ePvj9LeVQfBlyaXS8C4lSfwvzU2suaY5jkmpIIxYyht4Z
   tiJjy26aC6iAmGIpcmTSLLaw8ZLBzGKy2jbWsz/SS7ximtsDHwOMJxvvq
   qxiMc30FxU18z3F8ee7GR6I1/2H0AciMAOUEo/6A/ajvPe+lwtbzo0tMv
   1SbWN4wB3+zK3b3drefppS5sULF9WyGXIf19tYpKUVS84FXSDgNUmaAR1
   8zwMNkDmy+DZ5NLQeHHsEi+j9josxmuLlqHhVSjUkRjHbm6207XgN4VOD
   g==;
X-CSE-ConnectionGUID: 4BHkkp39R8uUiOxbP9Or9g==
X-CSE-MsgGUID: rSV6c7BYSYOJpmgoFfOOzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="75062069"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="75062069"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 09:41:19 -0800
X-CSE-ConnectionGUID: fxvhx8QBR6a2sC+c/6MBTA==
X-CSE-MsgGUID: UD5GfdqfRcGrhfQvZcmZFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="192384949"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.211])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 09:41:07 -0800
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Xiaofei Tan <tanxiaofei@huawei.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Guo Weikang <guoweikang.kernel@gmail.com>,
 Xin Li <xin@zytor.com>, Will Deacon <will@kernel.org>,
 Huang Yiwei <quic_hyiwei@quicinc.com>, Gavin Shan <gshan@redhat.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Li Ming <ming.li@zohomail.com>,
 Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Karolina Stolarek <karolina.stolarek@oracle.com>,
 Jon Pan-Doh <pandoh@google.com>, Lukas Wunner <lukas@wunner.de>,
 Shiju Jose <shiju.jose@huawei.com>, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org
Subject:
 Re: [PATCH 4/6 v6] acpi/ghes: Add helper for CXL protocol errors checks
Date: Tue, 04 Nov 2025 18:41:04 +0100
Message-ID: <2925654.DJkKcVGEfx@fdefranc-mobl3>
In-Reply-To: <20251028145415.000034bd@huawei.com>
References:
 <20251023122612.1326748-1-fabio.m.de.francesco@linux.intel.com>
 <20251023122612.1326748-5-fabio.m.de.francesco@linux.intel.com>
 <20251028145415.000034bd@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, October 28, 2025 3:54:15=E2=80=AFPM Central European Standard T=
ime Jonathan Cameron wrote:
> On Thu, 23 Oct 2025 14:25:39 +0200
> "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com> wrote:
>=20
> > Move the CPER CXL protocol errors validity out of
>=20
> validity check
>=20
> > cxl_cper_post_prot_err() to cxl_cper_sec_prot_err_valid() and limit the
>=20
> to new cxl_cper_sec_prot_err_valid()=20
>=20
> as otherwise it sounds like it already exists.
>=20
> > serial number check only to CXL agents that are CXL devices (UEFI v2.10,
> > Appendix N.2.13).
>=20
> Perhaps a little more here on why.  I assume because you are going to have
> a second user for it, but good to say that. Also serves to justify the
> export.
>=20
Hi Jonathan,

All the corrections you made will be applied to the next version.
> >=20
> > Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.=
com>
> > ---
> >  drivers/acpi/apei/ghes.c | 32 ++++++++++++++++++++++----------
> >  include/cxl/event.h      | 10 ++++++++++
> >  2 files changed, 32 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > index d6fe5f020e96..e69ae864f43d 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -706,30 +706,42 @@ static DEFINE_KFIFO(cxl_cper_prot_err_fifo, struc=
t cxl_cper_prot_err_work_data,
> >  static DEFINE_SPINLOCK(cxl_cper_prot_err_work_lock);
> >  struct work_struct *cxl_cper_prot_err_work;
> > =20
> > -static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_=
err,
> > -				   int severity)
> > +int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err)
>=20
> Useful to return an error number?  Or would a bool be better given it is =
either
> valid or not?
>=20
I prefer to return more information when reasonable and leave the callers f=
ree
to use or ignore the specific error number.

=46abio
>
> Otherwise looks good to me,
>=20
> Jonathan
>=20
> >  {
> > -	struct cxl_cper_prot_err_work_data wd;
> > -	u8 *dvsec_start, *cap_start;
> > -
> >  	if (!(prot_err->valid_bits & PROT_ERR_VALID_AGENT_ADDRESS)) {
> >  		pr_err_ratelimited("CXL CPER invalid agent type\n");
> > -		return;
> > +		return -EINVAL;
> >  	}
> > =20
> >  	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
> >  		pr_err_ratelimited("CXL CPER invalid protocol error log\n");
> > -		return;
> > +		return -EINVAL;
> >  	}
> > =20
> >  	if (prot_err->err_len !=3D sizeof(struct cxl_ras_capability_regs)) {
> >  		pr_err_ratelimited("CXL CPER invalid RAS Cap size (%u)\n",
> >  				   prot_err->err_len);
> > -		return;
> > +		return -EINVAL;
> >  	}
> > =20
> > -	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))
> > -		pr_warn(FW_WARN "CXL CPER no device serial number\n");
> > +	if ((prot_err->agent_type =3D=3D RCD || prot_err->agent_type =3D=3D D=
EVICE ||
> > +	     prot_err->agent_type =3D=3D LD || prot_err->agent_type =3D=3D FM=
LD) &&
> > +	    !(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))
> > +		pr_warn_ratelimited(FW_WARN
> > +				    "CXL CPER no device serial number\n");
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(cxl_cper_sec_prot_err_valid);
> > +
> > +static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_=
err,
> > +				   int severity)
> > +{
> > +	struct cxl_cper_prot_err_work_data wd;
> > +	u8 *dvsec_start, *cap_start;
> > +
> > +	if (cxl_cper_sec_prot_err_valid(prot_err))
> > +		return;
> > =20
> >  	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
> > =20
>=20
>=20
>=20





