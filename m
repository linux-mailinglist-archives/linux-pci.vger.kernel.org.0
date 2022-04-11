Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E192C4FB644
	for <lists+linux-pci@lfdr.de>; Mon, 11 Apr 2022 10:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343940AbiDKIqh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Apr 2022 04:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343941AbiDKIqf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2022 04:46:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6475F55;
        Mon, 11 Apr 2022 01:44:19 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23B8cx1N037982;
        Mon, 11 Apr 2022 08:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version; s=pp1; bh=lZg6/NDrtfcKNrz+a4Ul9FSLuVpiXTuAV75sUdv+6eY=;
 b=G7fVx5XmAHBpaMfPbiBMG8gpIPtpjDZfLqTrv0QQocLscJZyRd0sQojB6D4cEUrKojqk
 44F4Q1BGewyudW3hvJoi8x+LZSxX/lw48yH1Kw2ymMvGVxWSJnpWuefgmuqPdthdeAEF
 aXBFx/LBQLiWk+UTOHEKVFjZgv7hayMukh+8wey2/3maVMRG0TMF7prGX5ps/EzXvx7G
 lYOWMogQGN7KKJ+fJ9jEXKO0i2937PURPaBiF2z492S+Wxbkjz7Go6CHdpsHTt+ydY1y
 AR5cDRSOc4KRhBkVHGMLgFBhOuuohXvCFsxp2+O/DZRZ+vstWwj1Vw5tBs4oqNgJ6CS1 GA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fbkm0pkc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Apr 2022 08:44:10 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23B8Wmav016915;
        Mon, 11 Apr 2022 08:44:10 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fbkm0pkbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Apr 2022 08:44:10 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23B8hnve020038;
        Mon, 11 Apr 2022 08:44:07 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3fb1s8j5vq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Apr 2022 08:44:07 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23B8i4ap36176156
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 08:44:04 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A54DCAE056;
        Mon, 11 Apr 2022 08:44:04 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2956CAE04D;
        Mon, 11 Apr 2022 08:44:04 +0000 (GMT)
Received: from sig-9-145-41-213.uk.ibm.com (unknown [9.145.41.213])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Apr 2022 08:44:04 +0000 (GMT)
Message-ID: <e565547113567e9fd6cacce333bc28d2af088b72.camel@linux.ibm.com>
Subject: Re: [PATCH RESEND 1/2] PCI: Extend isolated function probing to s390
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
Date:   Mon, 11 Apr 2022 10:43:56 +0200
In-Reply-To: <20220408224514.GA353445@bhelgaas>
References: <20220408224514.GA353445@bhelgaas>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-PbxZJLOD/wIhH9K18RJQ"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RUsjhSnWXNUrpam3jyZ26HQdZ0XhRKRf
X-Proofpoint-ORIG-GUID: frveAZjDjPJZtCjxpt5nb76WcOKP632S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-11_02,2022-04-08_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 mlxscore=0 phishscore=0
 adultscore=0 mlxlogscore=907 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204110045
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-PbxZJLOD/wIhH9K18RJQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2022-04-08 at 17:45 -0500, Bjorn Helgaas wrote:
> On Mon, Apr 04, 2022 at 11:53:45AM +0200, Niklas Schnelle wrote:
> > Like the jailhouse hypervisor s390's PCI architecture allows passing
> > isolated PCI functions to an OS instance. As of now this is was not
> > utilized even with multi-function support as the s390 PCI code makes
> > sure that only virtual PCI busses including a function with devfn 0 are
> > presented to the PCI subsystem. A subsequent change will remove this
> > restriction.
> >=20
> > Allow probing such functions by replacing the existing check for
> > jailhouse_paravirt() with a new hypervisor_isolated_pci_functions()
> > helper.
> >=20
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>=20
> I'm OK with the idea of generalizing this Jailhouse test, but I wonder
> if this check should be in pci_scan_slot() rather than in
> pci_scan_child_bus_extend().
>=20
> I think the idea is that pci_scan_slot() should find all the functions
> of a device (a.k.a. "slot"), so it's a little weird to have a loop
> calling pci_scan_single_device() for each function in both places.

Yeah, I agree.
>=20
> Currently we never call pcie_aspm_init_link_state() for these
> Jailhouse or s390 functions.  Maybe that's OK (and I think
> pci_scan_slot() is the wrong place to initialize ASPM anyway) but if
> we could move the Jailhouse/s390 checking to pci_scan_slot(), it would
> at least remove the inconsistency.
>=20
> I'm thinking something along the lines of the patch below.  I'm sure
> Jan considered this originally, so maybe there's some reason this
> won't work.

One thing I already noticed is that I think next_fn() may need to be
changed. If pci_ari_enabled(bus) is true, then it immediately returns 0
on dev =3D=3D NULL while if it is false there is an extra check for non-
contiguous multifunction devices. Even then I think on jailhouse() dev-
>multifunction might not be set at that point. This is in contrast to
s390 where we set dev->multifunction based on information provided by
the platform before scanning the bus. So I'll have to be careful not to
create a state where this works on s390 but might not work for
jailhouse.

I also do wonder what the role of the PCI_SCAN_ALL_PCIE_DEVS flag
should be here. At least the comment in only_one_child() sounds a lot
like that flag kind of indicates the same thing.

I'll do some more investigation and testing and report back. I do agree
that there seems to be some potential for cleanup here.

--=-PbxZJLOD/wIhH9K18RJQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSiikNOrnCUNbxSj4j7H22hwInkVgUCYlPqTAAKCRD7H22hwInk
VgRWAP4qwiQe4aUTA4vPUfo5NKahyffwtI33Q201iJaHeS9qaQEAlN2biMrJEtwz
bf48i7vJiJe4mtQqZevG3yBFlUbvwgY=
=Zl25
-----END PGP SIGNATURE-----

--=-PbxZJLOD/wIhH9K18RJQ--

