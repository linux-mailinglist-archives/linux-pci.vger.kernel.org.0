Return-Path: <linux-pci+bounces-28684-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07368AC83AF
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 23:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17ABA7AD64A
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 21:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F541293752;
	Thu, 29 May 2025 21:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bl45ywHV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486C9293725
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 21:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748555152; cv=none; b=L9+vOkGliXdEucoHTMeYwJRTny9WIdD7lOwIFEcr6Xps8MGUHlNPF8ELOtqRMJoUJBBJlb6dI4l6mIxf1Y6aNXDOcTmStxNLQ6Rte6QryL1/ltrFmNb5nuO2BCo78xWDMlLjOTG/PHsdgOEE7XTBsThS4RkZptfrRMh/bU96b38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748555152; c=relaxed/simple;
	bh=BCaMPS+A2FwMWe536A/mkcK+XQdRzFV9OSoLZ8TvP7w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I7yaAzpQTfQdl2djMhMJcgz99KR99BQdP5lnwNmW+lIgAqWWcIU+tQxpR0EWx07nnsdLmQWeU8XpZRO9PaWCnp03tw4yjkObsZ75b/PDCf+GKkuc0SbmRAobDEAlYSkfQC5Q4jZhi1Jxu23RFYmJ2PMXO/g1wrlghbD6QM4W2SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=bl45ywHV; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TLjkYq024376
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 14:45:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=facebook; bh=D+IQI7hzYY4AdulWkAeQeVS
	VYH2EOVQ0gfgjGpBkn+M=; b=bl45ywHVXtgR56V3eZOByDZ+5tuWz0lz3cILXPo
	zbOU/8xYy4hjIfp5fvWWi6DG5oNZq7efhZU7ea+QpS1NIWqx0ZbTY3/fgaP/ymX6
	D96Obhbvd0/H7Ot4zq5fT0HKODtruUVyWVzAVbkGFlBX13kZqchaoP7eOL/Bi1LC
	JvFk=
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46xhf5dvy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 14:45:48 -0700 (PDT)
Received: from twshared0377.32.frc3.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Thu, 29 May 2025 21:44:29 +0000
Received: by devgpu004.nha5.facebook.com (Postfix, from userid 199522)
	id C78E440913C; Thu, 29 May 2025 14:44:15 -0700 (PDT)
From: Alex Mastro <amastro@fb.com>
To: <linux-pci@vger.kernel.org>
CC: <alex.williamson@redhat.com>, <jgg@nvidia.com>, <peterx@redhat.com>,
        <kbusch@kernel.org>, <linux-mm@kvack.org>
Subject: [BUG?] vfio/pci: VA alignment sensitivity of VFIO_IOMMU_MAP_DMA which target MMIO
Date: Thu, 29 May 2025 14:44:14 -0700
Message-ID: <20250529214414.1508155-1-amastro@fb.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDIxMiBTYWx0ZWRfX14oI89rA0cXl L37Ylh4Sep+HkyHJhjDiDo+ivNi+mcB8kUI+OzLL/XHcdxvFLmJL0mPOICztc5L/UOVzAE2+9rj IvWU/bM8q9H066wb0styrOygFklaT0tWd+B3gx1yslI59+zHvgpSuTa2kLTjKZazH31L6xvQsnc
 X5t5Zdjs1GuNkeiYwWNxBoNrjTpSEKMBlrt4Uyy1Gu0OzD5QRLkFoEnTKN1eNKJNugPFa80bT+d LDtj6SZvGML9nYOm4ffs5pHWfO+fUBMaj/M96mwoBtxwVmflGb3EGKjOax0s8OC9NrqR6X9vV7Q e7KuG4CQFgfxMGlU9FFOIi9DVt25zweZ0/7Rd37hHq93SQfvZxx5SbjnSYQLem4ZWIhiWnMgUqo
 y7Q1Y2hX/ShB1WoSuO2dsV6ErjSNWLyy1Nv46XoOnntZ+AyaPVJ6x9rVz8vKkPrtHs8IUdxi
X-Authority-Analysis: v=2.4 cv=HuZ2G1TS c=1 sm=1 tr=0 ts=6838d58c cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=7NlN7ispKPTGJu6vY8wA:9
X-Proofpoint-GUID: Ox7qUUws9lDcYiVPcg4dqY-ug5LlM4le
X-Proofpoint-ORIG-GUID: Ox7qUUws9lDcYiVPcg4dqY-ug5LlM4le
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_09,2025-05-29_01,2025-03-28_01

Hello,

We are running user space drivers in production on top of VFIO, and after
upgrading from v6.9.0 to v6.13.2 noticed intermittent, slow performance l=
eading
to "rcu_sched self-detected stall" when issuing VFIO_IOMMU_MAP_DMA on ~64=
 GiB
mmap-ed BAR regions. When doing this on enough devices concurrently, we
triggered softlockup_panic. The mmap-ed BAR regions were obtained from mm=
ap on
a VFIO device fd.

We map regions > 1G, which sometimes do not start at 1G-aligned BAR offse=
ts,
but they are always aligned by at least 2 MiB.

We determined that slow, stalling runs were correlated with 4 KiB-aligned
addresses returned by mmap, and normal runs with >=3D 2 MiB alignment.

Inspired by QEMU's mmap-alloc.c, we are handling this by reserving VA wit=
h an
oversized mmap, and then clobbering with MAP_FIXED at a good address insi=
de the
reservation with the mmap on the VFIO device fd.

At first we settled for aligning the mmap address to {1 GiB, 2 MiB} exact=
ly,
and the stalls disappeared, but then improved performance with the follow=
ing:

We found that the best addresses to pass to VFIO_IOMMU_MAP_DMA have the
following properties, where va_align and va_offset are chosen based on th=
e size
and BAR offsets of the desired mapping.

va_align =3D {1 GiB, 2 MiB, 4 KiB}
va_offset =3D mmap_offset % va_align
(addr_to_mmap % va_align) =3D=3D va_offset

Using addresses with the above properties seems to optimize the count and
granularity of faults as confirmed by bpftrace-ing vfio_pci_mmap_huge_fau=
lt.

We then backported "Improve DMA mapping performance for huge pfnmaps" [1]=
 to
our 6.13 tree, and saw further performance improvements consistent with t=
hose
described in the patch (thank you!). However, with the backport, we still=
 need
to align mmap addresses manually, otherwise we see stalls.

We are wondering the following:
- Is all of the above expected behavior, and usage of VFIO?
- Is there an expected minimum alignment greater than 4K (our system page=
 size)
  for non-MAP_FIXED mmap on a VFIO device fd?
- Was there an unintended regression to our use-case in between 6.9 and 6=
.13?

Thanks,
Alex Mastro

[1] https://lore.kernel.org/all/20250205231728.2527186-1-alex.williamson@=
redhat.com/

