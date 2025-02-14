Return-Path: <linux-pci+bounces-21443-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17014A35BF6
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 11:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB84188ED1B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 10:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1829524A062;
	Fri, 14 Feb 2025 10:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jnKfMjmH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EF3245AE1
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 10:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739530629; cv=none; b=n8B/ITbe+EpIVYn4xlr6p4Fqjmyk/mFn7havJCgJdEBTwcHMkUgexYRK4idKHEAUW3bnfsYQvta/sLM8AEyC587+vSWdsTReZ4QH1kwKAe0QE0BDDkQ8jzQPT3bdtagd3zuLfIxYgUVtZ/WgQfIy68zjbN/T64zkeG1UjHN8FJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739530629; c=relaxed/simple;
	bh=+tKbftjm8iyVxBPWvEA02ljsqiP064EnOA/Uan1U+vY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=Tq62bM2DDi/hkTMDCFToGjeWPdqPJfwfDHwY3v2dlg6kDmhqUs+f0IcZl4t4gmkD4EJ5DZHC0s6WHVaxUGMWyIz/TE+p0GfXb1LPL+J95b2Jt1RE0UIhCDMNMGkSBR63gHE+1tsTykZ4ORvlULOHi6r6d1I27+HB7KITm0P2wHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jnKfMjmH; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250214105704epoutp03d249e8e5edc2a5fef928256ad737a9ba~kDeL4WWwU1312813128epoutp03T
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 10:57:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250214105704epoutp03d249e8e5edc2a5fef928256ad737a9ba~kDeL4WWwU1312813128epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739530624;
	bh=fnQkwQE2nD+RZL7aOVAiUJR3+UfXo9NzS1eJy0seoKk=;
	h=From:To:Cc:Subject:Date:References:From;
	b=jnKfMjmHHX5Hr1SSoZ4EXXNqSurCcKNY0OMi9zJtOk27LhTvoYdshaEhSvL+/KgLf
	 XMVU9zBQDZ60M7+kwz+LL2MEVQc1LsXG3BR+kuPvJ+Q0HbHhKB1sVJO3OdyYQOtEjG
	 B/qNEsU83HOXIShjfp1OPpx0Ut2IoC2JNYTCzTbM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250214105704epcas5p4e9af62b922284ae396523e4149fd3d77~kDeLdUmAv1436414364epcas5p4H;
	Fri, 14 Feb 2025 10:57:04 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4YvTWx5jQpz4x9Pr; Fri, 14 Feb
	2025 10:57:01 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	CD.0A.29212.D712FA76; Fri, 14 Feb 2025 19:57:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250214105330epcas5p13b0d5bef72b012d71e850c9454015880~kDbE-Pxsr0376503765epcas5p1-;
	Fri, 14 Feb 2025 10:53:30 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250214105330epsmtrp2131e8fd8c6c1a29d6e9c308ce19962fa~kDbE_ZdE20381003810epsmtrp2j;
	Fri, 14 Feb 2025 10:53:30 +0000 (GMT)
X-AuditID: b6c32a50-7ebff7000000721c-f7-67af217d9b6a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0E.00.18949.AA02FA76; Fri, 14 Feb 2025 19:53:30 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250214105328epsmtip18844b9fc9c9d32f40c243b131f31bb83~kDbCdxWrp0947209472epsmtip1j;
	Fri, 14 Feb 2025 10:53:28 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@Huawei.com, fan.ni@samsung.com, nifan.cxl@gmail.com,
	a.manzanares@samsung.com, pankaj.dubey@samsung.com, cassel@kernel.org,
	18255117159@163.com, quic_nitegupt@quicinc.com, quic_krichai@quicinc.com,
	gost.dev@samsung.com, Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v6 0/4] Add support for debugfs based RAS DES feature in
 PCIe DW
Date: Fri, 14 Feb 2025 16:20:03 +0530
Message-Id: <20250214105007.97582-1-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPJsWRmVeSWpSXmKPExsWy7bCmum6t4vp0g+XPtC2utP9mt5h+WNFi
	SVOGxbEJK5gtmlbfZbW4eWAnk8WKLzPZLVYtvMZm0dDzm9Xi8q45bBZn5x1ns2j508Jicbel
	k9Xi77a9jBaLtn5ht3jwoNKic84RZov/e3awW/QernUQ9li8Ygqrx85Zd9k9Fmwq9Wg58pbV
	Y9OqTjaPO9f2sHk8uTKdyWPinjqPvi2rGD0+b5IL4IrKtslITUxJLVJIzUvOT8nMS7dV8g6O
	d443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wB+kpJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9c
	YquUWpCSU2BSoFecmFtcmpeul5daYmVoYGBkClSYkJ1xsmMpc8EZ+Yrmp8YNjKckuxg5OSQE
	TCQ+b3/M3MXIxSEksIdR4tP6l4wQzidGiSV3TrNBON8YJU61vWCBaXn3/zaYLSSwl1Hi9Xp1
	iKIvjBI3r59nB0mwCWhJNH7tYgaxRQSsJQ63b2EDsZkFFjFLzO1OBLGFBYIkutbvARvEIqAq
	8XHjd7AaXgEriaYT7cwQy+QlVm84wAwRF5Q4OfMJC8QceYnmrbPB7pYQuMIhMfd3O1MXIweQ
	4yJxbmscRK+wxKvjW9ghbCmJz+/2skHY6RIrN8+Amp8j8W3zEiYI217iwJU5LCBjmAU0Jdbv
	0ocIy0pMPbWOCWItn0Tv7ydQ5bwSO+bB2MoSX/7ugYaPpMS8Y5dZIa7xkJh2VADEFBKIlVja
	YjyBUX4Wkl9mIfllFsLeBYzMqxilUguKc9NTk00LDHXzUsvhsZqcn7uJEZyytQJ2MK7e8Ffv
	ECMTB+MhRgkOZiURXolpa9KFeFMSK6tSi/Lji0pzUosPMZoCQ3gis5Rocj4wa+SVxBuaWBqY
	mJmZmVgamxkqifM272xJFxJITyxJzU5NLUgtgulj4uCUamAKuMi8fP3GibcPvb9UuDaFI0BM
	vYd1pq2oivlSrRdxsgl12ed/cblmtLqeSG3u91j45OWOOq/CYzp/ogq/cs2qEj6+bunTOc/7
	nVjWz1J3fKo352q57M9KvTXnJif6hbC41PzkzbE8WSKtMMv8moiQh0na9ulnPspvVS74/2Nb
	xsNXqxS7bus/W+jt3qra/nTjKcYtoS8+sbgxrhf9zbtehLNri9JhyWqVp94F3BHuBx71PFm/
	wIdn7y8V25vd8QuWehzZEld7R3NRTJpPzO2ISE29Q+uucIa6KkYL9r0ykn7baVDiqGJZ6Wsc
	Zywy19oy/rLw2+MMb/LsTy/vTz9dfSquweyMbuKWLq65N5VYijMSDbWYi4oTAR0GS35iBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSnO4qhfXpBk92mFlcaf/NbjH9sKLF
	kqYMi2MTVjBbNK2+y2px88BOJosVX2ayW6xaeI3NoqHnN6vF5V1z2CzOzjvOZtHyp4XF4m5L
	J6vF3217GS0Wbf3CbvHgQaVF55wjzBb/9+xgt+g9XOsg7LF4xRRWj52z7rJ7LNhU6tFy5C2r
	x6ZVnWwed67tYfN4cmU6k8fEPXUefVtWMXp83iQXwBXFZZOSmpNZllqkb5fAlXGyYylzwRn5
	iuanxg2MpyS7GDk5JARMJN79v80CYgsJ7GaU2LnCCiIuKfH54jomCFtYYuW/5+xdjFxANZ8Y
	JSY9uskIkmAT0JJo/NrFDGKLCNhK3H80mRWkiFlgB7PE33lb2UESwgIBEhPeQmxgEVCV+Ljx
	OxuIzStgJdF0op0ZYoO8xOoNB5gh4oISJ2c+AarnABqkLrF+nhBImBmopHnrbOYJjPyzkFTN
	QqiahaRqASPzKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4HjT0trBuGfVB71DjEwc
	jIcYJTiYlUR4JaatSRfiTUmsrEotyo8vKs1JLT7EKM3BoiTO++11b4qQQHpiSWp2ampBahFM
	lomDU6qBqen3AYbZmgnzX6s7B029s2J79ELjX8X/NY89SUnuzKpcmN2U+jYxYdlSxXfpwqGx
	3695cEpv/vDYM+OmxX9nYGhbPOiYlrXKK5zhT/09FcPutS1OYbnBMxptj3fwHVo307/tTdeV
	9SyfN0s9mu5wR6E6Sm7KufCql2+lfT3fLot8xXrkVEH27R/piRv/l5s2pch/c/0+/UnYZgHz
	K8cOyuzNlxULmCAVfrDh+KYDc0SM3OaraE5uVvTssizhn1gfdiDv9EfrzKul32bveTe9IeaI
	17wLbHNbJTc8rNwyw407J+TDs2OSdyJ2eW+1WGlVnqDWWGOV+Ha7u+KvB09XCRv76LxYu2Vh
	V8J7NWt7JZbijERDLeai4kQA/9mmIyYDAAA=
X-CMS-MailID: 20250214105330epcas5p13b0d5bef72b012d71e850c9454015880
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250214105330epcas5p13b0d5bef72b012d71e850c9454015880
References: <CGME20250214105330epcas5p13b0d5bef72b012d71e850c9454015880@epcas5p1.samsung.com>

DesignWare controller provides a vendor specific extended capability
called RASDES as an IP feature. This extended capability  provides
hardware information like:
 - Debug registers to know the state of the link or controller. 
 - Error injection mechanisms to inject various PCIe errors including
   sequence number, CRC
 - Statistical counters to know how many times a particular event
   occurred

However, in Linux we do not have any generic or custom support to be
able to use this feature in an efficient manner. This is the reason we
are proposing this framework. Debug and bring up time of high-speed IPs
are highly dependent on costlier hardware analyzers and this solution
will in some ways help to reduce the HW analyzer usage.

The debugfs entries can be used to get information about underlying
hardware and can be shared with user space. Separate debugfs entries has
been created to cater to all the DES hooks provided by the controller.
The debugfs entries interacts with the RASDES registers in the required
sequence and provides the meaningful data to the user. This eases the
effort to understand and use the register information for debugging.

This series creates a generic debugfs framework for DesignWare PCIe
controllers where other debug features apart from RASDES can also be
added as and when required.

v6:
    - Addressed Niklas's comment to make vsec ID finding similar to perf
    - Minor changes in the driver to make the debugfs file common and
      not specefic to RASDES so that other developers can add debug
      related features to this file.

v5: https://lore.kernel.org/all/20250121111421.35437-1-shradha.t@samsung.com/
    - Addressed Fan's comment to split the patches for easier review
    - Addressed Bjorn's comment to fix vendor specific cap search
    - Addressed style related change requests from v4
    - Added rasdes debugfs init call to common designware files for host
      and EP.

v4: https://lore.kernel.org/lkml/20241206074456.17401-1-shradha.t@samsung.com/
    - Addressed comments from Manivannan, Bjorn and Jonathan
    - Addressed style related change requests from v3
    - Added Documentation under Documentation/ABI/testing and kdoc stype
      comments wherever required for better understanding
    - Enhanced error injection to include all possible error groups
    - Removed debugfs init call from common designware file and left it
      up to individual platform drivers to init/deinit as required.

v3: https://lore.kernel.org/all/20240625093813.112555-1-shradha.t@samsung.com/
    - v2 had suggestions about moving this framework to perf/EDAC instead of a
      controller specific debugfs but after discussions we decided to go ahead
      with the same. Rebased and posted v3 with minor style changes.

v2: https://lore.kernel.org/lkml/20231130115044.53512-1-shradha.t@samsung.com/
    - Addressed comments from Krzysztof Wilczyński, Bjorn Helgaas and
      posted v2 with a changed implementation for a better code design

v1: https://lore.kernel.org/all/20210518174618.42089-1-shradha.t@samsung.com/T/

Shradha Todi (4):
  PCI: dwc: Add support for vendor specific capability search
  Add debugfs based silicon debug support in DWC
  Add debugfs based error injection support in DWC
  Add debugfs based statistical counter support in DWC

 Documentation/ABI/testing/debugfs-dwc-pcie    | 144 +++++
 drivers/pci/controller/dwc/Kconfig            |  10 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 .../controller/dwc/pcie-designware-debugfs.c  | 595 ++++++++++++++++++
 .../pci/controller/dwc/pcie-designware-ep.c   |   5 +
 .../pci/controller/dwc/pcie-designware-host.c |   6 +
 drivers/pci/controller/dwc/pcie-designware.c  |  19 +
 drivers/pci/controller/dwc/pcie-designware.h  |  21 +
 8 files changed, 801 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-dwc-pcie
 create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.c

-- 
2.17.1


