Return-Path: <linux-pci+bounces-9223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B9E91656D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 12:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2968528404F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 10:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6638F2572;
	Tue, 25 Jun 2024 10:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="V4gk7h3d"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397BD14A614
	for <linux-pci@vger.kernel.org>; Tue, 25 Jun 2024 10:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719312143; cv=none; b=n4xULT2gdqA6hu3z3a5JCN1iKZU7fT7KLTqS3O3GoYZthE1EoJXX6m/+AyreCIogGy4g+MySojdlShL9bT9YdPjb8cZXPIuol0oCqtX9g/lZKA+VHJ2Wpa15D5MIzAnk9TAwuDTOhA0SqjNyGZhqD1dIth/g5JHj/iGvFx7q5ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719312143; c=relaxed/simple;
	bh=pZwlVIa6d7qexCa92aQ/9t4+0E9yFwIhS6X/ifHa6ms=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:References; b=Cc04wEZaW1qqDdh12PSC7+VPpzKp4bcYwB+hukVPiqp4JhlaC51azrlncfNdif9GMyjKKtvSamDS0lURBRH3M0yQUEkldvjBCwtAUhlg66ERqiFR4LSCvlSNwm9dKwhphyDQnSvsZcbgkIo9pz0gocGSphyj/ZrbuozAJ8AR6Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=V4gk7h3d; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240625104212epoutp041119e614f97e1c49edbd9cd6ea2e6091~cOUZ-geIL0641906419epoutp04H
	for <linux-pci@vger.kernel.org>; Tue, 25 Jun 2024 10:42:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240625104212epoutp041119e614f97e1c49edbd9cd6ea2e6091~cOUZ-geIL0641906419epoutp04H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719312132;
	bh=L16NlU78WNPt2trfZ0T9gTyiTCgc6N/4T4c1o8cN6cs=;
	h=From:To:Cc:Subject:Date:References:From;
	b=V4gk7h3d7vSxM8bQiFgWDeUKM2QuH515WGsgSN+TEr+bklTv7aLoPzajYRoAggrz2
	 u1HvEjGm6gT228ofrq9JXrp4JRPgDmpanHIHoYwcR/f4QDMvL5hlsi81h54Fb7eizO
	 8JL9OnGWK9uJodHSwiatmagYOdxt3f7dtmC9MoJ4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240625104212epcas5p101a6cd81b3e8c6ec90770528160ffc05~cOUZYhiot0878608786epcas5p1D;
	Tue, 25 Jun 2024 10:42:12 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4W7hGp1tswz4x9Pr; Tue, 25 Jun
	2024 10:42:10 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6D.5B.06857.20F9A766; Tue, 25 Jun 2024 19:42:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240625094434epcas5p2e48bda118809ccb841c983d737d4f09d~cNiFrHhcE0053500535epcas5p2D;
	Tue, 25 Jun 2024 09:44:34 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240625094434epsmtrp2f1b2d24c88ec9ed6e6f2c1d46d5515d2~cNiFqK8Ig1814418144epsmtrp2r;
	Tue, 25 Jun 2024 09:44:34 +0000 (GMT)
X-AuditID: b6c32a4b-88bff70000021ac9-2f-667a9f023469
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E1.DE.19057.2819A766; Tue, 25 Jun 2024 18:44:34 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240625094432epsmtip1b407f24481c763defe0216e4ea075f58~cNiDk1nS90463104631epsmtip1P;
	Tue, 25 Jun 2024 09:44:32 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	fancer.lancer@gmail.com, yoshihiro.shimoda.uh@renesas.com,
	conor.dooley@microchip.com, pankaj.dubey@samsung.com, gost.dev@samsung.com,
	Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v3 0/3] Add support for RAS DES feature in PCIe DW
Date: Tue, 25 Jun 2024 15:08:10 +0530
Message-Id: <20240625093813.112555-1-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdlhTXZdpflWawbZJ3BZLmjIspmzawW6x
	oWMOq8XNAzuZLFZ8mclu0dDzm9Xi8q45bBZn5x1ns2j508Jicbelk9Vi0dYv7Bb/9wB19B6u
	tfi69zObA5/Hzll32T0WbCr12LSqk83jzrU9bB5Prkxn8rjzYymjx7czE1k8+rasYvT4vEku
	gDMq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6HQl
	hbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBh
	QnbG4UtXWApuClT0XJ7L3MB4j7eLkZNDQsBE4sHdU0xdjFwcQgK7GSV+n+tghXA+MUrMvrIC
	KvONUWLTns0sMC3Pb8xkhEjsZZRoWrcaLCEk0Mok8Wu/N4jNJqAl0fi1ixnEFhGwljjcvoUN
	pIFZYBeTRM+Tc4wgCWEBJ4nza66wgtgsAqoSey8dYwKxeYEaru9uZYPYJi+xesMBZpBmCYGf
	7BLPPt9gh0i4SHxYM50JwhaWeHV8C1RcSuLzu71QzekSKzfPYIawcyS+bV4CVW8vceDKHKCr
	OYAu0pRYv0sfIiwrMfXUOrASZgE+id7fT6DKeSV2zIOxlSW+/N0DDQlJiXnHLrNC2B4SHfu+
	MUICIlbi+KHn7BMYZWchbFjAyLiKUTK1oDg3PbXYtMA4L7UcHlPJ+bmbGMFJUst7B+OjBx/0
	DjEycTAeYpTgYFYS4Q0tqUoT4k1JrKxKLcqPLyrNSS0+xGgKDLOJzFKiyfnANJ1XEm9oYmlg
	YmZmZmJpbGaoJM77unVuipBAemJJanZqakFqEUwfEwenVAPTK5EL+x/4dWYYXX9+c930bFmJ
	M9VlimFhfDEcO06bqb7cJpao/DnDSbR9Q6uif1KyqwZb8bPFOlW+BfeaLk4IypgcrbzsOU/Q
	zZXMKjpvXe9+N/xg4Hy8dBd/vmtG3rOYsM/xvBrsgRd1tjJP3LdS9Y5vmPdO+afVt/JtjsUZ
	rHs+SfLtdan973YqVLUoFHj6Oi7WOzFN0mv6/XvCUUdkVl/LnZeld21CV+MRV/MbYmz7j33o
	bn0YtOv9W+n+B0wtLaZFmQ1lwqzXlXf6L7j94U9crN/tWd8YtthafdhUrr1l9dpvVZc+CDVW
	8MSweV9eWaHbdNPhrJD2RgcHp4wze7OuB017w//O9bvhfyElluKMREMt5qLiRACFYd59GwQA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCLMWRmVeSWpSXmKPExsWy7bCSnG7TxKo0g8PPdC2WNGVYTNm0g91i
	Q8ccVoubB3YyWaz4MpPdoqHnN6vF5V1z2CzOzjvOZtHyp4XF4m5LJ6vFoq1f2C3+7wHq6D1c
	a/F172c2Bz6PnbPusnss2FTqsWlVJ5vHnWt72DyeXJnO5HHnx1JGj29nJrJ49G1ZxejxeZNc
	AGcUl01Kak5mWWqRvl0CV8bhS1dYCm4KVPRcnsvcwHiPt4uRk0NCwETi+Y2ZjF2MXBxCArsZ
	JQ5MesUIkZCU+HxxHROELSyx8t9zdoiiZiaJQ393sYAk2AS0JBq/djGD2CICthL3H01mBSli
	FjjBJHF78gZWkISwgJPE+TVXwGwWAVWJvZeOgU3lFbCWuL67lQ1ig7zE6g0HmCcw8ixgZFjF
	KJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcsFpaOxj3rPqgd4iRiYPxEKMEB7OSCG9o
	SVWaEG9KYmVValF+fFFpTmrxIUZpDhYlcd5vr3tThATSE0tSs1NTC1KLYLJMHJxSDUwT1ANF
	Uw+2dLt+EHsh1vK2Mj77wnXxVyVV3eeZDidN3tsY/VvKoHz+yulLNY3vTn91+f2iHVEFV+p0
	xdisJZRkXk11vn9+7fZfv/9O7tDbkcqR2KCseYM7sav2gVZSWVT0ttgVH388fbDTZYKy04lV
	3+xnBzF6qpx8F7zn6lqD4k3NB9827nfYfHdS85buziqJWCVJLqM+NSdNsVkH+ZpmiPeVvZjn
	Nm2tRJbV54mSh3/q7GLOmXg671V1I1P99LrLqtKH7M+/TOdu7PUPUr436dxzJt6YFjaOWtvj
	1UsUT2R//qrRVCVgntImZf13hm1cm31iytprmx0vrWo8cT+s2Vzw/MGia6m1FRV1DkosxRmJ
	hlrMRcWJAE3gMqTHAgAA
X-CMS-MailID: 20240625094434epcas5p2e48bda118809ccb841c983d737d4f09d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240625094434epcas5p2e48bda118809ccb841c983d737d4f09d
References: <CGME20240625094434epcas5p2e48bda118809ccb841c983d737d4f09d@epcas5p2.samsung.com>
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

v2: https://lore.kernel.org/lkml/20240319163315.GD3297@thinkpad/T/

v1: https://lore.kernel.org/all/20210518174618.42089-1-shradha.t@samsung.com/T/

Shradha Todi (3):
  PCI: dwc: Add support for vendor specific capability search
  PCI: debugfs: Add support for RASDES framework in DWC
  PCI: dwc: Create debugfs files in DWC driver

 drivers/pci/controller/dwc/Kconfig            |   8 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 .../controller/dwc/pcie-designware-debugfs.c  | 474 ++++++++++++++++++
 .../controller/dwc/pcie-designware-debugfs.h  |   0
 .../pci/controller/dwc/pcie-designware-host.c |   2 +
 drivers/pci/controller/dwc/pcie-designware.c  |  20 +
 drivers/pci/controller/dwc/pcie-designware.h  |  18 +
 7 files changed, 523 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.c
 create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.h

-- 
2.17.1


