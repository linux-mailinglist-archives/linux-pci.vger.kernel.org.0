Return-Path: <linux-pci+bounces-10158-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 968EE92EA9D
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 16:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CBFA1F2351F
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 14:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BCC16A921;
	Thu, 11 Jul 2024 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vp9D4zD2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C431684A6;
	Thu, 11 Jul 2024 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720707705; cv=none; b=stouBE3NOawH0IQ5tXFHnvl8LEaY5k5O4rPHnVdBay6ur9T5ja4/Ya9EJxmbOZEqacV+V+I7h9g0xMqhT0u0IXE5An980en96HhYP19k12TW1FfO5fXa+KnUQY1MaFGXCfwZkcWDhImsuho39ppakbC809CaUrlT6ADEI20+tZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720707705; c=relaxed/simple;
	bh=9rv9sMOJTNaVCAXVckZJpszdBHzLkx+Y2phucmuy4AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZSSttIltXb1gb1KCSmDTnuqrG279UypoasjP1G8N9YTwC7WxkNlr0HQsbqns4fzwMQeFw8UyS5vummjcp4qmMhGarSOYX35Kupyf16yGDfVidzy9Df6pS6M6gnOW58tfI8vK345PCkeWUfoGjyT9lGihlcOHE+VcmX69JkPid8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vp9D4zD2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BDxDbF029159;
	Thu, 11 Jul 2024 14:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=pp1; bh=H
	y7Ow+QuFzjJ8HpKXMdsxifcalcMak4d4YwFzu94KDM=; b=Vp9D4zD2DTnztFWPx
	4JTvWSirWHljxahtUil6FV8CbRXG1/dxWfsR7npfISHY7xqnCT9AXNnmaI/Uwhs6
	MAzRkUwjMyCscFRPllshORjUcTwq/GLaqdE/uxMgax9zcB0sGWVL0iABn97JX7Kd
	5Z/GaRQjSwKV11UEdgXzjHxYYl4HzNW7E4svVSXwIWkUs5X8DwbRx4uBDdy97QEX
	L75H8hTMxkpU5f/tVBsm0Me+PbMk+e7TexD58x/Hlsgl6KRoztQOuBn0DtoZdRou
	DbqIWoFscwSUGowvCdRuJEPFBdlYeOpwCy2ciRs1ElR+DFZYVIzjOm2P4x0xE+ov
	nmEEQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40agrb02d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 14:21:30 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46BELU10031657;
	Thu, 11 Jul 2024 14:21:30 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40agrb02cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 14:21:30 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46BBDMKW024698;
	Thu, 11 Jul 2024 14:21:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 407g8uhdqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 14:21:29 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46BELNvx15335856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 14:21:25 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D6542004D;
	Thu, 11 Jul 2024 14:21:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE0B220040;
	Thu, 11 Jul 2024 14:21:14 +0000 (GMT)
Received: from li-e7e2bd4c-2dae-11b2-a85c-bfd29497117c.ibm.com (unknown [9.195.44.247])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 11 Jul 2024 14:21:14 +0000 (GMT)
Date: Thu, 11 Jul 2024 19:51:06 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
        Kowshik Jois B S <kowsjois@linux.ibm.com>
Subject: Re: [PATCH] PCI: Fix crash during pci_dev hot-unplug on pseries KVM
 guest
Message-ID: <qcidmczsjdhaqz7hy3cqnpkjiaulxi7277ayzly3zyrrdbcr4w@5s4x5cgd3xk2>
Mail-Followup-To: Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>, 
	Vaibhav Jain <vaibhav@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, 
	Kowshik Jois B S <kowsjois@linux.ibm.com>
References: <20240703141634.2974589-1-amachhiw@linux.ibm.com>
 <CAL_JsqL9hg8Hze4oOP1R55yVXBfTKE=RfwdBraNHiO71K21uNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqL9hg8Hze4oOP1R55yVXBfTKE=RfwdBraNHiO71K21uNA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OdiQBSyMmWoj7PQSjzWTRMr86YEyO3b6
X-Proofpoint-ORIG-GUID: vNxGWtVZgWNpTeQ951TVzKXP0lr4nCmh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_09,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 spamscore=0 mlxlogscore=664 priorityscore=1501
 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110099

Hi Rob,

On 2024/07/11 06:20 AM, Rob Herring wrote:
> On Wed, Jul 3, 2024 at 8:17 AM Amit Machhiwal <amachhiw@linux.ibm.com> wrote:
> >
> > With CONFIG_PCI_DYNAMIC_OF_NODES [1], a hot-plug and hot-unplug sequence
> > of a PCI device attached to a PCI-bridge causes following kernel Oops on
> > a pseries KVM guest:
> 
> Can I ask why you have this option on in the first place? Do you have
> a use for it or it's just a case of distros turn on every kconfig
> option.

Yes, this option is turned on in Ubuntu's distro kernel config where the issue
was originally reported, while Fedora is keeping this turned off.

    root@ubuntu:~# cat /boot/config-6.8.0-38-generic | grep PCI_DYN
    CONFIG_PCI_DYNAMIC_OF_NODES=y

    root@fedora:~# cat /boot/config-6.9.7-200.fc40.ppc64le | grep PCI_DYN
    # CONFIG_PCI_DYNAMIC_OF_NODES is not set

Thanks,
Amit

> 
> Rob

