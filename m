Return-Path: <linux-pci+bounces-40821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BB4C4B91C
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 06:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C8D8A34E0A4
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 05:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D26626E6F7;
	Tue, 11 Nov 2025 05:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="a25IZSIg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80D425A2BB;
	Tue, 11 Nov 2025 05:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762840210; cv=none; b=vAFhP6iPs8jDxc+jjexlLSIMvX3MU9WzpHXKG5XruUXnK1GC36aX12HrBG5sjn8i9HfTsbm0Xa6CGYFyg8tnindLV8OPpw5gKrSvmviKMRuADUTcwuCihzrY1jcBdPasgEsKEHy1aMAbCF8lnJHaApXXSAZ8QzJD7HJm4uKrUwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762840210; c=relaxed/simple;
	bh=FqP3xWIkEbVz1BQX6sqvitRdRIe9hcRFt3vF1OQQCeY=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mWZx/bSA4G7c46+c7MEdFvqchwVagdV1Lb9K41difb/IL3VBlctIvKrwd9JZ4xJVjLRbifWQRQuWo1CXWFV2hQTYwwy37aDR7N4Lzn4SSrtvyPCqcsHSet5khY3O73pZztpb/A3FbRA87iOY9GAlOf3jZ1YkMwAwDa8jEfqiXoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=a25IZSIg; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AACf9gR2488054;
	Mon, 10 Nov 2025 21:49:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=7Crlj5rTmxhTEnDI8pS48dokYU7S6de8qIKUYDJytsM=; b=a25
	IZSIgoUOpCMPaOppWI5kLWhlsyn84DcgcP4i69qz/U+MeSqAGYiWMyFfzd4QJOS3
	EAsMAojdmlW5Uy4SDtp1asXtVddMQyMZSbb1x57jANMdSIuoXLjqsVhP77h7JCaT
	63Vwcq4z9KcuiXVD8Vhl5T0miCQucyGX2LpiPg5ABAC8vYZwSCz46CIaQSbmZBSb
	s9zXPF4EZAOUHeRIMrGVECTjr4iIDbr9CgGrJSPo4fMglADG1UQMI825ksfuURvN
	xsLEq5TTSirFqmQK5PHaF51CKQ3ikziWotx4pI6hikeb3R0rn4U7pegyRPgeLJ4z
	PP0O73j+po0niHwTS7w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4abg8na28a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 21:49:59 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 10 Nov 2025 21:49:58 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 10 Nov 2025 21:49:58 -0800
Received: from marvell-OptiPlex-Tower-Plus-7020 (unknown [10.28.38.120])
	by maili.marvell.com (Postfix) with SMTP id 7B52C3F704E;
	Mon, 10 Nov 2025 21:49:56 -0800 (PST)
Date: Tue, 11 Nov 2025 11:19:55 +0530
From: Shashank Gupta <shashankg@marvell.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Shashank Gupta <shashankg@marvell.com>,
        Bharat Bhushan
	<bbhushan2@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>
Subject: RE: [RFC PATCH] PCI: fix concurrent pci_bus_add_device() execution
 during SR-IOV VF creation
Message-ID: <aRLOg6+e3A+CByPB@marvell-OptiPlex-Tower-Plus-7020>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA0MyBTYWx0ZWRfX9NAk4ABy8tPC
 cwdmXtutoHG5MFX+csv+5c6U/6A2KmY4ntWpp0XwNlrq4kkeR0A59U6qUpbHU/gV3LbVkH/L3rf
 V3O6EOJwfxW2F9FCXwO2r09+LyIm/fTkOV4iV9SlCuhK0IEQrw0Z5U5wZbXVis45JP3jkHTeGqu
 EBUsTbOgPgueYx9Ch8oNrkgcFa5nd2AcxrIGu3BvUc7ASbEwvAPB2gjk5hcCWrMa0hhsNsd+8Js
 0iDihwsyP5tnvAFhwCWBzhsriIqDdNkYXZlJe1lSFYQ+8CwkXYFa8ntVmI4KjdOxGUJ+fo8hQSn
 yIA2+4VKIYrVvmlOZvklc5CgfTD9PS+F9N6T40RbG/mxRIFflQZMBiR3MQBmDD0mMoMMufeClRI
 5jsXw9Cq7qdhmBib9/deMT2zvUVEIg==
X-Authority-Analysis: v=2.4 cv=eKEeTXp1 c=1 sm=1 tr=0 ts=6912ce87 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=M5GUcnROAAAA:8 a=UqCG9HQmAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
 a=fkQ1JoPIeKV-9lTz00IA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-GUID: -De2gruysh2lQPTraFE7NgFUiIoZZRdu
X-Proofpoint-ORIG-GUID: -De2gruysh2lQPTraFE7NgFUiIoZZRdu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-10_02,2025-10-01_01

<bbhushan2@marvell.com>, Sunil Kovvuri Goutham <sgoutham@marvell.com> 
Bcc: 
Subject: Re: [RFC PATCH] PCI: fix concurrent pci_bus_add_device() execution
 during SR-IOV VF creation
Reply-To: 
In-Reply-To: <SN7PR18MB53145C30677F872D61EE49AEE3FCA@SN7PR18MB5314.namprd18.prod.outlook.com>

> > -----Original Message-----
> > From: Shashank Gupta <shashankg@marvell.com>
> > Sent: Thursday, September 11, 2025 4:41 PM
> > To: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Cc: Shashank Gupta <shashankg@marvell.com>; Bharat Bhushan
> > <bbhushan2@marvell.com>; Sunil Kovvuri Goutham
> > <sgoutham@marvell.com>
> > Subject: [RFC PATCH] PCI: fix concurrent pci_bus_add_device() execution
> > during SR-IOV VF creation
> > 
> > When enabling SR-IOV VFs via sriov_numvfs, a race can occur between VF
> > creation (`pci_iov_add_virtfn()`) and a parallel PCI bus rescan.
> > This may cause duplicate sysfs resource files to be created for the same VF.
> > `pci_device_add()` links the VF into the bus list before calling
> > `pci_bus_add_device()`. During this window, a parallel pci rescan may iterate
> > over the same VF and call `pci_bus_add_device()` before the PCI_DEV_ADDED
> > flag is set by sriov_numvfs, leading to duplicate sysfs entries.
> > 
> > sysfs: cannot create duplicate filename
> > '/devices/platform/0.soc/878020000000.pci/pci0002:00/0002:00:02.0/000
> > 2:03:00.3/resource2'
> > CPU: 10 PID: 1787 Comm: tee Tainted: G        W
> > 6.1.67-00053-g785627de1dee #150
> > Hardware name: Marvell CN106XX board (DT) Call trace:
> >  dump_backtrace.part.0+0xe0/0xf0
> >  show_stack+0x18/0x30
> >  dump_stack_lvl+0x68/0x84
> >  dump_stack+0x18/0x34
> >  sysfs_warn_dup+0x64/0x80
> >  sysfs_add_bin_file_mode_ns+0xd4/0x100
> >  sysfs_create_bin_file+0x74/0xa4
> >  pci_create_attr+0xf0/0x190
> >  pci_create_resource_files+0x48/0xc0
> >  pci_create_sysfs_dev_files+0x1c/0x30
> >  pci_bus_add_device+0x30/0xc0
> >  pci_bus_add_devices+0x38/0x84
> >  pci_bus_add_devices+0x64/0x84
> >  pci_rescan_bus+0x30/0x44
> >  rescan_store+0x7c/0xa0
> >  bus_attr_store+0x28/0x3c
> >  sysfs_kf_write+0x44/0x54
> >  kernfs_fop_write_iter+0x118/0x1b0
> >  vfs_write+0x20c/0x294
> >  ksys_write+0x6c/0x100
> >  __arm64_sys_write+0x1c/0x30
> > 
> > To prevent this, introduce a new in-progress private flag
> > (PCI_DEV_ADD_INPROG) in struct pci_dev and use it as an atomic guard
> > around pci_bus_add_device(). This ensures only one thread can progress with
> > device addition at a time.
> > 
> > The flag is cleared once the device has been added or the attempt has finished,
> > avoiding duplicate sysfs entries.
> 
> Please provide feedback to this RFC patch. 
> 
> Thanks
> -Bharat
>
Hi,

Please take a look to this RFC patch,

Thanks
-Shashank
> > 
> > Signed-off-by: Shashank Gupta <shashankg@marvell.com>
> > ---
> > 
> > Issue trace:
> > ------------
> > 
> > CPU2 (sriov_numvfs)                          CPU4 (pci rescan)
> > ------------------------------------------  --------------------------
> > pci_iov_add_virtfn()
> >   pci_device_add(virtfn)   # VF linked to bus
> >                                           pci_bus_add_devices()
> >                                             iterates over VF
> > 						PCI_DEV_ADDED not set yet
> > 
> > 
> >   pci_bus_add_device()
> > 	create sysfs file
> >         pci_dev_assign_added() set PCI_DEV_ADDED
> > 						pci_bus_add_device()
> > 						 duplicate sysfs file
> > 
> > 
> > 
> > Issue Log :
> > -----------
> > 
> > [CPU 2] = sriov_numfs creating 9 vfs
> > [CPU 4] = Pci rescan
> > 
> > [   93.486440] [CPU : 2]`==>pci_iov_add_virtfn: bus = PCI Bus 0002:20 slot = 0
> > func= 4 	# sriov_numvfs vf is getting created for vf 4
> > [   93.494002] [CPU : 4]`->pci_bus_add_devices: child-bus =
> > 				    # Pci rescan
> > [   93.494003] [CPU : 4]`->pci_bus_add_devices: bus = PCI Bus 0002:20
> > 
> > [   93.500178] pci 0002:20:00.4: [177d:a0f3] type 00 class 0x108000
> > [   93.507825] [CPU : 4]`->pci_bus_add_devices iterated dev : slot =  0 func = 0
> > # pci rescan iterating on created vfs
> > [   93.513288] [CPU : 2]`->pci_device_add : bus = PCI Bus 0002:20 slot = 0,
> > func= 4     # sriov_numvfs: vf 4 added in the cus list
> > [   93.519388] [CPU : 4]`->pci_bus_add_devices iterated dev : slot =  0 func = 1
> > 	    # pci rescan : vf iterated 1
> > [   93.525438] [CPU : 2]`->pci_bus_add_device: slot = 0 func= 4	                        #
> > sriov_numvfs: enter in adding vf 4 in sys/proc fs
> > [   93.532515] [CPU : 4]`->pci_bus_add_devices iterated dev : slot =  0 func = 2
> > 	    # pci rescan : vf iterated 2
> > [   93.539904] [CPU : 2]`->pci_bus_add_device create sysfs
> > pci_create_sysfs_dev_files: slot = 0 func= 4 # sriov: vf 4 sysfs file created
> > [   93.547032] [CPU : 4]`->pci_bus_add_devices iterated dev : slot =  0 func = 3
> > # pci rescan : vf iterated 3
> > [   93.552714] rvu_cptvf 0002:20:00.4: Adding to iommu group 85
> > [   93.559812] [CPU : 4]`->pci_bus_add_devices iterated dev : slot =  0 func = 4
> > 	    # pci rescan : vf iterated 4
> > [   93.569002] rvu_cptvf 0002:20:00.4: enabling device (0000 -> 0002)
> > [   93.576069] [CPU : 4]`->pci_bus_add_devices PCI_DEV_ADDED not set : slot
> > =  0 func = 4 # pci rescan : vf 4 PCI_DEV_ADDED flag not set by sriov_numvfs
> > [   93.576070] [CPU : 4]`->pci_bus_add_device: slot = 0 func= 4
> > 					  # pci rescan : enter for adding vf 4 in
> > sys/proc fs
> > [   93.576072] [CPU : 4]`->pci_bus_add_device create sysfs
> > pci_create_sysfs_dev_files: slot = 0 func= 4 # pci rescan : going to create sysfs
> > file
> > [   93.576078] sysfs: cannot create duplicate filename
> > '/devices/platform/0.soc/878020000000.pci/pci0002:00/0002:00:1f.0/000
> > 2:20:00.4/resource2' # duplication detected
> > [   93.608709] [CPU : 2]`->pci_dev_assign_added set PCI_DEV_ADDED : slot =
> > 0, func= 4        # sriov_numvfs : PCI_DEV_ADDED is set
> > [   93.617714] CPU: 4 PID: 811 Comm: tee Not tainted 6.1.67-00054-
> > g3acfa4185b96-dirty #159
> > [   93.630399] [CPU : 2]<==pci_iov_add_virtfn: bus = PCI Bus 0002:20 slot = 0
> > func= 4
> > 
> > 
> > Fix trace (with patch):
> > -----------------------
> > 
> > CPU2 (sriov_numvfs)                   CPU4 (pci rescan)
> > ----------------------------------   --------------------------
> > pci_iov_add_virtfn()
> >   pci_device_add(virtfn)   # VF linked to bus
> > 	pci_bus_add_device() enter
> > 		set PCI_DEV_ADD_INPROG
> >                                      pci_bus_add_device() enter
> >                                      PCI_DEV_ADD_INPROG already set
> >                                      return
> > 	pci_dev_assign_added()
> > 	pci_dev_clear_inprog()
> > 
> > Fix log:
> > -------
> > 
> > [CPU 2] = sriov_numfs creating 9 vfs
> > [CPU 4] = Pci rescan
> > 
> > [  178.296167] pci 0002:20:00.5: [177d:a0f3] type 00 class 0x108000 [
> > 178.302680] pci 0002:00:1b.0: PCI bridge to [bus 1c]
> > [  178.307746] [CPU : 2]`->pci_bus_add_device Enter : slot = 0, func= 5   #
> > sriov_numvfs: adding vf5 in sys/proc
> > [  178.313636] pci 0002:00:1c.0: PCI bridge to [bus 1d] [  178.318592] [CPU
> > : 2]`->pci_bus_add_device set PCI_DEV_ADD_INPROG : slot = 0, func= 5  #
> > sriov_numvfs: vf 5 PCI_DEV_ADD_INPROG flag set [  178.324939] pci
> > 0002:00:1d.0: PCI bridge to [bus 1e] [  178.329895] [CPU : 2]`-
> > >pci_bus_add_device PCI_DEV_ADDED is not set: slot = 0, func= 5 #
> > sriov_numvfs: vf 5 check if PCI_DEV_ADDED flag is set before proceed to
> > create sysfs file [  178.337719] pci 0002:00:1e.0: PCI bridge to [bus 1f] [
> > 178.342704] rvu_cptvf 0002:20:00.5: Adding to iommu group 86
> > [  178.350586] [CPU : 4]`->pci_bus_add_device Enter : slot = 0, func= 5     # pci
> > rescan : since PCI_DEV_ADDED flag is not set it enter the pci_bus_add_device
> > for vf 5
> > [  178.355597] rvu_cptvf 0002:20:00.5: enabling device (0000 -> 0002) [
> > 178.361193] [CPU : 4]`->pci_bus_add_device PCI_DEV_ADD_INPROG is
> > already set : slot = 0, func= 5  # pci rescan : check PCI_DEV_ADD_INPROG flag,
> > it is already set
> > [  178.373726] [CPU : 4] <- pci_bus_add_device return : slot = 0, func= 5
> > 	# pri rescan : return
> > [  178.382852] pci_bus 0003:01: busn_res: [bus 01] end is updated to 01
> > [  178.395474] [CPU : 2]`->pci_dev_assign_added set PCI_DEV_ADDED : slot =
> > 0, func= 5    # sriov_numvfs: set PCI_DEV_ADDED for vf5
> > [  178.395721] [CPU : 2]`->pci_dev_clear_inprog unset
> > PCI_DEV_ADD_INPROG : slot = 0, func= 5 # sriov_numvfs : clear
> > PCI_DEV_ADD_INPROG for vf5 [  178.403289] [CPU : 2] <-
> > pci_bus_add_device return : slot = 0, func= 5  drivers/pci/bus.c |  8 ++++++++
> > drivers/pci/pci.h | 11 +++++++++++
> >  2 files changed, 19 insertions(+)
> > 
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c index
> > feafa378bf8e..cafce1c4ec3d 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -331,6 +331,13 @@ void pci_bus_add_device(struct pci_dev *dev)  {
> >  	int retval;
> > 
> > +	if (pci_dev_add_inprog_check_and_set(dev))
> > +		return;
> > +
> > +	if (pci_dev_is_added(dev)) {
> > +		pci_dev_clear_inprog(dev);
> > +		return;
> > +	}
> >  	/*
> >  	 * Can not put in pci_device_add yet because resources
> >  	 * are not assigned yet for some devices.
> > @@ -347,6 +354,7 @@ void pci_bus_add_device(struct pci_dev *dev)
> >  		pci_warn(dev, "device attach failed (%d)\n", retval);
> > 
> >  	pci_dev_assign_added(dev, true);
> > +	pci_dev_clear_inprog(dev);
> >  }
> >  EXPORT_SYMBOL_GPL(pci_bus_add_device);
> > 
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h index
> > ffccb03933e2..a2d01db8e837 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -366,17 +366,28 @@ static inline bool pci_dev_is_disconnected(const
> > struct pci_dev *dev)  #define PCI_DEV_ADDED 0  #define
> > PCI_DPC_RECOVERED 1  #define PCI_DPC_RECOVERING 2
> > +#define PCI_DEV_ADD_INPROG 3
> > 
> >  static inline void pci_dev_assign_added(struct pci_dev *dev, bool added)  {
> >  	assign_bit(PCI_DEV_ADDED, &dev->priv_flags, added);  }
> > 
> > +static inline void pci_dev_clear_inprog(struct pci_dev *dev) {
> > +	clear_bit(PCI_DEV_ADD_INPROG, &dev->priv_flags); }
> > +
> >  static inline bool pci_dev_is_added(const struct pci_dev *dev)  {
> >  	return test_bit(PCI_DEV_ADDED, &dev->priv_flags);  }
> > 
> > +static inline bool pci_dev_add_inprog_check_and_set(struct pci_dev
> > +*dev) {
> > +	return test_and_set_bit(PCI_DEV_ADD_INPROG, &dev->priv_flags); }
> > +
> >  #ifdef CONFIG_PCIEAER
> >  #include <linux/aer.h>
> > 
> > --
> > 2.34.1
> 

