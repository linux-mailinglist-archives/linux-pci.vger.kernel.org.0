Return-Path: <linux-pci+bounces-29746-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFC9AD9102
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 17:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81EDF1E4C85
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 15:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B59C1E1DFE;
	Fri, 13 Jun 2025 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iV67mHC/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75712B9A9;
	Fri, 13 Jun 2025 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749827969; cv=none; b=GiJat+/3fiyZsd09VbsnMng4NpL/Yz5bopTw15j+t/Mp+xYBRHj9srBtos7HBAs8NJDepo5xicKqE1T/i8n3AiarGTIWfR6UzgQbWKC+aDh2GAJ+xhkxAaiqfZBiGBzDEuhif0BYHw5enEbB6Q3Hg7dSZWsZh66a5h0JeMDQ9Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749827969; c=relaxed/simple;
	bh=nHPJUt2IiJwZuWc7/3YI2Y+yJKOyCh18zYy1JNeGUbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHubbrvfFo5G4crwN4dteKPJ9ry+KWnnWLw3YgA/W4tGBSReWCfvH8zJiTzPJAIMiriXU6YT5XfewqH0JrS2VdWudD2t4bHwFiRtZt0g8YIEK8vCqKH/ghdGkOL3P/bRrG2O5cBDP8qx1vymeU4ToIaTNw5clAeGbDKc7R0RV/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iV67mHC/; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7406c6dd2b1so3197764b3a.0;
        Fri, 13 Jun 2025 08:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749827967; x=1750432767; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E5wEqTLrIuHxlff07XhC6OAddwglGpYMw59cggcJYQ4=;
        b=iV67mHC/LiSPY90ReVi3U9qC5C9aXwY/JEQr1Tr+I5+FVnXbD04RFVg/yr4WOKP/+9
         /HIPunQDhAXotuKNoG2dja2gjYMQSBQrWmSgy6Bh/YMt49BP/UTi5uESJsG6ji6OVYOT
         EXh9lqJ3Lbw7RLa3t1jTafYAWWWSsAChgkcnxcySYnibx90su7yEmhaSLT238AyvUeMP
         JmKp98IcDQWM1x+g6BvjPgVtqJ05ZX2vkQFoVC094BHsynsKyu9HtuSQJEv+Shdda3YA
         4KBwp9mgJNyq5NWbbW5hcjH1U+NKL0xMytuJ5Enrr6d7uFn/fwGeC28IGXgM1GXWMYaT
         oOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749827967; x=1750432767;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E5wEqTLrIuHxlff07XhC6OAddwglGpYMw59cggcJYQ4=;
        b=MMdnIozr6j4VQSm4py2Y7BLiswn3fcw5Rqk87yOJ1ZUp9d7132TZU7dyyeh+Y+8FUJ
         mAmQFhku7DiK+aoXQsnAEStKL1lPTjxS2vm1dqgrTRd/Hh2F37XxbG6BtRULO4oL/6Nn
         9mltPCXdZtbWWQGOmaotg4kqhoXGW/nWKnG6tOdS+7EeQ5OLUly63rbFz5XWVE5XFx5T
         24htzA32y/5Azl22XTcNhDXQJzRTDGQ/+P0BQEeun8OaFcJ7a+4wTb5PwElbDU1PTA4R
         PhzCRVf7SGVMa0l9oJ/o77TB8OmQU7k7GelEg7Aa9yVjvrY8g/eOrk6CilCll+DaVblB
         ZYkA==
X-Forwarded-Encrypted: i=1; AJvYcCWwE9NRaUIrh0ZPdbOMgc8ph/Awc+Kq7jYeRfpEwTXFu8XMsMuHdq+IqHOqf7TfC6GwxpD3HHRG5peJ@vger.kernel.org, AJvYcCXnoHhPZ8T/F0A3jW6TUDEfgGiCiwx6izaJqvBkytmXhRmyTzdIYinlin0jFtmsZ9aNjm8CvT+OqM/JhZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2kO7Z87IbW9OympdMXPIZu6Tb84lUZSMGQHwpmLoCgVg5rpA/
	HlL3CUOracu8TWYJr7FULk5dift0tsHakz2NZwNYpzQDTUNO9p2BPQSY
X-Gm-Gg: ASbGncu34j/UXa63JxwIFt2X2bkLagzBVm4gChRWPVG+hPsE2xHkN4+tgV4YsOBVvZj
	As95G8SZBcEOM7Q67nsMPleiu27Ol0DF5urqzMhyx3y/35UFFL+ukUQMliuuGGEFyYZYRVY9ppo
	tY0MHC3pwDiCaGfV/3nABh1hHdU+siDy1wwZOcQ3emb3FzvXzn9HvK/QczRn90ftUibqkg4axQ5
	22H4Dn3CPyrzaVz/ARiJIMMqZRKkAIvo9/o/7GQiC1vWwfe045f/21uprZlrcoKcB9YJDjomt0Y
	V+tPBwiWeg+81D4uZM9aUacl6Ke70vjtGGE8n15xujLT1aruLw==
X-Google-Smtp-Source: AGHT+IH6BtrN8GvaynSvVoLNqD2VGmMz6n61XivbhbvYaO0BgySl9/odnV8zmrOFQ6SXd92rPXn+AA==
X-Received: by 2002:a05:6a00:10c9:b0:742:b928:59cb with SMTP id d2e1a72fcca58-74898586762mr1340177b3a.7.1749827966984;
        Fri, 13 Jun 2025 08:19:26 -0700 (PDT)
Received: from geday ([2804:7f2:800b:838f::dead:c001])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7489008303fsm1687203b3a.79.2025.06.13.08.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 08:19:26 -0700 (PDT)
Date: Fri, 13 Jun 2025 12:19:20 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v4 2/5] PCI: rockchip: Drop unused custom registers
 and bitfields
Message-ID: <aExBeNdkOtFtW87z@geday>
References: <cover.1749826250.git.geraldogabriel@gmail.com>
 <ed25d30f2761e963164efffcfbe35502feb3adc2.1749826250.git.geraldogabriel@gmail.com>
 <97114c68-5eb7-18b0-adbd-227e1d7957c6@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97114c68-5eb7-18b0-adbd-227e1d7957c6@linux.intel.com>

On Fri, Jun 13, 2025 at 06:03:14PM +0300, Ilpo Järvinen wrote:
> On Fri, 13 Jun 2025, Geraldo Nascimento wrote:
> 
> > Since we are now using standard PCIe defines, drop
> > unused custom-defined ones, which are now referenced
> > from offset at added Capabilities Register.
> 
> These are quite short lines, please reflow the changelog paragraphs to the 
> usual length.

Hi Ilpo,

I'll reflow for v5.

> 
> > Suggested-By: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> > ---
> >  drivers/pci/controller/pcie-rockchip.h | 11 +----------
> >  1 file changed, 1 insertion(+), 10 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> > index 5864a20323f2..f611599988d7 100644
> > --- a/drivers/pci/controller/pcie-rockchip.h
> > +++ b/drivers/pci/controller/pcie-rockchip.h
> > @@ -155,16 +155,7 @@
> >  #define PCIE_EP_CONFIG_DID_VID		(PCIE_EP_CONFIG_BASE + 0x00)
> >  #define PCIE_EP_CONFIG_LCS		(PCIE_EP_CONFIG_BASE + 0xd0)
> >  #define PCIE_RC_CONFIG_RID_CCR		(PCIE_RC_CONFIG_BASE + 0x08)
> > -#define PCIE_RC_CONFIG_DCR		(PCIE_RC_CONFIG_BASE + 0xc4)
> > -#define   PCIE_RC_CONFIG_DCR_CSPL_SHIFT		18
> > -#define   PCIE_RC_CONFIG_DCR_CSPL_LIMIT		0xff
> > -#define   PCIE_RC_CONFIG_DCR_CPLS_SHIFT		26
> > -#define PCIE_RC_CONFIG_DCSR		(PCIE_RC_CONFIG_BASE + 0xc8)
> > -#define   PCIE_RC_CONFIG_DCSR_MPS_MASK		GENMASK(7, 5)
> > -#define   PCIE_RC_CONFIG_DCSR_MPS_256		(0x1 << 5)
> > -#define PCIE_RC_CONFIG_LINK_CAP		(PCIE_RC_CONFIG_BASE + 0xcc)
> > -#define   PCIE_RC_CONFIG_LINK_CAP_L0S		BIT(10)
> > -#define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_BASE + 0xd0)
> > +#define PCIE_RC_CONFIG_CR		(PCIE_RC_CONFIG_BASE + 0xc0)
> 
> This will cause a build failure because PCIE_RC_CONFIG_CR is used in 1/5 
> but only introduced here so you'll need to do this in the same patch as 
> any step within a series must build too. IMO it would anyway make sense to 
> combine patches 1 & 2.

Ah, interesting angle. I'll fix it.

> 
> >  #define PCIE_EP_CONFIG_LCS		(PCIE_EP_CONFIG_BASE + 0xd0)
> 
> Aren't you going to convert this as well?

I can, but I can't test it however! But I'll Cc: someone who hopefully
can.

Thanks,
Geraldo Nascimento
> 
> >  #define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE + 0x90c)
> >  #define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
> > 
> 
> -- 
>  i.
> 

