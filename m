Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D002D4393D0
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 12:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbhJYKgc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 06:36:32 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:38816
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232927AbhJYKga (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Oct 2021 06:36:30 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1E8EF3FFFA
        for <linux-pci@vger.kernel.org>; Mon, 25 Oct 2021 10:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635158044;
        bh=NWa8u1xqA+kXknAshTbkluDR3q/LaPNaEJOIEVhvOvY=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=A8c2lOMTJjUrU04UoFE+O7DxH9kKBJApEE6eT0sTVRmNLXdDFXwfqjYdWU4cL7DPb
         DMxK2MZx7ObgNCMq7rTF2LvzPEP7Sk5kBPbPZcsgE49o7e8CguH5UnTFBVhk+Vk7o5
         9jfVzjAALUZdpRPlUrcR7bYx77D2iAg9EDkTigvjZcZ7rlUKpHuTsQ30H5i0le6QKm
         MYiZYo+fDJqw0t8jbQVyzVws4L+vR2C5cICJsDwuX42rXbiwMTdijXeWdRj2f+ph+X
         6w9wY6KcpoqTueyUzk3tMzRA3S8gR4iivQDD5aTx7CgBCOAFYM5pENfwteeURuZB/n
         kIxFsX0uglCqA==
Received: by mail-oi1-f197.google.com with SMTP id q82-20020aca4355000000b00299b6e8495cso5506400oia.2
        for <linux-pci@vger.kernel.org>; Mon, 25 Oct 2021 03:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NWa8u1xqA+kXknAshTbkluDR3q/LaPNaEJOIEVhvOvY=;
        b=anC1BxQLUwXi+IHN3djjloMc9kFyA6+yfP4BiYHA/8BXayyjxU8ngfYF1jwq9rS506
         01HMAhMVUa7j5s8RePk42obLFLfSvPrwPMskR5Fk03ZMbRCURGM8d99FosXrE/mWL1rS
         9zGU3yWZNCnZc8bYFX2kIDkxQAtf2MU/kqzZjKQC20DVezGCL2wUP6LUNLEB7vc7ZE3j
         GZ1+c+Kid52v6GFnF8peq0kG16VQgkApG/EWK6S9YXloXdN3HSTdX2wAqQbpKnCQcYI/
         mP1hT3SkYjwY+ryYeYUGl28KNHnxJixT4xSBuA/kMeTG7+tkqszq5rk1V8Pb2URtSQbU
         DqGw==
X-Gm-Message-State: AOAM5303SSabhH+930LeusWOqeBvr7dhC2Ihvc+syRr8S4nE2kaIHGHh
        oGTjiS/KM1n8b0hG+Q8vp/FlxeTh9igRYd22d986j5zZ507JfFVZUH0rgvwn6ABb5GegDawPVXB
        FUGUTxS5UdaoC/WnvtvbDbNSvSuDkVwIYsNi/In6f/+ARvgdxJWCztQ==
X-Received: by 2002:aca:3ad6:: with SMTP id h205mr22065166oia.146.1635158042924;
        Mon, 25 Oct 2021 03:34:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuKzBbKGpJhZzcbfNyVyDC6ItnLcanDHxEbpsXf1pAp+cVQrLNUOvkRoxy0+hpaxacKhLjpf9glLMBx31vXyU=
X-Received: by 2002:aca:3ad6:: with SMTP id h205mr22065145oia.146.1635158042599;
 Mon, 25 Oct 2021 03:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211021035159.1117456-4-kai.heng.feng@canonical.com> <20211021150920.GA2680911@bhelgaas>
In-Reply-To: <20211021150920.GA2680911@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 25 Oct 2021 18:33:50 +0800
Message-ID: <CAAd53p4L+NGQE_Z8u5MBN4X3-3Jmj+FdWp+hGo8mumqsQNoxNg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] PCI/ASPM: Add LTR sysfs attributes
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 21, 2021 at 11:09 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Oct 21, 2021 at 11:51:59AM +0800, Kai-Heng Feng wrote:
> > Sometimes BIOS may not be able to program ASPM and LTR settings, for
> > instance, the NVMe devices behind Intel VMD bridges. For this case, both
> > ASPM and LTR have to be enabled to have significant power saving.
> >
> > Since we still want POLICY_DEFAULT honor the default BIOS ASPM settings,
> > introduce LTR sysfs knobs so users can set max snoop and max nosnoop
> > latency manually or via udev rules.
>
> How is the user supposed to figure out what "max snoop" and "max
> nosnoop" values to program?

Actually, the only way I know is to get the value from other OS.

>
> If we add this, I'm afraid we'll have people programming random things
> that seem to work but are not actually reliable.

IMO users need to take full responsibility for own doings.
Also, it's already doable by using setpci...

If we don't want to add LTR sysfs, what other options do we have to
enable VMD ASPM and LTR by default since BIOS doesn't do it for us?
1) Enable it in the PCI or VMD driver, however this approach violates
POLICY_DEFAULT.
2) Use `setpci` directly in udev rules to enable VMD ASPM and LTR.

I think 2) is bad, and since 1) isn't so good either, the approach in
this patch may be the best compromise.

Kai-Heng

>
> > [1] https://github.com/systemd/systemd/pull/17899/
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=209789
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v2:
> >  - New patch.
> >
> >  drivers/pci/pcie/aspm.c | 59 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> >
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 1560859ab056..f7dc62936445 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -1299,6 +1299,59 @@ static ssize_t clkpm_store(struct device *dev,
> >       return len;
> >  }
> >
> > +static ssize_t ltr_attr_show_common(struct device *dev,
> > +                       struct device_attribute *attr, char *buf, u8 state)
> > +{
> > +     struct pci_dev *pdev = to_pci_dev(dev);
> > +     int ltr;
> > +     u16 val;
> > +
> > +     ltr = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
> > +     if (!ltr)
> > +             return -EINVAL;
> > +
> > +     pci_read_config_word(pdev, ltr + state, &val);
> > +
> > +     return sysfs_emit(buf, "0x%0x\n", val);
> > +}
> > +
> > +static ssize_t ltr_attr_store_common(struct device *dev,
> > +                        struct device_attribute *attr,
> > +                        const char *buf, size_t len, u8 state)
> > +{
> > +     struct pci_dev *pdev = to_pci_dev(dev);
> > +     int ltr;
> > +     u16 val;
> > +
> > +     ltr = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
> > +     if (!ltr)
> > +             return -EINVAL;
> > +
> > +     if (kstrtou16(buf, 16, &val) < 0)
> > +             return -EINVAL;
> > +
> > +     /* LatencyScale is not permitted to be 110 or 111 */
> > +     if ((val >> 10) > 5)
> > +             return -EINVAL;
> > +
> > +     pci_write_config_word(pdev, ltr + state, val);
> > +
> > +     return len;
> > +}
> > +
> > +#define LTR_ATTR(_f, _s)                                             \
> > +static ssize_t _f##_show(struct device *dev,                         \
> > +                      struct device_attribute *attr, char *buf)      \
> > +{ return ltr_attr_show_common(dev, attr, buf, PCI_LTR_##_s); }               \
> > +                                                                     \
> > +static ssize_t _f##_store(struct device *dev,                                \
> > +                       struct device_attribute *attr,                \
> > +                       const char *buf, size_t len)                  \
> > +{ return ltr_attr_store_common(dev, attr, buf, len, PCI_LTR_##_s); }
> > +
> > +LTR_ATTR(ltr_max_snoop_lat, MAX_SNOOP_LAT);
> > +LTR_ATTR(ltr_max_nosnoop_lat, MAX_NOSNOOP_LAT);
> > +
> >  static DEVICE_ATTR_RW(clkpm);
> >  static DEVICE_ATTR_RW(l0s_aspm);
> >  static DEVICE_ATTR_RW(l1_aspm);
> > @@ -1306,6 +1359,8 @@ static DEVICE_ATTR_RW(l1_1_aspm);
> >  static DEVICE_ATTR_RW(l1_2_aspm);
> >  static DEVICE_ATTR_RW(l1_1_pcipm);
> >  static DEVICE_ATTR_RW(l1_2_pcipm);
> > +static DEVICE_ATTR_RW(ltr_max_snoop_lat);
> > +static DEVICE_ATTR_RW(ltr_max_nosnoop_lat);
> >
> >  static struct attribute *aspm_ctrl_attrs[] = {
> >       &dev_attr_clkpm.attr,
> > @@ -1315,6 +1370,8 @@ static struct attribute *aspm_ctrl_attrs[] = {
> >       &dev_attr_l1_2_aspm.attr,
> >       &dev_attr_l1_1_pcipm.attr,
> >       &dev_attr_l1_2_pcipm.attr,
> > +     &dev_attr_ltr_max_snoop_lat.attr,
> > +     &dev_attr_ltr_max_nosnoop_lat.attr,
> >       NULL
> >  };
> >
> > @@ -1338,6 +1395,8 @@ static umode_t aspm_ctrl_attrs_are_visible(struct kobject *kobj,
> >
> >       if (n == 0)
> >               return link->clkpm_capable ? a->mode : 0;
> > +     else if (n == 7 || n == 8)
> > +             return pdev->ltr_path ? a->mode : 0;
> >
> >       return link->aspm_capable & aspm_state_map[n - 1] ? a->mode : 0;
> >  }
> > --
> > 2.32.0
> >
