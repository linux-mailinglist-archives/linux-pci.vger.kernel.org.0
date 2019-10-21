Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC14DEF14
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 16:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfJUOOd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 10:14:33 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:19876 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbfJUOOd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Oct 2019 10:14:33 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191021141430epoutp0378a784c2baf78ab19f10d27f3dd68cac~Prw41C0BH0396403964epoutp03K
        for <linux-pci@vger.kernel.org>; Mon, 21 Oct 2019 14:14:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191021141430epoutp0378a784c2baf78ab19f10d27f3dd68cac~Prw41C0BH0396403964epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1571667270;
        bh=PcRAuDOcHjLHppSatFUnALgrkProkok4O489w5TSF50=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=qwhubt3Zbv7CL4LdyNNNhIgNJ6d2p8CAih3O1bYdvpLwu2NEeOdwHtRenAKuBIx0Q
         UbeHGz61LojXBbqm4ajRnkXUZ9wyPd2eseTVLKgB52WeH55BL1JMC6cTYjqvbcNiG9
         i7bXMWSpSlOAKrLnDNWjAk/veMdfnalbOHEJyV3E=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20191021141429epcas5p2cf7e3a3fe86191579f733576fb3d154c~Prw3lctit2837128371epcas5p2S;
        Mon, 21 Oct 2019 14:14:29 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        50.FF.04647.54DBDAD5; Mon, 21 Oct 2019 23:14:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20191021141428epcas5p2343617905183e317aaeb5beed17be301~Prw2kmxI_2837128371epcas5p2R;
        Mon, 21 Oct 2019 14:14:28 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191021141428epsmtrp2f1d05c6ffcee999e2ccc6a5ec326f845~Prw2j7DEE1778717787epsmtrp2X;
        Mon, 21 Oct 2019 14:14:28 +0000 (GMT)
X-AuditID: b6c32a49-72bff70000001227-a7-5dadbd453604
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A5.AF.03889.34DBDAD5; Mon, 21 Oct 2019 23:14:28 +0900 (KST)
Received: from pankajdubey02 (unknown [107.111.85.21]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191021141426epsmtip2d80189b38641ce4076a4d1f85881b759~Prw1VY_zk1037410374epsmtip2H;
        Mon, 21 Oct 2019 14:14:26 +0000 (GMT)
From:   "Pankaj Dubey" <pankaj.dubey@samsung.com>
To:     "'Andrew Murray'" <andrew.murray@arm.com>,
        "'Anvesh Salveru'" <anvesh.s@samsung.com>
Cc:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>, <gustavo.pimentel@synopsys.com>,
        <jingoohan1@gmail.com>, <lorenzo.pieralisi@arm.com>
In-Reply-To: <20191021140424.GR47056@e119886-lin.cambridge.arm.com>
Subject: RE: [PATCH 2/2] PCI: dwc: Add support to handle ZRX-DC Compliant
 PHYs
Date:   Mon, 21 Oct 2019 19:44:25 +0530
Message-ID: <05b301d58819$d962fa00$8c28ee00$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHofyUpkW9F4esSgqZqrNFszEeXZwD9REAhAfezFTmnJ40NUA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsWy7bCmpq7r3rWxBv17WS2a/29ntTi7ayGr
        xZKmDItddzvYLVZ8mclucXnXHDaLs/OOs1m8+f2C3YHDY828NYweO2fdZfdYsKnUo2/LKkaP
        Lfs/M3p83iQXwBbFZZOSmpNZllqkb5fAlTH1+SOmguVSFQu/SDcwXhDtYuTkkBAwkZjceJO1
        i5GLQ0hgN6PEriffWEASQgKfGCWOT4mCSHxjlDj/YBIzTMfK/RfYIRJ7GSUamm4wQXS8ZpT4
        96wYxGYT0Jc492MeK4gtIhAlsfDeVrAVzAIbGCXaVx8ES3AKOEusfNgENlVYIEBi+/Q1YKtZ
        BFQl5l+9xdbFyMHBK2Ap8WY/O0iYV0BQ4uTMJ2AlzALyEtvfzoE6SEHi59NlrCDlIgJOEu/e
        CkGUiEu8PHqEHaLkN5vEm92WELaLxLfeVhYIW1ji1fEtUDVSEp/f7WWDsPMlfiwG+ZcLyG5h
        lJh8fC4rRMJe4sCVOSwgu5gFNCXW79KH2MUn0fv7CRNIWEKAV6KjTQiiWk3i+/MzUFfKSDxs
        XsoEYXtIfNnRyTiBUXEWksdmIXlsFpIPZiEsW8DIsopRMrWgODc9tdi0wDAvtVyvODG3uDQv
        XS85P3cTIzghaXnuYJx1zucQowAHoxIPb8GitbFCrIllxZW5hxglOJiVRHjvGACFeFMSK6tS
        i/Lji0pzUosPMUpzsCiJ805ivRojJJCeWJKanZpakFoEk2Xi4JRqYNwjbn3T9BqTcHsez+pn
        r5pTLiurbmrYtanL8M5sX+6N8fw7962/aaCl4DH/9M93zauqN7Fe1V2w5qG93NfAuIMrn9Uu
        Nfz88JXkgZc/y6XErq/JPM9WELycx1On9IxhocL7RSoWqdWr3pX80Hf1fnh7etSjFQXPwkL1
        U0t+5PUmzdp17Otlo7NKLMUZiYZazEXFiQCashsXRAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsWy7bCSvK7L3rWxBq8mMlo0/9/OanF210JW
        iyVNGRa77nawW6z4MpPd4vKuOWwWZ+cdZ7N48/sFuwOHx5p5axg9ds66y+6xYFOpR9+WVYwe
        W/Z/ZvT4vEkugC2KyyYlNSezLLVI3y6BK2Pq80dMBculKhZ+kW5gvCDaxcjJISFgIrFy/wX2
        LkYuDiGB3YwSFxrPsEIkZCQmr14BZQtLrPz3HKroJaPEq72/2EASbAL6Eud+zAMrEhGIkvj7
        +QYLSBGzwDZGiU+75rFBdJxllGh+cAOsg1PAWWLlwyZmEFtYwE/i4dUrYHEWAVWJ+VdvAdkc
        HLwClhJv9rODhHkFBCVOznzCAhJmFtCTaNvICBJmFpCX2P52DjPEcQoSP58uYwUpERFwknj3
        VgiiRFzi5dEj7BMYhWchGTQLYdAsJINmIelYwMiyilEytaA4Nz232LDAKC+1XK84Mbe4NC9d
        Lzk/dxMjOLK0tHYwnjgRf4hRgINRiYf3xJK1sUKsiWXFlbmHGCU4mJVEeO8YAIV4UxIrq1KL
        8uOLSnNSiw8xSnOwKInzyucfixQSSE8sSc1OTS1ILYLJMnFwSjUwcnnmz3k68ZHtzUtuR29p
        tedIhp0WW+a52cXmRJkls7HYE4tbe+am5quWFfKzMy1aFSortmC1XYTo5aP2tRP/XUvZmnBI
        9f/jG8cq6z4KCzj1Z0wK2K0573+kwUNXlQdq3xnirz6cnebSqaaVm+dVv/jj/ZI73JVX+JTP
        vixeMOu+1pa6vMw9SizFGYmGWsxFxYkAWo4XUKgCAAA=
X-CMS-MailID: 20191021141428epcas5p2343617905183e317aaeb5beed17be301
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191021123016epcas5p3ab7100162a8d6d803b117976240f20b4
References: <CGME20191021123016epcas5p3ab7100162a8d6d803b117976240f20b4@epcas5p3.samsung.com>
        <1571660993-30329-1-git-send-email-anvesh.s@samsung.com>
        <20191021140424.GR47056@e119886-lin.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Andrew Murray <andrew.murray@arm.com>
> Sent: Monday, October 21, 2019 7:34 PM
> To: Anvesh Salveru <anvesh.s@samsung.com>
> Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> bhelgaas@google.com; gustavo.pimentel@synopsys.com;
> jingoohan1@gmail.com; lorenzo.pieralisi@arm.com; Pankaj Dubey
> <pankaj.dubey@samsung.com>
> Subject: Re: [PATCH 2/2] PCI: dwc: Add support to handle ZRX-DC Compliant
> PHYs
> 
> On Mon, Oct 21, 2019 at 05:59:53PM +0530, Anvesh Salveru wrote:
> > Many platforms use DesignWare controller but the PHY can be different
> > in different platforms. If the PHY is compliant is to ZRX-DC
> > specification
> 
> s/is to/to the/

OK

> 
> > it helps in low power consumption during power states.
> 
> s/in low/lower/
> 
OK
> >
> > If current data rate is 8.0 GT/s or higher and PHY is not compliant to
> > ZRX-DC specification, then after every 100ms link should transition to
> > recovery state during the low power states.
> >
> > DesignWare controller provides GEN3_ZRXDC_NONCOMPL field in
> > GEN3_RELATED_OFF to specify about ZRX-DC compliant PHY.
> >
> > Platforms with ZRX-DC compliant PHY can set "snps,phy-zrxdc-compliant"
> > property in controller DT node to specify this property to the
controller.
> >
> > Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
> > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 7 +++++++
> > drivers/pci/controller/dwc/pcie-designware.h | 3 +++
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> > b/drivers/pci/controller/dwc/pcie-designware.c
> > index 820488dfeaed..6560d9f765d7 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -556,4 +556,11 @@ void dw_pcie_setup(struct dw_pcie *pci)
> >  		       PCIE_PL_CHK_REG_CHK_REG_START;
> >  		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS,
> val);
> >  	}
> > +
> > +	if (of_property_read_bool(np, "snps,phy-zrxdc-compliant")) {
> > +		val = dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
> > +		val &= ~PORT_LOGIC_GEN3_ZRXDC_NONCOMPL;
> > +		dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
> > +	}
> > +
> 
> Given that this duplicates tegra_pcie_prepare_host in pcie-tegra194.c, can
we
> update that driver to adopt this new binding?
> 

Yes, Thanks for highlighting this. Otherwise I was worried that we have one
more patch without real user :)
We will update pcie-tegra194.c driver and post the patch to adopt this
binding.

> Thanks,
> 
> Andrew Murray
> 
> >  }
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> > b/drivers/pci/controller/dwc/pcie-designware.h
> > index 5a18e94e52c8..427a55ec43c6 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -60,6 +60,9 @@
> >  #define PCIE_MSI_INTR0_MASK		0x82C
> >  #define PCIE_MSI_INTR0_STATUS		0x830
> >
> > +#define PCIE_PORT_GEN3_RELATED		0x890
> > +#define PORT_LOGIC_GEN3_ZRXDC_NONCOMPL		BIT(0)
> > +
> >  #define PCIE_ATU_VIEWPORT		0x900
> >  #define PCIE_ATU_REGION_INBOUND		BIT(31)
> >  #define PCIE_ATU_REGION_OUTBOUND	0
> > --
> > 2.17.1
> >

