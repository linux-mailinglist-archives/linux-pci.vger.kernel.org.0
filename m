Return-Path: <linux-pci+bounces-28741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE46CAC97FE
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 01:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8738E4E4F16
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 23:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33BA2236F7;
	Fri, 30 May 2025 23:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="imE/ZAWy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE27219313
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 23:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748646427; cv=none; b=bJeEvpkO6MqTUN16wrBuwU8fW20XyMFi2nKFQZTYFXkJW+0LUzW0NfH++lXj9YJjAZRVqP6Ihag3zAOppI0LTHUYG+h+egBpTxkXubfywFh/QH2Gj3EpEluXVC0rio8HS8v9y5raLWOWbjecNPR0UCCyKrFG+U7QqTp149fjwy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748646427; c=relaxed/simple;
	bh=AR6cTw5HYbxJ2qMyCfAaeRdYxE8L1ZMz12yMlbY423Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NmFFcksc3EszbxBtZmKx/x4mGu4MRAmxAarA9J0fENEqB7SDIYIfjcynKG8d/MLtCtrEJthr2I+qJTYPpQ4Ungdkm3r3iRkBhGw++nohu96GyIDwMoEmkdRoXSWvu52VpdUDHe4Ic8GioCChnI7VKujYRYBlVyriTHKWn+ncPB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=imE/ZAWy; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54UL5uXS021647
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 16:07:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=facebook; bh=Q
	mEUoEof0XuWSY9NCPw+hCQm0lsio92LEaLT6yMorqU=; b=imE/ZAWynTjwlpBYh
	PCW2pGUFiXZl3Bvejc9tti4hCz8QIv8KeJ0/jfLsTsVV6W+Knk++GgyogmMlhJx3
	iYjRaL6Ac4BMBDOhK3qi79DGZFtq4q5S3ihQIMIG1uvAD3QaxsasWFWbsYaxWExJ
	3vGCZ3f3jcXaGG5+1YWEx73Qz4=
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46y7qhwtcf-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 16:07:05 -0700 (PDT)
Received: from twshared37834.15.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Fri, 30 May 2025 23:07:03 +0000
Received: by devgpu004.nha5.facebook.com (Postfix, from userid 199522)
	id AC0F14B34DC; Fri, 30 May 2025 16:06:58 -0700 (PDT)
From: Alex Mastro <amastro@fb.com>
To: <peterx@redhat.com>
CC: <alex.williamson@redhat.com>, <jgg@nvidia.com>, <kbusch@kernel.org>,
        <linux-mm@kvack.org>, <linux-pci@vger.kernel.org>
Subject: Re: [BUG?] vfio/pci: VA alignment sensitivity of VFIO_IOMMU_MAP_DMA which target MMIO
Date: Fri, 30 May 2025 16:05:10 -0700
Message-ID: <20250530230510.2680688-1-amastro@fb.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <aDm_vaQUnrVbuvxO@x1.local>
References: <aDm_vaQUnrVbuvxO@x1.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDIwNyBTYWx0ZWRfX/cvYocVvL1JO Ni9u2QBWrw5iEKG+SqEpO4AwD2EMxACkz4ZjyBku92r7qHKG5w7TrH3Na3UzG+wH2fdF/j6WqO3 meZh+ywYQ25bo/m9yEcuyj+pKreLarmXW2q1uWZUGRYFZpKoHAKqsSyPSzwdjGQK2G9M+k0n6Uc
 ayaiAeIxJpLWiOmKtCSWtjzkV6/LWlyUwM0OkunOvsi4lq6QY059Hi1EtwuoKsLrVDCa3C9Mjqi psVQ3d/a2+c5uvPfU6kXBjlLQWQ++++IW4UXFAT5LyQq14psdBujldpWpyNR/ecE3yJrArhdBvT La7tam5D9+ozNzajacRhny3mzOWf7JFM0WAomXjr37qZiSM33AGfdPRnrSA0Lqo7VzYjIANCQV5
 5F7G5+p8KsT8hFn4FiytkshIiNu0qW1auULwqZV3HhmT1TKW0BQCYbr+YRB6+OnFPDg1UR01
X-Proofpoint-ORIG-GUID: U2FRY1nluy57zYY3lsm7PQRLpfl61rmG
X-Authority-Analysis: v=2.4 cv=cZPSrmDM c=1 sm=1 tr=0 ts=683a3a19 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=BpDLBPb1mtdKZWO58xwA:9
X-Proofpoint-GUID: U2FRY1nluy57zYY3lsm7PQRLpfl61rmG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_10,2025-05-30_01,2025-03-28_01

On Fri, 30 May 2025 10:25:01 -0400 Peter Xu <peterx@redhat.com> wrote:
> On Fri, May 30, 2025 at 10:10:50AM -0300, Jason Gunthorpe wrote:

> Probably due to aac6db75a9fc vfio/pci: Use unmap_mapping_range().

Ack.

> > I think this is something we have missed. VFIO should automatically
> > align the VMA's address if not MAP_FIXED, otherwise it can't use the
> > efficient huge page sizes anymore. qemu uses MAP_FIXED so we've left
> > out the non-qemu users from this performance optimization.

Thanks for confirming.

> Good point!  I overlooked the VA hints when QEMU doesn't need it.  I ca=
n
> have a closer look if nobody else will.

This would be appreciated -- thank you!

> > I think if you are mmaping a huge huge BAR it is not surprising that
> > it will take a huge amount of time to write out all of the 4K
> > PTEs.=20

Agreed. This matches what we observed.

> I think if your trace shows correct huge faults when you did correct
> alignment, it should mean it doesn't affect your case (likely your app
> sequentially fault in the bar region.

Yes, this is the faulting triggered by the call stack below, downstream f=
rom
VFIO_IOMMU_MAP_DMA, which faults in the entire VA range to be mapped.

vfio_pci_mmap_huge_fault+0xf5/0x1b0 [vfio_pci_core]
__do_fault+0x3f/0x130
do_pte_missing+0x363/0xf40
handle_mm_fault+0x6d2/0x1200
fixup_user_fault+0x121/0x280
vaddr_get_pfns+0x185/0x3c0 [vfio_iommu_type1]
vfio_pin_pages_remote+0x1a1/0x590 [vfio_iommu_type1]
vfio_pin_map_dma+0xe6/0x2c0 [vfio_iommu_type1]
vfio_iommu_type1_ioctl+0xd32/0xea0 [vfio_iommu_type1]

I also confirmed that cherry picking "vfio/pci: Align huge faults to orde=
r"
does not affect our usage of this path (manual mmap alignment is still
required).

Thanks,
Alex Mastro

