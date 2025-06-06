Return-Path: <linux-pci+bounces-29112-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E77FAD084F
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 20:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC843B3DD6
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 18:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221E91EFFB7;
	Fri,  6 Jun 2025 18:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mYCsI3+T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B42D1E8335
	for <linux-pci@vger.kernel.org>; Fri,  6 Jun 2025 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749235879; cv=none; b=NthuZzaojuQuwIwsAQW5iR4uDYgABMTJjVydyQzXIUmBTDC0OyL93KL8sE/U+llt62IRa+gemExxurwEURlZ0IzXcsZzKNnNeDy2oIpuTw9XIRiSFxENxA5IUEtzYM6IxrqE1p9HiXWzi6jlAGb6y17EFJcS65H5E5MUNYeI0Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749235879; c=relaxed/simple;
	bh=PUAPLa3487RHYqMiFCzyrtOAoZwcBvZ7g/Lmtgq+14A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+low0N2DpLd2vzo8OlgtAz+LUI1OGIWjiEVqCXebXNNJUmjz+nDeOqdcU6oaFD8mGuNmsgzz+QOUrMplqhkfWIAv7t9ujd3k2ZLAc1ioyZQM/m10b+gVf4VHq3Z6ktUVIIhF9WppGCDazilasZxWbB5r1PnvDsqbxqHlW4kzJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=mYCsI3+T; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 556H2dIS007862
	for <linux-pci@vger.kernel.org>; Fri, 6 Jun 2025 11:51:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=facebook; bh=P
	UAPLa3487RHYqMiFCzyrtOAoZwcBvZ7g/Lmtgq+14A=; b=mYCsI3+Tk/CRzOuW8
	1vUprUWZtfdM4T2UI8+UCST/azvVsdBuYpm159TGG0BdCgEE8twg0E018LtQxM2z
	xsOtlNc6/pNbnqX8mXc61GWOShootylNed/ESt+NJTZaPZLW6y9UCTkPmt8L3H46
	ySM4KZpfIHWAHu58s8bsYkkeE8=
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 473v76vbsf-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 06 Jun 2025 11:51:16 -0700 (PDT)
Received: from twshared18532.02.prn5.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Fri, 6 Jun 2025 18:51:13 +0000
Received: by devgpu007.eag1.facebook.com (Postfix, from userid 199522)
	id B899240453C; Fri,  6 Jun 2025 11:51:06 -0700 (PDT)
From: Alex Mastro <amastro@fb.com>
To: <jgg@nvidia.com>
CC: <linux-pci@vger.kernel.org>, <alex.williamson@redhat.com>,
        <peterx@redhat.com>, <kbusch@kernel.org>, <linux-mm@kvack.org>,
        <leon@kernel.org>, <vivek.kasireddy@intel.com>, <wguay@meta.com>,
        <yilun.xu@linux.intel.com>
Subject: Re: [BUG?] vfio/pci: VA alignment sensitivity of VFIO_IOMMU_MAP_DMA which target MMIO
Date: Fri, 6 Jun 2025 11:49:46 -0700
Message-ID: <20250606184946.4175252-1-amastro@fb.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250530131050.GA233377@nvidia.com>
References: <20250530131050.GA233377@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=BOOzrEQG c=1 sm=1 tr=0 ts=684338a4 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=4ehY1fKBMCqGZ9VsUN4A:9
X-Proofpoint-ORIG-GUID: 9BnLzHJMzmbWnJzgRzK8eh3mXZeSU4ZX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE2MiBTYWx0ZWRfX62NOV52IYFSn I0OrnOhUXm3aVs6MQy64l8Nv5NKyz6NUudvDmPr2mwVVdsZdGY4ZFypp3KyvSpQZfME1HE4Ethh UShjvJ7r0GEqYyNGWuRWpfRPCNWOnQMu/aQupzYMOac9MKf36rsaS9W/upjJVfgmYvsEfJV2OdF
 tnQugPu9KYaJeH57b4Aas4wlYdJIWGro+Nu5/xoBOsXL43SkhwgT+R2Vu3tnlr7thtxcoYNenMN dC+/CGbKf2Gkq3OU6sSnNBcZxJa52suStkYvz50WJn8ENY1npHuaLgM3Ko7StroEopVWvuf7TJL +SOV7Xx2Q1RbuCyPSH3luNwUI7qLTNiLnsUkPe9VVHnq2Z3xZf+5SvAzL6TnNWxyH5l+Y9+fFOr
 xMnwbru9vmoV3yHiKi1fkk1VkpZ1IlmiXhs03ShAAtFEa0qhi48McHYNC1WHfDTIzVrlBosW
X-Proofpoint-GUID: 9BnLzHJMzmbWnJzgRzK8eh3mXZeSU4ZX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_07,2025-06-05_01,2025-03-28_01

Hi Jason,

By the way, we have been following progress on IOMMUFD, and would be inte=
rested
in dogfooding it for our use case when ready. The main blocker is IOMMUFD=
's
current lack of P2P support (IOMMU_IOAS_MAP fails when the VA range is ba=
cked
by MMIO).

dma-buf as a less ambiguous semantic for communicating this intent (rathe=
r than
the struggles of inferring what kind of memory is behind some VA range) m=
akes a
lot of sense.

Based on tidbits we have gleaned, IOMMUFD P2P support intends to be built=
 on
top of "Provide a new two step DMA mapping API" [1] and "vfio/pci: Allow =
MMIO
regions to be exported through dma-buf" [2].

Item [2] appears to have been picked up by "Host side (KVM/VFIO/IOMMUFD) =
support
for TDISP using TSM" [3].

Is the above understanding correct?

On top of this, there would need to be a new IOMMUFD uapi, or extension t=
o
existing, which would accept an input dma-buf to map. Are there any patch=
es in
progress which include this?

[1] https://lore.kernel.org/all/cover.1746424934.git.leon@kernel.org/
[2] https://lore.kernel.org/all/20250307052248.405803-1-vivek.kasireddy@i=
ntel.com
[3] https://lore.kernel.org/all/20250529053513.1592088-1-yilun.xu@linux.i=
ntel.com

Thanks,
Alex

