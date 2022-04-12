Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE05B4FE072
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 14:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353218AbiDLMke (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 08:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355163AbiDLMjA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 08:39:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EAC5DA1A;
        Tue, 12 Apr 2022 04:59:25 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23CBBsTA003228;
        Tue, 12 Apr 2022 11:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version; s=pp1; bh=yHu1YiMcXBjBiYCzq1CRcs/NYWRxbRqI7csqw43nT/E=;
 b=gtvJUdIoEG7Dtqpo4Y2aupeGoyhQm9qX3OF/eisKWwypGhYoraNOoM0N60QX1jUh0apB
 sLw8c8EPctwjvGtMATUpMsS/2WyDjA85uAY/5RdhnhFEpBcSQMvVpzeu2tCIwvR+Mqj9
 ntH1DxSEVdO4y3sTzs5jHjiakF6d0Np5zza/z9p4wKSb5vWjc9NG1gXDMpTQFfMcrRmC
 JfhWoZ7gh9tdiv+R1x/mgQeWx3mTsi2MdadNNZZqfq3SOmjpcAZQqpPNihglzMcQySLq
 GxgxCpdGLUGSy12Y+iBdHtvN+6Xt6166Al30Nc4rcvXRSMtEF7/ePBevUt6T11Uj9E8H wA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fd8b611wq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 11:59:20 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23CBi6GN028860;
        Tue, 12 Apr 2022 11:59:19 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fd8b611w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 11:59:19 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23CBbwfw007739;
        Tue, 12 Apr 2022 11:59:17 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3fb1s8vty9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 11:59:17 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23CBxEG638666662
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 11:59:14 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3ABA42041;
        Tue, 12 Apr 2022 11:59:13 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78C734203F;
        Tue, 12 Apr 2022 11:59:13 +0000 (GMT)
Received: from sig-9-145-31-85.uk.ibm.com (unknown [9.145.31.85])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Apr 2022 11:59:13 +0000 (GMT)
Message-ID: <d4c7aca9c662c3d99886abfd948e5c8590e43ab6.camel@linux.ibm.com>
Subject: Re: [PATCH RESEND 1/2] PCI: Extend isolated function probing to s390
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
Date:   Tue, 12 Apr 2022 13:59:06 +0200
In-Reply-To: <20220411192312.GA531449@bhelgaas>
References: <20220411192312.GA531449@bhelgaas>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-1ip2eaNreskyjKOkjE3X"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y2WKxO9Mx-nRK3GWErvugW2hRsJJdE7M
X-Proofpoint-ORIG-GUID: Muh2p9oWtiuthkmbn0CcLwTFVfptA2YQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-12_03,2022-04-12_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204120053
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-1ip2eaNreskyjKOkjE3X
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2022-04-11 at 14:23 -0500, Bjorn Helgaas wrote:
> On Mon, Apr 11, 2022 at 10:43:56AM +0200, Niklas Schnelle wrote:
> > On Fri, 2022-04-08 at 17:45 -0500, Bjorn Helgaas wrote:
> > > On Mon, Apr 04, 2022 at 11:53:45AM +0200, Niklas Schnelle wrote:
> > > > Like the jailhouse hypervisor s390's PCI architecture allows passin=
g
> > > > isolated PCI functions to an OS instance. As of now this is was not
> > > > utilized even with multi-function support as the s390 PCI code make=
s
> > > > sure that only virtual PCI busses including a function with devfn 0=
 are
> > > > presented to the PCI subsystem. A subsequent change will remove thi=
s
> > > > restriction.
> > > >=20
> > > > Allow probing such functions by replacing the existing check for
> > > > jailhouse_paravirt() with a new hypervisor_isolated_pci_functions()
> > > > helper.
> > > >=20
> > > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > >=20
> > > I'm OK with the idea of generalizing this Jailhouse test, but I wonde=
r
> > > if this check should be in pci_scan_slot() rather than in
> > > pci_scan_child_bus_extend().
> > >=20
> > > I think the idea is that pci_scan_slot() should find all the function=
s
> > > of a device (a.k.a. "slot"), so it's a little weird to have a loop
> > > calling pci_scan_single_device() for each function in both places.
> >=20
> > Yeah, I agree.
> > > Currently we never call pcie_aspm_init_link_state() for these
> > > Jailhouse or s390 functions.  Maybe that's OK (and I think
> > > pci_scan_slot() is the wrong place to initialize ASPM anyway) but if
> > > we could move the Jailhouse/s390 checking to pci_scan_slot(), it woul=
d
> > > at least remove the inconsistency.
> > >=20
> > > I'm thinking something along the lines of the patch below.  I'm sure
> > > Jan considered this originally, so maybe there's some reason this
> > > won't work.
> >=20
> > One thing I already noticed is that I think next_fn() may need to be
> > changed. If pci_ari_enabled(bus) is true, then it immediately returns 0
> > on dev =3D=3D NULL while if it is false there is an extra check for non=
-
> > contiguous multifunction devices. Even then I think on jailhouse() dev-
> > > multifunction might not be set at that point. This is in contrast to
> > s390 where we set dev->multifunction based on information provided by
> > the platform before scanning the bus. So I'll have to be careful not to
> > create a state where this works on s390 but might not work for
> > jailhouse.
> >=20
> > I also do wonder what the role of the PCI_SCAN_ALL_PCIE_DEVS flag
> > should be here. At least the comment in only_one_child() sounds a lot
> > like that flag kind of indicates the same thing.
>=20
> I looked at PCI_SCAN_ALL_PCIE_DEVS, too, but I think that's for a
> slightly different situation; see
> https://git.kernel.org/linus/284f5f9dbac1
>=20
> Bjorn

Thanks for the link. I did some more investigating and testing. I think
I understand it now but I have to say I did struggle a little with the
whole pci_scan_slot()/next_fn() logic.

The most interesting to me is how I think the following check in
next_fn() actually has multiple uses that weren't clear to me on first
glance:

	/* dev may be NULL for non-contiguous multifunction devices */
	if (!dev || dev->multifunction)
		return (fn + 1) % 8;

First it does cover the case mentioned in the comment where a=20
multifunction device has some functions missing making it non-
contiguous. As I understand it this case is also triggered on s390 when
we "powered off" some of the VFs of a SR-IOV device where both the PFs
and VFs are under the control of Linux but enumeration is done by
firmware and that can hide some of the VFs.

Secondly assuming we have a call of pci_scan_slot(bus, 0) and no ARI
this check also makes sure that the next_fn(bus, dev, 0) call that
initializes fn in the loop returns 0 unless dev->multifunction is set
so we only enter the loop and look for more functions if the devfn 0
device is multifunction. I found this a bit non obvious. Also I
personally don't like that next_fn() returns 0 which is a valid fn to
indicate no more functions and that the handling of the first function
duplicates the code in the loop for the other functions.

The first point also means that your proposal of allowing
dev =3D=3D NULL for the first function if jailhouse_paravirt() respectively
hypervisor_isolated_pci_functions() is set indeed works as far as I can
tell from the s390 case. That made me wonder though. If we instead
unconditionally allow the first function to be missing (dev =3D=3D NULL)
then we don't even need the extra chek for isolated PCI functions. I'm
assuming though we can't do that as we would then waste time scanning
all function of empty downstream ports?

It's a bit of a larger cleanup but I think I will send a patch to
propose changing things around such that the first function is handled
in the loop of pci_scan_slot() too and that next_fn() returns -ENODEV
if there are no more functions. That will also make things more
readable (to me) and commented the cases where we know that we're done
looking. Then a second patch can pull the jailhouse/s390 special case
into pci_scan_slot().

Thanks,
Niklas

--=-1ip2eaNreskyjKOkjE3X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSiikNOrnCUNbxSj4j7H22hwInkVgUCYlVpigAKCRD7H22hwInk
Vr9VAQCW2W/D94YrYhOitc7fmElPM7yxyJJnNRpzdiawAVhIPQD/RYYotOrlXumS
YKoN3Qgf2vjZF7G4gv453E/2wT66SgY=
=Y6rV
-----END PGP SIGNATURE-----

--=-1ip2eaNreskyjKOkjE3X--

