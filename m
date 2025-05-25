Return-Path: <linux-pci+bounces-28387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B7CAC32E0
	for <lists+linux-pci@lfdr.de>; Sun, 25 May 2025 10:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307D8173845
	for <lists+linux-pci@lfdr.de>; Sun, 25 May 2025 08:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F620158DD4;
	Sun, 25 May 2025 08:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nDvWVW2a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7EF2DCBF7
	for <linux-pci@vger.kernel.org>; Sun, 25 May 2025 08:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748160039; cv=none; b=qPVvJ9wSLDV2rFQ64o1cRW6P+tqcOsz9hUAVv9sf+CpcrGC8MHOM36I7CIkJiGWy5CjpMI3uER4tZKgeFEH+QpgvQMPFRwH/uYBXnmuQ0Qa75if7T8I2pH7LZkDlI8q9mPxgGccQGal3RVhX+HH69PQe6OSrYkTEvqb3dut3fEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748160039; c=relaxed/simple;
	bh=L3aMHR4CTO/nCqAwynDrCTi/8dVwtXeVc2t3Pr6BsgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rewf0bU5iHLXlD9b9w8UHoI7eRFsAyYAH6QNl8OaqIxy9eQ8HZ2TVYMEqE30miktsBLkJAt8ty9LioY+tmd3DZZqXhXiREssJeqksL5DQugPT84IgcGReOlD7VgUcAkP4OCvOkSU9oV6g/T4G8epnromrMFyFYCrBB+uTonAn1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nDvWVW2a; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-74019695377so805969b3a.3
        for <linux-pci@vger.kernel.org>; Sun, 25 May 2025 01:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748160037; x=1748764837; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iflJB+w+lsWSV4UDga7gqAG5xctQ/PU9lw7yRpGdqCM=;
        b=nDvWVW2aF0IlbWgrJQ6ila6b/rvXr83BRffYulH9SXiqDFXvcdo8p2eM1QZJ6hRhpc
         IQW18v3W57wmgrQIBBcoIuMFhU3Yfav6OMqm52zuLsb9pGJDPvX/1+R9TLFjJ03kxarE
         TK2NSHmOrf752BQl3LdpFraoGXIDhZP7q+tttJua5jswPC9568Y4lls//ZtjrmV/9+95
         lXO1So1lqvzb/Kc6oz/cSaW4bpm9j4vPzMKZA9DafFYzOcdmZeR3dTlOqZW93QfndCi+
         wntLqaZEJZ+iATsPPuUhpVERaW5sO/hJNih3YqWixoskNJjJxKtZI5ThJYrWqNJV4RoP
         drLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748160037; x=1748764837;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iflJB+w+lsWSV4UDga7gqAG5xctQ/PU9lw7yRpGdqCM=;
        b=CTLn0lFuIVOnTWY6X13JKQdh1S4S6yNwszZQKxTt/uSHMUrnV9QBl8WGpu0BGmHOdG
         Es9ZJbAqNKwsUXMuE69k9ndTav5DseGohr8SaoO3iYqXc/IIbZwS4v4zeEGeeuhN31KH
         nl+Xq8eXTQuNEWCVwutnwXbjBEahiwIrfdtUNeRiZlO6yWeF95VJnQFWjTKf/mBBdn3F
         UBC6w2m/I2nIAh4Fo4MaBV7o2Ns4TmSn6EZ/1TKHM2v6DINYbBo5x8zYd7RKNAxheHD2
         lj+GnYjYWMN5mxK1Y91PtfXXlXlQ29LyDg6EhUy1ELvjgtJU9COv7vt/xMQSHJpqIuON
         cTtA==
X-Forwarded-Encrypted: i=1; AJvYcCXPcPPsGjgF2YEooVVhFXqK6xu1GeTl7MxJnaWW8bboHK6QCvkO9poub34Yb+jLH1bnSS+wHT2iJck=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPbv37GYsG28l2ao60TG8VMTeuPUSV5dZXS3Xk395QmEn5ExN9
	PPHyoW1QimdS1wR3B/YohPrDT6BKkwuSv9NHU/ZZKdARkWvIUh813Y7MkfJev4m5iw==
X-Gm-Gg: ASbGnctkYwYj3CTQd/33Dtd5IUnVnTHszTxdXVsv790Y+a94q7aWK4twAQkamhwsh65
	dFjtSRwyPMxnZs3j7yQZ1Hx/tcUz/0SrMwgjrYfGPBsfMsu0pf8vJmbceYVDYHKqJKQfcJL08ll
	Cna9qfEZGTY8mtoBVQ8d41JQ5H092PdM/HRXiUzgLTWMSfqaPX87DwbwkUT3/iLfz5AjT+165fT
	R5CVcTr9c1g6TKI1eh3uTsGLLL4npIpmpo3DJQbPEOXGOzSss25QbghJcoiHhZMN1q+IQa/KBRA
	Di+kTzypnfNf/y/uyOEBJCjYK/Eo12QTAWAhrQEfloszVIop7Lma04qgS2yklN4=
X-Google-Smtp-Source: AGHT+IG2fQnMLM1qHNOz/+4mtcm1AbBKu3X2bdFMeu7peaLGvWWoekE628Sw8UBiyxEDYRCPbc1BNw==
X-Received: by 2002:a05:6a00:10cd:b0:73f:f816:dd7f with SMTP id d2e1a72fcca58-745fe08352dmr7554205b3a.15.1748160036849;
        Sun, 25 May 2025 01:00:36 -0700 (PDT)
Received: from thinkpad ([120.56.207.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-746029d0b57sm1853087b3a.19.2025.05.25.01.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 01:00:36 -0700 (PDT)
Date: Sun, 25 May 2025 13:30:32 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	wilfred.mallawa@wdc.com, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 2/2] PCI: Rename host_bridge::reset_slot() to
 host_bridge::reset_root_port()
Message-ID: <2ha23gwiz2iakdm56e5qhnxdnfib6cnk3jnl4qkrafx3ouipn6@43lu4d7aoqwe>
References: <20250524185304.26698-1-manivannan.sadhasivam@linaro.org>
 <20250524185304.26698-3-manivannan.sadhasivam@linaro.org>
 <aDIyyMvQkMC40jnQ@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aDIyyMvQkMC40jnQ@ryzen>

On Sat, May 24, 2025 at 10:57:44PM +0200, Niklas Cassel wrote:
> On Sun, May 25, 2025 at 12:23:04AM +0530, Manivannan Sadhasivam wrote:
> > The callback is supposed to reset the root port, hence it should be named
> > as 'reset_root_port'. This also warrants renaming the rest of the instances
> > of 'reset slot' as 'reset root port' in the drivers.
> > 
> > Suggested-by: Lukas Wunner <lukas@wunner.de>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-dw-rockchip.c |  8 ++++----
> >  drivers/pci/controller/dwc/pcie-qcom.c        |  8 ++++----
> >  drivers/pci/controller/pci-host-common.c      | 20 +++++++++----------
> >  drivers/pci/pci.c                             |  6 +++---
> >  include/linux/pci.h                           |  2 +-
> >  5 files changed, 22 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > index 193e97adf228..0cc7186758ce 100644
> > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > @@ -85,7 +85,7 @@ struct rockchip_pcie_of_data {
> >  	const struct pci_epc_features *epc_features;
> >  };
> >  
> > -static int rockchip_pcie_rc_reset_slot(struct pci_host_bridge *bridge,
> > +static int rockchip_pcie_rc_reset_root_port(struct pci_host_bridge *bridge,
> >  				       struct pci_dev *pdev);
> >  
> >  static int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip, u32 reg)
> > @@ -261,7 +261,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
> >  					 rockchip);
> >  
> >  	rockchip_pcie_enable_l0s(pci);
> > -	pp->bridge->reset_slot = rockchip_pcie_rc_reset_slot;
> > +	pp->bridge->reset_root_port = rockchip_pcie_rc_reset_slot;
> 
> You just renamed the function to rockchip_pcie_rc_reset_root_port(),
> but you seem to use the old name here, so I would guess that this will
> not compile.
> 

Yeah, I guess I exposed my sed skills here :P Will fix it up while applying.

> With the function pointer renamed, this patch looks good to me:
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> 

Thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

