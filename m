Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECE285DD2
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2019 11:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbfHHJGb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Aug 2019 05:06:31 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46646 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730777AbfHHJGa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Aug 2019 05:06:30 -0400
Received: by mail-ot1-f65.google.com with SMTP id z23so7467046ote.13;
        Thu, 08 Aug 2019 02:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=34pNCA2fAatpNgW2gdL2L6PIclEzNScEt8bxwQ+wQhw=;
        b=btZ7kWQQ7+ANtWZZv0B8Zmo7GHQyct0e5GJoz2SUmqFBw5okICc3X8pjW217ewd8rP
         tX8Axugdb5ZczQ608pY0Z7daXPJMT9KZsbCp2IdJl5ciRBtQG4NYoC2Za59aboZYK99O
         0kOHoQXfd/CnpLcAEBu6HdpPoi4hecd8Qduk7rqPjVuvpkaTXgbdQSSAKdD5IT1HzyI2
         0DzkyAjb7FXgHYNzP0hGRwPxQV/mI3hh6rECqosAOoEKCWosPZ3eecsSsHJx3+Q/TJM2
         kGxp9upFhpDnA+zA2EGwdP87XSiQgat2RxfE6AxG31947lVx+kepppOamFbdidxYrYoq
         FBbw==
X-Gm-Message-State: APjAAAXiwkCDbdsRixfuTrleg//Eq9wEOAqeVAlC0HSQzawBkx2yAlTA
        JKQ4f5z5qsnFLVZHqhfMvzZZonZC9WPFGkfJl8c=
X-Google-Smtp-Source: APXvYqzj3UqThCxDGgQPBMBDcNMHtdPq2BpaEuppJuuyxhOKl1E6sX2FzFWUaJgpE/jjcNezeJuicOhA12ciL3iufCI=
X-Received: by 2002:aca:cdd3:: with SMTP id d202mr1665889oig.115.1565255189517;
 Thu, 08 Aug 2019 02:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <47415939.KV5G6iaeJG@kreacher> <20190730144134.GA12844@localhost.localdomain>
 <100ba4aff1c6434a81e47774ab4acddc@AUSX13MPC105.AMER.DELL.COM>
 <8246360B-F7D9-42EB-94FC-82995A769E28@canonical.com> <20190730191934.GD13948@localhost.localdomain>
 <7d3e0b8ba1444194a153c93faa1cabb3@AUSX13MPC105.AMER.DELL.COM>
 <20190730213114.GK13948@localhost.localdomain> <CAJZ5v0gxfeMN8eCNRjcXmUOkReVsdozb3EccaYMpnmSHu3771g@mail.gmail.com>
 <20190731221956.GB15795@localhost.localdomain> <2583975.4sIyE3leJj@kreacher> <20190808084804.GA31404@lst.de>
In-Reply-To: <20190808084804.GA31404@lst.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Aug 2019 11:06:17 +0200
Message-ID: <CAJZ5v0hTJKPi1zfB_RjuZ415-JjmK2nVP7mss3npqoB3+Xvy4w@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Allow PCI bus-level PM to be used if ASPM is disabled
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Keith Busch <kbusch@kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 8, 2019 at 10:48 AM Christoph Hellwig <hch@lst.de> wrote:
>
> > -     ndev->last_ps = 0;
> >       ret = nvme_get_power_state(ctrl, &ndev->last_ps);
> > -     if (ret < 0)
> > +     if (ret < 0 || ndev->last_ps == U32_MAX)
>
> Is the intent of the magic U32_MAX check to see if the
> nvme_get_power_state failed at the nvme level?  In that case just
> checking for any non-zero return value from nvme_get_power_state might
> be the easier and more clear way to do it.

Now that I think of that, it appears redundant.  I'll drop it.

>
> > Index: linux-pm/drivers/pci/pcie/aspm.c
> > ===================================================================
> > --- linux-pm.orig/drivers/pci/pcie/aspm.c
> > +++ linux-pm/drivers/pci/pcie/aspm.c
>
> Shouldn't we split PCI vs nvme in two patches?

That can be done.

> > @@ -1170,6 +1170,26 @@ static int pcie_aspm_get_policy(char *bu
> >  module_param_call(policy, pcie_aspm_set_policy, pcie_aspm_get_policy,
> >       NULL, 0644);
> >
> > +/*
> > + * pcie_aspm_enabled - Return the mask of enabled ASPM link states.
> > + * @pci_device: Target device.
> > + */
> > +u32 pcie_aspm_enabled(struct pci_dev *pci_device)
>
> pcie_aspm_enabled sounds like it returns a boolean.  Shouldn't there be
> a mask or so in the name better documenting what it returns?

OK

> > +{
> > +     struct pci_dev *bridge = pci_upstream_bridge(pci_device);
> > +     u32 ret;
> > +
> > +     if (!bridge)
> > +             return 0;
> > +
> > +     mutex_lock(&aspm_lock);
> > +     ret = bridge->link_state ? bridge->link_state->aspm_enabled : 0;
> > +     mutex_unlock(&aspm_lock);
> > +
> > +     return ret;
> > +}
>
> I think this will need a EXPORT_SYMBOL_GPL thrown in so that modular
> nvme continues working.

Right, sorry.

> > +
> > +
> >  #ifdef CONFIG_PCIEASPM_DEBUG
>
> Nit: double blank line here.

Overlooked, will fix.

Thanks!
