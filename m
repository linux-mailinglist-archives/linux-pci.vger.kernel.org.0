Return-Path: <linux-pci+bounces-6506-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CEF8AC4E6
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 09:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B5E2815C8
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 07:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965F34B5A6;
	Mon, 22 Apr 2024 07:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iGojFyue"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF044E1DD
	for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2024 07:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713769926; cv=none; b=kaKUlYQWA4e39mLDQKEHJ+60iIPnQlEgen+tYahPmileJpcQTVfMFZOGtDc9qfJiF58cwawO4DliEkdL3ApqzACvTMw8G403bejM+v4WPLT2LrtbixrpxisbLUvmbpq1f35kH9SBs7oVIwn7qgYc/5xmqfZON3WSOIZ+1QFr/+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713769926; c=relaxed/simple;
	bh=uPH6Y67fwbijcJ63Bx9ZgEyKOxdB9i7MlDXsKbFIr70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZc61VA9YcCeVsMriHzEGcgq5Um/oOIBfQjUklfziiPRmiPqXj0LkA72r+wCvchZHa8wiQd/QubRBZnYWbJnC4p73u/EIMDugBJZCODkj+zQB7VfqFWyB9R84rxfnfLHNMwtnihwGNUBE8AgYJRwEYnY7K6f37nHTiYFzxTRmSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iGojFyue; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-22f01274622so1991667fac.1
        for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2024 00:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713769924; x=1714374724; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4Cg+LkkJAMIn0twUnN3DDfZ/IhwvjeNrn5o075GoKwo=;
        b=iGojFyueUeaKUwnFwkF3iz+55T6H2EJ1Zq3N967psrLO+xUoi3J769DSbN+8siT2eM
         qr18WcnOnqmdUUfx4yvh8hW6fLjKmoyO/RiosIkQsdGTDa2Di1rtah+Yjwzq7zUDdeVF
         fN/49XzJzr3co0eLp+l52s3Y+0I4rq8ckqNSFOn7M8M2+Ad/ImWnOUowGoLzLeRdrhV9
         siu+HDe+lpEonH+j0chy8zhREYqHZbHLSMBBoCvW6RZeQGg2zpdJX0YjXlUkxTQVUdAI
         U/OjTtXyk12zR7j50H2NnKWw/nK8mdH7b5dVyy4A1b7iM2YTMCaBgKzDZFEb5/nG6dA1
         kuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713769924; x=1714374724;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Cg+LkkJAMIn0twUnN3DDfZ/IhwvjeNrn5o075GoKwo=;
        b=dPw8fhFKGHZqm2LmcHKHaZh2FWgQgZBrFuyxiOxUir9JgUjKnmognW0OEgTxMyn+wn
         0yGEXfZ55F9wzT+Bc4HxyLhZy56GUdH3i+Fuj7LxPKE8LmeDNQK+DqfKOLzlWwn1IggG
         oQFGWhfIELvIAssO3zyLXJVZ9h+zOotsD9rMwaiVs6IUjyo93kuVhUvqPFdxVTX86rj+
         IimIS0Dj3tl22HeEXv8B6sYnnJiNYKS24qGLDFOn9C6BbAJDAQyjmY/mCkqLAOqw1F9i
         C/e4Jv0I0DhYP9jVJyQT27uN4Y6Of5Pe/u7dwPdmzQ1bDYwfjAEKD9xvLouLzShdPivf
         Jnzw==
X-Forwarded-Encrypted: i=1; AJvYcCXBjnS6bW1ggO1D8uKqLC2BtSDx4bQ8jEXuudbK21/sXK5RSt38IwmHybXMK9Cyk6B9447ZcXYnigBvFXIUwu+/r16BNpTUCucl
X-Gm-Message-State: AOJu0Yxr/19YEBNNrfVyske9F3v1HC6jOO1wvqLF/WmRgELLTU0UNF6L
	BlwhJdC07YZeMZZEy/YA5VzMMbo2uzWdhnBFFRnCEZAJBQKYKLC4xMpaIX1XjQ==
X-Google-Smtp-Source: AGHT+IGsAnvtXsNNVTtGLGsnDwgTZNcM5E8iRPZJhaMeCx1yHucYJ64i8pt6jXG7TTPYe25ap1BMcw==
X-Received: by 2002:a05:6870:82a6:b0:22a:4c05:2efd with SMTP id q38-20020a05687082a600b0022a4c052efdmr11720065oae.10.1713769923903;
        Mon, 22 Apr 2024 00:12:03 -0700 (PDT)
Received: from thinkpad ([120.60.70.118])
        by smtp.gmail.com with ESMTPSA id fe8-20020a056a002f0800b006ed00ea504asm7189292pfb.159.2024.04.22.00.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 00:12:03 -0700 (PDT)
Date: Mon, 22 Apr 2024 12:41:56 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: mr.nuke.me@gmail.com
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 4/7] PCI: qcom: Add support for IPQ9574
Message-ID: <20240422071156.GB9522@thinkpad>
References: <20240415182052.374494-1-mr.nuke.me@gmail.com>
 <20240415182052.374494-5-mr.nuke.me@gmail.com>
 <CAA8EJpqKWJBqDUacE0xTLzxny32ZTStiRgXsd2LBD=Hou_CRBw@mail.gmail.com>
 <3cfc26e6-5587-d4a2-f217-1a30169ad1a0@gmail.com>
 <20240417070616.GB3894@thinkpad>
 <102f209c-3367-86ac-c583-73103d5510a9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <102f209c-3367-86ac-c583-73103d5510a9@gmail.com>

On Fri, Apr 19, 2024 at 02:44:36PM -0500, mr.nuke.me@gmail.com wrote:
> Hi Mani.
> 
> On 4/17/24 02:06, Manivannan Sadhasivam wrote:
> > On Mon, Apr 15, 2024 at 03:07:02PM -0500, mr.nuke.me@gmail.com wrote:
> > > 
> > > 
> > > On 4/15/24 15:04, Dmitry Baryshkov wrote:
> > > > On Mon, 15 Apr 2024 at 21:22, Alexandru Gagniuc <mr.nuke.me@gmail.com> wrote:
> > > > > 
> > > > > Add support for the PCIe on IPQ9574. The main difference from ipq6018
> > > > > is that the "iface" clock is not necessarry. Add a special case in
> > > > > qcom_pcie_get_resources_2_9_0() to handle this.
> > > > > 
> > > > > Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> > > > > ---
> > > > >    drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++----
> > > > >    1 file changed, 9 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > index 14772edcf0d3..10560d6d6336 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > @@ -1101,15 +1101,19 @@ static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
> > > > >           struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
> > > > >           struct dw_pcie *pci = pcie->pci;
> > > > >           struct device *dev = pci->dev;
> > > > > -       int ret;
> > > > > +       int ret, num_clks = ARRAY_SIZE(res->clks) - 1;
> > > > > 
> > > > > -       res->clks[0].id = "iface";
> > > > > +       res->clks[0].id = "rchng";
> > > > >           res->clks[1].id = "axi_m";
> > > > >           res->clks[2].id = "axi_s";
> > > > >           res->clks[3].id = "axi_bridge";
> > > > > -       res->clks[4].id = "rchng";
> > > > > 
> > > > > -       ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
> > > > > +       if (!of_device_is_compatible(dev->of_node, "qcom,pcie-ipq9574")) {
> > > > > +               res->clks[4].id = "iface";
> > > > > +               num_clks++;
> > > > > +       }
> > > > > +
> > > > > +       ret = devm_clk_bulk_get(dev, num_clks, res->clks);
> > > > 
> > > > Just use devm_clk_bulk_get_optional() here.
> > > 
> > > Thank you! I wasn't sure if this was the correct solution here. I will get
> > > this updated in v4.
> > > 
> > 
> > Please rebase on top of [1] and mention the dependency in cover letter.
> 
> I am very hesitant to depend on another patch series. Is it okay if I
> include your patch in v4 of this series?
> 

Feel free to.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

