Return-Path: <linux-pci+bounces-21459-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2829DA35F14
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 14:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BBD41602C7
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 13:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CA6265CB6;
	Fri, 14 Feb 2025 13:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yYdOZ9z6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D509264A90
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539285; cv=none; b=h9TuY+0hRo0nTF72sLaTvboWHfu2RYM+/0cPtpeglrBXlcJh9dKgZn32zY/64L7PKWQEMhdO+nMl4Hi/wLMiuxQvWpeBnbZyAsXTaIMzyN+nV5lMJ7y3g/IA4bkDD0bnEPn4Gsfn1nu4NZBwYAkh+KMgW6kghNS9H8Kwy53Btp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539285; c=relaxed/simple;
	bh=iUpdeyeQQjXOQvrBPlDvQAeSvEhUZLpAr5hoCBShPAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVSXj98X/1dVBXGjqyud+4sYNLbU33ekb5s1vB7NdxyBv5oDGMTerb01exzX8WCGwJQGmshPNHxGVomYVGaO83HVRW6OndzRrq22UJpez0r6M8k7KHpMDVPk0E/uMMZokRypeiOBlatkwUf/ghEybJtWRABcbqaOXb6v3pH5SHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yYdOZ9z6; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fc3db58932so89775a91.2
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 05:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739539282; x=1740144082; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D6X7TbU2TKSA6FfWi/bx/2Zh2Uwig40zqLcYQUHDpnM=;
        b=yYdOZ9z6UK1QaqaMp4oCgDQa+dDPShDLe7gf1uGn3L8Ab4eVKyOTOAr9fYefJ4Q/E7
         V2nbvqf9lPbG/VpcflrFzczZHXd6NfKULMXmWBxPoNV9ECWPovEb4j9InJDdGPGNbx+r
         aSAVzfgDB9fqZ/Ul22I44w2uroJkGJRrO57AR+s+R1S3Z5HX3zqDesBvxTVJDwVH7NU7
         6HobBgsaA5ZWi8OdoYAeVLyMJhQYvj0b5veaQr9yFg374PFZIE1HBiociH0jFW+DOCvY
         sg5aEhSXcnsQigI3eOjreCWw/xme6RgpMmIOYllOYgFq5Zttp6V/Fzfql+yBbUgEUued
         g4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739539282; x=1740144082;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D6X7TbU2TKSA6FfWi/bx/2Zh2Uwig40zqLcYQUHDpnM=;
        b=v4x5WhxmdbGVBqEUma22Ce72RPGsI/F727fExccsXOA1uxlDaUNxu401xsnJjFp+jB
         MJv21Fszgh846AbDpphMO8QDEA3Z2JsaVbQ3SAhdUpvKit2nQFdZRPBDUF73ykh7Gd1p
         mGDmqn1Y5mnoP157HxpI0ORFuv1aebmECKTh9B2xX3RBHxUdh/DJhFfZnmJVf0JhX859
         HGh9EMOaTSxynpRprUSZ/K0mJUf3EOK3sxMiUTQugEhw52ZES4q1iacfkVeAT5vkW3hg
         AQkiSQ5skVE1xGG36pbc/wGeVJdItBY3StcH20dht1ARpPEiE8cIJ7TLxy+SoFvmQIsB
         srUw==
X-Forwarded-Encrypted: i=1; AJvYcCWWiJsc+urntRY9+2UEGwfJDoLiaASwi0D/GSgDwv2sIVH0AR//GQgyWWyb0vEr9kJN1tQtpF5FujE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVqpIEapxcSazzxIMlQR5Bkk4HLjKj4N+PdTUOQ8bQiZd2z/z9
	r5HtGy9GZznkbzfDXAjBRLfYWDQn6ptSGseuUcXXYSb71E16mpp2p5MpRNkifw==
X-Gm-Gg: ASbGnctGbIlUJOxlATPaJQTfrrjZigIREbpb00fgpjYMBWrqTNxj7qwytf6Nfx/+zik
	BJcudlDcjBNG5nkWW/36fu4eX+p0CWX/DLXJM8ZuHMiOUJNzUUSYDvMFopBcCGIC2lv/6PDcaWd
	5ynaIEwrNUTc+DKRXt0BO0tv7o/vAAQg4wu1G+wI8t3JJfJ1Fh5laNsSZ0qHEjwnTiC5rssCaoQ
	BMzA7rDSuyxVh64pPWwideiSKqEtDYhGC+6gmxBa3OTV1IwpCA5xzl8tqmWp5EJ3aBkOKvckhT4
	82cuKGJ9FI/pQ2zCtPzo8nEMdAZhHmU=
X-Google-Smtp-Source: AGHT+IFojHOCI81P67j+Pdb6NB1BhabP8Ji4yZG9LPBDN4to6OWIQ20bBJz01hSrYBfB9Y6LZ3Z0iw==
X-Received: by 2002:a17:90b:4b06:b0:2ee:f687:6ad5 with SMTP id 98e67ed59e1d1-2fbf8957f05mr16448954a91.2.1739539282301;
        Fri, 14 Feb 2025 05:21:22 -0800 (PST)
Received: from thinkpad ([2409:40f4:304f:ad8a:250c:8408:d2ac:10db])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf999b5b4sm5588794a91.30.2025.02.14.05.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 05:21:21 -0800 (PST)
Date: Fri, 14 Feb 2025 18:51:15 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, bwawrzyn@cisco.com, cassel@kernel.org,
	wojciech.jasko-EXT@continental-corporation.com, a-verma1@ti.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rockswang7@gmail.com
Subject: Re: [v3] PCI: cadence: Fix sending message with data or without data
Message-ID: <20250214132115.fpiqq65tqtowl2wa@thinkpad>
References: <20250207103923.32190-1-18255117159@163.com>
 <20250214073030.4vckeq2hf6wbb4ez@thinkpad>
 <7eb9fedc-67c9-4886-9470-d747273f136c@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7eb9fedc-67c9-4886-9470-d747273f136c@163.com>

On Fri, Feb 14, 2025 at 04:23:33PM +0800, Hans Zhang wrote:
> 
> 
> On 2025/2/14 15:30, Manivannan Sadhasivam wrote:
> > On Fri, Feb 07, 2025 at 06:39:23PM +0800, Hans Zhang wrote:
> > > View from cdns document cdn_pcie_gen4_hpa_axi_ips_ug_v1.04.pdf.
> > > In section 9.1.7.1 AXI Subordinate to PCIe Address Translation
> > > Registers below:
> > > 
> > > axi_s_awaddr bits 16 is 1 for MSG with data and 0 for MSG without data.
> > > 
> > > Signed-off-by: hans.zhang <18255117159@163.com>
> > > ---
> > > Changes since v1-v2:
> > > - Change email number and Signed-off-by
> > > ---
> > >   drivers/pci/controller/cadence/pcie-cadence-ep.c | 3 +--
> > >   drivers/pci/controller/cadence/pcie-cadence.h    | 2 +-
> > >   2 files changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > > index e0cc4560dfde..0bf4cde34f51 100644
> > > --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > > +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > > @@ -352,8 +352,7 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn, u8 intx,
> > >   	spin_unlock_irqrestore(&ep->lock, flags);
> > >   	offset = CDNS_PCIE_NORMAL_MSG_ROUTING(MSG_ROUTING_LOCAL) |
> > > -		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code) |
> > > -		 CDNS_PCIE_MSG_NO_DATA;
> > > +		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code);
> > >   	writel(0, ep->irq_cpu_addr + offset);
> > >   }
> > > diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> > > index f5eeff834ec1..39ee9945c903 100644
> > > --- a/drivers/pci/controller/cadence/pcie-cadence.h
> > > +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> > > @@ -246,7 +246,7 @@ struct cdns_pcie_rp_ib_bar {
> > >   #define CDNS_PCIE_NORMAL_MSG_CODE_MASK		GENMASK(15, 8)
> > >   #define CDNS_PCIE_NORMAL_MSG_CODE(code) \
> > >   	(((code) << 8) & CDNS_PCIE_NORMAL_MSG_CODE_MASK)
> > > -#define CDNS_PCIE_MSG_NO_DATA			BIT(16)
> > > +#define CDNS_PCIE_MSG_DATA			BIT(16)
> > 
> > Oops! So how did you spot the issue? Did INTx triggering ever worked? RC should
> > have reported it as malformed TLP isn't it?
> > 
> In our first generation SOC, sending messages did not work, and the length
> of messages was all 1. Cadence fixed this problem in the second generation
> SOC. And I have verified in the EMU environment that it is OK to send
> various messages, including INTx.
> 
> And that's what Cadence's release documentation says:
> axi_s_awaddr bits 16 is 1 for MSG with data and 0 for MSG without data.

I'm confused now. So the change in axi_s_awaddr bit applies to second generation
SoCs only? What about the first ones?

Are you saying that the first generation SoCs can never send any message TLPs at
all? This sounds horrible.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

