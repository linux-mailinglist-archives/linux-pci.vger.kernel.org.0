Return-Path: <linux-pci+bounces-24891-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D95BDA7405C
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 22:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67D8F16A8AA
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 21:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601CD1CCB21;
	Thu, 27 Mar 2025 21:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IlDz2PB3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA101CDA2D;
	Thu, 27 Mar 2025 21:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743111410; cv=none; b=JEhsKqR7Eko6FPL+z6msexexkrgUDbBWOKrVTZabZnM3xrhK3x9a9iW7UZEDOs2j0vwcXzDhnAf9qPRX0akAmmIyRpOO87t3l6JQGW8zlf+6yQPAhVCuDLfnrkAonE9Year9mV3/EV/NAsJ+v58AUBNR+1k1KL3sS+BrXDmNbmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743111410; c=relaxed/simple;
	bh=E4FHWzLgdzZKCh/heaNsXDin/Zf7ee+WtzhHzXjVGRE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fqjrUOa36+fvsothply2dxNe/vDUQMlE0NV7b50z6g0g80XzfODFavARrP48+zFw8zOgujnOYiaZ+Rw5yLTNk8zOW7fPMEqrcRX6SP5A+VNs67fdpsbEWVIx7EkvHwzNNaLU2tdx1UdubJ/OECN6ACPfd9Uja5DQPK+FSkrxTHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IlDz2PB3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RHBQd8001208;
	Thu, 27 Mar 2025 21:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pZq6sY
	B9F3sDcDveyOfLPuYIXAvcDbrRHan5X2BoNSo=; b=IlDz2PB32EVmM374w0o2aj
	f3ztLgM/sVHHJ+9mtbKxCDnM1gm/tYyv6oBwi3WfbypVgPW/29iLU0eKfK11s+d3
	cf+8jhij5AukNqrfXUqcvo/iMAUbEuwzeqiL4eC5U9+SjnyeXxK0ptbtc/OcAzID
	AKRNTtVXWLNwplaBKx3/k665dbFN+9aTU+nP66JKGVuCD8nk/pM+9nIeYs4jtBLJ
	TdONPK660dYgfDYa6VghvCZsMUI+zOShT3MOjtV+M6+L3ClUJKe8//Gb4s9oJ2S0
	p44AWSLObh1LlpQ8vGdSs6Ppjj8JgJYX0PWZEWFccPXSC2M/oz1nkKGG0bgOfnhw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45naux19sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 21:36:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52RKCWuO009693;
	Thu, 27 Mar 2025 21:36:33 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j9rky70q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 21:36:33 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52RLaXI127460272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 21:36:33 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 233D258057;
	Thu, 27 Mar 2025 21:36:33 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D746C5805D;
	Thu, 27 Mar 2025 21:36:32 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Mar 2025 21:36:32 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Mar 2025 16:36:32 -0500
From: Wen Xiong <wenxiong@linux.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, gjoyce@linux.ibm.com,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/1] genirq/msi: Dynamic remove/add stroage adapter hits
 EEH
In-Reply-To: <874izo3x60.ffs@tglx>
References: <1742386474-13717-1-git-send-email-wenxiong@linux.ibm.com>
 <87a59h3sk9.ffs@tglx> <90777da90abe02c87d30968bfedc9168@linux.ibm.com>
 <877c4k3yc5.ffs@tglx> <874izo3x60.ffs@tglx>
Message-ID: <8383b17f160bb75dd6ca6b47cd1a0d32@linux.ibm.com>
X-Sender: wenxiong@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MJe-CSRXuqJGTS97fGwGBjuuI2_TBMpK
X-Proofpoint-ORIG-GUID: MJe-CSRXuqJGTS97fGwGBjuuI2_TBMpK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_04,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503270144



> What about tearing down resources first and then issuing the reset?

This SAS adapter supports dual controller configuration. Normally we 
have two adapters in a system.
We config one of them as Primary adapter and another one as  Secondary 
adapter.
When doing remove operation on primary adapter, the Secondary adapter is 
going to be failover and config as primary by adapter firmware. During 
failover process, adapter firmware requests the secondary adapter reset, 
then sets it as primary adapter.

Secondary adapter failover triggers adapter 
reset(ipr_reset_get_unit_check_job()).

[  940.742698] ipr 0206:a0:00.0: 9070: IOA requested reset  -> FW 
requested
[  940.742733] ipr 0206:a0:00.0: Adapter to Adapter Link Failed Due to 
SAS Fabric Change [PRC: 17101C25]
[  940.742768] ipr 0206:a0:00.0: Remote IOA VPID/SN: IBM 57B4001SISIOA 
00458021

When secondary adapter doing a reset, we use the same code path as 
removing operation. We can’t free irqs for Secondary adapter since 
kernel has assigned the irqs for Secondary adapter.

Actually we discussed about "calling pci_free_irq_vectors()" before 
doing bist reset when we trying to fix in device driver.

That might cause other problems. It is also not what a user would 
expect. For example, if they disabled irq balance and manually setup irq 
binding and affinity, if we go and free and reallocate the interrupts 
across a reset, this would wipe out those changes, which would not be 
expected.

Thanks,
Wendy

