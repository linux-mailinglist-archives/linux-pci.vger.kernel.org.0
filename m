Return-Path: <linux-pci+bounces-4126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 795108690A4
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 13:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020721F23B3B
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 12:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B54013957E;
	Tue, 27 Feb 2024 12:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="prlmLAjy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5649C1CFA9
	for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709037168; cv=none; b=qh4JntESYZas8wVdqEAdwRLEzDf5J16ShsnhswtOx5YCPut52oNZ0ThskDnpPViLuFS62utodoX8e4HF3We1EQJGKr6Ve0kvVamN/GkjwRCdWKVYvdaokUqqhYyeUNcQnnWjIppUaUyq8jhN5I80ck/p+AFbs3GfyNtH1eMy7kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709037168; c=relaxed/simple;
	bh=iRPyBsf91aBgQomrNp6NHB0+TRiYOkN18LHNhGZ5bAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHH6Z94fcLRbk3pSmU+GRQoogO39Oa6NmgiiS8kT53gfEwLqdgf9a+7lU733LjNfoHBwm20MGOyyceUz+w3NRwxWG6mBghdjM7IOffl+GB21wzZZyi3F6b7PerZ/mTPiunXfdgRT4O0h7FZFBPB7JA+/amTWux8qPkvNYP7MPhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=prlmLAjy; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e4670921a4so2283841b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 04:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709037165; x=1709641965; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r6McJiuv+h7AyXeU5mDp5gY4ceOSplSmKT9ljaBZAeI=;
        b=prlmLAjy/C/TRxN6wQ49FPKtqoxLaPqhp40puhqd5vZQZOenFq4l/E2FczruDcb+cF
         kfqm790rrfsUon1jLX9uorsOlogb7bYx5O2EOOdhBB9pe1/afp1gp5pBAPyGenSc0ar4
         9J/CzfAbxcXfrZGKG/czzv9m1RMFeB9n7Iq/Dxs8DFFYenK2NiKNMhDf+qEPuSB057dm
         omoOnDj+JQ4L8yxBThjzMBGmSAWdkglBcbzmBU/AVZoPGxibtkcZ2F7L7KBgCDpCwEP8
         5aZX1FwnzHxBsx+juoesF3hiVfT7b+VgIRDKZ1bHfok2/7cBDK3WNQtEDSddn2KkvHHH
         3vPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709037165; x=1709641965;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r6McJiuv+h7AyXeU5mDp5gY4ceOSplSmKT9ljaBZAeI=;
        b=v2wru67z/vLUQhJSK4Wr487Wn/z3/O0kP3QzD1QynqIVIolGqOfdYhj4cl3WtIvg/q
         tDF1EahFkKWcVh/jcoeOp/F0UEPJTP+yR77Nh3aL1dqNeggBiT5/lIl7P8eW/3mPBeAJ
         vIvhIU1pMK2YI1g4Du+jnpNoXJeGXviLmcTGP38xVx7A41Jxu4aM+Rbdcn839GQifT/M
         KOuAW/4E18NNfm514y2l7oFoqdkhW3LS/x/sNguSXA8PNS/+/XbFHy2T1ta37PYtRT1H
         0TJBam9O3xwDxIEFNgZDh+irKdHe0fDGw9bxb8dB0RrFmAR2PM1wl4F3ypPobWUnAcCD
         YD9g==
X-Forwarded-Encrypted: i=1; AJvYcCVIJdYBTXrE7nKrGSeRgV1xvrM7Og6cxWbesfYbkj+aGJPGxkeFZfa9hQkdzJ5G9SXASC3IvkLT/QybPzU1M8mI5h1eC83Anrho
X-Gm-Message-State: AOJu0YxJZY44rjIf4QYRLMEmysAnhKUI9nxFhwS5lBdcbcvHddxFM2dF
	DY9voaOPrQjzXC3l8bFoo2xBFtYmLxXe9bTqMUcbydkWVupiefFBNgpsHB4W4A==
X-Google-Smtp-Source: AGHT+IEFhhrIt7Yi0/j6C6WifjMm92/qMQnfNrHB04A6+0UV4a2UVc5t/CmWxX+vY2RC+MyJMs/Upg==
X-Received: by 2002:a05:6a21:910c:b0:1a0:cce6:d526 with SMTP id tn12-20020a056a21910c00b001a0cce6d526mr2594508pzb.41.1709037164773;
        Tue, 27 Feb 2024 04:32:44 -0800 (PST)
Received: from thinkpad ([117.213.97.177])
        by smtp.gmail.com with ESMTPSA id fn11-20020a056a002fcb00b006e0737f2bafsm5775175pfb.45.2024.02.27.04.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 04:32:44 -0800 (PST)
Date: Tue, 27 Feb 2024 18:02:30 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v8 09/10] PCI: qcom-ep: Use the generic
 dw_pcie_ep_linkdown() API to handle LINK_DOWN event
Message-ID: <20240227123230.GP2587@thinkpad>
References: <20240224-pci-dbi-rework-v8-0-64c7fd0cfe64@linaro.org>
 <20240224-pci-dbi-rework-v8-9-64c7fd0cfe64@linaro.org>
 <ZdzIada1H95ike0t@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZdzIada1H95ike0t@lizhi-Precision-Tower-5810>

On Mon, Feb 26, 2024 at 12:20:41PM -0500, Frank Li wrote:
> On Sat, Feb 24, 2024 at 12:24:15PM +0530, Manivannan Sadhasivam wrote:
> > Now that the API is available, let's make use of it. It also handles the
> > reinitialization of DWC non-sticky registers in addition to sending the
> > notification to EPF drivers.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom-ep.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > index 2fb8c15e7a91..4e45bc4bca45 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > @@ -640,7 +640,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
> >  	if (FIELD_GET(PARF_INT_ALL_LINK_DOWN, status)) {
> >  		dev_dbg(dev, "Received Linkdown event\n");
> >  		pcie_ep->link_status = QCOM_PCIE_EP_LINK_DOWN;
> > -		pci_epc_linkdown(pci->ep.epc);
> > +		dw_pcie_ep_linkdown(&pci->ep);
> 
> Suppose pci_epc_linkdown() will call dw_pcie_ep_linkdown() ?
> why need direct call dw_pcie_ep_linkdown() here?
> 

I've already justified this in the commit message. Here is the excerpt:

"It also handles the reinitialization of DWC non-sticky registers in addition
to sending the notification to EPF drivers."

- Mani

-- 
மணிவண்ணன் சதாசிவம்

