Return-Path: <linux-pci+bounces-40573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C321C3F983
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 11:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED9EF4EF1A8
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 10:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F8330F7E0;
	Fri,  7 Nov 2025 10:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NmA17DCv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6985531B82E;
	Fri,  7 Nov 2025 10:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762512891; cv=none; b=i97lGOwrKjdvz89/35nbRbxyepZ2kstmbMorqbnjKeS+POGYnwgpjKAgwLzNln3sexYXRWb46ZVBSVm7lzmcXMGwIoWx0szjwqruEuZzRBQHbmFfbOgZ1tyLuAr1LXTpmheehue/LVCngydll+uLCus8lGTuS0yQ3sJ6swLxs28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762512891; c=relaxed/simple;
	bh=f0UT+zAjNvqJvmM+MCPdxco34geubQvi9S/5ZE69KQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hB4undyXbDvQdhBWvrGIQI2a6lDYBoGQ60tlRklq1Ckynjjk0JOO5O2lwaHuWx+FOVmwUdFbkPQfMRBpyEp3F9sj/X0+671yP3/LEa1Hz4SMvTtsRql06fafuWb8ycNtprrhpFEw1mSUnKYoB0Nqaf2uiP9j1q+OP9ySnVgT070=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NmA17DCv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A78aMkF027290;
	Fri, 7 Nov 2025 10:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=nmdHonZEW5S4WBO/qMDEojU/8EYSI+zDi3J+bjgTxr8=; b=NmA17DCvibtW
	iK3Z4GwN07PbSDFy9TQHrHKHgHAFTsA2ws7/8JsRbUG9cRVr7gWUJsZyrc8grf0K
	ejx7rjxXWumSRNuSfw59PYO3KL+9oCcTGOWuj8lbRTAxOL53ATCNhEum3Uzv8RZv
	9wIG7LckG2BRPBmI80p6AdWmGlVba2sTrNXuVmarWFW9QBIEiRlBPKpHYI0pjlBq
	MUeEPnZlxoYipNV4N9sKhL1om86x73rLMthm8NMhvcL0vq5az0MVCgnUw2fB3u/0
	2vKF9LvqGmC4hNgI8y1GcRr6LoKn9KH6P831UYmhg4Ab8z/OCOKwy5zeaLuT/FRy
	2jvhlezeew==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59xcc62m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 10:54:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A77FJJ3027408;
	Fri, 7 Nov 2025 10:54:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5vwytcty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 10:54:44 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A7AsdOF49545708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Nov 2025 10:54:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3F082004B;
	Fri,  7 Nov 2025 10:54:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1CCF20040;
	Fri,  7 Nov 2025 10:54:39 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.152.212.147])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  7 Nov 2025 10:54:39 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.98.2)
	(envelope-from <bblock@linux.ibm.com>)
	id 1vHK75-00000000L1C-1stN;
	Fri, 07 Nov 2025 11:54:39 +0100
Date: Fri, 7 Nov 2025 11:54:39 +0100
From: Benjamin Block <bblock@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <kbusch@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Revert "PCI/IOV: Add PCI rescan-remove locking when
 enabling/disabling SR-IOV"
Message-ID: <20251107105439.GF20064@p1gen4-pw042f0m.boeblingen.de.ibm.com>
References: <20251030-revert_sriov_lock-v1-0-70f82ade426f@linux.ibm.com>
 <20251030-revert_sriov_lock-v1-1-70f82ade426f@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251030-revert_sriov_lock-v1-1-70f82ade426f@linux.ibm.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfXw0LvmHdseXs1
 oNxd9WInXRk51IyQH/a0f7yBlvo+3ag49NkhJhX6X5ngcbPtcE9HR8Oi9Co4BLRvOMKhOqq/6O0
 sWKj9w+M+f3kMw3pKUtVTX9ey3w+KdfJxK1UgJzlUKPYFn2qxbkdsdvB2RL1gTya9jcXsp9McJS
 a8E9ejHcKY+V5as3m0/eksDO+Bch7SVXoI6YcMjKdICYjr3PTrxddBsYT56m+Q4iLEyxw5wfmSc
 m/vaL1T/ODlbXfhKC/bPzaxW1hsEjmdnBXYn/iCvxnAfFX+v8CkkyWQ/qU8gStDwDXniHUHH/nl
 iZ0eRt7TVEnGph3F5B8XbwOs/cZC7e9mOeWmLn8c+rPtcz3vSazt6NIey84+7vku9l5LmuTCs8L
 way+qTssjDkLkJPgS8HOPQueP9Fabw==
X-Proofpoint-GUID: oPxCcaQa2QJjnkRwUtfn83b1OeiRrWF0
X-Authority-Analysis: v=2.4 cv=OdCVzxTY c=1 sm=1 tr=0 ts=690dcff5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=pTeQPpAXdWtEnx7RHPEA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: oPxCcaQa2QJjnkRwUtfn83b1OeiRrWF0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010021

On Thu, Oct 30, 2025 at 11:26:01AM +0100, Niklas Schnelle wrote:
> This reverts commit 05703271c3cd ("PCI/IOV: Add PCI rescan-remove
> locking when enabling/disabling SR-IOV") which causes a deadlock by
> recursively taking pci_rescan_remove_lock when sriov_del_vfs() is called
> as part of pci_stop_and_remove_bus_device(). For example with the
> following sequence of commands:
> 
> $ echo <NUM> > /sys/bus/pci/devices/<pf>/sriov_numvfs
> $ echo 1 > /sys/bus/pci/devices/<pf>/remove
> 
> A trimmed trace of the deadlock on a mlx5 device is as below:
> 
>  mutex_lock_nested+0x3c/0x50
>  sriov_disable+0x34/0x140
>  mlx5_sriov_disable+0x50/0x80 [mlx5_core]
>  remove_one+0x5e/0xf0 [mlx5_core]
>  pci_device_remove+0x3c/0xa0
>  device_release_driver_internal+0x18e/0x280
>  pci_stop_bus_device+0x82/0xa0
>  pci_stop_and_remove_bus_device_locked+0x5e/0x80
>  remove_store+0x72/0x90
> 
> This is not a complete fix as it restores the issue the cited commit
> tried to solve.
> 

Reviewed-by: Benjamin Block <bblock@linux.ibm.com>

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Böblingen     /    Registergericht: AmtsG Stuttgart, HRB 243294

