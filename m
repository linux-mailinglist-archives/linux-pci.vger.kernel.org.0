Return-Path: <linux-pci+bounces-30920-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 092E1AEB672
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 13:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C62107A8129
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 11:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5862676D9;
	Fri, 27 Jun 2025 11:32:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C57C214801;
	Fri, 27 Jun 2025 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751023928; cv=none; b=sMyAg4mTPBCKdMryJAIWHNbBN1rgkHXJGLAWEUDKsb9sHL5ZyHAU/NZdkA+JSy32n/MInqE4RCzgbAYiEI33VdcntqbFmgBn8jy1wLJyYUskPOOGc3IEuEC0STUUP9SvtQV9pKtfRXvFkNDerggrnvJ54P8AkNmtMfq6qdk9bCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751023928; c=relaxed/simple;
	bh=GGAyJAwyGYCz2xKGTXKKTOHY/uXmtZ1y7wQNKXN7Iyo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=twyGTM1IcZNk9waNKOPtJv+nDtkK+qTAUctxGQKhz02i2+EKMS3VN4VE2AprWPsoqJ70ijtxLQJviMv67zA5Gs6qjbNuUV6oOhTrNH4IlDfcXqKw9puza/WAP5Kt4SXFeJjlAjRdpnWXXwV9WrbpiYNXVNSpCkgoKBwfSeizqH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bTD012vTWz6M4MK;
	Fri, 27 Jun 2025 19:31:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id F2F6314038F;
	Fri, 27 Jun 2025 19:32:01 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 27 Jun 2025 13:32:01 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 27 Jun 2025 13:32:01 +0200
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
Subject: RE: [PATCH v10 03/17] PCI/AER: Report CXL or PCIe bus error type in
 trace logging
Thread-Topic: [PATCH v10 03/17] PCI/AER: Report CXL or PCIe bus error type in
 trace logging
Thread-Index: AQHb5uvEpV1Ywekg6EKh6UMIyi2HxLQW3iRw
Date: Fri, 27 Jun 2025 11:32:01 +0000
Message-ID: <b745b33288e540cea2d67286c9e49f8b@huawei.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-4-terry.bowman@amd.com>
In-Reply-To: <20250626224252.1415009-4-terry.bowman@amd.com>
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
>Subject: [PATCH v10 03/17] PCI/AER: Report CXL or PCIe bus error type in t=
race
>logging
>
>The AER service driver and aer_event tracing currently log 'PCIe Bus Type'
>for all errors. Update the driver and aer_event tracing to log 'CXL Bus Ty=
pe' for
>CXL device errors.
>
>This requires the AER can identify and distinguish between PCIe errors and=
 CXL
>errors.
>
>Introduce boolean 'is_cxl' to 'struct aer_err_info'. Add assignment in
>aer_get_device_error_info() and pci_print_aer().
>
>Update the aer_event trace routine to accept a bus type string parameter.
>
>Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>---
> drivers/pci/pci.h       |  6 ++++++
> drivers/pci/pcie/aer.c  | 21 +++++++++++++++------  include/ras/ras_event=
.h |  9
>++++++---
> 3 files changed, 27 insertions(+), 9 deletions(-)
>
>diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h index
>12215ee72afb..a0d1e59b5666 100644
>--- a/drivers/pci/pci.h
>+++ b/drivers/pci/pci.h
>@@ -608,6 +608,7 @@ struct aer_err_info {
> 	int ratelimit_print[AER_MAX_MULTI_ERR_DEVICES];
> 	int error_dev_num;
> 	const char *level;		/* printk level */
>+	bool is_cxl;
>
> 	unsigned int id:16;
>
>@@ -628,6 +629,11 @@ struct aer_err_info {  int
>aer_get_device_error_info(struct aer_err_info *info, int i);  void
>aer_print_error(struct aer_err_info *info, int i);
>
>+static inline const char *aer_err_bus(struct aer_err_info *info) {
>+	return info->is_cxl ? "CXL" : "PCIe";
>+}
>+
> int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
> 		      unsigned int tlp_len, bool flit,
> 		      struct pcie_tlp_log *log);
>diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c index
>70ac66188367..a2df9456595a 100644
>--- a/drivers/pci/pcie/aer.c
>+++ b/drivers/pci/pcie/aer.c
>@@ -837,6 +837,7 @@ void aer_print_error(struct aer_err_info *info, int i)
> 	struct pci_dev *dev;
> 	int layer, agent, id;
> 	const char *level =3D info->level;
>+	const char *bus_type =3D aer_err_bus(info);
>
> 	if (WARN_ON_ONCE(i >=3D AER_MAX_MULTI_ERR_DEVICES))
> 		return;
>@@ -845,23 +846,23 @@ void aer_print_error(struct aer_err_info *info, int =
i)
> 	id =3D pci_dev_id(dev);
>
> 	pci_dev_aer_stats_incr(dev, info);
>-	trace_aer_event(pci_name(dev), (info->status & ~info->mask),
>+	trace_aer_event(pci_name(dev), bus_type, (info->status & ~info->mask),
> 			info->severity, info->tlp_header_valid, &info->tlp);
>
> 	if (!info->ratelimit_print[i])
> 		return;
>
> 	if (!info->status) {
>-		pci_err(dev, "PCIe Bus Error: severity=3D%s, type=3DInaccessible,
>(Unregistered Agent ID)\n",
>-			aer_error_severity_string[info->severity]);
>+		pci_err(dev, "%s Bus Error: severity=3D%s, type=3DInaccessible,
>(Unregistered Agent ID)\n",
>+			bus_type, aer_error_severity_string[info->severity]);
> 		goto out;
> 	}
>
> 	layer =3D AER_GET_LAYER_ERROR(info->severity, info->status);
> 	agent =3D AER_GET_AGENT(info->severity, info->status);
>
>-	aer_printk(level, dev, "PCIe Bus Error: severity=3D%s, type=3D%s, (%s)\n=
",
>-		   aer_error_severity_string[info->severity],
>+	aer_printk(level, dev, "%s Bus Error: severity=3D%s, type=3D%s, (%s)\n",
>+		   bus_type, aer_error_severity_string[info->severity],
> 		   aer_error_layer[layer], aer_agent_string[agent]);
>
> 	aer_printk(level, dev, "  device [%04x:%04x] error
>status/mask=3D%08x/%08x\n", @@ -895,6 +896,7 @@
>EXPORT_SYMBOL_GPL(cper_severity_to_aer);
> void pci_print_aer(struct pci_dev *dev, int aer_severity,
> 		   struct aer_capability_regs *aer)
> {
>+	const char *bus_type;
> 	int layer, agent, tlp_header_valid =3D 0;
> 	u32 status, mask;
> 	struct aer_err_info info =3D {
>@@ -915,9 +917,12 @@ void pci_print_aer(struct pci_dev *dev, int
>aer_severity,
>
> 	info.status =3D status;
> 	info.mask =3D mask;
>+	info.is_cxl =3D pcie_is_cxl(dev);
>+
>+	bus_type =3D aer_err_bus(&info);
>
> 	pci_dev_aer_stats_incr(dev, &info);
>-	trace_aer_event(pci_name(dev), (status & ~mask),
>+	trace_aer_event(pci_name(dev), bus_type, (status & ~mask),
> 			aer_severity, tlp_header_valid, &aer->header_log);
>
> 	if (!aer_ratelimit(dev, info.severity)) @@ -939,6 +944,9 @@ void
>pci_print_aer(struct pci_dev *dev, int aer_severity,
> 	if (tlp_header_valid)
> 		pcie_print_tlp_log(dev, &aer->header_log, info.level,
> 				   dev_fmt("  "));
>+
>+	trace_aer_event(dev_name(&dev->dev), bus_type, (status & ~mask),
>+			aer_severity, tlp_header_valid, &aer->header_log);
Hi Terry,

It looks like an extra trace_aer_event() is called here along with the abov=
e
trace_aer_event(pci_name(dev),...?=20

Thanks,
Shiju
> }
> EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
>
>@@ -1371,6 +1379,7 @@ int aer_get_device_error_info(struct aer_err_info
>*info, int i)
> 	/* Must reset in this function */
> 	info->status =3D 0;
> 	info->tlp_header_valid =3D 0;
>+	info->is_cxl =3D pcie_is_cxl(dev);
>
> 	/* The device might not support AER */
> 	if (!aer)
>diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h index
>14c9f943d53f..080829d59c36 100644
>--- a/include/ras/ras_event.h
>+++ b/include/ras/ras_event.h
>@@ -297,15 +297,17 @@ TRACE_EVENT(non_standard_event,
>
> TRACE_EVENT(aer_event,
> 	TP_PROTO(const char *dev_name,
>+		 const char *bus_type,
> 		 const u32 status,
> 		 const u8 severity,
> 		 const u8 tlp_header_valid,
> 		 struct pcie_tlp_log *tlp),
>
>-	TP_ARGS(dev_name, status, severity, tlp_header_valid, tlp),
>+	TP_ARGS(dev_name, bus_type, status, severity, tlp_header_valid, tlp),
>
> 	TP_STRUCT__entry(
> 		__string(	dev_name,	dev_name	)
>+		__string(	bus_type,	bus_type	)
> 		__field(	u32,		status		)
> 		__field(	u8,		severity	)
> 		__field(	u8, 		tlp_header_valid)
>@@ -314,6 +316,7 @@ TRACE_EVENT(aer_event,
>
> 	TP_fast_assign(
> 		__assign_str(dev_name);
>+		__assign_str(bus_type);
> 		__entry->status		=3D status;
> 		__entry->severity	=3D severity;
> 		__entry->tlp_header_valid =3D tlp_header_valid; @@ -325,8
>+328,8 @@ TRACE_EVENT(aer_event,
> 		}
> 	),
>
>-	TP_printk("%s PCIe Bus Error: severity=3D%s, %s, TLP Header=3D%s\n",
>-		__get_str(dev_name),
>+	TP_printk("%s %s Bus Error: severity=3D%s, %s, TLP Header=3D%s\n",
>+		__get_str(dev_name), __get_str(bus_type),
> 		__entry->severity =3D=3D AER_CORRECTABLE ? "Corrected" :
> 			__entry->severity =3D=3D AER_FATAL ?
> 			"Fatal" : "Uncorrected, non-fatal",
>--
>2.34.1


