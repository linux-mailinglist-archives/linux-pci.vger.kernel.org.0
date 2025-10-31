Return-Path: <linux-pci+bounces-39912-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7A2C246C4
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 11:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98101A214EA
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 10:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A531624DF;
	Fri, 31 Oct 2025 10:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iEWEp9JC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4050633A024;
	Fri, 31 Oct 2025 10:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761905925; cv=none; b=gV4JLTnXg3lRx+3xzJxZmEkxpPOLPlSAVbUG/oX6hgRrRGUpS9Z5tD9tOyyju3MyszVfsxSOwpVq80AB0KhhG1EpDfRLxRVBqK/vnLEICVci4iAF9u57LiAXP8ulJjhtC0rAdtQCijjTn8l0W+9wBB7IhEcXU8kjnfIALpuetA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761905925; c=relaxed/simple;
	bh=ScQKh0k+g0sLHY6zzPeiiWF3Mx49kdxeKS7TZIXktok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oerCHwtGdqIc67mCjnve1K8p0mD5KA8pvsNKmOGmhCLiUCmx7VINWSH/jWfqLngqpeCKJ4J/f866qQMZB0CsQAFaEs0k5XshzvK+8Vb+085yewvUU/7JA431gZX9Yx3eeWOfuO4PLW34Rf9a23RdP/65PoTvrJpwCV4j6u1HUbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iEWEp9JC; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761905923; x=1793441923;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ScQKh0k+g0sLHY6zzPeiiWF3Mx49kdxeKS7TZIXktok=;
  b=iEWEp9JCYSCTMYEkh6+Zz1rt/s5pZ2VgFxzqpXxW+DRrRf5PNQ7aFvkL
   CJD25IV0pzyfoFdwYjiecfuek128+Cm918K9zI40cDnoaDdvAbIjHd+VH
   lByTnzpanD5vZeQ+iDwzf8rKH7k6E7TP0t4AshFxWu6xgBR+RxtWNSKoY
   qkkCYYOWQLEXyK562JGi39oQHfDMoRo/M8GeCJrOV7VbTEH5UrohnX4PU
   aH/VBCsvk5kusq7fqqhBsR+E/jlX3nrFtmTYO2v9+cGxjtf8Y712UDXAE
   olJqMlsOagBzm9bLb/YzPKqX4yEhtnqA9aCYBwpOkQqji7laDm5s5njJM
   Q==;
X-CSE-ConnectionGUID: wudIQrEYThGBVwKxzKhXrw==
X-CSE-MsgGUID: yP4uDmFtTxqbP1YRHiBnAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="63761119"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="63761119"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 03:18:43 -0700
X-CSE-ConnectionGUID: k25i44LyS2un9PQ5Y6ncag==
X-CSE-MsgGUID: vJDIqqS8RQmFeEw6PNSdLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="185890295"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.56])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 03:18:30 -0700
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
Subject: Re: [PATCH 2/6 v6] ACPI: extlog: Trace CPER PCI Express Error Section
Date: Fri, 31 Oct 2025 11:18:27 +0100
Message-ID: <2351924.vFx2qVVIhK@fdefranc-mobl3>
In-Reply-To: <20251028144816.000018a3@huawei.com>
References:
 <20251023122612.1326748-1-fabio.m.de.francesco@linux.intel.com>
 <20251023122612.1326748-3-fabio.m.de.francesco@linux.intel.com>
 <20251028144816.000018a3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, October 28, 2025 3:48:16=E2=80=AFPM Central European Standard T=
ime Jonathan Cameron wrote:
> On Thu, 23 Oct 2025 14:25:37 +0200
> "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com> wrote:
>=20
> > I/O Machine Check Architecture events may signal failing PCIe components
> > or links. The AER event contains details on what was happening on the w=
ire
> > when the error was signaled.
> >=20
> > Trace the CPER PCIe Error section (UEFI v2.10, Appendix N.2.7) reported
> > by the I/O MCA.
> >=20
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.=
com>
> Hi Fabio,
>=20
> Was taking a fresh look at this as a precursor to looking at later
> patches in series and spotted something that I'm doubtful about.
>=20
> > diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> > index 47d11cb5c912..cefe8d2d8aff 100644
> > --- a/drivers/acpi/acpi_extlog.c
> > +++ b/drivers/acpi/acpi_extlog.c
> > @@ -132,6 +132,34 @@ static int print_extlog_rcd(const char *pfx,
> >  	return 1;
> >  }
> > =20
> > +static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
> > +			      int severity)
> > +{
> > +	struct aer_capability_regs *aer;
> > +	struct pci_dev *pdev;
> > +	unsigned int devfn;
> > +	unsigned int bus;
> > +	int aer_severity;
> > +	int domain;
> > +
> > +	if (!(pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID ||
> > +	      pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO))
>=20
> Looking again, I'm not sure this is as intended.  Is the aim to
> allow for either one of these two?  Or check that that are both present?=
=20
> That is should it be !(A && B) rather than !(A || B)?
>=20
Hi Jonathan,

You're right. We need to check that both are true and return if they are=20
not, then the statement has to be !(A && B).

Thank you,

=46abio=20
>=20
> > +		return;
> > +
> > +	aer_severity =3D cper_severity_to_aer(severity);
> > +	aer =3D (struct aer_capability_regs *)pcie_err->aer_info;
> > +	domain =3D pcie_err->device_id.segment;
> > +	bus =3D pcie_err->device_id.bus;
> > +	devfn =3D PCI_DEVFN(pcie_err->device_id.device,
> > +			  pcie_err->device_id.function);
> > +	pdev =3D pci_get_domain_bus_and_slot(domain, bus, devfn);
> > +	if (!pdev)
> > +		return;
> > +
> > +	pci_print_aer(pdev, aer_severity, aer);
> > +	pci_dev_put(pdev);
> > +}
>=20
>=20





