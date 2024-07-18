Return-Path: <linux-pci+bounces-10495-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F3A934B88
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 12:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57A62B2283F
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 10:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A177A715;
	Thu, 18 Jul 2024 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q8AOWycx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D103612C46D;
	Thu, 18 Jul 2024 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721297617; cv=none; b=KXAgbb8n+jNik2tuzUlyDW+ohVbWC1zcGUN2dG0x98OcwnJLizqQtWMkNCWKmf1tpCQ6+bXafKGOPWnLyPPhWpHLNUtnkIfpBk1M+hhzuBt3RkbYQetq4suUNOKZqzSlzlScVaLzbVoxpSmI8OKyYxZ+A09bV1aK9Chawwv+ZYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721297617; c=relaxed/simple;
	bh=R3Xl2ulng1qAC+aJtbMR94fFWC6W2dXLXgdRmegLgWQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3cZXbiL99T7Jl+AUgnC1dQw0gCu3AEZRtyhBnF0jnO/Xc+ZAfFHpZcBBAukkuobBm1c4zSRieHFfI7ufajrcmG6Y6w6AFPXv5qGScwnnagkPAR1mZ2kOIyAQYIPQX7/nLd8IQM2zohAnTkBGSalLH/wrRN7PmA8V9hy9479NzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q8AOWycx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46I30Wdf024108;
	Thu, 18 Jul 2024 10:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=eR8901HJO9WITQXSspzaYXad
	3fJdO0EezwyJ9Xn459I=; b=Q8AOWycxxTaFrfPR+SH/hQf0nTv3AeJvra0O4mSj
	WMFap5FNqsR/h66kTqWBIYk6rX/p/kLjoqi/TY9aHhF83eTO/NFGzSS87xBvcH2z
	lCa4CBvuZC+Rgyrwn/6I6QvWLTNiw9H6PjykkmCzErCCW6FMmz2VLhthEjmtEizL
	q6vSdcIjLnLivGDi7J6YcUBmSJ8RcnX8qSBqRRm1vJaaxbdCpo0gyrjeU+nyX5KJ
	cXiuULlc0hD6Q+GQwx+9Tizimqe1G5gSfgOJE93pJs6apJ+3Jyh68BMO2ANZbs80
	SpcBkJvSlkBDgHi6Z4ZCYLmHR/MwEApubaoHrhN/iGiKOg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfnn592-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 10:13:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46IADPOL017215
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 10:13:25 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 18 Jul 2024 03:13:21 -0700
Date: Thu, 18 Jul 2024 15:43:18 +0530
From: Pavan Kondeti <quic_pkondeti@quicinc.com>
To: Will Deacon <will@kernel.org>, Vidya Sagar <vidyas@nvidia.com>
CC: Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Manikanta Maddireddy
	<mmaddireddy@nvidia.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Krishna Thota <kthota@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [Query] ACS enablement in the DT based boot flow
Message-ID: <f551eecc-33fa-4729-b004-64a532493705@quicinc.com>
References: <PH8PR12MB667446D4A4CAD6E0A2F488B5B83F2@PH8PR12MB6674.namprd12.prod.outlook.com>
 <20240410192840.GA2147526@bhelgaas>
 <20240428072318.GA11447@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240428072318.GA11447@willie-the-truck>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iDxlsnbsC8QinLVrS0tGPOoz8_Quukl9
X-Proofpoint-ORIG-GUID: iDxlsnbsC8QinLVrS0tGPOoz8_Quukl9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_06,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 clxscore=1011 spamscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407180066

Hi Vidya/Will,

On Sun, Apr 28, 2024 at 08:23:18AM +0100, Will Deacon wrote:
> On Wed, Apr 10, 2024 at 02:28:40PM -0500, Bjorn Helgaas wrote:
> > [+cc Will, Joerg]
> > 
> > On Mon, Apr 01, 2024 at 10:40:15AM +0000, Vidya Sagar wrote:
> > > Hi folks,
> > > ACS (Access Control Services) is configured for a PCI device through
> > > pci_enable_acs().  The first thing pci_enable_acs() checks for is
> > > whether the global flag 'pci_acs_enable' is set or not.  The global
> > > flag 'pci_acs_enable' is set by the function pci_request_acs().
> > > 
> > > pci_enable_acs() function is called whenever a new PCI device is
> > > added to the system
> > > 
> > >  pci_enable_acs+0x4c/0x2a4
> > >  pci_acs_init+0x38/0x60
> > >  pci_device_add+0x1a0/0x670
> > >  pci_scan_single_device+0xc4/0x100
> > >  pci_scan_slot+0x6c/0x1e0
> > >  pci_scan_child_bus_extend+0x48/0x2e0
> > >  pci_scan_root_bus_bridge+0x64/0xf0
> > >  pci_host_probe+0x18/0xd0
> > > 
> > > In the case of a system that boots using device-tree blob,
> > > pci_request_acs() is called when the device driver binds with the
> > > respective device
> > > 
> > > of_iommu_configure+0xf4/0x230
> > > of_dma_configure_id+0x110/0x340
> > > pci_dma_configure+0x54/0x120
> > > really_probe+0x80/0x3e0
> > > __driver_probe_device+0x88/0x1c0
> > > driver_probe_device+0x3c/0x140
> > > __device_attach_driver+0xe8/0x1e0
> > > bus_for_each_drv+0x78/0xf0
> > > __device_attach+0x104/0x1e0
> > > device_attach+0x14/0x30
> > > pci_bus_add_device+0x50/0xd0
> > > pci_bus_add_devices+0x38/0x90
> > > pci_host_probe+0x40/0xd0
> > > 
> > > Since the device addition always happens first followed by the
> > > driver binding, this flow effectively makes sure that ACS never gets
> > > enabled.
> > > 
> > > Ideally, I would expect the pci_request_acs() get called (probably
> > > by the OF framework itself) before calling pci_enable_acs().
> > > 
> > > This happens in the ACPI flow where pci_request_acs() is called
> > > during IORT node initialization (i.e. iort_init_platform_devices()
> > > function).
> > > 
> > > Is this understanding correct? If yes, would it make sense to call
> > > pci_request_acs() during OF initialization (similar to IORT
> > > initialization in ACPI flow)?
> > 
> > Your understanding looks correct to me.  My call graph notes, FWIW:
> > 
> >   mem_init
> >     pci_iommu_alloc                   # x86 only
> >       amd_iommu_detect                # init_state = IOMMU_START_STATE
> >         iommu_go_to_state(IOMMU_IVRS_DETECTED)
> >           state_next
> >             switch (init_state)
> >             case IOMMU_START_STATE:
> >               detect_ivrs
> >                 pci_request_acs
> >                   pci_acs_enable = 1  # <--
> >       detect_intel_iommu
> >         pci_request_acs
> >           pci_acs_enable = 1          # <--
> > 
> >   pci_scan_single_device              # PCI enumeration
> >     ...
> >       pci_init_capabilities
> >         pci_acs_init
> >           pci_enable_acs
> >             if (pci_acs_enable)       # <--
> >               pci_std_enable_acs
> > 
> >   __driver_probe_device
> >     really_probe
> >       pci_dma_configure               # pci_bus_type.dma_configure
> >         if (OF)
> >           of_dma_configure
> >             of_dma_configure_id
> >               of_iommu_configure
> >                 pci_request_acs       # <-- 6bf6c24720d3
> >                 iommu_probe_device
> >         else if (ACPI)
> >           acpi_dma_configure
> >             acpi_dma_configure_id
> >               acpi_iommu_configure_id
> >                 iommu_probe_device
> > 
> > The pci_request_acs() in of_iommu_configure(), which happens too late
> > to affect pci_enable_acs(), was added by 6bf6c24720d3 ("iommu/of:
> > Request ACS from the PCI core when configuring IOMMU linkage"), so I
> > cc'd Will and Joerg.  I don't know if that *used* to work and got
> > broken somehow, or if it never worked as intended.
> 
> I don't have any way to test this, but I'm supportive of having the same
> flow for DT and ACPI-based flows. Vidya, are you able to cook a patch?
> 

I ran into a similar observation while testing a PCI device assignment
to a VM. In my configuration, the virtio-iommu is enumerated over the
PCI transport. So, I am thinking we can't hook pci_request_acs() to an
IOMMU driver. Does the below patch makes sense?

The patch is tested with a VM and I could see ACS getting enabled and
separate IOMMU groups are created for the devices attached under
PCIe root port(s).

The RC/devices with ACS quirks are not suffering from this problem as we 
short circuit ACS capability detection checking in
pci_acs_enabled()->pci_dev_specific_acs_enabled() . May be this is one
of the reason why this was not reported/observed by some platforms with
DT.

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index b908fe1ae951..0eeb7abfbcfa 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -123,6 +123,13 @@ bool pci_host_of_has_msi_map(struct device *dev)
 	return false;
 }
 
+bool pci_host_of_has_iommu_map(struct device *dev)
+{
+	if (dev && dev->of_node)
+		return of_get_property(dev->of_node, "iommu-map", NULL);
+	return false;
+}
+
 static inline int __of_pci_pci_compare(struct device_node *node,
 				       unsigned int data)
 {
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4c367f13acdc..ea6fcdaf63e2 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -889,6 +889,7 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
 	dev_set_msi_domain(&bus->dev, d);
 }
 
+bool pci_host_of_has_iommu(struct device *dev);
 static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 {
 	struct device *parent = bridge->dev.parent;
@@ -951,6 +952,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	    !pci_host_of_has_msi_map(parent))
 		bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
 
+	if (pci_host_of_has_iommu_map(parent))
+		pci_request_acs();
+
 	if (!parent)
 		set_dev_node(bus->bridge, pcibus_to_node(bus));
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index cafc5ab1cbcb..7eceed71236a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2571,6 +2571,7 @@ struct device_node;
 struct irq_domain;
 struct irq_domain *pci_host_bridge_of_msi_domain(struct pci_bus *bus);
 bool pci_host_of_has_msi_map(struct device *dev);
+bool pci_host_of_has_iommu_map(struct device *dev);
 
 /* Arch may override this (weak) */
 struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus);
@@ -2579,6 +2580,7 @@ struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus);
 static inline struct irq_domain *
 pci_host_bridge_of_msi_domain(struct pci_bus *bus) { return NULL; }
 static inline bool pci_host_of_has_msi_map(struct device *dev) { return false; }
+static inline bool pci_host_of_has_iommu_map(struct device *dev) { return false; }
 #endif  /* CONFIG_OF */
 
 static inline struct device_node *

Thanks,
Pavan



