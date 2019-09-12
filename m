Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09550B0E08
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2019 13:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731377AbfILLjr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Sep 2019 07:39:47 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:58668 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731355AbfILLjr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Sep 2019 07:39:47 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190912113944epoutp04fb2232e550b79534460b19cdbab3a8c1~DrfoSP0Yh1722117221epoutp04E
        for <linux-pci@vger.kernel.org>; Thu, 12 Sep 2019 11:39:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190912113944epoutp04fb2232e550b79534460b19cdbab3a8c1~DrfoSP0Yh1722117221epoutp04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568288384;
        bh=FJ3B29g8an95tHNAjyirvuvQH9GQMebjFMmP0dg5AKY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=ezWVyqYLRvHnTJSHI9mw9GwZZyXhPX0VSQfwuKGYEGcNNki4d7C742W0bGzYmoRtf
         grp6sA/JhsXQjQVy64c4X/9Yl4jmYt5/XTJe7aou4z6kreY97dY6On4tCvFy+JMNuK
         9PTRFViZjyD+/OWVPUTDnsDQlEGJQZE0TToUzco4=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20190912113944epcas5p20555df6250f82b84b4e9c10f3b94909d~Drfn6qxjW2668226682epcas5p2o;
        Thu, 12 Sep 2019 11:39:44 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DF.C2.04150.08E2A7D5; Thu, 12 Sep 2019 20:39:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20190912113943epcas5p240c35bbce125c4d67919e7b957b94b5b~DrfnSm5kb1928919289epcas5p2-;
        Thu, 12 Sep 2019 11:39:43 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190912113943epsmtrp269460ba4cc81da1310d315d90eef4334~DrfnR4oy82493524935epsmtrp2d;
        Thu, 12 Sep 2019 11:39:43 +0000 (GMT)
X-AuditID: b6c32a49-a43ff70000001036-f7-5d7a2e80ad83
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.DD.03638.F7E2A7D5; Thu, 12 Sep 2019 20:39:43 +0900 (KST)
Received: from pankajdubey02 (unknown [107.111.85.21]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190912113942epsmtip2bfd6d21c0e07ee6a5ea2d2504b05141b~DrfmFjsS82087020870epsmtip20;
        Thu, 12 Sep 2019 11:39:42 +0000 (GMT)
From:   "Pankaj Dubey" <pankaj.dubey@samsung.com>
To:     "'Andrew Murray'" <andrew.murray@arm.com>
Cc:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Jingoo Han'" <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <lorenzo.pieralisi@arm.com>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Anvesh Salveru'" <anvesh.s@samsung.com>
In-Reply-To: <20190911092310.GN9720@e119886-lin.cambridge.arm.com>
Subject: RE: [PATCH 1/2] PCI: dwc: Add support to disable GEN3 equalization
Date:   Thu, 12 Sep 2019 17:09:41 +0530
Message-ID: <23a601d5695e$c54f2b80$4fed8280$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHkrftp/qePsooAO7EnIOhukMFsOwG9FaICAdZSMiACQwDdlwNi02KNpr+Wp/A=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7bCmpm6DXlWswY87QhbN/7ezWpzdtZDV
        YklThsWuux3sFiu+zGS3uLxrDpvF2XnH2Sze/H7B7sDhsWbeGkaPnbPusnss2FTq0bdlFaPH
        lv2fGT0+b5ILYIvisklJzcksSy3St0vgylj25QxTwVnzirfnl7I3ML7R7GLk5JAQMJE4vu8h
        axcjF4eQwG5GiRX9fxghnE+MEt+/7GQBqRIS+MYosfaKbBcjB1jH1elCEDV7GSUOzH/MBuG8
        ZpTYdOgeG0gDm4C+xLkf81hBbBEBXYmvq56DxZkF/jFKzDtqCDKIU8BJ4vAPGZCwsIC3xKme
        iewgNouAqsTUnkvMIDavgKVE05ZTLBC2oMTJmU9YIMbIS2x/O4cZ4gMFiZ9Pl0Gt8pN4dW49
        I0SNuMTLo0fYQW6TEPjNJvF04l92iAYXib6PXawQtrDEq+NboOJSEp/f7WWDsPMlfiyexAzR
        3MIoMfn4XKgGe4kDV+awgDzALKApsX6XPsQyPone30+YIAHEK9HRJgRRrSbx/fkZqDtlJB42
        L2WCsD0k7u+ayjyBUXEWktdmIXltFpIXZiEsW8DIsopRMrWgODc9tdi0wDAvtVyvODG3uDQv
        XS85P3cTIzgpaXnuYJx1zucQowAHoxIPr4VOVawQa2JZcWXuIUYJDmYlEV6fN5WxQrwpiZVV
        qUX58UWlOanFhxilOViUxHknsV6NERJITyxJzU5NLUgtgskycXBKNTAy9n4/0B0ifWHevh8a
        p+xFbvf4KpX4rbJzdVUqeyBxX357yX+z+79n5xr4iy+XMP8SO+FZnfW9P5LFB29Vr918ZENp
        reW9t4I+j9QeqZvpq1XvPeqrx3jo/qW7XZXNWnNOLD9nz/WO91+duPmT0ycKV86zbbt8QuSF
        zg7lia4bklX2L+efHXNCiaU4I9FQi7moOBEAsIaDCEYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsWy7bCSvG69XlWswa0+LYvm/9tZLc7uWshq
        saQpw2LX3Q52ixVfZrJbXN41h83i7LzjbBZvfr9gd+DwWDNvDaPHzll32T0WbCr16NuyitFj
        y/7PjB6fN8kFsEVx2aSk5mSWpRbp2yVwZSz7coap4Kx5xdvzS9kbGN9odjFycEgImEhcnS7U
        xcjFISSwm1Fiz437LF2MnEBxGYnJq1ewQtjCEiv/PWeHKHrJKLFr91ZmkASbgL7EuR/zwIpE
        BHQlvq56zgZSxCzQwiTRvO8PE0hCSOA0k0Rjvx3INk4BJ4nDP2RAwsIC3hKneiayg9gsAqoS
        U3sugc3kFbCUaNpyigXCFpQ4OfMJC0grs4CeRNtGRpAws4C8xPa3c5ghblOQ+Pl0GdQJfhKv
        zq2HqhGXeHn0CPsERuFZSCbNQpg0C8mkWUg6FjCyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L
        10vOz93ECI4sLa0djCdOxB9iFOBgVOLhfaBZFSvEmlhWXJl7iFGCg1lJhNfnTWWsEG9KYmVV
        alF+fFFpTmrxIUZpDhYlcV75/GORQgLpiSWp2ampBalFMFkmDk6pBsbk25nc3H/XRkqeqjh3
        foUD72ahpM2qs1O5tlQ0L/rD5/nZ/+HBAHaPKdzSS+UfnGJvzMzMeejRa/H40d+sMNb2+utF
        d7sEV69bvvptivGpq3ExXi3mj3zl2abMVd05wYE1/PCKcqmp6/m66pNKnonrGra+/HKAV6i/
        z//XzoIW7a/9Ai+KDZVYijMSDbWYi4oTAdxulaioAgAA
X-CMS-MailID: 20190912113943epcas5p240c35bbce125c4d67919e7b957b94b5b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20190910122514epcas5p4f00c0f999333dd7707c0a353fd06b57f
References: <CGME20190910122514epcas5p4f00c0f999333dd7707c0a353fd06b57f@epcas5p4.samsung.com>
        <1568118302-10505-1-git-send-email-pankaj.dubey@samsung.com>
        <20190910135813.GK9720@e119886-lin.cambridge.arm.com>
        <CAGcde9F6dTGga6Rxo62PPk3AMb3tK8oqo9K6Zi=0TbnFktmQQw@mail.gmail.com>
        <20190911092310.GN9720@e119886-lin.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> From: Andrew Murray <andrew.murray@arm.com>
> 
> On Tue, Sep 10, 2019 at 09:46:28PM +0530, Pankaj Dubey wrote:
> > On Tue, 10 Sep 2019 at 19:56, Andrew Murray <andrew.murray@arm.com>
> wrote:
> > >
> > > On Tue, Sep 10, 2019 at 05:55:01PM +0530, Pankaj Dubey wrote:
> > > > From: Anvesh Salveru <anvesh.s@samsung.com>
> > > >
> > > > In some platforms, PCIe PHY may have issues which will prevent
> > > > linkup to happen in GEN3 or high speed. In case equalization
> > > > fails, link will fallback to GEN1.
> > >
> > > When you refer to "high speed", do you mean "higher speeds" as in
> > > GEN3, GEN4, etc?
> > >
> >
> > Yes. Will reword the commit message as "higher speeds"
> >
> > > >
> > > > Designware controller has support for disabling GEN3 equalization
> > > > if required. This patch enables the designware driver to disable
> > > > the PCIe
> > > > GEN3 equalization by writing into PCIE_PORT_GEN3_RELATED.
> > >
> > > Thus limiting to GEN2 speeds max, right?
> > >
> > > Is the purpose of PORT_LOGIC_GEN3_EQ_DISABLE to disable GEN3 and
> > > above even though we advertise GEN3 and above speeds? I.e. the IP
> > > advertises
> > > GEN3 but the phy can't handle it, we can't change what the IP
> > > advertises and so we disable equalization to limit to GEN2?
> > >
> > > I notice many of the other dwc drivers (dra7xx, keystone, tegra194,
> > > imx6) seem to use the device tree to specify a max-link-speed and
> > > then impose that limit by changing the value in PCI_EXP_LNKCAP. Is
> > > your PORT_LOGIC_GEN3_EQ_DISABLE approach and alternative to the
> > > PCI_EXP_LNKCAP approach, or does your approach add something else?
> > >
> >
> > No, max speed will be still as per advertised by link or it will be
> > equal to the limited speed as per DT property if any.
> > This register will prohibit to perform all phases of equalization and
> > thus allowing link to happen in maximum supported/advertised speed.
> >
> > This is not to limit max link speed, this register helps link to
> > happen in higher speeds (GEN3/4) without going through equalization
> > phases. It is intended to use only if at all link fails to latch up in
> > GEN3/4 due to failure in equalization phases.
> 
> I thought that for GEN3 and beyond equalization was *required* - with only
> phases 2 and 3 being optional. Therefore I'm suprised to see that if
equalization
> does fail we continue to train the link anyway. Have I understood this
correctly?
> 

AFAIK, equalization is not mandatory for GEN3 and higher speed. I mean in
case there is some H/W issue we can still go ahead and disable complete
equalization.

> Also are there any plans to provide patches to use this quirk on any
drivers?
> 

Yes, we have plans and soon the user driver of this feature will land for
review. But I believe this should not be blocker to consider this patch, as
it is a feature provided in Designware H/W and so we can add S/W support for
the same.

> >
> > > >
> > > > Platform drivers can disable equalization by setting the
> > > > dwc_pci_quirk flag DWC_EQUALIZATION_DISABLE.
> > > >
> > > > Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
> > > > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-designware.c | 7 +++++++
> > > > drivers/pci/controller/dwc/pcie-designware.h | 7 +++++++
> > > >  2 files changed, 14 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> > > > b/drivers/pci/controller/dwc/pcie-designware.c
> > > > index 7d25102..bf82091 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > @@ -466,4 +466,11 @@ void dw_pcie_setup(struct dw_pcie *pci)
> > > >               break;
> > > >       }
> > > >       dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> > > > +
> > > > +     val = dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
> > > > +
> > > > +     if (pci->dwc_pci_quirk & DWC_EQUALIZATION_DISABLE)
> > > > +             val |= PORT_LOGIC_GEN3_EQ_DISABLE;
> > > > +
> > > > +     dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
> > >
> > > The problem here is that even when DWC_EQUALIZATION_DISABLE is not
> > > set the driver will read and write PCIE_PORT_GEN3_RELATED when it is
> > > not needed. How about something like:
> > >
> > > > +
> > > > +     if (pci->dwc_pci_quirk & DWC_EQUALIZATION_DISABLE) {
> > > > +             val = dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
> > > > +             val |= PORT_LOGIC_GEN3_EQ_DISABLE;
> > > > +             dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
> > > > +     }
> > >
> >
> > Yes, before posting we taught about it, but then next patchset is
> > adding one more quirk and in that case we need to repeat read and
> > write under each if condition. I hope that repetition should be fine.
> 
> I understand. I think the repetition is prefered over needlessly reading
and
> writing registers.
> 

OK, will handle this in v2.

> Given these quirks are so similar, I wouldn't have a problem with them
being in
> the same patch.
> 

I still prefer to keep these in two separate patches, unless until it is
something mandatory.

> Thanks,
> 
> Andrew Murray
> 
> >
> > > >  }
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> > > > b/drivers/pci/controller/dwc/pcie-designware.h
> > > > index ffed084..a1453c5 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > > @@ -29,6 +29,9 @@
> > > >  #define LINK_WAIT_MAX_IATU_RETRIES   5
> > > >  #define LINK_WAIT_IATU                       9
> > > >
> > > > +/* Parameters for PCIe Quirks */
> > > > +#define DWC_EQUALIZATION_DISABLE     0x1
> > >
> > > How about using BIT(1) instead? Thus implying that you can combine
> > > quirks.
> > >
> >
> > Agreed.
> >
> > > Thanks,
> > >
> > > Andrew Murray
> > >
> > > > +
> > > >  /* Synopsys-specific PCIe configuration registers */
> > > >  #define PCIE_PORT_LINK_CONTROL               0x710
> > > >  #define PORT_LINK_MODE_MASK          GENMASK(21, 16)
> > > > @@ -60,6 +63,9 @@
> > > >  #define PCIE_MSI_INTR0_MASK          0x82C
> > > >  #define PCIE_MSI_INTR0_STATUS                0x830
> > > >
> > > > +#define PCIE_PORT_GEN3_RELATED               0x890
> > > > +#define PORT_LOGIC_GEN3_EQ_DISABLE   BIT(16)
> > > > +
> > > >  #define PCIE_ATU_VIEWPORT            0x900
> > > >  #define PCIE_ATU_REGION_INBOUND              BIT(31)
> > > >  #define PCIE_ATU_REGION_OUTBOUND     0
> > > > @@ -244,6 +250,7 @@ struct dw_pcie {
> > > >       struct dw_pcie_ep       ep;
> > > >       const struct dw_pcie_ops *ops;
> > > >       unsigned int            version;
> > > > +     unsigned int            dwc_pci_quirk;
> > > >  };
> > > >
> > > >  #define to_dw_pcie_from_pp(port) container_of((port), struct
> > > > dw_pcie, pp)
> > > > --
> > > > 2.7.4
> > > >

