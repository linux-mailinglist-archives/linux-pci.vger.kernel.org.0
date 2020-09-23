Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB06274F4D
	for <lists+linux-pci@lfdr.de>; Wed, 23 Sep 2020 04:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgIWCzx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 22:55:53 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:53313 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726655AbgIWCzw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Sep 2020 22:55:52 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id B9137AD6;
        Tue, 22 Sep 2020 22:55:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 22 Sep 2020 22:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=mime-version:references:in-reply-to:from
        :date:message-id:subject:to:cc:content-type; s=fm1; bh=2WduS5iTe
        4bDSDIenxMWPsEFBiL5Mmx6/cOCmz3FrJY=; b=izTVPeAHX7jRMZD7n05aaJA3R
        zPkUB5Fw8GjnMgQxSevUv9+hYvQAVSJjCBQw4TryO1P5Zf/Zbk7Vij2Cq3hsbXXJ
        PSjRdqkF3moQnfhmspnZ4oatj406c5HzgaCgRKB+AAjBiRMaVnXULOojJtP1aSZ9
        MifAR+Ysl0FqTGlpPGOMqmJsv9nRiVa+PtzfqMKVpyHDklhHFl1/6dlMCHcXR0jL
        oniMThtiJmfetT8UbSzIZqAlQ5WRhZTOjPzM1bKOCKgpx7k7FTjS1VlZXMOfc04/
        EMm7sodjUnQqyO4i7T9gBZIpJAB7J2pQKlWXwNs3xYBdZnpxhB1er4v+9TLDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=2WduS5
        iTe4bDSDIenxMWPsEFBiL5Mmx6/cOCmz3FrJY=; b=aW5vo09CWi2Dg+wYM9s351
        8dds2tiAok4PiKX4emb9X+1Wl7dnFPREBJ3tR+hsx165ieTuClHZiHk/tBrpPSnD
        ghrJ6yLaHR4hhhNuVAg1G0msd//eFu62wYGPyKsE+a630ty7ZDEC6HSuNkcqJPPN
        E9gGEOCttdJqpzQlPdNzg6x28pIRRj0I/QvbOLHJEKTAilrlz4Gjp2BmzS5zmPE/
        r4JbBeXxcMwG7qOhSQJqXtRJlAIEiguRl8nRogH+JymP7Qhz6RlWfXZH9+39Wsbt
        5gsTXslZVBI2NwfoLifP4rFkDz5ZMciu3tHAYm0jP+Bc8/Oar6Fw8tbPiR07eJEg
        ==
X-ME-Sender: <xms:N7lqXxpSEa3Xg1cyX84jMrsZNIEhRhs1trOk1imqsnbf8uj3JbqKOQ>
    <xme:N7lqXzptEcQydZIDrLOLkBO-pLMwgnB9kMP9WGkv_-J7aU_l2jQZ2er6wnCX5VexM
    BoTDO_1qCAQ7vf9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudehgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeggfhgjhfffkffuvfgtsehttdertddttdejnecuhfhrohhmpefuvggrnhcuggcu
    mfgvlhhlvgihuceoshgvrghnvhhkrdguvghvsehorhgvghhonhhtrhgrtghkshdrohhrgh
    eqnecuggftrfgrthhtvghrnhepieelhfetgefhvdetkeejieefteffveekgefgheekieeg
    iefhvedtuddtkefhleejnecukfhppedvtdelrdekhedrudeitddrudejudenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvggrnhhvkhdruggv
    vhesohhrvghgohhnthhrrggtkhhsrdhorhhg
X-ME-Proxy: <xmx:N7lqX-P1ZRiJ_v5LDcjTtXDrDl2YzY_T8R0lA6sphStuRd-fvDmfOg>
    <xmx:N7lqX84Pe8qXlkiOhcGfy6Xfv_YNp3X6OkvLZlJIRo28Psuf48VsQw>
    <xmx:N7lqXw6TxDgVHroT2bEJgKqkdptiQZqNH_fKTXWfn4EK9D5pPNzYww>
    <xmx:N7lqX1VNPFhxXBJwdPd1yyXWepfaYe_fVhDOG3aFFpBNs1r9tankDQ>
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by mail.messagingengine.com (Postfix) with ESMTPA id 12AD1306467D;
        Tue, 22 Sep 2020 22:55:51 -0400 (EDT)
Received: by mail-qt1-f171.google.com with SMTP id z2so17484650qtv.12;
        Tue, 22 Sep 2020 19:55:51 -0700 (PDT)
X-Gm-Message-State: AOAM532lEDaTlSi6c4x5KDamiwOBsmwzA3jlRi7cEf+cDTdbJ/LD+FIT
        JlhmkyhNUKrh+LcpmP9dQDdcSk9qDLa4H7q/XSk=
X-Google-Smtp-Source: ABdhPJxlRTwvasGRdm3qwWfQaGfJe4umcm2toVtlHXJZE8Z6eOJkvyV+yno+NNN9pJ6nBhps3z5a79efJhfuZHlLhTg=
X-Received: by 2002:ac8:1ab3:: with SMTP id x48mr7721549qtj.153.1600829750597;
 Tue, 22 Sep 2020 19:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200918204603.62100-1-sean.v.kelley@intel.com>
 <20200918204603.62100-7-sean.v.kelley@intel.com> <20200921122500.000032ff@Huawei.com>
In-Reply-To: <20200921122500.000032ff@Huawei.com>
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
Date:   Tue, 22 Sep 2020 19:55:39 -0700
X-Gmail-Original-Message-ID: <CAAbOPF3=CC2gNjPvNk48=1JpM6v5APF-ksDYbhYua_qA1Ukxjg@mail.gmail.com>
Message-ID: <CAAbOPF3=CC2gNjPvNk48=1JpM6v5APF-ksDYbhYua_qA1Ukxjg@mail.gmail.com>
Subject: Re: [PATCH v5 06/10] PCI/RCEC: Add pcie_link_rcec() to associate RCiEPs
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Sean V Kelley <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 21, 2020 at 4:26 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 18 Sep 2020 13:45:59 -0700
> Sean V Kelley <sean.v.kelley@intel.com> wrote:
>
> > A Root Complex Event Collector provides support for
> > terminating error and PME messages from associated RCiEPs.
> >
> > Make use of the RCEC Endpoint Association Extended Capability
> > to identify associated RCiEPs. Link the associated RCiEPs as
> > the RCECs are enumerated.
> >
> > Co-developed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> A couple of minor things inline plus follow through on not
> special casing the older versions of the capability.
>
> Otherwise looks good to me.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks again for your feedback on v5.  I will be sure to add in v7.
Apologies again for the email server trouble resulting in partial
patch series landing on the list.

Sean

>
> > ---
> >  drivers/pci/pci.h              |  2 +
> >  drivers/pci/pcie/portdrv_pci.c |  3 ++
> >  drivers/pci/pcie/rcec.c        | 96 ++++++++++++++++++++++++++++++++++
> >  include/linux/pci.h            |  1 +
> >  4 files changed, 102 insertions(+)
> >
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 7b547fc3679a..ddb5872466fb 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -474,9 +474,11 @@ static inline void pci_dpc_init(struct pci_dev *pdev) {}
> >  #ifdef CONFIG_PCIEPORTBUS
> >  void pci_rcec_init(struct pci_dev *dev);
> >  void pci_rcec_exit(struct pci_dev *dev);
> > +void pcie_link_rcec(struct pci_dev *rcec);
> >  #else
> >  static inline void pci_rcec_init(struct pci_dev *dev) {}
> >  static inline void pci_rcec_exit(struct pci_dev *dev) {}
> > +static inline void pcie_link_rcec(struct pci_dev *rcec) {}
> >  #endif
> >
> >  #ifdef CONFIG_PCI_ATS
> > diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> > index 4d880679b9b1..dbeb0155c2c3 100644
> > --- a/drivers/pci/pcie/portdrv_pci.c
> > +++ b/drivers/pci/pcie/portdrv_pci.c
> > @@ -110,6 +110,9 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
> >            (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC)))
> >               return -ENODEV;
> >
> > +     if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
> > +             pcie_link_rcec(dev);
> > +
> >       status = pcie_port_device_register(dev);
> >       if (status)
> >               return status;
> > diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
> > index 519ae086ff41..5630480a6659 100644
> > --- a/drivers/pci/pcie/rcec.c
> > +++ b/drivers/pci/pcie/rcec.c
> > @@ -17,6 +17,102 @@
> >
> >  #include "../pci.h"
> >
> > +struct walk_rcec_data {
> > +     struct pci_dev *rcec;
> > +     int (*user_callback)(struct pci_dev *dev, void *data);
> > +     void *user_data;
> > +};
> > +
> > +static bool rcec_assoc_rciep(struct pci_dev *rcec, struct pci_dev *rciep)
> > +{
> > +     unsigned long bitmap = rcec->rcec_ext->bitmap;
> > +     unsigned int devn;
> > +
> > +     /* An RCiEP found on bus in range */
> Perhaps adjust the comment to say:
>         /* An RCiEP found on a different bus in range */
>
> as the actual rcec bus can be in the range as I understand it.
>
> > +     if (rcec->bus->number != rciep->bus->number)
> > +             return true;
> > +
> > +     /* Same bus, so check bitmap */
> > +     for_each_set_bit(devn, &bitmap, 32)
> > +             if (devn == rciep->devfn)
> > +                     return true;
> > +
> > +     return false;
> > +}
> > +
> > +static int link_rcec_helper(struct pci_dev *dev, void *data)
> > +{
> > +     struct walk_rcec_data *rcec_data = data;
> > +     struct pci_dev *rcec = rcec_data->rcec;
> > +
> > +     if ((pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) && rcec_assoc_rciep(rcec, dev)) {
> > +             dev->rcec = rcec;
> > +             pci_dbg(dev, "PME & error events reported via %s\n", pci_name(rcec));
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +void walk_rcec(int (*cb)(struct pci_dev *dev, void *data), void *userdata)
>
> static, or declare it in a header if we are going to need it elsewhere
> later in the series.
>
> > +{
> > +     struct walk_rcec_data *rcec_data = userdata;
> > +     struct pci_dev *rcec = rcec_data->rcec;
> > +     u8 nextbusn, lastbusn;
> > +     struct pci_bus *bus;
> > +     unsigned int bnr;
> > +
> > +     if (!rcec->rcec_cap)
> > +             return;
> > +
> > +     /* Walk own bus for bitmap based association */
> > +     pci_walk_bus(rcec->bus, cb, rcec_data);
> > +
> > +     /* Check whether RCEC BUSN register is present */
> > +     if (rcec->rcec_ext->ver < PCI_RCEC_BUSN_REG_VER)
> > +             return;
>
> If you make earlier suggested change go fill in nextbusn = 0xFF
> for the earlier versions of the capability can avoid special casing
> here.
>
> > +
> > +     nextbusn = rcec->rcec_ext->nextbusn;
> > +     lastbusn = rcec->rcec_ext->lastbusn;
> > +
> > +     /* All RCiEP devices are on the same bus as the RCEC */
> > +     if (nextbusn == 0xff && lastbusn == 0x00)
> > +             return;
> > +
> > +     for (bnr = nextbusn; bnr <= lastbusn; bnr++) {
> > +             /* No association indicated (PCIe 5.0-1, 7.9.10.3) */
> > +             if (bnr == rcec->bus->number)
> > +                     continue;
> > +
> > +             bus = pci_find_bus(pci_domain_nr(rcec->bus), bnr);
> > +             if (!bus)
> > +                     continue;
> > +
> > +             /* Find RCiEP devices on the given bus ranges */
> > +             pci_walk_bus(bus, cb, rcec_data);
> > +     }
> > +}
> > +
> > +/**
> > + * pcie_link_rcec - Link RCiEP devices associating with RCEC.
> > + * @rcec     RCEC whose RCiEP devices should be linked.
> > + *
> > + * Link the given RCEC to each RCiEP device found.
>
> I'm a fusspot on blank lines. The one here doesn't add anything!
>
> > + *
> > + */
> > +void pcie_link_rcec(struct pci_dev *rcec)
> > +{
> > +     struct walk_rcec_data rcec_data;
> > +
> > +     if (!rcec->rcec_cap)
> > +             return;
> > +
> > +     rcec_data.rcec = rcec;
> > +     rcec_data.user_callback = NULL;
> > +     rcec_data.user_data = NULL;
> > +
> > +     walk_rcec(link_rcec_helper, &rcec_data);
> > +}
> > +
> >  void pci_rcec_init(struct pci_dev *dev)
> >  {
> >       u32 rcec, hdr, busn;
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 5c5c4eb642b6..ad382a9484ea 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -330,6 +330,7 @@ struct pci_dev {
> >  #ifdef CONFIG_PCIEPORTBUS
> >       u16             rcec_cap;       /* RCEC capability offset */
> >       struct rcec_ext *rcec_ext;      /* RCEC cached assoc. endpoint extended capabilities */
> > +     struct pci_dev  *rcec;          /* Associated RCEC device */
> >  #endif
> >       u8              pcie_cap;       /* PCIe capability offset */
> >       u8              msi_cap;        /* MSI capability offset */
>
>
