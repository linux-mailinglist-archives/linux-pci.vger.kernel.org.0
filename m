Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5300D44EC7C
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 19:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbhKLSRc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Nov 2021 13:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhKLSRc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Nov 2021 13:17:32 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4452CC061766;
        Fri, 12 Nov 2021 10:14:41 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id s139so19308678oie.13;
        Fri, 12 Nov 2021 10:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k6vBm0W1nCavg671b89cqG0/+cyc/856RwfodNvKark=;
        b=EFsVedSxze2GLqkpELn8gzq1wlGyO5X3+YZOL9gki6dxSFJ8QnLKzQXqHoBIfO4Dez
         Cjj4sLtnP4ikXkHeXeTP05BB3wJq84rXRP/XTiSw+ALB/a7SOrbQGvhM3zjKl7jBpS+K
         b1+63Z1vGywdP8E2QQ+hhzqPidVjZrtq35sXTC7Ti1ZbslcOPUcrGnnqKs47uzmPtefl
         77Lrgg+fq/ZW5wd72QtLBD0kNdU42hHnHBzZFf1BqXaMWkSG8OpTE+HHPMG69tGttNax
         N35hGF6lPEbOVvv4o91+jkyndeYGD0sgHbFNmGHQpEdeTPpHzApIZGSd5M/fT9W9pN7a
         Mdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k6vBm0W1nCavg671b89cqG0/+cyc/856RwfodNvKark=;
        b=AnpUy0I4pO2OfRhxdrDi4inx/KCR8DaYFVXDIJj8eU2PV2xvRV2iGjGUlIWCoPEEGc
         SNiEnSPuSVCWRUd6zxOleRvOFXxrPC2jjKMEPCQIpnEyt2UROmb9dOGAgTkf/uOyS1d0
         iavb4telL0RDI32a+NrNV5DjSvZiArXqVUz0dZQUKuvvfh2wqskpIF6SN8HtmIqAq7Ni
         ErZcEvNHSkCogfbH9Kqxepei0wCC1EsGHYpnRyOHt+tFtficiTiiJVqAEFV3/a4//0IJ
         hvoI62Rs4ol8pQHgEF2pN+qTsSFBb6EZR7uIwJ6WT3fbvt0nss9ZavR7ne2XLV+U6ome
         J8ZQ==
X-Gm-Message-State: AOAM5308DfzCmu5Oot7xK+3a/qxCfLATM5ehbV6NtPtzXBbEhPMnQyro
        NVON+xyT9wVFuahleaT6fbygnODMNZtBjfmuLqA7i/FZzF7jcg==
X-Google-Smtp-Source: ABdhPJzyIERufOnKcfzbsPKtHYY5Hl5iMmrWKTmNMJ8ZnVuPuma6j1kMcLbX33TCunwGhhBFqS8jFHBQiJvnK5xfQAs=
X-Received: by 2002:aca:d608:: with SMTP id n8mr14975866oig.89.1636740880654;
 Fri, 12 Nov 2021 10:14:40 -0800 (PST)
MIME-Version: 1.0
References: <20211110221456.11977-1-jim2101024@gmail.com> <20211110221456.11977-5-jim2101024@gmail.com>
 <YY2sVNEcVmQinbj8@rocinante>
In-Reply-To: <YY2sVNEcVmQinbj8@rocinante>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Fri, 12 Nov 2021 13:14:28 -0500
Message-ID: <CANCKTBuor2xa9zCr1zrVPnFrfWe83qL8kR-pihRYn06rRw4xKw@mail.gmail.com>
Subject: Re: [PATCH v8 4/8] PCI/portdrv: Create pcie_is_port_dev() func from
 existing code
To:     =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 11, 2021 at 6:50 PM Krzysztof Wilczy=C5=84ski <kw@linux.com> wr=
ote:
>
> Hi Jim,
>
> [...]
> > +bool pcie_is_port_dev(struct pci_dev *dev)
> > +{
> > +     int type;
> > +
> > +     if (!dev)
> > +             return false;
> > +
> > +     type =3D pci_pcie_type(dev);
> > +
> > +     return pci_is_pcie(dev) &&
> > +             ((type =3D=3D PCI_EXP_TYPE_ROOT_PORT) ||
> > +              (type =3D=3D PCI_EXP_TYPE_UPSTREAM) ||
> > +              (type =3D=3D PCI_EXP_TYPE_DOWNSTREAM) ||
> > +              (type =3D=3D PCI_EXP_TYPE_RC_EC));
> > +}
> > +EXPORT_SYMBOL_GPL(pcie_is_port_dev);
>
> It would be really nice to document what the above function does (not tha=
t
> some of the logic has been extracted from other function).  You know, for
> the future generations of kernel hackers.

Hi Krzysztof and others,

I gave this a second look and realized that the portdrv's
pci_device_id list for the probe is doing filtering that is not
included in the function.  So perhaps the code must be the following
in order to live up to its name:

static inline bool pci_is_port_dev(struct pci_dev *dev)
{
    int type, class;

    if (!dev || !pci_is_pcie(dev))
        return false;

    class =3D dev->class;

    /* This must be kept in sync with port_pci_ids[] of protdev_pci.c */
    if (!(class =3D=3D ((PCI_CLASS_BRIDGE_PCI << 8) | 0x00) ||
          class =3D=3D ((PCI_CLASS_BRIDGE_PCI << 8) | 0x01) ||
          class =3D=3D ((PCI_CLASS_SYSTEM_RCEC << 8) | 0x00)))
        return false;

    type =3D pci_pcie_type(dev);

    return ((type =3D=3D PCI_EXP_TYPE_ROOT_PORT) ||
        (type =3D=3D PCI_EXP_TYPE_UPSTREAM) ||
        (type =3D=3D PCI_EXP_TYPE_DOWNSTREAM) ||
        (type =3D=3D PCI_EXP_TYPE_RC_EC));
}

Kind of large for an inline, plus the code must be kept in sync with
the device list.   Suggestions?

As for a description, my understanding is that the code identifies a
pci_dev that is directly under a host bridge device.  I'm not really
sure about the PCI_CLASS_SYSTEM_RCEC though.

Regards,
Jim Quinlan
Broadcom STB

>
>         Krzysztof
