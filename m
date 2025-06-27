Return-Path: <linux-pci+bounces-30924-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E112AEB78D
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 14:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C6F3BC05F
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 12:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C9E29C32C;
	Fri, 27 Jun 2025 12:22:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B441417A2F0;
	Fri, 27 Jun 2025 12:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751026966; cv=none; b=RsI98UcZO2UrcGSoVvF9hZAj3gQw9RQB7kYS1JHfQ1MGsf7kgRG6OOmRr8K9y4wcS+Kat8Z/+DmBL1JJs4X/ky+zWORqgpO98HDCCsamSR/yMRaV4mXrHSOp2q/THaWI0O4aZTAYs0k75xLAEStMyqV2cKQQVIBhZudDjtXIJGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751026966; c=relaxed/simple;
	bh=9qpYac8UwarZka5WXpLgL6ussyD+oXRxLVM+NICyN28=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B4hDfw3N5Wv+XJqb7xgNJ1WtB5o7vnaOSrNwhCsUJRuO45RV6LGBeQ/Cyytz9sLSNpwchOChMrHg+rvgC9K4jYriN3Xwbx7noyqOuTYTFtoiGp4YY/AtfwZT6rapiJpvaotM04pkkD80KMLVIhWcG9OYBwmziOiStUo4do7DLFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bTF6R3cwlz6M4ct;
	Fri, 27 Jun 2025 20:21:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 248E71402EC;
	Fri, 27 Jun 2025 20:22:40 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 27 Jun 2025 14:22:39 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 27 Jun 2025 14:22:39 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"ming.li@zohomail.com" <ming.li@zohomail.com>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "rrichter@amd.com"
	<rrichter@amd.com>, "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	"PradeepVineshReddy.Kodamati@amd.com" <PradeepVineshReddy.Kodamati@amd.com>,
	"lukas@wunner.de" <lukas@wunner.de>, "Benjamin.Cheatham@amd.com"
	<Benjamin.Cheatham@amd.com>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v10 12/17] cxl/pci: Unify CXL trace logging for CXL
 Endpoints and CXL Ports
Thread-Topic: [PATCH v10 12/17] cxl/pci: Unify CXL trace logging for CXL
 Endpoints and CXL Ports
Thread-Index: AQHb5uwA2IgfeKd+EU2rsxjkddOTWrQW5rQg
Date: Fri, 27 Jun 2025 12:22:39 +0000
Message-ID: <6b8b65df7c334043863b1464e04957db@huawei.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-13-terry.bowman@amd.com>
In-Reply-To: <20250626224252.1415009-13-terry.bowman@amd.com>
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
>Sent: 26 June 2025 23:43
>To: dave@stgolabs.net; Jonathan Cameron <jonathan.cameron@huawei.com>;
>dave.jiang@intel.com; alison.schofield@intel.com; dan.j.williams@intel.com=
;
>bhelgaas@google.com; Shiju Jose <shiju.jose@huawei.com>;
>ming.li@zohomail.com; Smita.KoralahalliChannabasappa@amd.com;
>rrichter@amd.com; dan.carpenter@linaro.org;
>PradeepVineshReddy.Kodamati@amd.com; lukas@wunner.de;
>Benjamin.Cheatham@amd.com;
>sathyanarayanan.kuppuswamy@linux.intel.com; terry.bowman@amd.com;
>linux-cxl@vger.kernel.org
>Cc: linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org
>Subject: [PATCH v10 12/17] cxl/pci: Unify CXL trace logging for CXL Endpoi=
nts
>and CXL Ports
>
>CXL currently has separate trace routines for CXL Port errors and CXL Endp=
oint
>errors. This is inconvenient for the user because they must enable
>2 sets of trace routines. Make updates to the trace logging such that a si=
ngle
>trace routine logs both CXL Endpoint and CXL Port protocol errors.
>
>Keep the trace log fields 'memdev' and 'host'. While these are not accurat=
e for
>non-Endpoints the fields will remain as-is to prevent breaking userspace R=
AS
>trace consumers.
>
>Add serial number parameter to the trace logging. This is used for EPs and=
 0 is
>provided for CXL port devices without a serial number.
>
>Below is output of correctable and uncorrectable protocol error logging.
>CXL Root Port and CXL Endpoint examples are included below.
>
>Root Port:
>cxl_aer_correctable_error: memdev=3D0000:0c:00.0 host=3Dpci0000:0c serial:=
 0
>status=3D'CRC Threshold Hit'
>cxl_aer_uncorrectable_error: memdev=3D0000:0c:00.0 host=3Dpci0000:0c seria=
l: 0
>status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable P=
arity
>Error'
>
>Endpoint:
>cxl_aer_correctable_error: memdev=3Dmem3 host=3D0000:0f:00.0 serial=3D0
>status=3D'CRC Threshold Hit'
>cxl_aer_uncorrectable_error: memdev=3Dmem3 host=3D0000:0f:00.0 serial: 0 s=
tatus:
>'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Er=
ror'
>
>Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>---
> drivers/cxl/core/pci.c   | 19 ++++-----
> drivers/cxl/core/ras.c   | 14 ++++---
> drivers/cxl/core/trace.h | 84 +++++++++-------------------------------
> 3 files changed, 37 insertions(+), 80 deletions(-)
>
[...]
>
> static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data
>*data) diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h in=
dex
>25ebfbc1616c..494d6db461a7 100644
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

Thanks for considering the feedback given in v9 regarding the compatibility=
 issue
with the rasdaemon.
https://lore.kernel.org/all/959acc682e6e4b52ac0283b37ee21026@huawei.com/

Probably some confusion w.r.t the feedback.
Unfortunately  TP_printk(...) is not an ABI that we need to keep stable,=20
it's this structure, TP_STRUCT__entry(..) , that matters to the rasdaemon.

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
>+	TP_printk("memdev=3D%s host=3D%s serial=3D%lld status=3D'%s'
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

Same as above.
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
>+	TP_printk("memdev=3D%s host=3D%s serial=3D%lld status=3D'%s'",
>+		  __get_str(name), __get_str(parent), __entry->serial,
> 		  show_ce_errs(__entry->status)
> 	)
> );
>--
>2.34.1

Thanks,
Shiju

