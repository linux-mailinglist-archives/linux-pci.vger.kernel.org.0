Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442306A073A
	for <lists+linux-pci@lfdr.de>; Thu, 23 Feb 2023 12:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjBWLWT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Feb 2023 06:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjBWLWS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2023 06:22:18 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA9C72B6;
        Thu, 23 Feb 2023 03:22:17 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NBIpwP030974;
        Thu, 23 Feb 2023 11:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=7WAigvkJ5FUoqvJ2NZwb+B2Cx0WAB2q72NLd4ixJhuo=;
 b=Z+O52jamNORL2/FJytKeX5yb4zr0FfOEO43v1gvJK5Oan8GSYV/Ko4xRTtkYLzPhyAbd
 Wegar3m5tHwIeMF5O90F6ufX7371X8jeNynszDYCfO1HXhoz9rwqB1VS1/BGPzqtMD3Z
 Yu2N8IXBFLwhx17mFS7n8vPv1g6xq0nq4pOEXd7zCcqID7cWd6sIhVckDqPqQuFebnz5
 00KPyW+d8ez+Z6RMbvcVdUaGuuHJPxuS/Hu9A1E1QnoF+hnmSkvrqyNKATA70O0FQGmV
 P3ZDwL1PvbpitTxClnaxEtBBXpHNW03gHsNa/7CdAQZyMn3fpktxm9tqnrnYXe2UJpKg 0w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nx2swy34c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 11:22:14 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31NBMEha016635;
        Thu, 23 Feb 2023 11:22:14 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nx2swy33r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 11:22:13 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31MJMx0T018945;
        Thu, 23 Feb 2023 11:22:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3ntpa6ek2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 11:22:11 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31NBM8Fl33948100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Feb 2023 11:22:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDFF220043;
        Thu, 23 Feb 2023 11:22:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 044152004E;
        Thu, 23 Feb 2023 11:22:07 +0000 (GMT)
Received: from [9.171.85.235] (unknown [9.171.85.235])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 23 Feb 2023 11:22:06 +0000 (GMT)
Message-ID: <3a41947fe19bfd655cecd7f6573ce3c3b4cb2a56.camel@linux.ibm.com>
Subject: Re: [PATCH RESEND] PCI: s390: Fix use-after-free of PCI bus
 resources with s390 per-function hotplug
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Date:   Thu, 23 Feb 2023 12:22:06 +0100
In-Reply-To: <20230222220220.GA3804275@bhelgaas>
References: <20230222220220.GA3804275@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MWQI12DVzmpjdeN5xz-LFx-HUm5cZ4Ag
X-Proofpoint-ORIG-GUID: rdahhXCP9ha6_DH2ov02VDuYlkuldo_r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_06,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxlogscore=927 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302230093
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2023-02-22 at 16:02 -0600, Bjorn Helgaas wrote:
> On Mon, Feb 20, 2023 at 01:53:34PM +0100, Niklas Schnelle wrote:
> > On Fri, 2023-02-17 at 17:15 -0600, Bjorn Helgaas wrote:
> > > On Tue, Feb 14, 2023 at 10:49:10AM +0100, Niklas Schnelle wrote:
> > > > ...
>=20
> > >     What happens when zpci_bus_release() calls
> > >     pci_free_resource_list() on &zbus->resources?  It looks like that
> > >     ultimately calls kfree(), which is OK for the
> > >     zpci_setup_bus_resources() stuff, but what about the
> > >     zbus->bus_resource that was not kalloc'ed?
> >=20
> > As far as I can see pci_free_resource_list() only calls kfree() on the
> > entry not on entry->res. The resources set up in
> > zpci_setup_bus_resources() are freed in zpci_cleanup_bus_resources()
> > explicitly.
>=20
> So I guess the zbus->resources are allocated in zpci_bus_scan_device()
> where zpci_setup_bus_resources() adds a zbus resource for every
> zpci_dev BAR, and freed in zpci_bus_release() when the last zpci_dev
> is unregistered.

Only the zbus->resources list itself is freed in zpci_bus_release() the
resources for the BARs of each zpci_dev are freed in
zpci_cleanup_bus_resources() when the individual zpci_dev is removed.

>=20
> Does that mean that if you add device A, add device B, and remove A,
> the zbus retains A's resources even though A is gone?  What if you
> then add device C whose resources partially overlap A's?
>=20
> > >=20

No. Prior to the proposed patch pci_bus::resources/pci_bus::resource[]
and zpci_bus::resources would retain dangling pointers to the BAR
resources of A while the BAR resource itself was already freed when A
is removed. This is the use-after-free this patch is trying to fix.

The BAR resource freeing happens when zpci_cleanup_bus_resources() is
called in zpci_release_device() once the reference count for the struct
zpci_dev hits 0. With this patch this stays the same but we're a)
removing the resource pointer from pci_bus::resources /
pci_bus::resource[] and never adding it to zpci_bus::resources. Meaning
with this patch zpci_bus::resources doesn't store BAR resources at all
and is only used for the IORESOURCE_BUS the BAR resources are instead
only referenced by zpci_dev::bars[bar_num].res and pci_bus::resources /
pci_bus::resource[i].

I don't think we can get overlapping resources but this way the
resource structs are freed when the device (PCI function) goes away
which is also when they become inaccessible for our PCI load/store
instructions.

