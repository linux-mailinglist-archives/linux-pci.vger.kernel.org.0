Return-Path: <linux-pci+bounces-22935-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E68FA4F67D
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 06:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776D53A522B
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 05:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51281C84CC;
	Wed,  5 Mar 2025 05:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqI9M0qx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979021C860B;
	Wed,  5 Mar 2025 05:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741151928; cv=none; b=DTyfa5Xeh6tkbxotVCYMnYZKWSOI5Swn1oQn75cu0OMV19jiX5LLtQrqCwAh37aBE1u/PRG3IhUu+30pHD/NEWPKmBFvrOkQD9kWAsSxMIdZGdOjtUQXLWzlvCvRVaNe+en1oKZOHznQ31FzVo8oHBy406iWa0CFJAC6K2f6XUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741151928; c=relaxed/simple;
	bh=kC87oeOMtl04lb5WrpnzUnxVnwsFKi0GNcv5vmYteyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFq0O06BrJKVbx/UTh3SQX3w2lOBRPA54ecxewiJej5JrLMeGmVTtlOEivFMF1EKj0vE4awGq9fSh3fOCtmzQNfA3gm0DiNWAReYGiNfUEq3+0KfDmkcAiVF8oe1rHCQhW4Ay1PH/zZPHjl32udNpfoXn8le68soXFDdIo4nX98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqI9M0qx; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-47208e35f9cso74221361cf.3;
        Tue, 04 Mar 2025 21:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741151925; x=1741756725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1P3+iYzJ+YpQ9FI2rKYP4r/ocmp23KFw2lq/RJsTz1Y=;
        b=nqI9M0qxWGD86tY3SCfSarYGX2THSffymq518qCorOYwkLs6rEQOM+5APuSiR32/mC
         MEn/s7R/oBAOznXoVzEKa6tsBZ4ZuFIzHU3P8keIIktEIf5AdeCUxr+6+9iMaBmxnsL2
         jaon7YPUEIN6HBkCxiX/AZPitY2PX1+zkmkzQmC1l6HbxLaJt7lKvHv+pEyVR9TY1ayE
         wHwlxzZ2HczEKmKaqdUIUVrF1x08RAVje6O7LBuclB4nb1RuIevJJyJpyLnTB5VyhTcY
         wqfdzKGO6tFXNL+kG4DiFe9Gawtvi5X1YWCXjstvqO3i8J+Wb/DXLykusiZuxoGj73w6
         4XXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741151925; x=1741756725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1P3+iYzJ+YpQ9FI2rKYP4r/ocmp23KFw2lq/RJsTz1Y=;
        b=TZS3Y8pX5V2g/l/4puEXr6o/1H9SAQQY7GqTu0tm5nCJ9Fzks8Xm8689GKtwAHbRnM
         LrCcccUh32aMPeYAIydZSRg+8K7xhKS/r/hkzgRc3KJXeIYf7HNnDFTyUtY8BpgORvk2
         b7VdNw8w9hk2y9pSep6Mgty+zCWbyS6g8uP/RHB0GGLLytqrJbwCY/PE8Nri7ljJttPG
         3B2G7bKpwJAKgI3hwW86lXY8Rp1BbwkyJQHazM2krn/1d8joCFRs0ZPYBSAC/Tg+GJEP
         tyGRXB2egBAM+dlhXxdyr9/DUGupRdnLjsKAcrcD0G0h3sGnv/rat+qIUjMZErWZQ7rH
         652g==
X-Forwarded-Encrypted: i=1; AJvYcCVN24ClVz7byggYs2MCEjznFTMT4s/6PwF9j0LYAZNKVyH/zenKj9ExrwJ/IkGavXYyoH3IwgzCkUCk@vger.kernel.org, AJvYcCWDvGeVwntI5dRZCT4uyO/cTmmkgEm5L5Ju34NkUZyPD7y+IFVUibIAHOG6q2FHy8tdGB0cw+8GAQEqehk9@vger.kernel.org
X-Gm-Message-State: AOJu0YzZRVZCdy2M+w6fn1LUDQcPFogo2EZ60GFkw9FJzKGJQ+qRzlAU
	bJE0Xg1A7jN4b83CsLwP3gJIQTwRphApFRzLum8F/aDsH6pO2CAq
X-Gm-Gg: ASbGnctA/ZOZ6PiZDpu+FMHstUzuikv3Wp5Wa/Lgs0JCB0sLuYWulS9cPNUfb6f/Vwq
	78bnWCNtsavaGwrV3KUCcOrJXP2qa36rB5vkqVVz79169QQQC1btbuAhSzjJCb1T5bkWJSCXMyX
	mHpfOhCEg+G+R5y2TOeAUNipqw0pZ5Ks8cZttBCep34rs0rYqK1nZfPq9GzTGvr4Z5aSflJTWSu
	7Hwz324ch0qsTMzDnY96K8NQrOKZrj2WnlnqtIkF3/dnUn8G2jndkeJ4NrAPIi1mlPajbP45nxg
	2fG8ZnE8K8I+02nCoJ20
X-Google-Smtp-Source: AGHT+IEL+SRXWaxNqoLf2fRqsU51Nuz6KF+mx2D44cet7M+NDkMLl3pM/VonNiECdPjeLo+ew7jsDA==
X-Received: by 2002:ac8:5715:0:b0:471:bbd5:aff2 with SMTP id d75a77b69052e-4750b23bd92mr21798421cf.10.1741151924641;
        Tue, 04 Mar 2025 21:18:44 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-474f73d8145sm27595631cf.55.2025.03.04.21.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 21:18:44 -0800 (PST)
Date: Wed, 5 Mar 2025 13:18:17 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Johan Hovold <johan+linaro@kernel.org>, 
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 2/2] PCI: sophgo-dwc: Add Sophgo SG2044 PCIe driver
Message-ID: <borpjzjwtdeigqs4szogy2ozzqsqj3ucvppl3k6cdzfoukgdur@23wwl55dmrfj>
References: <20250304071239.352486-1-inochiama@gmail.com>
 <20250304071239.352486-3-inochiama@gmail.com>
 <PN0PR01MB10393134B6BD714C1F070F0BEFEC82@PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PN0PR01MB10393134B6BD714C1F070F0BEFEC82@PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM>

On Wed, Mar 05, 2025 at 07:57:14AM +0800, Chen Wang wrote:
> 
> On 2025/3/4 15:12, Inochi Amaoto wrote:
> > Add support for DesignWare-based PCIe controller in SG2044 SoC.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >   drivers/pci/controller/dwc/Kconfig          |  10 +
> >   drivers/pci/controller/dwc/Makefile         |   1 +
> >   drivers/pci/controller/dwc/pcie-dw-sophgo.c | 270 ++++++++++++++++++++
> Will this driver work for all sophgo chips using dw's IP? If not, it is
> recommended to rename it to "pcie-dw-sg2044.c".

It should. As the DesignWare PCIe ip is widely used and I saw
limit changed across the vendor. And the implement on SG2044
is almost like the Synopsys one. I think it is possible to 
represent all DesignWare based PCIe driver for the Sophgo SoCs.

Also, please think twice before giving some suggestion like
this. Although it is a good practice to keep the driver
specifc. keeping everythings specifc make us miss some common
things. 

Regards,
Inochi

> >   3 files changed, 281 insertions(+)
> >   create mode 100644 drivers/pci/controller/dwc/pcie-dw-sophgo.c
> > 
> > [...]
> > +
> > +static void sophgo_intx_irq_eoi(struct irq_data *d)
> > +{
> > +}
> Why define this empty callback function? Please add a comment if it is
> really needed.

See https://lore.kernel.org/all/bxwsvluj6amgoelk7r55gqhmhjwpewnfyhvvw6zpxen7kqzvwc@fxcebjzo5axk/

