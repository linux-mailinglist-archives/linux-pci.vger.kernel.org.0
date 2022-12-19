Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEF26509EC
	for <lists+linux-pci@lfdr.de>; Mon, 19 Dec 2022 11:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiLSKR0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Dec 2022 05:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiLSKRZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Dec 2022 05:17:25 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D191A444
        for <linux-pci@vger.kernel.org>; Mon, 19 Dec 2022 02:17:24 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJA1ULk024916;
        Mon, 19 Dec 2022 10:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=FDRrcmNq7RAmDy/oZRTu56VfdjeA7Nks2Fzu0Zwc4PI=;
 b=I7WdDJkA9ACV0N9vfD+E85NDL/MdfRF/cusi2ojn1HNdHcvGHyL7f/mtEdUEDIMqTMBr
 aEH1FsaFF+iFLNZueSibkY1txuD0ty2IzJMyxNj86YgM5z1fvD73BmivzjlLUNXX+uTz
 oyIoVlQBtBrMUdGgyUAoAkdHK5W0iwn7na8GF+s51c3mFo+sBsOvfNn5em6orU2JY/yH
 NDpt00WIs0XIcCPreO1XI1GUOi6MJAjge3IpGGbvZANgWRfsqY/EdJYj9lZtqyDAz1S6
 /DYK/20OqhWjGQkJp98cvpUr1jj04o7oXhZh8TtrlsmuAnT+6Y+lX0QaLgn+YXkb9SmS hA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mjnudgcaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 10:16:58 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BJA1bhU025300;
        Mon, 19 Dec 2022 10:16:57 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mjnudgca2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 10:16:57 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJ2YpeP014025;
        Mon, 19 Dec 2022 10:16:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3mh6yw29y6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 10:16:55 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BJAGqqb52756956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Dec 2022 10:16:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3AB22004E;
        Mon, 19 Dec 2022 10:16:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6EBC72004D;
        Mon, 19 Dec 2022 10:16:52 +0000 (GMT)
Received: from [9.155.211.163] (unknown [9.155.211.163])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 19 Dec 2022 10:16:52 +0000 (GMT)
Message-ID: <e7df748cf89dd368f281012214d15aa74f63ee07.camel@linux.ibm.com>
Subject: Re: [PATCH] PCI/IOV: "virtfn4294967295\0" requires 17 bytes
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>,
        "Alexey V. Vissarionov" <gremlin@altlinux.org>
Cc:     Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        Yu Zhao <yu.zhao@intel.com>, linux-pci@vger.kernel.org,
        lvc-project@linuxtesting.org
Date:   Mon, 19 Dec 2022 11:16:52 +0100
In-Reply-To: <Y5+R7DUZFaFNEeza@casper.infradead.org>
References: <20221218033347.23743-1-gremlin@altlinux.org>
         <Y57x/iCSkdtU3kov@rocinante> <20221218122139.GA1182@altlinux.org>
         <Y5+R7DUZFaFNEeza@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: u1hpuIdB39uLexsQpHsXCztyE619xmni
X-Proofpoint-GUID: VRdPepZrXZES2TIIERkDhOEXjQOZxgoi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-18_13,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 mlxlogscore=490 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212190089
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 2022-12-18 at 22:19 +0000, Matthew Wilcox wrote:
> On Sun, Dec 18, 2022 at 03:21:39PM +0300, Alexey V. Vissarionov wrote:
> > On 2022-12-18 19:57:02 +0900, Krzysztof Wilczy=C5=84ski wrote:
> >=20
> >  > Thank you for sending the patch over! However, if possible,
> >  > can you send it as plain text without any multi-part MIME
> >  > involved?
> >=20
> > ACK.
> >=20
> >  > If possible, it would be nice to mention that this needed
> >  > to make sure that there is enough space to correctly
> >  > NULL-terminate the ID string.
> >=20
> > ACK.
> >=20
> > So, here goes the corrected text:
> >=20
> > Although unlikely, the 'id' value may be as big as 4294967295
> > (uint32_max) and "virtfn4294967295\0" would require 17 bytes
> > instead of 16 to make sure that buffer has enough space to
> > properly NULL-terminate the ID string.
>=20
> Wait, what?  How can we get to a number that large for the virtual
> function ID?  devfn is 8 bits, bus is a further 8 bits.  Sure, domain
> is an extra 16 bits on top of that but I'm pretty sure that virtual
> functions can't span multiple domains.  Unless that's changed recently?
>=20
> Even if they can, we'd need to span 2^14 domains to get up to a billion
> IDs.  That's a hell of a system and I think overflowing here is the
> least of our problems.
>=20
> So while this is typed as u32, I don't think it can get anywhere close.

While we can't realistically get such high IDs on s390 at the moment
it's important to note that we do use the PCI domains differently and
will use the entire 16 bit namespace. As s390 aka mainframes always has
a virtualization layer which does the PCI enumeration for us and just
presents us with single PCI functions from which we reconstruct a PCI
hiearchy. Historically the only PCI devices available were Virtual
Functions which then use bus and devfn 0 with either an incrementing or
user defined domain ID as virtual PCI domain. Meaning that
"ffff:00:00.0" can and does occur. Since commit d1379279f2d6b
("s390/pci: Handling multifunctions") we may also present multiple
functions under the same domain with the a local topology matching the
hardware, though currently limited to a single fixed bus 0, but still
with a virtual and user defined domain ID. So at least on s390 we would
"only" need 2^16 VFs to see ffff:ff:ff.f.

That said, as far as I can tell this wouldn't actually create a virtfn
ID of such a high value as I don't think the domain actually plays into
that. For example with the following (sub) topology of 2 PFs with 4 VFs
each:

 +-[0008:00]-+-00.0  Mellanox Technologies MT28800 Family [ConnectX-5 Ex]
 |           +-00.1  Mellanox Technologies MT28800 Family [ConnectX-5 Ex]
 |           +-00.2  Mellanox Technologies MT28800 Family [ConnectX-5 Ex Vi=
rtual Function]
 |           +-00.3  Mellanox Technologies MT28800 Family [ConnectX-5 Ex Vi=
rtual Function]
 |           +-00.4  Mellanox Technologies MT28800 Family [ConnectX-5 Ex Vi=
rtual Function]
 |           +-00.5  Mellanox Technologies MT28800 Family [ConnectX-5 Ex Vi=
rtual Function]
 |           +-08.2  Mellanox Technologies MT28800 Family [ConnectX-5 Ex Vi=
rtual Function]
 |           +-08.3  Mellanox Technologies MT28800 Family [ConnectX-5 Ex Vi=
rtual Function]
 |           +-08.4  Mellanox Technologies MT28800 Family [ConnectX-5 Ex Vi=
rtual Function]
 |           \-08.5  Mellanox Technologies MT28800 Family [ConnectX-5 Ex Vi=
rtual Function]

I actually get:

# ls -l /sys/bus/pci/devices/0008\:00\:00.0/virtfn*
... /sys/bus/pci/devices/0008:00:00.0/virtfn0 -> ../0008:00:00.2
... /sys/bus/pci/devices/0008:00:00.0/virtfn1 -> ../0008:00:00.3
... /sys/bus/pci/devices/0008:00:00.0/virtfn2 -> ../0008:00:00.4
... /sys/bus/pci/devices/0008:00:00.0/virtfn3 -> ../0008:00:00.5

# ls -l /sys/bus/pci/devices/0008\:00\:00.1/virtfn*
... /sys/bus/pci/devices/0008:00:00.1/virtfn0 -> ../0008:00:08.2
... /sys/bus/pci/devices/0008:00:00.1/virtfn1 -> ../0008:00:08.3
... /sys/bus/pci/devices/0008:00:00.1/virtfn2 -> ../0008:00:08.4
... /sys/bus/pci/devices/0008:00:00.1/virtfn3 -> ../0008:00:08.5

Thanks,
Niklas
