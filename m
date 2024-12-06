Return-Path: <linux-pci+bounces-17830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B227B9E6901
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 09:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CABD51884168
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 08:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B061DF985;
	Fri,  6 Dec 2024 08:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AxLDfEAI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9081DFE31
	for <linux-pci@vger.kernel.org>; Fri,  6 Dec 2024 08:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733474065; cv=none; b=kcrqLtz1eeeh0yP4juIBhyJxVaUzZJ8Kp0tiU76mWH29zrIBFMlCWlrCvUH7MNZ0U59HdarQQkRnVpYiwJH08uL4yPZaOt2nvjnpeVp/sd1STCreQgX++nSO4Ush2kTgAYRTaSzT/bJAcrUp1jlGAmv2dbb8ZtTLez0ze2ufZwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733474065; c=relaxed/simple;
	bh=Y7hyQYliKi59P3EK++qFtNAavnhWZIoTQz1hiPMCIGk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=bfo+uCevKPpOO5Uz+sc5ufF/D2Kagbx9dcBCTHTSDJMcIkR1EARhr382KLs5U3DL0X6dwnZgXcfuomLI7qZOnLZBBmH696zeHBroyQeGabnBeYdwguJprfjaBTdZuEXJlNPKcH3ADGspM+OKhw50b9wTlsZqzBxXF4kUjoIRp0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=AxLDfEAI; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241206083415epoutp0355f26e57d33b649f40bfba4aabdcbe23~OiXf92sXY2333723337epoutp035
	for <linux-pci@vger.kernel.org>; Fri,  6 Dec 2024 08:34:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241206083415epoutp0355f26e57d33b649f40bfba4aabdcbe23~OiXf92sXY2333723337epoutp035
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733474055;
	bh=/2WNDe6QLmRMDxTMHLaeSgssrnQ4gM5C33L7+CC7KuA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=AxLDfEAI6nV03qK8hG4hFw3qEZwCH2yBGwD/BBUcbdKSFB4k7OiEH3iB0JnKKRATI
	 5Y+SpmxoaoHQm3rbYn67LEopz4I+PzI+ckT2K94k0/I3G4GwcuqzpD6p68/Y6mkdLN
	 O5JooPCbNvlsl6xQqdhs7sb9hkk/xNqMhlUgUL8Q=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20241206083413epcas5p2a2f484ded668808c7e339fe8d8277161~OiXe8VFSM0537205372epcas5p2c;
	Fri,  6 Dec 2024 08:34:13 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Y4PgS1qt2z4x9Q9; Fri,  6 Dec
	2024 08:34:12 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	63.D7.19956.407B2576; Fri,  6 Dec 2024 17:34:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20241206074226epcas5p116df75209c19f95223761ba56d179a39~OhqRC_Ttr1687316873epcas5p1u;
	Fri,  6 Dec 2024 07:42:26 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241206074226epsmtrp110fbcd5032905bec982001472bf4eda7~OhqRCAi3-1431314313epsmtrp1C;
	Fri,  6 Dec 2024 07:42:26 +0000 (GMT)
X-AuditID: b6c32a4b-fd1f170000004df4-ac-6752b70452fd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9B.FC.18729.2EAA2576; Fri,  6 Dec 2024 16:42:26 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241206074223epsmtip1be6e21cb5e0321145d5c67ed97d1909a~OhqOFYz8O1582115821epsmtip1C;
	Fri,  6 Dec 2024 07:42:23 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@Huawei.com, fan.ni@samsung.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, quic_nitegupt@quicinc.com,
	quic_krichai@quicinc.com, gost.dev@samsung.com, Shradha Todi
	<shradha.t@samsung.com>
Subject: [PATCH v4 0/2] Add support for RAS DES feature in PCIe DW
Date: Fri,  6 Dec 2024 13:14:54 +0530
Message-Id: <20241206074456.17401-1-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRmVeSWpSXmKPExsWy7bCmui7L9qB0g/k3uS2mH1a0WNKUYdG0
	+i6rxc0DO5ksVnyZyW6xauE1NouGnt+sFpd3zWGzODvvOJtFy58WFou7LZ2sFou2fmG3ePCg
	0qJzzhFmi/97drBb9B6udRDw2DnrLrvHgk2lHi1H3rJ6bFrVyeZx59oeNo8nV6YzeUzcU+fR
	t2UVo8fnTXIBnFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+
	AbpumTlAHygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL89L18lJL
	rAwNDIxMgQoTsjOeztjGXjBRouL093VsDYw3hLsYOTkkBEwkdm97ygRiCwnsZpTYf6W6i5EL
	yP7EKLHnbDc7hPONUeL8jotsMB3nP06CSuxllPjQvpIVwvnCKLH53lN2kCo2AS2Jxq9dzCC2
	iIC1xOH2LWwgRcwCT5kkWo//BBslLOAkMWvXYkYQm0VAVeLNnEawQ3gFrCRe/H3FDrFOXmL1
	hgPMEHFBiZMzn7CA2MxA8eats5lBhkoI7OGQeNR3jBGiwUXiwNxrULcKS7w6vgVqkJTEy/42
	KDtdYuXmGcwQdo7Et81LmCBse4kDV+YALeAAWqApsX6XPkRYVmLqqXVMEHv5JHp/P4Eq55XY
	MQ/GVpb48ncPC4QtKTHv2GVWCNtDovHCGmgAx0ocaH7DNoFRfhaSd2YheWcWwuYFjMyrGCVT
	C4pz01OLTQuM81LL4TGbnJ+7iRGckrW8dzA+evBB7xAjEwfjIUYJDmYlEd7KsMB0Id6UxMqq
	1KL8+KLSnNTiQ4ymwDCeyCwlmpwPzAp5JfGGJpYGJmZmZiaWxmaGSuK8r1vnpggJpCeWpGan
	phakFsH0MXFwSjUwHcy+vOpXh8SbxFM5nzpXBOjI7NzgzsvdcHCeda98TiDb54vdyie9r5y8
	pFxzsqheuscyjM9b009gifiu+gzvDa8SGKeV/eHZXte95LbY2qN3ea//e3u209Ttd3Y3W/eW
	pk1i07QblcLrtba+n3VA/DXruV/fwy1P7fxbl3kuI/Tcmv2NrVYTO67Xvom5EcHcqy6Y8UDt
	2AsLr4qcqfY/j7xU+RVmd0I3dnLshY5+VaOrH6s2dXw4e0QsZYKdYrbF9zdfVx4/lDp76gzL
	CRrqkV0TMx9pVhYu7mKydF6iEHbTYEbj5j8r1bPt8jnUci/PKOQ1O37++uuH9U8VrS+7e6YH
	lZxvKDucLJI1f16IEktxRqKhFnNRcSIAsBbb8FIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42LZdlhJTvfRqqB0g/a70hbTDytaLGnKsGha
	fZfV4uaBnUwWK77MZLdYtfAam0VDz29Wi8u75rBZnJ13nM2i5U8Li8Xdlk5Wi0Vbv7BbPHhQ
	adE55wizxf89O9gteg/XOgh47Jx1l91jwaZSj5Yjb1k9Nq3qZPO4c20Pm8eTK9OZPCbuqfPo
	27KK0ePzJrkAzigum5TUnMyy1CJ9uwSujKcztrEXTJSoOP19HVsD4w3hLkZODgkBE4nzHyex
	dzFycQgJ7GaU2HvmCytEQlLi88V1TBC2sMTKf8+hij4xSrSu3M0GkmAT0JJo/NrFDGKLCNhK
	3H80mRWkiFngK5PEx083wBLCAk4Ss3YtZgSxWQRUJd7MaQSbyitgJfHi7yt2iA3yEqs3HGCG
	iAtKnJz5hKWLkQNokLrE+nlCIGFmoJLmrbOZJzDyz0JSNQuhahaSqgWMzKsYJVMLinPTc4sN
	CwzzUsv1ihNzi0vz0vWS83M3MYJjSUtzB+P2VR/0DjEycTAeYpTgYFYS4a0MC0wX4k1JrKxK
	LcqPLyrNSS0+xCjNwaIkziv+ojdFSCA9sSQ1OzW1ILUIJsvEwSnVwOTjlvxnffu5bbIbN73Q
	1T2m+L5jddnF+gQtId+9NXonF/1m26H8dW9KUNg8LpfEB0d3RdfPqpB11HoqqVxkYDlJ8KfG
	tE8W7zc9/ngzruG1wdbF+6SrzrhKHM2U+9IjoVpj63jjdNxKk3CvePnnCscY03cfnuYm0jhH
	6q3oE5cGwYedv+Mn7VbyKTeL7Z/U6X7h98/33gvv7620W6NZNNnlsaRSyur8T5+tTLIeH56+
	7fCa6b8X6eb2BiX88/3AvVZnjtL952sL6vkOCfvapHFekPt1avsWa+vkKafWb5Kcr7jdsi2/
	LttcUP/EDs/bgt4PvLe9kApSOt+6yTVW7OLvyZFJs9taOfcnek39eVCJpTgj0VCLuag4EQBn
	M+79FAMAAA==
X-CMS-MailID: 20241206074226epcas5p116df75209c19f95223761ba56d179a39
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241206074226epcas5p116df75209c19f95223761ba56d179a39
References: <CGME20241206074226epcas5p116df75209c19f95223761ba56d179a39@epcas5p1.samsung.com>

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

v4:
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

Shradha Todi (2):
  PCI: dwc: Add support for vendor specific capability search
  PCI: dwc: Add debugfs based RASDES support in DWC

 Documentation/ABI/testing/debugfs-dwc-pcie    | 143 +++++
 drivers/pci/controller/dwc/Kconfig            |  11 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 .../controller/dwc/pcie-designware-debugfs.c  | 544 ++++++++++++++++++
 .../controller/dwc/pcie-designware-debugfs.h  |   0
 drivers/pci/controller/dwc/pcie-designware.c  |  16 +
 drivers/pci/controller/dwc/pcie-designware.h  |  18 +
 7 files changed, 733 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-dwc-pcie
 create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.c
 create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.h

-- 
2.17.1


