Return-Path: <linux-pci+bounces-20187-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4705AA17DA6
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 13:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42ADC3A33FE
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 12:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6521BEF82;
	Tue, 21 Jan 2025 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KIEho7Bj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B781A1F2377
	for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2025 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737461703; cv=none; b=QdI2w6Kc9knyTaav9Hy+DucI/PZnTcORBHNq+sY2BMrFsQDAnPr0e/dC8/Hft23mlAE24vsoVcW0a7agVZiljCS4F04Z8w78TtGR9DslRwZ5HNEwAm9DRTlgVBI2TB7ma2XpAP7YR0YJc/tw9gRmKueoPgFzXi1LFL6tD67NehA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737461703; c=relaxed/simple;
	bh=NUk4i/SPmaayWwpfmA6zqwIeYyIBOelZ6oOeMIax5zc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=PkLz9z8t10H50Vk7zFBXxIOR/WNXYanGPdtpZDyc5iNJ/3rwRuz4PLiHeON9Fhy3ycHL7lfea4PQ5fC0J9PkIQeW3zVdGC/kXa84w8XMnDJNDbAD6qiiullaA1mJMf4G8c01s6yri/YtJRiCRk//hfwB5olXzfWjGK1mY+OR8Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KIEho7Bj; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250121121459epoutp028d91d5f1b834900882ed6722eeaa41df~ctDXlgKih2361923619epoutp02Z
	for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2025 12:14:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250121121459epoutp028d91d5f1b834900882ed6722eeaa41df~ctDXlgKih2361923619epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1737461699;
	bh=CVhXkMaMNrC6nsn01V2f9lAt+sJh0dgdZAWcbUeNBuI=;
	h=From:To:Cc:Subject:Date:References:From;
	b=KIEho7Bj0Q8af9KvD/n1UEyzbGNKLo4fdHUUwLaLVhiQmM8m35D36OrjzP9hkRclc
	 wxqFe6HRuVZ/exxh7QXqwSMy1FrFASElietWfZgguKIj1oyP6aWwOh9+4dOljFqeBp
	 nv8Bw7/4PdYV+XrII6gXJjY+k9uXAul8FgHdltIE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250121121458epcas5p4ffc4f49f49f84c83aedf90d8bf839141~ctDWNWVL90802108021epcas5p4B;
	Tue, 21 Jan 2025 12:14:58 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4YcmNw4Pczz4x9Pp; Tue, 21 Jan
	2025 12:14:56 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4F.4A.20052.0CF8F876; Tue, 21 Jan 2025 21:14:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250121115157epcas5p15f8b34cd76cbbb3b043763e644469b18~csvP3Q4M71635316353epcas5p1T;
	Tue, 21 Jan 2025 11:51:57 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250121115157epsmtrp22623974c524c9542b4f5c579f47e5785~csvP2ZXGe1513315133epsmtrp2m;
	Tue, 21 Jan 2025 11:51:57 +0000 (GMT)
X-AuditID: b6c32a49-3fffd70000004e54-aa-678f8fc0dd25
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	1E.5C.33707.D5A8F876; Tue, 21 Jan 2025 20:51:57 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
	[107.109.115.6]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250121115154epsmtip10441c54040454bf47f4c1eb92d8e62ee~csvNukeI81736817368epsmtip1E;
	Tue, 21 Jan 2025 11:51:54 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@Huawei.com, fan.ni@samsung.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, quic_nitegupt@quicinc.com,
	quic_krichai@quicinc.com, gost.dev@samsung.com, Shradha Todi
	<shradha.t@samsung.com>
Subject: [PATCH v5 0/4] Add support for RAS DES feature in PCIe DW
Date: Tue, 21 Jan 2025 16:44:17 +0530
Message-Id: <20250121111421.35437-1-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRmVeSWpSXmKPExsWy7bCmuu6B/v50g23XZCymH1a0WNKUYdG0
	+i6rxc0DO5ksVnyZyW6xauE1NouGnt+sFpd3zWGzODvvOJtFy58WFou7LZ2sFou2fmG3ePCg
	0qJzzhFmi/97drBb9B6udRDw2DnrLrvHgk2lHi1H3rJ6bFrVyeZx59oeNo8nV6YzeUzcU+fR
	t2UVo8fnTXIBnFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+
	AbpumTlAHygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL89L18lJL
	rAwNDIxMgQoTsjMOTb3CXHBVuuLoskssDYw7xLoYOTkkBEwklu1/y9jFyMUhJLCbUeJ64zFm
	COcTo8Sx2f8QnKUP7rPDtKx8/JAVIrGTUeLE/RdMEE4zk8SXP/8ZQarYBLQkGr92MYPYIgLW
	Eofbt7CBFDELPGWSaD3+kw0kISzgJNH/bBkTiM0ioCrxfNsSsBW8AlYSXTc/sUGsk5dYveEA
	M0RcUOLkzCcsIDYzULx562yw+yQEtnBIvNh9A6rBReLWki2sELawxKvjW6DulpL4/G4vVE26
	xMrNM5gh7ByJb5uXMEHY9hIHrswBWsABtEBTYv0ufYiwrMTUU+uYIPbySfT+fgJVziuxYx6M
	rSzx5e8eFghbUmLescusIGMkBDwkGib7gYSFBGIlzvdsZprAKD8LyTezkHwzC2HxAkbmVYyS
	qQXFuempxaYFhnmp5fCYTc7P3cQITslanjsY7z74oHeIkYmD8RCjBAezkgiv6IeedCHelMTK
	qtSi/Pii0pzU4kOMpsAgnsgsJZqcD8wKeSXxhiaWBiZmZmYmlsZmhkrivM07W9KFBNITS1Kz
	U1MLUotg+pg4OKUamOQVMhy5BWaLs2g31k6L2pN75cx5EY3wqwoNLbwV26bNDefLiTdUmLyf
	pW1CZo/c90ylwFk8782VbhxoO7DPbUnst88X9ZY3XtqxVVvY/ApTG3/h/F453jPKnqr2D7xK
	yg33FO3Ypr20ecF9XtZ3rH4ThdUu/Cl7cmBSlMi6qFktkvIl/3anZ/vym6WJa3w1zDBecq7u
	tKiS98dS1tI7aQX3jaSXOL/duTZ0auarDOElibuiJ71jSZN44Nwx88ry6Ta1EVFRj91/H8s9
	LfHe5tWcpW2pFVvZr/oUux+98vid9GJtIx7j89echKWm/JOZ3pnf9OvszOMm3xdVnDnMdk9f
	4Wz9RtlNv7d/Vn//W4mlOCPRUIu5qDgRAOISvI1SBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSnG5sV3+6wZEvzBbTDytaLGnKsGha
	fZfV4uaBnUwWK77MZLdYtfAam0VDz29Wi8u75rBZnJ13nM2i5U8Li8Xdlk5Wi0Vbv7BbPHhQ
	adE55wizxf89O9gteg/XOgh47Jx1l91jwaZSj5Yjb1k9Nq3qZPO4c20Pm8eTK9OZPCbuqfPo
	27KK0ePzJrkAzigum5TUnMyy1CJ9uwSujENTrzAXXJWuOLrsEksD4w6xLkZODgkBE4mVjx+y
	djFycQgJbGeUOLvtBCNEQlLi88V1TBC2sMTKf8/ZIYoamSS6jqwAK2IT0JJo/NrFDGKLCNhK
	3H80GWwSs8BXJomPn26AJYQFnCT6ny0Dm8QioCrxfNsSdhCbV8BKouvmJzaIDfISqzccYIaI
	C0qcnPmEpYuRA2iQusT6eUIgYWagkuats5knMPLPQlI1C6FqFpKqBYzMqxhFUwuKc9NzkwsM
	9YoTc4tL89L1kvNzNzGCY0graAfjsvV/9Q4xMnEwHmKU4GBWEuEV/dCTLsSbklhZlVqUH19U
	mpNafIhRmoNFSZxXOaczRUggPbEkNTs1tSC1CCbLxMEp1cBkvG3Wqgt3n1zYmurNVT1p5Xkr
	AS85xr2mn8s1Vwddmi1TH2u8/kJgSZ6l4V/tBZMeHz357dnMplvmncLbc6z2nn6hL+a4VzXw
	evzHv/4Gl/8ZXlj/rFJBd/n2rTsvN5T6nJ8zTfAdT/8Gz7L+MxfZjOQvK1y/wHs6zVRTxjTi
	eeSmtS9sl/TPX/U9k6k38eOjide+9mbMuKr1bUL23+fnPFRl2uTcmu9PdSg84/Vzyb+aLT19
	/t+3J9y+lM24dcWEy1XfrJQdplVc0TLKzHl/rKnCTDZ5heTDjW5yn8JMmnzzpU7knlK6ddb1
	9cS7H1LCbDblLVioY+ohdSnzU21TxP+A/7N7770tZX4asXiHuhJLcUaioRZzUXEiADsGHMYQ
	AwAA
X-CMS-MailID: 20250121115157epcas5p15f8b34cd76cbbb3b043763e644469b18
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250121115157epcas5p15f8b34cd76cbbb3b043763e644469b18
References: <CGME20250121115157epcas5p15f8b34cd76cbbb3b043763e644469b18@epcas5p1.samsung.com>

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

v5:
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
 .../controller/dwc/pcie-designware-debugfs.c  | 561 ++++++++++++++++++
 .../pci/controller/dwc/pcie-designware-ep.c   |   5 +
 .../pci/controller/dwc/pcie-designware-host.c |   6 +
 drivers/pci/controller/dwc/pcie-designware.c  |  19 +
 drivers/pci/controller/dwc/pcie-designware.h  |  16 +
 8 files changed, 762 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-dwc-pcie
 create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.c

-- 
2.17.1


