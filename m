Return-Path: <linux-pci+bounces-1077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 262BC81531D
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 23:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3C97B25440
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 22:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A0F13B154;
	Fri, 15 Dec 2023 21:53:45 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87244B15F;
	Fri, 15 Dec 2023 21:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6d3165ac96bso3830b3a.0;
        Fri, 15 Dec 2023 13:53:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702677223; x=1703282023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hA3Hgf6nqLzdqHtPQW16dypUAXOdqP0k3RFbxDCTWU=;
        b=NRCFh5gzgm4N+1Y2mnY423XgYDbnmrCILTW4D29S/PKrp6GZrhrnfFA+gtcw/fPKMp
         4SsPWpdDL67q8WtRmnMBWP7p7cBtRIfxmLRV/tA+pLkwf8G1agyzW16QW8sVSPMQChNl
         lM3YtHfWBP1ghJEcRUUZ7xiENZ9y/M2vWz8alvbS84lhelz+QZUCNcbigOc4E3Jr62er
         spDK511xDCpr4RTYntyI1dfETagrN0G6wSocZ2dgbRqnF6Bn0WWzlI9d6g+GAyXtiecr
         Qe0USmvoukc2yzp3Jv2y0u8pLmHGr4ni+ksx2Htqea9m9eouobkXLn+0MtcDeP6f9Buc
         z2+g==
X-Gm-Message-State: AOJu0YwQ6bReWVOM8CKMJeCrWZ8icCzGTsQogncP1X8t7XfCH/D1hV2S
	kehiG3X0txklO1iUmjqJX0g=
X-Google-Smtp-Source: AGHT+IF2/YGHNdbW1xBXfJiqLH3eObzr2iLIti5qGi+SF7q+N+5lL4mkwdo3xswfGbiLNa2+CHGkDg==
X-Received: by 2002:a05:6a00:c91:b0:6ce:5fbf:3cd8 with SMTP id a17-20020a056a000c9100b006ce5fbf3cd8mr8062574pfv.21.1702677222905;
        Fri, 15 Dec 2023 13:53:42 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id kr5-20020a056a004b4500b006ce83da3076sm14267311pfb.170.2023.12.15.13.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 13:53:41 -0800 (PST)
Date: Sat, 16 Dec 2023 06:53:39 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
	mani@kernel.org, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 4/6] PCI: dwc: Add dw_pcie_ep_{read,write}_dbi[2]
 helpers
Message-ID: <20231215215339.GA766237@rocinante>
References: <20231215022955.3574063-1-yoshihiro.shimoda.uh@renesas.com>
 <20231215022955.3574063-5-yoshihiro.shimoda.uh@renesas.com>
 <lgwp4u2pzfkax6qdozen74cl6bddyaloz57wiso62swafslz2n@7di6ura7omzo>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lgwp4u2pzfkax6qdozen74cl6bddyaloz57wiso62swafslz2n@7di6ura7omzo>

Hello,

[...]
> > The current code calculated some dbi[2] registers' offset by calling
> > dw_pcie_ep_get_dbi[2]_offset() in each function. To improve code
> > readability, add dw_pcie_ep_{read,write}_dbi[2} and some data-width
> > related helpers.
[...]
> > +static inline unsigned int dw_pcie_ep_get_dbi_offset(struct dw_pcie_ep *ep,
> > +						     u8 func_no)
> > +{
> > +	unsigned int dbi_offset = 0;
> > +
> > +	if (ep->ops->get_dbi_offset)
> > +		dbi_offset = ep->ops->get_dbi_offset(ep, func_no);
> > +
> > +	return dbi_offset;
> > +}
> > +
> > +static inline unsigned int dw_pcie_ep_get_dbi2_offset(struct dw_pcie_ep *ep,
> > +						      u8 func_no)
> > +{
> > +	unsigned int dbi2_offset = 0;
> > +
> > +	if (ep->ops->get_dbi2_offset)
> > +		dbi2_offset = ep->ops->get_dbi2_offset(ep, func_no);
> > +	else if (ep->ops->get_dbi_offset)     /* for backward compatibility */
> > +		dbi2_offset = ep->ops->get_dbi_offset(ep, func_no);
> > +
> > +	return dbi2_offset;
> > +}
> > +
> > +static inline u32 dw_pcie_ep_read_dbi(struct dw_pcie_ep *ep, u8 func_no,
> > +				      u32 reg, size_t size)
> > +{
> > +	unsigned int offset = dw_pcie_ep_get_dbi_offset(ep, func_no);
> > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +
> > +	return dw_pcie_read_dbi(pci, offset + reg, size);
> > +}
> > +
> > +static inline void dw_pcie_ep_write_dbi(struct dw_pcie_ep *ep, u8 func_no,
> > +					u32 reg, size_t size, u32 val)
> > +{
> > +	unsigned int offset = dw_pcie_ep_get_dbi_offset(ep, func_no);
> > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +
> > +	dw_pcie_write_dbi(pci, offset + reg, size, val);
> > +}
> > +
> > +static inline void dw_pcie_ep_write_dbi2(struct dw_pcie_ep *ep, u8 func_no,
> > +					 u32 reg, size_t size, u32 val)
> > +{
> > +	unsigned int offset = dw_pcie_ep_get_dbi2_offset(ep, func_no);
> > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +
> > +	dw_pcie_write_dbi2(pci, offset + reg, size, val);
> > +}
> > +
> > +static inline void dw_pcie_ep_writel_dbi(struct dw_pcie_ep *ep, u8 func_no,
> > +					 u32 reg, u32 val)
> > +{
> > +	dw_pcie_ep_write_dbi(ep, func_no, reg, 0x4, val);
> > +}
> > +
> > +static inline u32 dw_pcie_ep_readl_dbi(struct dw_pcie_ep *ep, u8 func_no,
> > +				       u32 reg)
> > +{
> > +	return dw_pcie_ep_read_dbi(ep, func_no, reg, 0x4);
> > +}
> > +
> > +static inline void dw_pcie_ep_writew_dbi(struct dw_pcie_ep *ep, u8 func_no,
> > +					 u32 reg, u16 val)
> > +{
> > +	dw_pcie_ep_write_dbi(ep, func_no, reg, 0x2, val);
> > +}
> > +
> > +static inline u16 dw_pcie_ep_readw_dbi(struct dw_pcie_ep *ep, u8 func_no,
> > +				       u32 reg)
> > +{
> > +	return dw_pcie_ep_read_dbi(ep, func_no, reg, 0x2);
> > +}
> > +
> > +static inline void dw_pcie_ep_writeb_dbi(struct dw_pcie_ep *ep, u8 func_no,
> > +					 u32 reg, u8 val)
> > +{
> > +	dw_pcie_ep_write_dbi(ep, func_no, reg, 0x1, val);
> > +}
> > +
> > +static inline u8 dw_pcie_ep_readb_dbi(struct dw_pcie_ep *ep, u8 func_no,
> > +				      u32 reg)
> > +{
> > +	return dw_pcie_ep_read_dbi(ep, func_no, reg, 0x1);
> > +}
> > +
> > +static inline void dw_pcie_ep_writel_dbi2(struct dw_pcie_ep *ep, u8 func_no,
> > +					  u32 reg, u32 val)
> > +{
> > +	dw_pcie_ep_write_dbi2(ep, func_no, reg, 0x4, val);
> > +}
> > +
> 
> A tiny nitpick. Since these are CSRs accessors it would be better for
> readability to have them grouped with the rest of the IO-accessors
> dw_pcie_writel_dbi()..dw_pcie_writel_dbi2(). Particularly have them
> defined below the already available ones. So first normal
> DBI-accessors would be placed and the EP-specific DBI-accessors
> afterwords. Not sure whether it's that much required. So it's up to
> Mani to decide. Perhaps the subsystem maintainers could fix it on
> merge in? Bjorn, Krzysztof, Lorenzo?

Yes, I can change order after I pull this series.  Not to worry.

	Krzysztof

