Return-Path: <linux-pci+bounces-1164-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3228184DA
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 10:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62169B23945
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 09:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D4F13FED;
	Tue, 19 Dec 2023 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6TNfE6y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999311426D;
	Tue, 19 Dec 2023 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cc6b5a8364so25365921fa.2;
        Tue, 19 Dec 2023 01:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702979701; x=1703584501; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pY97st3Y3o4yCoSSj1vvbIrh6fQSNbBquLfi6PeOp9c=;
        b=b6TNfE6yWX7lmSyxuPU9xfxpuRuM4eo9yy+S3tdBeJ5UiUYGtTEc9lxI7m+nhQFClq
         DHQmqQe5H5hdplm6HANnsYFdsxuZeMy7ING4KOeUWCXvorQR/KbtOuJYKnEurJH9oCIc
         2ihqPmdmLbiovYjdaHYYGhY1r28aFTCepySoULzP03I0qQ40u4Fs5hMp5A7X6ToVm6Cx
         WV3U6/IvP2XyI3JjWTOWmfVgk//TNl5+52oPP9HBcm/w/iC02fhIf/g7CcfA2xGhfJmh
         TtJ/bfKrTI+6QnPJauz9pXGdyHUKqxxkzGKX/nFJWNpRSpTFjJREpY48SIZyMrsmxJeQ
         hx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702979701; x=1703584501;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pY97st3Y3o4yCoSSj1vvbIrh6fQSNbBquLfi6PeOp9c=;
        b=BZEE3f523IxuuI0nt1mtHVq8VvnogniAciC4A2TpK1AeMvAyBmALH7Ba75gjV0YsS1
         OimwrznptMfLVfZQN/8kAe6QfNQeldunpTwim7loesSg8MoXmPAPQBRFR6T/oAV6YWXb
         vmzsl60vL4Sz2Uni3YZ/cbBGmCH2JmKHWN1TLjMIDtlIe+ofwOi3kU8HTFK9u7doeMeg
         cEcY7zg1bq3NrvNVfhGVkcyC51IYP+ASLSkMyNzjuMNfFS7DnTWNA2RM7pErLJ1dX5ks
         mnLvRO0VkokdhiJiAQjwW9rtxsIop3TYsiCENG2yKaaH+1rEaNW5XhM14d7///FCk7Yb
         LplQ==
X-Gm-Message-State: AOJu0Yxxiu1dRULHeUcAojxmvPRdeAJuvo91TItudlnM/HIUY+DnpiCt
	9hjddHTmH+3Mt7QstCfJttK50lctyFLDwQ==
X-Google-Smtp-Source: AGHT+IFAHpiYWkS2BRciudSx8hm4mZSrCsvuCHTs3/ZQHE1pq83D5Cp7MlgjPMn17scpz9tZodjXyQ==
X-Received: by 2002:a2e:8704:0:b0:2cc:7b95:ac8b with SMTP id m4-20020a2e8704000000b002cc7b95ac8bmr557609lji.25.1702979701336;
        Tue, 19 Dec 2023 01:55:01 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id j1-20020a2ea901000000b002cb2e889f7esm3369822ljq.91.2023.12.19.01.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 01:55:00 -0800 (PST)
Date: Tue, 19 Dec 2023 12:54:57 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, 
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>, "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v3 4/6] PCI: dwc: Add dw_pcie_ep_{read,write}_dbi[2]
 helpers
Message-ID: <xxry4dc4r56vwifkso7g34r3a46tinf2sow7qgc2zemy4g6uvx@7rgtxboob3rh>
References: <20231215022955.3574063-1-yoshihiro.shimoda.uh@renesas.com>
 <20231215022955.3574063-5-yoshihiro.shimoda.uh@renesas.com>
 <lgwp4u2pzfkax6qdozen74cl6bddyaloz57wiso62swafslz2n@7di6ura7omzo>
 <20231217163247.GA6748@thinkpad>
 <TYBPR01MB534142EF4D309C4AE4B38C6BD897A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYBPR01MB534142EF4D309C4AE4B38C6BD897A@TYBPR01MB5341.jpnprd01.prod.outlook.com>

Hi Yoshihiro

On Tue, Dec 19, 2023 at 12:21:12AM +0000, Yoshihiro Shimoda wrote:
> Hello Serge, Manivannan,
> 
> > From: Manivannan Sadhasivam, Sent: Monday, December 18, 2023 1:33 AM
> > 
> > On Fri, Dec 15, 2023 at 12:51:28PM +0300, Serge Semin wrote:
> > > Hi Yoshihiro
> > >
> > > On Fri, Dec 15, 2023 at 11:29:53AM +0900, Yoshihiro Shimoda wrote:
> > > > The current code calculated some dbi[2] registers' offset by calling
> > > > dw_pcie_ep_get_dbi[2]_offset() in each function. To improve code
> > > > readability, add dw_pcie_ep_{read,write}_dbi[2} and some data-width
> > > > related helpers.
> > > >
> > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > > > ---
> > > >  .../pci/controller/dwc/pcie-designware-ep.c   | 184 ++++++------------
> > > >  drivers/pci/controller/dwc/pcie-designware.h  |  93 +++++++++
> > > >  2 files changed, 153 insertions(+), 124 deletions(-)
> > > >
> <snip>
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > > index 5e36da166ffe..b92e69041fe8 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > > @@ -534,6 +534,99 @@ static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
> > > >  	return (enum dw_pcie_ltssm)FIELD_GET(PORT_LOGIC_LTSSM_STATE_MASK, val);
> > > >  }
> > > >
> > >
> > > > +static inline unsigned int dw_pcie_ep_get_dbi_offset(struct dw_pcie_ep *ep,
> > > > +						     u8 func_no)
> > > > +{
> > > > +	unsigned int dbi_offset = 0;
> > > > +
> > > > +	if (ep->ops->get_dbi_offset)
> > > > +		dbi_offset = ep->ops->get_dbi_offset(ep, func_no);
> > > > +
> > > > +	return dbi_offset;
> > > > +}
> > > > +
> > > > +static inline unsigned int dw_pcie_ep_get_dbi2_offset(struct dw_pcie_ep *ep,
> > > > +						      u8 func_no)
> > > > +{
> > > > +	unsigned int dbi2_offset = 0;
> > > > +
> > > > +	if (ep->ops->get_dbi2_offset)
> > > > +		dbi2_offset = ep->ops->get_dbi2_offset(ep, func_no);
> > > > +	else if (ep->ops->get_dbi_offset)     /* for backward compatibility */
> > > > +		dbi2_offset = ep->ops->get_dbi_offset(ep, func_no);
> > > > +
> > > > +	return dbi2_offset;
> > > > +}
> > > > +
> > > > +static inline u32 dw_pcie_ep_read_dbi(struct dw_pcie_ep *ep, u8 func_no,
> > > > +				      u32 reg, size_t size)
> > > > +{
> > > > +	unsigned int offset = dw_pcie_ep_get_dbi_offset(ep, func_no);
> > > > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > > +
> > > > +	return dw_pcie_read_dbi(pci, offset + reg, size);
> > > > +}
> > > > +
> > > > +static inline void dw_pcie_ep_write_dbi(struct dw_pcie_ep *ep, u8 func_no,
> > > > +					u32 reg, size_t size, u32 val)
> > > > +{
> > > > +	unsigned int offset = dw_pcie_ep_get_dbi_offset(ep, func_no);
> > > > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > > +
> > > > +	dw_pcie_write_dbi(pci, offset + reg, size, val);
> > > > +}
> > > > +
> > > > +static inline void dw_pcie_ep_write_dbi2(struct dw_pcie_ep *ep, u8 func_no,
> > > > +					 u32 reg, size_t size, u32 val)
> > > > +{
> > > > +	unsigned int offset = dw_pcie_ep_get_dbi2_offset(ep, func_no);
> > > > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > > +
> > > > +	dw_pcie_write_dbi2(pci, offset + reg, size, val);
> > > > +}
> > > > +
> > > > +static inline void dw_pcie_ep_writel_dbi(struct dw_pcie_ep *ep, u8 func_no,
> > > > +					 u32 reg, u32 val)
> > > > +{
> > > > +	dw_pcie_ep_write_dbi(ep, func_no, reg, 0x4, val);
> > > > +}
> > > > +
> > > > +static inline u32 dw_pcie_ep_readl_dbi(struct dw_pcie_ep *ep, u8 func_no,
> > > > +				       u32 reg)
> > > > +{
> > > > +	return dw_pcie_ep_read_dbi(ep, func_no, reg, 0x4);
> > > > +}
> > > > +
> > > > +static inline void dw_pcie_ep_writew_dbi(struct dw_pcie_ep *ep, u8 func_no,
> > > > +					 u32 reg, u16 val)
> > > > +{
> > > > +	dw_pcie_ep_write_dbi(ep, func_no, reg, 0x2, val);
> > > > +}
> > > > +
> > > > +static inline u16 dw_pcie_ep_readw_dbi(struct dw_pcie_ep *ep, u8 func_no,
> > > > +				       u32 reg)
> > > > +{
> > > > +	return dw_pcie_ep_read_dbi(ep, func_no, reg, 0x2);
> > > > +}
> > > > +
> > > > +static inline void dw_pcie_ep_writeb_dbi(struct dw_pcie_ep *ep, u8 func_no,
> > > > +					 u32 reg, u8 val)
> > > > +{
> > > > +	dw_pcie_ep_write_dbi(ep, func_no, reg, 0x1, val);
> > > > +}
> > > > +
> > > > +static inline u8 dw_pcie_ep_readb_dbi(struct dw_pcie_ep *ep, u8 func_no,
> > > > +				      u32 reg)
> > > > +{
> > > > +	return dw_pcie_ep_read_dbi(ep, func_no, reg, 0x1);
> > > > +}
> > > > +
> > > > +static inline void dw_pcie_ep_writel_dbi2(struct dw_pcie_ep *ep, u8 func_no,
> > > > +					  u32 reg, u32 val)
> > > > +{
> > > > +	dw_pcie_ep_write_dbi2(ep, func_no, reg, 0x4, val);
> > > > +}
> > > > +
> > >
> > > A tiny nitpick. Since these are CSRs accessors it would be better for
> > > readability to have them grouped with the rest of the IO-accessors
> > > dw_pcie_writel_dbi()..dw_pcie_writel_dbi2(). Particularly have them
> > > defined below the already available ones. So first normal
> > > DBI-accessors would be placed and the EP-specific DBI-accessors
> > > afterwords. Not sure whether it's that much required. So it's up to
> > > Mani to decide. Perhaps the subsystem maintainers could fix it on
> > > merge in? Bjorn, Krzysztof, Lorenzo?
> > >
> > 
> > +1
> 
> Thank you for your comment and a vote.

> To be honest, I don't understand what grouping is better for readability...

It's better to group the function definitions up by their
functionality so the code reader wouldn't need to jump over the
unrelated methods if one is looking for something particular, like
only EP-specific DBI accessors or EP-specific DBI2 accessors, etc.

> Anyway, perhaps, I should modify the header file as v4 patches. On v3,
> the IO-accessors are the following:
> ---
> static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
> static inline u32 dw_pcie_readl_dbi(struct dw_pcie *pci, u32 reg)
> static inline void dw_pcie_writew_dbi(struct dw_pcie *pci, u32 reg, u16 val)
> static inline u16 dw_pcie_readw_dbi(struct dw_pcie *pci, u32 reg)
> static inline void dw_pcie_writeb_dbi(struct dw_pcie *pci, u32 reg, u8 val)
> static inline u8 dw_pcie_readb_dbi(struct dw_pcie *pci, u32 reg)
> static inline void dw_pcie_writel_dbi2(struct dw_pcie *pci, u32 reg, u32 val)
> 
> static inline void dw_pcie_dbi_ro_wr_en(struct dw_pcie *pci) // not IO-accessors
> static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci) // not IO-accessors
> static inline int dw_pcie_start_link(struct dw_pcie *pci) // not IO-accessors
> static inline void dw_pcie_stop_link(struct dw_pcie *pci) // not IO-accessors
> static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci) // not IO-accessors
> 
> static inline unsigned int dw_pcie_ep_get_dbi_offset(struct dw_pcie_ep *ep, u8 func_no)
> static inline unsigned int dw_pcie_ep_get_dbi2_offset(struct dw_pcie_ep *ep, u8 func_no)
> static inline u32 dw_pcie_ep_read_dbi(struct dw_pcie_ep *ep, u8 func_no, u32 reg, size_t size)
> static inline void dw_pcie_ep_write_dbi(struct dw_pcie_ep *ep, u8 func_no, u32 reg, size_t size, u32 val)
> static inline void dw_pcie_ep_write_dbi2(struct dw_pcie_ep *ep, u8 func_no, u32 reg, size_t size, u32 val) // for dbi2
> static inline void dw_pcie_ep_writel_dbi(struct dw_pcie_ep *ep, u8 func_no, u32 reg, u32 val)
> static inline u32 dw_pcie_ep_readl_dbi(struct dw_pcie_ep *ep, u8 func_no, u32 reg)
> static inline void dw_pcie_ep_writew_dbi(struct dw_pcie_ep *ep, u8 func_no, u32 reg, u16 val)
> static inline u16 dw_pcie_ep_readw_dbi(struct dw_pcie_ep *ep, u8 func_no, u32 reg)
> static inline void dw_pcie_ep_writeb_dbi(struct dw_pcie_ep *ep, u8 func_no, u32 reg, u8 val)
> static inline u8 dw_pcie_ep_readb_dbi(struct dw_pcie_ep *ep, u8 func_no, u32 reg)
> static inline void dw_pcie_ep_writel_dbi2(struct dw_pcie_ep *ep, u8 func_no, u32 reg, u32 val) // for dbi2
> ---
> 

> Perhaps the following order is better?
> ---
> // normal DBI-accessors
> static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
> static inline u32 dw_pcie_readl_dbi(struct dw_pcie *pci, u32 reg)
> static inline void dw_pcie_writew_dbi(struct dw_pcie *pci, u32 reg, u16 val)
> static inline u16 dw_pcie_readw_dbi(struct dw_pcie *pci, u32 reg)
> static inline void dw_pcie_writeb_dbi(struct dw_pcie *pci, u32 reg, u8 val)
> static inline u8 dw_pcie_readb_dbi(struct dw_pcie *pci, u32 reg)
> static inline void dw_pcie_writel_dbi2(struct dw_pcie *pci, u32 reg, u32 val)
> 
> // EP-specific DBI-accessors for dbi
> static inline unsigned int dw_pcie_ep_get_dbi_offset(struct dw_pcie_ep *ep, u8 func_no)
> static inline u32 dw_pcie_ep_read_dbi(struct dw_pcie_ep *ep, u8 func_no, u32 reg, size_t size)
> static inline void dw_pcie_ep_write_dbi(struct dw_pcie_ep *ep, u8 func_no, u32 reg, size_t size, u32 val)
> static inline void dw_pcie_ep_writel_dbi(struct dw_pcie_ep *ep, u8 func_no, u32 reg, u32 val)
> static inline u32 dw_pcie_ep_readl_dbi(struct dw_pcie_ep *ep, u8 func_no, u32 reg)
> static inline void dw_pcie_ep_writew_dbi(struct dw_pcie_ep *ep, u8 func_no, u32 reg, u16 val)
> static inline u16 dw_pcie_ep_readw_dbi(struct dw_pcie_ep *ep, u8 func_no, u32 reg)
> static inline void dw_pcie_ep_writeb_dbi(struct dw_pcie_ep *ep, u8 func_no, u32 reg, u8 val)
> static inline u8 dw_pcie_ep_readb_dbi(struct dw_pcie_ep *ep, u8 func_no, u32 reg)
> 
> // EP-specific DBI-accessors for dbi2
> static inline unsigned int dw_pcie_ep_get_dbi2_offset(struct dw_pcie_ep *ep, u8 func_no)
> static inline void dw_pcie_ep_write_dbi2(struct dw_pcie_ep *ep, u8 func_no, u32 reg, size_t size, u32 val)
> static inline void dw_pcie_ep_writel_dbi2(struct dw_pcie_ep *ep, u8 func_no, u32 reg, u32 val)

LGTM. Thanks.

-Serge(y)

> 
> // rest of inline functions
> static inline void dw_pcie_dbi_ro_wr_en(struct dw_pcie *pci)
> static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
> static inline int dw_pcie_start_link(struct dw_pcie *pci)
> static inline void dw_pcie_stop_link(struct dw_pcie *pci)
> static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
> ---
> 
> Best regards,
> Yoshihiro Shimoda
> 
> > - Mani
> > 
> > > -Serge(y)
> > >
> > > >  #ifdef CONFIG_PCIE_DW_HOST
> > > >  irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp);
> > > >  int dw_pcie_setup_rc(struct dw_pcie_rp *pp);
> > > > --
> > > > 2.34.1
> > > >
> > >
> > 
> > --
> > மணிவண்ணன் சதாசிவம்

