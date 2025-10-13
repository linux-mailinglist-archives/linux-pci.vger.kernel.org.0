Return-Path: <linux-pci+bounces-37870-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 950E8BD1C06
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 09:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F7683B7575
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 07:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3B82E8894;
	Mon, 13 Oct 2025 07:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Y42ft8D6"
X-Original-To: linux-pci@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5923C610B
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760339706; cv=none; b=DMi1RfLT0qRGrbUlNkYMmWlwKHAZ4UY8qMvrdhgCplXnPcxXIr2HHCUXzzWid868fka0WPdHmbm97euDApTFF+cKUCQ5ZiviJQsF43m/gIR1DkHCo1UprLQTBgMY3GFbl43TnnkUiGCQ6fyMTpqnFNRpmbkFeR4VnC3i44vEs5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760339706; c=relaxed/simple;
	bh=Dw25R2eZ8DMJQQOBcbI56rCIwt7zrBlY5WSN7481ImU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=HR3EfiAuzIpRJqu5Xy2371wsI9vUII+xtOU6KsyudOf8RBk3o08ovUx2akT+1Z7yytqW1aUkkOLkYdAVSw1a1ZMLkZWNuhBOv3nA4HdnSzn2E3SH8Nm/H1ABuLe7J/qdNiWydMsf6GLdRQ4V0pNfpdEm5iPuE85rumVUqvtY8RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Y42ft8D6; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5006b.ext.cloudfilter.net ([10.0.29.217])
	by cmsmtp with ESMTPS
	id 7iZIvlEXXaPqL8CllvS75o; Mon, 13 Oct 2025 07:14:58 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 8ClkvVVOg0HUD8ClkvjTDA; Mon, 13 Oct 2025 07:14:56 +0000
X-Authority-Analysis: v=2.4 cv=TIhFS0la c=1 sm=1 tr=0 ts=68eca6f1
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7vwVE5O1G3EA:10
 a=MNViUi8bbABe4p9O268A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:Cc:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Qz0nb/M5vgl79rSNKrhGowcyULzQUz8RfrryvD4bgsg=; b=Y42ft8D6REzMdUPE5gEaTksNaB
	QCJmQJMDmPuxO1E1eipVBMvzqEZkKjTFMGc2FvSwgpip0v9xELSj+ecED1ccbGUfzqgcMwLqxqaCZ
	yrXIbZJ6EW3qufkjCAkSR/ubbxI798tfQ30JJ7U3JT3rW970faxcfKZZ/iCTYuVQKf3mSW4mhb4s8
	x4TbKiYEZigbIOjGuzRMi0379/eNSCV/cwtUBw2UIfNJYMpFT7izftR2ikHJfIo0aQi2jnie7wfHm
	UjIEYCARacl4Y89FfHCxAhf+lWRoiHzdFoNONRsDoZOGhRtUe/hn2wi/YIuxyn6MBIi6pPTP522iN
	wwWMjOhQ==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:41908 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1v8Clj-00000003JdT-2yvG;
	Mon, 13 Oct 2025 01:14:55 -0600
Message-ID: <eac81c57-1164-4d74-a1b4-6f353c577731@w6rz.net>
Date: Mon, 13 Oct 2025 00:14:54 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: bhelgaas@google.comk, rishna.chundru@oss.qualcomm.com, mani@kernel.org
From: Ron Economos <re@w6rz.net>
Subject: SiFive FU740 PCI driver fails on 6.18-rc1
Cc: helgass@kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.92.56.26
X-Source-L: No
X-Exim-ID: 1v8Clj-00000003JdT-2yvG
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:41908
X-Source-Auth: re@w6rz.net
X-Email-Count: 3
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMuxRhPgQ21odQI0yMLoo20QDm7E763JDu/8MpZ/Ps8GCAXJ9Qe3idkI1M3ByDkxPiOpYUxDZgUbF2jMdanAO3VolvG65fv7ONg0LifeMOh7+PVdfhN6
 Z8j6sOuJsq0nwO4t+PnoSiPsfqZCQyonY/lelIXqxyFxUmoirCLvUMuELFltDf9WeA9ku70jmq+ZV+V7pScaqzxDs5lGLJmAE3U=

The SiFive FU740 PCI driver fails on the HiFive Unmatched board with 
Linux 6.18-rc1. The error message is:

[    3.166624] fu740-pcie e00000000.pcie: host bridge 
/soc/pcie@e00000000 ranges:
[    3.166706] fu740-pcie e00000000.pcie:       IO 
0x0060080000..0x006008ffff -> 0x0060080000
[    3.166767] fu740-pcie e00000000.pcie:      MEM 
0x0060090000..0x007fffffff -> 0x0060090000
[    3.166805] fu740-pcie e00000000.pcie:      MEM 
0x2000000000..0x3fffffffff -> 0x2000000000
[    3.166950] fu740-pcie e00000000.pcie: ECAM at [mem 
0xdf0000000-0xdffffffff] for [bus 00-ff]
[    3.579500] fu740-pcie e00000000.pcie: No iATU regions found
[    3.579552] fu740-pcie e00000000.pcie: Failed to configure iATU in 
ECAM mode
[    3.579655] fu740-pcie e00000000.pcie: probe with driver fu740-pcie 
failed with error -22

The normal message (on Linux 6.17.2) is:

[    3.381487] fu740-pcie e00000000.pcie: host bridge 
/soc/pcie@e00000000 ranges:
[    3.381584] fu740-pcie e00000000.pcie:       IO 
0x0060080000..0x006008ffff -> 0x0060080000
[    3.381682] fu740-pcie e00000000.pcie:      MEM 
0x0060090000..0x007fffffff -> 0x0060090000
[    3.381724] fu740-pcie e00000000.pcie:      MEM 
0x2000000000..0x3fffffffff -> 0x2000000000
[    3.484809] fu740-pcie e00000000.pcie: iATU: unroll T, 8 ob, 8 ib, 
align 4K, limit 4096G
[    3.683678] fu740-pcie e00000000.pcie: PCIe Gen.1 x8 link up
[    3.883674] fu740-pcie e00000000.pcie: PCIe Gen.3 x8 link up
[    3.987678] fu740-pcie e00000000.pcie: PCIe Gen.3 x8 link up
[    3.988164] fu740-pcie e00000000.pcie: PCI host bridge to bus 0000:00

Reverting the following commits solves the issue.

0da48c5b2fa731b21bc523c82d927399a1e508b0 PCI: dwc: Support ECAM 
mechanism by enabling iATU 'CFG Shift Feature'

4660e50cf81800f82eeecf743ad1e3e97ab72190 PCI: qcom: Prepare for the DWC 
ECAM enablement

f6fd357f7afbeb34a633e5688a23b9d7eb49d558 PCI: dwc: Prepare the driver 
for enabling ECAM mechanism using iATU 'CFG Shift Feature'


