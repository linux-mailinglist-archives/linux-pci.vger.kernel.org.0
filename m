Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF8435D95C
	for <lists+linux-pci@lfdr.de>; Tue, 13 Apr 2021 09:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238531AbhDMHxa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Apr 2021 03:53:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31498 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238431AbhDMHx1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Apr 2021 03:53:27 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13D7XIZY012031;
        Tue, 13 Apr 2021 03:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=m+wdxi5MN8DBGBoeFXvvoseu/fmM/uh7e5tPhVSbrG4=;
 b=TFOtig7klfEXQbImLmgkgm5U+HgyKVZ0GmiHLVdyqDwoXL8UfSFpqgn8izxWwdMJ7l9b
 stpFD0MK79x0v6LhJDyf1410gsNybHWwfHstC0VaKsdYyTyr4OdsA8P2htdmlCiLLg3X
 pdThUec/ay1zJOLsdp3pVasLjxZKAc2KuL6BgU+2xDDyEd/EwVDRj4ULdKDaimXoM6Ft
 oLNNoBgfevaJaRzINfhSAPMDW2KJ7ApCQKHPz0KG3ZZLXHrpXZiZ+U211Ri+A6TwJVLW
 UWtiIukD7znTAFYEH5sWKqSzt9reW3SmLatWp+driK5kLt9CqVrTCMQIuq0MiZW4yjIa kQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37vk4j924s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 03:53:05 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13D7l4VO027204;
        Tue, 13 Apr 2021 07:53:04 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 37u39hjg8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 07:53:03 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13D7r1io51118380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 07:53:01 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AF8C11C050;
        Tue, 13 Apr 2021 07:53:01 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85CA811C04C;
        Tue, 13 Apr 2021 07:53:00 +0000 (GMT)
Received: from sig-9-145-159-22.de.ibm.com (unknown [9.145.159.22])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 13 Apr 2021 07:53:00 +0000 (GMT)
Message-ID: <34568cb081b9e93eedac32da8af42fa42c60b254.camel@linux.ibm.com>
Subject: Re: [PATCH 0/1] Use of
 =?UTF-8?Q?=2Fsys=2Fbus=2Fpci=2Fdevices=2F=E2=80=A6=2Findex?= for non-SMBIOS
 platforms
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Narendra K <narendra_k@dell.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-netdev@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Date:   Tue, 13 Apr 2021 09:53:00 +0200
In-Reply-To: <YHVJF3M1Nq4iavQl@unreal>
References: <20210412135905.1434249-1-schnelle@linux.ibm.com>
         <YHUujU1o6bdHDfmS@unreal>
         <88c62c2789d5798338736308672867f30d617794.camel@linux.ibm.com>
         <YHVJF3M1Nq4iavQl@unreal>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rCfqPn2tzn16YmHXAMDDSwV-cO1bgyM_
X-Proofpoint-GUID: rCfqPn2tzn16YmHXAMDDSwV-cO1bgyM_
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_03:2021-04-13,2021-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 impostorscore=0 phishscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130052
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2021-04-13 at 10:32 +0300, Leon Romanovsky wrote:
> On Tue, Apr 13, 2021 at 08:57:19AM +0200, Niklas Schnelle wrote:
> > On Tue, 2021-04-13 at 08:39 +0300, Leon Romanovsky wrote:
> > > On Mon, Apr 12, 2021 at 03:59:04PM +0200, Niklas Schnelle wrote:
> > > > Hi Narendra, Hi All,
> > > > 
> > > > According to Documentation/ABI/testing/sysfs-bus-pci you are responsible
> > > > for the index device attribute that is used by systemd to create network
> > > > interface names.
> > > > 
> > > > Now we would like to reuse this attribute for firmware provided PCI
> > > > device index numbers on the s390 architecture which doesn't have
> > > > SMBIOS/DMI nor ACPI. All code changes are within our architecture
> > > > specific code but I'd like to get some Acks for this reuse. I've sent an
> > > > RFC version of this patch on 15th of March with the subject:
> > > > 
> > > >    s390/pci: expose a PCI device's UID as its index
> > > > 
> > > > but got no response. Would it be okay to re-use this attribute for
> > > > essentially the same purpose but with index numbers provided by
> > > > a different platform mechanism? I think this would be cleaner than
> > > > further proliferation of /sys/bus/pci/devices/<dev>/xyz_index
> > > > attributes and allows re-use of the existing userspace infrastructure.
> > > 
> > > I'm missing an explanation that this change is safe for systemd and
> > > they don't have some hard-coded assumption about the meaning of existing
> > > index on s390.
> > > 
> > > Thanks
> > 
> > Sure, good point. So first off yes this change does create new index
> > based names also on existing systemd versions, this is known and
> > intended and we'll certainly closely collaborate with any distributions
> > wishing to backport this change.
> > 
> > As for being otherwise safe or having unintended consequences, Viktor
> > (see R-b) and I recently got the following PR merged in that exact area
> > of systemd to fix how hotplug slot derived interface names are
> > generated:
> > https://github.com/systemd/systemd/pull/19017
> > In working on that we did also analyse the use of the index attribute
> > for hidden assumptions and tested with this attribute added. Arguably,
> > as the nature of that PR shows we haven't had a perfect track record of
> > keeping this monitored but will in the future as PCI based NICs become
> > increasingly important for our platform. We also have special NIC
> > naming logic in the same area for our channel based platform specific
> > NICs which was also contributed by Viktor.
> 
> Thanks, this PR is exciting to read, very warm words were said about
> kernel developers :). Can you please summarize that will be the breakage
> in old systemd if this index will be overloaded?
> 
> Thanks

;-) yeah, maybe us working closely across kernel and systemd will help
improve relations.

In principle the same happens on existing and new systemd i.e. we get
new eno<UID_in_decimal>… interface names. Due to the way naming
priorities work this will become the dominant interface name but thanks
to altname support in current kernels we expect all old settings,
routing rules etc. to remain working with the old name.

This only happens however if the Linux instance is running with active
UID Uniqueness Checking, this is a Hypervisor/Platform setting that
enforces that no PCI device can be attached if one with the same UID is
already attached. So far this setting was hidden inside the kernel but
I recently committed a change to expose it to userspace here:
https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features&id=408f2c9c15682fc21b645fdec1f726492e235c4b

That said, we're also still open for other approaches for example as
floated by Lennart in this comment:
https://github.com/systemd/systemd/pull/18829#discussion_r584794766
But this of course also depends on whether the kernel community is open
to reusing the index attribute or has other preferences.

> 
> > Thanks,
> > Niklas
> > 

