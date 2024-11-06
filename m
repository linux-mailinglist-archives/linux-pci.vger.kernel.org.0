Return-Path: <linux-pci+bounces-16098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5819BDEA2
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 07:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66178B20B58
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 06:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5913E1922D8;
	Wed,  6 Nov 2024 06:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Vw9BIM28"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AB71EA84;
	Wed,  6 Nov 2024 06:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730873636; cv=none; b=YMfQIesJ17SEjJZVHF8ZLrkIarsEU5mphDsIrBzUma9rbShB8nt5/ghI8nUEEzoRTBA6lYXOh6ueM9EFkll25qJROzKK7o8VrEZb9RHztehLPnLsA5JVHeENmOxlkccehJgg0e6TGIYp0gpKaMmoV32Wb3tafTmQ7MowRIzRtSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730873636; c=relaxed/simple;
	bh=ij5sP0sgcfyp4vNcr5VhNkd1kYiVnX85SnfkKP8HySM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzZhc/WUbhNqpjxdS8pwP1FfnRueNDwO40iac4+jtZquQpzR3azAKM9h4ubfpHIkPiPPIP6NSqiEn8Cwyalnp6fsnw+VDhN5m04xII5fbCTJ4pBtWgnLWUNswwoeKS7uEbix8cpAQS0cCALQLokMC1GlfEUhwJ2HQP3AdqzdbuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Vw9BIM28; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5JSevM028956;
	Wed, 6 Nov 2024 06:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tQEdaeIHsa+YDP0T1JV2vU5j
	HJvqfZsEeBJ+ccBrGFs=; b=Vw9BIM28J3hcF3FYqrUzZSXy6dbpXMqsnOQVxJA5
	Cgn9KQv3teN4555ZyuZyQLN497gx+ePcpjlAk2Sa1yogrdScmSZU0mZgx1TuGDPy
	t5kd3ANW+GkYFKAOorHyf6irMGv3t2BbUm93F/aqZjpY7PJNr/eIw01erpxq6A3b
	FO+kGFvFlHKMaAGDaSCBVSxnImUUa3VJvfTioq1K89iLzDa6s95sKtjuEFcLYgHq
	N1g66xSX/sk9CsK9Teq5P8h4aeC/bzUG4P1fhX9kRhtFYXbIU6in0i9QE/TJTu53
	cSZT5x3wXCEY+I8NqcO6dYiqGNXlkTHvvnPQRL6xk4ofEw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd28a5ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 06:13:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A66Damv011540
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Nov 2024 06:13:36 GMT
Received: from hu-pkondeti-hyd (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 5 Nov 2024
 22:13:32 -0800
Date: Wed, 6 Nov 2024 11:43:30 +0530
From: Pavan Kondeti <quic_pkondeti@quicinc.com>
To: Pavan Kondeti <quic_pkondeti@quicinc.com>
CC: Will Deacon <will@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
        "Bjorn
 Helgaas" <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Manikanta Maddireddy
	<mmaddireddy@nvidia.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Krishna Thota <kthota@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [Query] ACS enablement in the DT based boot flow
Message-ID: <f320e311-89ba-4a92-a231-1298ecc94c0b@quicinc.com>
References: <PH8PR12MB667446D4A4CAD6E0A2F488B5B83F2@PH8PR12MB6674.namprd12.prod.outlook.com>
 <20240410192840.GA2147526@bhelgaas>
 <20240428072318.GA11447@willie-the-truck>
 <f551eecc-33fa-4729-b004-64a532493705@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f551eecc-33fa-4729-b004-64a532493705@quicinc.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qGyXiVCKSC9oqX5JFNj49MOw9bMc-ESH
X-Proofpoint-GUID: qGyXiVCKSC9oqX5JFNj49MOw9bMc-ESH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 clxscore=1011 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060048

Hi Will,

On Thu, Jul 18, 2024 at 03:43:18PM +0530, Pavan Kondeti wrote:
> > > The pci_request_acs() in of_iommu_configure(), which happens too late
> > > to affect pci_enable_acs(), was added by 6bf6c24720d3 ("iommu/of:
> > > Request ACS from the PCI core when configuring IOMMU linkage"), so I
> > > cc'd Will and Joerg.  I don't know if that *used* to work and got
> > > broken somehow, or if it never worked as intended.
> > 
> > I don't have any way to test this, but I'm supportive of having the same
> > flow for DT and ACPI-based flows. Vidya, are you able to cook a patch?
> > 
> 
> I ran into a similar observation while testing a PCI device assignment
> to a VM. In my configuration, the virtio-iommu is enumerated over the
> PCI transport. So, I am thinking we can't hook pci_request_acs() to an
> IOMMU driver. Does the below patch makes sense?
> 
> The patch is tested with a VM and I could see ACS getting enabled and
> separate IOMMU groups are created for the devices attached under
> PCIe root port(s).
> 
> The RC/devices with ACS quirks are not suffering from this problem as we 
> short circuit ACS capability detection checking in
> pci_acs_enabled()->pci_dev_specific_acs_enabled() . May be this is one
> of the reason why this was not reported/observed by some platforms with
> DT.
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index b908fe1ae951..0eeb7abfbcfa 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -123,6 +123,13 @@ bool pci_host_of_has_msi_map(struct device *dev)
>  	return false;
>  }
>  
> +bool pci_host_of_has_iommu_map(struct device *dev)
> +{
> +	if (dev && dev->of_node)
> +		return of_get_property(dev->of_node, "iommu-map", NULL);
> +	return false;
> +}
> +
>  static inline int __of_pci_pci_compare(struct device_node *node,
>  				       unsigned int data)
>  {
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4c367f13acdc..ea6fcdaf63e2 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -889,6 +889,7 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
>  	dev_set_msi_domain(&bus->dev, d);
>  }
>  
> +bool pci_host_of_has_iommu(struct device *dev);
>  static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  {
>  	struct device *parent = bridge->dev.parent;
> @@ -951,6 +952,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  	    !pci_host_of_has_msi_map(parent))
>  		bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
>  
> +	if (pci_host_of_has_iommu_map(parent))
> +		pci_request_acs();
> +
>  	if (!parent)
>  		set_dev_node(bus->bridge, pcibus_to_node(bus));
>  

I see that this problem is reproducible with the kernel tip. While preparing
patch submission, I found there was an attempt to fix [1] this problem
earlier but later reverted due to issues reported on linux-next. I did
not see any follow up on the issues. I would like to resend this patch
again as it was acked by people.

Thanks,
Pavan

[1]
https://lore.kernel.org/all/1621566204-37456-1-git-send-email-wangxingang5@huawei.com/

