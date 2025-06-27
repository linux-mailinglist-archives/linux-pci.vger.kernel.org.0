Return-Path: <linux-pci+bounces-30925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B73AEB7AB
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 14:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02774162ED9
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 12:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D88C2C08C0;
	Fri, 27 Jun 2025 12:27:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297ED17C21C;
	Fri, 27 Jun 2025 12:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751027276; cv=none; b=Sr8wJ7KkUPPmKf7c415XfyLJWUVjk8P54IO6ouNIjUU4MY0kKYdPzBejZEjdOyiBhvnvh5DoH1Y+zpb2o7xZnchQZa+YLcPCSIFtrtTVMr0Vt4aCBY4rvVFPgBoiIi4L5JcPBGWRepWMmr4mNtDR2G0Il619pDw0FUNu9mqYGWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751027276; c=relaxed/simple;
	bh=OKIu7W/RcNJLxYl61nYTQ/+Y9Gmg/tGRmCBvtkwXg8M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t7j0ZZQCEaTRSI3RbITdQ278622gsmINHy/CROpp0RYa50kfsvoko3lfT4GqkIC10TB8PuogGjSoKGVo2ebmqmujtHlQ3ehl8p8MHO/k9B/eJYa/QLyeI/xYUKRM6WM1Eipt799ou4NTRJBW443w8bEs03MgeyVrQHoNzMZiX0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bTFDP0tWCz6M4TC;
	Fri, 27 Jun 2025 20:27:01 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
	by mail.maildlp.com (Postfix) with ESMTPS id BBD02140277;
	Fri, 27 Jun 2025 20:27:49 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 27 Jun 2025 14:27:49 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 27 Jun 2025 14:27:49 +0200
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
Subject: RE: [PATCH v10 07/17] CXL/PCI: Introduce CXL uncorrectable protocol
 error recovery
Thread-Topic: [PATCH v10 07/17] CXL/PCI: Introduce CXL uncorrectable protocol
 error recovery
Thread-Index: AQHb5uvfZA3RpW+GBEiRkwmWc42YArQW1HrA
Date: Fri, 27 Jun 2025 12:27:49 +0000
Message-ID: <8b09bb6b1c4d4363996368b67a574e1d@huawei.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-8-terry.bowman@amd.com>
In-Reply-To: <20250626224252.1415009-8-terry.bowman@amd.com>
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
>Subject: [PATCH v10 07/17] CXL/PCI: Introduce CXL uncorrectable protocol e=
rror
>recovery
>
>Create cxl_do_recovery() to provide uncorrectable protocol error (UCE)
>handling. Follow similar design as found in PCIe error driver,
>pcie_do_recovery(). One difference is cxl_do_recovery() will treat all UCE=
s as
>fatal with a kernel panic. This is to prevent corruption on CXL memory.
>
>Export the PCI error driver's merge_result() to CXL namespace. Introduce
>PCI_ERS_RESULT_PANIC and add support in merge_result() routine. This will =
be
>used by CXL to panic the system in the case of uncorrectable protocol erro=
rs. PCI
>error handling is not currently expected to use the PCI_ERS_RESULT_PANIC.
>
>Copy pci_walk_bridge() to cxl_walk_bridge(). Make a change to walk the fir=
st
>device in all cases.
>
>Copy the PCI error driver's report_error_detected() to
>cxl_report_error_detected().
>Note, only CXL Endpoints and RCH Downstream Ports(RCH DSP) are currently
>supported. Add locking for PCI device as done in PCI's report_error_detect=
ed().
>This is necessary to prevent the RAS registers from disappearing before lo=
gging
>is completed.
>
>Call panic() to halt the system in the case of uncorrectable errors (UCE) =
in
>cxl_do_recovery(). Export pci_aer_clear_fatal_status() for CXL to use if a=
 UCE is
>not found. In this case the AER status must be cleared and uses
>pci_aer_clear_fatal_status().
>
>Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>---
> drivers/cxl/core/native_ras.c | 44 +++++++++++++++++++++++++++++++++++
> drivers/pci/pcie/cxl_aer.c    |  3 ++-
> drivers/pci/pcie/err.c        |  8 +++++--
> include/linux/aer.h           | 11 +++++++++
> include/linux/pci.h           |  3 +++
> 5 files changed, 66 insertions(+), 3 deletions(-)
>
[...]
>
> void pci_print_aer(struct pci_dev *dev, int aer_severity, diff --git
>a/include/linux/pci.h b/include/linux/pci.h index 79326358f641..16a8310e03=
73
>100644
>--- a/include/linux/pci.h
>+++ b/include/linux/pci.h
>@@ -868,6 +868,9 @@ enum pci_ers_result {
>
> 	/* No AER capabilities registered for the driver */
> 	PCI_ERS_RESULT_NO_AER_DRIVER =3D (__force pci_ers_result_t) 6,
>+
>+	/* System is unstable, panic. Is CXL specific  */
>+	PCI_ERS_RESULT_PANIC =3D (__force pci_ers_result_t) 7,
Extra space is present after casting?
> };
>
> /* PCI bus error event callbacks */
>--
>2.34.1


