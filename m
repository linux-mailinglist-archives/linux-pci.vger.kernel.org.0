Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE3735D85F
	for <lists+linux-pci@lfdr.de>; Tue, 13 Apr 2021 09:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345145AbhDMG5x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Apr 2021 02:57:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24456 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1345166AbhDMG5r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Apr 2021 02:57:47 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13D6XcJO017030;
        Tue, 13 Apr 2021 02:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=wfGBjbDgG1oEUZ1VK7iNc4tMkpGi4D3LcN0jWjA/f9I=;
 b=tNKW0g6fQVzLpXRZPdR7Wv5Xe+xz7qTOF6crdVsw624EDaoA430BV/w1Xxv4bBJdKMrd
 j6RlH0A6ydR/nvNPnBn69/jE2Kj2HUFD+gbbjD1vxfHmhud9x7xWIyyzcK2GWPKlPbXb
 NBbV6lr02wOuoCrmr+mlCgSYT+rw6dYptW0KUGxKoOF4qu1m7H5tXmA2hhq++H4n4R8p
 rWBAIwGk13F+coMafRzfZ4NQZnLa0dUIEdfrLsRe0QZcNfXzU3FUo2B5xXo0kdfXTfEK
 ButNbcQuvnsUkK7sD54W7/FqCUzrbxBD29AMWJYJNHFtjaXW9TNJHNIEYhX7d+MQGY3H Qw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37vtnswsp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 02:57:25 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13D6ps6E008247;
        Tue, 13 Apr 2021 06:57:24 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 37u3n8h9gb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 06:57:23 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13D6uwna33358292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 06:56:58 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A28524C040;
        Tue, 13 Apr 2021 06:57:20 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 286DE4C058;
        Tue, 13 Apr 2021 06:57:20 +0000 (GMT)
Received: from sig-9-145-159-22.de.ibm.com (unknown [9.145.159.22])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 13 Apr 2021 06:57:20 +0000 (GMT)
Message-ID: <88c62c2789d5798338736308672867f30d617794.camel@linux.ibm.com>
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
Date:   Tue, 13 Apr 2021 08:57:19 +0200
In-Reply-To: <YHUujU1o6bdHDfmS@unreal>
References: <20210412135905.1434249-1-schnelle@linux.ibm.com>
         <YHUujU1o6bdHDfmS@unreal>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gele9Ca_pxdoc31XAH_rNTQyTvycxGQD
X-Proofpoint-ORIG-GUID: gele9Ca_pxdoc31XAH_rNTQyTvycxGQD
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_03:2021-04-13,2021-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 impostorscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130044
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2021-04-13 at 08:39 +0300, Leon Romanovsky wrote:
> On Mon, Apr 12, 2021 at 03:59:04PM +0200, Niklas Schnelle wrote:
> > Hi Narendra, Hi All,
> > 
> > According to Documentation/ABI/testing/sysfs-bus-pci you are responsible
> > for the index device attribute that is used by systemd to create network
> > interface names.
> > 
> > Now we would like to reuse this attribute for firmware provided PCI
> > device index numbers on the s390 architecture which doesn't have
> > SMBIOS/DMI nor ACPI. All code changes are within our architecture
> > specific code but I'd like to get some Acks for this reuse. I've sent an
> > RFC version of this patch on 15th of March with the subject:
> > 
> >    s390/pci: expose a PCI device's UID as its index
> > 
> > but got no response. Would it be okay to re-use this attribute for
> > essentially the same purpose but with index numbers provided by
> > a different platform mechanism? I think this would be cleaner than
> > further proliferation of /sys/bus/pci/devices/<dev>/xyz_index
> > attributes and allows re-use of the existing userspace infrastructure.
> 
> I'm missing an explanation that this change is safe for systemd and
> they don't have some hard-coded assumption about the meaning of existing
> index on s390.
> 
> Thanks


Sure, good point. So first off yes this change does create new index
based names also on existing systemd versions, this is known and
intended and we'll certainly closely collaborate with any distributions
wishing to backport this change.

As for being otherwise safe or having unintended consequences, Viktor
(see R-b) and I recently got the following PR merged in that exact area
of systemd to fix how hotplug slot derived interface names are
generated:
https://github.com/systemd/systemd/pull/19017
In working on that we did also analyse the use of the index attribute
for hidden assumptions and tested with this attribute added. Arguably,
as the nature of that PR shows we haven't had a perfect track record of
keeping this monitored but will in the future as PCI based NICs become
increasingly important for our platform. We also have special NIC
naming logic in the same area for our channel based platform specific
NICs which was also contributed by Viktor.

Thanks,
Niklas

