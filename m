Return-Path: <linux-pci+bounces-16211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4165C9C0066
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 09:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA17EB22E63
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 08:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4561DC739;
	Thu,  7 Nov 2024 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SPuRDLu1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F131DB37C;
	Thu,  7 Nov 2024 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730969303; cv=none; b=PgZ8Z8llfE+vupM+l1Fqts5j9ZPjObXj3IjJ+GWO01UoaHOHOG6yiZeNNjtEqK51vcSiZzlwp6PThzC7PzLOQXRUBrw/kAcXifFnSdLclMegEEDVMr6krPiFahOvaeiz/ZneQJvn6V0o34+T2Zvkeca/z02KGUTa77/5igKMSGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730969303; c=relaxed/simple;
	bh=tjQVX49rIGbkZMDW7witKhW1+czUPeFSqpo1iq8CLcA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZT5f4napVTsWfMfkdBmrQmdBfQty+GcOd9msg37puyaxiEf5Z7RpRVJYNC3H/kAJiXjv01MSjhH9S8AVndhZSp6TJ19RJ5PLCmFzRKa160Kvvk449tplwTbWahedvEyGUNwD0zdVbrWfOIbp/f4bS4Rf+k5A4by0vF2Tl7WJwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SPuRDLu1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A71m6fc009985;
	Thu, 7 Nov 2024 08:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JseuV4HHIbMW59kRHiYqixKv
	JQm6Wv+8Q+A/BIy8NN8=; b=SPuRDLu1O5rtnaxfJDP3LEkxJ4nRdPTclAcL8Inm
	Uv7ahN/RWqhHQaE7yEiEeZESV+KJI/hEDylTOKJRnoC5s3lXLLh1JWXt0Qm3Jtp6
	bbuztBIWHhb6DkrLeVhAh2smfuAd8C1Xq/ZM9TpaHqwRSJA+JN+1b589nb+QNRCh
	gKLg+WHgmH6JEDg/YPorZwdGzYX3gW11I7BucsJS0ZGy3FpqGfNkJ6Ra+MhR6RXZ
	j56EPaY39F4RctI/Xv1PpqIsvV61vvkaWKN0WsUQcFWZZqFBQez4zTVvRcvJ0Uuf
	aGc93INe3Yz5wcw+zCu7j4zz8SVamm4ArRf+as1MS0JCEA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42rm6vrwm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 08:42:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A78gr6W003818
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 08:42:53 GMT
Received: from hu-pkondeti-hyd (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 7 Nov 2024
 00:42:49 -0800
Date: Thu, 7 Nov 2024 14:12:46 +0530
From: Pavan Kondeti <quic_pkondeti@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy
	<robin.murphy@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel
	<jroedel@suse.de>,
        Rob Herring <robh@kernel.org>,
        Marek Szyprowski
	<m.szyprowski@samsung.com>,
        Anders Roxell <anders.roxell@linaro.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Xingang Wang <wangxingang5@huawei.com>
Subject: Re: [PATCH RESEND] iommu/of: Fix pci_request_acs() before
 enumerating PCI devices
Message-ID: <be01d3e0-3c3a-46ec-ae68-df1cf88415de@quicinc.com>
References: <20241107-pci_acs_fix-v1-1-185a2462a571@quicinc.com>
 <2024110759-refusal-mayflower-2522@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2024110759-refusal-mayflower-2522@gregkh>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TxpIqLvJ1IWW3BbTEbSecWp0sda1TDy0
X-Proofpoint-GUID: TxpIqLvJ1IWW3BbTEbSecWp0sda1TDy0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1015 phishscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 mlxlogscore=769 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070066

On Thu, Nov 07, 2024 at 09:17:44AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Nov 07, 2024 at 01:29:15PM +0530, Pavankumar Kondeti wrote:
> > From: Xingang Wang <wangxingang5@huawei.com>
> > 
> > When booting with devicetree, the pci_request_acs() is called after the
> > enumeration and initialization of PCI devices, thus the ACS is not
> > enabled. And ACS should be enabled when IOMMU is detected for the
> > PCI host bridge, so add check for IOMMU before probe of PCI host and call
> > pci_request_acs() to make sure ACS will be enabled when enumerating PCI
> > devices.
> > 
> > Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when configuring IOMMU linkage")
> > Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
> > Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> > ---
> > Earlier this patch made it to linux-next but got dropped later as it
> > broke PCI on ARM Juno R1 board. AFAICT, this issue is never root caused,
> > so resending this patch to get attention again.
> > 
> > https://lore.kernel.org/all/1621566204-37456-1-git-send-email-wangxingang5@huawei.com/
> 
> Please don't resend known-broken patches.  Please fix them up before
> resending, otherwise we will just ignore this one as well as obviously
> we can not take such a thing (nor should you want us to.)
> 

Thanks Greg for taking a look.

AFAICT, there is nothing wrong with the patch (It was Ackd before). The
root cause of the breakage on Juno ARM board is not identified. I resent
the patch to get the attention from people who reported this problem few
years back. I am *hoping* that they might have fixed the issue on their
side.

Thanks,
Pavan

