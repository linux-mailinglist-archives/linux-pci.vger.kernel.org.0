Return-Path: <linux-pci+bounces-14374-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D637299B291
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 11:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84227B22C70
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 09:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59DF132120;
	Sat, 12 Oct 2024 09:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zVD3trPA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A569913D29A
	for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 09:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728725472; cv=none; b=dUV3gXIj8OCPziT4WndqZK8wqB1iyQfMzi/XgeKThLnzr8ANzqd3+HnMMKWAOjJQRvr3RgoC3FEEZEKt/97PECRAq0z4yhahR2T27TrBAuboSP/78o7jDsnsu6emiWWLYV7YVnh6xbbEe34dFlP2TB7vRW0uWN3a9/a+Asgg6uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728725472; c=relaxed/simple;
	bh=T7xcItGbI2+5mK2O6A3Rv8KVWTocHFl0tE3ClKSoL4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQYwjbmMKoSpfUVR622xd5jgPpzb71A+MDemdOD9fWsvHdo0PaVmE3iXxPj+LQ4qTDlSe4FdOY40aKT7mzoT8OEEdnNWY7+x4UQXIcQM4GK/80qzoaZrdJdg3BKdXtYUZYVaHGiqN63w2u055Fb9yUiurBnmAW0YD8PXfovVFgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zVD3trPA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c70abba48so18960995ad.0
        for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 02:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728725469; x=1729330269; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rcftYANGLd6pDOpBmVKdv1wKLxatNo30nI4FX9b8jS0=;
        b=zVD3trPAwc37ReGc27shMu8XugaLGdKLReJk0tKAfaS+c4wyjl/1jGX5spzIGmE/LZ
         t+Zblwq++byYqmEwsHOLRs3cY1kUGX07o0VWOpJKGxdA/1L7CR0d6DS4HCivVncHcToG
         c87S56bs4DDItgSAiO0UhjHlBHzuvtqiWw67/25Ko684DeS9NVvafU57OQr/TLXVXXeK
         HScg0RJ00j17f393uWn7gZqIdIjPiML6SHuPiTx7t5iQEd8EiIvko5KSzga9IGtmxO7M
         ofW2AAq5wtEPFWgYXp9E1NFS7wWSprMx8gxk4iaELmAaWjGFzs2CS/fjMfQBB4eup+vA
         9QXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728725469; x=1729330269;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rcftYANGLd6pDOpBmVKdv1wKLxatNo30nI4FX9b8jS0=;
        b=XowL2cUqFrYkghUi9OeHOkjdETOMMatRj7BxdupP+q3dJAvxuzzgZ6oUJmwKI8HgSp
         RsJBOBAjRFYbFKS7eHxp7ukbgEgCMcWAbq5vEEDL8OpicMyD56CrNnvTX3IMb1EsmgIl
         JgTrH27GhOkzKZ7+N7IBk2XbLl4crjfvVJs6rVHcbV6n4oWx7aA/G2r+OO/7bR03lF/U
         xmOTEZ3ejRDWy0HkulGg9jaJc1R/xwPyXXasvRv1Y8UGqQ+n9MWWj1cliNfajc68SXpE
         GQZ02eZW5JSx6bM43rDhF5sLsuz8As0Qqv9otKvD+STRBoLn4HN+jfjj1rzW5mUD4Z0T
         Bh0g==
X-Forwarded-Encrypted: i=1; AJvYcCXBssg/t1PIA1Fx/BIbAPHYBTS6E0+iUVid0Zllb6RMEBSfpB90eiR4qLbtZfNuqFxOx9AI2jvY/qU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6kc4ZEUQvotG/HFyhx1JWIB37q/hvS2/DN1QOLlf15Ih2yJFe
	S2elo2X7R0HtnohTLK16UnhkaXFx+q1YLipD9lrq0ArFzFjB4S9LB0OTn/mjDw==
X-Google-Smtp-Source: AGHT+IGsrSVPLo2rqLm/AiXBekvMiDAlBEdtpXhvi9HiJkIymx4hBrwU78+sa3FEwKJHL6PkuqNiMw==
X-Received: by 2002:a17:902:f550:b0:20c:a175:1942 with SMTP id d9443c01a7336-20cbb1aa3a5mr27207425ad.24.1728725468864;
        Sat, 12 Oct 2024 02:31:08 -0700 (PDT)
Received: from thinkpad ([220.158.156.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc0546csm34476595ad.79.2024.10.12.02.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 02:31:07 -0700 (PDT)
Date: Sat, 12 Oct 2024 15:01:01 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v3 04/12] PCI: rockchip-ep: Improve
 rockchip_pcie_ep_map_addr()
Message-ID: <20241012093101.aj5hyeo3r7g6qlnn@thinkpad>
References: <20241007041218.157516-1-dlemoal@kernel.org>
 <20241007041218.157516-5-dlemoal@kernel.org>
 <20241010071357.c3kck3rxdhvy6m67@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241010071357.c3kck3rxdhvy6m67@thinkpad>

On Thu, Oct 10, 2024 at 12:43:57PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Oct 07, 2024 at 01:12:10PM +0900, Damien Le Moal wrote:
> > Add a check to verify that the outbound region to be used for mapping an
> > address is not already in use.
> > 
> > Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 

I'm trying to understand the ob window mapping here. So if rockchip_ob_region()
returns same index for different *CPU* addresses, then you cannot map both of
them? Is this a hardware ATU limitation?

Also rockchip_pcie_prog_ep_ob_atu() is not taking into account of the cpu_addr.
So I'm not sure how the mapping happens either.

- Mani

> - Mani
> 
> > ---
> >  drivers/pci/controller/pcie-rockchip-ep.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> > index 89ebdf3e4737..edb84fb1ba39 100644
> > --- a/drivers/pci/controller/pcie-rockchip-ep.c
> > +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> > @@ -243,6 +243,9 @@ static int rockchip_pcie_ep_map_addr(struct pci_epc *epc, u8 fn, u8 vfn,
> >  	struct rockchip_pcie *pcie = &ep->rockchip;
> >  	u32 r = rockchip_ob_region(addr);
> >  
> > +	if (test_bit(r, &ep->ob_region_map))
> > +		return -EBUSY;
> > +
> >  	rockchip_pcie_prog_ep_ob_atu(pcie, fn, r, addr, pci_addr, size);
> >  
> >  	set_bit(r, &ep->ob_region_map);
> > -- 
> > 2.46.2
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

