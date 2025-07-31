Return-Path: <linux-pci+bounces-33252-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41294B175B7
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 19:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4F41C22377
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 17:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3C324DCED;
	Thu, 31 Jul 2025 17:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kHmh9WTI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF1F243379;
	Thu, 31 Jul 2025 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753983550; cv=none; b=tg4mQs7eKP5e3YN1ptlsw8CPDtnkVN9pjF2gjFB+9qEzewAFOhiPNJJnbvM5pAviwIr+3bNpnK/V/OTQL4V2/SZMVNpUf7vL2jby77lmVGUcdVqTiSPVbUFuAnqtmaaHAj1NRAMsoDiM0xRrBy4X5HrP/XTx7KyYVJ/GfMyAOG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753983550; c=relaxed/simple;
	bh=LCVddIPlJf1KfqdATIKykvPn7Ks9+AhznvMhH3WotkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1YHUuusY66bXsHNUU+JPLIHpGy9LrBZ1vBqEZRmsjYRDEjG1leSXkg0shJO7lwtTt15qHUH1NZYfpz3zBZcU86K23/2+a6KQs5lOmDzc16de3aYEdpf0KdfzuTuMR71QaWONgJ/RKeAF5cOb3debSOSyQz1yJn/vx7/ckweQG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kHmh9WTI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VAvT9M021832;
	Thu, 31 Jul 2025 17:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tzU8F9Ik1MUAwjnMU
	fOLBMknArSI9MwYfIgTw1yKLEw=; b=kHmh9WTIe1IQDXpKjHTI3sWeqdZFBdSMA
	yg+14zGDFtZOyPwv/4gv2K3wuBNRNOUHI/E626UUoA8wnaj0cE10WI01mg9Sm5Kp
	JW5OEG0EMK+jQx6eoc3qOeyb5mAliujNmSMWPM5fHwdUBLZiKny1HZJkupMK+Q5p
	w5j78MB8ybReVKaAwcydA8WY25Mfus+9+Q7/fQybD9IBOO54VciCfaShqwz3zYIx
	7iZKPguC0RS3Xlgcu8Zi/wNM2iH0rs3WPfWfUO7gZc/UGs2ANyYJg1Lgx7Gl0yqE
	aXScJ72khlQd/tVeQ/WXrwSPzdbCaXnXUx+Ph6X/deZ9DuyRcU+Ig==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qen482v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 17:39:04 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56VHUlXW002308;
	Thu, 31 Jul 2025 17:39:04 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qen482s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 17:39:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56VF5SeJ017464;
	Thu, 31 Jul 2025 17:39:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4859r0dr3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 17:39:02 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56VHcwwY52494692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 17:38:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B26792004B;
	Thu, 31 Jul 2025 17:38:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78EA920043;
	Thu, 31 Jul 2025 17:38:58 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 31 Jul 2025 17:38:58 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
To: 18255117159@163.com, bhelgaas@google.com, helgaas@kernel.org
Cc: gbayer@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        ilpo.jarvinen@linux.intel.com, jingoohan1@gmail.com,
        kwilczynski@kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-next@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org, mani@kernel.org,
        robh@kernel.org, schnelle@linux.ibm.com
Subject: [PATCH] PCI: Fix endianness issues in pci_bus_read_config()
Date: Thu, 31 Jul 2025 19:38:58 +0200
Message-ID: <20250731173858.1173442-1-gbayer@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <4e10bea3aa91ee721bb40e9388e8f72f930908fe.camel@linux.ibm.com>
References: <4e10bea3aa91ee721bb40e9388e8f72f930908fe.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dTQDf-ePIRf2HCvROzeIzIwabYlVCwig
X-Proofpoint-GUID: yAHBx8M0qM3OjVV29OTqZi3GqnvjhKax
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDEyMCBTYWx0ZWRfX4s98G7dwl3i1
 TteX2/43+G6a1sfSdSOQZmN6fOHbGRaiyrpx6jhmdiu0Q7wWQK++v/dLS7VeSUBgSoP+CHF0OcJ
 53DFtZHyutJdx1dxRL2w7xtxl+4/V5Snwvcb+HYnsY93MsNI4pQVOhaW8eVG0Md2Q7uxZVs0t6Q
 aR0VvjYAVRC1kEFShEnWqfEpb9ymPYOyO8lrdlsc+KD8NtEkhknxcsXyJjWCn7eXRZ9H39GQe3x
 58qpAl6BPVmuxg0cdfTo7PoNO+g+xjRjVNptK6TxWtX2NiL82IMqja6khPZhOs9CdhO/rBDtcFc
 DzsG76wQ0QCKZBWpE8Ft1xzEDlBTuTn9w0j3kLvAEU0xUQ94fr6MmZSbRcpkwwZs+mw5WaZXaU2
 sk+mRsa62pHmJLkUNGiNwxDfAjUQY00N9TA+Ia9S0egdcoQJoG1AEk1x6gv3eSCMShxklKcL
X-Authority-Analysis: v=2.4 cv=BJOzrEQG c=1 sm=1 tr=0 ts=688baa38 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=VnNF1IyMAAAA:8
 a=Pc6pn_66ZPNL0meD3e8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507310120

Simple pointer-casts to map byte and word reads from PCI config space
into dwords (i.e. u32) produce unintended results on big-endian systems.
Add the necessary adjustments under compile-time switch
CONFIG_CPU_BIG_ENDIAN.

pci_bus_read_config() was just introduced with
https://lore.kernel.org/all/20250716161203.83823-2-18255117159@163.com/

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---

Hi Hans, hi Bjorn,

Sorry to spill this endianness aware code into drivers/pci, feel free to
suggest a cleaner approach. This has fixed the issues seen on s390 systems
Otherwise it is just compile-tested for x86 and arm64.

Since this is still sitting in the a pull-request for upstream, I'm not sure if this
warrants a Fixes: tag.

Thanks,
Gerd
---
 drivers/pci/access.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index ba66f55d2524..77a73b772a28 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -89,15 +89,24 @@ int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 size,
 			u32 *val)
 {
 	struct pci_bus *bus = priv;
+	int rc;
 
-	if (size == 1)
-		return pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
-	else if (size == 2)
-		return pci_bus_read_config_word(bus, devfn, where, (u16 *)val);
-	else if (size == 4)
-		return pci_bus_read_config_dword(bus, devfn, where, val);
-	else
-		return PCIBIOS_BAD_REGISTER_NUMBER;
+	if (size == 1) {
+		rc = pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
+#if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
+		*val = ((*val >> 24) & 0xff);
+#endif
+	} else if (size == 2) {
+		rc = pci_bus_read_config_word(bus, devfn, where, (u16 *)val);
+#if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
+		*val = ((*val >> 16) & 0xffff);
+#endif
+	} else if (size == 4) {
+		rc = pci_bus_read_config_dword(bus, devfn, where, val);
+	} else {
+		rc =  PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+	return rc;
 }
 
 int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
-- 
2.48.1


