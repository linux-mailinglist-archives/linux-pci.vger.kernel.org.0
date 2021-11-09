Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA9444B938
	for <lists+linux-pci@lfdr.de>; Wed, 10 Nov 2021 00:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240198AbhKIXIc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 9 Nov 2021 18:08:32 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:46871 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhKIXIc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Nov 2021 18:08:32 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M3UhQ-1mk1xC1tTe-000dEb for <linux-pci@vger.kernel.org>; Wed, 10 Nov 2021
 00:05:44 +0100
Received: by mail-wm1-f50.google.com with SMTP id z200so553783wmc.1
        for <linux-pci@vger.kernel.org>; Tue, 09 Nov 2021 15:05:44 -0800 (PST)
X-Gm-Message-State: AOAM531a0pf9HdIN15dPJX1rf168cPyAZrxVhbbInwXbcrRzKrsay/a2
        ulM62V7HkYoa6l8vg+kQuVXwrdt9XllksgCOBrE=
X-Google-Smtp-Source: ABdhPJyydwLr2fKa6VYKHPniUxgyBGl18idqK0WC0ICPxHTvaiCopkmtj+TmYYZcehzCLcUKUeCKvHOGQWR05V6I6CM=
X-Received: by 2002:a05:600c:2107:: with SMTP id u7mr11505127wml.82.1636499144157;
 Tue, 09 Nov 2021 15:05:44 -0800 (PST)
MIME-Version: 1.0
References: <ee3884db-da17-39e3-4010-bcc8f878e2f6@xenosoft.de>
 <20211109165848.GA1155989@bhelgaas> <YYr4x1xWfptXRmqt@rocinante>
In-Reply-To: <YYr4x1xWfptXRmqt@rocinante>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 10 Nov 2021 00:05:28 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3fB7KmqWcaenn04WMps=jucV8wOZs=AZcNFHR+o+Bvyg@mail.gmail.com>
Message-ID: <CAK8P3a3fB7KmqWcaenn04WMps=jucV8wOZs=AZcNFHR+o+Bvyg@mail.gmail.com>
Subject: Re: [PASEMI] Nemo board doesn't recognize any ATA disks with the
 pci-v5.16 updates
To:     =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Olof Johansson <olof@lixom.net>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        "bhelgaas@google.com >> Bjorn Helgaas" <bhelgaas@google.com>,
        Matthew Leaman <matthew@a-eon.biz>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christian Zigotzky <info@xenosoft.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:VwzWRxJfyqFn8IsFLdWy/8JzTNKFp67n94v6rat5z1909ajdGMZ
 JzkgiMrJzd9vLtCx3H1I8kzMrPxUXtDoeTnyWVaaA79xvqnv6mPoHhpU13OVaDibm0AVqBG
 I6E557Gi66xA6vN6Pliahuy/GZ0/fK/alWIlZopdGe6VfkPO+cwM99cKP+B9lQbU/FhEPjF
 kmp8IQrbJc/hcOYsWrDLw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AypO1iSDV2E=:KPqRPowbRR7AZuTSrXV9Wy
 2rM1lJuGJuNVXw9inPOhL8Bv7P+m+1ZSDtGI37ryJoBKYe0Nz4hbn8TQrP2CUYSFEKIev884y
 dXzGy2HXIJa0Y2YibPitBesxQJksjucvtsxYUvnH8l+k5I+fVvdbpGpyq9ptVgQfjnA1LDiOJ
 C9ia7QFUV+r0GV3a7BuuzyN6oHoBdzEAr9lK4I9yePjQrCl+BOkdhcENJkIXvrJOpikbgEbRc
 7Cc+w7YwLjQZuZjsfUF+xJcx3tUAsMf2noxfnm6If2ZpImX0E6qIiPVDe4EL2/X6Hp12NnBzr
 GFmlwTc2F8ovilOJEAffP6Jh4LocXtCMD7aSu9yPIr6Q3n1N10sJTkVUqfnS+cilUGiauCIbM
 rgj2Nurq0SGS1lkqefkwil73KHYnXuKeRBp8JuWG3NWvC9khtAC8WgDNxqrjrr3kyto+xYpEp
 WKN3Vffu0R8HfeCH1DT4uwskpSW2F1+Qfa2oRfGP16FqYQY0TbSXK2m3Wt4uIF+IAHooUCPll
 T2s2KjGMd4rIZ0btaiEHLEusNi3bAe6BMCWMggerRkZq2Ik6jkPevLmvLFfL2qVDppPEpAW7f
 rdmVD/XQTX76KgznKKNyf1VctqW6jYGWFbqwh3ziueLWXTDzbFkW/4LIxKaGFLxReB3e23bsY
 0kZhpR1+E2ebdaFjn5xiPQjEYpNDSZ9IoLIjlyxJmBdCTM/xvMxFYt56JE/iIfIIYzK8=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 9, 2021 at 11:40 PM Krzysztof Wilczyński <kw@linux.com> wrote:
> >
> > You could attach the kernel config there, too, since it didn't make it
> > to the mailing list (vger may discard them -- see
> > http://vger.kernel.org/majordomo-info.html).
>
> Bjorn and I looked at which commits that went with a recent Pull Request
> from us might be causing this, but we are a little bit at loss, and were
> hoping that you could give us a hand in troubleshooting this.

For reference, these are the patches in that branch that touch any
interesting files,
as most of the contents are for pci-controller drivers that are not used on
powerpc at all:

$ git log --no-merges --oneline 512b7931ad05..dda4b381f05d
arch/powerpc/ drivers/of/  drivers/pci/*.[ch]  include/linux/
acd61ffb2f16 PCI: Add ACS quirk for Pericom PI7C9X2G switches
978fd0056e19 PCI: of: Allow matching of an interrupt-map local to a PCI device
041284181226 of/irq: Allow matching of an interrupt-map local to an
interrupt controller
0ab8d0f6ae3f irqdomain: Make of_phandle_args_to_fwspec() generally available
5ec0a6fcb60e PCI: Do not enable AtomicOps on VFs
7a41ae80bdcb PCI: pci-bridge-emul: Fix emulation of W1C bits
fd1ae23b495b PCI: Prefer 'unsigned int' over bare 'unsigned'
ff5d3bb6e16d PCI: Remove redundant 'rc' initialization
3331325c6347 PCI/VPD: Use pci_read_vpd_any() in pci_vpd_size()
e1b0d0bb2032 PCI: Re-enable Downstream Port LTR after reset or hotplug
ac8e3cef588c PCI/sysfs: Explicitly show first MSI IRQ for 'irq'
88dee3b0efe4 PCI: Remove unused pci_pool wrappers
b5f9c644eb1b PCI: Remove struct pci_dev->driver
2a4d9408c9e8 PCI: Use to_pci_driver() instead of pci_dev->driver
4141127c44a9 powerpc/eeh: Use to_pci_driver() instead of pci_dev->driver
f9a6c8ad4922 PCI/ERR: Reduce compile time for CONFIG_PCIEAER=n
43e85554d4ed xen/pcifront: Use to_pci_driver() instead of pci_dev->driver
34ab316d7287 xen/pcifront: Drop pcifront_common_process() tests of pcidev, pdrv
9f37ab0412eb PCI/switchtec: Add check of event support
5a72431ec318 powerpc/eeh: Use dev_driver_string() instead of struct
pci_dev->driver->name
ae232f0970ea PCI: Drop pci_device_probe() test of !pci_dev->driver
097d9d414433 PCI: Drop pci_device_remove() test of pci_dev->driver
8e9028b3790d PCI: Return NULL for to_pci_driver(NULL)
357df2fc0066 PCI: Use unsigned to match sscanf("%x") in pci_dev_str_match_path()
bf2928c7a284 PCI/VPD: Add pci_read/write_vpd_any()
b2105b9f39b5 PCI: Correct misspelled and remove duplicated words
7c3855c423b1 PCI: Coalesce host bridge contiguous apertures
e0f7b1922358 PCI: Use kstrtobool() directly, sans strtobool() wrapper
36f354ec7bf9 PCI/sysfs: Return -EINVAL consistently from "store" functions
95e83e219d68 PCI/sysfs: Check CAP_SYS_ADMIN before parsing user input
af9d82626c8f PCI/ACPI: Remove OSC_PCI_SUPPORT_MASKS and OSC_PCI_CONTROL_MASKS
9a0a1417d3bb PCI: Tidy comments
06dc660e6eb8 PCI: Rename pcibios_add_device() to pcibios_device_add()
e3f4bd3462f6 PCI: Mark Atheros QCA6174 to avoid bus reset
3a19407913e8 PCI/P2PDMA: Apply bus offset correctly in DMA address calculation

Out of these, I agree that most of them seem harmless, these would
be the ones I'd try to look at more closely, or maybe revert for testing:

978fd0056e19 PCI: of: Allow matching of an interrupt-map local to a PCI device
041284181226 of/irq: Allow matching of an interrupt-map local to an
interrupt controller
e1b0d0bb2032 PCI: Re-enable Downstream Port LTR after reset or hotplug
7c3855c423b1 PCI: Coalesce host bridge contiguous apertures
3a19407913e8 PCI/P2PDMA: Apply bus offset correctly in DMA address calculation

       Arnd
