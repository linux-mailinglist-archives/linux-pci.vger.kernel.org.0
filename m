Return-Path: <linux-pci+bounces-25732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08062A87264
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 17:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2005E1894A01
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 15:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA281C9DE5;
	Sun, 13 Apr 2025 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WhXeE9tf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4637A1A4F3C
	for <linux-pci@vger.kernel.org>; Sun, 13 Apr 2025 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744558734; cv=none; b=cDyCSUl8S1NkOD3orw/f3iFEF+z2HTCxJ07RXyQG2N5n3pbdf3d/bMd/SLWS9kPYs1zGBb5Ptuswmzz+yjlE/LMDQ7RuZGxY5r9WbLIoNGFzQjcP/CHwhpFIp03yKraAWmjxXqbOJfKiFKyC0XJRsQYEQkYcd8W2+QRgSoex0qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744558734; c=relaxed/simple;
	bh=NEFQkTV6HWbWySDV1gYFlTQgKHF1fM8Q2eL5vnHMCvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJ2bKzTNHxxLR6YaxY87KVPX2gnvVoM/XHXxkjma4s6pm5Wf4nNWapJrk0MxPnTLhbwtPU+fUghCCbSM5HFcj2bLqL5tyAChOnx4rJYxtNhWUwkBAUwpvrZhXfoSUnTc5J8TwVII4blsA2ZyxAntH8FJBEkVft68lbwB31wcBx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WhXeE9tf; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-224019ad9edso45592985ad.1
        for <linux-pci@vger.kernel.org>; Sun, 13 Apr 2025 08:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744558732; x=1745163532; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wJxSIAZXO2C4Zhd9fy6/iiyMv7oQ8uqx9BwDDb/UO4o=;
        b=WhXeE9tfVoerLXom90RKhk9qwZ3H10lRioe+LK0ZcQDxmsFmuqjVk4kGAzG5wO+JOa
         ImSH9rw3O96di0PaXQtkbipzowvPqv/FlM7DVxWLWaCiwKWw4EHOMI15y1SJ+OMACmop
         fUwqO0vkq4xEOktGCdAijsWcsY3OamzUl7pTf8NehX2z4f2ak6hnGysCGQzLF0dL8zqr
         r/Qp6ueFuY7dB1nlf1sRutPeSOYplgDfoWpoQp8hc5KDSYVcRhRxcOpCfdLSaf6R21N5
         riOeGZtFwTMPzrkPoADwI07PbLzWSKRXT99Fm/PZcP8j53sUIPRdoWl4FiVyIjRjKlFh
         l3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744558732; x=1745163532;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wJxSIAZXO2C4Zhd9fy6/iiyMv7oQ8uqx9BwDDb/UO4o=;
        b=d0tqQGE+xDCMtOP8/NuwARiYK0K7Co/+ucd1wwfSUKl0MsAKMhWLh4YaW3ZdcfDuDD
         2EUzheRJhs5TvFTTyXy2gVQo2P+fFEYZ76L3cMHFh4gtqVk1wWi7m4/Ht9s9I2YcD9dX
         bFPvf2QF+pmV9mFj3LlI+UUSRm+casvECYxXIsvrWs0ZKCnWh6VclV11TPcdlm3g4MVX
         FWQUgLgtUe8z0GEWz98EThD69VcwqbcC3+Lc5BaFJwFYNoSs2CCz44ddfBE9GqhuvBOY
         K6xPnO0RSrB64qc2dCGifjNc1I6S4KgjmQQr48sbEyNPBk8I8psqZPFWHH+CjmJERfFa
         jWhA==
X-Forwarded-Encrypted: i=1; AJvYcCWY6bxPk4HSQ4HuJxaed43sKlKE9KS2iehBzklg9BdReGUgaxJ9pHRRI2J1tyJlOVeTMVBOtA1irOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJaEsTMAxUzH549/TfBvlpGtTJaLU91xTdWKrPE52ShoAiUJMz
	bBi1ou9f9uuiFB2ZFJ/xPPfINeAfZYmtU0OHhkJfwJD6kejy5xNJW+bPTqnpJQ==
X-Gm-Gg: ASbGnctHjfM9qBop1UstfdWOnmsbxPD/Lkjif3N2TOcI0Xk8RjaPaKSr1nooQkK+H5s
	ZuP2TDIpRM+cpc+rXDD0F5q1PnWcgezm+IICm9bnowtG+oQXnb2gcgSo6ipJcZ+4L9oA2OxvIpj
	Ht2hJYckCK8wG/dGOptVkb6A/R9f52JvueDw9Le7T/CO7kGjxVaXND4BhSPl8KVyTPApRWOk3L7
	PMHa1G17QZXPDdeZ+3sFJiXIKZ5tEad9yCYdpxGKgbw1k9L9t9UABgbjfPiyzrM5DTN8UaldNHL
	I1V0gDBSzq7ZRGMKAWDcR8dCM8hMw0DOlnutf71XeY14yubtvy3s
X-Google-Smtp-Source: AGHT+IF144jyIPz4NUFnuSSDcuxFolD9nML5zcTpAccGjMR/wBPaVGXigppgwKhzhmzy2ywG7rsfww==
X-Received: by 2002:a17:903:1905:b0:223:65a9:ab86 with SMTP id d9443c01a7336-22bea4aab88mr160177565ad.12.1744558732319;
        Sun, 13 Apr 2025 08:38:52 -0700 (PDT)
Received: from thinkpad ([120.60.137.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306df09071fsm9507767a91.25.2025.04.13.08.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 08:38:51 -0700 (PDT)
Date: Sun, 13 Apr 2025 21:08:45 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Frank Li <frank.li@nxp.com>, 
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, 
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	"festevam@gmail.com" <festevam@gmail.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/6] PCI: imx6: Workaround i.MX95 PCIe may not exit
 L23 ready
Message-ID: <h7pja24zffl4t7653rjaamp6v2j5nmukbzq7rdajynemlyb6l6@3e37ggkparjg>
References: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
 <20250328030213.1650990-4-hongxing.zhu@nxp.com>
 <ovaomfvo7b3uxoss3tzhrkgdy6cvxi4kr2zxmqsfjxds5qfohl@t6kc4rswq6gp>
 <AS8PR04MB8676687332C78840B927E7568CAF2@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <rqgl5jjauppyudgmugp34fillkeli3qkwf4uf2djghi6nslebg@pyi6rbwyduxd>
 <AS8PR04MB8676BB3EDFCF3E5A490AC0628CAE2@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <AS8PR04MB8676C5D0DB84975D34C4C65A8CB52@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <4qrfkx3ckywcbk7qbjplal5j7v6sjs3zebeehe5dnrgjz2ej2t@krdwjb4xm2sx>
 <AS8PR04MB8676221C998474EF5A9B94288CB72@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8676221C998474EF5A9B94288CB72@AS8PR04MB8676.eurprd04.prod.outlook.com>

On Thu, Apr 10, 2025 at 02:45:51AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Sent: 2025年4月10日 0:44
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de; lpieralisi@kernel.org;
> > kw@linux.com; robh@kernel.org; bhelgaas@google.com;
> > shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> > festevam@gmail.com; linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; imx@lists.linux.dev;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v3 3/6] PCI: imx6: Workaround i.MX95 PCIe may not exit L23
> > ready
> > 
> > On Tue, Apr 08, 2025 at 03:02:42AM +0000, Hongxing Zhu wrote:
> > > > -----Original Message-----
> > > > From: Hongxing Zhu
> > > > Sent: 2025年4月3日 11:23
> > > > To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > Cc: Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de;
> > > > lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> > > > bhelgaas@google.com; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > > > kernel@pengutronix.de; festevam@gmail.com;
> > > > linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > > > imx@lists.linux.dev; linux-kernel@vger.kernel.org
> > > > Subject: RE: [PATCH v3 3/6] PCI: imx6: Workaround i.MX95 PCIe may
> > > > not exit
> > > > L23 ready
> > > >
> > > > > -----Original Message-----
> > > > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > Sent: 2025年4月2日 23:18
> > > > > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > > > > Cc: Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de;
> > > > > lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> > > > > bhelgaas@google.com; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > > > > kernel@pengutronix.de; festevam@gmail.com;
> > > > > linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > > > > imx@lists.linux.dev; linux-kernel@vger.kernel.org
> > > > > Subject: Re: [PATCH v3 3/6] PCI: imx6: Workaround i.MX95 PCIe may
> > > > > not exit L23 ready
> > > > >
> > > > > On Wed, Apr 02, 2025 at 07:59:26AM +0000, Hongxing Zhu wrote:
> > > > > > > -----Original Message-----
> > > > > > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > > > Sent: 2025年4月2日 15:08
> > > > > > > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > > > > > > Cc: Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de;
> > > > > > > lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> > > > > > > bhelgaas@google.com; shawnguo@kernel.org;
> > > > > > > s.hauer@pengutronix.de; kernel@pengutronix.de;
> > > > > > > festevam@gmail.com; linux-pci@vger.kernel.org;
> > > > > > > linux-arm-kernel@lists.infradead.org;
> > > > > > > imx@lists.linux.dev; linux-kernel@vger.kernel.org
> > > > > > > Subject: Re: [PATCH v3 3/6] PCI: imx6: Workaround i.MX95 PCIe
> > > > > > > may not exit L23 ready
> > > > > > >
> > > > > > > On Fri, Mar 28, 2025 at 11:02:10AM +0800, Richard Zhu wrote:
> > > > > > > > ERR051624: The Controller Without Vaux Cannot Exit L23 Ready
> > > > > > > > Through Beacon or PERST# De-assertion
> > > > > > >
> > > > > > > Is it possible to share the link to the erratum?
> > > > > > >
> > > > > > Sorry, the erratum document isn't ready to be published yet.
> > > > > > > >
> > > > > > > > When the auxiliary power is not available, the controller
> > > > > > > > cannot exit from
> > > > > > > > L23 Ready with beacon or PERST# de-assertion when main power
> > > > > > > > is not removed.
> > > > > > > >
> > > > > > >
> > > > > > > I don't understand how the presence of Vaux affects the controller.
> > > > > > > Same goes for PERST# deassertion. How does that relate to
> > > > > > > Vaux? Is this erratum for a specific endpoint behavior?
> > > > > > IMHO I don't know the exact details of the power supplies in this IP
> > design.
> > > > > > Refer to my guess , maybe the beacon detect or wake-up logic in
> > > > > > designs is  relied on the status of SYS_AUX_PWR_DET signals in this
> > case.
> > > > >
> > > > > Can you please try to get more details? I couldn't understand the errata.
> > > > >
> > > > Sure. Will contact designer and try to get more details.
> > > Hi Mani:
> > > Get some information from designs, the internal design logic is relied
> > > on the  status of SYS_AUX_PWR_DET signal to handle the low power stuff.
> > > So, the SYS_AUX_PWR_DET is required to be 1b'1 in the SW workaround.
> > >
> > 
> > Ok. So due to the errata, when the link enters L23 Ready state, it cannot
> > transition to L3 when Vaux is not available. And the workaround requires setting
> > SYS_AUX_PWR_DET bit?
> > 
> Refer to the description of this errata, it just mentions the exist from
>  L23 Ready state.

Exiting from L23 Ready == entering L2/L3. And since you mentioned that Vaux is
not available, it is definitely entering L3.

> Yes, the workaround requires setting SYS_AUX_PWR_DET bit to 1b'1.
> 
> > IIUC, the issue here is that the controller is not able to detect the presence of
> > Vaux in the L23 Ready state. So it relies on the SYS_AUX_PWR_DET bit. But even
> > in that case, how would you support the endpoint *with* Vaux?
> > 
> This errata is only applied for i.MX95 dual PCIe mode controller.
> The Vaux is not present for i.MX95 PCIe EP mode either.
> 

First of all, does the controller really know whether Vaux is supplied to the
endpoint or not? AFAIK, it is up to the board designers to route Vaux and only
endpoint should care about it.

I still feel that this specific erratum is for fixing the issue with some
endpoints where Vaux is not supplied and the link doesn't exit L23 Ready. Again,
what would be the behavior if Vaux is supplied to the endpoint? You cannot just
say that the controller doesn't support Vaux, which is not a valid statement
IMO.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

