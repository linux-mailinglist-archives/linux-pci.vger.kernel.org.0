Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCBA509C5A
	for <lists+linux-pci@lfdr.de>; Thu, 21 Apr 2022 11:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387621AbiDUJay (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Apr 2022 05:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387625AbiDUJay (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Apr 2022 05:30:54 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE25527CFC;
        Thu, 21 Apr 2022 02:28:04 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23L9Nhm0007645;
        Thu, 21 Apr 2022 09:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version; s=pp1; bh=UoyM7QuV4f6z+1Hig/YUjPae6yDBBRuV0rL44GgLXcc=;
 b=VGhbb5JZsjkcE8KiFkF8H0JkPLnp9EJuF7c0fxXdizzW46Xk2Yngw2VLJa40AC3pvW0o
 pXV7uwARt0mIr58uq3eGG9homohltz+qzGwEmxQv8riLcVkx1ahHnadQr9fQITsR0r6V
 bjH6nDzWmtsMJiIibS9oS21oFXxxmgn+9K3FKhNr8iRAMVaebM7QfZaCXtstC10WO73y
 QtG+OM7sIZ+p46FGhIZzDPdinVVbC6wiReHk2TPHI7RT7zXH7BLqvbA6Ye6WlLQUj/49
 tMD49lo3qOhy6hrjKc3OHp2+R5oI/9pGi/40xAg68lM0pssk5yZ2Sc90XFZ7UkjezjB6 Pg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fk4kqg24c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Apr 2022 09:27:55 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23L9RtxE031320;
        Thu, 21 Apr 2022 09:27:55 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fk4kqg23t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Apr 2022 09:27:55 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23L9RHsB004316;
        Thu, 21 Apr 2022 09:27:53 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3ffne97ku2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Apr 2022 09:27:53 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23L9RoF551905016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Apr 2022 09:27:50 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0140BA4040;
        Thu, 21 Apr 2022 09:27:50 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59616A4051;
        Thu, 21 Apr 2022 09:27:49 +0000 (GMT)
Received: from sig-9-145-44-250.uk.ibm.com (unknown [9.145.44.250])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 21 Apr 2022 09:27:49 +0000 (GMT)
Message-ID: <8225cf74d6d81c3ce149d677b5bf47689d8e3fd2.camel@linux.ibm.com>
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
Date:   Thu, 21 Apr 2022 11:27:42 +0200
In-Reply-To: <20220421021446.GA1356365@bhelgaas>
References: <20220421021446.GA1356365@bhelgaas>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-kgosNNU3lYVX4dmGeFTy"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YadYJuWXU6oE_qrkkIVQQ6l8oNS4W3n_
X-Proofpoint-ORIG-GUID: nps0FDslBiQ6Y2ZyM1QFczbbbOUxjHb6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_06,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204210050
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-kgosNNU3lYVX4dmGeFTy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2022-04-20 at 21:14 -0500, Bjorn Helgaas wrote:
> Hi Niklas,
>=20
> I'm sure this makes good sense, but I need a little more hand-holding.
> Sorry this is long and rambling.
>=20
> On Tue, Apr 19, 2022 at 12:28:00PM +0200, Niklas Schnelle wrote:
> > While determining the next PCI function is factored out of
> > pci_scan_slot() into next_fn() the former still handles the first
> > function as a special case duplicating the code from the scan loop and
> > splitting the condition that the first function exits from it being
> > multifunction which is tested in next_fn().
> >=20
> > Furthermore the non ARI branch of next_fn() mixes the case that
> > multifunction devices may have non-contiguous function ranges and dev
> > may thus be NULL with the multifunction requirement. It also signals
> > that no further functions need to be scanned by returning 0 which is
> > a valid function number.
> >=20
> > Improve upon this by moving all conditions for having to scan for more
> > functions into next_fn() and make them obvious and commented.
> >=20
> > By changing next_fn() to return -ENODEV instead of 0 when there is no
> > next function we can then handle the initial function inside the loop
> > and deduplicate the shared handling.
> >=20
> > No functional change is intended.
> >=20
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> >  drivers/pci/probe.c | 41 +++++++++++++++++++----------------------
> >  1 file changed, 19 insertions(+), 22 deletions(-)
> >=20
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 17a969942d37..389aa1f9cb2c 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -2579,33 +2579,35 @@ struct pci_dev *pci_scan_single_device(struct p=
ci_bus *bus, int devfn)
> >  }
> >  EXPORT_SYMBOL(pci_scan_single_device);
> > =20
> > -static unsigned int next_fn(struct pci_bus *bus, struct pci_dev *dev,
> > -			    unsigned int fn)
> > +static int next_fn(struct pci_bus *bus, struct pci_dev *dev, int fn)
> >  {
> >  	int pos;
> >  	u16 cap =3D 0;
> >  	unsigned int next_fn;
> > =20
> > -	if (pci_ari_enabled(bus)) {
> > -		if (!dev)
> > -			return 0;
> > +	if (dev && pci_ari_enabled(bus)) {
>=20
> I think this would be easier to verify if we kept the explicit error
> return, e.g.,
>=20
>   if (pci_ari_enabled(bus)) {
>     if (!dev)
>       return -ENODEV;
>     pos =3D pci_find_ext_capability(...);
>=20
> Otherwise we have to sort through the !dev cases below.  I guess
> -ENODEV would come from either the "!fn && !dev" case or the "fn > 6"
> case, but it's not obvious to me that those are equivalent to the
> previous code.

We could keep this the same for this patch but I think for jailhouse
(patch 2) we need the "!dev" case not to fail here such that we can
handle the missing function 0 below even if ARI is enabled. For s390
this doesn't currently matter because pci_ari_enabled(bus) is always
false but I assumed that this isn't necessarily so for jailhouse. I
sent a follow up mail on a slight behavior change I can think of for
this case for v2 but forgot to send it also for v3. Quoted below:

"This part here theoretically changes the behavior slightly. If the ARI
information is wrong/lands us in a "hole" we may look for more
functions via the non-ARI path. Not sure if that is relevant though as
in the worst case we might find functions that we otherwise wouldn't
have seen. Seems rather obsure to me but I might be wrong, we currently
don't see the ARI capability in Linux on IBM Z so I have less
experience with this. I did of course boot test on my x86_64
workstation."

>=20
> >  		pos =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI);
> >  		if (!pos)
> > -			return 0;
> > +			return -ENODEV;
> > =20
> >  		pci_read_config_word(dev, pos + PCI_ARI_CAP, &cap);
> >  		next_fn =3D PCI_ARI_CAP_NFN(cap);
> >  		if (next_fn <=3D fn)
> > -			return 0;	/* protect against malformed list */
> > +			return -ENODEV;	/* protect against malformed list */
> > =20
> >  		return next_fn;
> >  	}
> > =20
> > -	/* dev may be NULL for non-contiguous multifunction devices */
> > -	if (!dev || dev->multifunction)
> > -		return (fn + 1) % 8;
> > -
> > -	return 0;
> > +	/* only multifunction devices may have more functions */
> > +	if (dev && !dev->multifunction)
> > +		return -ENODEV;
>=20
> I don't understand why the "!dev || dev->multifunction" test needs to
> change.  Isn't that valid even in the hypervisor case?  IIUC, you want
> to return success in some cases that currently return failure, so this
> case that was already success should be fine as it was.

This isn't a change to the test. It's the negation of the logical
condition *and* a switch of the branches i.e. keeps the overall
behavior exactly the same. The equivalence is !(!A || B) =3D=3D (A && !B).
There are two reasons I did this.

1. I find (!dev || dev->multifunction) to be much harder to grasp than
(dev && !dev->multifunction).

2. The whole next_fn() in my opinion becomes easier to read if it bails
for all bad cases early and the "this is the next fn" is the final
return if we didn't bail. This becomes even more true as another
condition is added in patch 2.

>=20
> Is this because "(fn + 1) % 8" may be zero, which previously
> terminated the loop, but now it doesn't because "fn =3D=3D 0" is the
> *first* execution of the loop?

Yes with function 0 handled in the loop we can't use 0 as the
termination indication. Also I find it generally weird to use a wrap
around for this.

>=20
> If so, I wonder if we could avoid that case by adding:
>=20
>   if (fn >=3D 7)
>     return -ENODEV;
>=20
> at the very beginning.  Maybe that would allow a more trivial patch
> that just changed the error return from 0 to -ENODEV, i.e., leaving
> all the logic in next_fn() unchanged?

I think this is equivalent to the ternary at the return. Both return
-ENODEV for fn >=3D 7. I do like your idea better though as it keeps with
the scheme of my point 2 above and ternaries are ever so slightly
harder to read.

>=20
> I'm wondering if this could end up like:
>=20
>     if (fn >=3D 7)
>       return -ENODEV;
>=20
>     if (pci_ari_enabled(bus)) {
>       if (!dev)
> 	return -ENODEV;
>       ...
>       return next_fn;
>     }
>=20
>     if (!dev || dev->multifunction)
>       return (fn + 1) % 8;
>=20
>  +  if (hypervisor_isolated_pci_functions())
>  +    return (fn + 1) % 8;
>=20
>     return -ENODEV;
>=20
> (The hypervisor part being added in a subsequent patch, and I'm not
> sure exactly what logic you need there -- the point being that it's
> just an additional success case.)

Yes pretty much only that by negating the success case and switching
the branches we end up with a list of fail/bail checks and a single
success return even with the hyperisor check added. Also not sure if
the "fn >=3D 7" check should rather go after the ARI path to keep them
separate doesn't really matter of course.

>=20
> The "% 8" seems possibly superfluous then, since previously that
> caused a zero return that terminated the loop.  If we're using -ENODEV
> to terminate the loop, we probably don't care about the mod 8.

Yes

>=20
> > +	/*
> > +	 * A function 0 is required but multifunction devices may
> > +	 * be non-contiguous so dev can be NULL otherwise.
>=20
> I understood the original "dev may be NULL ..." comment, but I can't
> quite parse this.  "dev can be NULL" for non-zero functions?  That's
> basically what it said before, but it's not clear what "otherwise"
> refers to.

I agree this can probably be improved. I'm trying to say that dev can
be NULL if it is not function 0 which must exist. Maybe:

"dev may be NULL as multifunction devices may be non-contiguous but a
function 0 is required"

>=20
> > +	 */
> > +	if (!fn && !dev)
> > +		return -ENODEV;
>=20
> This part isn't obvious to me yet, partly because of the "!fn && !dev"
> construction.  The negatives make it hard to parse.
>=20
> Since "fn" isn't a boolean or a pointer, I think "fn =3D=3D 0" is easier
> to read than "!fn".  I would test "dev" first since it logically
> precedes "fn".

I agree about the "fn =3D=3D 0", I only used "!fn" because I remember
getting checkpatch warnings for "foo =3D=3D 0" in the past. I'll change to
fn =3D=3D 0. As for the order see below.

>=20
> IIUC !dev means we haven't found a function at this device number yet.
> So this:
>=20
>   if (!dev && fn =3D=3D 0)
>     return -ENODEV;
>=20
> means we called pci_scan_single_device(bus, devfn + 0) the first time
> through the loop, and it didn't find a device so it returned NULL.

Yes. This is "dev may be NULL unless we're looking at function 0". The
fn came before dev because I wrote it as "function 0 must not be NULL"
but it could also be "dev is NULL and we're looking at function 0",
I have no clear preference.

This is also the case that gets changed by patch 2 to become:

"function 0 must not be NULL unless we have isolated PCI functions"

or with the order switched:

"dev is NULL and we're looking at function 0 and don't have isolated
PCI functions"

>=20
> > +	return (fn <=3D 6) ? fn + 1 : -ENODEV;
> >  }
> > =20
> >  static int only_one_child(struct pci_bus *bus)
> > @@ -2643,24 +2645,19 @@ static int only_one_child(struct pci_bus *bus)
> >   */
> >  int pci_scan_slot(struct pci_bus *bus, int devfn)
> >  {
> > -	unsigned int fn, nr =3D 0;
> > -	struct pci_dev *dev;
> > +	int fn, nr =3D 0;
> > +	struct pci_dev *dev =3D NULL;
> > =20
> >  	if (only_one_child(bus) && (devfn > 0))
> >  		return 0; /* Already scanned the entire slot */
> > =20
> > -	dev =3D pci_scan_single_device(bus, devfn);
> > -	if (!dev)
> > -		return 0;
> > -	if (!pci_dev_is_added(dev))
> > -		nr++;
> > -
> > -	for (fn =3D next_fn(bus, dev, 0); fn > 0; fn =3D next_fn(bus, dev, fn=
)) {
> > +	for (fn =3D 0; fn >=3D 0; fn =3D next_fn(bus, dev, fn)) {
> >  		dev =3D pci_scan_single_device(bus, devfn + fn);
>=20
> "devfn + fn" (in the existing, unchanged code) is a little bit weird.
> In almost all cases, devfn is the result of "PCI_DEVFN(slot, 0)", so
> we could make the interface:
>=20
>   pci_scan_slot(struct pci_bus *bus, int dev)
>=20
> where "dev" is 0-31.
>=20
> The only exceptions are a couple hotplug drivers where the fn probably
> is or should be 0, too, but I haven't verified that.
>=20
> But this would be scope creep, so possibly something we could consider
> in the future, but not for this series.

Hmm, I see your point. It makes little sense to have a devfn that isn't
from PCI_DEVFN(slot, 0) and not use pci_scan_single_device() instead.

>=20
> >  		if (dev) {
> >  			if (!pci_dev_is_added(dev))
> >  				nr++;
> > -			dev->multifunction =3D 1;
> > +			if (nr > 1)
> > +				dev->multifunction =3D 1;
> >  		}
> >  	}
> > =20
> > --=20
> > 2.32.0
> >=20


--=-kgosNNU3lYVX4dmGeFTy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSiikNOrnCUNbxSj4j7H22hwInkVgUCYmEjjgAKCRD7H22hwInk
Vit4AQDprxiVgvFsILBgrF891xFGJG34rFju00CjqryS8efKjgEAndHSdBHZI/Gl
z8qLGrpwFcLgsK/UIlE/qcQoTVt9UwE=
=bjJh
-----END PGP SIGNATURE-----

--=-kgosNNU3lYVX4dmGeFTy--

