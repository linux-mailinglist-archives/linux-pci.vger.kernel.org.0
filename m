Return-Path: <linux-pci+bounces-4122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A434869052
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 13:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8751C20E33
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 12:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A049C13AA58;
	Tue, 27 Feb 2024 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtdiwcU9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D15113AA51;
	Tue, 27 Feb 2024 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036468; cv=none; b=tgTfDmuS2j8jFVJSDevtWa9KbMd12bNQ3IeafzuPCFsvn76ZeBC08v1PvxIu+tMaKQAN5xz3eFkCBtp/nzuk503I/CuOOJZwFfhg9ypNB+npRBb4LK8LwoqZCkTykr51TefxIi3Sfarkp5wx1/vLhkB8pH47zuNQLQZDKJTLUjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036468; c=relaxed/simple;
	bh=oyWFbEvn5bNpJPoUUha+0MQeB/JABm8GUNDl/KEdi0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ST69otNNJFzB52XLLZGRPE8O2WELgYzkEdi7KVgmX3hRUWVMuvH/qnuBbylSQ33D1xdy7y4L0kzRoH08wKAH5qVYw5plsru5/EMxZ/RKXsgGImsU21Q8IzaJQyRSLEkyfI3li/rNaQapnxxonjGptPvOF15AXZ5/DNXpJ53X/jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtdiwcU9; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512f5484a37so3749516e87.3;
        Tue, 27 Feb 2024 04:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709036465; x=1709641265; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+UiG2wqcRS1Sx3jAk7tguEpouMFpI1yilLUIM0yjSvo=;
        b=DtdiwcU97pjfdG9hVOufNkKl54QZKrUYYDBsF+D1Ww2tpgBH92JQVTTvQUW20Igy7T
         xuQR3xzRLacxzW2USQJANMs9S6X64zaDIxRVc3nAEjm6KXPw5Jf0+u9E11RFGXS0cVK8
         oZVTT05J8JwngksePiYY3DC3cxZlHBDR1WNQs/VAFXBAB1b3laxHpYvE1FAUM0+FNpfA
         UtMn65MWJrl+iH8ZwE2LEA4oLE1CJNhfDTvOXYM6kQLbzDl0R2LK5BBpSqzgDBzOZkZs
         8UXWJNxRWk/nuve4nc0aKJJCIiVcUOjHhn4Iy8kpEt7Jb7AJgbFXHCaHCNJyOws2k+Xt
         QwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709036465; x=1709641265;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+UiG2wqcRS1Sx3jAk7tguEpouMFpI1yilLUIM0yjSvo=;
        b=h4pojhkIRqiRLsJxCILBFjMwAFPdsjHeWVFKI99Br1f21LVLFhcK4nBAZjgrvp6x+T
         YzL+dvEDTNDWUwym6BJMQsyp84Xcdng9JWkNMEwQ+mc+H6V3cOUJH7YgXwm7iHPR21DL
         EyELh869nFPEmTtdZG72knjs4KloKVydL7+xV8e/zjLtRYD78p+Bf34hc3re1WiTUE/J
         TGYFAhCDDVgn9nT+i4QyYOiGmOoRc2GYoZzeNwC6JPfw/q4867cHBWEBi51glHbkgio1
         M+dxhDcvBOd0JZg7AUihlDo3bdiMX+qLwSO3SbSdek8OV1RxZlpX7zc7C2Sy/SrPNPPr
         tw1A==
X-Forwarded-Encrypted: i=1; AJvYcCXDhD35+RCVnHTf2fxfXuOWQRClLrLDpa5O9dC8Q2/eJe1+t0gpM45il0qx37A/5NxBWj2DoyeozXVJwVouTCYwpddpq/rMh30KvOvpS34iNfTHuP0cT21cPXX3hR3sb2rjKMN9fhVlqjBVEQ94tla6bUng/o2Bk4tXPfNbwQwbYSXzr4IRL6cQSEEw63pyQDkHVRWmUdKM5MaDEnpWpnIXREhYfm1NhdCJ
X-Gm-Message-State: AOJu0Yy/5S/AQ8QUKTwboZsT0G7M/nMxjAcF6aX2DnrARRqj8mw7OXHy
	bkEaPP9eV8WtjsG+pWkLs8mBuBxt0Oi7NCSDCg1L3klO3N/3KaG7
X-Google-Smtp-Source: AGHT+IHki1IzFC7bJGQf318FsyvwZ0oLFKtMs8eHrcJanJqzvjrP+qWMSLbA/vhzS3pwzR3oyy89ow==
X-Received: by 2002:a05:6512:33d5:b0:512:fe39:5d0e with SMTP id d21-20020a05651233d500b00512fe395d0emr4598773lfg.9.1709036464384;
        Tue, 27 Feb 2024 04:21:04 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id o13-20020ac25b8d000000b0051315216363sm25361lfn.238.2024.02.27.04.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 04:21:03 -0800 (PST)
Date: Tue, 27 Feb 2024 15:21:00 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Marek Vasut <marek.vasut+renesas@gmail.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 2/5] PCI: dwc: Skip finding eDMA channels count if
 glue drivers have passed them
Message-ID: <nl4byqs3boe3zke6yvnxmwpgw5oi63ubo36rgzejzg2c4ymwm5@utad76n57gr5>
References: <20240226-dw-hdma-v3-0-cfcb8171fc24@linaro.org>
 <20240226-dw-hdma-v3-2-cfcb8171fc24@linaro.org>
 <5gzkxdpx6u3jhw5twbncjhtozgekmlzxrpj3m6is3ijadm2svb@f6ng4owyakup>
 <20240226153014.GG8422@thinkpad>
 <4p4z5eyhpdhxzi36drhrmz6z7krupszddudg6c2baypkbnnj7t@nqcmk2wdntts>
 <20240227084204.GI2587@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240227084204.GI2587@thinkpad>

On Tue, Feb 27, 2024 at 02:12:04PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Feb 27, 2024 at 12:32:44AM +0300, Serge Semin wrote:
> > On Mon, Feb 26, 2024 at 09:00:14PM +0530, Manivannan Sadhasivam wrote:
> > > On Mon, Feb 26, 2024 at 03:53:20PM +0300, Serge Semin wrote:
> > > > On Mon, Feb 26, 2024 at 05:07:27PM +0530, Manivannan Sadhasivam wrote:
> > > > > In the case of Hyper DMA (HDMA) present in DWC controllers, there is no way
> > > > > the drivers can auto detect the number of read/write channels as like its
> > > > > predecessor embedded DMA (eDMA). So the glue drivers making use of HDMA
> > > > > have to pass the channels count during probe.
> > > > > 
> > > > > To accommodate that, let's skip finding the channels if the channels count
> > > > > were already passed by glue drivers. If the channels count passed were
> > > > > wrong in any form, then the existing sanity check will catch it.
> > > > > 
> > > > > Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> > > > > Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > ---
> > > > >  drivers/pci/controller/dwc/pcie-designware.c | 16 +++++++++-------
> > > > >  1 file changed, 9 insertions(+), 7 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > index 193fcd86cf93..ce273c3c5421 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > @@ -927,13 +927,15 @@ static int dw_pcie_edma_find_channels(struct dw_pcie *pci)
> > > > >  {
> > > > >  	u32 val;
> > > > >  
> > > > > -	if (pci->edma.mf == EDMA_MF_EDMA_LEGACY)
> > > > > -		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> > > > > -	else
> > > > > -		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> > > > > -
> > > > > -	pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
> > > > > -	pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
> > > > 
> > > > > +	if (!pci->edma.ll_wr_cnt || !pci->edma.ll_rd_cnt) {
> > > > 
> > > > Are you sure that the partly initialized case should be considered as
> > > > a request for the auto-detection? IMO &&-ing here and letting the
> > > > sanity check to fail further would be more correct since thus the
> > > > developer would know about improper initialized data.
> > > > 
> > > 
> > > We already have the check below. So the partly initialized case will fail
> > > anyway.
> > 
> > Not really. If the partly initialized case activates the
> > auto-detection procedure it will override both non-initialized and
> > _initialized_ number of channels with the values retrieved from the
> > hardware, which the glue driver has been willing not to use. This
> > prone to undefined behavior depending on the reasons of skipping the
> > auto-detection procedure. For instance, assume the DMA_CTRL register
> > reports an invalid number of read channels. A glue driver by mistake
> > or willingly overwrites the pci->edma.ll_rd_cnt field only. This won't
> > solve the problem since the auto-detection will be proceeded due to
> > the pci->edma.ll_wr_cnt field being left uninitialized.
> > 
> > So to speak it would be better to implement a strictly determined case
> > for activating the auto-detection procedure: both number of channels
> > aren't initialized; if only one field is initialized then report an
> > error.
> > 
> > Alternatively we can have the auto-detection executed on the
> > per-channel basis:
> > 
> > +	if (pci->edma.mf != EDMA_MF_HDMA_NATIVE) {
> > +		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> > +
> > +		if (!pci->edma.ll_wr_cnt)
> > +			pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
> > +
> > +		if (!pci->edma.ll_rd_cnt)
> > +			pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
> > +	}
> > 
> 
> Hmm, in this case there is no need to check for uninitialized channels count:
> 
> 	/*
> 	 * Autodetect the read/write channels count only for non-HDMA platforms.
> 	 * HDMA platforms doesn't support autodetect, so the glue drivers should've
> 	 * passed the valid count already. If not, the below sanity check will
> 	 * catch it.
> 	 */
> 	if (pci->edma.mf != EDMA_MF_HDMA_NATIVE) {
> 		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> 
> 		pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
> 		pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
> 	}
> 
> 	/* Sanity check */

That is another possible implementation. Let's sum all of them up:

1. Channel fields-base conditional statement:
+	if (!pci->edma.ll_wr_cnt && !pci->edma.ll_rd_cnt) {
+		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
+
+		pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
+		pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
+	}
pros: NoF channels override support for all IP-cores; simple.
cons: incompatible with HDMA, but can be taken by mistake/bug; no
partial NoF channels pre-initialization.

2. Channel fields-base conditional statement with logical OR operator #1:
+	if (!pci->edma.ll_wr_cnt || !pci->edma.ll_rd_cnt) {
+		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
+
+		pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
+		pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
+	}
pros: NoF channels override support for all IP-cores; simple.
cons: incompatible with HDMA, but can be taken by mistake/bug; no
partial NoF channels pre-initialization; silently overrides the
partial NoF channels case.

3. Channel fields-base conditional statement with logical OR operator #2:
+	if (!pci->edma.ll_wr_cnt || !pci->edma.ll_rd_cnt) {
+		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
+
+		if (!pci->edma.ll_wr_cnt)
+			pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
+
+		if (!pci->edma.ll_rd_cnt)
+			pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
+	}
pros: NoF channels override support for all IP-cores; partial NoF
channels pre-initialization support.
cons: incompatible with HDMA, but can be taken by mistake/bug; more
complex (and actually looking a bit clumsy due to two conditional
statements over the same fields).

4. Unconditional auto-detection:
+	val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
+
+	if (!pci->edma.ll_wr_cnt)
+		pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
+
+	if (!pci->edma.ll_rd_cnt)
+		pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
pros: NoF channels override support for all IP-cores; partial NoF
channels pre-initialization support; simple.
cons: incompatible with HDMA, but will be executed for it anyway so
the NoF channels fields will be overridden with the Channel#0.prefetch
CSR data if haven't been pre-initialized;

5. Mapping format-based conditional statement:
+	if (pci->edma.mf != EDMA_MF_HDMA_NATIVE) {
+		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
+
+		pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
+		pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
+	}
pros: free of being executed for HDMA IP-core, simple
cons: no NoF channels override support for non-HDMA IP-cores.

6. Mapping format-based conditional statement with partial NoF channels override:
+	if (pci->edma.mf != EDMA_MF_HDMA_NATIVE) {
+		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
+
+		if (!pci->edma.ll_wr_cnt)
+			pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
+
+		if (!pci->edma.ll_rd_cnt)
+			pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
+	}
pros: free of being executed for HDMA IP-core; NoF channels override
support for all IP-cores.
cons: more complex.


Looking at all of that I'd say that options 5 and 6 seems better to me
now since they prohibit the auto-detection for HDMA IP-cores which
have the Channel#0.prefetch CSR at the 0x8 offset. I don't have strong
opinion which of those two to choose. If you think simplicity is
preferable, then option 2 will be enough. If you wish to have the NoF
channels override supported for all IP-cores, then option 3 will work
for it.

-Serge(y)

> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

