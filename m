Return-Path: <linux-pci+bounces-284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B1E7FF0B8
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 14:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8518281E63
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 13:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0BA47A67;
	Thu, 30 Nov 2023 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ioZJ/VfI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373B0DD
	for <linux-pci@vger.kernel.org>; Thu, 30 Nov 2023 05:51:07 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231130135103epoutp020d920b33880833bf448c0fcf2b156f16~cat6oB0Wf1301213012epoutp028
	for <linux-pci@vger.kernel.org>; Thu, 30 Nov 2023 13:51:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231130135103epoutp020d920b33880833bf448c0fcf2b156f16~cat6oB0Wf1301213012epoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701352263;
	bh=AXEPALESso3IHEGnjNE8OOJAITFOwUrOekyzSLBnaRU=;
	h=From:To:Cc:Subject:Date:References:From;
	b=ioZJ/VfI4RzjktxFoBirM9FR0O23p3Z6nsNjWeoxbkLb61c7VwiRASRf/p+2+PD0M
	 ZDaCGkSqvT5Rxj3yZIYeCz04LbtmRxDVNwMjeOUWqJSXGt3fjs75GsvJ3N8JKoI23r
	 mZNVu6MRwp+lCKf2aUUKCqLX+Fy3PquGOGU3TUAc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20231130135102epcas5p3dc90e298d61549c962fd73a108e01383~cat5y5sGU0205102051epcas5p33;
	Thu, 30 Nov 2023 13:51:02 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4SgyJj5v3qz4x9Pv; Thu, 30 Nov
	2023 13:51:01 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2A.E7.09634.54398656; Thu, 30 Nov 2023 22:51:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20231130115055epcas5p4e29befa80877be45dbee308846edc0ba~cZFBa0JFd0967209672epcas5p4Y;
	Thu, 30 Nov 2023 11:50:55 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231130115055epsmtrp13238ef79585fb52257838b0a311c40f2~cZFBaDxs41720317203epsmtrp1q;
	Thu, 30 Nov 2023 11:50:55 +0000 (GMT)
X-AuditID: b6c32a49-159fd700000025a2-fc-65689345da6c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2A.BE.08817.F1778656; Thu, 30 Nov 2023 20:50:55 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231130115053epsmtip1ddf7dc43938900250ee67d35bc227628~cZE-UPiZ81499114991epsmtip1R;
	Thu, 30 Nov 2023 11:50:53 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com, josh@joshtriplett.org,
	lukas.bulwahn@gmail.com, hongxing.zhu@nxp.com, pankaj.dubey@samsung.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Shradha Todi
	<shradha.t@samsung.com>
Subject: [PATCH v2 0/3] Add support for RAS DES feature in PCIe DW
 controller
Date: Thu, 30 Nov 2023 17:20:41 +0530
Message-Id: <20231130115044.53512-1-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdlhTU9d1ckaqwb5V2hZLmjIsdt3tYLeY
	tW0uo8WKLzPZLf4vyLdo6PnNanF51xw2i7PzjrNZtPxpYbFoOdrOYnG3pZPVYtHWL0Ble3aw
	W/QernXg89g56y67x4JNpR63Xtt6bFrVyeZx59oeNo8nV6YzeWx8t4PJo2/LKkaPLfs/M3p8
	3iQXwBWVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkD
	dL2SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1xMrQwMDI
	FKgwITvj2Z9TTAWLBSv2v1zF0sDYz9fFyMkhIWAiMXf7bdYuRi4OIYHdjBKv7nUxgSSEBD4x
	Snz8Ug2R+MYo8eJXAxtMx6p7nYwQib2MEg8737JBOK1MEttftbOAVLEJaEk0fu1iBkmICHQx
	STxacZIdJMEskCwxr/8O2A5hAX+Ja03PwMayCKhKTOvvYwWxeQWsJJ6+mcEEsU5eYvWGA8wQ
	9l92iYsPeCFsF4mJHfdYIWxhiVfHt7BD2FISL/vboOx0iZWbZ0D15kh827wEaqa9xIErc4AO
	5QC6R1Ni/S59iLCsxNRT65ggzuST6P39BKqcV2LHPBhbWeLL3z0sELakxLxjl6FO8JBYue4T
	CyToYiVeHl3FOIFRdhbChgWMjKsYJVMLinPTU4tNCwzzUsvhEZWcn7uJEZwotTx3MN598EHv
	ECMTB+MhRgkOZiUR3utP01OFeFMSK6tSi/Lji0pzUosPMZoCg2wis5Rocj4wVeeVxBuaWBqY
	mJmZmVgamxkqifO+bp2bIiSQnliSmp2aWpBaBNPHxMEp1cDk1Hb5fVsP+7Un9Z1iPwP/z6y+
	asBx/uW1ZW6i10R0/3xtVf/eaNXTu9v1oNaigDy/EN3Ed4WiTuePV1r/WdhZ8NVsjcpayfkH
	U1XeRa7y1z/I9IH3f/Orx2unnU7Qu/vlMaP5tMyzS6/cWHAl+nqsknIOR3nA7xju+9OM4/gZ
	Nt5PV/yvqjPXv7WpUjjo3pfu7cbc5lsuPev302vtjbXKlhVex5rKK9j6sdjuyArbXUuft0wW
	aT3lp/nq/M7ggJgCS/336syrmC8dmjVzY/GcC7XnWOrkrFIS3x0Qk8+0y5tR2XwtPmHq9duP
	qhTdQhvfZcw7VMR0ctfH0px/S9XsH/K3OEoGJa2uOl7+d7kSS3FGoqEWc1FxIgD0xun0HQQA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsWy7bCSnK58eUaqwfGpkhZLmjIsdt3tYLeY
	tW0uo8WKLzPZLf4vyLdo6PnNanF51xw2i7PzjrNZtPxpYbFoOdrOYnG3pZPVYtHWL0Ble3aw
	W/QernXg89g56y67x4JNpR63Xtt6bFrVyeZx59oeNo8nV6YzeWx8t4PJo2/LKkaPLfs/M3p8
	3iQXwBXFZZOSmpNZllqkb5fAlfHszymmgsWCFftfrmJpYOzn62Lk5JAQMJFYda+TsYuRi0NI
	YDejxPnPK1khEpISny+uY4KwhSVW/nvODlHUzCTx7MYeNpAEm4CWROPXLmaQhIjADCaJlu77
	LCAJZoFUiduH54AVCQv4SjxdcQ7MZhFQlZjW3we2gVfASuLpmxlQG+QlVm84wDyBkWcBI8Mq
	RsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzgsNXS2sG4Z9UHvUOMTByMhxglOJiVRHiv
	P01PFeJNSaysSi3Kjy8qzUktPsQozcGiJM777XVvipBAemJJanZqakFqEUyWiYNTqoHp9EqP
	+VcX/pdPVtiy7upsr/akUoMzU49qb66+Y8zgtXK55Ebb8rmL3Q2idzAtL7u97DmvUmLT14Ku
	1w6Oz3xrf4jM1X7zsJmn96ydbMyeeYEfPt7q76vlXqa8hyWiRbbh5/nuhl+W5xV2bOw2UbV/
	afg7a+ty+0/ek8JCJT7mz135OaM1PLdzR/3n2XU8qxfrvgxv9GkLnGTysXm+ponok4hHBfwN
	HJ27T4tzX1wssVm2eNnzSMHnvzzb/H2jlpXnhrTOFF1fl/pF7uEKpT9xNhcFWmN0K1ef2uiQ
	Et2yKKnSVsrm+/3SKZsmpy1T1I4u+rfjjHHvqlenpr9sUpx3rUzmZONBd52zNczsl94qsRRn
	JBpqMRcVJwIA4+CEqsoCAAA=
X-CMS-MailID: 20231130115055epcas5p4e29befa80877be45dbee308846edc0ba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231130115055epcas5p4e29befa80877be45dbee308846edc0ba
References: <CGME20231130115055epcas5p4e29befa80877be45dbee308846edc0ba@epcas5p4.samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

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

v1 version was posted long back and for some reasons I couldn't work on
it. I apologize for the long break. I'm restarting this activity and
have taken care of all previous review comments shared.
v1: https://lore.kernel.org/all/20210518174618.42089-1-shradha.t@samsung.com/T/

Shradha Todi (3):
  PCI: dwc: Add support for vendor specific capability search
  PCI: debugfs: Add support for RASDES framework in DWC
  PCI: dwc: Create debugfs files in DWC driver

 drivers/pci/controller/dwc/Kconfig            |   8 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 .../controller/dwc/pcie-designware-debugfs.c  | 476 ++++++++++++++++++
 .../controller/dwc/pcie-designware-debugfs.h  |   0
 drivers/pci/controller/dwc/pcie-designware.c  |  20 +
 drivers/pci/controller/dwc/pcie-designware.h  |  18 +
 6 files changed, 523 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.c
 create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.h

-- 
2.17.1


