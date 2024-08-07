Return-Path: <linux-pci+bounces-11454-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E9294AE9D
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 19:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1EF0B260A6
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 17:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22E913DBBC;
	Wed,  7 Aug 2024 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WhJY6mYI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F9413DDC0
	for <linux-pci@vger.kernel.org>; Wed,  7 Aug 2024 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723050024; cv=none; b=lW4w7gf8PUJNGPp6u53mwKEOGaB1PscMv+KnFwek37al5ZWRJGPv5Tk2U47DcTQ0yhpaQ9kNh4IrWpKgIAqLrpYAYRlvQqw9o8zmwUEqUU5bsRu8AcjXuQ/m1JQ/J9JtQhHTRFmDfSBQ8ga4jPwMaJ6wTeyYhVJhMGcmUV4gnkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723050024; c=relaxed/simple;
	bh=jL7S3d8oy5zxfp5mRfu6SUwGyJ1m2Qne4UZtkrwTc3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAiwgv3KJTWaG5CxMaFpBcuZDKNSXy5ruJiFW30f+WEQPRbutr6bR2XjlWpdDqfXdRBMgx0bhZHCXGDFK0uba1oHgNI8AlHGp09WyIhkVJm5b7wXWG5ZzJgmLRI7DRkLuaRDL8jmxb0s8/Y1Hpca/vImbkh916JeKix8GAgFyOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WhJY6mYI; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fb3b7d0d56so913705ad.1
        for <linux-pci@vger.kernel.org>; Wed, 07 Aug 2024 10:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723050023; x=1723654823; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WWwBbhcDkvNaxUygLQVH/xx2sd0hR+vnAl1kEVRw/lA=;
        b=WhJY6mYIQSo4DpYmxhDH62aeGfPX0/t/txUNvLKaDcfwiPnfrZsEDKX3ydYFpH99oi
         khzQXaBS9t2X00QRdEiuJy62WLl9xnNTmZyVeuDmGxV6y5HIkqUPgm0/MXzupp0b1zWX
         SdcRonBDMuFMVRUQfBlcL/6+dHqr6jfFxOVNN03AdTCaTtE3DnxBzR6jNLjqxJGuKxs8
         G0bYIiFKlIzF3U1qDgNF5nKk90spfQXpTvgFzmaIz2yVE+o8VeAaDxr+Gri4Aj7IukXx
         40DvvxFKKfnQDdnVEq2pulPOog1WfRpFahsuCR9FHmCQrYyyG1wZFFAwFS47+HaAv50A
         77Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723050023; x=1723654823;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WWwBbhcDkvNaxUygLQVH/xx2sd0hR+vnAl1kEVRw/lA=;
        b=lyHNWYQocHL0gLlbBzIe0zWjV4/XJYGPX4liSkZ8tv9QSpju9Tci2ABgt+PA8nnBoy
         sXkIIIU+gu6P/8F9tcsANQrsEjcZg6srGm3Y5czANJeFGBmbWs9Zs0nKWZOAkx2zFsml
         CaFyIfvJBhzmGBfjMYzzZl2BLvoYF0fbtByQBlNSMFxUKjuYIUWQ0q28TdJgoVOq373u
         O324O/tuAc95y3kAE8gKRf9xpsGZqbbd1aRgalkjg7MIQvCSlr8ubj6h888CEWVGjhF1
         57jXqOV0S85+d8Rlqv34lt8vgleLLjfkYXL7zxW+H2DhGVB/Xxcxb0KmpOsSZzg/S6MK
         up4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW96cbRhxSbkxbZnjZNnoiwnvuXq65LknZqa6ttVZg+5/3Z0y7WxI1SnBERV8/2++bU0mpG7Kbl/bOLpN6+sy2i9wevxIObgxlE
X-Gm-Message-State: AOJu0Yz2LCuh7Oq/hWY8KUzsfI6O7hmlX8CL2X+HG4ySFujNygdqNvTf
	HTn+STHfgCC6L0ArO5ZuhLuG86WsGrjJH91fW5mU8Rkz3Q053TioX+2XQepdMw==
X-Google-Smtp-Source: AGHT+IGQ8DPd+Wqtq+Spl5EDiAuVhLzByGSc7Am4v9rp+zU/4CqC8Aerp7AGU/R+/C2yss5AVMTF5w==
X-Received: by 2002:a17:903:1108:b0:1fd:9044:13d8 with SMTP id d9443c01a7336-1ff57257f52mr197895405ad.9.1723050022643;
        Wed, 07 Aug 2024 10:00:22 -0700 (PDT)
Received: from thinkpad ([120.60.60.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592ad9e4sm108304425ad.283.2024.08.07.10.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 10:00:21 -0700 (PDT)
Date: Wed, 7 Aug 2024 22:30:11 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Anand Moon <linux.amoon@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linu-next v1] PCI: dw-rockchip: Enable async probe by
 default
Message-ID: <20240807170011.GC5664@thinkpad>
References: <20240625155759.132878-1-linux.amoon@gmail.com>
 <20240807163106.GA101420@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240807163106.GA101420@bhelgaas>

On Wed, Aug 07, 2024 at 11:31:06AM -0500, Bjorn Helgaas wrote:
> On Tue, Jun 25, 2024 at 09:27:57PM +0530, Anand Moon wrote:
> > Rockchip PCIe driver lets waits for the combo PHY link like PCIe 3.0,
> > PCIe 2.0 and SATA 3.0 controller to be up during the probe this
> > consumes several milliseconds during boot.
> 
> This needs some wordsmithing.  "driver lets waits" ... I guess "lets"
> is not supposed to be there?  I'm not sure what the relevance of "PCIe
> 3.0, PCIe 2.0, SATA 3.0" is.  I assume the host controller driver
> doesn't know what downstream devices might be present, and the async
> probing is desirable no matter what they might be?
> 

Since the DWC driver is enabling link training during boot, it also waits for
the link to be 'up'. But if the device is 'up', then the wait time would be
usually negligible (few ms). But if there is no device, then the wait time of 1s
would be evident.

But here the patch is trying to avoid the few ms delay itself (which is fine).
The type of endpoint might have some impact on the link training also. But async
probe is always preferred.

- Mani

> > Establishing a PCIe link can take a while; allow asynchronous probing so
> > that link establishment can happen in the background while other devices
> > are being probed.
> > 
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > index 61b1acba7182..74a3e9d172a0 100644
> > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > @@ -367,6 +367,7 @@ static struct platform_driver rockchip_pcie_driver = {
> >  		.name	= "rockchip-dw-pcie",
> >  		.of_match_table = rockchip_pcie_of_match,
> >  		.suppress_bind_attrs = true,
> > +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> >  	},
> >  	.probe = rockchip_pcie_probe,
> >  };
> > -- 
> > 2.44.0
> > 
> 

-- 
மணிவண்ணன் சதாசிவம்

