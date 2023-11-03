Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27DA7DFE24
	for <lists+linux-pci@lfdr.de>; Fri,  3 Nov 2023 03:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjKCCR6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Nov 2023 22:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKCCR6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2023 22:17:58 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2475A196;
        Thu,  2 Nov 2023 19:17:52 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-49d6bd360f8so674026e0c.2;
        Thu, 02 Nov 2023 19:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698977871; x=1699582671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVd/B7XBrOzSs5hPnEN7b8XMGWqh/5oqHOmikTUi/fA=;
        b=HmW8bfXB3YwR+9mzchflQJTgDZ3uB9KMrzOyQMG6fmVYIV0N09eT+02CaoSM6Y+V9F
         y16uALsxiz9hSOhGB5fYk89la8w3r4v5ZH5OOCZGf0GXIe2L0bOB/BDpbkhHX0bKcy1D
         7/UtOWrnLOD7TlVLyIFshmTu9cNyIj5Xh1Mes8lh5+0mI3TdV4dy90tYapSVA96b2A28
         8bfqC6rTWKWBX4sdJ4DxhTOMrF2Kvp6N+4trS2E4yECO3kZFYSfal21J44lqufh27F+2
         snD8bb1nqmWU1n7lCh/qVLm30DmxbQL8poX6vNxIpksHJkbyG2xC4YwzzPggjFNPWP+H
         uitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698977871; x=1699582671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVd/B7XBrOzSs5hPnEN7b8XMGWqh/5oqHOmikTUi/fA=;
        b=F7GpeOjnqMDZ+nr6R2xtfIKptS0ijhvAxzOD06u+OORNbASdcRYa2SukkSsSrVGN4E
         vovM2tpCVXJrDaKFnAq5MG6vhxDxp70ictENYYpKo/DHny2uR/ECQZ8HRafe8eRucrkJ
         s7NxRXUlNrlxNCUKE7XUFn3ogChZbaGFsQJqZa6HPtbjBszaKcrSt5wlL7BusoknhuJ5
         uxfmjjIMztBCJ4ESOZSL37BEe6uTxFl0w8qgEZFB90u3a2yh4N31j9ahvnccpIP8++nf
         RfMpvCzm6tk8zIonaVojLLfO+6IX2evVbjcHLMnoh143LricV/ZwogIbGm1Ty2kPzWfd
         0Zyw==
X-Gm-Message-State: AOJu0YzaQydSxUFDEV6l48bZnuz+Yd72QjoHScRzQyuaKipxyJWVXQvR
        9+koD1lGVXfOsC5JZ4rSrnk/Prw9p000hSmZcYI=
X-Google-Smtp-Source: AGHT+IEwIL/LfZY4jZFVftOBWtjKAhy+/zNxtBhmnyPLvK3Fzs3hjJ60WamOzAaK/zVkcJ0j+XbTOF0RmpRI9d33qVQ=
X-Received: by 2002:a05:6102:1e:b0:45d:6b40:6078 with SMTP id
 j30-20020a056102001e00b0045d6b406078mr2939114vsp.17.1698977871089; Thu, 02
 Nov 2023 19:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231013034158.2745127-2-alistair.francis@wdc.com> <20231019165829.GA1381099@bhelgaas>
In-Reply-To: <20231019165829.GA1381099@bhelgaas>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Fri, 3 Nov 2023 12:17:24 +1000
Message-ID: <CAKmqyKOKX=Nh22RQ6rhKj1p7dpQCfYpVz_LL3MgTmcJ72O5ysQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] PCI/DOE: Expose the DOE features via sysfs
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, lukas@wunner.de,
        alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, chaitanyak@nvidia.com,
        rdunlap@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 20, 2023 at 2:58=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, Oct 13, 2023 at 01:41:57PM +1000, Alistair Francis wrote:
> > The PCIe 6 specification added support for the Data Object Exchange (DO=
E).
> > When DOE is supported the DOE Discovery Feature must be implemented per
> > PCIe r6.1 sec 6.30.1.1. The protocol allows a requester to obtain
> > information about the other DOE features supported by the device.
> > ...
>
> > +static umode_t pci_doe_sysfs_attr_is_visible(struct kobject *kobj,
> > +                                          struct attribute *a, int n)
> > +{
> > +     struct pci_dev *pdev =3D to_pci_dev(kobj_to_dev(kobj));
> > +     struct pci_doe_mb *doe_mb;
> > +     unsigned long index, j;
> > +     void *entry;
> > +
> > +     xa_for_each(&pdev->doe_mbs, index, doe_mb) {
> > +             xa_for_each(&doe_mb->feats, j, entry)
> > +                     return a->mode;
> > +     }
> > +
> > +     return 0;
>
> The nested loops that don't test anything look a little weird and
> maybe I'm missing something, but this looks like it returns a->mode if
> any mailbox with a feature exists, and 0 otherwise.
>
> Is that the same as this:
>
>   if (pdev->doe_mbs)
>     return a->mode;
>
>   return 0;
>
> since it sounds like a mailbox must support at least one feature?

I don't think this is the exact same.

pdev->doe_mbs exist (created by xa_init()) even if there are no
features supported.

I do think it's important we make sure DOE features exist before we
show the property.

>
> > +}
> > +
> > +static struct attribute *pci_dev_doe_feature_attrs[] =3D {
> > +     NULL,
> > +};
> > +
> > +const struct attribute_group pci_dev_doe_feature_group =3D {
> > +     .name   =3D "doe_features",
> > +     .attrs  =3D pci_dev_doe_feature_attrs,
> > +     .is_visible =3D pci_doe_sysfs_attr_is_visible,
> > +};
> > +
> > +static ssize_t pci_doe_sysfs_feature_show(struct device *dev,
> > +                                       struct device_attribute *attr,
> > +                                       char *buf)
> > +{
> > +     return sysfs_emit(buf, "%s\n", attr->attr.name);
> > +}
> > +
> > +static void pci_doe_sysfs_feature_remove(struct pci_dev *pdev,
> > +                                      struct pci_doe_mb *doe_mb)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct device_attribute *attrs =3D doe_mb->sysfs_attrs;
> > +     unsigned long i;
> > +     void *entry;
> > +
> > +     if (!attrs)
> > +             return;
> > +
> > +     doe_mb->sysfs_attrs =3D NULL;
> > +     xa_for_each(&doe_mb->feats, i, entry) {
> > +             if (attrs[i].show)
> > +                     sysfs_remove_file_from_group(&dev->kobj, &attrs[i=
].attr,
> > +                                                  pci_dev_doe_feature_=
group.name);
> > +             kfree(attrs[i].attr.name);
> > +     }
> > +     kfree(attrs);
> > +}
> > +
> > +static int pci_doe_sysfs_feature_populate(struct pci_dev *pdev,
> > +                                       struct pci_doe_mb *doe_mb)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct device_attribute *attrs;
> > +     unsigned long num_features =3D 0;
> > +     unsigned long vid, type;
> > +     unsigned long i;
> > +     void *entry;
> > +     int ret;
> > +
> > +     xa_for_each(&doe_mb->feats, i, entry)
> > +             num_features++;
> > +
> > +     attrs =3D kcalloc(num_features, sizeof(*attrs), GFP_KERNEL);
> > +     if (!attrs)
> > +             return -ENOMEM;
> > +
> > +     doe_mb->sysfs_attrs =3D attrs;
> > +     xa_for_each(&doe_mb->feats, i, entry) {
> > +             sysfs_attr_init(&attrs[i].attr);
> > +             vid =3D xa_to_value(entry) >> 8;
> > +             type =3D xa_to_value(entry) & 0xFF;
> > +             attrs[i].attr.name =3D kasprintf(GFP_KERNEL,
> > +                                            "0x%04lX:%02lX", vid, type=
);
>
> What's the rationale for using "0x" on the vendor ID but not on the
> type?  "0x1234:10" hints that the "10" might be decimal since it lacks
> "0x".
>
> Suggest lower-case "%04lx:%02lx" either way.

Fixed!

>
> FWIW, there's no "0x" prefix on the hex vendor IDs in "lspci -n"
> output and dmesg messages like this:
>
>   pci 0000:01:00.0: [10de:13b6] type 00
>
> > +             if (!attrs[i].attr.name) {
> > +                     ret =3D -ENOMEM;
> > +                     goto fail;
> > +             }
> > +
> > +             attrs[i].attr.mode =3D 0444;
> > +             attrs[i].show =3D pci_doe_sysfs_feature_show;
> > +
> > +             ret =3D sysfs_add_file_to_group(&dev->kobj, &attrs[i].att=
r,
> > +                                           pci_dev_doe_feature_group.n=
ame);
> > +             if (ret) {
> > +                     attrs[i].show =3D NULL;
> > +                     goto fail;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +
> > +fail:
> > +     pci_doe_sysfs_feature_remove(pdev, doe_mb);
> > +     return ret;
>
> Not sure we should treat this failure this seriously.  Looks like it
> will prevent creation of the BAR resource files, and possibly even
> abort pci_sysfs_init() early.  I think the pci_dev will still be
> usable (lacking DOE sysfs) even if this fails.

I can change the call in pci_create_resource_files() to not return?

>
> > +}
> > +
> > +void pci_doe_sysfs_teardown(struct pci_dev *pdev)
> > +{
> > +     struct pci_doe_mb *doe_mb;
> > +     unsigned long index;
> > +
> > +     xa_for_each(&pdev->doe_mbs, index, doe_mb) {
> > +             pci_doe_sysfs_feature_remove(pdev, doe_mb);
> > +     }
> > +}
> > +
> > +int pci_doe_sysfs_init(struct pci_dev *pdev)
> > +{
> > +     struct pci_doe_mb *doe_mb;
> > +     unsigned long index;
> > +     int ret;
> > +
> > +     xa_for_each(&pdev->doe_mbs, index, doe_mb) {
> > +             ret =3D pci_doe_sysfs_feature_populate(pdev, doe_mb);
> > +             if (ret)
> > +                     return ret;
> > +     }
>
> I agree with Lukas that pci_create_resource_files() is not the right
> place to call this.
>
> I try hard to avoid calling *anything* from the
> pci_create_sysfs_dev_files() path because it has the nasty
> "sysfs_initialized" check and the associated pci_sysfs_init()
> initcall.
>
> It's so much cleaner when we can set up static attributes that are
> automatically added in the device_add() path.  I don't know whether
> that's possible.  I see lots of discussion with Greg KH that might be
> related, but I'm not sure.

I don't think it's possible, at least not that I or anyone else has
been able to figure out yet.

>
> I do know that we enumerate the mailboxes and features during
> pci_init_capabilities(), which happens before device_add(), so the
> information about which attributes should be present is at least
> *available* early enough:
>
>   pci_host_probe
>     pci_scan_root_bus_bridge
>       ...
>         pci_scan_single_device
>           pci_device_add
>             pci_init_capabilities
>               pci_doe_init
>                 while (pci_find_next_ext_capability(PCI_EXT_CAP_ID_DOE))
>                   pci_doe_create_mb
>                     pci_doe_cache_features
>                       pci_doe_discovery
>                       xa_insert(&doe_mb->feats)   <--
>             device_add
>               device_add_attrs
>                 device_add_groups
>     pci_bus_add_devices
>       pci_bus_add_device
>         pci_create_sysfs_dev_files
>           ...
>             pci_doe_sysfs_init                    <--
>               xa_for_each(&pdev->doe_mbs)
>                 pci_doe_sysfs_feature_populate
>                   xa_for_each(&doe_mb->feats)
>                     sysfs_add_file_to_group(pci_dev_doe_feature_group.nam=
e)
>
> Is it feasible to build an attribute group in pci_doe_init() and add
> it to dev->groups so device_add() will automatically add them?

That doesn't work as the sysfs_add_file_to_group() function will seg
fault when trying to find the parent as I don't think it exists yet.

[    0.767581] BUG: kernel NULL pointer dereference, address: 0000000000000=
008
[    0.767835] #PF: supervisor read access in kernel mode
[    0.767835] #PF: error_code(0x0000) - not-present page
[    0.767835] PGD 0 P4D 0
[    0.767835] Oops: 0000 [#1] PREEMPT SMP NOPTI
[    0.767835] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
6.6.0-10270-g5dda351a02c8-dirty #10
[    0.767835] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS rel-1.16.2-14-g1e1da7a96300-prebuilt.qemu.org 04/01/2014
[    0.767835] RIP: 0010:kernfs_find_and_get_ns+0x10/0x70
[    0.767835] Code: 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 41 55 49 89 d5 41 54 49 89
f4 55 53 <48> 8b 0
[    0.767835] RSP: 0018:ffff96f9c00138a8 EFLAGS: 00000246
[    0.767835] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00030
[    0.767835] RDX: 0000000000000000 RSI: ffffffffafec53d9 RDI: 00000000000=
00000
[    0.767835] RBP: ffff957b4180e0b8 R08: 0000000000000000 R09: 0000000000f=
fff10
[    0.767835] R10: 0000000000000000 R11: ffffffffaf677c80 R12: ffffffffafe=
c53d9
[    0.767835] R13: 0000000000000000 R14: ffff957b413c1ea0 R15: ffff957b418=
0e000
[    0.767835] FS:  0000000000000000(0000) GS:ffff957bbdc00000(0000)
knlGS:0000000000000000
[    0.767835] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.767835] CR2: 0000000000000008 CR3: 000000004442e000 CR4: 00000000000=
006f0
[    0.767835] Call Trace:
[    0.767835]  <TASK>
[    0.767835]  ? __die+0x1e/0x60
[    0.767835]  ? page_fault_oops+0x17c/0x470
[    0.767835]  ? search_module_extables+0x14/0x50
[    0.767835]  ? exc_page_fault+0x67/0x150
[    0.767835]  ? asm_exc_page_fault+0x26/0x30
[    0.767835]  ? __pfx_pci_mmcfg_read+0x10/0x10
[    0.767835]  ? kernfs_find_and_get_ns+0x10/0x70
[    0.767835]  ? kasprintf+0x5a/0x80
[    0.767835]  sysfs_add_file_to_group+0x4c/0x110
[    0.767835]  pci_doe_sysfs_init+0x13b/0x240
[    0.767835]  pci_device_add+0x1d7/0x620
[    0.767835]  pci_scan_single_device+0xc8/0x100
[    0.767835]  pci_scan_slot+0x6f/0x1e0
[    0.767835]  pci_scan_child_bus_extend+0x30/0x210
[    0.767835]  pci_scan_bridge_extend+0x5f4/0x710
[    0.767835]  pci_scan_child_bus_extend+0xc2/0x210
[    0.767835]  acpi_pci_root_create+0x283/0x2f0
[    0.767835]  pci_acpi_scan_root+0x199/0x200
[    0.767835]  acpi_pci_root_add+0x1ba/0x370
[    0.767835]  acpi_bus_attach+0x140/0x260
[    0.767835]  ? __pfx_acpi_dev_for_one_check+0x10/0x10
[    0.767835]  device_for_each_child+0x68/0xa0
[    0.767835]  acpi_dev_for_each_child+0x37/0x60
[    0.767835]  ? __pfx_acpi_bus_attach+0x10/0x10
[    0.767835]  acpi_bus_attach+0x21e/0x260
[    0.767835]  ? __pfx_acpi_dev_for_one_check+0x10/0x10
[    0.767835]  device_for_each_child+0x68/0xa0
[    0.767835]  acpi_dev_for_each_child+0x37/0x60
[    0.767835]  ? __pfx_acpi_bus_attach+0x10/0x10
[    0.767835]  acpi_bus_attach+0x21e/0x260
[    0.767835]  acpi_bus_scan+0x6b/0x1e0
[    0.767835]  acpi_scan_init+0xdc/0x290
[    0.767835]  acpi_init+0x22b/0x500
[    0.767835]  ? __pfx_acpi_init+0x10/0x10
[    0.767835]  do_one_initcall+0x56/0x220
[    0.767835]  kernel_init_freeable+0x19e/0x2d0
[    0.767835]  ? __pfx_kernel_init+0x10/0x10
[    0.767835]  kernel_init+0x15/0x1b0
[    0.767835]  ret_from_fork+0x2f/0x50
[    0.767835]  ? __pfx_kernel_init+0x10/0x10
[    0.767835]  ret_from_fork_asm+0x1b/0x30

I can move this to pci_create_sysfs_dev_files() instead if that's at
least better?

>
> It looks like __power_supply_register() does something like that:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/power/supply/power_supply_core.c?id=3Dv6.5#n1375
>
> > --- a/include/linux/pci-doe.h
> > +++ b/include/linux/pci-doe.h
> > @@ -22,4 +22,6 @@ int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8=
 type,
> >           const void *request, size_t request_sz,
> >           void *response, size_t response_sz);
> >
> > +int pci_doe_sysfs_init(struct pci_dev *pci_dev);
> > +void pci_doe_sysfs_teardown(struct pci_dev *pdev);
>
> These declarations look like they should be in drivers/pci/pci.h as
> well.  I don't think anything outside the PCI core should need these.

I will move these.

Alistair

>
> Bjorn
