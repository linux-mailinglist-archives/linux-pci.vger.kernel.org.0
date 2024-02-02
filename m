Return-Path: <linux-pci+bounces-2993-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F063846B45
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 09:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA8E31F21EF9
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 08:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F18605D3;
	Fri,  2 Feb 2024 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LDYHmxt8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E966860870
	for <linux-pci@vger.kernel.org>; Fri,  2 Feb 2024 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863908; cv=none; b=iVZTevWf2jKFM339URfAwDWd765eFRNzjFjZgpLC4bda0gCQdErKYSmlYlHYuum1431m0/4SeL3CEFZEjFb5BDql9gRCVpqnVWQtTitk5CZWjSTqUq3q96mYeBWyErqB+q7feu5Hzk8z9328h6aWX7hOfo+SWFmrKWaVK/0KO2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863908; c=relaxed/simple;
	bh=6ouAx7WumWAZr6bp6pEvbPCTMqysvVYKs5zAzB6pwmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTM7lhhkiMGczqmRA/FlUdnScyO12k3qTu4Nt6nY9p6AEFFVOCK9nTszHGL2lGqW8fj5O3wh+1/iqhLv0FV6fw+KScr8cvniFcIMTaiBl/7aB4aqdkxi6nBEsXOOS5BUZ3y7PfZ0+qcEQkDB+I+zT6+e4Miw84a7yFa6Uj3TkYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LDYHmxt8; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3510d79ae9so241074466b.0
        for <linux-pci@vger.kernel.org>; Fri, 02 Feb 2024 00:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706863903; x=1707468703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=35GTgs2Y35QmPxIciJppfgdroGdGch7dNuzJo/gOG+Q=;
        b=LDYHmxt8gtY/W2UhDuDQUNQa54E29S99CqRrk5XSaoqiTpxeE4OnjbVcxMzoMOHlSs
         /Dzp/pyOigkYZg2An/5i7D5OqAR0i6OHnoyJ2jubjk8b7hpBWrACUnmyOSjT0BR54Gpg
         QhN7tQunzGbAeGUbnNVBR4TgX+n2SceCdPuQQLx5PeNP1fusVuZzAV6ooykseNfD7o1y
         bLOChK/9QG2irAsnSJtlzVqnDnrEgT6Kc4FEO7E+6p9+KJYqXzObS5cx+dNHQoMX4s9q
         88GAh1bzHrARmtKChUALHuPHJkOAnYMNoLUa/+IqVd0a9IpA9xd/dalmXDQXunmCPngx
         jeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706863903; x=1707468703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35GTgs2Y35QmPxIciJppfgdroGdGch7dNuzJo/gOG+Q=;
        b=ZpH/oes/3rgkJKA7PIk38QVb0mWSf13JRhe4kuqd6vHA1TpmmWkb96RsWhZNu8nuzB
         zSu07ZD3YhWMw6TMlPh5B5TkXeNBK35TlU5tQh40O+ueI6i0EpxS/3Fk9busw61oNkN7
         gWPs0KCcz0eFKx5ZMdFtxcBhLX9uTnA+kS8SttyUBDFakiwcJarxYaRTHW2MdsazvO2e
         LkyeTBTOdzdJRIi5fKqIcPDfqnW/QwuzBms0VkjkQulHOH9opx22rONFzATKNuZExjD3
         xXSXZgC4xftucrJtkJ9A3EySK6h5hn6MCy4JEyJLvAyw/epEFj+E7tPF3gBzzsAWabWF
         qUJQ==
X-Gm-Message-State: AOJu0YyeFjR7F6FNH0seUqG3C2MbbkBgXgASgimfh+KOPYMLOnwVAHoC
	3kSwQtcADW1fQaLseBFYfD4hjGhcNKTmYksgeW8lXMfi9PpBcKdFPbq8yZ+hrXY=
X-Google-Smtp-Source: AGHT+IG+HYlwqvjprhVjfBvzNxUoZZ0s/mxs17IQgwnpS1WRvY14ACcG89LqObqzuLHhlL8c4++WOg==
X-Received: by 2002:a17:906:e48:b0:a35:7b14:dc50 with SMTP id q8-20020a1709060e4800b00a357b14dc50mr4963572eji.17.1706863903099;
        Fri, 02 Feb 2024 00:51:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWkNFyc47xmaQn6AvATqFFtH7zi/Gjq5bW9iGeDp+mjqEkj548XM7NuVtwOlGRbx1SjQod1sWD0XPkcr7mZI4zMyfT03gP/Q9llUiDL+rP2kFCUxyfTZI5647d8v1jVDaI89KJEBslD3a/91FpngPF0ANtu+kbpm+Qp85n7EktIvG4iak7VEBFWJp++q13KnVxwgkcUPSjXshOI7vHO8as9T2TyGOrwzJfnnVFtChoDb049tP4tYHJ6uxePnW1r9uzkr962bfXSbIcb6I/l4WmcUm5lkJPIciHv5QHsGVjYfa0kIS/pRFoPgHcF6ZCe+Eb3ltNn6u1qVFz45GMeOEu5IWAFu62OuF+1
Received: from linaro.org ([62.231.97.49])
        by smtp.gmail.com with ESMTPSA id un1-20020a170907cb8100b00a35cd148c7esm653476ejc.212.2024.02.02.00.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 00:51:42 -0800 (PST)
Date: Fri, 2 Feb 2024 10:51:41 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: neil.armstrong@linaro.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: qcom: Add X1E80100 PCIe support
Message-ID: <ZbytHYA+bPYa9KtR@linaro.org>
References: <20240129-x1e80100-pci-v2-0-a466d10685b6@linaro.org>
 <20240129-x1e80100-pci-v2-2-a466d10685b6@linaro.org>
 <30360d96-4513-40c4-9646-e3ae09121fa7@linaro.org>
 <Zbyqn5wnH7yCe38P@linaro.org>
 <0becd323-6104-4c61-80ce-935c55f9a66f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0becd323-6104-4c61-80ce-935c55f9a66f@linaro.org>

On 24-02-02 09:44:23, neil.armstrong@linaro.org wrote:
> On 02/02/2024 09:41, Abel Vesa wrote:
> > On 24-02-01 20:20:40, Konrad Dybcio wrote:
> > > On 29.01.2024 12:10, Abel Vesa wrote:
> > > > Add the compatible and the driver data for X1E80100.
> > > > 
> > > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > > ---
> > > >   drivers/pci/controller/dwc/pcie-qcom.c | 1 +
> > > >   1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > index 10f2d0bb86be..2a6000e457bc 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > @@ -1642,6 +1642,7 @@ static const struct of_device_id qcom_pcie_match[] = {
> > > >   	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
> > > >   	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
> > > >   	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
> > > > +	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_1_9_0 },
> > > 
> > > I swear I'm not delaying everything related to x1 on purpose..
> > > 
> > 
> > No worries.
> > 
> > > But..
> > > 
> > > Would a "qcom,pcie-v1.9.0" generic match string be a good idea?
> > 
> > Sure. So that means this would be fallback compatible for all the following platforms:
> > 
> > - sa8540p
> > - sa8775p
> > - sc7280
> > - sc8180x
> > - sc8280xp
> > - sdx55
> > - sm8150
> > - sm8250
> > - sm8350
> > - sm8450-pcie0
> > - sm8450-pcie1
> > - sm8550
> > - x1e80100
> > 
> > Will prepare a patchset.
> 
> Honestly I don't know from where comes the 1_9_0 here, I didn't find a match... none of the IP version matches.
> 
> So I consider this "1_9_0" is a software implementation, not a proper IP version so I'm against using this.

This is the core version starting with SM8250. All the other ones are
compatible with it, from configuration point of view.

> 
> But, using close cousins as fallback that are known to share 99% of IP design is ok to me, this is why I used the sm8550 as fallback because the IP *behaves* like the one in sm8550.
> 
> Neil
> 
> > 
> > > 
> > > Konrad
> > 
> 

