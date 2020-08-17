Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28352247AAF
	for <lists+linux-pci@lfdr.de>; Tue, 18 Aug 2020 00:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgHQWuZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Aug 2020 18:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgHQWuT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Aug 2020 18:50:19 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4590CC061342;
        Mon, 17 Aug 2020 15:50:19 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id cs12so8647186qvb.2;
        Mon, 17 Aug 2020 15:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=5iPUCDkT6kpRlaYmo6n3eyDdXJDi6YJP5N4VINF97Ok=;
        b=jUaWQNJ39hyxeWMjz1Xc9GhWCDp3Di/XqkZ/uWMC45LmJCfH5NHqXekNdcwlvYcHNb
         ltZAowbk37IGGVWYhoithbDlVDGO5FuLuRf8cj/sT2zXhFUBPqxOo3t9vLBZkNzI1U0Q
         4K0+lZhhNXn30qIIy/jdMGz7OlIyMXevSEx5ZgJ7ybUV4fiQx/TX3DUth5tKktzlhXoC
         S2HRCG/igMd0XChQ+Ngcd3oOnFRT2doyc0hxAs2AnoLINlTvpksC8UbVmYu4QhmoO9oM
         lYCs0MGLbxhhDrrcw9IBr87EMZgQncIkgDnhuajTUSkNwCusrVIX4+8ob/bZ/+1h5/YE
         D3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=5iPUCDkT6kpRlaYmo6n3eyDdXJDi6YJP5N4VINF97Ok=;
        b=YZKNAKu90L5boNXJKyJgoUJP8gck6iGKmmgXkMd77KcX0oGMquJxJjrEhf1zxc0tqv
         xRQZc1fJOVsCcHMI2w2PezC8qzhAIBH1oNYRAGK0/gXMnuA+PTOsycay4tmGO818AKnt
         qUGEsF/RQ7TfF+PVgUY65cIGRLox/oA8WcBAnRPrNGYP3+FZM0u5ghu9T7SbtYiAWhQT
         DLMmTIk3YkU+aX16xoEPyaLl+OwONZq9ZbBrfvEi+LQdKHUlagAfzvWu2ZRc0viSK+Cw
         epfteYUmkU5p3u4FR/0Mh2Z2GAjt0uxIW/uY1sT2dbbhHnBpHJfc6P35c6UhpIbuDUOY
         kSPg==
X-Gm-Message-State: AOAM532LdAhHMgFr4uGVNZqcmm2gr4pF7uurm88EySgRP9F9lMHQQwOj
        Qo0et3LlXZ3/INQHEeaqCHdkQt3Ec3cTEG048ao=
X-Google-Smtp-Source: ABdhPJzRnzluugA/mDtd1PjFACZT8XzOvOb1QEW+VIf7eVsZ9RIlsjNYgxJ9ze8Js53Mk8g5GeJAj+pQwHLruZncMBQ=
X-Received: by 2002:a0c:dd05:: with SMTP id u5mr16362593qvk.143.1597704618177;
 Mon, 17 Aug 2020 15:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200714201540.3139140-1-rajatja@google.com> <CAA93t1rzHbTVCrXhz3YBExJS1FOHBe=GCnns9=q1Ry9zdWb4VA@mail.gmail.com>
 <CACK8Z6EbWikLjDr3xjRqzDNeyk-6Qwe67sOp3hczWd3xSQL3vQ@mail.gmail.com>
In-Reply-To: <CACK8Z6EbWikLjDr3xjRqzDNeyk-6Qwe67sOp3hczWd3xSQL3vQ@mail.gmail.com>
Reply-To: rajatxjain@gmail.com
From:   Rajat Jain <rajatxjain@gmail.com>
Date:   Mon, 17 Aug 2020 15:50:06 -0700
Message-ID: <CAA93t1qkNDRW_AaYzV-sBJPGgYTnM1YKeNMTjOP9FR7Cf2Q7=w@mail.gmail.com>
Subject: Re: [PATCH v5] PCI/ACS: Enable PCI_ACS_TB and disable only when
 needed for ATS
To:     Rajat Jain <rajatja@google.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn,


On Sat, Aug 1, 2020 at 5:30 PM Rajat Jain <rajatja@google.com> wrote:
>
> Hi Bjorn,
>
>
> On Tue, Jul 14, 2020 at 1:24 PM Rajat Jain <rajatxjain@gmail.com> wrote:
> >
> > On Tue, Jul 14, 2020 at 1:15 PM Rajat Jain <rajatja@google.com> wrote:
> > >
> > > The ACS "Translation Blocking" bit blocks the translated addresses from
> > > the devices. We don't expect such traffic from devices unless ATS is
> > > enabled on them. A device sending such traffic without ATS enabled,
> > > indicates malicious intent, and thus should be blocked.
> > >
> > > Enable PCI_ACS_TB by default for all devices, and it stays enabled until
> > > atleast one of the devices downstream wants to enable ATS. It gets
> > > disabled to enable ATS on a device downstream it, and then gets enabled
> > > back on once all the downstream devices don't need ATS.
> > >
> > > Signed-off-by: Rajat Jain <rajatja@google.com>
>
> Just checking to see if you got a chance to look at this V5 patch.

Any feedback on this patch?

Thanks & Best Regards,

Rajat

>
> Thanks & Best Regards,
>
> Rajat
>
> > > ---
> > > Note that I'm ignoring the devices that require quirks to enable or
> > > disable ACS, instead of using the standard way for ACS configuration.
> > > The reason is that it would require adding yet another quirk table or
> > > quirk function pointer, that I don't know how to implement for those
> > > devices, and will neither have the devices to test that code.
> > >
> > > v5: Enable TB and disable ATS for all devices on boot. Disable TB later
> > >     only if needed to enable ATS on downstream devices.
> > > v4: Add braces to avoid warning from kernel robot
> > >     print warning for only external-facing devices.
> > > v3: print warning if ACS_TB not supported on external-facing/untrusted ports.
> > >     Minor code comments fixes.
> > > v2: Commit log change
> > >
> > >  drivers/pci/ats.c   |  5 ++++
> > >  drivers/pci/pci.c   | 57 +++++++++++++++++++++++++++++++++++++++++++++
> > >  drivers/pci/pci.h   |  2 ++
> > >  drivers/pci/probe.c |  2 +-
> > >  include/linux/pci.h |  2 ++
> > >  5 files changed, 67 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> > > index b761c1f72f67..e2ea9083f30f 100644
> > > --- a/drivers/pci/ats.c
> > > +++ b/drivers/pci/ats.c
> > > @@ -28,6 +28,9 @@ void pci_ats_init(struct pci_dev *dev)
> > >                 return;
> > >
> > >         dev->ats_cap = pos;
> > > +
> > > +       dev->ats_enabled = 1; /* To avoid WARN_ON from pci_disable_ats() */
> > > +       pci_disable_ats(dev);
> > >  }
> > >
> > >  /**
> > > @@ -82,6 +85,7 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
> > >         }
> > >         pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
> > >
> > > +       pci_disable_acs_trans_blocking(dev);
> > >         dev->ats_enabled = 1;
> > >         return 0;
> > >  }
> > > @@ -102,6 +106,7 @@ void pci_disable_ats(struct pci_dev *dev)
> > >         ctrl &= ~PCI_ATS_CTRL_ENABLE;
> > >         pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
> > >
> > > +       pci_enable_acs_trans_blocking(dev);
> > >         dev->ats_enabled = 0;
> > >  }
> > >  EXPORT_SYMBOL_GPL(pci_disable_ats);
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 73a862782214..614e3c1e8c56 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -876,6 +876,9 @@ static void pci_std_enable_acs(struct pci_dev *dev)
> > >         /* Upstream Forwarding */
> > >         ctrl |= (cap & PCI_ACS_UF);
> > >
> > > +       /* Translation Blocking */
> > > +       ctrl |= (cap & PCI_ACS_TB);
> > > +
> > >         pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> > >  }
> > >
> > > @@ -904,6 +907,60 @@ static void pci_enable_acs(struct pci_dev *dev)
> > >         pci_disable_acs_redir(dev);
> > >  }
> > >
> > > +void pci_disable_acs_trans_blocking(struct pci_dev *pdev)
> > > +{
> > > +       u16 cap, ctrl, pos;
> > > +       struct pci_dev *dev;
> > > +
> > > +       if (!pci_acs_enable)
> > > +               return;
> > > +
> > > +       for (dev = pdev; dev; dev = pci_upstream_bridge(pdev)) {
> > > +
> > > +               pos = dev->acs_cap;
> > > +               if (!pos)
> > > +                       continue;
> > > +
> > > +               /*
> > > +                * Disable translation blocking when first downstream
> > > +                * device that needs it (for ATS) wants to enable ATS
> > > +                */
> > > +               if (++dev->ats_dependencies == 1) {
> >
> > I am a little worried about a potential race condition here. I know
> > that 2 PCI devices cannot be enumerating at the same time. Do we know
> > if multiple pci_enable_ats() and pci_disable_ats() function calls can
> > be simultaneously executing (even for different devices)? If so, we
> > may need an atomic_t variable for ats_dependencies.
> >
> > Thanks,
> >
> > Rajat
> >
> >
> > > +                       pci_read_config_word(dev, pos + PCI_ACS_CAP, &cap);
> > > +                       pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
> > > +                       ctrl &= ~(cap & PCI_ACS_TB);
> > > +                       pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> > > +               }
> > > +       }
> > > +}
> > > +
> > > +void pci_enable_acs_trans_blocking(struct pci_dev *pdev)
> > > +{
> > > +       u16 cap, ctrl, pos;
> > > +       struct pci_dev *dev;
> > > +
> > > +       if (!pci_acs_enable)
> > > +               return;
> > > +
> > > +       for (dev = pdev; dev; dev = pci_upstream_bridge(pdev)) {
> > > +
> > > +               pos = dev->acs_cap;
> > > +               if (!pos)
> > > +                       continue;
> > > +
> > > +               /*
> > > +                * Enable translation blocking when last downstream device
> > > +                * that depends on it (for ATS), doesn't need ATS anymore
> > > +                */
> > > +               if (--dev->ats_dependencies == 0) {
> > > +                       pci_read_config_word(dev, pos + PCI_ACS_CAP, &cap);
> > > +                       pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
> > > +                       ctrl |= (cap & PCI_ACS_TB);
> > > +                       pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> > > +               }
> > > +       }
> > > +}
> > > +
> > >  /**
> > >   * pci_restore_bars - restore a device's BAR values (e.g. after wake-up)
> > >   * @dev: PCI device to have its BARs restored
> > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > index 12fb79fbe29d..f5d8ecb6ba96 100644
> > > --- a/drivers/pci/pci.h
> > > +++ b/drivers/pci/pci.h
> > > @@ -552,6 +552,8 @@ static inline int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
> > >         return -ENOTTY;
> > >  }
> > >  #endif
> > > +void pci_disable_acs_trans_blocking(struct pci_dev *dev);
> > > +void pci_enable_acs_trans_blocking(struct pci_dev *dev);
> > >
> > >  /* PCI error reporting and recovery */
> > >  pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > index 8c40c00413e7..e2ff3a94e621 100644
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -2387,10 +2387,10 @@ static void pci_init_capabilities(struct pci_dev *dev)
> > >         pci_vpd_init(dev);              /* Vital Product Data */
> > >         pci_configure_ari(dev);         /* Alternative Routing-ID Forwarding */
> > >         pci_iov_init(dev);              /* Single Root I/O Virtualization */
> > > +       pci_acs_init(dev);              /* Access Control Services */
> > >         pci_ats_init(dev);              /* Address Translation Services */
> > >         pci_pri_init(dev);              /* Page Request Interface */
> > >         pci_pasid_init(dev);            /* Process Address Space ID */
> > > -       pci_acs_init(dev);              /* Access Control Services */
> > >         pci_ptm_init(dev);              /* Precision Time Measurement */
> > >         pci_aer_init(dev);              /* Advanced Error Reporting */
> > >         pci_dpc_init(dev);              /* Downstream Port Containment */
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index 7a40cd5caed0..31da4355f0fd 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -480,6 +480,8 @@ struct pci_dev {
> > >         u16             ats_cap;        /* ATS Capability offset */
> > >         u8              ats_stu;        /* ATS Smallest Translation Unit */
> > >  #endif
> > > +       /* Total number of downstream devices below a bridge that need ATS */
> > > +       u8              ats_dependencies;
> > >  #ifdef CONFIG_PCI_PRI
> > >         u16             pri_cap;        /* PRI Capability offset */
> > >         u32             pri_reqs_alloc; /* Number of PRI requests allocated */
> > > --
> > > 2.27.0.389.gc38d7665816-goog
> > >
