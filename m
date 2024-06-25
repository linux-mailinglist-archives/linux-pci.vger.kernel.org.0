Return-Path: <linux-pci+bounces-9225-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6A491656F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 12:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E3B1F2320B
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 10:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B547614A614;
	Tue, 25 Jun 2024 10:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GLVTh7m3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C421494A8
	for <linux-pci@vger.kernel.org>; Tue, 25 Jun 2024 10:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719312148; cv=none; b=h+bF/agZEkpLTPVc0FdWxlmNgAazTfhDJ+qQ6cosJNBAtNkrxrykfSf/96/teVvJlQMqSV+UH2k42c/Uwwe9Eg/9fcHoqB3Dh7Sgn+5PM3wEfhIBRhtAypAS3XE52RNCV7KMpg1LFsDTCoxgskb2kbSMpSrTP2pZfJ5cgu1riRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719312148; c=relaxed/simple;
	bh=/7iyMeYuJupZ1RomJ/NR2whmiGjUphWFPoPduP9U3ZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=rxXSNl9pzaRqvH/qR3PvyFgutPSiAIVtozDzlHUnWa9/blRJCRrnvMtfrukiFrw4SX/Q+TAOIQtL6QpG3+pvrCvoyu5i7AvyE9NtzvTzCTxBiU44XFwruAWfutTHelyn0+88zSEkdkNEIINkB/hljqz2s0YpfJFNhES6YGe6UOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GLVTh7m3; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240625104222epoutp036f2ed4c68a45051fd4a627f95d00cdd9~cOUjk6Hgy2299822998epoutp03M
	for <linux-pci@vger.kernel.org>; Tue, 25 Jun 2024 10:42:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240625104222epoutp036f2ed4c68a45051fd4a627f95d00cdd9~cOUjk6Hgy2299822998epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719312143;
	bh=K5FJorSPe1FcKHWSRV4/HNukyATsDDzjNDpl/ez9U6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GLVTh7m3vZgjRR4Iw0TBTmwz3TdvHYhuN54Z55UaUbJHbyGQtcCrPDks4tqj9Bof0
	 jnwqHBROb6Cl74u1enRW8VCfkDkfCrP65FxpK6XRDB6XPVhwzLxQnQMQ0F3Dl3g48M
	 ZBaufd6QuLC9tS5w+l9zuEfFrO+ZfdIHpU+XW37o=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240625104222epcas5p3041e7abbd7f37ce10a5b4f682f211510~cOUjG7Gye0555805558epcas5p3M;
	Tue, 25 Jun 2024 10:42:22 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4W7hH11fnjz4x9Pr; Tue, 25 Jun
	2024 10:42:21 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	CD.3A.09989.D0F9A766; Tue, 25 Jun 2024 19:42:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240625094446epcas5p4e5e864d5f56af0a44e950a426bc9f5f5~cNiQ0VJ401053910539epcas5p4T;
	Tue, 25 Jun 2024 09:44:46 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240625094446epsmtrp1e82ce481043241f53f1c171e2caca1f9~cNiQzhX7S1600816008epsmtrp1U;
	Tue, 25 Jun 2024 09:44:46 +0000 (GMT)
X-AuditID: b6c32a4a-bffff70000002705-e3-667a9f0d9a99
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	1E.9E.18846.E819A766; Tue, 25 Jun 2024 18:44:46 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240625094444epsmtip19b8f0a32d11b74bdd491d2c2daff2b9f~cNiOxRYuy0560105601epsmtip1H;
	Tue, 25 Jun 2024 09:44:44 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	fancer.lancer@gmail.com, yoshihiro.shimoda.uh@renesas.com,
	conor.dooley@microchip.com, pankaj.dubey@samsung.com, gost.dev@samsung.com,
	Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH 3/3] PCI: dwc: Create debugfs files in DWC driver
Date: Tue, 25 Jun 2024 15:08:13 +0530
Message-Id: <20240625093813.112555-4-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240625093813.112555-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMJsWRmVeSWpSXmKPExsWy7bCmpi7v/Ko0g6td7BZLmjIspmzawW6x
	oWMOq8XNAzuZLFZ8mclu0dDzm9Xi8q45bBZn5x1ns2j508Jicbelk9Vi0dYv7Bb/9wB19B6u
	tfi69zObA5/Hzll32T0WbCr12LSqk83jzrU9bB5Prkxn8rjzYymjx7czE1k8+rasYvT4vEku
	gDMq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6HQl
	hbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBh
	QnbG718BBa08Fb++32VvYNzP1cXIySEhYCJxffMZpi5GLg4hgd2MEuf2zGWEcD4xStzrvcsM
	52w5uZkNpmXe07XsEImdjBKfZu+Fqmplklj3ZBIjSBWbgJZE49cuZhBbRMBa4nD7FjaQImaB
	XUwSPU/OgRUJCzhKLGp/D2azCKhKXFo4CWgsBwcvUMP3jXkQ2+QlVm84wAwS5hSwkZh4WQlk
	jITARA6J1nfrWSBqXCQ+fNsDZQtLvDq+hR3ClpJ42d8GZadLrNw8gxnCzpH4tnkJE4RtL3Hg
	yhwWkPnMApoS63fpQ4RlJaaeWgdWwizAJ9H7+wlUOa/EjnkwtrLEl78wayUl5h27zAphe0hc
	ezYFGqb9jBLrb/9lnsAoNwthxQJGxlWMkqkFxbnpqcWmBUZ5qeXwSEvOz93ECE6dWl47GB8+
	+KB3iJGJg/EQowQHs5IIb2hJVZoQb0piZVVqUX58UWlOavEhRlNg8E1klhJNzgcm77ySeEMT
	SwMTMzMzE0tjM0Mlcd7XrXNThATSE0tSs1NTC1KLYPqYODilGpgUbvp95Q0qfPx153SBK2fy
	F52botmW/Nr+/qN8weveDKdWr351LeBAk2/Az9M7W5e+Fdzjzia/P35FmBXL5Lo3W0OTWH9c
	iWpmWrHdrOjw6Vc9Pfs6jpp9tGX3zD1SJBP98PrRvQZuq3iUZl/YXSLzdp6k5ssdV5csW5fF
	v5VT+PY7p1UTLXLVCg6n+pmXJLpdLNrA7GK+fOGGvXMr9844qjEhd8vuq8ZmiiInzj3Yo9pp
	m+TeHSc7pbDq6DuhLGXhKXYe59JZKqa/rptzVGz1k/XX+N89++72+YjmgzKJL5vDfwdOZlbi
	9ag+4czwx+3lsVkH/+Wmx++sanTmzGGc5ceiF5rlcmvW56czv88tVGIpzkg01GIuKk4EAFMy
	xt0mBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsWy7bCSnG7fxKo0g7Pf9C2WNGVYTNm0g91i
	Q8ccVoubB3YyWaz4MpPdoqHnN6vF5V1z2CzOzjvOZtHyp4XF4m5LJ6vFoq1f2C3+7wHq6D1c
	a/F172c2Bz6PnbPusnss2FTqsWlVJ5vHnWt72DyeXJnO5HHnx1JGj29nJrJ49G1ZxejxeZNc
	AGcUl01Kak5mWWqRvl0CV8bvXwEFrTwVv77fZW9g3M/VxcjJISFgIjHv6Vr2LkYuDiGB7YwS
	x35uZIFISEp8vriOCcIWllj57zlUUTOTxK77rcwgCTYBLYnGr11gtoiArcT9R5NZQYqYBU4w
	SdyevIEVJCEs4CixqP09I4jNIqAqcWnhJKBJHBy8AtYS3zfmQSyQl1i94QAzSJhTwEZi4mUl
	kLAQUMXdK39ZJzDyLWBkWMUomlpQnJuem1xgqFecmFtcmpeul5yfu4kRHNJaQTsYl63/q3eI
	kYmD8RCjBAezkghvaElVmhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe5ZzOFCGB9MSS1OzU1ILU
	IpgsEwenVAPTPt0NwvPz9W5seae9RTO0sMHowMmg/XUpqZvCBFc4q2UsPOn+rHvZz8CWWwee
	Xak6ee3eni/G2w/75xyYYFIbuZPjcOkO3xtnJxmIFP14qmozPz5e5QhTYPLe1x13NrxlWunt
	efHfprubVC7Lb3ZdbTL5nsvm1gWPj+1/qpTwTH/n040/LhbY98by856bvfL+Pn7Rreb+844H
	chkV/esXXaqevWLihNePNjf9eDn1r/KxG3mS1d82TVBQvvfzy5Sda07sbfFcfWO+4GJuy0kL
	ul+m6xzZY2sRKm/sPCXvpUfLnKCpfpuFpt6b4X3mrHF31YUd36x6Fsb/0ZigW/l2aYH8bH+Z
	17xHn27UXvNwY7iCEktxRqKhFnNRcSIAlI5DztgCAAA=
X-CMS-MailID: 20240625094446epcas5p4e5e864d5f56af0a44e950a426bc9f5f5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240625094446epcas5p4e5e864d5f56af0a44e950a426bc9f5f5
References: <20240625093813.112555-1-shradha.t@samsung.com>
	<CGME20240625094446epcas5p4e5e864d5f56af0a44e950a426bc9f5f5@epcas5p4.samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add call to initialize debugfs from DWC driver and create the RASDES
debugfs hierarchy for each platform driver. Since it can be used for
both DW HOST controller as well as DW EP controller, add it in the
common setup function.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 ++
 drivers/pci/controller/dwc/pcie-designware.c      | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index d15a5c2d5b48..c2e6f8484000 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -537,6 +537,8 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
 	pci_stop_root_bus(pp->bridge->bus);
 	pci_remove_root_bus(pp->bridge->bus);
 
+	dwc_pcie_rasdes_debugfs_deinit(pci);
+
 	dw_pcie_stop_link(pci);
 
 	dw_pcie_edma_remove(pci);
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index b74e4a97558e..ebb21ba75388 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -1084,4 +1084,8 @@ void dw_pcie_setup(struct dw_pcie *pci)
 	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
 
 	dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
+
+	val = dwc_pcie_rasdes_debugfs_init(pci);
+	if (val)
+		dev_err(pci->dev, "Couldn't create debugfs files\n");
 }
-- 
2.17.1


