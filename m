Return-Path: <linux-pci+bounces-20594-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 867F0A23F30
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 15:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1803A8FE6
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 14:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913641C878A;
	Fri, 31 Jan 2025 14:36:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2994EAC6
	for <linux-pci@vger.kernel.org>; Fri, 31 Jan 2025 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738334183; cv=none; b=nPWIypOZSRfVrg7M60C46CWD2ChA4HXFNTJsd7RUiALNPUTrnNQ7hA4tyZctNft8WAy7yfVnJE1Hj944MXSS+Ta6BgMLMvtvJa1Z13WP92XIIOL0yzzY28seWx0Q6ZXZxzX0WKqVAremgrZwzdbmEMx2B/ci2KmWvAROVMvzGrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738334183; c=relaxed/simple;
	bh=3rDiMUgwJWmcMYaAimh7iLuNbdr2MdV1sR7OBPDtLys=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qrcStH1vm9GFT8L5g1SZ/cTnfkqLDb5VSWsr0qm41r/rXOqoaqmXf5ID3ncXWtCRjSTX8VHUxDM2SH+gjezRRRnCTx2OKAf4vPHI9YBJKVmoK3ZC7rBSsgYoUDzHCY687ce6fKNCdntQVm5VfZIuVF66JQ64sN62Ds2PBxtwqww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ykz2c4GGNz6K5dR;
	Fri, 31 Jan 2025 22:35:36 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5AA761408F9;
	Fri, 31 Jan 2025 22:36:18 +0800 (CST)
Received: from localhost (10.195.244.178) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 31 Jan
 2025 15:36:17 +0100
Date: Fri, 31 Jan 2025 14:36:16 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Rajat Jain <rajatja@google.com>
CC: Karolina Stolarek <karolina.stolarek@oracle.com>, Jon Pan-Doh
	<pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 8/8] PCI/AER: Move AER sysfs attributes into separate
 directory
Message-ID: <20250131143616.00007a73@huawei.com>
In-Reply-To: <CACK8Z6Hyx4D3d=BK15f55muYu7kMLYV7fEusc7dTiUJJ3G5KuQ@mail.gmail.com>
References: <20250115074301.3514927-1-pandoh@google.com>
	<20250115074301.3514927-9-pandoh@google.com>
	<620bbbde-35a9-4232-9cf9-a1fa1e899f8a@oracle.com>
	<CACK8Z6Hyx4D3d=BK15f55muYu7kMLYV7fEusc7dTiUJJ3G5KuQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 16 Jan 2025 09:18:20 -0800
Rajat Jain <rajatja@google.com> wrote:

> Hello,
>=20
> On Thu, Jan 16, 2025 at 2:26=E2=80=AFAM Karolina Stolarek
> <karolina.stolarek@oracle.com> wrote:
> >
> > On 15/01/2025 08:43, Jon Pan-Doh wrote: =20
> > > Prepare for the addition of new AER sysfs attributes (e.g. ratelimits)
> > > by moving them into their own directory. Update naming to reflect
> > > broader definition and for consistency.
> > >
> > > /sys/bus/pci/devices/<dev>/aer_dev_correctable
> > > /sys/bus/pci/devices/<dev>/aer_dev_fatal
> > > /sys/bus/pci/devices/<dev>/aer_dev_nonfatal
> > > /sys/bus/pci/devices/<dev>/aer_rootport_total_err_cor
> > > /sys/bus/pci/devices/<dev>/aer_rootport_total_err_fatal
> > > /sys/bus/pci/devices/<dev>/aer_rootport_total_err_nonfatal =20
> > > -> =20
> > > /sys/bus/pci/devices/<dev>/aer/err_cor
> > > /sys/bus/pci/devices/<dev>/aer/err_fatal
> > > /sys/bus/pci/devices/<dev>/aer/err_nonfatal
> > > /sys/bus/pci/devices/<dev>/aer/rootport_total_err_cor
> > > /sys/bus/pci/devices/<dev>/aer/rootport_total_err_fatal
> > > /sys/bus/pci/devices/<dev>/aer/rootport_total_err_nonfatal
> > >
> > > Tested using aer-inject[1] tool. Sent 1 AER error. Observed AER stats
> > > correctedly logged (cat /sys/bus/pci/devices/<dev>/aer/dev_err_cor). =
=20
> >
> > I'm not a sysfs expert but my understanding is that we shouldn't do
> > major changes in the existing hierarchies.
> >
> > On one hand, I think it would be nice to extract out AER-specific info
> > and knobs into a subdirectory (e.g., using attribute_group with name
> > "aer"), but on the other this would be disruptive to the userspace. I
> > can imagine that there are tools that watch these values that would
> > break after this change. =20
>=20
> Thank you. This is the right guidance.
>=20
> As the original author to introduce these attributes, I just wanted to
> chime in from the ChromeOS team's perspective (who originally
> introduced these attributes). I can say that we have used these
> attributes for debugging mostly manually, and do not have tools yet
> with hardcoded hierarchy / paths. So we wouldn't be opposed to it, if
> changes to the hierarchy have wider acceptance and it seems better in
> general.

You'd need to be really sure no one is using them or this is
ABI breakage and will need reverting.  If it's been live for a while
then we are in a mess as we have to revert and break new users...

Generally I'd go with don't touch the existing elements.

Jonathan


>=20
> Thanks & Best Regards,
>=20
> Rajat
>=20
>=20
> >
> > All the best,
> > Karolina
> > =20
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inj=
ect.git
> > >
> > > Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> > > ---
> > >   .../ABI/testing/sysfs-bus-pci-devices-aer     | 18 +++---
> > >   drivers/pci/pci-sysfs.c                       |  1 -
> > >   drivers/pci/pci.h                             |  1 -
> > >   drivers/pci/pcie/aer.c                        | 64 +++++++---------=
---
> > >   4 files changed, 32 insertions(+), 52 deletions(-)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer b/Do=
cumentation/ABI/testing/sysfs-bus-pci-devices-aer
> > > index c680a53af0f4..e1472583207b 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> > > +++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> > > @@ -9,7 +9,7 @@ errors may be "seen" / reported by the link partner a=
nd not the
> > >   problematic endpoint itself (which may report all counters as 0 as =
it never
> > >   saw any problems).
> > >
> > > -What:                /sys/bus/pci/devices/<dev>/aer_dev_correctable
> > > +What:                /sys/bus/pci/devices/<dev>/aer/err_cor
> > >   Date:               July 2018
> > >   KernelVersion:      4.19.0
> > >   Contact:    linux-pci@vger.kernel.org, rajatja@google.com
> > > @@ -19,7 +19,7 @@ Description:        List of correctable errors seen=
 and reported by this
> > >               TOTAL_ERR_COR at the end of the file may not match the =
actual
> > >               total of all the errors in the file. Sample output::
> > >
> > > -                 localhost /sys/devices/pci0000:00/0000:00:1c.0 # ca=
t aer_dev_correctable
> > > +                 localhost /sys/devices/pci0000:00/0000:00:1c.0/aer =
# cat err_cor
> > >                   Receiver Error 2
> > >                   Bad TLP 0
> > >                   Bad DLLP 0
> > > @@ -30,7 +30,7 @@ Description:        List of correctable errors seen=
 and reported by this
> > >                   Header Log Overflow 0
> > >                   TOTAL_ERR_COR 2
> > >
> > > -What:                /sys/bus/pci/devices/<dev>/aer_dev_fatal
> > > +What:                /sys/bus/pci/devices/<dev>/aer/err_fatal
> > >   Date:               July 2018
> > >   KernelVersion:      4.19.0
> > >   Contact:    linux-pci@vger.kernel.org, rajatja@google.com
> > > @@ -40,7 +40,7 @@ Description:        List of uncorrectable fatal err=
ors seen and reported by this
> > >               TOTAL_ERR_FATAL at the end of the file may not match th=
e actual
> > >               total of all the errors in the file. Sample output::
> > >
> > > -                 localhost /sys/devices/pci0000:00/0000:00:1c.0 # ca=
t aer_dev_fatal
> > > +                 localhost /sys/devices/pci0000:00/0000:00:1c.0/aer =
# cat err_fatal
> > >                   Undefined 0
> > >                   Data Link Protocol 0
> > >                   Surprise Down Error 0
> > > @@ -60,7 +60,7 @@ Description:        List of uncorrectable fatal err=
ors seen and reported by this
> > >                   TLP Prefix Blocked Error 0
> > >                   TOTAL_ERR_FATAL 0
> > >
> > > -What:                /sys/bus/pci/devices/<dev>/aer_dev_nonfatal
> > > +What:                /sys/bus/pci/devices/<dev>/aer/err_nonfatal
> > >   Date:               July 2018
> > >   KernelVersion:      4.19.0
> > >   Contact:    linux-pci@vger.kernel.org, rajatja@google.com
> > > @@ -70,7 +70,7 @@ Description:        List of uncorrectable nonfatal =
errors seen and reported by this
> > >               TOTAL_ERR_NONFATAL at the end of the file may not match=
 the
> > >               actual total of all the errors in the file. Sample outp=
ut::
> > >
> > > -                 localhost /sys/devices/pci0000:00/0000:00:1c.0 # ca=
t aer_dev_nonfatal
> > > +                 localhost /sys/devices/pci0000:00/0000:00:1c.0/aer =
# cat err_nonfatal
> > >                   Undefined 0
> > >                   Data Link Protocol 0
> > >                   Surprise Down Error 0
> > > @@ -100,19 +100,19 @@ collectors) that are AER capable. These indicat=
e the number of error messages as
> > >   device, so these counters include them and are thus cumulative of a=
ll the error
> > >   messages on the PCI hierarchy originating at that root port.
> > >
> > > -What:                /sys/bus/pci/devices/<dev>/aer_rootport_total_e=
rr_cor
> > > +What:                /sys/bus/pci/devices/<dev>/aer/rootport_total_e=
rr_cor
> > >   Date:               July 2018
> > >   KernelVersion:      4.19.0
> > >   Contact:    linux-pci@vger.kernel.org, rajatja@google.com
> > >   Description:        Total number of ERR_COR messages reported to ro=
otport.
> > >
> > > -What:                /sys/bus/pci/devices/<dev>/aer_rootport_total_e=
rr_fatal
> > > +What:                /sys/bus/pci/devices/<dev>/aer/rootport_total_e=
rr_fatal
> > >   Date:               July 2018
> > >   KernelVersion:      4.19.0
> > >   Contact:    linux-pci@vger.kernel.org, rajatja@google.com
> > >   Description:        Total number of ERR_FATAL messages reported to =
rootport.
> > >
> > > -What:                /sys/bus/pci/devices/<dev>/aer_rootport_total_e=
rr_nonfatal
> > > +What:                /sys/bus/pci/devices/<dev>/aer/rootport_total_e=
rr_nonfatal
> > >   Date:               July 2018
> > >   KernelVersion:      4.19.0
> > >   Contact:    linux-pci@vger.kernel.org, rajatja@google.com
> > > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > > index 41acb6713e2d..e16b92edf3bd 100644
> > > --- a/drivers/pci/pci-sysfs.c
> > > +++ b/drivers/pci/pci-sysfs.c
> > > @@ -1692,7 +1692,6 @@ const struct attribute_group *pci_dev_attr_grou=
ps[] =3D {
> > >       &pci_bridge_attr_group,
> > >       &pcie_dev_attr_group,
> > >   #ifdef CONFIG_PCIEAER
> > > -     &aer_stats_attr_group,
> > >       &aer_attr_group,
> > >   #endif
> > >   #ifdef CONFIG_PCIEASPM
> > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > index 9d0272a890ef..a80cfc08f634 100644
> > > --- a/drivers/pci/pci.h
> > > +++ b/drivers/pci/pci.h
> > > @@ -880,7 +880,6 @@ static inline void of_pci_remove_node(struct pci_=
dev *pdev) { }
> > >   void pci_no_aer(void);
> > >   void pci_aer_init(struct pci_dev *dev);
> > >   void pci_aer_exit(struct pci_dev *dev);
> > > -extern const struct attribute_group aer_stats_attr_group;
> > >   extern const struct attribute_group aer_attr_group;
> > >   void pci_aer_clear_fatal_status(struct pci_dev *dev);
> > >   int pci_aer_clear_status(struct pci_dev *dev);
> > > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > > index e48e2951baae..68850525cc8d 100644
> > > --- a/drivers/pci/pcie/aer.c
> > > +++ b/drivers/pci/pcie/aer.c
> > > @@ -569,13 +569,13 @@ static const char *aer_agent_string[] =3D {
> > >   }                                                                  =
 \
> > >   static DEVICE_ATTR_RO(name)
> > >
> > > -aer_stats_dev_attr(aer_dev_correctable, dev_cor_errs,
> > > +aer_stats_dev_attr(err_cor, dev_cor_errs,
> > >                  aer_correctable_error_string, "ERR_COR",
> > >                  dev_total_cor_errs);
> > > -aer_stats_dev_attr(aer_dev_fatal, dev_fatal_errs,
> > > +aer_stats_dev_attr(err_fatal, dev_fatal_errs,
> > >                  aer_uncorrectable_error_string, "ERR_FATAL",
> > >                  dev_total_fatal_errs);
> > > -aer_stats_dev_attr(aer_dev_nonfatal, dev_nonfatal_errs,
> > > +aer_stats_dev_attr(err_nonfatal, dev_nonfatal_errs,
> > >                  aer_uncorrectable_error_string, "ERR_NONFATAL",
> > >                  dev_total_nonfatal_errs);
> > >
> > > @@ -589,47 +589,13 @@ aer_stats_dev_attr(aer_dev_nonfatal, dev_nonfat=
al_errs,
> > >   }                                                                  =
 \
> > >   static DEVICE_ATTR_RO(name)
> > >
> > > -aer_stats_rootport_attr(aer_rootport_total_err_cor,
> > > +aer_stats_rootport_attr(rootport_total_err_cor,
> > >                        rootport_total_cor_errs);
> > > -aer_stats_rootport_attr(aer_rootport_total_err_fatal,
> > > +aer_stats_rootport_attr(rootport_total_err_fatal,
> > >                        rootport_total_fatal_errs);
> > > -aer_stats_rootport_attr(aer_rootport_total_err_nonfatal,
> > > +aer_stats_rootport_attr(rootport_total_err_nonfatal,
> > >                        rootport_total_nonfatal_errs);
> > >
> > > -static struct attribute *aer_stats_attrs[] __ro_after_init =3D {
> > > -     &dev_attr_aer_dev_correctable.attr,
> > > -     &dev_attr_aer_dev_fatal.attr,
> > > -     &dev_attr_aer_dev_nonfatal.attr,
> > > -     &dev_attr_aer_rootport_total_err_cor.attr,
> > > -     &dev_attr_aer_rootport_total_err_fatal.attr,
> > > -     &dev_attr_aer_rootport_total_err_nonfatal.attr,
> > > -     NULL
> > > -};
> > > -
> > > -static umode_t aer_stats_attrs_are_visible(struct kobject *kobj,
> > > -                                        struct attribute *a, int n)
> > > -{
> > > -     struct device *dev =3D kobj_to_dev(kobj);
> > > -     struct pci_dev *pdev =3D to_pci_dev(dev);
> > > -
> > > -     if (!pdev->aer_info)
> > > -             return 0;
> > > -
> > > -     if ((a =3D=3D &dev_attr_aer_rootport_total_err_cor.attr ||
> > > -          a =3D=3D &dev_attr_aer_rootport_total_err_fatal.attr ||
> > > -          a =3D=3D &dev_attr_aer_rootport_total_err_nonfatal.attr) &&
> > > -         ((pci_pcie_type(pdev) !=3D PCI_EXP_TYPE_ROOT_PORT) &&
> > > -          (pci_pcie_type(pdev) !=3D PCI_EXP_TYPE_RC_EC)))
> > > -             return 0;
> > > -
> > > -     return a->mode;
> > > -}
> > > -
> > > -const struct attribute_group aer_stats_attr_group =3D {
> > > -     .attrs  =3D aer_stats_attrs,
> > > -     .is_visible =3D aer_stats_attrs_are_visible,
> > > -};
> > > -
> > >   #define aer_ratelimit_attr(name, ratelimit)                        =
 \
> > >       static ssize_t                                                 =
 \
> > >       name##_show(struct device *dev, struct device_attribute *attr, =
 \
> > > @@ -662,6 +628,14 @@ aer_ratelimit_attr(ratelimit_cor_log, cor_log_ra=
telimit);
> > >   aer_ratelimit_attr(ratelimit_uncor_log, uncor_log_ratelimit);
> > >
> > >   static struct attribute *aer_attrs[] __ro_after_init =3D {
> > > +     /* Stats */
> > > +     &dev_attr_err_cor.attr,
> > > +     &dev_attr_err_fatal.attr,
> > > +     &dev_attr_err_nonfatal.attr,
> > > +     &dev_attr_rootport_total_err_cor.attr,
> > > +     &dev_attr_rootport_total_err_fatal.attr,
> > > +     &dev_attr_rootport_total_err_nonfatal.attr,
> > > +     /* Ratelimits */
> > >       &dev_attr_ratelimit_cor_irq.attr,
> > >       &dev_attr_ratelimit_uncor_irq.attr,
> > >       &dev_attr_ratelimit_cor_log.attr,
> > > @@ -670,13 +644,21 @@ static struct attribute *aer_attrs[] __ro_after=
_init =3D {
> > >   };
> > >
> > >   static umode_t aer_attrs_are_visible(struct kobject *kobj,
> > > -                                  struct attribute *a, int n)
> > > +                                        struct attribute *a, int n)
> > >   {
> > >       struct device *dev =3D kobj_to_dev(kobj);
> > >       struct pci_dev *pdev =3D to_pci_dev(dev);
> > >
> > >       if (!pdev->aer_info)
> > >               return 0;
> > > +
> > > +     if ((a =3D=3D &dev_attr_rootport_total_err_cor.attr ||
> > > +          a =3D=3D &dev_attr_rootport_total_err_fatal.attr ||
> > > +          a =3D=3D &dev_attr_rootport_total_err_nonfatal.attr) &&
> > > +         ((pci_pcie_type(pdev) !=3D PCI_EXP_TYPE_ROOT_PORT) &&
> > > +          (pci_pcie_type(pdev) !=3D PCI_EXP_TYPE_RC_EC)))
> > > +             return 0;
> > > +
> > >       return a->mode;
> > >   }
> > > =20
> >
> > =20
>=20
>=20


