Return-Path: <linux-pci+bounces-38391-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEDDBE53DF
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 21:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE7DB4E2B8C
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 19:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE2122172C;
	Thu, 16 Oct 2025 19:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="NDmkNvWE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163AC14F112
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 19:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760643064; cv=none; b=u2mJ+3OzTjcZJ+OXsk7U5dJWpMgMC1AqhWI10P4f0nf8MNdHETNKogSfH137lIwVxFRDCW9b9Eh3oQqimUGg5LVEy9UUI/dPcT70+ZMdq+8FD5elxk5viJbOXkKr0gq32ldNO1aBNF7Q9aBnSv9EPa15SV523X1ir5vm/QIob8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760643064; c=relaxed/simple;
	bh=I+PoOEoYaM8YLxfwh4d/mAySYBboIxFhYXMMxPvssVo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f4K+/qzERDOBG29lH5pjsIk7RP8Sf4YFOFNy7E9f8Q2GONkCghM+WKbpC173okFHCDOMDtSLcArA3Ak3vLBzHkbllKskYuugvMcZa1VT4RS4wxmZvmw0pTUUT7rf6eyi8oHWA2cjoodxuhMgW8Zgp6vV9dsgCkK8sAe8hOWlf3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=NDmkNvWE; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 59GJHZ2M867877
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 12:30:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=kX+u0ncRGH2lHeur91
	jnkyHTXQ49BFtPzYU/h+tgHt8=; b=NDmkNvWEsRk9HuvJqSc/JIK9VV1o9ja3rp
	Q44IYfl8h+bxHqaxRgm+fQ4nnx8CN6xgxzLWgGiMNFmvJXW+vUtUmLPepHfZhDya
	EBzQ6DBCIQrNAMYHpZ12Wn0B9tZfpwV4u8r6fmeBU4xSqMmscnOshWa6aP54v9cf
	7frN7tGl5QyasEeFjF7a0DPwlP6dAJIwiKZJO+MASPsM0r6tmgFM7xQo08T0SITn
	ZwvlCoO5i7zOzdDGKZZEupvfiYkW25NloCfGyIbPXhU/3XGF9po8itWj5vuHmbhr
	h37Jnwlv4Qcepe70vVJ9qUsZ4O8XMEXxxQ+txk5H16nFAjsdbpMA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 49u6r0g3m7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 12:30:59 -0700 (PDT)
Received: from twshared10560.01.ash9.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Thu, 16 Oct 2025 19:30:58 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 8916D2C7C392; Thu, 16 Oct 2025 12:30:49 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <lukas@wunner.de>, <helgaas@kernel.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH RESEND 0/1] pcie hotplug deadlock fix
Date: Thu, 16 Oct 2025 12:30:48 -0700
Message-ID: <20251016193049.881212-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: az2mmfV7DxVoVbGgJ8Uy42KgRFe3LHUV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDE0MyBTYWx0ZWRfX9LY5VMrA8tz9
 QyaepkuEeuNzrDLnNT+UzRaDpjAxo6eVcThhpEJegMPVoo2HoYr+LV8Gi27zJ1KAionpkWiDYgv
 Lxn+TX5zlrKDSOLjfpSZoEI2S8jotwu9qimu9iZpf2xpYeFLyzGSCy4RyCbas9pjViyapppjmNn
 cTxAmDTFDMXmP4DRdsNd4gP1oWFm01zG8MR471xgH5MsaqV52ITu4peTZuFr0efZMea6HDmQE+B
 MTYsqE9T0Msr7D2JRSEsPW3OkhCtKvxngsazdhLa6af68MR4CZFhfqyk3xuRNLaC25h9cwyXpdR
 BlxtbeOyOHctH0LQVKrOpdfl66+clCPQbRqSEDXOg5BfQU4ZrauYqfGvEDUd+a7bLXe7b5Fw//4
 nAtRykC3FEFRVYLRLn9Bg1X1/c808Q==
X-Authority-Analysis: v=2.4 cv=d5L4CBjE c=1 sm=1 tr=0 ts=68f147f3 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8
 a=7EHR9VL78Pfb2RVWdU8A:9
X-Proofpoint-GUID: az2mmfV7DxVoVbGgJ8Uy42KgRFe3LHUV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

It's been a while since the last resend, and no movement on this so far.
This problem has been reported multiple times over the years, first one
I can find is from here:

  https://lore.kernel.org/lkml/1519648875-38196-1-git-send-email-wangxion=
gfeng2@huawei.com/

Lacking any other progress, I once again ask that we can take fixes for
this issue, as perfection is the providing to be a blocker to
improvement. The patch from this series is what we run in the Meta fleet
already and it has proven tremendously valuable at maintaining uptime
across the machines. No issues have been found with running it, so
asking once again if we can consider it for upstream.

Keith Busch (1):
  PCI: pciehp: fix concurrent sub-tree removal deadlock

 drivers/pci/hotplug/pciehp_pci.c | 12 +++++++++---
 drivers/pci/pci.h                |  1 +
 drivers/pci/probe.c              | 25 +++++++++++++++++++++++++
 include/linux/pci.h              |  2 ++
 4 files changed, 37 insertions(+), 3 deletions(-)

--=20
2.47.3


