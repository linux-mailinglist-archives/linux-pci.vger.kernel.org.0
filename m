Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12B869CB70
	for <lists+linux-pci@lfdr.de>; Mon, 20 Feb 2023 13:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjBTMxu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Feb 2023 07:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjBTMxt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Feb 2023 07:53:49 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D8983F5;
        Mon, 20 Feb 2023 04:53:47 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31KCXa3U024143;
        Mon, 20 Feb 2023 12:53:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=YztoCcKA1qAotP7zviv5DPxU/2kKFA3RhwizP6I7Dcg=;
 b=mpGTwSa+vYunD7qX9iSbxW85/6zMN4gp0KEGuNLaY27bGEL9byzSVjYXocuXuMjCa+oN
 R/kGYvRdaJr8pQ1V1rUUa2UD1O/wAH2i5jZyDohxZqkpTEtzJdEaJBQJ5QOQOuIZSdDp
 vMrSI16gLZXXZyYhtVkbKWYigyC4e0MvcR0bWCpT2QJoV9xJ8ac+4OAuyNcwVwchavTl
 n+Uz0uhRqINy3ZiK4+9wmCoTdIcFHsNa5j+X/UP5mcRs2pTLVsxX60X4Vdlsr6k7aadg
 peS/JVHhaJXskr+2X2PjnuAnj7i8ha3x/8UEC1wTbrg5q0RZjCVridQEFEtajGUKdiXn ZQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nv2at26xd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 12:53:42 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31KCo9Kp025432;
        Mon, 20 Feb 2023 12:53:42 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nv2at26x0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 12:53:41 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31KBgY3Y004632;
        Mon, 20 Feb 2023 12:53:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3ntpa6apnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 12:53:39 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31KCrZMm36962730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Feb 2023 12:53:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E15C320040;
        Mon, 20 Feb 2023 12:53:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D311E20049;
        Mon, 20 Feb 2023 12:53:34 +0000 (GMT)
Received: from [9.171.0.30] (unknown [9.171.0.30])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Feb 2023 12:53:34 +0000 (GMT)
Message-ID: <1a621a2b836d81d12b6f265f47d93b827e0a82df.camel@linux.ibm.com>
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
Date:   Mon, 20 Feb 2023 13:53:34 +0100
In-Reply-To: <20230217231503.GA3425666@bhelgaas>
References: <20230217231503.GA3425666@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uzcwYrTmgbMkSaFItKDZZyEpzzcMV6az
X-Proofpoint-ORIG-GUID: hBw7SIIb_gaVLwCvApgsQy8lvVTCchwH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_10,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302200114
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2023-02-17 at 17:15 -0600, Bjorn Helgaas wrote:
> On Tue, Feb 14, 2023 at 10:49:10AM +0100, Niklas Schnelle wrote:
> > On s390 PCI functions may be hotplugged individually even when they
> > belong to a multi-function device. In particular on an SR-IOV device VF=
s
> > may be removed and later re-added.
>=20
> Is there something special about the SR-IOV/VF case that relates to
> this problem?  If not, it might be unnecessary distraction to mention
> it.

It's not really special in that the problem could also be triggered by
other hotplug but it is the most common scenario where you'd run into
this problem. Some background. If you simply do a "echo 0 >
/sys/bus/pci/slots/<func>/power" and then power on again the PCI
resources are not removed because the function stays visible to the
system just deconfigured. To trigger removal you'd have to move a
single function to a different system in the machine hypervisor but
then you're less likely to bring it back again so the dangling resource
pointer won't cause problems. When using "../sriov_numvfs" to change
the number of VFs however they are temporarily removed and then re-
appear.

>=20
> > In commit a50297cf8235 ("s390/pci: separate zbus creation from
> > scanning") it was missed however that struct pci_bus and struct
> > zpci_bus's resource list retained a reference to the PCI functions MMIO
> > resources even though those resources are released and freed on
> > hot-unplug. These stale resources may subsequently be claimed when the
> > PCI function re-appears resulting in use-after-free.
>=20
> Lifetimes of all these resources definitely aren't obvious to me.

Yes the problem is that the old code did muddy the water here because
it didn't properly separate which resources are tied to a PCI function
and which to the bus as a whole. I tried to fix this in this patch.

But  let me first explain lifetimes of the struct zpci_bus and struct
zpci_bus. As our basic architecture works with one struct zpci_dev per
function and they can be hot(un-)plugged in any order but we still want
to support exposing the topology within a multi-function PCI device the
struct zpci_bus representing the PCI bus on which the functions reside
is created when the first PCI function on that bus is discovered and it
exists until the last PCI function on that bus disappears.


>=20
> So I guess the critical thing here is the new
> pci_bus_remove_resource() in zpci_cleanup_bus_resources(), which
> removes (and kfrees when necessary) the resource from
> pci_bus->resources.
>=20
> I'm not clear on where the zpci_bus resource list comes in.  I guess
> we kalloc resources in zpci_setup_bus_resources(), and the current
> code adds them to zpci_bus->resources and copies them onto the pci_bus
> list.
>=20
> The new code does not add them to zpci_bus->resources at all, and only
> adds them to the pci_bus resource list.  Right?  I guess maybe that's
> what the "no need to add the MMIO resources at all" below refers to?

Yes exactly. The problem is that I got confused with how to map our
model where the BAR resources are strictly tied to the PCI function to
the common API which more closely resembles real hardware and where the
BAR resources are tied to the PCI bus. Instead of making sure that the
per-function resources are added and removed together with the PCI
function matching when they are accessible in our architecture I added
them to the struct zpci_bus and didn't properly remove them neither
from sruct zpci_bus nor the common PCI bus though they were freed thus
creating the use-after free in two places at once. I think somehow I
had though that release_resource() somehow removed it from the resource
lists.

>=20
> > One idea of fixing this use-after-free in s390 specific code that was
> > investigated was to simply keep resources around from the moment a PCI
> > function first appeared until the whole virtual PCI bus created for
> > a multi-function device disappears. The problem with this however is
> > that due to the requirement of artificial MMIO addreesses (address
> > cookies) we will then need extra logic and tracking in struct zpci_bus
> > to keep these compatible for re-use. At the same time the MMIO resource=
s
> > semantically belong to the PCI function so tying their lifecycle to the
> > function seems more logical.
> >=20
> > Instead a simpler approach is to remove the resources of an individuall=
y
> > hot-unplugged PCI function from the PCI bus's resource list while
> > keeping the resources of other PCI functions on the PCI bus untouched.
>=20
> Do we currently never kfree the pci_bus resource list until we free
> the whole pci_bus via release_pcibus_dev()?  Does a remove + add just
> allocate more resources that are probably duplicates of what the
> pci_bus already had?

Yes the current code adds new resources on remove + add while leaving
dangling freed resources in the list creating kind of half duplicates.
It's only due to the order that we end up using the freed dangling
resources instead of the new ones.

>=20
> > This is done by introducing pci_bus_remove_resource() to remove an
> > individual resource. Similarly the resource also needs to be removed
> > from the struct zpci_bus's resource list. It turns out however, that
> > there is really no need to add the MMIO resources at all and instead we
> > can simply use the zpci_bar_struct's resource pointer directly.
> >=20
> > Fixes: a50297cf8235 ("s390/pci: separate zbus creation from scanning")
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>=20
> Other random questions unrelated to this patch:
>=20
>   - zpci_bus_create_pci_bus() calls pci_bus_add_devices().  Isn't that
>     pointless?  AFAICT, the bus->devices list is empty then.

Yes I think you're right it does nothing and can be dropped.

>=20
>   - What about zpci_bus_scan_device()?  Why does it call both
>     pci_bus_add_device() and pci_bus_add_devices()?  The latter will
>     just call the former, so it looks redundant.  And the latter is
>     locked but not the former?

Hmm. great find. This seems to have been weird and redundant since I
first used that pattern in 3047766bc6ec ("s390/pci: fix enabling a
reserved PCI function"). I think maybe then the reason for this was
that prior to 960ac3626487 ("s390/pci: allow zPCI zbus without a
function zero") when the newly enabled is devfn =3D=3D 0 there could be
functions from the same bus which would not have been added yet. I'm
not sure though. That was definitely the idea behind the
zpci_bus_scan_bus() in zpci_scan_configured_devices() that is also
redundant now as we can now scan each function as it appears.

This will definitely need to be cleaned up.

>=20
>   - Struct zpci_bus has a "resources" list.  I guess this contains the
>     &zbus->bus_resource put there in zpci_bus_alloc(), plus an entry
>     for every BAR of every device on the bus (I guess you'd never see
>     an actual PCI-to-PCI bridge on s390?), kalloc'ed in
>     zpci_setup_bus_resources()?

Yes that was the situation before this patch. After this patch only the
zpci_bus.bus_resource is in this resources list. After this patch the
BAR resources are not on the list and only referred to via zdev-
>bars[i].res thus tying them to struct zpci_dev.

Currently Linux does not see PCI-to-PCI bridges on s390. We do have
PCIe switches in the hardware in the so called I/O drawers but they are
hidden from us by firmware. There have been some ideas about having
PCI-to-PCI bridges visible to Linux but nothing concrete at the moment.

>=20
>     What happens when zpci_bus_release() calls
>     pci_free_resource_list() on &zbus->resources?  It looks like that
>     ultimately calls kfree(), which is OK for the
>     zpci_setup_bus_resources() stuff, but what about the
>     zbus->bus_resource that was not kalloc'ed?

As far as I can see pci_free_resource_list() only calls kfree() on the
entry not on entry->res. The resources set up in
zpci_setup_bus_resources() are freed in zpci_cleanup_bus_resources()
explicitly.

>=20
> > ---
> >  arch/s390/pci/pci.c     | 16 ++++++++++------
> >  arch/s390/pci/pci_bus.c | 12 +++++-------
> >  arch/s390/pci/pci_bus.h |  3 +--
> >  drivers/pci/bus.c       | 23 +++++++++++++++++++++++
> >  include/linux/pci.h     |  1 +
> >  5 files changed, 40 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> > index ef38b1514c77..e16afacc8fd1 100644
> > --- a/arch/s390/pci/pci.c
> > +++ b/arch/s390/pci/pci.c
> > @@ -544,8 +544,7 @@ static struct resource *__alloc_res(struct zpci_dev=
 *zdev, unsigned long start,
> >  	return r;
> >  }
> > =20
> > -int zpci_setup_bus_resources(struct zpci_dev *zdev,
> > -			     struct list_head *resources)
> > +int zpci_setup_bus_resources(struct zpci_dev *zdev)
> >  {
> >  	unsigned long addr, size, flags;
> >  	struct resource *res;
> > @@ -581,7 +580,6 @@ int zpci_setup_bus_resources(struct zpci_dev *zdev,
> >  			return -ENOMEM;
> >  		}
> >  		zdev->bars[i].res =3D res;
> > -		pci_add_resource(resources, res);
> >  	}
> >  	zdev->has_resources =3D 1;
> > =20
> > @@ -590,17 +588,23 @@ int zpci_setup_bus_resources(struct zpci_dev *zde=
v,
> > =20
> >  static void zpci_cleanup_bus_resources(struct zpci_dev *zdev)
> >  {
> > +	struct resource *res;
> >  	int i;
> > =20
> > +	pci_lock_rescan_remove();
>=20
> What exactly is this protecting?  This doesn't seem like quite the
> right place since we're not adding/removing a pci_dev here.  Is this
> to protect the bus->resources list in pci_bus_remove_resource()?

Yes I did not find a lock that is specifically for bus->resources but
it seemed to me that changes to resources would only affect things
running under the rescan/remove lock.

>=20
> >  	for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> > -		if (!zdev->bars[i].size || !zdev->bars[i].res)
> > +		res =3D zdev->bars[i].res;
> > +		if (!res)
> >  			continue;
> > =20
> > +		release_resource(res);
> > +		pci_bus_remove_resource(zdev->zbus->bus, res);
> >  		zpci_free_iomap(zdev, zdev->bars[i].map_idx);
> > -		release_resource(zdev->bars[i].res);
> > -		kfree(zdev->bars[i].res);
> > +		zdev->bars[i].res =3D NULL;
> > +		kfree(res);
> >  	}
> >  	zdev->has_resources =3D 0;
> > +	pci_unlock_rescan_remove();
> >  }
> > =20
> >  int pcibios_device_add(struct pci_dev *pdev)
> > diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
> > index 6a8da1b742ae..a99926af2b69 100644
> > --- a/arch/s390/pci/pci_bus.c
> > +++ b/arch/s390/pci/pci_bus.c
> > @@ -41,9 +41,7 @@ static int zpci_nb_devices;
> >   */
> >  static int zpci_bus_prepare_device(struct zpci_dev *zdev)
> >  {
> > -	struct resource_entry *window, *n;
> > -	struct resource *res;
> > -	int rc;
> > +	int rc, i;
> > =20
> >  	if (!zdev_enabled(zdev)) {
> >  		rc =3D zpci_enable_device(zdev);
> > @@ -57,10 +55,10 @@ static int zpci_bus_prepare_device(struct zpci_dev =
*zdev)
> >  	}
> > =20
> >  	if (!zdev->has_resources) {
> > -		zpci_setup_bus_resources(zdev, &zdev->zbus->resources);
> > -		resource_list_for_each_entry_safe(window, n, &zdev->zbus->resources)=
 {
> > -			res =3D window->res;
> > -			pci_bus_add_resource(zdev->zbus->bus, res, 0);
> > +		zpci_setup_bus_resources(zdev);
> > +		for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> > +			if (zdev->bars[i].res)
> > +				pci_bus_add_resource(zdev->zbus->bus, zdev->bars[i].res, 0);
> >  		}
> >  	}
> > =20
> > diff --git a/arch/s390/pci/pci_bus.h b/arch/s390/pci/pci_bus.h
> > index e96c9860e064..af9f0ac79a1b 100644
> > --- a/arch/s390/pci/pci_bus.h
> > +++ b/arch/s390/pci/pci_bus.h
> > @@ -30,8 +30,7 @@ static inline void zpci_zdev_get(struct zpci_dev *zde=
v)
> > =20
> >  int zpci_alloc_domain(int domain);
> >  void zpci_free_domain(int domain);
> > -int zpci_setup_bus_resources(struct zpci_dev *zdev,
> > -			     struct list_head *resources);
> > +int zpci_setup_bus_resources(struct zpci_dev *zdev);
> > =20
> >  static inline struct zpci_dev *zdev_from_bus(struct pci_bus *bus,
> >  					     unsigned int devfn)
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index 83ae838ceb5f..f021f1d4af9f 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -76,6 +76,29 @@ struct resource *pci_bus_resource_n(const struct pci=
_bus *bus, int n)
> >  }
> >  EXPORT_SYMBOL_GPL(pci_bus_resource_n);
> > =20
> > +void pci_bus_remove_resource(struct pci_bus *bus, struct resource *res=
)
> > +{
> > +	struct pci_bus_resource *bus_res, *tmp;
> > +	int i;
> > +
> > +	for (i =3D 0; i < PCI_BRIDGE_RESOURCE_NUM; i++) {
> > +		if (bus->resource[i] =3D=3D res) {
> > +			bus->resource[i] =3D NULL;
> > +			return;
> > +		}
> > +	}
> > +
> > +	list_for_each_entry_safe(bus_res, tmp, &bus->resources, list) {
> > +		if (bus_res->res =3D=3D res) {
> > +			list_del(&bus_res->list);
> > +			kfree(bus_res);
> > +			return;
> > +		}
> > +	}
> > +	return;
> > +
>=20
> Superfluous "return" and blank line.

Will drop.

>=20
> > +}
> > +
> >  void pci_bus_remove_resources(struct pci_bus *bus)
> >  {
> >  	int i;
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index adffd65e84b4..3b1974e2ec73 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -1436,6 +1436,7 @@ void pci_bus_add_resource(struct pci_bus *bus, st=
ruct resource *res,
> >  			  unsigned int flags);
> >  struct resource *pci_bus_resource_n(const struct pci_bus *bus, int n);
> >  void pci_bus_remove_resources(struct pci_bus *bus);
> > +void pci_bus_remove_resource(struct pci_bus *bus, struct resource *res=
);
> >  int devm_request_pci_bus_resources(struct device *dev,
> >  				   struct list_head *resources);
> > =20
> > --=20
> > 2.37.2
> >=20

