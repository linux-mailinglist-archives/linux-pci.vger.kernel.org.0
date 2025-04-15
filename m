Return-Path: <linux-pci+bounces-25908-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DBEA894B2
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 09:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300981892524
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 07:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD022556E;
	Tue, 15 Apr 2025 07:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jT+val2g"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD68C274FE6
	for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2025 07:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744701435; cv=none; b=YZnSboemombg0NPmISF6fnHcoMHdGX6FJsIqzF52HV05Y7EG2NoOTbd8C9WzacbF2QC32Etmhe5w9AmleBzNCT52LNv1VmE2Aifx6DMbc+W7WhJ+Eqw7GdYXTRMoZ3e67N2ncPt7TfbNfy/Tj3ZTulIzoZVr15QSXfDi64yn+oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744701435; c=relaxed/simple;
	bh=T8MD/T4X8uKn1XMHfC5HIhpX3DfNRuLJFkxyCHa8pVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqblMJkEFXKsXzvyB8zOIrKzmz2I2RgScpet3jdN+2OEdARKUTPsbVx8kI4CwkzBgUm6NSU7k1ZbbiBPky+bGO6npk/1NStbC8rT2sVYTaDkcrJXVdUIIzEhbEB0PqfIl5w1VGCGV7kMecPCHASk1A6nGCq6DuRC5SXHqacEsBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jT+val2g; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b06e9bcc986so1810334a12.0
        for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2025 00:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744701433; x=1745306233; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jV6NGQFGLg4JdFHEjIqGuC71J4i1+oIq9oJnSeBlp3s=;
        b=jT+val2gxqHuZqijp2WtGSeJq3Gj+IiIDX6Z8Mx6BgdgRXLNmKjtFW0Egq5BH7cisG
         PoAuRcF8Dd2GB3Kvlb3/1OGE71n+o1RsbQ++cfzk+dAFhEXll6dpskRq71sz8schxlr5
         STal9GzTkdD8TIps9qg6rTE9eSNC+aoOZJymHrKs2Rjraeq1ZuSRbiAmfMtDUBqO9wio
         NNYRbRABf1SvYrvV59gngBi8mhxzwgqBjUpipzmafSCgSt9Mq4Nn2csJM82s6afq+V6Z
         4wAVaALivhIxMbjv2ggvghmfwPirYhZKV8zX0AK/gqb3XZkQiDJKPQBYFiSL41qzoI/c
         5mpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744701433; x=1745306233;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jV6NGQFGLg4JdFHEjIqGuC71J4i1+oIq9oJnSeBlp3s=;
        b=OdSABEOMxZiKt3h8gM3FNNq7b+jJ01MAMjcEJLY5DmF1gUKWP73kCoWltAEz2a6zkm
         KAjgSgRZ7MTGOU81t4S3vMKCieAaHsJpxWyH9c55OFwsOBuCAEv6MX2yTPO/NX2eB1fb
         E+RJt5T9tJGdJ7g9qQ5vnIXhD45Q3RHHUE4ThBhkfjnlOrC6sMg37fulY5KO1h34QyuQ
         AtMQphvYSaBRcM1+OOHxOkkhO+Oeahy+MqWwFon+TojPrF/m26vWu+8PhsRGmbcE8h82
         EfAgHE0wb56Fln2EJbBPqtxn2ox8ljVi1QyD4vuZrPUsliWDLsV0oRTZl/4UmP/lS3MZ
         s15w==
X-Forwarded-Encrypted: i=1; AJvYcCUndGJkx63HEltZwQfN50cjapKLgtOspa4HsR1Bbqq+YlQmePOkr0NKufbI5nKJvW4l6WxVpAUFo6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YysLMkE2jEWbfyj+dFjgBXBkOgnq1PBQNtbWbcTYvtYzCQpqdhV
	vjPJKEQamHS5bD/+woD9k5dN9D4CCUM+rSl6f4gxuYlAFRpcRCTCg/0LHorgbg==
X-Gm-Gg: ASbGnctIwqeAQY0FakI8JfkNkPjhGH4DWyJ3kkx/tQ1m0eSsSceAHWynC9h1WuRdoa7
	0TuVoC0hvyJqqeBuym4z+TUb9I0cL3FBdPciIs1rVGdPq+TQu99HKhup9AeO+RoHsUVQT2BKEkU
	fDJTHQPJSvc3H3NFQk3hphEzV5HSFvSIlM5eYX1dwJlpwfQT23xmbAUHOH7oYvPoyTm2iPJWaXq
	5+wlqPSoMDed+pwiBeriXSmuND/KfodaW6JiVN9/naXJMkZN2z14LXjxpF0Lvzx1yCS2WF7KUew
	o+t/6u69UbBkOUoewWgN57Bi13S4pr+UVDWXPL8g5qr38sozMw==
X-Google-Smtp-Source: AGHT+IEsKIi1AC4jZA/ksxZU1y9WCKtKtWG0llGnvi3XAKZ2YzyptaNOJKPI/OvYlRGlImVjo9ZAgw==
X-Received: by 2002:a17:902:f707:b0:224:2175:b0cd with SMTP id d9443c01a7336-22bea4c3baamr218535905ad.26.1744701432954;
        Tue, 15 Apr 2025 00:17:12 -0700 (PDT)
Received: from thinkpad ([120.60.71.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8b355sm110106255ad.87.2025.04.15.00.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 00:17:12 -0700 (PDT)
Date: Tue, 15 Apr 2025 12:47:06 +0530
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
Message-ID: <cm5esahjwyoi5hky344nk2vfawf26hzgvu2rkplabav6d2r3gt@y4ypf6mdaapx>
References: <20250328030213.1650990-4-hongxing.zhu@nxp.com>
 <ovaomfvo7b3uxoss3tzhrkgdy6cvxi4kr2zxmqsfjxds5qfohl@t6kc4rswq6gp>
 <AS8PR04MB8676687332C78840B927E7568CAF2@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <rqgl5jjauppyudgmugp34fillkeli3qkwf4uf2djghi6nslebg@pyi6rbwyduxd>
 <AS8PR04MB8676BB3EDFCF3E5A490AC0628CAE2@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <AS8PR04MB8676C5D0DB84975D34C4C65A8CB52@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <4qrfkx3ckywcbk7qbjplal5j7v6sjs3zebeehe5dnrgjz2ej2t@krdwjb4xm2sx>
 <AS8PR04MB8676221C998474EF5A9B94288CB72@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <h7pja24zffl4t7653rjaamp6v2j5nmukbzq7rdajynemlyb6l6@3e37ggkparjg>
 <AS8PR04MB8676CFD0FA7BCBB06AC51B018CB32@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8676CFD0FA7BCBB06AC51B018CB32@AS8PR04MB8676.eurprd04.prod.outlook.com>

On Mon, Apr 14, 2025 at 03:15:28AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Sent: 2025年4月13日 23:39
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de;
> > lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> > bhelgaas@google.com; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > kernel@pengutronix.de; festevam@gmail.com; linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; imx@lists.linux.dev;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v3 3/6] PCI: imx6: Workaround i.MX95 PCIe may not exit
> > L23 ready
> > 
> > On Thu, Apr 10, 2025 at 02:45:51AM +0000, Hongxing Zhu wrote:
> > > > -----Original Message-----
> > > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > Sent: 2025年4月10日 0:44
> > > > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > > > Cc: Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de;
> > > > lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> > > > bhelgaas@google.com; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > > > kernel@pengutronix.de; festevam@gmail.com;
> > > > linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > > > imx@lists.linux.dev; linux-kernel@vger.kernel.org
> > > > Subject: Re: [PATCH v3 3/6] PCI: imx6: Workaround i.MX95 PCIe may
> > > > not exit L23 ready
> > > >
> > > > On Tue, Apr 08, 2025 at 03:02:42AM +0000, Hongxing Zhu wrote:
> > > > > > -----Original Message-----
> > > > > > From: Hongxing Zhu
> > > > > > Sent: 2025年4月3日 11:23
> > > > > > To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > > Cc: Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de;
> > > > > > lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> > > > > > bhelgaas@google.com; shawnguo@kernel.org;
> > > > > > s.hauer@pengutronix.de; kernel@pengutronix.de;
> > > > > > festevam@gmail.com; linux-pci@vger.kernel.org;
> > > > > > linux-arm-kernel@lists.infradead.org;
> > > > > > imx@lists.linux.dev; linux-kernel@vger.kernel.org
> > > > > > Subject: RE: [PATCH v3 3/6] PCI: imx6: Workaround i.MX95 PCIe
> > > > > > may not exit
> > > > > > L23 ready
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org>
> > > > > > > Sent: 2025年4月2日 23:18
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
> > > > > > > On Wed, Apr 02, 2025 at 07:59:26AM +0000, Hongxing Zhu wrote:
> > > > > > > > > -----Original Message-----
> > > > > > > > > From: Manivannan Sadhasivam
> > > > > > > > > <manivannan.sadhasivam@linaro.org>
> > > > > > > > > Sent: 2025年4月2日 15:08
> > > > > > > > > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > > > > > > > > Cc: Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de;
> > > > > > > > > lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> > > > > > > > > bhelgaas@google.com; shawnguo@kernel.org;
> > > > > > > > > s.hauer@pengutronix.de; kernel@pengutronix.de;
> > > > > > > > > festevam@gmail.com; linux-pci@vger.kernel.org;
> > > > > > > > > linux-arm-kernel@lists.infradead.org;
> > > > > > > > > imx@lists.linux.dev; linux-kernel@vger.kernel.org
> > > > > > > > > Subject: Re: [PATCH v3 3/6] PCI: imx6: Workaround i.MX95
> > > > > > > > > PCIe may not exit L23 ready
> > > > > > > > >
> > > > > > > > > On Fri, Mar 28, 2025 at 11:02:10AM +0800, Richard Zhu wrote:
> > > > > > > > > > ERR051624: The Controller Without Vaux Cannot Exit L23
> > > > > > > > > > Ready Through Beacon or PERST# De-assertion
> > > > > > > > >
> > > > > > > > > Is it possible to share the link to the erratum?
> > > > > > > > >
> > > > > > > > Sorry, the erratum document isn't ready to be published yet.
> > > > > > > > > >
> > > > > > > > > > When the auxiliary power is not available, the
> > > > > > > > > > controller cannot exit from
> > > > > > > > > > L23 Ready with beacon or PERST# de-assertion when main
> > > > > > > > > > power is not removed.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > I don't understand how the presence of Vaux affects the
> > controller.
> > > > > > > > > Same goes for PERST# deassertion. How does that relate to
> > > > > > > > > Vaux? Is this erratum for a specific endpoint behavior?
> > > > > > > > IMHO I don't know the exact details of the power supplies in
> > > > > > > > this IP
> > > > design.
> > > > > > > > Refer to my guess , maybe the beacon detect or wake-up logic
> > > > > > > > in designs is  relied on the status of SYS_AUX_PWR_DET
> > > > > > > > signals in this
> > > > case.
> > > > > > >
> > > > > > > Can you please try to get more details? I couldn't understand the
> > errata.
> > > > > > >
> > > > > > Sure. Will contact designer and try to get more details.
> > > > > Hi Mani:
> > > > > Get some information from designs, the internal design logic is
> > > > > relied on the  status of SYS_AUX_PWR_DET signal to handle the low
> > power stuff.
> > > > > So, the SYS_AUX_PWR_DET is required to be 1b'1 in the SW
> > workaround.
> > > > >
> > > >
> > > > Ok. So due to the errata, when the link enters L23 Ready state, it
> > > > cannot transition to L3 when Vaux is not available. And the
> > > > workaround requires setting SYS_AUX_PWR_DET bit?
> > > >
> > > Refer to the description of this errata, it just mentions the exist
> > > from
> > >  L23 Ready state.
> > 
> > Exiting from L23 Ready == entering L2/L3. And since you mentioned that Vaux
> > is not available, it is definitely entering L3.
> > 
> > > Yes, the workaround requires setting SYS_AUX_PWR_DET bit to 1b'1.
> > >
> > > > IIUC, the issue here is that the controller is not able to detect
> > > > the presence of Vaux in the L23 Ready state. So it relies on the
> > > > SYS_AUX_PWR_DET bit. But even in that case, how would you support the
> > endpoint *with* Vaux?
> > > >
> > > This errata is only applied for i.MX95 dual PCIe mode controller.
> > > The Vaux is not present for i.MX95 PCIe EP mode either.
> > >
> > 
> > First of all, does the controller really know whether Vaux is supplied to the
> > endpoint or not? AFAIK, it is up to the board designers to route Vaux and only
> > endpoint should care about it.
> > 
> > I still feel that this specific erratum is for fixing the issue with some endpoints
> > where Vaux is not supplied and the link doesn't exit L23 Ready. Again, what
> > would be the behavior if Vaux is supplied to the endpoint? You cannot just say
> > that the controller doesn't support Vaux, which is not a valid statement IMO.
> > 
> Sorry, I miss-understand the question you posted in the previous reply.
> I get the following answer from designers when the Vaux is supplied to the
>  remote endpoint. Hope it can get ride of your concerns.
> Q:
> How about the situations when remote partner has the Vaux present?
> For example, i.MX95 PCIe used as RC, and a endpoint device with one Vaux
>  present is connected to i.MX95 PCIe RC.
> 
> A:
> " As per my understanding it should work irrespective of vaux presence in remote partner."

Okay, thanks for the confirmation. Please include this information in commit
message for documentation.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

