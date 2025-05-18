Return-Path: <linux-pci+bounces-27927-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F66ABB9C4
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 11:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4062A7A5CDB
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 09:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA94E27055B;
	Mon, 19 May 2025 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UqqKHd4p"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABDD270547
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646971; cv=none; b=uGlMlrR/5AKYMpbUpl7Tn7R/H+Eh+5aztEfIIY8H+CStoGU7lLI7oxrSV9qBYWJg8brJILD7nXTJ6xPRgXmmELIuXJgrx2HXlPyEcmNwHdGnv29Jg8dFkKJcXoY/Rs+88aeTX51wuDLxQa9UfDYL27Aq6EpP4PeUB3Hwz5axkG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646971; c=relaxed/simple;
	bh=VqfsgDaCFdvADgmhIAYYskRSEPPVkwQynU4VvO/XymA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=uMVS9SA+LX7IGJ7wX7lFxiV2tFcMOMpA6bS0mI/prm+kvxVhoNKJNZNkDrgAmryxOWedU26TRHPx6LJHULIUsfnCw1gO7heFeHJJfeUwRT7Gk4UxBnXm5wJshxpzotS94YbhBtjjh4nwCJ6vsJC8jOYVaCQwoOloaKqa4/AgXWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UqqKHd4p; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250519092928epoutp03a4ecda3da5fd241321b709e3f0ff4855~A46h1jd3c2924429244epoutp03T
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:29:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250519092928epoutp03a4ecda3da5fd241321b709e3f0ff4855~A46h1jd3c2924429244epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1747646968;
	bh=8/g6vyHilQjjcSTnrPbpb3Jk/BH6c4Lj3y4koJE69UY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=UqqKHd4puhiodSUV0+dPUdgSuRwewaKcAn0ru7d1nIcRJFY7jq5q10Q3XZ+ELDRo1
	 JEFG5+zMHTbFCyaznzS8gUN7oxIGivr7nWW17jDrr1ZvA4dl/zCYF+0FpAW3p4VMTZ
	 ifNpdDGDGObiy1amtHszeQb60MlgcGblC8nJPknU=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250519092927epcas5p29cc7c78741885d807b4862e37da451c1~A46hKQYX51126411264epcas5p2q;
	Mon, 19 May 2025 09:29:27 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.177]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4b1C7V1cHCz6B9mH; Mon, 19 May
	2025 09:29:26 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250518193219epcas5p24b442233b3e2bc2a92f43b71a126062f~AtfmzdgcQ1923619236epcas5p2D;
	Sun, 18 May 2025 19:32:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250518193217epsmtrp2417411fcc9c4c964f7a98b47e7b54e7c~AtfkhlhkH0348003480epsmtrp2Z;
	Sun, 18 May 2025 19:32:17 +0000 (GMT)
X-AuditID: b6c32a29-566fe7000000223e-0e-682a35c036f9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	80.C1.08766.0C53A286; Mon, 19 May 2025 04:32:16 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250518193214epsmtip19e58f6b1d64d38c1d3222269b76999bd~Atfhxhd2e0974409744epsmtip1d;
	Sun, 18 May 2025 19:32:13 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.or,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
	vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de,
	m.szyprowski@samsung.com, jh80.chung@samsung.com, Shradha Todi
	<shradha.t@samsung.com>
Subject: [PATCH 00/10] Add PCIe support for Tesla FSD SoC
Date: Mon, 19 May 2025 01:01:42 +0530
Message-ID: <20250518193152.63476-1-shradha.t@samsung.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJTveAqVaGwaN/5hYP5m1js/g76Ri7
	xZKmDIs1e88xWcw/co7V4savNlaLFV9mslscbf3PbPFy1j02i4ae36wWmx5fY7W4vGsOm8XZ
	ecfZLCas+sZicfb7AiaLlj8tLBZrj9xlt7jb0slq8X/PDnaL3sO1FjvvnGB2EPX4/WsSo8fO
	WXfZPRZsKvXYtKqTzePOtT1sHk+uTGfy2Lyk3qNvyypGjyNfp7N4fN4kF8AVxWWTkpqTWZZa
	pG+XwJXR8O8KS8ExoYqOOUdYGxj/8XUxcnJICJhIbP1yhb2LkYtDSGA3o8S0x7uZIRKSEp8v
	rmOCsIUlVv57DlX0iVHi+cs5YEVsAloSjV+7wGwRgROMEn23LEGKmAXeM0nMXPALrFtYwFLi
	zIopYDaLgKrEic3bwRp4Bawk5px5CRTnANogL9HfIQERFpQ4OfMJC4jNDBRu3jqbeQIj3ywk
	qVlIUgsYmVYxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgRHl5bmDsbtqz7oHWJk4mA8
	xCjBwawkwrtqs0aGEG9KYmVValF+fFFpTmrxIUZpDhYlcV7xF70pQgLpiSWp2ampBalFMFkm
	Dk6pBqbW+rQ4rZcz5rWuOVp96ctH83kTJG8s8lpqzMQZwe1yb+3n6CL7tx+q1e5qNFydyVve
	mvGxJUTdnrXJIbDe+O7Jo5qNyk6velwZ1vS1Z8udYDuVLVu33yCyv+hpLdtlmSmZ/xUrnx6e
	8Fztg+T+qYb1K6ZcTbWY8slWocq//pbS6p91rmsMP3ldXWb5octw2wER5bfvUnZEv9pq42cZ
	uJ358rxHzLOM7cWZay7PvblsdmTX6x9HHsvxrWX/17ly8aeVnp5mATfETS/FvRRP9XttttTS
	5tEjdu1fi2zUv1uav08umCh6pTdRf9FT/jUV9dMjQzzbPC3aOLqzbsYoHvva3Wx7KcyXs9Tw
	Bx9DnhJLcUaioRZzUXEiAOrOrZodAwAA
X-CMS-MailID: 20250518193219epcas5p24b442233b3e2bc2a92f43b71a126062f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250518193219epcas5p24b442233b3e2bc2a92f43b71a126062f
References: <CGME20250518193219epcas5p24b442233b3e2bc2a92f43b71a126062f@epcas5p2.samsung.com>

FSD platform has three instances of DesignWare based PCIe IP,
one is in FSYS0 block and other two in FSYS1 block.
This patch series add required DT binding, DT file modifications,
Controller driver support and PHY driver support for the same.

To keep single PCIe controller driver for all Samsung
manufactured SoC, we have made changes to Exynos file to extend
support for FSD platform and other Samsung manufactured SoCs which
shall be upstreamed soon.

First a v1 version was posted as a separate driver file:
https://lore.kernel.org/lkml/20221121105210.68596-1-shradha.t@samsung.com/
This was rejected and request was made to add the support in exynos file
itself.

Then another patchset was posted to refactor existing exynos file:
https://lore.kernel.org/lkml/649a8d88-0504-5aa9-d167-d25d394f3f26@linaro.org/T/
This requested some major changes

Taking both these reviews into consideration, I have posted a fresh
patchset where both changes to exynos framework and addition of new FSD
support is present. This is why not considering it to be v2 of either
patchset.

Currently the DT node is not added in this patchset and will send it
in the devicetree mailing list post this.

Shradha Todi (10):
  PCI: exynos: Change macro names to exynos specific
  PCI: exynos: Remove unused MACROs in exynos PCI file
  PCI: exynos: Reorder MACROs to maintain consistency
  PCI: exynos: Add platform device private data
  PCI: exynos: Add structure to hold resource operations
  dt-bindings: PCI: Add bindings support for Tesla FSD SoC
  dt-bindings: phy: Add PHY bindings support for FSD SoC
  phy: exynos: Add PCIe PHY support for FSD SoC
  PCI: exynos: Add support for Tesla FSD SoC
  misc: pci_endpoint_test: Add driver data for FSD PCIe controllers

 .../bindings/pci/samsung,exynos-pcie-ep.yaml  |  66 ++
 .../bindings/pci/samsung,exynos-pcie.yaml     | 199 +++---
 .../bindings/phy/samsung,exynos-pcie-phy.yaml |   8 +-
 drivers/misc/pci_endpoint_test.c              |   3 +
 drivers/pci/controller/dwc/pci-exynos.c       | 569 +++++++++++++++---
 drivers/phy/samsung/phy-exynos-pcie.c         | 357 ++++++++++-
 include/linux/pci_ids.h                       |   2 +
 7 files changed, 1043 insertions(+), 161 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos-pcie-ep.yaml

-- 
2.49.0


