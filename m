Return-Path: <linux-pci+bounces-40584-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7221C407C7
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 15:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD3BF565E87
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 14:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D83732B9AC;
	Fri,  7 Nov 2025 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qu1w2X9H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444DC32B9A1;
	Fri,  7 Nov 2025 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762527126; cv=none; b=GAXnUOCX3F418c7JAfIOnSDt+2LF1ApO1TfThbCX1HCGiVjuPpRSyV4EEliqBT/xbRTV9vDYIAmM7Q02p3XjMdINfYQfFOG1KXw55Rw0I5AHkaPWPiRXRuk52w+cX0B6MS2t3nBVbNmNGBCZzCztnZ1G0mSNCKfPQL/DJmTIKi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762527126; c=relaxed/simple;
	bh=C38A8Rppp1oAApe6G86myQtqDVJXMB+Fq0+b+PaLiE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQj5SLNH2ayj5uQTsgslLnVtdrH7AFL73xf9xXjUrKFG2kfHezrHmOu7RRw+MszdrdfNi5hgDaQxnepFeokyNdJmoBaWOATApPJjgCVRAtFK+hvu7ojM2laBstr2hTYcXUs1jJlIfud6dGn6ZBrrEPKHm85BpcXrQEIUcFe2E5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qu1w2X9H; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7Cf4Ce019513;
	Fri, 7 Nov 2025 14:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=S/6bVdHxr7CBOUI2ULa9n4Kzkn4cJ41uX7rrnTk8wjg=; b=Qu1w2X9HuJRD
	ls2XYnA7WDoBygxgV/J2nsGQsIdwxkz7rHzWNNab+5t7w1oX/Z7Ipue8ocUpeZhC
	iIbaADbknOI+wuox6BPuMLgpcy9/WVRSpcMfqlG5CIWAthUwI5IDGEQdRNW5etVy
	9GugcwuaCioUIRbB69+c+nYBit6ijvCbvWUhFKd+1x0G+kkJ6DG1kkE/13wH5JUR
	sPJxEWp1yzRJaEmMueGgZAqxX+MLZXbxjix4/Vrygj//ukojVaWQvqxR4sL3QtQK
	7fo5r9OkvkVtCCbmb3BwNbbcb8jXqPJjitSLnomIxXbrNtfvWhD7A4IgCAau4w91
	mox//WCIuA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a58mmc1nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 14:52:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7BHNTb027371;
	Fri, 7 Nov 2025 14:52:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5vwyubxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 14:52:00 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A7Epukg44695844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Nov 2025 14:51:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98C6D2004B;
	Fri,  7 Nov 2025 14:51:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8705020043;
	Fri,  7 Nov 2025 14:51:56 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.152.212.147])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  7 Nov 2025 14:51:56 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.98.2)
	(envelope-from <bblock@linux.ibm.com>)
	id 1vHNoi-00000000gZ0-1F4t;
	Fri, 07 Nov 2025 15:51:56 +0100
Date: Fri, 7 Nov 2025 15:51:56 +0100
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
Subject: Re: [PATCH 2/2] PCI/IOV: Fix race between SR-IOV enable/disable and
 hotplug
Message-ID: <20251107145156.GG20064@p1gen4-pw042f0m.boeblingen.de.ibm.com>
References: <20251030-revert_sriov_lock-v1-0-70f82ade426f@linux.ibm.com>
 <20251030-revert_sriov_lock-v1-2-70f82ade426f@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251030-revert_sriov_lock-v1-2-70f82ade426f@linux.ibm.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 197XCXiNaUyQrw7Nm6oITgN2d6cin25c
X-Proofpoint-GUID: 197XCXiNaUyQrw7Nm6oITgN2d6cin25c
X-Authority-Analysis: v=2.4 cv=SqidKfO0 c=1 sm=1 tr=0 ts=690e0791 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=FA75riZvBPGjLy6D85AA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAwOSBTYWx0ZWRfX9T3IwsWb3CpD
 FnCmdeevT9Kt6Fy8XSggCL/rSROWx4GTYPo/qyqnnLZ95uihTCHaabBOqzB4g4HwpQGxN9WvG1C
 cxR8E0RAbzD2EbhZdvn5K0tfWrQyQ3v0x5sqzWDp0ZO0cvMbaiFy5PIxerAOEW2FexzPckV2I5O
 bIo1M+2A2qE9+foj4FdgIEhueF9EIRZnkKGkSNN1KWx+EjUWDbZrzaPJiK/2cdRdV2145TdsLJP
 DxOkKFc2I52Wuc31BiIyjc/CEEoGVO3VmfrhOqbjbFzS4Gtv1JZ2HFzBTKqietqok4v3EOLAgfR
 /e7KizqYYnrbovYc/Lsbr3ltLk0MSpIB/6MwFOjw+tSu4H7KcNQGHw4WquYXakgzsBkIb9Gs+c/
 3VfbTfN6ZC71OSwCPSZirZOfpcO3Kg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010009

Hey Niklas,

On Thu, Oct 30, 2025 at 11:26:02AM +0100, Niklas Schnelle wrote:
> Commit 05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when
> enabling/disabling SR-IOV") tried to fix a race between the VF removal
> inside sriov_del_vfs() and concurrent hot unplug by taking the PCI
> rescan/remove lock in sriov_del_vfs(). Similarly the PCI rescan/remove
> lock was also taken in sriov_add_vfs() to protect addition of VFs.
> 
> This approach however causes deadlock on trying to remove PFs with
> SR-IOV enabled because PFs disable SR-IOV during removal and this
> removal happens under the PCI rescan/remove lock. So the original fix
> had to be reverted.
> 
> Instead of taking the PCI rescan/remove lock in sriov_add_vfs() and
> sriov_del_vfs(), fix the race that occurs with SR-IOV enable and disable
> vs hotplug higher up in the callchain by taking the lock in
> sriov_numvfs_store() before calling into the driver's sriov_configure()
> callback.
> 
> Cc: stable@vger.kernel.org
> Fixes: 05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV")
> Reported-by: Benjamin Block <bblock@linux.ibm.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/pci/iov.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

It fixes the original bug (kernel panic) AFAICT, insofar:

Reviewed-by: Benjamin Block <bblock@linux.ibm.com>


But tbh., I find it a bit "scary" to take one global lock at such a high
level, when it is also used at much lower levels throughout the stack.

IIRC my original (internal) report boiled down to that pci_destroy_dev() is
called essentially unlocked, and without taking any of the attached reference
counts into account.. which seems fishy IMHO. The actual freeing of the memory
is hidden behind a reference, but stuff like device_del() is just.. done..
and that seems strange to me.

Having a bit more granularity here might not hurt; but I can't say I have a
good idea on top of my mind in how to do that, so... rather fix the panic.

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Böblingen     /    Registergericht: AmtsG Stuttgart, HRB 243294

