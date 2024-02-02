Return-Path: <linux-pci+bounces-2987-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C37A846AE6
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 09:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5836B28B9A7
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 08:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63365FDAC;
	Fri,  2 Feb 2024 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mcibuihy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0823405F8
	for <linux-pci@vger.kernel.org>; Fri,  2 Feb 2024 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863268; cv=none; b=amGwxBLhPTTTpr7241DmCUf2NKYyAUU3Y+CRjw3X4ZEzjCH5g2zQWAELLtW8ypo2xk/HPbGog6vNSj2YWsE7/Cwh+qfSJ+DlsLpDmu0TjpUPYtEJSAOJYCo90Aw8NNUguVfdDjd4hNpd5XXIz+JuZjaQ7J6Z8AhE09hP4ZoWYOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863268; c=relaxed/simple;
	bh=3Z8P50PkuZaBvlmx/OaFJ91y4sTuVBubXMK9RVN1S5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSN9xX/2qJpoC8QqSS8qAvKLfudzhC3zriVmD5mVVsJKg3to8bv0FReTX9zJkbP6gicujjRs5YL5sN45c845xxkf2mhb1AKR9Zt3M1/lo2R8+1GhX3Lu/QgskUn4rzTDfOoJ0jUfq/XqH4ORbEvRjSroREorRgio0XXAWFBlCFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mcibuihy; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55fc8f91b79so1642100a12.3
        for <linux-pci@vger.kernel.org>; Fri, 02 Feb 2024 00:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706863265; x=1707468065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iHKQ78QQnBXdM5NexBaC3kdL6BR/8TDhZh5GGSia/Og=;
        b=McibuihyT9qffX25GRD7qaL3Y0IssmZmQPEkHE8OBvdjn00+Phc/J4Ox4KUqUflfB7
         ELwjlQ2uVFi7V6VSz7ZcDW41Yiogfdh2r+bQFKQtfTVwvGMgoPSJmrx7uDCkSIWQpi5B
         1WG5dqzfcVRNmmhfoEo1Hr3C8Eb7dv2jmvhJkc80SxPAImSkcoxoiwS7gOVKe0HfMQWd
         2fFzTkg5ReFDgN2ggaxfmlznqWWULZqfEoedzy1hwRfBXz3hhVNTxHwup0nkZWQJuR0j
         uTD2uc0+s367v8s/HHNCjvs8+zyg3ivait08n7i7RzUUx6nK81kbHzHlEvA4D6qlTgMZ
         b1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706863265; x=1707468065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHKQ78QQnBXdM5NexBaC3kdL6BR/8TDhZh5GGSia/Og=;
        b=QVQADTOjEDZppdEgzf6Cyq5rTK1WRHWv9qNjz5PPmzB59z6h/oO6wczVtoXafjlQFR
         RaKxL4yddxbx8H6E8MqBJI+27rOqyaJGHfCRCoJcJ21FQBvevmvjtKCjdEdmi+mnW65Z
         N42jarRHnCYX+u6Ffb102jIdwwlACTLHNEUmkDSH5q/adPuvY6vdV8B0XYvKdcOjygM0
         N1jmRG9P9EftqnOXESKgv2/CFIL/uauxn/QsuQxEDluANLGBK1ILvVTQt5zKs5zbu+hb
         pgQoppN2F4QPWKlfndud5XInZZKrx9e18wuR/nWGYj2W7HZ9vDy66p5KmcGJ2h5aKvIg
         oEhQ==
X-Gm-Message-State: AOJu0Yw2nx8Zen5iFf8q5ia+DLoR5Sud4Z+hOvY3Agn/MLv72wC7nH+a
	ezmk94gQ55iYF0mpY6PxRzEZp8Db2meuHhjhRTywKX+HLlBv8J1enJEqsgIm47U=
X-Google-Smtp-Source: AGHT+IFXv6FpkgRZmzFJL73lQAobzYsR9jGj4JMmLneCg8xqu1F6BLb6os2emk9seK1kuVKzL+eUAw==
X-Received: by 2002:a05:6402:1343:b0:55f:a7d6:fd61 with SMTP id y3-20020a056402134300b0055fa7d6fd61mr686448edw.26.1706863265064;
        Fri, 02 Feb 2024 00:41:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUqzK2jUUQeWimymreX14ZMUZ6d5k2goenvNKKFTdvP8lmDsI9dk9UHeIrrX7JYJ6BAttbfPBdoMHJJegVfGSu7rY1/wejxPS+GHtMenZxnqIoCE5QGvePGD9HPAKFe8ubwq3+JJDxNrPs6Rkz1YM9uFzXBUyDJmRTZBe+RifdOKyBFub5FcGUZJ7LEWIwkooaD2rCniMSdDmXHw8n6y2xfd0KH6pmj/yXIHNs2SbXCoYhb/ExV0cl9XI+sXo7W3ZQk9lnnDM5kpdiYnN0nb5V5wQ+yu1uO6R7vKvT5COTrZ8R9J2mxZZ3IsBFWIgtOj7ARu/4=
Received: from linaro.org ([62.231.97.49])
        by smtp.gmail.com with ESMTPSA id em7-20020a056402364700b0055fff31ee27sm113934edb.43.2024.02.02.00.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 00:41:04 -0800 (PST)
Date: Fri, 2 Feb 2024 10:41:03 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: qcom: Add X1E80100 PCIe support
Message-ID: <Zbyqn5wnH7yCe38P@linaro.org>
References: <20240129-x1e80100-pci-v2-0-a466d10685b6@linaro.org>
 <20240129-x1e80100-pci-v2-2-a466d10685b6@linaro.org>
 <30360d96-4513-40c4-9646-e3ae09121fa7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30360d96-4513-40c4-9646-e3ae09121fa7@linaro.org>

On 24-02-01 20:20:40, Konrad Dybcio wrote:
> On 29.01.2024 12:10, Abel Vesa wrote:
> > Add the compatible and the driver data for X1E80100.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 10f2d0bb86be..2a6000e457bc 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -1642,6 +1642,7 @@ static const struct of_device_id qcom_pcie_match[] = {
> >  	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
> >  	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
> >  	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
> > +	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_1_9_0 },
> 
> I swear I'm not delaying everything related to x1 on purpose..
> 

No worries.

> But..
> 
> Would a "qcom,pcie-v1.9.0" generic match string be a good idea?

Sure. So that means this would be fallback compatible for all the following platforms:

- sa8540p
- sa8775p
- sc7280
- sc8180x
- sc8280xp
- sdx55
- sm8150
- sm8250
- sm8350
- sm8450-pcie0
- sm8450-pcie1
- sm8550
- x1e80100

Will prepare a patchset.

> 
> Konrad

