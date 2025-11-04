Return-Path: <linux-pci+bounces-40231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F37FFC3228A
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 17:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 950BF4EB3BD
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 16:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA5E33769A;
	Tue,  4 Nov 2025 16:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fEUCTmJb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DDD295D90;
	Tue,  4 Nov 2025 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275212; cv=none; b=jr9dsgsv5WmQt5ipHpA6w0Hvyg/oQN1D8qWC8B8RSTnkMZSmkovjUZe/EI0uGSi8M5UHuJ9AzC6QCVrwG2FKxmNR/nMV4k7uyjnHh1q/N7dvQA58u04KdNBIizKwEJf+SjD8rGwjfWA2QviKIi2939iLiupYuT0TG6gtsya8IvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275212; c=relaxed/simple;
	bh=0Vi8CmVpksI68INMwO9Cwr5Wqs6m/qtWAkyblVIpvsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hPxUqHyqP+o0UjtkBEU/OsNeg1SMaWIvSk3FArj2k1ckEFpZGhQu6FxJLbhY5RfTa7WGfTsiasATlYCbeHiHsUOaUf46tJQpwsictRAxs+XxVOFzOGi7pZpy/KI6QZTdy3YLIHFRQN9tH6Py8JjyqNKMO9m1aNUdfMFATaKNiIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fEUCTmJb; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762275210; x=1793811210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0Vi8CmVpksI68INMwO9Cwr5Wqs6m/qtWAkyblVIpvsA=;
  b=fEUCTmJbejJVfeAyC0VUOsYI2N6ypx+rW3Ggn8++ogS9ojgNdtZ4YKZh
   aECK6yPNxjidn/XWkOGMc5f/NfcZ/cHCNhC9sC6NUygrYNrV4+UlD8LPY
   bJirW2DbB0dy7dvftsmSmqem4dG0rsBUF8x2SosWlVqvVPWjulsGx4kvS
   140tEMi4SI1hDByumXMTgGe5znz4En3vt6G+hxB5lln1fuQyigPBHCLRU
   cN05Ex9jC/BTve6DQfC8DWlOX8dywZAmSprZ42Lb8AfWHFAGwC2uJRFf1
   9LT5fNorMd4Us/X9/q6cj83wf/XHW5/mK/I9fkh6RGPBeZqGIOHohoma/
   A==;
X-CSE-ConnectionGUID: eD5TMTBgRiCQQOoSvYla2g==
X-CSE-MsgGUID: k2pMSIZ5Q0aeltakML3p/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="64474125"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="64474125"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 08:53:30 -0800
X-CSE-ConnectionGUID: MacTnz2bToWrXxp7w5uRHw==
X-CSE-MsgGUID: SWyiQwSoSH2xTfhg7s/xyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="187057481"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.211])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 08:53:20 -0800
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
 Re: [PATCH 6/6 v6] ACPI: extlog: Trace CPER CXL Protocol Error Section
Date: Tue, 04 Nov 2025 17:53:18 +0100
Message-ID: <4532273.UPlyArG6xL@fdefranc-mobl3>
In-Reply-To: <20251028150609.000023bf@huawei.com>
References:
 <20251023122612.1326748-1-fabio.m.de.francesco@linux.intel.com>
 <20251023122612.1326748-7-fabio.m.de.francesco@linux.intel.com>
 <20251028150609.000023bf@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, October 28, 2025 4:06:09=E2=80=AFPM Central European Standard T=
ime Jonathan Cameron wrote:
> On Thu, 23 Oct 2025 14:25:41 +0200
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
>=20
> Just one small question.   With that addressed,=20
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>=20
> > diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> > index 2731ba3a0799..3f527b0c6509 100644
> > --- a/drivers/cxl/core/ras.c
> > +++ b/drivers/cxl/core/ras.c
> > @@ -105,6 +105,12 @@ static void cxl_cper_handle_prot_err(struct cxl_cp=
er_prot_err_work_data *data)
> >  		cxl_cper_trace_uncorr_prot_err(cxlmd, data->ras_cap);
> >  }
> > =20
> > +void cxl_cper_ras_handle_prot_err(struct cxl_cper_prot_err_work_data *=
wd)
>=20
> Why do we need this wrapper?  The name is a bit more general, so if you
> do need it, then why not instead just rename cxl_cper_handle_prot_err()
>=20
Actually, on a second thought I believe that we don't need either this
wrapper or renaming cxl_cper_handle_prot_err(). I'll export the latter
as it is.

=46abio
> > +{
> > +	cxl_cper_handle_prot_err(wd);
> > +}
> > +EXPORT_SYMBOL_GPL(cxl_cper_ras_handle_prot_err);
> > +
> >  static void cxl_cper_prot_err_work_fn(struct work_struct *work)
> >  {
> >  	struct cxl_cper_prot_err_work_data wd;
> > diff --git a/include/cxl/event.h b/include/cxl/event.h
> > index 94081aec597a..a37eef112411 100644
> > --- a/include/cxl/event.h
> > +++ b/include/cxl/event.h
> > @@ -340,4 +340,6 @@ cxl_cper_setup_prot_err_work_data(struct cxl_cper_p=
rot_err_work_data *wd,
> >  }
> >  #endif
> > =20
> > +void cxl_cper_ras_handle_prot_err(struct cxl_cper_prot_err_work_data *=
wd);
> > +
> >  #endif /* _LINUX_CXL_EVENT_H */
>=20
>=20





