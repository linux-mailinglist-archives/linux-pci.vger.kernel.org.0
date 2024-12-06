Return-Path: <linux-pci+bounces-17831-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAC79E6902
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 09:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24751882534
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 08:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571241E1A31;
	Fri,  6 Dec 2024 08:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nJAGrqWh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433BC1DDC01
	for <linux-pci@vger.kernel.org>; Fri,  6 Dec 2024 08:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733474068; cv=none; b=Bz7Pwcz487MDEI1hn9Ff8AIlIN+Y88GAygqBTRGVOoEYMMc9iwuEreDFAngH7aMkA9jpmBR7zfsP8t2tWas7rfc56bFG1pprl8AuIW+dk/K69CuacTbphEbAaPmFbZPRnbHe+q9V0f2RXVRmRbJ0eJi1UBSzbIkIAtRBKMiiN6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733474068; c=relaxed/simple;
	bh=jtQkhzpYvRMej+Y2WjaJAjfLsZbTtvyPC3AE28T1wW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=KymSQ9sk2qB7K/ET551xnnXS7D0vZSTgd2HkhlNCWcQVWVKkOYiOAt2o5UDstitsDKwTN4diz8CKMufTg+qnAvwS1P3PDgcGoMJH+KkT30Mxjv2x+FbqR2v2Ak4wR0dym0J0+CiwthN8hMqAVtODxOopOjBGl1EQAZ9sezAnePA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nJAGrqWh; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241206083423epoutp0319be2166f7bc706275d08a1222a6395b~OiXnryWHO2259222592epoutp03k
	for <linux-pci@vger.kernel.org>; Fri,  6 Dec 2024 08:34:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241206083423epoutp0319be2166f7bc706275d08a1222a6395b~OiXnryWHO2259222592epoutp03k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733474063;
	bh=v9zzUqXKSXuD3O/LtBRA2f2NxcOEN6WTl0ID7ZJAz38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nJAGrqWhdYw6SRYwkHaqb4h4PcyGhK/KT8vd7ut6krC08bk3iUYlSTHliKwTc+6Zb
	 A+xJ9yGQYHMPgXuCDqHDwNXBZsn1OiFw34FW/6TlqOkGQYuizdy8+QCffqhjIQwQdO
	 nPChcyBOoIXfapz6Ke9RHD1zdvn0CEStLbACOY8g=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20241206083422epcas5p4abc22a100cacb8dfb7e3e3cc863d3b88~OiXnMrIAG2843128431epcas5p4Y;
	Fri,  6 Dec 2024 08:34:22 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Y4Pgc6fqFz4x9Pw; Fri,  6 Dec
	2024 08:34:20 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E4.1D.20052.C07B2576; Fri,  6 Dec 2024 17:34:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20241206074242epcas5p35c4db25aade3f328a93475225c170bb7~OhqgCiChO2147021470epcas5p3f;
	Fri,  6 Dec 2024 07:42:42 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241206074242epsmtrp2359e72d01015565f75e1959cf94e75b5~OhqgBtlOA0930109301epsmtrp2p;
	Fri,  6 Dec 2024 07:42:42 +0000 (GMT)
X-AuditID: b6c32a49-3fffd70000004e54-46-6752b70c7aa8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FF.0E.18949.2FAA2576; Fri,  6 Dec 2024 16:42:42 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241206074240epsmtip14916c559115d67c472f81cd57e77756d~OhqdsMyM71378213782epsmtip1J;
	Fri,  6 Dec 2024 07:42:40 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@Huawei.com, fan.ni@samsung.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, quic_nitegupt@quicinc.com,
	quic_krichai@quicinc.com, gost.dev@samsung.com, Shradha Todi
	<shradha.t@samsung.com>
Subject: [PATCH v4 2/2] PCI: dwc: Add debugfs based RASDES support in DWC
Date: Fri,  6 Dec 2024 13:14:56 +0530
Message-Id: <20241206074456.17401-3-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241206074456.17401-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmli7P9qB0g913DCymH1a0WNKUYdG0
	+i6rxc0DO5ksVnyZyW6xauE1NouGnt+sFpd3zWGzODvvOJtFy58WFou7LZ2sFou2fmG3ePCg
	0qJzzhFmi/97drBb9B6udRDw2DnrLrvHgk2lHi1H3rJ6bFrVyeZx59oeNo8nV6YzeUzcU+fR
	t2UVo8fnTXIBnFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+
	AbpumTlAHygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL89L18lJL
	rAwNDIxMgQoTsjM2LbzDWDDtJmPFiqfTmBsYl25h7GLk5JAQMJHo/viVtYuRi0NIYDejxJYP
	q1kgnE+MEv82HGeDcL4xShxYexOuZc6/54wQib2MEicvHINyvjBKzJr8gBmkik1AS6LxaxeY
	LSJgLXG4fQvYKGaBp0wSrcd/soEkhAU8JS7+eMYEYrMIqEr8aJ8EZvMKWElM/doLtU5eYvWG
	A0CDODg4gQZN/RUAMkdCYCGHxPvDR1khalwkdj3ezwRhC0u8Or6FHcKWkvj8bi8bhJ0usXLz
	DGYIO0fi2+YlUPX2EgeuzGEBmc8soCmxfpc+RFhWYuqpdWAlzAJ8Er2/n0CV80rsmAdjK0t8
	+buHBcKWlJh37DLUOR4SW5/MgAZqH6PE/ilf2Scwys1CWLGAkXEVo2RqQXFuemqxaYFhXmo5
	POKS83M3MYITqpbnDsa7Dz7oHWJk4mA8xCjBwawkwlsZFpguxJuSWFmVWpQfX1Sak1p8iNEU
	GH4TmaVEk/OBKT2vJN7QxNLAxMzMzMTS2MxQSZz3devcFCGB9MSS1OzU1ILUIpg+Jg5OqQam
	knr2TDuLRZ/la748WXdOuWr3yjNbz6+ZXLn4asqbtRmqlnJsqvcrM5gdBdTNDudt2MXXJXHI
	99b74l6Hd3rNJf+fhq2YZtNuumOlKEeoo01GN6tmdaD5hDlLNWeIiG0Q+eFtnsr6UIL/8b1F
	US0xD/OF/NZKyLkE6ez6P32OreD/e49Or1SPMlJ/wP7rXoTR//8xM21vH7Z92Bn3LdPZ43Gu
	2TuJbIF2jwblRS5VSx853px0a7bI/F0BHyPWqxTE7D9coKB7T/LZZ94bv17diz+jpx78SWzK
	kflH9erPeN0/b3n/WrTenZ7qV1PX1f9gebXkSgmP5KbEp/6i1RYTuW46aCjZ9cUeUGs5fXKr
	EktxRqKhFnNRcSIACVLuUzEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWy7bCSnO6nVUHpBut/qFlMP6xosaQpw6Jp
	9V1Wi5sHdjJZrPgyk91i1cJrbBYNPb9ZLS7vmsNmcXbecTaLlj8tLBZ3WzpZLRZt/cJu8eBB
	pUXnnCPMFv/37GC36D1c6yDgsXPWXXaPBZtKPVqOvGX12LSqk83jzrU9bB5Prkxn8pi4p86j
	b8sqRo/Pm+QCOKO4bFJSczLLUov07RK4MjYtvMNYMO0mY8WKp9OYGxiXbmHsYuTkkBAwkZjz
	7zmQzcUhJLCbUeJn/yUWiISkxOeL65ggbGGJlf+es0MUfWKUOLnlH1gRm4CWROPXLmYQW0TA
	VuL+o8msIEXMAl+ZJD5+ugGWEBbwlLj44xnYJBYBVYkf7ZPAbF4BK4mpX3uhzpCXWL3hAFA9
	BwengLXE1F8BIGEhoJL1Lf/ZJjDyLWBkWMUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJ
	ERzwWlo7GPes+qB3iJGJg/EQowQHs5IIb2VYYLoQb0piZVVqUX58UWlOavEhRmkOFiVx3m+v
	e1OEBNITS1KzU1MLUotgskwcnFINTCIlZkuXhKmV5D1ZwrZl0uNPWZ/N+wXiF/RXKRxNeLRs
	7vfbThHqVR1XFqov6uqocV8YlKPL//qNkYpw73dX/81sHVlhGmvtXDfmBZcl35xpabvjzqPX
	IdWZIavuvOso2M7oIOUoFuygHuHezum/+u6m3gf3H5yxqOCI+W6/bp79zYfH6lfInFt1frFx
	HVNv69l4n57lqvOu7GVv3/buR9S3B+XMTaFXpbf+f6a69mQaQ+EM90K1Z8mZbhMfvfl9/eiv
	xde6uze6/mS2vj9juZvEBalHHTe/6t6d3XImxPpq0fvsM+uezNQuEm/v6uBlLF9+ebnMx/sR
	i8Stq3O3zNtXEnxWtY1xzfPJu/uC1yqxFGckGmoxFxUnAgCKFc695wIAAA==
X-CMS-MailID: 20241206074242epcas5p35c4db25aade3f328a93475225c170bb7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241206074242epcas5p35c4db25aade3f328a93475225c170bb7
References: <20241206074456.17401-1-shradha.t@samsung.com>
	<CGME20241206074242epcas5p35c4db25aade3f328a93475225c170bb7@epcas5p3.samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add support to use the RASDES feature of DesignWare PCIe controller
using debugfs entries.

RASDES is a vendor specific extended PCIe capability which reads the
current hardware internal state of PCIe device. Following primary
features are provided to userspace via debugfs:
- Debug registers
- Error injection
- Statistical counters

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 Documentation/ABI/testing/debugfs-dwc-pcie    | 143 +++++
 drivers/pci/controller/dwc/Kconfig            |  11 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 .../controller/dwc/pcie-designware-debugfs.c  | 544 ++++++++++++++++++
 .../controller/dwc/pcie-designware-debugfs.h  |   0
 drivers/pci/controller/dwc/pcie-designware.h  |  17 +
 6 files changed, 716 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-dwc-pcie
 create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.c
 create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.h

diff --git a/Documentation/ABI/testing/debugfs-dwc-pcie b/Documentation/ABI/testing/debugfs-dwc-pcie
new file mode 100644
index 000000000000..7da73ac8d40c
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-dwc-pcie
@@ -0,0 +1,143 @@
+What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_debug/lane_detect
+Date:		December 2024
+Contact:	Shradha Todi <shradha.t@samsung.com>
+Description:	(RW) Write the lane number to be checked for detection.	Read
+		will dump whether PHY indicates receiver detection on the
+		selected lane.
+
+What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_debug/rx_valid
+Date:		December 2024
+Contact:	Shradha Todi <shradha.t@samsung.com>
+Description:	(RW) Write the lane number to be checked as valid or invalid. Read
+		will dump the status of PIPE RXVALID signal of the selected lane.
+
+What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_event_counters/<event>/counter_enable
+Date:		December 2024
+Contact:	Shradha Todi <shradha.t@samsung.com>
+Description:	rasdes_event_counters is the directory which can be used to collect
+		statistical data about the number of times a certain event has occurred
+		in the controller. The list of possible events are:
+
+		1) EBUF Overflow
+		2) EBUF Underrun
+		3) Decode Error
+		4) Running Disparity Error
+		5) SKP OS Parity Error
+		6) SYNC Header Error
+		7) Rx Valid De-assertion
+		8) CTL SKP OS Parity Error
+		9) 1st Retimer Parity Error
+		10) 2nd Retimer Parity Error
+		11) Margin CRC and Parity Error
+		12) Detect EI Infer
+		13) Receiver Error
+		14) RX Recovery Req
+		15) N_FTS Timeout
+		16) Framing Error
+		17) Deskew Error
+		18) Framing Error In L0
+		19) Deskew Uncompleted Error
+		20) Bad TLP
+		21) LCRC Error
+		22) Bad DLLP
+		23) Replay Number Rollover
+		24) Replay Timeout
+		25) Rx Nak DLLP
+		26) Tx Nak DLLP
+		27) Retry TLP
+		28) FC Timeout
+		29) Poisoned TLP
+		30) ECRC Error
+		31) Unsupported Request
+		32) Completer Abort
+		33) Completion Timeout
+		34) EBUF SKP Add
+		35) EBUF SKP Del
+
+		counter_enable is RW. Write 1 to enable the event counter and write 0 to
+		disable the event counter. Read will dump whether the counter is currently
+		enabled	or disabled.
+
+What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_event_counters/<event>/counter_value
+Date:		December 2024
+Contact:	Shradha Todi <shradha.t@samsung.com>
+Description:	(RO) Read will dump the current value of the event counter. To reset the counter,
+		we can disable and re-enable the counter.
+
+What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_event_counters/<event>/lane_select
+Date:		December 2024
+Contact:	Shradha Todi <shradha.t@samsung.com>
+Description:	(RW) Some lanes in the event list are lane specific events. These include
+		events 1) - 11) and 34) - 35).
+		Write lane number for which counter needs to be enabled/disabled/dumped.
+		Read will dump the current selected lane number.
+
+What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_err_inj/<error>
+Date:		December 2024
+Contact:	Shradha Todi <shradha.t@samsung.com>
+Description:	rasdes_err_inj is the directory which can be used to inject errors in the
+		system. The possible errors that can be injected are:
+
+		1) TLP LCRC error injection TX Path - tx_lcrc
+		2) 16b CRC error injection of ACK/NAK DLLP - b16_crc_dllp
+		3) 16b CRC error injection of Update-FC DLLP - b16_crc_upd_fc
+		4) TLP ECRC error injection TX Path - tx_ecrc
+		5) TLP's FCRC error injection TX Path - fcrc_tlp
+		6) Parity error of TSOS - parity_tsos
+		7) Parity error on SKPOS - parity_skpos
+		8) LCRC error injection RX Path - rx_lcrc
+		9) ECRC error injection RX Path - rx_ecrc
+		10) TLPs SEQ# error - tlp_err_seq
+		11) DLLPS ACK/NAK SEQ# error - ack_nak_dllp_seq
+		12) ACK/NAK DLLPs transmission block - ack_nak_dllp
+		13) UpdateFC DLLPs transmission block - upd_fc_dllp
+		14) Always transmission for NAK DLLP - nak_dllp
+		15) Invert SYNC header - inv_sync_hdr_sym
+		16) COM/PAD TS1 order set - com_pad_ts1
+		17) COM/PAD TS2 order set - com_pad_ts2
+		18) COM/FTS FTS order set - com_fts
+		19) COM/IDL E-idle order set - com_idl
+		20) END/EDB symbol - end_edb
+		21) STP/SDP symbol - stp_sdp
+		22) COM/SKP SKP order set - com_skp
+		23) Posted TLP Header credit value control - posted_tlp_hdr
+		24) Non-Posted TLP Header credit value control - non_post_tlp_hdr
+		25) Completion TLP Header credit value control - cmpl_tlp_hdr
+		26) Posted TLP Data credit value control - posted_tlp_data
+		27) Non-Posted TLP Data credit value control - non_post_tlp_data
+		28) Completion TLP Data credit value control - cmpl_tlp_data
+		29) Generates duplicate TLPs - duplicate_dllp
+		30) Generates Nullified TLPs - nullified_tlp
+
+		Each of the possible errors are WO files. Write to the file will prepare
+		controller to inject the respective error in the next transmission of data.
+		Parameter required to write will change in the following ways:
+
+		i) Errors 9) - 10) are sequence errors. The write command for these will be
+
+			echo <count> <diff> > /sys/kernel/debug/dwc_pcie_<dev>/rasdes_err_inj/<error>
+
+			<count>
+				Number of errors to be injected
+			<diff>
+				The difference to add or subtract from natural sequence number to
+				generate sequence error. Range (-4095 : 4095)
+
+		ii) Errors 23) - 28) are credit value error insertions. Write command:
+
+			echo <count> <diff> <vc> > /sys/kernel/debug/dwc_pcie_<dev>/rasdes_err_inj/<error>
+
+			<count>
+				Number of errors to be injected
+			<diff>
+				The difference to add or subtract from UpdateFC credit value.
+				Range (-4095 : 4095)
+			<vc>
+				Target VC number
+
+		iii) All other errors. Write command:
+
+			echo <count> > /sys/kernel/debug/dwc_pcie_<dev>/rasdes_err_inj/<error>
+
+			<count>
+				Number of errors to be injected
diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index b6d6778b0698..9ab8d724fe0d 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -6,6 +6,17 @@ menu "DesignWare-based PCIe controllers"
 config PCIE_DW
 	bool
 
+config PCIE_DW_DEBUGFS
+	default y
+	depends on DEBUG_FS
+	depends on PCIE_DW_HOST || PCIE_DW_EP
+	bool "DWC PCIe debugfs entries"
+	help
+	  Enables debugfs entries for the DWC PCIe Controller.
+	  These entries make use of the RAS features in the DW
+	  controller to help in debug, error injection and statistical
+	  counters
+
 config PCIE_DW_HOST
 	bool
 	select PCIE_DW
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index a8308d9ea986..54565eedc52c 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PCIE_DW) += pcie-designware.o
+obj-$(CONFIG_PCIE_DW_DEBUGFS) += pcie-designware-debugfs.o
 obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
 obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
 obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
new file mode 100644
index 000000000000..a93e29993f75
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -0,0 +1,544 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Synopsys DesignWare PCIe controller debugfs driver
+ *
+ * Copyright (C) 2024 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Author: Shradha Todi <shradha.t@samsung.com>
+ */
+
+#include <linux/debugfs.h>
+
+#include "pcie-designware.h"
+
+#define SD_STATUS_L1LANE_REG		0xb0
+#define PIPE_DETECT_LANE		BIT(17)
+#define PIPE_RXVALID			BIT(18)
+#define LANE_SELECT			GENMASK(3, 0)
+
+#define RAS_DES_EVENT_COUNTER_CTRL_REG	0x8
+#define EVENT_COUNTER_GROUP_SELECT	GENMASK(27, 24)
+#define EVENT_COUNTER_EVENT_SELECT	GENMASK(23, 16)
+#define EVENT_COUNTER_LANE_SELECT	GENMASK(11, 8)
+#define EVENT_COUNTER_STATUS		BIT(7)
+#define EVENT_COUNTER_ENABLE		GENMASK(4, 2)
+#define PER_EVENT_OFF			0x1
+#define PER_EVENT_ON			0x3
+
+#define RAS_DES_EVENT_COUNTER_DATA_REG	0xc
+
+#define ERR_INJ_ENABLE_REG		0x30
+#define ERR_INJ0_OFF			0x34
+#define EINJ_COUNT			GENMASK(7, 0)
+#define EINJ_TYPE_SHIFT			8
+#define EINJ0_TYPE			GENMASK(11, 8)
+#define EINJ1_TYPE			BIT(8)
+#define EINJ2_TYPE			GENMASK(9, 8)
+#define EINJ3_TYPE			GENMASK(10, 8)
+#define EINJ4_TYPE			GENMASK(10, 8)
+#define EINJ5_TYPE			BIT(8)
+#define EINJ_VC_NUM			GENMASK(14, 12)
+#define EINJ_VAL_DIFF			GENMASK(28, 16)
+
+#define DWC_DEBUGFS_BUF_MAX		128
+
+/**
+ * struct dwc_pcie_rasdes_info - Stores controller common information
+ * @ras_cap_offset: RAS DES vendor specific extended capability offset
+ * @reg_lock: Mutex used for RASDES shadow event registers
+ * @rasdes_dir: Top level debugfs directory entry
+ *
+ * Any parameter constant to all files of the debugfs hierarchy for a single controller
+ * will be stored in this struct. It is allocated and assigned to controller specific
+ * struct dw_pcie during initialization.
+ */
+struct dwc_pcie_rasdes_info {
+	u32 ras_cap_offset;
+	struct mutex reg_lock;
+	struct dentry *rasdes_dir;
+};
+
+/**
+ * struct dwc_pcie_rasdes_priv - Stores file specific private data information
+ * @pci: Reference to the dw_pcie structure
+ * @idx: Index to point to specific file related information in array of structs
+ *
+ * All debugfs files will have this struct as its private data.
+ */
+struct dwc_pcie_rasdes_priv {
+	struct dw_pcie *pci;
+	int idx;
+};
+
+/**
+ * struct dwc_pcie_event_counter - Store details about each event counter supported in DWC RASDES
+ * @name: Name of the error counter
+ * @group_no: Group number that the event belongs to. Value ranges from 0 - 4
+ * @event_no: Event number of the particular event. Value ranges from -
+ *		Group 0: 0 - 10
+ *		Group 1: 5 - 13
+ *		Group 2: 0 - 7
+ *		Group 3: 0 - 5
+ *		Group 4: 0 - 1
+ */
+struct dwc_pcie_event_counter {
+	const char *name;
+	u32 group_no;
+	u32 event_no;
+};
+
+static const struct dwc_pcie_event_counter event_list[] = {
+	{"ebuf_overflow", 0x0, 0x0},
+	{"ebuf_underrun", 0x0, 0x1},
+	{"decode_err", 0x0, 0x2},
+	{"running_disparity_err", 0x0, 0x3},
+	{"skp_os_parity_err", 0x0, 0x4},
+	{"sync_header_err", 0x0, 0x5},
+	{"rx_valid_deassertion", 0x0, 0x6},
+	{"ctl_skp_os_parity_err", 0x0, 0x7},
+	{"retimer_parity_err_1st", 0x0, 0x8},
+	{"retimer_parity_err_2nd", 0x0, 0x9},
+	{"margin_crc_parity_err", 0x0, 0xA},
+	{"detect_ei_infer", 0x1, 0x5},
+	{"receiver_err", 0x1, 0x6},
+	{"rx_recovery_req", 0x1, 0x7},
+	{"n_fts_timeout", 0x1, 0x8},
+	{"framing_err", 0x1, 0x9},
+	{"deskew_err", 0x1, 0xa},
+	{"framing_err_in_l0", 0x1, 0xc},
+	{"deskew_uncompleted_err", 0x1, 0xd},
+	{"bad_tlp", 0x2, 0x0},
+	{"lcrc_err", 0x2, 0x1},
+	{"bad_dllp", 0x2, 0x2},
+	{"replay_num_rollover", 0x2, 0x3},
+	{"replay_timeout", 0x2, 0x4},
+	{"rx_nak_dllp", 0x2, 0x5},
+	{"tx_nak_dllp", 0x2, 0x6},
+	{"retry_tlp", 0x2, 0x7},
+	{"fc_timeout", 0x3, 0x0},
+	{"poisoned_tlp", 0x3, 0x1},
+	{"ecrc_error", 0x3, 0x2},
+	{"unsupported_request", 0x3, 0x3},
+	{"completer_abort", 0x3, 0x4},
+	{"completion_timeout", 0x3, 0x5},
+	{"ebuf_skp_add", 0x4, 0x0},
+	{"ebuf_skp_del", 0x4, 0x1},
+};
+
+/**
+ * struct dwc_pcie_err_inj - Store details about each error injection supported by DWC RASDES
+ * @name: Name of the error that can be injected
+ * @err_inj_group: Group number to which the error belongs to. Value can range from 0 - 5
+ * @err_inj_type: Each group can have multiple types of error
+ */
+struct dwc_pcie_err_inj {
+	const char *name;
+	u32 err_inj_group;
+	u32 err_inj_type;
+};
+
+static const struct dwc_pcie_err_inj err_inj_list[] = {
+	{"tx_lcrc", 0x0, 0x0},
+	{"b16_crc_dllp", 0x0, 0x1},
+	{"b16_crc_upd_fc", 0x0, 0x2},
+	{"tx_ecrc", 0x0, 0x3},
+	{"fcrc_tlp", 0x0, 0x4},
+	{"parity_tsos", 0x0, 0x5},
+	{"parity_skpos", 0x0, 0x6},
+	{"rx_lcrc", 0x0, 0x8},
+	{"rx_ecrc", 0x0, 0xb},
+	{"tlp_err_seq", 0x1, 0x0},
+	{"ack_nak_dllp_seq", 0x1, 0x1},
+	{"ack_nak_dllp", 0x2, 0x0},
+	{"upd_fc_dllp", 0x2, 0x1},
+	{"nak_dllp", 0x2, 0x2},
+	{"inv_sync_hdr_sym", 0x3, 0x0},
+	{"com_pad_ts1", 0x3, 0x1},
+	{"com_pad_ts2", 0x3, 0x2},
+	{"com_fts", 0x3, 0x3},
+	{"com_idl", 0x3, 0x4},
+	{"end_edb", 0x3, 0x5},
+	{"stp_sdp", 0x3, 0x6},
+	{"com_skp", 0x3, 0x7},
+	{"posted_tlp_hdr", 0x4, 0x0},
+	{"non_post_tlp_hdr", 0x4, 0x1},
+	{"cmpl_tlp_hdr", 0x4, 0x2},
+	{"posted_tlp_data", 0x4, 0x4},
+	{"non_post_tlp_data", 0x4, 0x5},
+	{"cmpl_tlp_data", 0x4, 0x6},
+	{"duplicate_dllp", 0x5, 0x0},
+	{"nullified_tlp", 0x5, 0x1},
+};
+
+static const u32 err_inj_type_mask[] = {
+	EINJ0_TYPE,
+	EINJ1_TYPE,
+	EINJ2_TYPE,
+	EINJ3_TYPE,
+	EINJ4_TYPE,
+	EINJ5_TYPE,
+};
+
+static ssize_t lane_detect_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+{
+	struct dw_pcie *pci = file->private_data;
+	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
+	char debugfs_buf[DWC_DEBUGFS_BUF_MAX];
+	ssize_t off = 0;
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG);
+	val = FIELD_GET(PIPE_DETECT_LANE, val);
+	if (val)
+		off += scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, "Lane Detected\n");
+	else
+		off += scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, "Lane Undetected\n");
+
+	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, off);
+}
+
+static ssize_t lane_detect_write(struct file *file, const char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	struct dw_pcie *pci = file->private_data;
+	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
+	u32 lane, val;
+
+	val = kstrtou32_from_user(buf, count, 0, &lane);
+	if (val)
+		return val;
+
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG);
+	val &= ~(LANE_SELECT);
+	val |= FIELD_PREP(LANE_SELECT, lane);
+	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG, val);
+
+	return count;
+}
+
+static ssize_t rx_valid_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+{
+	struct dw_pcie *pci = file->private_data;
+	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
+	char debugfs_buf[DWC_DEBUGFS_BUF_MAX];
+	ssize_t off = 0;
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG);
+	val = FIELD_GET(PIPE_RXVALID, val);
+	if (val)
+		off += scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, "RX Valid\n");
+	else
+		off += scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, "RX Invalid\n");
+
+	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, off);
+}
+
+static ssize_t rx_valid_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
+{
+	return lane_detect_write(file, buf, count, ppos);
+}
+
+static void set_event_number(struct dwc_pcie_rasdes_priv *pdata, struct dw_pcie *pci,
+			     struct dwc_pcie_rasdes_info *rinfo)
+{
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
+	val &= ~EVENT_COUNTER_ENABLE;
+	val &= ~(EVENT_COUNTER_GROUP_SELECT | EVENT_COUNTER_EVENT_SELECT);
+	val |= FIELD_PREP(EVENT_COUNTER_GROUP_SELECT, event_list[pdata->idx].group_no);
+	val |= FIELD_PREP(EVENT_COUNTER_EVENT_SELECT, event_list[pdata->idx].event_no);
+	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
+}
+
+static ssize_t counter_enable_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+{
+	struct dwc_pcie_rasdes_priv *pdata = file->private_data;
+	struct dw_pcie *pci = pdata->pci;
+	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
+	char debugfs_buf[DWC_DEBUGFS_BUF_MAX];
+	ssize_t off = 0;
+	u32 val;
+
+	mutex_lock(&rinfo->reg_lock);
+	set_event_number(pdata, pci, rinfo);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
+	mutex_unlock(&rinfo->reg_lock);
+	val = FIELD_GET(EVENT_COUNTER_STATUS, val);
+	if (val)
+		off += scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, "Counter Enabled\n");
+	else
+		off += scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, "Counter Disabled\n");
+
+	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, off);
+}
+
+static ssize_t counter_enable_write(struct file *file, const char __user *buf,
+				    size_t count, loff_t *ppos)
+{
+	struct dwc_pcie_rasdes_priv *pdata = file->private_data;
+	struct dw_pcie *pci = pdata->pci;
+	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
+	u32 val, enable;
+
+	val = kstrtou32_from_user(buf, count, 0, &enable);
+	if (val)
+		return val;
+
+	mutex_lock(&rinfo->reg_lock);
+	set_event_number(pdata, pci, rinfo);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
+	if (enable)
+		val |= FIELD_PREP(EVENT_COUNTER_ENABLE, PER_EVENT_ON);
+	else
+		val |= FIELD_PREP(EVENT_COUNTER_ENABLE, PER_EVENT_OFF);
+
+	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
+	mutex_unlock(&rinfo->reg_lock);
+
+	return count;
+}
+
+static ssize_t counter_lane_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+{
+	struct dwc_pcie_rasdes_priv *pdata = file->private_data;
+	struct dw_pcie *pci = pdata->pci;
+	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
+	char debugfs_buf[DWC_DEBUGFS_BUF_MAX];
+	ssize_t off = 0;
+	u32 val;
+
+	mutex_lock(&rinfo->reg_lock);
+	set_event_number(pdata, pci, rinfo);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
+	mutex_unlock(&rinfo->reg_lock);
+	val = FIELD_GET(EVENT_COUNTER_LANE_SELECT, val);
+	off += scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, "Lane: %d\n", val);
+
+	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, off);
+}
+
+static ssize_t counter_lane_write(struct file *file, const char __user *buf,
+				  size_t count, loff_t *ppos)
+{
+	struct dwc_pcie_rasdes_priv *pdata = file->private_data;
+	struct dw_pcie *pci = pdata->pci;
+	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
+	u32 val, lane;
+
+	val = kstrtou32_from_user(buf, count, 0, &lane);
+	if (val)
+		return val;
+
+	mutex_lock(&rinfo->reg_lock);
+	set_event_number(pdata, pci, rinfo);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
+	val &= ~(EVENT_COUNTER_LANE_SELECT);
+	val |= FIELD_PREP(EVENT_COUNTER_LANE_SELECT, lane);
+	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
+	mutex_unlock(&rinfo->reg_lock);
+
+	return count;
+}
+
+static ssize_t counter_value_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+{
+	struct dwc_pcie_rasdes_priv *pdata = file->private_data;
+	struct dw_pcie *pci = pdata->pci;
+	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
+	char debugfs_buf[DWC_DEBUGFS_BUF_MAX];
+	ssize_t off = 0;
+	u32 val;
+
+	mutex_lock(&rinfo->reg_lock);
+	set_event_number(pdata, pci, rinfo);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_DATA_REG);
+	mutex_unlock(&rinfo->reg_lock);
+	off += scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, "Counter value: %d\n", val);
+
+	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, off);
+}
+
+static ssize_t err_inj_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
+{
+	struct dwc_pcie_rasdes_priv *pdata = file->private_data;
+	struct dw_pcie *pci = pdata->pci;
+	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
+	u32 val, counter, vc_num, err_group, type_mask;
+	int val_diff = 0;
+	char *kern_buf;
+
+	err_group = err_inj_list[pdata->idx].err_inj_group;
+	type_mask = err_inj_type_mask[err_group];
+
+	kern_buf = memdup_user_nul(buf, count);
+	if (IS_ERR(kern_buf))
+		return PTR_ERR(kern_buf);
+
+	if (err_group == 4) {
+		val = sscanf(kern_buf, "%u %d %u", &counter, &val_diff, &vc_num);
+		if ((val != 3) || (val_diff < -4095 || val_diff > 4095)) {
+			kfree(kern_buf);
+			return -EINVAL;
+		}
+	} else if (err_group == 1) {
+		val = sscanf(kern_buf, "%u %d", &counter, &val_diff);
+		if ((val != 2) || (val_diff < -4095 || val_diff > 4095)) {
+			kfree(kern_buf);
+			return -EINVAL;
+		}
+	} else {
+		val = kstrtou32(kern_buf, 0, &counter);
+		if (val) {
+			kfree(kern_buf);
+			return val;
+		}
+	}
+
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + ERR_INJ0_OFF + (0x4 * err_group));
+	val &= ~(type_mask | EINJ_COUNT);
+	val |= ((err_inj_list[pdata->idx].err_inj_type << EINJ_TYPE_SHIFT) & type_mask);
+	val |= FIELD_PREP(EINJ_COUNT, counter);
+
+	if (err_group == 1 || err_group == 4) {
+		val &= ~(EINJ_VAL_DIFF);
+		val |= FIELD_PREP(EINJ_VAL_DIFF, val_diff);
+	}
+	if (err_group == 4) {
+		val &= ~(EINJ_VC_NUM);
+		val |= FIELD_PREP(EINJ_VC_NUM, vc_num);
+	}
+
+	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + ERR_INJ0_OFF + (0x4 * err_group), val);
+	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + ERR_INJ_ENABLE_REG, (0x1 << err_group));
+
+	kfree(kern_buf);
+	return count;
+}
+
+#define dwc_debugfs_create(name)			\
+debugfs_create_file(#name, 0644, rasdes_debug, pci,	\
+			&dbg_ ## name ## _fops)
+
+#define DWC_DEBUGFS_FOPS(name)					\
+static const struct file_operations dbg_ ## name ## _fops = {	\
+	.open = simple_open,				\
+	.read = name ## _read,				\
+	.write = name ## _write				\
+}
+
+DWC_DEBUGFS_FOPS(lane_detect);
+DWC_DEBUGFS_FOPS(rx_valid);
+
+static const struct file_operations dwc_pcie_counter_enable_ops = {
+	.open = simple_open,
+	.read = counter_enable_read,
+	.write = counter_enable_write,
+};
+
+static const struct file_operations dwc_pcie_counter_lane_ops = {
+	.open = simple_open,
+	.read = counter_lane_read,
+	.write = counter_lane_write,
+};
+
+static const struct file_operations dwc_pcie_counter_value_ops = {
+	.open = simple_open,
+	.read = counter_value_read,
+};
+
+static const struct file_operations dwc_pcie_err_inj_ops = {
+	.open = simple_open,
+	.write = err_inj_write,
+};
+
+void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
+{
+	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
+
+	debugfs_remove_recursive(rinfo->rasdes_dir);
+	mutex_destroy(&rinfo->reg_lock);
+}
+
+int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci)
+{
+	struct dentry *dir, *rasdes_debug, *rasdes_err_inj, *rasdes_event_counter, *rasdes_events;
+	struct dwc_pcie_rasdes_info *rasdes_info;
+	struct dwc_pcie_rasdes_priv *priv_tmp;
+	char dirname[DWC_DEBUGFS_BUF_MAX];
+	struct device *dev = pci->dev;
+	int ras_cap, i, ret;
+
+	ras_cap = dw_pcie_find_vsec_capability(pci, DW_PCIE_VSEC_EXT_CAP_RAS_DES);
+	if (!ras_cap) {
+		dev_dbg(dev, "No RASDES capability available\n");
+		return -ENODEV;
+	}
+
+	rasdes_info = devm_kzalloc(dev, sizeof(*rasdes_info), GFP_KERNEL);
+	if (!rasdes_info)
+		return -ENOMEM;
+
+	/* Create main directory for each platform driver */
+	snprintf(dirname, DWC_DEBUGFS_BUF_MAX, "dwc_pcie_%s", dev_name(dev));
+	dir = debugfs_create_dir(dirname, NULL);
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
+
+	/* Create subdirectories for Debug, Error injection, Statistics */
+	rasdes_debug = debugfs_create_dir("rasdes_debug", dir);
+	rasdes_err_inj = debugfs_create_dir("rasdes_err_inj", dir);
+	rasdes_event_counter = debugfs_create_dir("rasdes_event_counter", dir);
+
+	mutex_init(&rasdes_info->reg_lock);
+	rasdes_info->ras_cap_offset = ras_cap;
+	rasdes_info->rasdes_dir = dir;
+	pci->rasdes_info = rasdes_info;
+
+	/* Create debugfs files for Debug subdirectory */
+	dwc_debugfs_create(lane_detect);
+	dwc_debugfs_create(rx_valid);
+
+	/* Create debugfs files for Error injection subdirectory */
+	for (i = 0; i < ARRAY_SIZE(err_inj_list); i++) {
+		priv_tmp = devm_kzalloc(dev, sizeof(*priv_tmp), GFP_KERNEL);
+		if (!priv_tmp) {
+			ret = -ENOMEM;
+			goto err_deinit;
+		}
+
+		priv_tmp->idx = i;
+		priv_tmp->pci = pci;
+		debugfs_create_file(err_inj_list[i].name, 0200, rasdes_err_inj, priv_tmp,
+				    &dwc_pcie_err_inj_ops);
+	}
+
+	/* Create debugfs files for Statistical counter subdirectory */
+	for (i = 0; i < ARRAY_SIZE(event_list); i++) {
+		priv_tmp = devm_kzalloc(dev, sizeof(*priv_tmp), GFP_KERNEL);
+		if (!priv_tmp) {
+			ret = -ENOMEM;
+			goto err_deinit;
+		}
+
+		priv_tmp->idx = i;
+		priv_tmp->pci = pci;
+		rasdes_events = debugfs_create_dir(event_list[i].name, rasdes_event_counter);
+		if (event_list[i].group_no == 0 || event_list[i].group_no == 4) {
+			debugfs_create_file("lane_select", 0644, rasdes_events,
+					    priv_tmp, &dwc_pcie_counter_lane_ops);
+		}
+		debugfs_create_file("counter_value", 0444, rasdes_events, priv_tmp,
+				    &dwc_pcie_counter_value_ops);
+		debugfs_create_file("counter_enable", 0644, rasdes_events, priv_tmp,
+				    &dwc_pcie_counter_enable_ops);
+	}
+
+	return 0;
+
+err_deinit:
+	dwc_pcie_rasdes_debugfs_deinit(pci);
+	return ret;
+}
diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.h b/drivers/pci/controller/dwc/pcie-designware-debugfs.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 98a057820bc7..ed0f26d69626 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -260,6 +260,8 @@
 
 #define PCIE_RAS_DES_EVENT_COUNTER_DATA		0xc
 
+#define DW_PCIE_VSEC_EXT_CAP_RAS_DES		0x2
+
 /*
  * The default address offset between dbi_base and atu_base. Root controller
  * drivers are not required to initialize atu_base if the offset matches this
@@ -463,6 +465,7 @@ struct dw_pcie {
 	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
 	struct gpio_desc		*pe_rst;
 	bool			suspended;
+	void			*rasdes_info;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
@@ -796,4 +799,18 @@ dw_pcie_ep_get_func_from_ep(struct dw_pcie_ep *ep, u8 func_no)
 	return NULL;
 }
 #endif
+
+#ifdef CONFIG_PCIE_DW_DEBUGFS
+int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci);
+void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci);
+#else
+static inline int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci)
+{
+	return 0;
+}
+static inline void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
+{
+}
+#endif
+
 #endif /* _PCIE_DESIGNWARE_H */
-- 
2.17.1


