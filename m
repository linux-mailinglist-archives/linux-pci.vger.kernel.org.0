Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65632E248A
	for <lists+linux-pci@lfdr.de>; Thu, 24 Dec 2020 07:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgLXGEm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Dec 2020 01:04:42 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:51509 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgLXGEm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Dec 2020 01:04:42 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201224060359epoutp026a6d4ed408b693d0dbb7ed7da1c537f6~TkdXLHqUg1325513255epoutp02T
        for <linux-pci@vger.kernel.org>; Thu, 24 Dec 2020 06:03:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201224060359epoutp026a6d4ed408b693d0dbb7ed7da1c537f6~TkdXLHqUg1325513255epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1608789839;
        bh=/Gun7qc00RhUt5XHDKXSsCvFxRdYWNB8IY+9C/Ad1q8=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=rTaBW9mqOvC8VrUGB/SbR2dXXSAUewWTYw64c4v9KKor+RgeL0Dl7+F9PVcBOzsF+
         0ryPoCEoSKn8/4X8wszX/kH5KHK2gtfl9+9AHzi8//eWgi0d6zRmlqlXRbBlxswofm
         phM7inhOMccAbhTJeNWHMuANBdv43I6SueUeJcNU=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20201224060358epcas5p1edfdc60a05045f04ec660accefdca19f~TkdWmEAwp2332923329epcas5p1u;
        Thu, 24 Dec 2020 06:03:58 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.4A.15682.E4F24EF5; Thu, 24 Dec 2020 15:03:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20201224055324epcas5p1f08415baa9d4a0150809a562124c24a8~TkUIHNCyP2821228212epcas5p19;
        Thu, 24 Dec 2020 05:53:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201224055324epsmtrp2769aea46340676c4e4a8be4efc5c374e~TkUIGZgrZ0215302153epsmtrp2a;
        Thu, 24 Dec 2020 05:53:24 +0000 (GMT)
X-AuditID: b6c32a49-8d5ff70000013d42-08-5fe42f4e9cb9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C3.1D.13470.4DC24EF5; Thu, 24 Dec 2020 14:53:24 +0900 (KST)
Received: from shradhat02 (unknown [107.122.8.248]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20201224055314epsmtip278746895521692d75fbaa6ababce4971~TkT_4ZWu52251322513epsmtip22;
        Thu, 24 Dec 2020 05:53:14 +0000 (GMT)
From:   "Shradha Todi" <shradha.t@samsung.com>
To:     "'Bjorn Helgaas'" <helgaas@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <pankaj.dubey@samsung.com>
In-Reply-To: <20201223203821.GA320232@bjorn-Precision-5520>
Subject: RE: [PATCH] PCI: dwc: Change size to u64 for EP outbound iATU
Date:   Thu, 24 Dec 2020 11:23:10 +0530
Message-ID: <096401d6d9b9$17c238f0$4746aad0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI0xPnWW2MqTfDY1YhJMF5paK56mgHTw/tXqTtJk1A=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1CLcRzHffdsz/MsVo/N8WlKbi4UKoTH799uO3Q7zhX/zI7nCrVlTxGO
        63KorsKpO2amUiEhWz/WqouKKRmi4w8Rlt8lrRNNYj2h/16f9+f9vff3/b0viYnNAim5QxPH
        6DTqaBnuwS+rCwiYERbsUIUkv5hM5yVF0dbWZIL+2HQVpy/1nCHox1YDTt832nD6s+s9QeeW
        9hD0QJWFWCaUFxmLkLxC30rIs03xclNhCi7PKClE8pIaJ5I7TROUxBaPRduZ6B17GF3wkq0e
        UfazR7HYcknC174WlIjMXqlISAIVCgVpLiwVeZBiqhJBc3UawQ3dCMz36oeGbwh6zV95/45U
        nkTcohpBWc9LPje8R9Dwuglzu3BqOjie/BzkMVQg2G7VCNwmjHqFwPnIRbgXQmoh3DiWgbtZ
        Qq2Bty1OgZv5lD/051bw3Syi5sNDeyeP49HQcMYxqGOUH5R3GDDuShPhR3uBgAtbAFbbIwHn
        GQcfbnMdgKoioTHtFJ87sAouXk8ZYgl8tJUQHEvB2VmNc6yFrIftfzzkH06Ai2mHOHkp3Hxi
        GJQxKgCuW4M52ReyGq/xuFhPSHc5hl5LBBbjX54EPf1VQ6neYLzzWHACyfTDmumHNdMPa6D/
        n5aN+IXIm4llYyIZdk7sTA2zN4hVx7DxmsigbdoYExr8V4EKC2pt6wqqRTwS1SIgMdkYUbPX
        G5VYtF29bz+j06p08dEMW4vGk3zZOJElpE0lpiLVccwuholldH+3PFIoTeR5WryodXbX1nUK
        ocO16JtQAsvjDgRuMRFXyyoKVlhST0hWZ5wubune/0KkFbGb6lpDTRG28o39O8NGPtg1kJiZ
        42XtetdpXK54VXT40Chp72XNtA1J7wT+6RsVfqrNky2zc0aG+4bkPzs593uX9jgvz1V8atbY
        +9S52yuTco6GZvY3v6wfkW1+Xo8rmOz1U2uM6VMPluZ7+jX4zFuNlPa1Yd3J3gal4W5mYcUA
        fBo9q+OX/emVxryaPeIOQVjBwgt9TfOIcyofX6V0PNu3aveBT72jso7IP0cUH1Yxs9+cVy42
        3/NRfEn21Kc7ptSdTtEG4B/aVoQHZRFSqynhVlW7v4zPRqlnBmI6Vv0bcG3+cMYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWy7bCSvO4VnSfxBjevqlgsacqw2HW3g93i
        1Zm1bBYrvsxkt7i8aw6bxdl5x9ks3vx+wW6xaOsXdov/e3awO3B6rJm3htFj56y77B4LNpV6
        bFrVyebRt2UVo8eW/Z8ZPT5vkgtgj+KySUnNySxLLdK3S+DKODe7jblgu3DFx19XGRsYN/N3
        MXJySAiYSCzbPZGxi5GLQ0hgN6PEjNUv2SASkhKfL65jgrCFJVb+e84OUfSMUeJ883d2kASb
        gI7Ekyt/mEFsEQEtieMH97OCFDELvGSUOPZqBitIQkigh1HiwXlBEJtTwFpiY3sf2AZhATeJ
        Z1c/g9WwCKhK/F20kwXE5hWwlLhw7h0ThC0ocXLmE6A4B9BQPYm2jYwgYWYBeYntb+cwQxyn
        IPHz6TJWiBusJHYdv8gKUSMu8fLoEfYJjMKzkEyahTBpFpJJs5B0LGBkWcUomVpQnJueW2xY
        YJiXWq5XnJhbXJqXrpecn7uJERxxWpo7GLev+qB3iJGJg/EQowQHs5II7yX+x/FCvCmJlVWp
        RfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MK2O3fRQ21hcy0GieCEz
        k1/Bohunv5vd/Pf+9MLPvwx033f3bDr7tFzj+bXzU955VetPyHr+ZfL1xQVHOmZcXTx3zd65
        jts2NnR9f+H86VHBRdXPnunPWjxd2lclHHjTmrk3p9hkgkFznrnN8c1xfua8VyQf3tjvvLH5
        ouTuh5pbzlh9exvwxeJLxHPLV3fy9Y53OumYXftnWyDtYq55/ty6hpaXXhIK+sZP37oZVpa+
        jZOcaOUgHNJ5+uCTABPbpfLf3x2Y3VI6c+/d345qS4XerZneXHI16srVZzvd+fuvHTgVseuO
        7Q2x+6YXuFgm7tB7LHaNw/5Yd7hOQ1FMQWIW1yL/ic299x9MNdg0KytJiaU4I9FQi7moOBEA
        oiX3ricDAAA=
X-CMS-MailID: 20201224055324epcas5p1f08415baa9d4a0150809a562124c24a8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20201223203825epcas5p3d494947e59970eb3adf37d20e64dd972
References: <CGME20201223203825epcas5p3d494947e59970eb3adf37d20e64dd972@epcas5p3.samsung.com>
        <20201223203821.GA320232@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Bjorn Helgaas <helgaas@kernel.org>
> Subject: Re: [PATCH] PCI: dwc: Change size to u64 for EP outbound iATU
> 
> On Fri, Dec 18, 2020 at 09:04:08PM +0530, Shradha Todi wrote:
> > Since outbound iATU permits size to be greater than 4GB for which the
> > support is also available, allow EP function to send u64 size instead
> > of truncating to u32.
> 
> Please wrap your commit messages so they use more of an 80-column window.
> I use "set textwidth=75" for vim to account for git log indenting by 4
characters.
> 
> I know 80 isn't a magic width, but it's the convention in drivers/pci.
> 
> This also affects other patches from you, e.g., "PCI: dwc: Add upper limit
> address for outbound iATU".
> 

Thanks for the review and suggestion. I will take care of this for all my
patches
in next version.

> > Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
> > drivers/pci/controller/dwc/pcie-designware.h | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> > b/drivers/pci/controller/dwc/pcie-designware.c
> > index 7eba3b2..6298212 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -325,7 +325,7 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie
> > *pci, int index, int type,
> >
> >  void dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int
> index,
> >  				  int type, u64 cpu_addr, u64 pci_addr,
> > -				  u32 size)
> > +				  u64 size)
> >  {
> >  	__dw_pcie_prog_outbound_atu(pci, func_no, index, type,
> >  				    cpu_addr, pci_addr, size);
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> > b/drivers/pci/controller/dwc/pcie-designware.h
> > index 28b72fb..bb33f28 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -307,7 +307,7 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> int index,
> >  			       u64 size);
> >  void dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int
> index,
> >  				  int type, u64 cpu_addr, u64 pci_addr,
> > -				  u32 size);
> > +				  u64 size);
> >  int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int
index,
> >  			     int bar, u64 cpu_addr,
> >  			     enum dw_pcie_as_type as_type);
> > --
> > 2.7.4
> >

