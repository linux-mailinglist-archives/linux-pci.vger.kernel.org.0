Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB11E69F963
	for <lists+linux-pci@lfdr.de>; Wed, 22 Feb 2023 17:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjBVQzO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Feb 2023 11:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjBVQzO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Feb 2023 11:55:14 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B5634016;
        Wed, 22 Feb 2023 08:55:13 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MGBxFf005450;
        Wed, 22 Feb 2023 16:55:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=qNaXY5aZLhTPbDWbbj6yK6XhwLtng0pp6xKbrCD/R3w=;
 b=XqTci3SRB/Tsjd9aOkr2rO7tRx2HmQkTgPjBxEdD1AOwG6WS+8Mh3f08Twhig0id1IgD
 /Quiwk0yO6hIzTckHLeKa7DiRxAwJ/I9PwRtizg+K8OV1/c0yLIMKwCOPv2ElcIrALh0
 BRzPukwye62dXfyb+qOqNfJrI+Crdj8W9Zl2WzPKqgd2o0ZD19cLd6edqQ0HMXUsbLqE
 oDfpL/aWPKs3P2kIZTiFW7grwltmsIkBGSfqkXML6YJ9AAUDhvie+nH3giBjD4kTdh/m
 /MJ5ViyOrFLAiHxW8CW2D22hRQvqTgsvt8WcMQeXTg9q1uUQLtK+gDpHGb93CJ1T9Uqc 8g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwm5k5esc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 16:55:03 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31MG07ii008643;
        Wed, 22 Feb 2023 16:55:03 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwm5k5er1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 16:55:03 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31MB41Oe020283;
        Wed, 22 Feb 2023 16:55:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3ntpa648js-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 16:55:00 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31MGsveg55574942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 16:54:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0045820043;
        Wed, 22 Feb 2023 16:54:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E81120040;
        Wed, 22 Feb 2023 16:54:56 +0000 (GMT)
Received: from [9.171.87.157] (unknown [9.171.87.157])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Feb 2023 16:54:56 +0000 (GMT)
Message-ID: <1793b3cd12921b7a3fa8b3ee7e20b7cf1df1eca1.camel@linux.ibm.com>
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
Date:   Wed, 22 Feb 2023 17:54:55 +0100
In-Reply-To: <1a621a2b836d81d12b6f265f47d93b827e0a82df.camel@linux.ibm.com>
References: <20230217231503.GA3425666@bhelgaas>
         <1a621a2b836d81d12b6f265f47d93b827e0a82df.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mSPqSjbWkuASLouyegHMgEtQ5Kwz-jj2
X-Proofpoint-GUID: a1hmJwYsil-bc-QBDZj1GGxFdhrqfe7i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_06,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 clxscore=1015 mlxscore=0 mlxlogscore=620
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220145
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2023-02-20 at 13:53 +0100, Niklas Schnelle wrote:
> On Fri, 2023-02-17 at 17:15 -0600, Bjorn Helgaas wrote:
> > On Tue, Feb 14, 2023 at 10:49:10AM +0100, Niklas Schnelle wrote:
> >=20
> >=20
---8<---
> > Other random questions unrelated to this patch:
> >=20
> >   - zpci_bus_create_pci_bus() calls pci_bus_add_devices().  Isn't that
> >     pointless?  AFAICT, the bus->devices list is empty then.
>=20
> Yes I think you're right it does nothing and can be dropped.
>=20
> >=20
> >   - What about zpci_bus_scan_device()?  Why does it call both
> >     pci_bus_add_device() and pci_bus_add_devices()?  The latter will
> >     just call the former, so it looks redundant.  And the latter is
> >     locked but not the former?
>=20
> Hmm. great find. This seems to have been weird and redundant since I
> first used that pattern in 3047766bc6ec ("s390/pci: fix enabling a
> reserved PCI function"). I think maybe then the reason for this was
> that prior to 960ac3626487 ("s390/pci: allow zPCI zbus without a
> function zero") when the newly enabled is devfn =3D=3D 0 there could be
> functions from the same bus which would not have been added yet. I'm
> not sure though. That was definitely the idea behind the
> zpci_bus_scan_bus() in zpci_scan_configured_devices() that is also
> redundant now as we can now scan each function as it appears.
>=20
> This will definitely need to be cleaned up.
>=20

I'm working on cleaning this up but I'm a little confused by what
exactly needs to be under the pci_rescan_remove lock. For example the
pci_bus_add_device(virtfn) at the end of pci_iov_add_virtfn() doesn't
seem to be under the lock while most calls to pci_bus_add_devices()
are, most prominently the one in acpi_pci_root_add() which I assume is
what is used on most x86 systems. Any hints?

Also I think my original thought here might have been a premature worry
about PCI-to-PCI bridges thinking that adding the new device could lead
to more devices appearing. Of course actually thinking about it a bit
more there are quite a few other things that won't work without further
changes if we wanted to add bridges e.g. we would need to create
zpci_dev structs for these somewhere.

