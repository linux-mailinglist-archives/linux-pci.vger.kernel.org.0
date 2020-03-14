Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A541185918
	for <lists+linux-pci@lfdr.de>; Sun, 15 Mar 2020 03:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbgCOCeM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Mar 2020 22:34:12 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43171 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgCOCeL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Mar 2020 22:34:11 -0400
Received: by mail-qk1-f194.google.com with SMTP id x1so15192919qkx.10;
        Sat, 14 Mar 2020 19:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n1RmxQ4NZXQ7rw9vMo4F3cQPPCUsvnJCcy5IALIShCI=;
        b=oP4Z84GPd42J+xB8hV62mLO5B+hW+kjw/d0Ue01sGgE8C+xC0goNZqF3fU2Jt0Wm+C
         I28PCupkKSR+y1/T3hmWzEZboVGwEedrEobKE7Qc9gPmr30pAeV7czi2JvxiCeEw0MYZ
         CQzCaMr6nCK1lxlLR3/auCOBh47TNHrc6Ux5dSjQv3E8RnTsUYhm4Jb92bjNnIv+fp+0
         gnH0EbN3+A0J7Mvb3ZRvg97VD8LGwZ82bAJBUkh7NAdbBixnk3nlibxWRRHwUiGWyt0j
         THWvBbqK618A3ELONiM4Cg7g7yKTfiYx2fsDpKxQDA0+S1Oy+Q3UcpZmQPAS6Aw9uJ47
         FyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n1RmxQ4NZXQ7rw9vMo4F3cQPPCUsvnJCcy5IALIShCI=;
        b=iWaQb6uq9k/5OPps38iCptQKvIbSHPeX5JMJdzvP9km7y/1qsqXKN3hgeklISCu4RN
         7FpJGqNISf/F37Q63qJJTcsN3guOA0vWDct0aG/F8f/jckKkIiE4AQzjj6psNsGbRzh8
         HBA4Hpq5lsHBumLDzLBhLyqHakEIDN8V2h3iY50LP6DW6DXvzb1divOseAbSmjYTtsqa
         +bPxcgVTuEyHGgLsnnuCDS/bFuLtyfYOF0g+pABX7yZfioUOnastFcKt64J9zatAvZu8
         1xr9qh7K68tgxzRNiYlQ6PiX5nSdeN02TZnCCVqS8PcEr9Dvy6g8t1OXFamXM2MSpyad
         i70Q==
X-Gm-Message-State: ANhLgQ193b0b2FIPTnEWzLMlFrnDCkGZSY9BnkL4BtmTSUFyLfiYRi/b
        oQZ66gnvaW5Blecz7lCaKNelU0ZDeW59ZUDAHNf0+m1VBFI=
X-Google-Smtp-Source: ADFU+vu+dpZBMmz/9HMPa6mDlQdZaf3RwuRC66msIav98HL0KnSTzuf63QxzQFJxBOd5qVB498hoIjbwuuHOiITumDs=
X-Received: by 2002:a9d:4d97:: with SMTP id u23mr15243945otk.293.1584183117512;
 Sat, 14 Mar 2020 03:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190813204513.4790-1-skunberg.kelsey@gmail.com> <20190815153352.86143-2-skunberg.kelsey@gmail.com>
In-Reply-To: <20190815153352.86143-2-skunberg.kelsey@gmail.com>
From:   Ruslan Bilovol <ruslan.bilovol@gmail.com>
Date:   Sat, 14 Mar 2020 12:51:47 +0200
Message-ID: <CAB=otbSYozS-ZfxB0nCiNnxcbqxwrHOSYxJJtDKa63KzXbXgpw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] PCI: sysfs: Define device attributes with DEVICE_ATTR*
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        bodong@mellanox.com, ddutile@redhat.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rbilovol@cisco.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 15, 2019 at 7:01 PM Kelsey Skunberg
<skunberg.kelsey@gmail.com> wrote:
>
> Defining device attributes should be done through the helper
> DEVICE_ATTR_RO(), DEVICE_ATTR_WO(), or similar. Change all instances using
> __ATTR* to now use its equivalent DEVICE_ATTR*.
>
> Example of old:
>
> static struct device_attribute dev_name_##_attr=__ATTR_RO(_name);
>
> Example of new:
>
> static DEVICE_ATTR_RO(_name);
>
> Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
> ---
>  drivers/pci/pci-sysfs.c | 59 +++++++++++++++++++----------------------
>  1 file changed, 27 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 965c72104150..8af7944fdccb 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -464,9 +464,7 @@ static ssize_t dev_rescan_store(struct device *dev,
>         }
>         return count;
>  }
> -static struct device_attribute dev_rescan_attr = __ATTR(rescan,
> -                                                       (S_IWUSR|S_IWGRP),
> -                                                       NULL, dev_rescan_store);
> +static DEVICE_ATTR(rescan, (S_IWUSR | S_IWGRP), NULL, dev_rescan_store);
>
>  static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
>                             const char *buf, size_t count)
> @@ -480,9 +478,8 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
>                 pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
>         return count;
>  }
> -static struct device_attribute dev_remove_attr = __ATTR_IGNORE_LOCKDEP(remove,
> -                                                       (S_IWUSR|S_IWGRP),
> -                                                       NULL, remove_store);
> +static DEVICE_ATTR_IGNORE_LOCKDEP(remove, (S_IWUSR | S_IWGRP), NULL,
> +                                 remove_store);
>
>  static ssize_t dev_bus_rescan_store(struct device *dev,
>                                     struct device_attribute *attr,
> @@ -504,7 +501,7 @@ static ssize_t dev_bus_rescan_store(struct device *dev,
>         }
>         return count;
>  }
> -static DEVICE_ATTR(rescan, (S_IWUSR|S_IWGRP), NULL, dev_bus_rescan_store);
> +static DEVICE_ATTR(bus_rescan, (S_IWUSR | S_IWGRP), NULL, dev_bus_rescan_store);

This patch renamed 'rescan' to 'bus_rescan' and broke my userspace application.
There is also mismatch now between real functionality and documentation
Documentation/ABI/testing/sysfs-bus-pci which still contains old "rescan"
descriptions.

Another patch from this patch series also renamed 'rescan' to 'dev_rescan'

Here is a comparison between two stable kernels (with and without this
patch series):

v5.4
# find /sys -name '*rescan'
/sys/devices/pci0000:00/0000:00:01.2/dev_rescan
/sys/devices/pci0000:00/0000:00:01.0/dev_rescan
/sys/devices/pci0000:00/0000:00:04.0/dev_rescan
/sys/devices/pci0000:00/0000:00:00.0/dev_rescan
/sys/devices/pci0000:00/pci_bus/0000:00/bus_rescan
/sys/devices/pci0000:00/0000:00:01.3/dev_rescan
/sys/devices/pci0000:00/0000:00:03.0/dev_rescan
/sys/devices/pci0000:00/0000:00:01.1/dev_rescan
/sys/devices/pci0000:00/0000:00:02.0/dev_rescan
/sys/devices/pci0000:00/0000:00:05.0/dev_rescan
/sys/bus/pci/rescan

v4.19
# find /sys -name '*rescan'
/sys/devices/pci0000:00/0000:00:01.2/rescan
/sys/devices/pci0000:00/0000:00:01.0/rescan
/sys/devices/pci0000:00/0000:00:04.0/rescan
/sys/devices/pci0000:00/0000:00:00.0/rescan
/sys/devices/pci0000:00/pci_bus/0000:00/rescan
/sys/devices/pci0000:00/0000:00:01.3/rescan
/sys/devices/pci0000:00/0000:00:03.0/rescan
/sys/devices/pci0000:00/0000:00:01.1/rescan
/sys/devices/pci0000:00/0000:00:02.0/rescan
/sys/devices/pci0000:00/0000:00:05.0/rescan
/sys/bus/pci/rescan

Do we maintain this kind of API as non-changeable?

Thanks,
Ruslan

>
>  #if defined(CONFIG_PM) && defined(CONFIG_ACPI)
>  static ssize_t d3cold_allowed_store(struct device *dev,
> @@ -687,16 +684,14 @@ static ssize_t sriov_drivers_autoprobe_store(struct device *dev,
>         return count;
>  }
>
> -static struct device_attribute sriov_totalvfs_attr = __ATTR_RO(sriov_totalvfs);
> -static struct device_attribute sriov_numvfs_attr =
> -               __ATTR(sriov_numvfs, (S_IRUGO|S_IWUSR|S_IWGRP),
> -                      sriov_numvfs_show, sriov_numvfs_store);
> -static struct device_attribute sriov_offset_attr = __ATTR_RO(sriov_offset);
> -static struct device_attribute sriov_stride_attr = __ATTR_RO(sriov_stride);
> -static struct device_attribute sriov_vf_device_attr = __ATTR_RO(sriov_vf_device);
> -static struct device_attribute sriov_drivers_autoprobe_attr =
> -               __ATTR(sriov_drivers_autoprobe, (S_IRUGO|S_IWUSR|S_IWGRP),
> -                      sriov_drivers_autoprobe_show, sriov_drivers_autoprobe_store);
> +static DEVICE_ATTR_RO(sriov_totalvfs);
> +static DEVICE_ATTR(sriov_numvfs, (S_IRUGO | S_IWUSR | S_IWGRP),
> +                                 sriov_numvfs_show, sriov_numvfs_store);
> +static DEVICE_ATTR_RO(sriov_offset);
> +static DEVICE_ATTR_RO(sriov_stride);
> +static DEVICE_ATTR_RO(sriov_vf_device);
> +static DEVICE_ATTR(sriov_drivers_autoprobe, (S_IRUGO | S_IWUSR | S_IWGRP),
> +                  sriov_drivers_autoprobe_show, sriov_drivers_autoprobe_store);
>  #endif /* CONFIG_PCI_IOV */
>
>  static ssize_t driver_override_store(struct device *dev,
> @@ -792,7 +787,7 @@ static struct attribute *pcie_dev_attrs[] = {
>  };
>
>  static struct attribute *pcibus_attrs[] = {
> -       &dev_attr_rescan.attr,
> +       &dev_attr_bus_rescan.attr,
>         &dev_attr_cpuaffinity.attr,
>         &dev_attr_cpulistaffinity.attr,
>         NULL,
> @@ -820,7 +815,7 @@ static ssize_t boot_vga_show(struct device *dev, struct device_attribute *attr,
>                 !!(pdev->resource[PCI_ROM_RESOURCE].flags &
>                    IORESOURCE_ROM_SHADOW));
>  }
> -static struct device_attribute vga_attr = __ATTR_RO(boot_vga);
> +static DEVICE_ATTR_RO(boot_vga);
>
>  static ssize_t pci_read_config(struct file *filp, struct kobject *kobj,
>                                struct bin_attribute *bin_attr, char *buf,
> @@ -1458,7 +1453,7 @@ static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
>         return count;
>  }
>
> -static struct device_attribute reset_attr = __ATTR(reset, 0200, NULL, reset_store);
> +static DEVICE_ATTR(reset, 0200, NULL, reset_store);
>
>  static int pci_create_capabilities_sysfs(struct pci_dev *dev)
>  {
> @@ -1468,7 +1463,7 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
>         pcie_aspm_create_sysfs_dev_files(dev);
>
>         if (dev->reset_fn) {
> -               retval = device_create_file(&dev->dev, &reset_attr);
> +               retval = device_create_file(&dev->dev, &dev_attr_reset);
>                 if (retval)
>                         goto error;
>         }
> @@ -1553,7 +1548,7 @@ static void pci_remove_capabilities_sysfs(struct pci_dev *dev)
>         pcie_vpd_remove_sysfs_dev_files(dev);
>         pcie_aspm_remove_sysfs_dev_files(dev);
>         if (dev->reset_fn) {
> -               device_remove_file(&dev->dev, &reset_attr);
> +               device_remove_file(&dev->dev, &dev_attr_reset);
>                 dev->reset_fn = 0;
>         }
>  }
> @@ -1606,7 +1601,7 @@ static int __init pci_sysfs_init(void)
>  late_initcall(pci_sysfs_init);
>
>  static struct attribute *pci_dev_dev_attrs[] = {
> -       &vga_attr.attr,
> +       &dev_attr_boot_vga.attr,
>         NULL,
>  };
>
> @@ -1616,7 +1611,7 @@ static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
>         struct device *dev = kobj_to_dev(kobj);
>         struct pci_dev *pdev = to_pci_dev(dev);
>
> -       if (a == &vga_attr.attr)
> +       if (a == &dev_attr_boot_vga.attr)
>                 if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
>                         return 0;
>
> @@ -1624,8 +1619,8 @@ static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
>  }
>
>  static struct attribute *pci_dev_hp_attrs[] = {
> -       &dev_remove_attr.attr,
> -       &dev_rescan_attr.attr,
> +       &dev_attr_remove.attr,
> +       &dev_attr_rescan.attr,
>         NULL,
>  };
>
> @@ -1699,12 +1694,12 @@ static const struct attribute_group pci_dev_hp_attr_group = {
>
>  #ifdef CONFIG_PCI_IOV
>  static struct attribute *sriov_dev_attrs[] = {
> -       &sriov_totalvfs_attr.attr,
> -       &sriov_numvfs_attr.attr,
> -       &sriov_offset_attr.attr,
> -       &sriov_stride_attr.attr,
> -       &sriov_vf_device_attr.attr,
> -       &sriov_drivers_autoprobe_attr.attr,
> +       &dev_attr_sriov_totalvfs.attr,
> +       &dev_attr_sriov_numvfs.attr,
> +       &dev_attr_sriov_offset.attr,
> +       &dev_attr_sriov_stride.attr,
> +       &dev_attr_sriov_vf_device.attr,
> +       &dev_attr_sriov_drivers_autoprobe.attr,
>         NULL,
>  };
>
> --
> 2.20.1
>
