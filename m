Return-Path: <linux-pci+bounces-17219-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6285E9D62C7
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 18:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CECBFB21439
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 17:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C85A1DEFC8;
	Fri, 22 Nov 2024 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eEHbJ5Cn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2E61DE3D6
	for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2024 17:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732295452; cv=none; b=OzCtB7FczU1aV/QNwT6ObNgpUMOIsYYKRFgzpBP3R7aN3vx6X5iyFKDvC80con2JL75i3Vlr1r6J2yxeY5JQ/3qaBtHviirwixwnEu8MTnH4X1P3pbRLysG1/ywo2rljn5PtaIj34kdf0U/CtwLUKERRLHgIrvjtxcANtc94phQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732295452; c=relaxed/simple;
	bh=JSfJBNYEbA8FDDOxY/qXqSPsOBH8pc0lxdl5eHk3OHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtxO1Yq7xw8Ja+ztjIpqlKWCwp9XkWQHtK1XSyiW23N76ujud1lbn4y30549iKvrUga3vx2CqoYn43k2Znnq782wEMi3BF9r5Z2oPCL7+KswTfPuuiUbTFTIeK8fHU6QqFndCa570fEVervzsEdgT5DmPs4CYL92lqcgkox7fKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eEHbJ5Cn; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7eb0bc007edso1631947a12.3
        for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2024 09:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732295450; x=1732900250; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m9Rzu/atJszaZiZQ8bphSysVEtM05e/rUjckRGXXQa8=;
        b=eEHbJ5Cnr2LP8QZElbeawTkXgevrD8ABRlNJvZt1JkG9R+miEgmgPO82jiaFVKeau0
         sYR9Qa3JIM8DlJuMwGsHosxuRynXh4QW0N4EmYr3ygqHL9zyXOp7JewevuBEPBhbpu2O
         aYA9Ozni6L4o7LO8v6+UmOCogpUHNooCv5dRIG2YhOHIfkiyxG/VdL/Is7eNt7ePUccd
         6c/2mxkv9oIeMW5N1VKoWnU0yxuIz/TnhuvOW/wUycHtIbCp+d0RyCcTgGBEb2OIGHZK
         iMgJDM2WAF7Br9pBVBawATHk1B6eKy+KXtCkqpfURGwyNtZi2beo9VNsFDSo+Y7nav0m
         Skzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732295450; x=1732900250;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m9Rzu/atJszaZiZQ8bphSysVEtM05e/rUjckRGXXQa8=;
        b=MSLTUM4MTF8Nel+5Y4rCgFKlFfWfShC9yjm6qwJ7eyNZ1zqkxQ5ZQaL9+gw/5cbLWe
         R63/F2nbgkj90eVYuOc85OMd7UXaqxEJR+/jLcFgxNMaYzGi4M6feoCBxsxxdrk3MDg7
         2Dli5xqPEI4jrECM/aNxX5/4QQUK9dWqZDd0L93vl9AYx5J1DaTX2uMG9m7PsPK+fkk3
         wKIrY06raYzSQq0BZMqCSzDqoph3/IunmNJR9j1/uijdkUaOn4LtaBPd9QFM6HVkdwVZ
         soljF/vM+86wJD1DPqYmQ7bmal9bBIVWRouvvXMtgZFTFFwlscsfcgA4y+2Sf3qv5ONg
         +ngw==
X-Forwarded-Encrypted: i=1; AJvYcCXWgdA4RqBdYCrxDGegNKwK/AdkgLk5obnC0m/4PoQbVQNJh3lHDpNBKs5CF9WK70PCEhPWClZMfEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfvObGwxVWp2Ia9Xqj6fbEYDMAfSzJf4/bl8xD3/AAKak386N8
	pC6kpHPHDDsDGCVgrD3Mo0e0sg21PMPjE4BNr4e3onNMuDl7gNhqXobzJ6Hnlw==
X-Gm-Gg: ASbGncsmKe1bBoLVhat2YXhWd/oC+/UNGk1TkhacVoukiHuKEt1xO+PwyIXo8A5GpgS
	Z63NGX8J06WEvdFeZBNTLdS2LSkTmO7ye/6ruT+cRpp+sU1xncBgCcQr9AB7EwQ8ct5myCqznNX
	+Kb61JAhTQxnwM5U0UPyFMhGhNhX0ldXYIJRql/zEXyQ9a1UB7r/yGrU6H6BKwQqB14T+ShUN1w
	UlVDVXAMBA2EzPVhKjmWoUOImXUoqFBAP80JmTCLQmSU/pOMqq9ud2oJvWC
X-Google-Smtp-Source: AGHT+IFIhc1R40hXLVSot1qpNb47cXTxZcrRwISXx0lJGKYTEDxVxH0DwKBYDolmma7+CJxTTAgLkQ==
X-Received: by 2002:a05:6a20:d503:b0:1c6:fb66:cfe with SMTP id adf61e73a8af0-1e09e45ff0emr4838841637.21.1732295449974;
        Fri, 22 Nov 2024 09:10:49 -0800 (PST)
Received: from thinkpad ([49.207.202.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de57a562sm1847026b3a.195.2024.11.22.09.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 09:10:49 -0800 (PST)
Date: Fri, 22 Nov 2024 22:40:43 +0530
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
Subject: Re: [PATCH v6 04/10] PCI: imx6: Correct controller_id generation
 logic for i.MX7D
Message-ID: <20241122171043.j2xh4fvdo6goq7o2@thinkpad>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
 <20241101070610.1267391-5-hongxing.zhu@nxp.com>
 <20241115064321.3cuqng7bzmphiomw@thinkpad>
 <AS8PR04MB8676989276C723C26DADFB5D8C272@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8676989276C723C26DADFB5D8C272@AS8PR04MB8676.eurprd04.prod.outlook.com>

On Mon, Nov 18, 2024 at 02:59:48AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Sent: 2024年11月15日 14:43
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: l.stach@pengutronix.de; bhelgaas@google.com; lpieralisi@kernel.org;
> > kw@linux.com; robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> > shawnguo@kernel.org; Frank Li <frank.li@nxp.com>;
> > s.hauer@pengutronix.de; festevam@gmail.com; imx@lists.linux.dev;
> > kernel@pengutronix.de; linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v6 04/10] PCI: imx6: Correct controller_id generation
> > logic for i.MX7D
> > 
> > On Fri, Nov 01, 2024 at 03:06:04PM +0800, Richard Zhu wrote:
> > > i.MX7D only has one PCIe controller, so controller_id should always be 0.
> > > The previous code is incorrect although yielding the correct result.
> > > Fix by removing IMX7D from the switch case branch.
> > >
> > 
> > Worth adding a fixes tag?
> > 
> It's originated from commit 2d8ed461dbc9 ("PCI: imx6: Add support for i.MX8MQ")
> 
> How about to add one Fixes tag like this?
> Fixes: commit 2d8ed461dbc9 ("PCI: imx6: Add support for i.MX8MQ")
> 

Okay.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

