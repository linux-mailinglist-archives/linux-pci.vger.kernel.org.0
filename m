Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FAD6B2B29
	for <lists+linux-pci@lfdr.de>; Thu,  9 Mar 2023 17:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjCIQuK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 11:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjCIQtv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 11:49:51 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630DCFCBFB;
        Thu,  9 Mar 2023 08:39:25 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329GWbFD029678;
        Thu, 9 Mar 2023 16:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=WoKGktYRxUw42/yRhVznkwqsMWqSMkRMk0spzj7c6Vw=;
 b=eiK67enU1ipFAdh7cT4eEzcvvpQs6wKu0SN9Lmfd8ihTBwI1RMQIuKeE0ROTu6njtmy5
 aRhESm3zEd2LqKZRUgjwnDXvgdI33ofMBAPakDPOoWrNkxyajhgFL4qzWQcz5+pQfTS5
 b148PO8fJFhGuUMKlKPMlbGmfTP3nGEuWWK+FzCv0UHB7YPRcEYzHXNlCzyt3s4uz7D2
 h3PTo7EFSgiV4EEpfLoV4VEs9EAmD+r5LN/uwWoIBP/yK5mFQBw2fde7biVcA12NLOet
 56lWBiOo12vIPBflrhB90lurgMg8JZfpzS03KUHmZ4U7+S4QeCFtfZQaj47Xh5Y09z8G Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6t3bym40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 16:39:21 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 329GZMjL005382;
        Thu, 9 Mar 2023 16:39:20 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6t3bym3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 16:39:20 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3294LVgL020036;
        Thu, 9 Mar 2023 16:39:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3p6ftvjngh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 16:39:18 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 329GdEMw59048436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Mar 2023 16:39:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEE562004B;
        Thu,  9 Mar 2023 16:39:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28A292004D;
        Thu,  9 Mar 2023 16:39:14 +0000 (GMT)
Received: from [9.171.26.163] (unknown [9.171.26.163])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  9 Mar 2023 16:39:14 +0000 (GMT)
Message-ID: <4c0696c0f02cf5da747a88a40d3f29ba597482ea.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/4] PCI: s390: Fix use-after-free of PCI resources
 with per-function hotplug
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Date:   Thu, 09 Mar 2023 17:39:13 +0100
In-Reply-To: <20230308231449.GA1057317@bhelgaas>
References: <20230308231449.GA1057317@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mqf-Co36suubKcz5uAopTefjSOtTwt1k
X-Proofpoint-ORIG-GUID: PHhJeJiTyC4c7s8uHMpqAjHTt4k_QlpM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_08,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=453 spamscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303090132
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2023-03-08 at 17:14 -0600, Bjorn Helgaas wrote:
> On Mon, Mar 06, 2023 at 04:10:11PM +0100, Niklas Schnelle wrote:
> > On s390 PCI functions may be hotplugged individually even when they
> > belong to a multi-function device. In particular on an SR-IOV device VF=
s
> > may be removed and later re-added.
> >=20
> > In commit a50297cf8235 ("s390/pci: separate zbus creation from
> > scanning") it was missed however that struct pci_bus and struct
> > zpci_bus's resource list retained a reference to the PCI functions MMIO
> > resources even though those resources are released and freed on
> > hot-unplug. These stale resources may subsequently be claimed when the
> > PCI function re-appears resulting in use-after-free.
> >=20
> > One idea of fixing this use-after-free in s390 specific code that was
> > investigated was to simply keep resources around from the moment a PCI
> > function first appeared until the whole virtual PCI bus created for
> > a multi-function device disappears. The problem with this however is
> > that due to the requirement of artificial MMIO addreesses (address
> > cookies) extra logic is then needed to keep the address cookies
> > compatible on re-plug. At the same time the MMIO resources semantically
> > belong to the PCI function so tying their lifecycle to the function
> > seems more logical.
> >=20
> > Instead a simpler approach is to remove the resources of an individuall=
y
> > hot-unplugged PCI function from the PCI bus's resource list while
> > keeping the resources of other PCI functions on the PCI bus untouched.
> >=20
> > This is done by introducing pci_bus_remove_resource() to remove an
> > individual resource. Similarly the resource also needs to be removed
> > from the struct zpci_bus's resource list. It turns out however, that
> > there is really no need to add the MMIO resources to the struct
> > zpci_bus's resource list at all and instead we can simply use the
> > zpci_bar_struct's resource pointer directly.
> >=20
> > Fixes: a50297cf8235 ("s390/pci: separate zbus creation from scanning")
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>=20
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>=20
> The meat of this is mostly in s390, so I think it makes more sense to
> merge via that tree.  But let me know if you'd rather that I take it.
>=20
>=20

Thanks for taking a look and the valuable suggestions. I'll coordinate
with Vasily to take this via the s390 tree. As for the locking I agree
it is out of scope for this series. Meant more that the resource
handling might be a good place to start splitting up the
pci_rescan_remove_lock and that I might take a look at that if I find
the time which of course we're all lacking.

Regards,
Niklas
