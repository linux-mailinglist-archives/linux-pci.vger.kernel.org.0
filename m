Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CE850B606
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 13:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376986AbiDVLTn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 07:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446942AbiDVLTn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 07:19:43 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A8D54F87;
        Fri, 22 Apr 2022 04:16:49 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23MBFO5f011002;
        Fri, 22 Apr 2022 11:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version; s=pp1; bh=xYPmjJ2SW/ZBfRCuqvz3uZDQKIM/XvHK3yjbb1+GNzA=;
 b=BfZcpfB/XLMLkf7lkEp51A/Uohvlr4qm16HlNJzJG9rjfS51XJdFhD7z6ufdrwQTYYqn
 GYVunIsFERoVuv2torARVOeRGZBDpIKgFG5vV/RR9lpRL0n1XPABIJZOChaewaYlS+7F
 tCF0hAerOlKZ6PatTE8TvFS5eWOYW3Yo+DMib6UEhrnizN+OKFw8k9dAcC3pOm2g8rRu
 EkGpan5WUxSIlzLk0BZz12tAwVx/bXy2LtMGBScsTavabERJTlSp2mTDpkIUFz2KeDtX
 gjWXdbQTGcFLo//6Jb231rtF7xsDy/UJXTGxyT+DXZ77AkGME5z7e30KXEVsQVqTSnvH Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fjswfe9fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 11:16:38 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23MBA1pU005996;
        Fri, 22 Apr 2022 11:16:37 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fjswfe9f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 11:16:37 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23MBBHRR004748;
        Fri, 22 Apr 2022 11:16:36 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3ffne8s8kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 11:16:35 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23MBGVAR28180874
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 11:16:31 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CA1E4204C;
        Fri, 22 Apr 2022 11:16:31 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D57F4203F;
        Fri, 22 Apr 2022 11:16:31 +0000 (GMT)
Received: from sig-9-145-175-158.de.ibm.com (unknown [9.145.175.158])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 22 Apr 2022 11:16:30 +0000 (GMT)
Message-ID: <f942bf2aa967744fc919a95ceb4acf8ac7a53aa6.camel@linux.ibm.com>
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
Date:   Fri, 22 Apr 2022 13:16:24 +0200
In-Reply-To: <20220421170920.GA1408189@bhelgaas>
References: <20220421170920.GA1408189@bhelgaas>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-UnxLVZywhFawVyCD9jVg"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2OsMm3pg7PeoA_5PFVdVM6QEDDVUlLDb
X-Proofpoint-GUID: IEV_T7TivXfTVmH1Bs57xNHuO1oumkaS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-22_02,2022-04-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 adultscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204220049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-UnxLVZywhFawVyCD9jVg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2022-04-21 at 12:09 -0500, Bjorn Helgaas wrote:
> On Thu, Apr 21, 2022 at 11:27:42AM +0200, Niklas Schnelle wrote:
> > On Wed, 2022-04-20 at 21:14 -0500, Bjorn Helgaas wrote:
> > > On Tue, Apr 19, 2022 at 12:28:00PM +0200, Niklas Schnelle wrote:
> > > > While determining the next PCI function is factored out of
> > > > pci_scan_slot() into next_fn() the former still handles the first
> > > > function as a special case duplicating the code from the scan loop =
and
> > > > splitting the condition that the first function exits from it being
> > > > multifunction which is tested in next_fn().
> > > >=20
> > > > Furthermore the non ARI branch of next_fn() mixes the case that
> > > > multifunction devices may have non-contiguous function ranges and d=
ev
> > > > may thus be NULL with the multifunction requirement. It also signal=
s
> > > > that no further functions need to be scanned by returning 0 which i=
s
> > > > a valid function number.
> > > >=20
> > > > Improve upon this by moving all conditions for having to scan for m=
ore
> > > > functions into next_fn() and make them obvious and commented.
> > > >=20
> > > > By changing next_fn() to return -ENODEV instead of 0 when there is =
no
> > > > next function we can then handle the initial function inside the lo=
op
> > > > and deduplicate the shared handling.
> > > >=20
> > > > No functional change is intended.
> > > >=20
> > > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > > ---
> > > >  drivers/pci/probe.c | 41 +++++++++++++++++++----------------------
> > > >  1 file changed, 19 insertions(+), 22 deletions(-)
> > > >=20
> > > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > > index 17a969942d37..389aa1f9cb2c 100644
> > > > --- a/drivers/pci/probe.c
> > > > +++ b/drivers/pci/probe.c
> > > > @@ -2579,33 +2579,35 @@ struct pci_dev *pci_scan_single_device(stru=
ct pci_bus *bus, int devfn)
> > > >  }
> > > >  EXPORT_SYMBOL(pci_scan_single_device);
> > > > =20
> > > > -static unsigned int next_fn(struct pci_bus *bus, struct pci_dev *d=
ev,
> > > > -			    unsigned int fn)
> > > > +static int next_fn(struct pci_bus *bus, struct pci_dev *dev, int f=
n)
> > > >  {
> > > >  	int pos;
> > > >  	u16 cap =3D 0;
> > > >  	unsigned int next_fn;
> > > > =20
> > > > -	if (pci_ari_enabled(bus)) {
> > > > -		if (!dev)
> > > > -			return 0;
> > > > +	if (dev && pci_ari_enabled(bus)) {
> > >=20
> > > I think this would be easier to verify if we kept the explicit error
> > > return, e.g.,
> > >=20
> > >   if (pci_ari_enabled(bus)) {
> > >     if (!dev)
> > >       return -ENODEV;
> > >     pos =3D pci_find_ext_capability(...);
> > >=20
> > > Otherwise we have to sort through the !dev cases below.  I guess
> > > -ENODEV would come from either the "!fn && !dev" case or the "fn > 6"
> > > case, but it's not obvious to me that those are equivalent to the
> > > previous code.
> >=20
> > We could keep this the same for this patch but I think for jailhouse
> > (patch 2) we need the "!dev" case not to fail here such that we can
> > handle the missing function 0 below even if ARI is enabled. For s390
> > this doesn't currently matter because pci_ari_enabled(bus) is always
> > false but I assumed that this isn't necessarily so for jailhouse. I
> > sent a follow up mail on a slight behavior change I can think of for
> > this case for v2 but forgot to send it also for v3. Quoted below:
>=20
> I think it would be good to make the first patch change as little as
> possible to make it easier to analyze, then possibly test for
> hypervisor when changing this behavior.

Yes makes sense, in my current local version I've kept the direct
return here. I think I've also found a way to keep this even for the
isolated PCI function case. See below.

>=20
> > > > -	/* dev may be NULL for non-contiguous multifunction devices */
> > > > -	if (!dev || dev->multifunction)
> > > > -		return (fn + 1) % 8;
> > > > -
> > > > -	return 0;
> > > > +	/* only multifunction devices may have more functions */
> > > > +	if (dev && !dev->multifunction)
> > > > +		return -ENODEV;
> > >=20
> > > I don't understand why the "!dev || dev->multifunction" test needs to
> > > change.  Isn't that valid even in the hypervisor case?  IIUC, you wan=
t
> > > to return success in some cases that currently return failure, so thi=
s
> > > case that was already success should be fine as it was.
> >=20
> > This isn't a change to the test. It's the negation of the logical
> > condition *and* a switch of the branches i.e. keeps the overall
> > behavior exactly the same. The equivalence is !(!A || B) =3D=3D (A && !=
B).
>=20
> I see the Boolean equivalence, but it's difficult to verify that the
> consequences are equivalent because the new code has the extra "!fn &&
> !dev" test in the middle.

Ok. I would argue that the "fn =3D=3D 0 && !dev" is just the moved "!dev"
check for the initial pci_scan_single_device() that previously happened
outside the loop. With the modulo gone I can't think of any other way
to get fn =3D=3D 0 but in the first iteration.=20

But you are right, the extra test introduces some extra churn in
next_fn(). I think we can get rid of that new condition such that
next_fn() is more easily verifiable. See below.

>=20
> > There are two reasons I did this.
> >=20
> > 1. I find (!dev || dev->multifunction) to be much harder to grasp than
> > (dev && !dev->multifunction).
> >=20
> > 2. The whole next_fn() in my opinion becomes easier to read if it bails
> > for all bad cases early and the "this is the next fn" is the final
> > return if we didn't bail. This becomes even more true as another
> > condition is added in patch 2.
>=20
> Fair enough, and I agree that "this is the next fn" is a nice final
> return.  In general I think it's good to return either an error or the
> next fn as soon as it is known.  It makes it harder to analyze if the
> return value has already been determined but we have to mentally pass
> over subsequent tests that don't affect it.

I agree and I think we can get this with the transformed cases too.

>=20
> > > Is this because "(fn + 1) % 8" may be zero, which previously
> > > terminated the loop, but now it doesn't because "fn =3D=3D 0" is the
> > > *first* execution of the loop?
> >=20
> > Yes with function 0 handled in the loop we can't use 0 as the
> > termination indication. Also I find it generally weird to use a wrap
> > around for this.
>=20
> Yes, I agree that's weird.  Usually I prefer "for" loops over
> "do ...  while", but this might be a case where it makes sense --
> we *always* want to call pci_scan_single_device() once, and
> "do ... while" would accomplish that without any fuss.  It might even
> allow us to keep the 0 return value as the termination condition,
> which would be nice because fn could stay unsigned and it would reduce
> the size of this patch.

To me the 0 return is part of the weirdness as it is a valid fn value,
so returning it from next_fn() would naturally communicate that the
next fn is fn 0 not that there are no more functions.

It feels like making next_fn() more obvious is worth the larger patch.
I think us having to convince ourselves of these details is testament
that it currently is very hard to understand the interactions here
while the new conditions for stopping the scan are each almost obvious.
So I think if we can convince ourselves that the new code is exactly
equivalent which I believe it is when keeping the check in the ARI
path, then that is what makes the patch save.

>=20
> I'm hoping we can end up with something like this:
>=20
>   unsigned int next_fn(bus, dev, fn, mf)
>   {
>     if (ari(bus)) {
>       if (!dev)
> 	return 0;
>       return PCI_ARI_CAP_NFN();
>     }
>=20
>     if (fn >=3D 7)
>       return 0;
>=20
>     if (mf)
>       return fn + 1;
>=20
>     if (hypervisor())
>       return fn + 1;

Ooh, just realized that my series changes the behavior for jailhouse
when the passed through device is not multifunction. In the existing
code pci_scan_single_device() is called for all devfn irrespective of
whether the first function found has dev->multifunction set after
scanning it. I'm not sure if that would happen if e.g. we have multiple
SR-IOV VFs but not the PF.

>=20
>     return 0;
>   }
>=20
>   int pci_scan_slot(...)
>   {
>     unsigned int fn =3D 0, mf =3D 0;
>=20
>     do {
>       dev =3D pci_scan_single_device(bus, devfn + fn);
>       if (dev && dev->multifunction)
> 	mf =3D 1;
>       fn =3D next_fn(dev, fn, mf);
>     } while (fn);
>   }
>=20
> This would be minimal change to next_fn(): just add the "mf"
> parameter, which removes a lot of the confusing "dev" and "!dev"
> testing, and add the "fn >=3D 7" to remove the implicit "% 8 =3D=3D 0"
> failure case.

The extra mf parameter feels a bit superflous as we already have dev-
>multifunction and then would just move the "dev && (!)dev-
>multifunction" test out of next_fn().=20

To me this doesn't look like less of a change to next_fn() either. That
said, it gave me an idea. One way to change next_fn() less is to keep
the "fn =3D=3D 0 && !dev" test out of it and in pci_scan_slot(). That way
there are no new conditions in next_fn() and the existing conditions
can be transformed as proposed without mixing in new stuff.

With that the scan loop would look something like:

  int pci_scan_slot(...)
  {
    int fn =3D 0, nr =3D0 ;

    do {
      dev =3D pci_scan_single_device(bus, devfn + fn);
      if (dev) {
         ...
      } else if (fn =3D=3D 0) {
        /* missing function 0*/
        break;
      }
      fn =3D next_fn(bus, dev, fn);
    } while (fn);
  }

Even better this allows us to keep the "!dev" check in the ARI case as
we don't have to handle the missing function 0 in next_fn().

Let me sent you this variant before we abandon the -ENODEV return and
condition transforms.

>=20
> Then the jailhouse/s390 patch would trivially add the new hypervisor
> case, which is clearly separated from everything else.
>=20
> > > If so, I wonder if we could avoid that case by adding:
> > >=20
> > >   if (fn >=3D 7)
> > >     return -ENODEV;
> > >=20
> > > at the very beginning.  Maybe that would allow a more trivial patch
> > > that just changed the error return from 0 to -ENODEV, i.e., leaving
> > > all the logic in next_fn() unchanged?
> >=20
> > I think this is equivalent to the ternary at the return. Both return
> > -ENODEV for fn >=3D 7. I do like your idea better though as it keeps wi=
th
> > the scheme of my point 2 above and ternaries are ever so slightly
> > harder to read.
>=20
> Oops, I don't think we can do this directly because in the ARI case,
> fn is basically 8 bits wide so can be 0-255.
>=20
> Bjorn

True, we really do need to keep the ARI case separate.


--=-UnxLVZywhFawVyCD9jVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSiikNOrnCUNbxSj4j7H22hwInkVgUCYmKOiAAKCRD7H22hwInk
VoPnAQD10rX0RP0mH7smxfhxg56S4//zk6/6oFVLHx16hkToaQD7B9mcrDz5rIod
ygOKAaCRh5BL18COQksLOkoXBaJEcAk=
=yryP
-----END PGP SIGNATURE-----

--=-UnxLVZywhFawVyCD9jVg--

