Return-Path: <linux-pci+bounces-44973-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB4ED25857
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 16:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B98ED3013565
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 15:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DD639449B;
	Thu, 15 Jan 2026 15:55:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1252D97BE;
	Thu, 15 Jan 2026 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768492530; cv=none; b=rGSGp6+UCDvLsob8RkDVaWU0I2nZGubdjgw0ezB1/rjmZfrq7ZfsWs4MmVAg9qY0UdQabh5Kb1Y+6bHFvrBwCntQ60I5NaHzftHdm8cJ5w88VJEglNvRWzBpJDpWmQOmi/ogYyq5ze6K6eI8JT3A+iCzjJ13Tmc94pZw3WEqV1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768492530; c=relaxed/simple;
	bh=9BccyQp5id9ZaXUaCFNfUjVe//9U9MhNJeW2s4KCTSg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I9JAzYPDt2cHeOiAgza5+VeGTQcIkokafoysy9jqwLaLSIzA7ffh3+apNprpnxlmLvP94TjVYnof8nsN0lVdVsLbq6+eYbRAVS7+ZIlj/GEJ28aSOp+KSp/RzmnO0Du2bhxkDD/m26QSVO/8dUsCtvfJmTHg8oE1LzlQj9h5d4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dsSHG4Jj1zJ468l;
	Thu, 15 Jan 2026 23:55:06 +0800 (CST)
Received: from frapema500006.china.huawei.com (unknown [7.182.19.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 2040F40563;
	Thu, 15 Jan 2026 23:55:23 +0800 (CST)
Received: from frapema500006.china.huawei.com (7.182.19.102) by
 frapema500006.china.huawei.com (7.182.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 15 Jan 2026 16:55:22 +0100
Received: from frapema500006.china.huawei.com ([7.182.19.102]) by
 frapema500006.china.huawei.com ([7.182.19.102]) with mapi id 15.02.1544.011;
 Thu, 15 Jan 2026 16:55:21 +0100
From: Mauro Carvalho Chehab <M.Chehab@huawei.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Terry Bowman
	<terry.bowman@amd.com>
CC: "dave@stgolabs.net" <dave@stgolabs.net>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	Shiju Jose <shiju.jose@huawei.com>, "ming.li@zohomail.com"
	<ming.li@zohomail.com>, "mchehab+huawei@kernel.org"
	<mchehab+huawei@kernel.org>, "Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "rrichter@amd.com"
	<rrichter@amd.com>, "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	"PradeepVineshReddy.Kodamati@amd.com" <PradeepVineshReddy.Kodamati@amd.com>,
	"lukas@wunner.de" <lukas@wunner.de>, "Benjamin.Cheatham@amd.com"
	<Benjamin.Cheatham@amd.com>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "alucerop@amd.com" <alucerop@amd.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v14 14/34] PCI/AER: Report CXL or PCIe bus type in AER
 trace logging
Thread-Topic: [PATCH v14 14/34] PCI/AER: Report CXL or PCIe bus type in AER
 trace logging
Thread-Index: AQHchY5eLtwbwKSK7EavhTz2Y1BayrVTYVOA
Date: Thu, 15 Jan 2026 15:55:21 +0000
Message-ID: <e3d57c01a14749199b5c042b7f8e7b37@huawei.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
	<20260114182055.46029-15-terry.bowman@amd.com>
 <20260114194539.0000662b@huawei.com>
In-Reply-To: <20260114194539.0000662b@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> > The AER service driver and aer_event tracing currently log 'PCIe Bus Ty=
pe'
> > for all errors. Update the driver and aer_event tracing to log 'CXL=20
> > Bus Type' for CXL device errors.
> >=20
> > This requires that AER can identify and distinguish between PCIe=20
> > errors and CXL errors.
> >=20
> > Introduce boolean 'is_cxl' to 'struct aer_err_info'. Add assignment in
> > aer_get_device_error_info() and pci_print_aer().
> >=20
> > Update the aer_event trace routine to accept a bus type string paramete=
r.
> >=20
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> I wonder if it is worth using __print_symbolic() etc and an integer stora=
ge rather than a string for in the tracepoints.
> However, not really that important to me as the strings are small anyway =
and there is no precedence of this in ras trace events.
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

It would be a lot better to pass integer values instead of strings. Right n=
ow, I'm working on a way
to have a CI to check if Kernel + rasdaemon is doing the right thing. The i=
dea is to inject errors
on QEMU via QMP interface (main patches already there at QEMU tree).

By using integers, it sounds easier to veriy if everything was properly han=
dled, as we can
ignore __print_symbolic at rasdaemon, picking the actual values directly.

Regards,
Mauro

