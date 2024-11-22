Return-Path: <linux-pci+bounces-17215-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D289E9D6283
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 17:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 089201608CF
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 16:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB9C1DF969;
	Fri, 22 Nov 2024 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N7sxXxm2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1F460890
	for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2024 16:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732294043; cv=none; b=Ip/5gDDOH9e8ThIhtdtkAm1vqJQZSOg+IKerdxbJ/r792tG00AMF+XTo1Qn7UsuEGrpO/ctrubGk6U1CaupzANm/C1h5ZS5nhQRy8VFuKvwyI+syrHWtlTnNQo7L/VDowNUEgtOMAZFvRIUwjWN7ZC0nzsmaQAjFQPPNCKMwnBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732294043; c=relaxed/simple;
	bh=ItNTKavT00h+piga1HTfcObBvAtBiGxqCrbjRJ1Tavc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8NnShmVeKGW8YZsei99yMzNsMekL6pG9nbcBEbCt4HzCHrx+jN9w5AttA52xf/fYraUFAHXnl9vQlzNK/HKpiQFwqjV2oOZ6nfLCzGDff/nznxHwqMu1G/Qcs7JsaswfDUN3UUybGUXK8y0yTRPM5QcMuE3LYPu3xXrkinu9Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N7sxXxm2; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2120f9ec28eso18816605ad.1
        for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2024 08:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732294040; x=1732898840; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kzq5xBGhrLm4GuYMaG3vOjkgbW2jTLhEik+B/AfpKr0=;
        b=N7sxXxm28qpSXdKXM1+JiWGvFRcSNDETzc91Xq/qDHCDzGC+Q7wjdupj7fQnIRqf7z
         qOd1jUlf2NO/MXy3qRwmHqEjJUVksk9IuTtuNdVwvareJuu41Oot2YKDmqaZb5wMiPJZ
         d9Cw/Z3hSFZ2KEtSRk4A0H+aNVDgDVzPs5nnGauQD5KeStHBiJNRvDTK+AlaoyyPcL2T
         g2uskKblMTx4NkQ+KozZqPC/aspdSRiC0Wzr9YMwGvJz1aGM2/sZvffUMukkkx6Trg7u
         ONTSqxQ9394/HY6LpZzlhR/8uljXKZrtZ0IEOFDZZakqTukL1ZaHU/0Kaze+SjCgPjGg
         OOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732294040; x=1732898840;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kzq5xBGhrLm4GuYMaG3vOjkgbW2jTLhEik+B/AfpKr0=;
        b=XJTO06UkrxZjG+5Zpl7aRWs43u1IMdZw6vG3+7J82g96ABz4kYv/SHJXRjLTe55OJ6
         LIOpw++PLQ4g7VY74GUMtQ67a40QHbPQfwDwGd+cnfRNPF/0tQUav93qtde5n5e6xKIb
         bkhroKKvMQi6yJmEGLH2bLaCMIsEQVKQzNMNDM/MumJXCBtu7w6pz2GCH/VWCdw5uUqT
         QFiUXw6uL2LmLlI0ont3HXz/kFSdHFeFT2a7NO7CZP0TDK0XvqpTWjfshq9F3z2st4pz
         HQzSV9wGCtcmMF/hYY4p1Ggm9P2HBHWoiVU5dKC7+hkAEzGJcW5EXx0t0ljeQj9ubs6g
         iXCA==
X-Forwarded-Encrypted: i=1; AJvYcCW2qllXGujLUt2TKNOhzuoKOqk07nc/BYvTooZ+JCrJBHbYaqxae3dxDz2SD7umwuj2TQMa/svBSBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwontuUHznZgDPvExTWF7eLL1DgQrF6+wViAf9E2QZjD6urwAp4
	beTNUnuLVV3CMk+3bLRiGux8hqJHeLwmut3rBdvwC5oAAPe43QohXaYsCTWFIQ==
X-Gm-Gg: ASbGncssF/lt9XOHKrGkyrJMZJ+nsige7qjKd9UXV7BO8V4+0mIFx8eZlLmFdmkG3M2
	WpB8HFS6yx8g5IHd0QQ5lP0ZHILWZ+UNRP9g4IyZ+zBc0Tr92f5bEJDwlf9iHpIw3/xF1dwOXaf
	14o4SubhWAx3pXpy4u2KdJYrtJQ90vz8rEjf0mrpFHUKpnEOFxaNFbi1NpS+4EyhLK61+orcH7M
	p5WsTputRVMGLM+y5f+6hViMwSRW0WJgjoTkrwhapgebqUJ1nZtUm7rJqs+
X-Google-Smtp-Source: AGHT+IH2RH2HUiPHMzLk35ACiz5SeB6Uib1iKjXQGa54thdOMDLFrThNUfglBoU0p2O84vxcD04wlg==
X-Received: by 2002:a17:902:f70d:b0:212:35f5:b564 with SMTP id d9443c01a7336-2129fe2669emr56816865ad.7.1732294040271;
        Fri, 22 Nov 2024 08:47:20 -0800 (PST)
Received: from thinkpad ([49.207.202.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba357bsm18336365ad.88.2024.11.22.08.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 08:47:19 -0800 (PST)
Date: Fri, 22 Nov 2024 22:17:14 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	Frank Li <frank.li@nxp.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 08/10] PCI: imx6: Use dwc common suspend resume method
Message-ID: <20241122164714.aj4dzv32zixdj7pq@thinkpad>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
 <20241101070610.1267391-9-hongxing.zhu@nxp.com>
 <20241115070932.vt4cqshyjtks2hq4@thinkpad>
 <AS8PR04MB867625A97A43FE5352FC0E768C272@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB867625A97A43FE5352FC0E768C272@AS8PR04MB8676.eurprd04.prod.outlook.com>

On Mon, Nov 18, 2024 at 03:00:44AM +0000, Hongxing Zhu wrote:

[...]

> > > -static void imx_pcie_pm_turnoff(struct imx_pcie *imx_pcie) -{
> > > -	struct device *dev = imx_pcie->pci->dev;
> > > -
> > > -	/* Some variants have a turnoff reset in DT */
> > > -	if (imx_pcie->turnoff_reset) {
> > > -		reset_control_assert(imx_pcie->turnoff_reset);
> > > -		reset_control_deassert(imx_pcie->turnoff_reset);
> > 
> > Where these are handled in imx_pcie_pme_turn_off()? If you removed them
> > intentionally for a reason, it should be mentioned in commit message.
> > 
> How about add the following descriptions into commit message?
> SRC interface is used to do the PME_TURN_OFF operations before. It's not very

What is SRC?

>  suitable. Now DWC common driver can do the PME_TURN_OFF kick off. Switch to
>  this common methods, and remove the useless turnoff_reset manipulate codes.
> 

Hmm, so 'turnoff_reset' is used to send PME_Turn_Off msg?

If so, then you need to say in such a way that the reader should understand
'turnoff_reset' was used to send PME_Turn_Off and since the DWC implementation
is used, it is not needed now.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

