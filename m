Return-Path: <linux-pci+bounces-37247-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CB1BAC2EF
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 11:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891821743AE
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 09:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A552425BF18;
	Tue, 30 Sep 2025 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ved8tk7E"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D834E13B7AE;
	Tue, 30 Sep 2025 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759223398; cv=none; b=HSSc5Y5OU/n5dujSa7BPGVqkpCeKJu21qLfIJ70iU/VhHJZqg8R5J+MW+N/8GYvuWMgSYzO0JZGRLgUnancTplQvCWgvYZsNRpGux2PKPpkW0vbwc61oFGYiHdCn/ahNRxX5SS9tHHpynDX3vMhOJusveXO08pYVSB1sFLBSo4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759223398; c=relaxed/simple;
	bh=j0dQ61BBZgel+vLf64vdTWhhJTqPlVoBGym2X/T+t7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlDOpmkT4PRU8uR4rK95yNzbM2DznhL2tQmEsIQFeE4z5y7roNUNO7TP7ecnefmSwxHCQ2IkggecTE87WlFddZnENPtH38lEQvuyb5B5C++bAPZxmiosDjHLk50Rk/sWkLYB5VnpuUqx45ML+cGUXV9oWNWP0LZEExeiSPqzhAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ved8tk7E; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U2k2fG003535;
	Tue, 30 Sep 2025 09:09:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=NwY0hUYw15bUdFK/K7Y9PHuY1XDRcsqtjAjoNeZwMBc=; b=Ved8tk7EVv15
	FlNGeSlVOJrPP4FDWHq3Uo0Lsbudh13HmeG/eXpW5x07Tvb8BoylOOLLeF2GvqlM
	FGD0+JHOqV+16l3qnjcLrohq5KLzDn244gILkJEfbvfB1X+AOfuA0FnTpKcIulyb
	88xmvsDbgdi9hM3k21sGVyGY+kpe0BBF42zTsYSQwFN1nP2qBMi0GVh+rueLp0fU
	l3qPScYwXFcYP0usytcynt2EfeB4kXoWeN0g2ucENr+04fRvB2wtGjxAqDOXtIH3
	dNrDmVN56i8TJKmA3KOReJp5GZ5+iNapCdo75DrXMYTrYGZy7H4IJd+VwZt6Ggde
	cyrZdu6MSA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7e77r4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 09:09:55 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58U8j04R022733;
	Tue, 30 Sep 2025 09:09:55 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7e77r4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 09:09:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58U8eAKh020061;
	Tue, 30 Sep 2025 09:09:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49et8s2rm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 09:09:54 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58U99oTP38470034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 09:09:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 494DD20043;
	Tue, 30 Sep 2025 09:09:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36D6920040;
	Tue, 30 Sep 2025 09:09:50 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.152.212.180])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 30 Sep 2025 09:09:50 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.98.2)
	(envelope-from <bblock@linux.ibm.com>)
	id 1v3WMn-00000000iGP-47IM;
	Tue, 30 Sep 2025 11:09:49 +0200
Date: Tue, 30 Sep 2025 11:09:49 +0200
From: Benjamin Block <bblock@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: s390: Expose the UID as an arch specific PCI slot
 attribute
Message-ID: <20250930090949.GA15786@p1gen4-pw042f0m.boeblingen.de.ibm.com>
References: <20250924-uid_slot-v1-1-09ae04f48c57@linux.ibm.com>
 <20250926142714.GB17059@p1gen4-pw042f0m.boeblingen.de.ibm.com>
 <b8c610fa2ac725364c8e485e948c7bd6efd605fa.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8c610fa2ac725364c8e485e948c7bd6efd605fa.camel@linux.ibm.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: anLfgzOBtdKKQkM0Z2Ta8usHZ4XXk3vR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyMCBTYWx0ZWRfX5Gba03ruZ+U+
 71Z/DJiUBaU+qvI4ApME5w/AzhUgCLa+3eFFk+m1aef+T0jTPwmPBXLUjMaKJDs8xJLMp8relNt
 PHCMiz30wKnfMjWEknHVcFd+pHiC5E2ncR8+fjoz26oTIj4qUhTnkAiVfa0dIsSMjIeCSnxJxBu
 KQOtqe2NGq/QwFE6sXciNB4uo2/NP4tmVQ/BZMmCQBzwtwu9cZsYwgpKMu93g+1DXaVtyxsh0B2
 51r7QzwKj96DqiaX8qMD/sd0XKh0BFGYmuex+1SqG8KcozbYIcW0TfQb9VMqhad2tHSuW1z2mse
 I3BEph6UAw6qw+sUJccn6pzgc69DG+F/zoku7kpCt9FoNISLXYHJK4Z9QM40H2PhzcCAgYwg/+x
 DoCrXTsTH2eeVd8BEMaQ7UZvZVWYMA==
X-Proofpoint-GUID: DJpkWsOD3XE8tA1gEunMbX9Q1-ETNTIO
X-Authority-Analysis: v=2.4 cv=Jvj8bc4C c=1 sm=1 tr=0 ts=68db9e63 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=8nJEP1OIZ-IA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=idd3SK8aOH9gq0nm_TcA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270020

On Fri, Sep 26, 2025 at 08:25:07PM +0200, Niklas Schnelle wrote:
> On Fri, 2025-09-26 at 16:27 +0200, Benjamin Block wrote:
> > > +extern const struct attribute_group zpci_slot_attr_group;
> > > +
> > > +#define ARCH_PCI_SLOT_GROUPS (&zpci_slot_attr_group)
> > 
> > I don't know the history exactly, but this can't be easily extended like the
> > other group above `ARCH_PCI_DEV_GROUPS`.
> > 
> >     (&zpci_slot_attr_group,  \
> >      &zpci_slot_attr_group_b)
> > 
> > Won't compile. The way `ARCH_PCI_DEV_GROUPS` does it, attaching a different
> > group is just adding a new line.
> 
> Without the parenthesis it should. I only added them because otherwise
> checkpatch complains and it's still valid for a single item to have
> parenthesis.

It's not like checkpatch is the last arbiter of truth here, especially sind we
already have a case without parenthesis; but I guess if we ever need to extend
the list, we can remove the parenthesis again.

> > > diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
> > > index 0ee0924cfab7e5d22468fb197ee78cac679d8c13..997dff3796094680d9a3f0b6eb27a89fa1ed30b2 100644
> > > --- a/arch/s390/pci/pci_sysfs.c
> > > +++ b/arch/s390/pci/pci_sysfs.c
> > > @@ -178,6 +178,17 @@ static ssize_t index_show(struct device *dev,
> > >  }
> > >  static DEVICE_ATTR_RO(index);
> > >  
> > > --- snip ---
> > > +{
> > > +	struct zpci_dev *zdev = container_of(slot->hotplug, struct zpci_dev,
> > > +					     hotplug_slot);
> > > +
> > > +	return sysfs_emit(buf, "0x%x\n", zdev->uid);
> > 
> > Do we need a special case for when `uid` is 0? That would imply the uid is
> > invalid, right? Would we want to return an error in that case (-EINVAL, or
> > smth)? 
> > 
> > Also, do we want to use the same format as in `zpci_setup_bus_resources()`
> > with the 4 leading 0's (`0x%04x`)?
> 
> I chose to match the "uid" device attribute here ("zpci_attr(uid,
> "0x%x\n", uid)" in the beginning of the same file).

Ah right, fair enough.

> This doesn't
> special case UID 0. You are right that this is an invalid UID though.
> It also still exposes the UID even if it is not guaranteed to be
> unique. But we'll make that setting known to user-space separately.
> I feel like knowing the UIDs can still be helpful even when they are
> not unique, for example to check that they've been set correctly from
> within Linux before enabling UID Checking.

I don't mind the case where the UID is not checked for uniqueness (the naming
is confusing in any case, since the U doesn't stand for unique), I was just
wondering whether printing an invalid UID makes sense. I think those are
distinct cases. 
It might be easier to 'encode' this knowledge about an UID being "invalid"
here, rather than 'encoding' it in every single user that might read this
attribute.

I guess the same can be said for the old `uid` attribute that is attached to
the PCI device, but that was introduced by Sebastian a long time ago.

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Böblingen     /    Registergericht: AmtsG Stuttgart, HRB 243294

