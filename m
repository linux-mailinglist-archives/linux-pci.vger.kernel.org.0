Return-Path: <linux-pci+bounces-15315-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8230E9B062A
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 16:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05FA1C20F54
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 14:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B62170809;
	Fri, 25 Oct 2024 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="f07B3FtO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06065212198
	for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2024 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729867833; cv=none; b=pMXJEN3eMQb7pxx29UcHzgH6jo96tzourpziLTzVJDBTu2IVLovxWbvr2zBkRnqO3TyI4/xDSroto0t5BBPwC9iH8gmEGxfZGZwYSj6KQzUxOvGVuhqKE6N82RqoFy+l2Rxj5MD2r1VZFrr0V/yCHFRkVijaIYPwqov6AtKiuEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729867833; c=relaxed/simple;
	bh=7CUHd1T+q5G579t/PSLx38aJuKRnbDoA4u5TSCCb34g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c+sXwQujYulwFb+NcrffFH53wLKA3JmPpOT3BbY+y9g5nNv456ZztO5QQYSuqxii4OshSeYGbn0IdnRyaA826XWeTc3SBt7h/+zYowZcf3oSjE9SMnVBTMvUhckv11/FW4vovE46/otGKSnCEn+zthx3nd7PcZbZyLTb9jrLDiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=f07B3FtO; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 49PCLCcB029642
	for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2024 07:50:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=jxIWx5EUcw5+unmAZk
	/xFsHpaAAIzmuGz58oiZaF2Jo=; b=f07B3FtOryruuEcOixKWpcD3JI4dvjbJmZ
	IPHh3C9SI3h1VEuDI3jJFnj4Dq0JCjysIfR+4ecyfOXi4thyUuuFL8rDrUMTs1zB
	di07bwjDgx7awbRme4TYJt3xiJZWVQxwmQRIXLW6TJx4h2NCdMBeQEzU5qgEzeZo
	sAJBXw489dLlAxHjNigkWfGorYSkvYC8Xw6Z7Kk4kCwuLDxAyhCHYlJK4wB+VwIl
	fioOkDzac3dtOdAbJN0dsp0A4JUu11LZfZu8PkW2aZ4TqxEyPqEWfvpDuliw2X5b
	Ibap9Ls+GUzQOuRm5YtNNN8PRRK8Ickpu5CefztF303Bw4zU6e9Q==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 42g9c9sg04-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2024 07:50:29 -0700 (PDT)
Received: from twshared4570.02.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 25 Oct 2024 14:50:28 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id E17021474B42A; Fri, 25 Oct 2024 07:50:22 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] pci: provide bus reset attribute
Date: Fri, 25 Oct 2024 07:50:21 -0700
Message-ID: <20241025145021.1410645-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1zJSG-x6noxjMS-Ac96bFKJx5Xlis96s
X-Proofpoint-GUID: 1zJSG-x6noxjMS-Ac96bFKJx5Xlis96s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

From: Keith Busch <kbusch@kernel.org>

Attempting a bus reset on an end device only works if it's the only
function on or below that bus.

Provide an attribute on the pci_bus device that can perform the
secondary bus reset. This makes it possible for a user to safely reset
multiple devices in a single command using the secondary bus reset
method.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/pci-sysfs.c | 23 +++++++++++++++++++++++
 drivers/pci/pci.c       |  2 +-
 drivers/pci/pci.h       |  1 +
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5d0f4db1cab78..616d64f12da4d 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -521,6 +521,28 @@ static ssize_t bus_rescan_store(struct device *dev,
 static struct device_attribute dev_attr_bus_rescan =3D __ATTR(rescan, 02=
00, NULL,
 							    bus_rescan_store);
=20
+static ssize_t bus_reset_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct pci_bus *bus =3D to_pci_bus(dev);
+	unsigned long val;
+
+	if (kstrtoul(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if (val) {
+		int ret =3D __pci_reset_bus(bus);
+
+		if (ret)
+			return ret;
+	}
+
+	return count;
+}
+static struct device_attribute dev_attr_bus_reset =3D __ATTR(reset, 0200=
, NULL,
+							   bus_reset_store);
+
 #if defined(CONFIG_PM) && defined(CONFIG_ACPI)
 static ssize_t d3cold_allowed_store(struct device *dev,
 				    struct device_attribute *attr,
@@ -638,6 +660,7 @@ static struct attribute *pcie_dev_attrs[] =3D {
=20
 static struct attribute *pcibus_attrs[] =3D {
 	&dev_attr_bus_rescan.attr,
+	&dev_attr_bus_reset.attr,
 	&dev_attr_cpuaffinity.attr,
 	&dev_attr_cpulistaffinity.attr,
 	NULL,
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7d85c04fbba2a..338dfcd983f1e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5880,7 +5880,7 @@ EXPORT_SYMBOL_GPL(pci_probe_reset_bus);
  *
  * Same as above except return -EAGAIN if the bus cannot be locked
  */
-static int __pci_reset_bus(struct pci_bus *bus)
+int __pci_reset_bus(struct pci_bus *bus)
 {
 	int rc;
=20
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 14d00ce45bfa9..1cdc2c9547a7e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -104,6 +104,7 @@ bool pci_reset_supported(struct pci_dev *dev);
 void pci_init_reset_methods(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
+int __pci_reset_bus(struct pci_bus *bus);
=20
 struct pci_cap_saved_data {
 	u16		cap_nr;
--=20
2.43.5


