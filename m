Return-Path: <linux-pci+bounces-25589-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A32BFA82CB8
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 18:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E43116DC24
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 16:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC75326772C;
	Wed,  9 Apr 2025 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xlr6WSs0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385941DC07D
	for <linux-pci@vger.kernel.org>; Wed,  9 Apr 2025 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744217024; cv=none; b=C2t6bzZYeFjhBSjLge1C+EzLsL7N0H/Oos1PXL0yedWzi/CNGNi/CAjbNyDUGsErLXxdeD5NkVuuZGppb8v8BUydl/HYfGdvmPagy11cVb8cMIiZdY11ze6mB13IWTFPXDjD5XNcIzio3OksBwiJdmAOS6jk26FTllS58Ohiay0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744217024; c=relaxed/simple;
	bh=5eUj6yBdJ8a0mINwGc3NfXDTNv0qkC5CznahgFCyhNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjrzEN0j23dPIHuWVbUOpJ2AxUSrGdnRVTJf84MwLa3ckyBd5xZBKe4eyTnJz6pAqZhmTjK4MoA6ZSI3YT+5VdnH16A5rwtqjLJbVEESahj5rvjgRNP6RQVHJYLc5tBVyoLQ4aWf8TlpnQWcBZnpfgM2m3vgwE4qZLJRVwbFBbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xlr6WSs0; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-224019ad9edso91633325ad.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Apr 2025 09:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744217022; x=1744821822; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vY1cCwOeuEYKDsSiTLX+gpvDg+AadEDeAOXISK1ljl4=;
        b=xlr6WSs0UFPT1X4QuKinBAVQbl/EgJxxa7ghRyYYeDc9oHeBO4lJXxTaEvv+gcg1sk
         lcT1X9cQtxrxFPQA2oDC1PKQRANIs9xyVkF4pNdrxeZE3wtMqSpvslunVctvNYpCQkSg
         6d7PIK+OMsN3ELAyWUyrb5rGAEqVZlo4mWs2GPBUXCXSx8YnqkoO9Z0TjCD/mQsPxLK6
         y/1n6GZ5pC0d8jhYqrXTm929ikAqoUYbz1mWkwOQT6s5ebGWkEle2qPFp7zVJsJeA/Vc
         IgsltZGvJyTH7WRc/RhZ+NtrLJuawttKKWqfOXcg6X4u8mhqNCyF8tek4DBOwpXHrrT4
         DNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744217022; x=1744821822;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vY1cCwOeuEYKDsSiTLX+gpvDg+AadEDeAOXISK1ljl4=;
        b=U3DLiM+xL57HVp7I5hoqtQF+BIRXkDoUw0YLYqabc4IpPHKkAnK3LQEMFCA7k02k2k
         SND6TYiFeTBayW08I13HhDuciQw2DM/kMHk09kZxOXgU8icVEbbLUtWctOjILeuCFscp
         pwLx/evVncDHZEAOzshIf5E6gXIJEGdWXlKogi5K25Eeu1wqvoWeqcLB55FnigDDajr9
         1KqyG2qV8ky0SgeIS5U7KFqisKWLJXNFezZMa9YjmZaB+anw8jHxHo2EJRsoCfV0SL65
         wafEmSxoybpcmuArQ3/Hdya0pxO+shzKiKYIRQtOjBcYpNJyF49eYup0Lx0ta3t/NDW7
         6rqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2kB7bTrH3Lm9kNBdkx16Ls1IXd3RxAqp5eI5PW/xxSz4PreCLwas0qW0D1H0AxlVgnGcM+p5osNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpVU7bERsyBa+ng2Jndz1cdb2yTtmeaFP6gvy97GNitMsn22Kc
	mGyuylgKvIEWMb3tWrbIlTbaFZnUYCNonbA8DsqLILp4L7Y19TJ0LHzdCaOksg==
X-Gm-Gg: ASbGncsHvPpe7g/sCZM6iFTb+4dDqF+L24FQe4GTT05YXrXv1DrEz3bZm8eT/SU6hI4
	45R8LD60bgTSVwJa36CH3dWd7KQzMyrd08YrPXIjHLxS4QDpOJ1wq3NCvCZ5//73qVzamtHkJVk
	Mqhai1J8nVR7LnlLk3r1P2/MkXF9Bvle2Gu4N9S46sbtNcVtC/w07nn0fBnwtcWpXfSeQqaCoh0
	ebnSBH1JRUOSWVNCM6t0l9gA8kBG2Usf3gOnhE0XDtx4lh8jTxeSCMtJCgF6ciDPxNGZuJm++KZ
	pVzdPb70g6YjGyS1A2CR6D2uu9tCE0C61oOBl22VJAEqXKTJ+rGuGB5gWVLMrA==
X-Google-Smtp-Source: AGHT+IGmox3LqV854DFPIki4F+4Ez1MkIE7qgsYtzCRr9m1FgmnFh+N3/PD/p2Tx05KbHuOZaTpH7A==
X-Received: by 2002:a17:903:32ce:b0:224:7a4:b2a with SMTP id d9443c01a7336-22ac297c916mr55618525ad.11.1744217022535;
        Wed, 09 Apr 2025 09:43:42 -0700 (PDT)
Received: from thinkpad ([120.56.198.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b642besm14327585ad.46.2025.04.09.09.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 09:43:41 -0700 (PDT)
Date: Wed, 9 Apr 2025 22:13:36 +0530
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
Message-ID: <4qrfkx3ckywcbk7qbjplal5j7v6sjs3zebeehe5dnrgjz2ej2t@krdwjb4xm2sx>
References: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
 <20250328030213.1650990-4-hongxing.zhu@nxp.com>
 <ovaomfvo7b3uxoss3tzhrkgdy6cvxi4kr2zxmqsfjxds5qfohl@t6kc4rswq6gp>
 <AS8PR04MB8676687332C78840B927E7568CAF2@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <rqgl5jjauppyudgmugp34fillkeli3qkwf4uf2djghi6nslebg@pyi6rbwyduxd>
 <AS8PR04MB8676BB3EDFCF3E5A490AC0628CAE2@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <AS8PR04MB8676C5D0DB84975D34C4C65A8CB52@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8676C5D0DB84975D34C4C65A8CB52@AS8PR04MB8676.eurprd04.prod.outlook.com>

On Tue, Apr 08, 2025 at 03:02:42AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Hongxing Zhu
> > Sent: 2025年4月3日 11:23
> > To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Cc: Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de; lpieralisi@kernel.org;
> > kw@linux.com; robh@kernel.org; bhelgaas@google.com;
> > shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> > festevam@gmail.com; linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; imx@lists.linux.dev;
> > linux-kernel@vger.kernel.org
> > Subject: RE: [PATCH v3 3/6] PCI: imx6: Workaround i.MX95 PCIe may not exit
> > L23 ready
> > 
> > > -----Original Message-----
> > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Sent: 2025年4月2日 23:18
> > > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > > Cc: Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de;
> > > lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> > > bhelgaas@google.com; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > > kernel@pengutronix.de; festevam@gmail.com; linux-pci@vger.kernel.org;
> > > linux-arm-kernel@lists.infradead.org; imx@lists.linux.dev;
> > > linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH v3 3/6] PCI: imx6: Workaround i.MX95 PCIe may not
> > > exit L23 ready
> > >
> > > On Wed, Apr 02, 2025 at 07:59:26AM +0000, Hongxing Zhu wrote:
> > > > > -----Original Message-----
> > > > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > Sent: 2025年4月2日 15:08
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
> > > > > On Fri, Mar 28, 2025 at 11:02:10AM +0800, Richard Zhu wrote:
> > > > > > ERR051624: The Controller Without Vaux Cannot Exit L23 Ready
> > > > > > Through Beacon or PERST# De-assertion
> > > > >
> > > > > Is it possible to share the link to the erratum?
> > > > >
> > > > Sorry, the erratum document isn't ready to be published yet.
> > > > > >
> > > > > > When the auxiliary power is not available, the controller cannot
> > > > > > exit from
> > > > > > L23 Ready with beacon or PERST# de-assertion when main power is
> > > > > > not removed.
> > > > > >
> > > > >
> > > > > I don't understand how the presence of Vaux affects the controller.
> > > > > Same goes for PERST# deassertion. How does that relate to Vaux? Is
> > > > > this erratum for a specific endpoint behavior?
> > > > IMHO I don't know the exact details of the power supplies in this IP design.
> > > > Refer to my guess , maybe the beacon detect or wake-up logic in
> > > > designs is  relied on the status of SYS_AUX_PWR_DET signals in this case.
> > >
> > > Can you please try to get more details? I couldn't understand the errata.
> > >
> > Sure. Will contact designer and try to get more details.
> Hi Mani:
> Get some information from designs, the internal design logic is relied on the
>  status of SYS_AUX_PWR_DET signal to handle the low power stuff.
> So, the SYS_AUX_PWR_DET is required to be 1b'1 in the SW workaround.
> 

Ok. So due to the errata, when the link enters L23 Ready state, it cannot
transition to L3 when Vaux is not available. And the workaround requires setting
SYS_AUX_PWR_DET bit?

IIUC, the issue here is that the controller is not able to detect the presence
of Vaux in the L23 Ready state. So it relies on the SYS_AUX_PWR_DET bit. But
even in that case, how would you support the endpoint *with* Vaux?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

