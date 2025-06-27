Return-Path: <linux-pci+bounces-30926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09588AEB7AD
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 14:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B049316C815
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 12:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C79D2C08C9;
	Fri, 27 Jun 2025 12:28:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094E72D23BA;
	Fri, 27 Jun 2025 12:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751027285; cv=none; b=eHXCt6vtIJLBJ/6W2lFlMvUKLtKQGt++k6NYIhTBD64hwITV1wq6X6Imw1jBMVm4kK8+7ePOcW43YqfYQDo2fzqB4wqdJBbGREh+oSd/D9moxbNSZ+Da/9QEGZtXS0sOswz7UC7wrOqkspGDVZtSZxV85LdATL9DV4jckmpy9F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751027285; c=relaxed/simple;
	bh=0zNrNmK3pqiGon8Seo2hMieH6flm2FikmLErgXfZOIM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XahfHrGzqR3V9ywUJ41cZYO3VE2NWSGb7JlKgvZ0KCr9itnTCdK6iVnP4A5kwk7VkE1YQJpiqIwvNEnoCJqq2hz3prXH15FWqg4/BQJe60P2N8OUmvllpNp91oUgXV9IzRE/CKKQ3JBmRjOGGXhQ8E7EjT3DZdS1AVw+NSrLakw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bTFFL3y0nz6L51N;
	Fri, 27 Jun 2025 20:27:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D5AB140277;
	Fri, 27 Jun 2025 20:28:00 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 27 Jun 2025 14:27:59 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 27 Jun 2025 14:27:59 +0200
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
Subject: RE: [PATCH v10 14/17] cxl/pci: Introduce CXL Endpoint protocol error
 handlers
Thread-Topic: [PATCH v10 14/17] cxl/pci: Introduce CXL Endpoint protocol error
 handlers
Thread-Index: AQHb5uwO1xcj9CtThUyjEaT7Asi8rbQW1kkQ
Date: Fri, 27 Jun 2025 12:27:59 +0000
Message-ID: <4a4e496db4c442178bf4f9d14dab9927@huawei.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-15-terry.bowman@amd.com>
In-Reply-To: <20250626224252.1415009-15-terry.bowman@amd.com>
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
>Subject: [PATCH v10 14/17] cxl/pci: Introduce CXL Endpoint protocol error
>handlers
>
>CXL Endpoint protocol errors are currently handled using PCI error handler=
s. The
>CXL Endpoint requires CXL specific handling in the case of uncorrectable e=
rror
>(UCE) handling not provided by the PCI handlers.
>
>Add CXL specific handlers for CXL Endpoints. Rename the existing
>cxl_error_handlers to be pci_error_handlers to more correctly indicate the
>error type and follow naming consistency.
>
>The PCI handlers will be called if the CXL device is not trained for alter=
nate
>protocol (CXL). Update the CXL Endpoint PCI handlers to call the CXL UCE
>handlers.
>
>The existing EP UCE handler includes checks for various results. These are=
 no
>longer needed because CXL UCE recovery will not be attempted. Implement
>cxl_handle_ras() to return PCI_ERS_RESULT_NONE or PCI_ERS_RESULT_PANIC.
>The CXL UCE handler is called by cxl_do_recovery() that acts on the return
>value. In the case of the PCI handler path, call panic() if the result is
>PCI_ERS_RESULT_PANIC.
>
>Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>Reviewed-by: Kuppuswamy Sathyanarayanan
><sathyanarayanan.kuppuswamy@linux.intel.com>
>---
> drivers/cxl/core/native_ras.c | 15 ++++---
> drivers/cxl/core/pci.c        | 77 ++++++++++++++++++-----------------
> drivers/cxl/cxl.h             |  4 ++
> drivers/cxl/cxlpci.h          |  6 +--
> drivers/cxl/pci.c             |  8 ++--
> 5 files changed, 59 insertions(+), 51 deletions(-)
>
[...]
>diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c index
>887b54cf3395..7209ffb5c2fe 100644
>--- a/drivers/cxl/core/pci.c
>+++ b/drivers/cxl/core/pci.c
>@@ -705,8 +705,8 @@ static void header_log_copy(void __iomem *ras_base,
>u32 *log)
>  * Log the state of the RAS status registers and prepare them to log the
>  * next error status. Return 1 if reset needed.
>  */
>-static bool cxl_handle_ras(struct device *dev, u64 serial,
>-			   void __iomem *ras_base)
>+static pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial,
>+				       void __iomem *ras_base)
> {
> 	u32 hl[CXL_HEADERLOG_SIZE_U32];
> 	void __iomem *addr;
>@@ -715,13 +715,13 @@ static bool cxl_handle_ras(struct device *dev, u64
>serial,
>
> 	if (!ras_base) {
> 		dev_warn_once(dev, "CXL RAS register block is not mapped");
>-		return false;
>+		return PCI_ERS_RESULT_NONE;
> 	}
>
> 	addr =3D ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
> 	status =3D readl(addr);
> 	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
>-		return false;
>+		return PCI_ERS_RESULT_NONE;
>
> 	/* If multiple errors, log header points to first error from ctrl reg */
> 	if (hweight32(status) > 1) {
>@@ -738,7 +738,7 @@ static bool cxl_handle_ras(struct device *dev, u64 ser=
ial,
> 	trace_cxl_aer_uncorrectable_error(dev, serial, status, fe, hl);
> 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>
>-	return true;
>+	return PCI_ERS_RESULT_PANIC;
> }
>
> #ifdef CONFIG_PCIEAER_CXL
>@@ -833,13 +833,14 @@ static void cxl_handle_rdport_errors(struct
>cxl_dev_state *cxlds)  static void cxl_handle_rdport_errors(struct cxl_dev=
_state
>*cxlds) { }  #endif
>
>-void cxl_cor_error_detected(struct pci_dev *pdev)
>+void cxl_cor_error_detected(struct device *dev)
> {
>+	struct pci_dev *pdev =3D to_pci_dev(dev);
> 	struct cxl_dev_state *cxlds =3D pci_get_drvdata(pdev);
>-	struct device *dev =3D &cxlds->cxlmd->dev;
>+	struct device *cxlmd_dev =3D &cxlds->cxlmd->dev;
>
>-	scoped_guard(device, dev) {
>-		if (!dev->driver) {
>+	scoped_guard(device, cxlmd_dev) {
>+		if (!cxlmd_dev->driver) {
> 			dev_warn(&pdev->dev,
> 				 "%s: memdev disabled, abort error
>handling\n",
> 				 dev_name(dev));
>@@ -854,20 +855,26 @@ void cxl_cor_error_detected(struct pci_dev *pdev)  }
>EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
>
>-pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>-				    pci_channel_state_t state)
>+void pci_cor_error_detected(struct pci_dev *pdev)
> {
>-	struct cxl_dev_state *cxlds =3D pci_get_drvdata(pdev);
>-	struct cxl_memdev *cxlmd =3D cxlds->cxlmd;
>-	struct device *dev =3D &cxlmd->dev;
>-	bool ue;
>+	cxl_cor_error_detected(&pdev->dev);
>+}
>+EXPORT_SYMBOL_NS_GPL(pci_cor_error_detected, "CXL");
>
>-	scoped_guard(device, dev) {
>-		if (!dev->driver) {
>+pci_ers_result_t cxl_error_detected(struct device *dev) {
>+	struct pci_dev *pdev =3D to_pci_dev(dev);
>+	struct cxl_dev_state *cxlds =3D pci_get_drvdata(pdev);
>+	struct device *cxlmd_dev =3D &cxlds->cxlmd->dev;
>+	pci_ers_result_t ue;
>+
>+	scoped_guard(device, cxlmd_dev) {
>+
Please remove the extra blank line.

>+		if (!cxlmd_dev->driver) {
> 			dev_warn(&pdev->dev,
> 				 "%s: memdev disabled, abort error
>handling\n",
> 				 dev_name(dev));

Thanks,
Shiju

