Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750B950B89D
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 15:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356589AbiDVNiW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 09:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237165AbiDVNiU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 09:38:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113B44A93F;
        Fri, 22 Apr 2022 06:35:27 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23MCmtew008621;
        Fri, 22 Apr 2022 13:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version; s=pp1; bh=Zcc0JtPRzC+pKr8++TBAJL5YNRPeYJc/FYOB64+6btE=;
 b=AmFwLcoI3tVKKINXxOxlp3AnwyUB1m2zkOvxgDvqYJIqHVGa77iRWtgy5IQRbCGtl052
 r/3MTho75Zygv7CEL7isQteaH/2fEQ/zFB1m5c3uGigwL9c8Oh16ytP9CjiN6Az5sN0b
 p8BPi+0Fx9GYhFSsO/7aRAYoqAhhJrGPxEz19s8IjOwYVneM7lPt6sTbUwu1ZswQIpWR
 T1apMP1nIj3AQDhBos5N9ZOtSfiH9XNVbPPVgy3N91PeWVj4qQb7zdN9w7hyeJMM3QQI
 7iSsXIDM6u8le+rC5g+xam6+3nZMb3LA95IPt70+dJtvQ7f9yttv4KlhqyrQE1ABZSq+ 6g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fjyk5j1sa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 13:35:23 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23MDL28n009338;
        Fri, 22 Apr 2022 13:35:23 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fjyk5j1rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 13:35:23 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23MDMbop007852;
        Fri, 22 Apr 2022 13:35:20 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3ffn2j1fce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 13:35:20 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23MDZHXQ47382996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 13:35:17 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FE7C11C04A;
        Fri, 22 Apr 2022 13:35:17 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0531911C04C;
        Fri, 22 Apr 2022 13:35:17 +0000 (GMT)
Received: from sig-9-145-175-158.de.ibm.com (unknown [9.145.175.158])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 22 Apr 2022 13:35:16 +0000 (GMT)
Message-ID: <19ea2a8ff04c24708a6504924f7a91c1045308d0.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/4] PCI: Clean up pci_scan_slot()
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
Date:   Fri, 22 Apr 2022 15:35:07 +0200
In-Reply-To: <20220422132858.1213022-2-schnelle@linux.ibm.com>
References: <20220422132858.1213022-1-schnelle@linux.ibm.com>
         <20220422132858.1213022-2-schnelle@linux.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-+5TQTceV7kwkEleY1vza"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0WaMBypyLUjSk87yGeJ1ASs6lTTjZ5xt
X-Proofpoint-GUID: FVqF75_czQd9DiAeaJToju48fGU_wdNy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-22_03,2022-04-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=907 spamscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204220059
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-+5TQTceV7kwkEleY1vza
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2022-04-22 at 15:28 +0200, Niklas Schnelle wrote:
> While determining the next PCI function is factored out of
> pci_scan_slot() into next_fn() the former still handles the first
> function as a special case. This duplicates the code from the scan loop.
>=20
> Furthermore the non ARI branch of next_fn() is generally hard to
> understand and especially the check for multifunction devices is hidden
> in the handling of NULL devices for non-contiguous multifunction. It
> also signals that no further functions need to be scanned by returning
> 0 via wraparound and this is a valid function number.
>=20
> Improve upon this by transforming the conditions in next_fn() to be
> easier to understand.
>=20
> By changing next_fn() to return -ENODEV instead of 0 when there is no
> next function we can then handle the initial function inside the loop
> and deduplicate the shared handling. This also makes it more explicit
> that only function 0 must exist.
>=20
> No functional change is intended.
>=20
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/pci/probe.c | 39 ++++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 17a969942d37..2000e9858f12 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2579,8 +2579,7 @@ struct pci_dev *pci_scan_single_device(struct pci_b=
us *bus, int devfn)
>  }
>  EXPORT_SYMBOL(pci_scan_single_device);
> =20
> -static unsigned int next_fn(struct pci_bus *bus, struct pci_dev *dev,
> -			    unsigned int fn)
> +static int next_fn(struct pci_bus *bus, struct pci_dev *dev, int fn)
>  {
>  	int pos;
>  	u16 cap =3D 0;
> @@ -2588,24 +2587,27 @@ static unsigned int next_fn(struct pci_bus *bus, =
struct pci_dev *dev,
> =20
>  	if (pci_ari_enabled(bus)) {
>  		if (!dev)
> -			return 0;
> +			return -ENODEV;
> +
>=20

Sorry the whitespace damage was of course not intended, fixed locally.


--=-+5TQTceV7kwkEleY1vza
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSiikNOrnCUNbxSj4j7H22hwInkVgUCYmKvCwAKCRD7H22hwInk
VuHsAP4kfYFxmlqA+DTbxpABv2slW9y+gv3ZVfhol3ARhACQTAEA7eHZ1cfNp120
EPzOHKOZgvgB4WoqBZ3lks5BKp7bhQg=
=esXt
-----END PGP SIGNATURE-----

--=-+5TQTceV7kwkEleY1vza--

