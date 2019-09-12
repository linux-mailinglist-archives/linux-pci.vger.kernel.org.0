Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10F83B0E32
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2019 13:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbfILLpD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Sep 2019 07:45:03 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:25256 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730454AbfILLpD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Sep 2019 07:45:03 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190912114459epoutp02c4d872afabd4d97c6a84170f019b7057~DrkNOufTN0445904459epoutp02F
        for <linux-pci@vger.kernel.org>; Thu, 12 Sep 2019 11:44:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190912114459epoutp02c4d872afabd4d97c6a84170f019b7057~DrkNOufTN0445904459epoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568288699;
        bh=vMENaR9B8BHnzZviypx8NCdd3+Dx8BLuVaaHmhNr/ho=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=pwZQOAaS0CLHI0ZbPKYTqjhCyK7fP2RfKS6gydjlNLDHHu93aFtveg/nUI1sPfL7f
         mHMHWsFFjaNTVROrGhdj5ThenfspB+GFysFcAKWJkLNxFodnFsYNNge+p4hWoz5Va6
         G0heW3xlYwM7LqabfPH+CNYvySLrlDgCcWb910JQ=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20190912114458epcas5p4e3b6a74007c7b6ff108ce910587ff60f~DrkMVmcUZ1345913459epcas5p4C;
        Thu, 12 Sep 2019 11:44:58 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.A3.04150.ABF2A7D5; Thu, 12 Sep 2019 20:44:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20190912114457epcas5p3583f05a2afb308b54f44ace2cc803e60~DrkLhIta92662026620epcas5p39;
        Thu, 12 Sep 2019 11:44:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190912114457epsmtrp1436d255d8900f29a80d1aa24a9b4479f~DrkLgYaQQ1846618466epsmtrp1U;
        Thu, 12 Sep 2019 11:44:57 +0000 (GMT)
X-AuditID: b6c32a49-a5bff70000001036-0a-5d7a2fba1418
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BA.0D.03706.9BF2A7D5; Thu, 12 Sep 2019 20:44:57 +0900 (KST)
Received: from pankajdubey02 (unknown [107.111.85.21]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190912114456epsmtip1bd2ed9030e341c49ccd64436466d31f4~DrkKOnUEA0370503705epsmtip1f;
        Thu, 12 Sep 2019 11:44:56 +0000 (GMT)
From:   "Pankaj Dubey" <pankaj.dubey@samsung.com>
To:     "'Andrew Murray'" <andrew.murray@arm.com>
Cc:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Jingoo Han'" <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <lorenzo.pieralisi@arm.com>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Anvesh Salveru'" <anvesh.s@samsung.com>
In-Reply-To: <20190911092710.GO9720@e119886-lin.cambridge.arm.com>
Subject: RE: [PATCH 2/2] PCI: dwc: Add support to disable equalization phase
 2 and 3
Date:   Thu, 12 Sep 2019 17:14:53 +0530
Message-ID: <23be01d5695f$804e4380$80eaca80$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG9FaICAAHvETL7ZYFipwvZlNiGfgIRhyJ4AoVEedEBndD0KAGBf8IBAaGhC6KnDdVyQA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsWy7bCmhu4u/apYgz0dwhbN/7ezWpzdtZDV
        YklThsWuux3sFiu+zGS3uLxrDpvF2XnH2Sze/H7B7sDhsWbeGkaPnbPusnss2FTq0bdlFaPH
        lv2fGT0+b5ILYIvisklJzcksSy3St0vgyljUWlywW6ai/d1O9gbGr6JdjJwcEgImEns777F0
        MXJxCAnsZpT4OWMfE4TziVGibeF3NgjnG6NE74NJ7DAty05dZ4dI7GWU6N94Car/NaPEgZ7d
        YFVsAvoS537MYwWxRQR0Jb6ues4GYjML/GOUmHfUEMTmFHCSmL/3AFhcWCBM4tqJVYwgNouA
        qsTyxVvBenkFLCVerO2HsgUlTs58wgIxR15i+9s5zBAXKUj8fLoMaleYxJ3jWxkhasQlXh49
        AnaphMBnNokjhz4DFXEAOS4Sf7bzQfQKS7w6vgXqMymJl/1tUHa+xI/Fk5ghelsYJSYfn8sK
        kbCXOHBlDgvIHGYBTYn1u/QhdvFJ9P5+wgQxnleio00IolpN4vvzM1Bnykg8bF7KBGF7SCxf
        dol9AqPiLCSfzULy2SwkH8xCWLaAkWUVo2RqQXFuemqxaYFhXmq5XnFibnFpXrpecn7uJkZw
        WtLy3ME465zPIUYBDkYlHl4LnapYIdbEsuLK3EOMEhzMSiK8Pm8qY4V4UxIrq1KL8uOLSnNS
        iw8xSnOwKInzTmK9GiMkkJ5YkpqdmlqQWgSTZeLglGpgzEj13txrqasp2Xxzxa6ErV8VJ3sf
        63m9YNKPJT2CAvdnbf15upRx8nOW1mXXvi3eLBluO6vl9bcY3g4Diz2tNXO3Rxc3pO+usVy6
        ZneocWpFkYFR7s/1Lu0Wmos3vrpsUVS+a4mS1qW3bqcOCji6HU++e/SlGmdYvtvllV+n+xs9
        mtyw/euyk0osxRmJhlrMRcWJAPvhOKRHAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsWy7bCSnO5O/apYg+6TkhbN/7ezWpzdtZDV
        YklThsWuux3sFiu+zGS3uLxrDpvF2XnH2Sze/H7B7sDhsWbeGkaPnbPusnss2FTq0bdlFaPH
        lv2fGT0+b5ILYIvisklJzcksSy3St0vgyljUWlywW6ai/d1O9gbGr6JdjJwcEgImEstOXWfv
        YuTiEBLYzSixfv56VoiEjMTk1SugbGGJlf+eQxW9ZJTo6bvGCJJgE9CXOPdjHliRiICuxNdV
        z9lAipgFWpgkmvf9YYLo6GCWWPbiNVgVp4CTxPy9B4CqODiEBUIkjh7PBwmzCKhKLF+8FayE
        V8BS4sXafihbUOLkzCcsIOXMAnoSbRvB9jILyEtsfzuHGeI4BYmfT5dB3RAmcef4VqgacYmX
        R4+wT2AUnoVk0iyESbOQTJqFpGMBI8sqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzg
        2NLS3MF4eUn8IUYBDkYlHt4HmlWxQqyJZcWVuYcYJTiYlUR4fd5UxgrxpiRWVqUW5ccXleak
        Fh9ilOZgURLnfZp3LFJIID2xJDU7NbUgtQgmy8TBKdXAmLNmXnfjuYpGxQdBBWJP2E5uEOFs
        /GChwCJyo+nOjDvyTUoHFsuFVP+ZeqyjR3Lzvrj5RstevJyzosipYJvp+VCpY4mV+/keJIhN
        8Ai0WvDylN3/zdVPui7y3glNX/OtvadCqkGJIddWU4Bff/3fW6t5OJbbl8deVXmyesFpv1ZN
        i6yirb3JSizFGYmGWsxFxYkABGnTh6kCAAA=
X-CMS-MailID: 20190912114457epcas5p3583f05a2afb308b54f44ace2cc803e60
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20190910122520epcas5p1faeb16f7c38ee057ce93783a637e6bf4
References: <1568118302-10505-1-git-send-email-pankaj.dubey@samsung.com>
        <CGME20190910122520epcas5p1faeb16f7c38ee057ce93783a637e6bf4@epcas5p1.samsung.com>
        <1568118302-10505-2-git-send-email-pankaj.dubey@samsung.com>
        <20190910140502.GL9720@e119886-lin.cambridge.arm.com>
        <CAGcde9Fm+WGamjAC6R4jmaShMYxAoCsofggfwdJ7viYt3NE_sQ@mail.gmail.com>
        <20190911092710.GO9720@e119886-lin.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> From: Andrew Murray <andrew.murray@arm.com>
> 
> On Tue, Sep 10, 2019 at 09:51:41PM +0530, Pankaj Dubey wrote:
> > On Tue, 10 Sep 2019 at 19:59, Andrew Murray <andrew.murray@arm.com>
> wrote:
> > >
> > > On Tue, Sep 10, 2019 at 05:55:02PM +0530, Pankaj Dubey wrote:
> > > > From: Anvesh Salveru <anvesh.s@samsung.com>
> > > >
> > > > In some platforms, PCIe PHY may have issues which will prevent
> > > > linkup to happen in GEN3 or high speed. In case equalization
> > > > fails, link will fallback to GEN1.
> > > >
> > > > Designware controller gives flexibility to disable GEN3
> > > > equalization completely or only phase 2 and 3.
> > >
> > > Do some platforms have issues conducting phase 2 and 3 when they
> > > successfully conduct phase 0 and 1?
> > >
> >
> > Yes, it is possible.
> >
> > > >
> > > > Platform drivers can disable equalization phase 2 and 3, by
> > > > setting dwc_pci_quirk flag DWC_EQUALIZATION_DISABLE.
> > > >
> > > > Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
> > > > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-designware.c | 3 +++
> > > > drivers/pci/controller/dwc/pcie-designware.h | 2 ++
> > > >  2 files changed, 5 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> > > > b/drivers/pci/controller/dwc/pcie-designware.c
> > > > index bf82091..97a8268 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > @@ -472,5 +472,8 @@ void dw_pcie_setup(struct dw_pcie *pci)
> > > >       if (pci->dwc_pci_quirk & DWC_EQUALIZATION_DISABLE)
> > > >               val |= PORT_LOGIC_GEN3_EQ_DISABLE;
> > > >
> > > > +     if (pci->dwc_pci_quirk & DWC_EQ_PHASE_2_3_DISABLE)
> > > > +             val |= PORT_LOGIC_GEN3_EQ_PHASE_2_3_DISABLE;
> > > > +
> 
> Also is it harmless to set both DWC_EQUALIZATION_DISABLE and
> DWC_EQ_PHASE_2_3_DISABLE? (Which is permitted here).
> 

Yes, it will be harmless.

> Thanks,
> 
> Andrew Murray
> 
> > > >       dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);  }
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> > > > b/drivers/pci/controller/dwc/pcie-designware.h
> > > > index a1453c5..b541508 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > > @@ -31,6 +31,7 @@
> > > >
> > > >  /* Parameters for PCIe Quirks */
> > > >  #define DWC_EQUALIZATION_DISABLE     0x1
> > > > +#define DWC_EQ_PHASE_2_3_DISABLE     0x2
> > >
> > > It only makes sense for either DWC_EQUALIZATION_DISABLE or
> > > DWC_EQ_PHASE_2_3_DISABLE to be specified, though if dwc_pci_quirk
> > > intends to hold other quirks should these be numbers and not bit
fields?
> > >
> > Yes, you are right in a given platform it will be either
> > DWC_EQUALIZATION_DISABLE or DWC_EQ_PHASE_2_3_DISABLE.
> >
> > Intention behind making it bit-field was to add other quirks in future.
> >
> > > Thanks,
> > >
> > > Andrew Murray
> > >
> > > >
> > > >  /* Synopsys-specific PCIe configuration registers */
> > > >  #define PCIE_PORT_LINK_CONTROL               0x710
> > > > @@ -65,6 +66,7 @@
> > > >
> > > >  #define PCIE_PORT_GEN3_RELATED               0x890
> > > >  #define PORT_LOGIC_GEN3_EQ_DISABLE   BIT(16)
> > > > +#define PORT_LOGIC_GEN3_EQ_PHASE_2_3_DISABLE BIT(9)
> > > >
> > > >  #define PCIE_ATU_VIEWPORT            0x900
> > > >  #define PCIE_ATU_REGION_INBOUND              BIT(31)
> > > > --
> > > > 2.7.4
> > > >

