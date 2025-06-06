Return-Path: <linux-pci+bounces-29081-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0616ACFEDB
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 11:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF803A2E9D
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 09:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3150E2857DE;
	Fri,  6 Jun 2025 09:09:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEAB283FFA;
	Fri,  6 Jun 2025 09:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749200951; cv=none; b=qcR8dq97L0P9IOFiDC3PAc1wg+eajNNN0dHDaUckjyL1B1NtPqL2VfZ8FPFX7n/uaGTXuIFJcvuJBseJmGMtyqCAoBVc8iEwQIGm8obXO+8hVNgH5ZJ28AXXrZ+M3YHqxFxhvJ7vSrE4625JXCDSeQhdiia0qec4Mfy1FHVELfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749200951; c=relaxed/simple;
	bh=+jeEVwHObp/6fHyIWr73Yk7MaqquFkQ03yRNSlJacAg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BkEsHN5QgiXymc2bg6k9+KZX5kDX6ZKhJyd6hDxMa8E38u/k7Tp40B1zT+Ju3+Kjm98/X24FsnYk5U5qCcDNXJTT/4rOY912lqZxYZCaa9a4gCXGePdf+FhCur4yq3jS3OxzpO036DUc9nhzpwNBLIelq0gYgrMj4gLZ8H00TIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bDFkw1065z6L53g;
	Fri,  6 Jun 2025 17:04:56 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 9EDD81404C6;
	Fri,  6 Jun 2025 17:08:57 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Jun 2025 11:08:57 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 6 Jun 2025 11:08:57 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>, "PradeepVineshReddy.Kodamati@amd.com"
	<PradeepVineshReddy.Kodamati@amd.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>, "ming.li@zohomail.com"
	<ming.li@zohomail.com>, "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>, "Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "kobayashi.da-06@fujitsu.com"
	<kobayashi.da-06@fujitsu.com>, "yanfei.xu@intel.com" <yanfei.xu@intel.com>,
	"rrichter@amd.com" <rrichter@amd.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "colyli@suse.de" <colyli@suse.de>,
	"uaisheng.ye@intel.com" <uaisheng.ye@intel.com>,
	"fabio.m.de.francesco@linux.intel.com"
	<fabio.m.de.francesco@linux.intel.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "yazen.ghannam@amd.com"
	<yazen.ghannam@amd.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v9 10/16] cxl/pci: Unify CXL trace logging for CXL
 Endpoints and CXL Ports
Thread-Topic: [PATCH v9 10/16] cxl/pci: Unify CXL trace logging for CXL
 Endpoints and CXL Ports
Thread-Index: AQHb1KxvIyPPJe0PxEWQEmGLwNmn7LP12Fmg
Date: Fri, 6 Jun 2025 09:08:57 +0000
Message-ID: <959acc682e6e4b52ac0283b37ee21026@huawei.com>
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-11-terry.bowman@amd.com>
In-Reply-To: <20250603172239.159260-11-terry.bowman@amd.com>
Accept-Language: en-GB, en-US
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

>-----Original Message-----
>From: Terry Bowman <terry.bowman@amd.com>
>Sent: 03 June 2025 18:23
>To: PradeepVineshReddy.Kodamati@amd.com; dave@stgolabs.net; Jonathan
>Cameron <jonathan.cameron@huawei.com>; dave.jiang@intel.com;
>alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>dan.j.williams@intel.com; bhelgaas@google.com; bp@alien8.de;
>ming.li@zohomail.com; Shiju Jose <shiju.jose@huawei.com>;
>dan.carpenter@linaro.org; Smita.KoralahalliChannabasappa@amd.com;
>kobayashi.da-06@fujitsu.com; terry.bowman@amd.com; yanfei.xu@intel.com;
>rrichter@amd.com; peterz@infradead.org; colyli@suse.de;
>uaisheng.ye@intel.com; fabio.m.de.francesco@linux.intel.com;
>ilpo.jarvinen@linux.intel.com; yazen.ghannam@amd.com; linux-
>cxl@vger.kernel.org; linux-kernel@vger.kernel.org; linux-pci@vger.kernel.o=
rg
>Subject: [PATCH v9 10/16] cxl/pci: Unify CXL trace logging for CXL Endpoin=
ts and
>CXL Ports
>
>CXL currently has separate trace routines for CXL Port errors and CXL Endp=
oint
>errors. This is inconvenient for the user because they must enable
>2 sets of trace routines. Make updates to the trace logging such that a si=
ngle
>trace routine logs both CXL Endpoint and CXL Port protocol errors.
>
>Rename the 'host' field from the CXL Endpoint trace to 'parent' in the uni=
fied
>trace routines. 'host' does not correctly apply to CXL Port devices. Paren=
t is more
>general and applies to CXL Port devices and CXL Endpoints.
>
>Add serial number parameter to the trace logging. This is used for EPs and=
 0 is
>provided for CXL port devices without a serial number.
>
>Below is output of correctable and uncorrectable protocol error logging.
>CXL Root Port and CXL Endpoint examples are included below.
>
>Root Port:
>cxl_aer_correctable_error: device=3D0000:0c:00.0 parent=3Dpci0000:0c seria=
l: 0
>status=3D'CRC Threshold Hit'
>cxl_aer_uncorrectable_error: device=3D0000:0c:00.0 parent=3Dpci0000:0c ser=
ial: 0
>status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable P=
arity
>Error'
>
>Endpoint:
>cxl_aer_correctable_error: device=3Dmem3 parent=3D0000:0f:00.0 serial=3D0
>status=3D'CRC Threshold Hit'
>cxl_aer_uncorrectable_error: device=3Dmem3 parent=3D0000:0f:00.0 serial: 0
>status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable P=
arity
>Error'
>
>Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>---
> drivers/cxl/core/pci.c   | 18 +++++----
> drivers/cxl/core/ras.c   | 14 ++++---
> drivers/cxl/core/trace.h | 84 +++++++++-------------------------------
> 3 files changed, 37 insertions(+), 79 deletions(-)
>
>diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c index
>186a5a20b951..0f4c07fd64a5 100644
>--- a/drivers/cxl/core/pci.c
>+++ b/drivers/cxl/core/pci.c
>@@ -664,7 +664,7 @@ void read_cdat_data(struct cxl_port *port)  }
>EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
>
[...]
> static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data
>*data) diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h in=
dex
>25ebfbc1616c..8c91b0f3d165 100644
>--- a/drivers/cxl/core/trace.h
>+++ b/drivers/cxl/core/trace.h
>@@ -48,49 +48,22 @@
> 	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
> )
>
>-TRACE_EVENT(cxl_port_aer_uncorrectable_error,
>-	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
>-	TP_ARGS(dev, status, fe, hl),
>-	TP_STRUCT__entry(
>-		__string(device, dev_name(dev))
>-		__string(host, dev_name(dev->parent))
>-		__field(u32, status)
>-		__field(u32, first_error)
>-		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
>-	),
>-	TP_fast_assign(
>-		__assign_str(device);
>-		__assign_str(host);
>-		__entry->status =3D status;
>-		__entry->first_error =3D fe;
>-		/*
>-		 * Embed the 512B headerlog data for user app retrieval and
>-		 * parsing, but no need to print this in the trace buffer.
>-		 */
>-		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
>-	),
>-	TP_printk("device=3D%s host=3D%s status: '%s' first_error: '%s'",
>-		  __get_str(device), __get_str(host),
>-		  show_uc_errs(__entry->status),
>-		  show_uc_errs(__entry->first_error)
>-	)
>-);
>-
> TRACE_EVENT(cxl_aer_uncorrectable_error,
>-	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32
>*hl),
>-	TP_ARGS(cxlmd, status, fe, hl),
>+	TP_PROTO(struct device *dev, u64 serial, u32 status, u32 fe,
>+		 u32 *hl),
>+	TP_ARGS(dev, serial, status, fe, hl),
> 	TP_STRUCT__entry(
>-		__string(memdev, dev_name(&cxlmd->dev))
>-		__string(host, dev_name(cxlmd->dev.parent))
>+		__string(name, dev_name(dev))
>+		__string(parent, dev_name(dev->parent))

Hi Terry,

As we pointed out in v8, renaming the fields "memdev" to "name" and "host" =
to "parent"
causes issues and failures in userspace rasdaemon  while parsing the trace =
event data.
Additionally, we can't rename these fields in rasdaemon  due to backward co=
mpatibility.

> 		__field(u64, serial)
> 		__field(u32, status)
> 		__field(u32, first_error)
> 		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
> 	),
> 	TP_fast_assign(
>-		__assign_str(memdev);
>-		__assign_str(host);
>-		__entry->serial =3D cxlmd->cxlds->serial;
>+		__assign_str(name);
>+		__assign_str(parent);
>+		__entry->serial =3D serial;
> 		__entry->status =3D status;
> 		__entry->first_error =3D fe;
> 		/*
>@@ -99,8 +72,8 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
> 		 */
> 		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
> 	),
>-	TP_printk("memdev=3D%s host=3D%s serial=3D%lld: status: '%s' first_error=
:
>'%s'",
>-		  __get_str(memdev), __get_str(host), __entry->serial,
>+	TP_printk("device=3D%s parent=3D%s serial=3D%lld status=3D'%s'
>first_error=3D'%s'",
>+		  __get_str(name), __get_str(parent), __entry->serial,
> 		  show_uc_errs(__entry->status),
> 		  show_uc_errs(__entry->first_error)
> 	)
>@@ -124,42 +97,23 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
> 	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer"
>}	\
> )
>
>-TRACE_EVENT(cxl_port_aer_correctable_error,
>-	TP_PROTO(struct device *dev, u32 status),
>-	TP_ARGS(dev, status),
>-	TP_STRUCT__entry(
>-		__string(device, dev_name(dev))
>-		__string(host, dev_name(dev->parent))
>-		__field(u32, status)
>-	),
>-	TP_fast_assign(
>-		__assign_str(device);
>-		__assign_str(host);
>-		__entry->status =3D status;
>-	),
>-	TP_printk("device=3D%s host=3D%s status=3D'%s'",
>-		  __get_str(device), __get_str(host),
>-		  show_ce_errs(__entry->status)
>-	)
>-);
>-
> TRACE_EVENT(cxl_aer_correctable_error,
>-	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
>-	TP_ARGS(cxlmd, status),
>+	TP_PROTO(struct device *dev, u64 serial, u32 status),
>+	TP_ARGS(dev, serial, status),
> 	TP_STRUCT__entry(
>-		__string(memdev, dev_name(&cxlmd->dev))
>-		__string(host, dev_name(cxlmd->dev.parent))
>+		__string(name, dev_name(dev))
>+		__string(parent, dev_name(dev->parent))

Renaming these fields is an issue for userspace as mentioned above=20
in cxl_aer_uncorrectable_error.

> 		__field(u64, serial)
> 		__field(u32, status)
> 	),
> 	TP_fast_assign(
>-		__assign_str(memdev);
>-		__assign_str(host);
>-		__entry->serial =3D cxlmd->cxlds->serial;
>+		__assign_str(name);
>+		__assign_str(parent);
>+		__entry->serial =3D serial;
> 		__entry->status =3D status;
> 	),
>-	TP_printk("memdev=3D%s host=3D%s serial=3D%lld: status: '%s'",
>-		  __get_str(memdev), __get_str(host), __entry->serial,
>+	TP_printk("device=3D%s parent=3D%s serial=3D%lld status=3D'%s'",
>+		  __get_str(name), __get_str(parent), __entry->serial,
> 		  show_ce_errs(__entry->status)
> 	)
> );
>--
>2.34.1


Thanks,
Shiju

