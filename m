Return-Path: <linux-pci+bounces-10336-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45FE931DB0
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 01:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C7D1C21967
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 23:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0B2143755;
	Mon, 15 Jul 2024 23:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJC956mQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF85143733;
	Mon, 15 Jul 2024 23:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721086701; cv=none; b=CLA0oVJxP+iFl6qY1dCIztu8yE4tpB+nyFdryQDPQNmTn8k5S3I/s1EHHsDxTuFRp6ED6OZNNu58nBcL0fmaSPjWCPO3zlgMGOqbOfSxU4kSOyyrwpsy9KyWzUSu3IhXueBYE7UGjBIyKge4s0w3G7dbop99udMfA6EHjPFDfwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721086701; c=relaxed/simple;
	bh=nu1r7SAuNxPlsVDbWbCvJLumEfvKj9pjdr/Eleq4hZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WAdV/V8+LRkDFz3j8GXv5dwAwG7Mxz+F7+YeKY+XKaqqfMIi9rhHHzcAnE/qZR5AKBRm0xugCfRKcvrYGZZekwVBBn5JBtQKNF732xJTMsDNSvKALOcJoN7UA0GsQehNUyxvF7jDjiuQLsq5037CP/tpHjiIWDIDC6ajBnL9gbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJC956mQ; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4f2fd568899so3158977e0c.1;
        Mon, 15 Jul 2024 16:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721086698; x=1721691498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eatGIoU4TUR+zIw/2L0nJc73VD5tWVXBI19BaewDpnI=;
        b=MJC956mQPo+9tQdECKtJyiJYT7BDHS95cS3ncgJPw43pucNrfV0EB7V7Csg1dcATnh
         djcTnRLC/01ma9XzTvN56MEp7xv8N7eylKErGrYMswmZR6l7Hap6SKMFrFbUcJ8tuGoj
         aZGHvruygTQvyOkrHawpO3iHR1Mb8Fm32RLjwgrnA7pogmo50CcA4gGCk/jURV3S1eeG
         gJmnAjl4VCPCJ11VRS1eQvj07xKd510j/3PCSp29BqTp3i5RgrA6lq4MEYezriDCcjvL
         g2d1iGcPYIvqltbsiCXm/5JCQQ7ccuNXTQJ6fU9W14qvMBsitJzyhvWzylBAbk7c9UK4
         k/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721086698; x=1721691498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eatGIoU4TUR+zIw/2L0nJc73VD5tWVXBI19BaewDpnI=;
        b=orP/lc31L64pz3Do5W5g4dd41/OB5cd8lRaLzNtiqolA3SgkQPGbT0EMX+mQ2Psd7Q
         ljlks8MPMSoot89m49P9dDwVWceV4ZUUHNl6QkJJoQp6bDXMwjAlVbFSpXHyN30KfqRR
         3+/s0KgsnAh3Km+b/EWQbBwId+T4G+ctcDb8x56YAXNjK+pOmzXbHCEZGosil1YePD0X
         rwFv9z7+bTvfgWciUa9irFOP8fss0sSqAgUdzJYWhyRcRxB3WhsfV8HA2Q3cjuTABHXC
         68NQbm8rMxvXmTWsm7iya0IMQB4JJjjG3/5QjipriUdtkiHFphe5qjEwUxPfAU4OdEWk
         lfEg==
X-Forwarded-Encrypted: i=1; AJvYcCXTn51mgRkULrpWPeg4+BxnQ5ALZryENQBUpEuA3VY3lZ4O9ef84NbAQbgcAflOAoFzgRibohw5aPBeg5Tc3UPF+oGcjDeDqg2ifWHQaNEqdzj8WN5YMIaV74iQ5+Mv/hP76kvf7nOs
X-Gm-Message-State: AOJu0Yyvx6vPPEgECYyG9oEIYzuIGMDtgNbK029IKH/GUWAdNEwlgRx9
	ORuOgqVcnsJAdmoQGglwNf/T7+1esTCKtTuN1EToYaaSOef5fS2gl70ExFvcCiPdSb01t/IsYyS
	FchnEyq+13YMCvOAqAC3kMjMu0ko=
X-Google-Smtp-Source: AGHT+IE1DrqfRb7e9mAPrKhI9qAORKxjpvWMfS9uFnhTJ/CBkf8MR6ga7pTyWkyM7cza8Q0g189RjszVBwUOde+XJ+Q=
X-Received: by 2002:ac5:c910:0:b0:4f2:ec73:ed42 with SMTP id
 71dfb90a1353d-4f4d1bb8ef4mr81347e0c.4.1721086697183; Mon, 15 Jul 2024
 16:38:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710023310.480713-1-alistair.francis@wdc.com> <20240710023310.480713-3-alistair.francis@wdc.com>
In-Reply-To: <20240710023310.480713-3-alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jul 2024 09:37:51 +1000
Message-ID: <CAKmqyKNwLNoVP2gsx5t-dNx_CZCf6tXPJLCU6V9m5i-i3=hNug@mail.gmail.com>
Subject: Re: [PATCH v14 3/4] PCI/DOE: Expose the DOE features via sysfs
To: bhelgaas@google.com, linux-pci@vger.kernel.org, 
	Jonathan.Cameron@huawei.com, lukas@wunner.de
Cc: alex.williamson@redhat.com, christian.koenig@amd.com, kch@nvidia.com, 
	gregkh@linuxfoundation.org, logang@deltatee.com, linux-kernel@vger.kernel.org, 
	chaitanyak@nvidia.com, rdunlap@infradead.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 12:33=E2=80=AFPM Alistair Francis <alistair23@gmail=
.com> wrote:
>
> The PCIe 6 specification added support for the Data Object
> Exchange (DOE).
> When DOE is supported the DOE Discovery Feature must be implemented per
> PCIe r6.1 sec 6.30.1.1. The protocol allows a requester to obtain
> information about the other DOE features supported by the device.
>
> The kernel is already querying the DOE features supported and cacheing
> the values. Expose the values in sysfs to allow user space to
> determine which DOE features are supported by the PCIe device.
>
> By exposing the information to userspace tools like lspci can relay the
> information to users. By listing all of the supported features we can
> allow userspace to parse the list, which might include
> vendor specific features as well as yet to be supported features.
>
> As the DOE Discovery feature must always be supported we treat it as a
> special named attribute case. This allows the usual PCI attribute_group
> handling to correctly create the doe_features directory when registering
> pci_doe_sysfs_group (otherwise it doesn't and sysfs_add_file_to_group()
> will seg fault).
>
> After this patch is supported you can see something like this when
> attaching a DOE device
>
> $ ls /sys/devices/pci0000:00/0000:00:02.0//doe*
> 0001:01        0001:02        doe_discovery
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v14:
>  - Revert back to v12 with extra pci_remove_resource_files() call

Using dev->groups and device_add() path as discussed earlier [1]
doesn't work as the pci_doe_sysfs_group is global.

It is possible to create a global pci_doe_sysfs_group that contains
all possible DOE entries on the system and then have the show
functions determine if they should be displayed for that device.

That would require that everytime we call pci_doe_init() we can check
for any missing entries in pci_doe_sysfs_group.attrs and then
reallocpci_doe_sysfs_group.attrs to add them.

It's complex and clunky so we are sticking with the
pci_remove_resource_files() implementation. See [2] for some more
details on this

1: https://lore.kernel.org/all/20231019165829.GA1381099@bhelgaas/
2: https://patchwork-proxy.ozlabs.org/project/linux-pci/patch/2024070206041=
8.387500-3-alistair.francis@wdc.com/


> v13:
>  - Drop pci_doe_sysfs_init() and use pci_doe_sysfs_group
>      - As discussed in https://lore.kernel.org/all/20231019165829.GA13810=
99@bhelgaas/
>        we can just modify pci_doe_sysfs_group at the DOE init and let
>        device_add() handle the sysfs attributes.
> v12:
>  - Drop pci_doe_features_sysfs_attr_visible()
> v11:
>  - Gracefully handle multiple entried of same feature
>  - Minor fixes and code cleanups
> v10:
>  - Rebase to use DEFINE_SYSFS_GROUP_VISIBLE and remove
>    special setup function
> v9:
>  - Add a teardown function
>  - Rename functions to be clearer
>  - Tidy up the commit message
>  - Remove #ifdef from header
> v8:
>  - Inlucde an example in the docs
>  - Fixup removing a file that wasn't added
>  - Remove a blank line
> v7:
>  - Fixup the #ifdefs to keep the test robot happy
> v6:
>  - Use "feature" instead of protocol
>  - Don't use any devm_* functions
>  - Add two more patches to the series
> v5:
>  - Return the file name as the file contents
>  - Code cleanups and simplifications
> v4:
>  - Fixup typos in the documentation
>  - Make it clear that the file names contain the information
>  - Small code cleanups
>  - Remove most #ifdefs
>  - Remove extra NULL assignment
> v3:
>  - Expose each DOE feature as a separate file
> v2:
>  - Add documentation
>  - Code cleanups
>
>
>  Documentation/ABI/testing/sysfs-bus-pci |  28 +++++
>  drivers/pci/doe.c                       | 151 ++++++++++++++++++++++++
>  drivers/pci/pci-sysfs.c                 |  15 +++
>  drivers/pci/pci.h                       |  10 ++
>  4 files changed, 204 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/=
testing/sysfs-bus-pci
> index ecf47559f495..65a3238ab701 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -500,3 +500,31 @@ Description:
>                 console drivers from the device.  Raw users of pci-sysfs
>                 resourceN attributes must be terminated prior to resizing=
.
>                 Success of the resizing operation is not guaranteed.
> +
> +What:          /sys/bus/pci/devices/.../doe_features
> +Date:          May 2024
> +Contact:       Linux PCI developers <linux-pci@vger.kernel.org>
> +Description:
> +               This directory contains a list of the supported
> +               Data Object Exchange (DOE) features. The features are
> +               the file name. The contents of each file is the raw vendo=
r id and
> +               data object feature values.
> +
> +               The value comes from the device and specifies the vendor =
and
> +               data object type supported. The lower (RHS of the colon) =
is
> +               the data object type in hex. The upper (LHS of the colon)
> +               is the vendor ID.
> +
> +               As all DOE devices must support the DOE discovery protoco=
l, if
> +               DOE is supported you will at least see the doe_discovery =
file, with
> +               this contents
> +
> +               # cat doe_features/doe_discovery
> +               0001:00
> +
> +               If the device supports other protocols you will see other=
 files
> +               as well. For example is CMA/SPDM and secure CMA/SPDM are =
supported
> +               the doe_features directory will look like this
> +
> +               # ls doe_features
> +               0001:01        0001:02        doe_discovery
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index defc4be81bd4..580370dc71ee 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -14,6 +14,7 @@
>
>  #include <linux/bitfield.h>
>  #include <linux/delay.h>
> +#include <linux/device.h>
>  #include <linux/jiffies.h>
>  #include <linux/mutex.h>
>  #include <linux/pci.h>
> @@ -47,6 +48,7 @@
>   * @wq: Wait queue for work item
>   * @work_queue: Queue of pci_doe_work items
>   * @flags: Bit array of PCI_DOE_FLAG_* flags
> + * @sysfs_attrs: Array of sysfs device attributes
>   */
>  struct pci_doe_mb {
>         struct pci_dev *pdev;
> @@ -56,6 +58,10 @@ struct pci_doe_mb {
>         wait_queue_head_t wq;
>         struct workqueue_struct *work_queue;
>         unsigned long flags;
> +
> +#ifdef CONFIG_SYSFS
> +       struct device_attribute *sysfs_attrs;
> +#endif
>  };
>
>  struct pci_doe_feature {
> @@ -92,6 +98,151 @@ struct pci_doe_task {
>         struct pci_doe_mb *doe_mb;
>  };
>
> +#ifdef CONFIG_SYSFS
> +static ssize_t doe_discovery_show(struct device *dev,
> +                                 struct device_attribute *attr,
> +                                 char *buf)
> +{
> +       return sysfs_emit(buf, "0001:00\n");
> +}
> +DEVICE_ATTR_RO(doe_discovery);
> +
> +static struct attribute *pci_doe_sysfs_feature_attrs[] =3D {
> +       &dev_attr_doe_discovery.attr,
> +       NULL
> +};
> +
> +static bool pci_doe_features_sysfs_group_visible(struct kobject *kobj)
> +{
> +       struct pci_dev *pdev =3D to_pci_dev(kobj_to_dev(kobj));
> +       struct pci_doe_mb *doe_mb;
> +       unsigned long index;
> +
> +       xa_for_each(&pdev->doe_mbs, index, doe_mb) {
> +               if (!xa_empty(&doe_mb->feats))
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(pci_doe_features_sysfs)
> +
> +const struct attribute_group pci_doe_sysfs_group =3D {
> +       .name       =3D "doe_features",
> +       .attrs      =3D pci_doe_sysfs_feature_attrs,
> +       .is_visible =3D SYSFS_GROUP_VISIBLE(pci_doe_features_sysfs),
> +};
> +
> +static ssize_t pci_doe_sysfs_feature_show(struct device *dev,
> +                                         struct device_attribute *attr,
> +                                         char *buf)
> +{
> +       return sysfs_emit(buf, "%s\n", attr->attr.name);
> +}
> +
> +static void pci_doe_sysfs_feature_remove(struct pci_dev *pdev,
> +                                        struct pci_doe_mb *doe_mb)
> +{
> +       struct device_attribute *attrs =3D doe_mb->sysfs_attrs;
> +       struct device *dev =3D &pdev->dev;
> +       unsigned long i;
> +       void *entry;
> +
> +       if (!attrs)
> +               return;
> +
> +       doe_mb->sysfs_attrs =3D NULL;
> +       xa_for_each(&doe_mb->feats, i, entry) {
> +               if (attrs[i].show)
> +                       sysfs_remove_file_from_group(&dev->kobj, &attrs[i=
].attr,
> +                                                    pci_doe_sysfs_group.=
name);
> +               kfree(attrs[i].attr.name);
> +       }
> +       kfree(attrs);
> +}
> +
> +static int pci_doe_sysfs_feature_populate(struct pci_dev *pdev,
> +                                         struct pci_doe_mb *doe_mb)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct device_attribute *attrs;
> +       unsigned long num_features =3D 0;
> +       unsigned long vid, type;
> +       unsigned long i;
> +       void *entry;
> +       int ret;
> +
> +       xa_for_each(&doe_mb->feats, i, entry)
> +               num_features++;
> +
> +       attrs =3D kcalloc(num_features, sizeof(*attrs), GFP_KERNEL);
> +       if (!attrs)
> +               return -ENOMEM;
> +
> +       doe_mb->sysfs_attrs =3D attrs;
> +       xa_for_each(&doe_mb->feats, i, entry) {
> +               sysfs_attr_init(&attrs[i].attr);
> +               vid =3D xa_to_value(entry) >> 8;
> +               type =3D xa_to_value(entry) & 0xFF;
> +
> +               if (vid =3D=3D 0x01 && type =3D=3D 0x00) {
> +                       /* DOE Discovery, manually displayed by `dev_attr=
_doe_discovery` */
> +                       continue;
> +               }
> +
> +               attrs[i].attr.name =3D kasprintf(GFP_KERNEL,
> +                                              "%04lx:%02lx", vid, type);
> +               if (!attrs[i].attr.name) {
> +                       ret =3D -ENOMEM;
> +                       goto fail;
> +               }
> +
> +               attrs[i].attr.mode =3D 0444;
> +               attrs[i].show =3D pci_doe_sysfs_feature_show;
> +
> +               ret =3D sysfs_add_file_to_group(&dev->kobj, &attrs[i].att=
r,
> +                                             pci_doe_sysfs_group.name);
> +               if (ret) {
> +                       attrs[i].show =3D NULL;
> +                       if (ret !=3D -EEXIST)
> +                               goto fail;
> +                       else
> +                               kfree(attrs[i].attr.name);
> +               }
> +       }
> +
> +       return 0;
> +
> +fail:
> +       pci_doe_sysfs_feature_remove(pdev, doe_mb);
> +       return ret;
> +}
> +
> +void pci_doe_sysfs_teardown(struct pci_dev *pdev)
> +{
> +       struct pci_doe_mb *doe_mb;
> +       unsigned long index;
> +
> +       xa_for_each(&pdev->doe_mbs, index, doe_mb)
> +               pci_doe_sysfs_feature_remove(pdev, doe_mb);
> +}
> +
> +int pci_doe_sysfs_init(struct pci_dev *pdev)
> +{
> +       struct pci_doe_mb *doe_mb;
> +       unsigned long index;
> +       int ret;
> +
> +       xa_for_each(&pdev->doe_mbs, index, doe_mb) {
> +               ret =3D pci_doe_sysfs_feature_populate(pdev, doe_mb);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +#endif
> +
>  static int pci_doe_wait(struct pci_doe_mb *doe_mb, unsigned long timeout=
)
>  {
>         if (wait_event_timeout(doe_mb->wq,
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 40cfa716392f..db795bfe3c56 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -16,6 +16,7 @@
>  #include <linux/kernel.h>
>  #include <linux/sched.h>
>  #include <linux/pci.h>
> +#include <linux/pci-doe.h>
>  #include <linux/stat.h>
>  #include <linux/export.h>
>  #include <linux/topology.h>
> @@ -1143,6 +1144,9 @@ static void pci_remove_resource_files(struct pci_de=
v *pdev)
>  {
>         int i;
>
> +       if (IS_ENABLED(CONFIG_PCI_DOE))
> +               pci_doe_sysfs_teardown(pdev);
> +
>         for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
>                 struct bin_attribute *res_attr;
>
> @@ -1227,6 +1231,14 @@ static int pci_create_resource_files(struct pci_de=
v *pdev)
>         int i;
>         int retval;
>
> +       if (IS_ENABLED(CONFIG_PCI_DOE)) {
> +               retval =3D pci_doe_sysfs_init(pdev);
> +               if (retval) {
> +                       pci_remove_resource_files(pdev);
> +                       return retval;
> +               }
> +       }
> +
>         /* Expose the PCI resources from this device as files */
>         for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
>
> @@ -1661,6 +1673,9 @@ const struct attribute_group *pci_dev_attr_groups[]=
 =3D {
>  #endif
>  #ifdef CONFIG_PCIEASPM
>         &aspm_ctrl_attr_group,
> +#endif
> +#ifdef CONFIG_PCI_DOE
> +       &pci_doe_sysfs_group,
>  #endif
>         NULL,
>  };
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index fd44565c4756..3aee231dcb0c 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -189,6 +189,7 @@ extern const struct attribute_group *pci_dev_groups[]=
;
>  extern const struct attribute_group *pci_dev_attr_groups[];
>  extern const struct attribute_group *pcibus_groups[];
>  extern const struct attribute_group *pci_bus_groups[];
> +extern const struct attribute_group pci_doe_sysfs_group;
>  #else
>  static inline int pci_create_sysfs_dev_files(struct pci_dev *pdev) { ret=
urn 0; }
>  static inline void pci_remove_sysfs_dev_files(struct pci_dev *pdev) { }
> @@ -196,6 +197,7 @@ static inline void pci_remove_sysfs_dev_files(struct =
pci_dev *pdev) { }
>  #define pci_dev_attr_groups NULL
>  #define pcibus_groups NULL
>  #define pci_bus_groups NULL
> +#define pci_doe_sysfs_group NULL
>  #endif
>
>  extern unsigned long pci_hotplug_io_size;
> @@ -333,6 +335,14 @@ static inline void pci_doe_destroy(struct pci_dev *p=
dev) { }
>  static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
>  #endif
>
> +#if defined(CONFIG_PCI_DOE) && defined(CONFIG_SYSFS)
> +int pci_doe_sysfs_init(struct pci_dev *pci_dev);
> +void pci_doe_sysfs_teardown(struct pci_dev *pdev);
> +#else
> +static inline int pci_doe_sysfs_init(struct pci_dev *pdev) { return 0; }
> +static inline void pci_doe_sysfs_teardown(struct pci_dev *pdev) { }
> +#endif
> +
>  /**
>   * pci_dev_set_io_state - Set the new error state if possible.
>   *
> --
> 2.45.2
>

