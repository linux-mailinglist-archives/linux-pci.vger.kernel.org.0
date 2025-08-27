Return-Path: <linux-pci+bounces-34912-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C614DB381CA
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 13:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55691BA25D1
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 11:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9869A2F39B8;
	Wed, 27 Aug 2025 11:55:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDC31EDA09;
	Wed, 27 Aug 2025 11:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756295747; cv=none; b=Ky1xXpqk1vLWRXVb/24kXIdL1JHlmfxvlDxY3u/kpUqwSpqlgsCq0ESkL9ZVfWpOshLqTOSSf6FOoseJnt5eKjKHcZPSX6L6yPrO2g8A3py6iYUrNtJVRJhXJA3u6Nkc3esmzOSKP7FTiAR9Wqrjczu8Rsf9Q0LP2H2RViXOvdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756295747; c=relaxed/simple;
	bh=KhQXv86kQVKGJw8aszaxAC/gVymxYsSpQh5L+SZFkl8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LjKiheZ/a9vEEguLh99YF+APf13j0AYLnzcu+AIFZhYcD5B4kXXQGqIYREHMbjrStfcpfU4aps6Ux24g2aLUWrsZ0hmEvaeGmutGsJmC0lcFIs0EX7fUyPbvhaXakfiNhPdUmnOCm6pYEGFKPrLB0G8ryc4SLbQ8T4EDyj2VPXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cBjbR5kl2z6M5BG;
	Wed, 27 Aug 2025 19:53:23 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 354791400D3;
	Wed, 27 Aug 2025 19:55:41 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 27 Aug 2025 13:55:40 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 27 Aug 2025 13:55:40 +0200
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
	<linux-cxl@vger.kernel.org>, "alucerop@amd.com" <alucerop@amd.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v11 13/23] cxl/pci: Unify CXL trace logging for CXL
 Endpoints and CXL Ports
Thread-Topic: [PATCH v11 13/23] cxl/pci: Unify CXL trace logging for CXL
 Endpoints and CXL Ports
Thread-Index: AQHcFvNHxFodFG2mWkCAduI7aP/bW7R2YxYg
Date: Wed, 27 Aug 2025 11:55:40 +0000
Message-ID: <159c6313b9da45d58d83ca9af8dc9a17@huawei.com>
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-14-terry.bowman@amd.com>
In-Reply-To: <20250827013539.903682-14-terry.bowman@amd.com>
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
>Sent: 27 August 2025 02:35
>To: dave@stgolabs.net; Jonathan Cameron <jonathan.cameron@huawei.com>;
>dave.jiang@intel.com; alison.schofield@intel.com; dan.j.williams@intel.com=
;
>bhelgaas@google.com; Shiju Jose <shiju.jose@huawei.com>;
>ming.li@zohomail.com; Smita.KoralahalliChannabasappa@amd.com;
>rrichter@amd.com; dan.carpenter@linaro.org;
>PradeepVineshReddy.Kodamati@amd.com; lukas@wunner.de;
>Benjamin.Cheatham@amd.com;
>sathyanarayanan.kuppuswamy@linux.intel.com; linux-cxl@vger.kernel.org;
>alucerop@amd.com; ira.weiny@intel.com
>Cc: linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org
>Subject: [PATCH v11 13/23] cxl/pci: Unify CXL trace logging for CXL Endpoi=
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
>Leave the correctable and uncorrectable trace routines' TP_STRUCT__entry()
>unchanged with respect to member data types and order.
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

Reviewed-by: Shiju Jose <shiju.jose@huawei.com>,
apart from one error below.

>
>---
>Changes in v10->v11:
>- Updated CE and UCE trace routines to maintain consistent TP_Struct ABI a=
nd
>unchanged TP_printk() logging.
>---
> drivers/cxl/core/ras.c   | 35 +++++++++++----------
> drivers/cxl/core/trace.h | 68 +++++++---------------------------------
> 2 files changed, 30 insertions(+), 73 deletions(-)
>
>diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c index
>3454cf1a118d..fda3b0a64dab 100644
>--- a/drivers/cxl/core/ras.c
>+++ b/drivers/cxl/core/ras.c
>@@ -13,7 +13,7 @@ static void cxl_cper_trace_corr_port_prot_err(struct
>pci_dev *pdev,  {
> 	u32 status =3D ras_cap.cor_status & ~ras_cap.cor_mask;
>
>-	trace_cxl_port_aer_correctable_error(&pdev->dev, status);
>+	trace_cxl_aer_correctable_error(&pdev->dev, status, 0);
> }
>
> static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev, @@ =
-
>28,8 +28,8 @@ static void cxl_cper_trace_uncorr_port_prot_err(struct pci_d=
ev
>*pdev,
> 	else
> 		fe =3D status;
>
>-	trace_cxl_port_aer_uncorrectable_error(&pdev->dev, status, fe,
>-					       ras_cap.header_log);
>+	trace_cxl_aer_uncorrectable_error(&pdev->dev, status, fe,
>+					  ras_cap.header_log, 0);
> }
>
> static void cxl_cper_trace_corr_prot_err(struct cxl_memdev *cxlmd, @@ -37=
,7
>+37,8 @@ static void cxl_cper_trace_corr_prot_err(struct cxl_memdev *cxlmd=
,
>{
> 	u32 status =3D ras_cap.cor_status & ~ras_cap.cor_mask;
>
>-	trace_cxl_aer_correctable_error(cxlmd, status);
>+	trace_cxl_aer_correctable_error(&cxlmd->dev, cxlmd->cxlds->serial,
>+					status);
Please correct to=20
             trace_cxl_aer_correctable_error(&cxlmd->dev,  status,=20
					cxlmd->cxlds->serial);
> }
>
> static void
[...]
>-
> TRACE_EVENT(cxl_aer_correctable_error,
>-	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
>-	TP_ARGS(cxlmd, status),
>+	TP_PROTO(const struct device *cxlmd, u32 status, u64 serial),
>+	TP_ARGS(cxlmd, status, serial),
> 	TP_STRUCT__entry(
>-		__string(memdev, dev_name(&cxlmd->dev))
>-		__string(host, dev_name(cxlmd->dev.parent))
>+		__string(memdev, dev_name(cxlmd))
>+		__string(host, dev_name(cxlmd->parent))
> 		__field(u64, serial)
> 		__field(u32, status)
> 	),
> 	TP_fast_assign(
> 		__assign_str(memdev);
> 		__assign_str(host);
>-		__entry->serial =3D cxlmd->cxlds->serial;
>+		__entry->serial =3D serial;
> 		__entry->status =3D status;
> 	),
> 	TP_printk("memdev=3D%s host=3D%s serial=3D%lld: status: '%s'",
>--
>2.51.0.rc2.21.ge5ab6b3e5a

Thanks,
Shiju


