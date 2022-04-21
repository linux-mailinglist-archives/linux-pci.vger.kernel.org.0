Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E201509E61
	for <lists+linux-pci@lfdr.de>; Thu, 21 Apr 2022 13:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388757AbiDULRz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Apr 2022 07:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388791AbiDULRt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Apr 2022 07:17:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D421364E6;
        Thu, 21 Apr 2022 04:14:59 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23L9PE7p017167;
        Thu, 21 Apr 2022 11:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version; s=pp1; bh=LdztdQlLn0Rd+xg/HChzSo+wwKFNP1uRvcYshiavi4o=;
 b=pAS/zEM/5FbiHt+q42F7vVYqT4F1QtHxzgenbPN415CI82XNxaUiY+R702soxrEG4vth
 CseFNhbiwwAzGjtwsn1x24ZOX8I0u2KSOzxEvT5Xr+pZWfZJlFTa/RWNot7Gpgy5wYfB
 FbrX9BQwi4rbeY8YuESS56LrCABUs11xt8ppf55kZuwf2BYhjV0c1kt+fC1LLjkbgRiT
 o+9/vWLRYRD7AHjsiq65HUf3OZw3FsXvLw4P67XFkaHjn45Z0cKxzjL5mQnLgbeHcIYz
 4USyf7pN6b/PPWD16lcK4M8yOAuy6jBqv8LQU/uVQAWv1niVkdmu5eoItxDN+/tAkcpG qQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fjm2hw7m0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Apr 2022 11:14:55 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23LAjwbe029904;
        Thu, 21 Apr 2022 11:14:54 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fjm2hw7ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Apr 2022 11:14:54 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23LBDwl2020193;
        Thu, 21 Apr 2022 11:14:52 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3fgu6u4kja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Apr 2022 11:14:52 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23LBEngS51904966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Apr 2022 11:14:49 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00F9D5204F;
        Thu, 21 Apr 2022 11:14:49 +0000 (GMT)
Received: from sig-9-145-44-250.uk.ibm.com (unknown [9.145.44.250])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6B1CD5204E;
        Thu, 21 Apr 2022 11:14:48 +0000 (GMT)
Message-ID: <18d8cc4875244211e3a89ae55f28abc9a73270b9.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/4] PCI: Clean up pci_scan_slot()
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
Date:   Thu, 21 Apr 2022 13:14:42 +0200
In-Reply-To: <8225cf74d6d81c3ce149d677b5bf47689d8e3fd2.camel@linux.ibm.com>
References: <20220421021446.GA1356365@bhelgaas>
         <8225cf74d6d81c3ce149d677b5bf47689d8e3fd2.camel@linux.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Ms39hFMWmUk7Ygg8vUOB"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y82B1RCJ5EIHzQlvmWW5khAxT5_BB-Cu
X-Proofpoint-ORIG-GUID: GJCGy3Wuh_432N_YDtCei6XSbFVmfjQV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_06,2022-04-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 suspectscore=0 mlxlogscore=674 spamscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204210062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-Ms39hFMWmUk7Ygg8vUOB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > > +	return (fn <=3D 6) ? fn + 1 : -ENODEV;
> > >  }
> > > =20
> > >  static int only_one_child(struct pci_bus *bus)
> > > @@ -2643,24 +2645,19 @@ static int only_one_child(struct pci_bus *bus=
)
> > >   */
> > >  int pci_scan_slot(struct pci_bus *bus, int devfn)
> > >  {
> > > -	unsigned int fn, nr =3D 0;
> > > -	struct pci_dev *dev;
> > > +	int fn, nr =3D 0;
> > > +	struct pci_dev *dev =3D NULL;
> > > =20
> > >  	if (only_one_child(bus) && (devfn > 0))
> > >  		return 0; /* Already scanned the entire slot */
> > > =20
> > > -	dev =3D pci_scan_single_device(bus, devfn);
> > > -	if (!dev)
> > > -		return 0;
> > >=20

As it might not have been clear in my previous mail. The above !dev
test just for the "devfn + 0" case is equivalent to the new:

if (!dev && fn =3D=3D 0)
	return -ENODEV;

As fn doesn't wrap around anymore fn =3D=3D 0 is true only for the first
iteration. Both in the existing and in the changed code the first
pci_scan_single_device() happens before the first next_fn() call though
with the new code that then breaks the loop instead of the above
return. This makes sense in my mind because if the first function
doesn't exist there are no more functions except if we have isolated
PCI functions due to a hypervisor.

--=-Ms39hFMWmUk7Ygg8vUOB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSiikNOrnCUNbxSj4j7H22hwInkVgUCYmE8ogAKCRD7H22hwInk
Vm+HAP45A1zy11Y/5W/jNQUnT9LxW54xIwvl4lOPryiadpR6RwD/SSQw6KM6h2NS
C28XCesj1ws2dTi+n9nTjZk5JGh7Wgg=
=wWn8
-----END PGP SIGNATURE-----

--=-Ms39hFMWmUk7Ygg8vUOB--

