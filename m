Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D756A552F
	for <lists+linux-pci@lfdr.de>; Tue, 28 Feb 2023 10:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjB1JI6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Feb 2023 04:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjB1JI5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Feb 2023 04:08:57 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4F1AA;
        Tue, 28 Feb 2023 01:08:56 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S8jQ7U021748;
        Tue, 28 Feb 2023 09:08:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=MBGv+RkVm2JThfrORlWXiDQ4x2zWBVkczC0frWJIKkQ=;
 b=FVnv2r47BcFsn/W1VhaoQobcXqCJ+i25Fxg21FGxR6Vfmky8FjDChBl+ZeFbqznW0e3H
 oJc0nulwmEQz5N2Ja4D6aPPu4VICdiy4DwXXskepPmD0NEyQSN6BPpbLeXV/GlVng5gE
 9dnvZYT/UyThTmXufVeqwuol8ds5tNWQJ1TwG/nrWGTF6Ht1edPDd7uPoG0akARgMz4i
 fciTNYZ6HwLpjzcRYRRYyxoDSOxRm1OSE5znBu1oM0Hv6ZoqZJNAN1KqQHtC+KJ4FSIf
 8ogNOt/OktMOBpFVDUfvpZw5txq12glgEabJYqZlmONRaNkGEt+tJDz0pAKneHRMhlK7 FA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p1ecs0mhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 09:08:53 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31S8vBBa021113;
        Tue, 28 Feb 2023 09:08:52 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p1ecs0mgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 09:08:52 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31S0n45w027740;
        Tue, 28 Feb 2023 09:08:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3nybdbj2k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 09:08:50 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31S98k9r32243998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 09:08:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 250492004B;
        Tue, 28 Feb 2023 09:08:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5660F20040;
        Tue, 28 Feb 2023 09:08:45 +0000 (GMT)
Received: from [9.171.11.239] (unknown [9.171.11.239])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 28 Feb 2023 09:08:45 +0000 (GMT)
Message-ID: <5bf4ca0f643bcd59f5761cdd29403433046a9995.camel@linux.ibm.com>
Subject: Re: [PATCH RESEND] PCI: s390: Fix use-after-free of PCI bus
 resources with s390 per-function hotplug
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Date:   Tue, 28 Feb 2023 10:08:45 +0100
In-Reply-To: <20230224041918.GB26067@wunner.de>
References: <1793b3cd12921b7a3fa8b3ee7e20b7cf1df1eca1.camel@linux.ibm.com>
         <20230223195345.GA3805039@bhelgaas> <20230224041918.GB26067@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: slyU2UR1UvbJ0jrXrx0EFxjN54W8tzOA
X-Proofpoint-ORIG-GUID: b-7OGtgecDGsvxQZly198Rh_Hivik3u3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-28_05,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 bulkscore=0 phishscore=0 adultscore=0 mlxlogscore=800 priorityscore=1501
 impostorscore=0 suspectscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280072
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2023-02-24 at 05:19 +0100, Lukas Wunner wrote:
> On Thu, Feb 23, 2023 at 01:53:45PM -0600, Bjorn Helgaas wrote:
> > Hmm.  Good question.  Off the top of my head, I can't explain the
> > difference between pci_rescan_remove_lock and pci_bus_sem, so I'm
> > confused, too.  I added Lukas in case he has a ready explanation.
>=20
> pci_bus_sem is a global lock which protects the "devices" list of all
> pci_bus structs.
>=20
> We do have a bunch of places left where the "devices" list is accessed
> without holding pci_bus_sem, though I've tried to slowly eliminate
> them.
>=20
> pci_rescan_remove_lock is a global "big kernel lock" which serializes
> any device addition and removal.
>=20
> pci_rescan_remove_lock is known to be far too course-grained and thus
> deadlock-prone, particularly if hotplug ports are nested (as is the
> case with Thunderbolt).  It needs to be split up into several smaller
> locks which protect e.g. allocation of resources of a bus (bus numbers
> or MMIO / IO space) and whatever else needs to be protected.  It's just
> that nobody has gotten around to identify what exactly needs to be
> protected, adding the new locks and removing pci_rescan_remove_lock.
>=20
> Thanks,
>=20
> Lukas

Thanks for the insights. So from that description I think it might make
sense to do this fix patch with the pci_rescan_remove_lock so it can be
backported. Then we can take the opportunity to add a lock specific to
the allocation/freeing of resources which would then replace at least
this new directly and clearly resource related use of
pci_rescan_remove_lock and potentially others we find.
What do you think?

Thanks,
Niklas
