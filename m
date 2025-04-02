Return-Path: <linux-pci+bounces-25188-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B207A791F5
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 17:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1DB016A06D
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 15:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329412D7BF;
	Wed,  2 Apr 2025 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uihdAEGm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E3D39FD9
	for <linux-pci@vger.kernel.org>; Wed,  2 Apr 2025 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743607062; cv=none; b=h2XJhJW7aAiqf+duVJZhMnpcMJlnKZlgSQi1RHOMCnvV44kHpZ+96XUn4iMkODWG4lD6jEaWB0VCtN2jWhYRozt3bVsL1pQX3skpYPVrcA/I9nRpGVnM1BBE7kjnZ1vMvzSpuMxstzG9cd0zMPfKG45brEEiyz2wCeCevNYsB0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743607062; c=relaxed/simple;
	bh=bz3rHQ1LEZ5GlZRhjsHjlZAaWas133zf2WZHx8MQBRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAGxiqpOgibgYBIGnl23dgqm0+qwlb9+4/dG85ijZl4G2KekG/opnNmRw/1knotQvT3aYouZn/SFL320Pb3CYm/KgUh9aSIRJJCD0BvXUF1LPVqriOAAUftd8zxB9n2Wm+8qjaSH37j//tk35CqTQvwnNHqLvpL9jVd2iCI9G6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uihdAEGm; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-af28bc68846so258334a12.1
        for <linux-pci@vger.kernel.org>; Wed, 02 Apr 2025 08:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743607060; x=1744211860; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A1VmkVlpRc4WSi9FaO0aW2j/f9rNxZ3VMxxdj/njEz0=;
        b=uihdAEGm4PcmfdflyqkzuBZmJG3CKxvzbghFT48jhXFYejBMVyVTMYL99PS9Sbtk+s
         NF1von7CcABHbFDLGxrqNgVV+P4ZHKnik/lMlvczg8lMvOv4xT6SN1w5a0SAy0JTebO/
         5gOkOtwpKjHUTMMBvqhBYlA+nDS27B+0b1IU9VgDpkIMPHq/TdkGj3LsU0Vz1hyaS5Sb
         DeASb8RjvcPYqZWJNB1eKEnyfLY8M/zVOE8xI+WgX5YfcWizXeAbAwp2tK/pz8ipNDvo
         2daIy4zErCe3sVPvah9cNzvjTFJ9DBRscHDUwFF0Eq6OtQt/hVtBINl2NLZJjP3Gz2CC
         NBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743607060; x=1744211860;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A1VmkVlpRc4WSi9FaO0aW2j/f9rNxZ3VMxxdj/njEz0=;
        b=mOy38o6JKkfw5F37ui0+2hvBDDvnT6DK55z6Vq/7TUOYcBYCycW05buGBcX5mB32mU
         +WfCYvgJ3gCHSaQiln8eBsgc4iXIJBw/M4LumHtFLp9FMSDBqm+rpFRIFR46jQz/fLTW
         ngDyUaOQBUt0bv54BnzzTY9W+IWzQI5nPY0vxZdqHQGrateFs+j1zPAvJDFqcaDSuK14
         Y7FA+0iFFZX8FiR5S2sL2VIP/9mxZWHgSE0HID0B6dR0gGUwfoj6M/x+lbhxR4PHhh82
         Bb+Q6X1m4xV7IE32g1xRTbhY7oH2bfnMwcyRTbvCYMNDpdH3QU5LJg+dOtXQRqF9hH+s
         QeBg==
X-Forwarded-Encrypted: i=1; AJvYcCVu6hQ+Xa0+/RN4PMm/jMjLl/WhSmIbXa+XlvZqTait9SBBN8VY4der7joPUSAiGm4NThyC/jKHS4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjVxv/WJ9h1311Rc0NMLqgsyPaLrWIT8PjRujkH7m29bjcJKOq
	ARVwpx6QevxZvUUBbzq0bdc6auKRmjOG6FPWJp0NbD+oFf1gv/Xm75219Pq2TvrGycB8CgZxxTU
	=
X-Gm-Gg: ASbGnct2gicd9+B+wb16SG/u/dGSqWzfyFqdYwiFnYlnmCyuH0Kczu7CPOCHuqbqpvz
	ENpWS8MDMEOtJlpZd2UstQpsaKzfYF6kQ29DEwpO5Xf25KM4CGN2HVoKbvBfn15YGlHKosNqsn/
	U4W+Zsql3mtLu8X+OOWDKRKch10Yo+LgLGgJYsih9lmh+gEYdTEhgBaMA/wngbOFbJSM2GfBhns
	r1lMB1Mw/9L9mqaX+XKlzkPGSO2fJJ4KNMSz12j22zM1ZXWQMh/NBgUvJEdz0rjKbdF903n1K43
	y3r1tjDucOiEy7R9AvneofDuoGBK2RMec7GXkvNy9XdY30Fsprffc+xe
X-Google-Smtp-Source: AGHT+IG16MivObzWU33JTwzx5znIxU6+vnQt0ROoOp8Kq1NbarWsZJpr2IHBGg06IH61ZT+KYFb1+A==
X-Received: by 2002:a17:90a:e7c7:b0:2f4:432d:250d with SMTP id 98e67ed59e1d1-305320b166emr18279561a91.21.1743607059436;
        Wed, 02 Apr 2025 08:17:39 -0700 (PDT)
Received: from thinkpad ([120.56.205.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eedf9b4sm109376755ad.84.2025.04.02.08.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 08:17:38 -0700 (PDT)
Date: Wed, 2 Apr 2025 20:47:33 +0530
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
Message-ID: <rqgl5jjauppyudgmugp34fillkeli3qkwf4uf2djghi6nslebg@pyi6rbwyduxd>
References: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
 <20250328030213.1650990-4-hongxing.zhu@nxp.com>
 <ovaomfvo7b3uxoss3tzhrkgdy6cvxi4kr2zxmqsfjxds5qfohl@t6kc4rswq6gp>
 <AS8PR04MB8676687332C78840B927E7568CAF2@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8676687332C78840B927E7568CAF2@AS8PR04MB8676.eurprd04.prod.outlook.com>

On Wed, Apr 02, 2025 at 07:59:26AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Sent: 2025年4月2日 15:08
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
> > On Fri, Mar 28, 2025 at 11:02:10AM +0800, Richard Zhu wrote:
> > > ERR051624: The Controller Without Vaux Cannot Exit L23 Ready Through
> > > Beacon or PERST# De-assertion
> > 
> > Is it possible to share the link to the erratum?
> > 
> Sorry, the erratum document isn't ready to be published yet.
> > >
> > > When the auxiliary power is not available, the controller cannot exit
> > > from
> > > L23 Ready with beacon or PERST# de-assertion when main power is not
> > > removed.
> > >
> > 
> > I don't understand how the presence of Vaux affects the controller. Same goes
> > for PERST# deassertion. How does that relate to Vaux? Is this erratum for a
> > specific endpoint behavior?
> IMHO I don't know the exact details of the power supplies in this IP design.
> Refer to my guess , maybe the beacon detect or wake-up logic in designs is
>  relied on the status of SYS_AUX_PWR_DET signals in this case.

Can you please try to get more details? I couldn't understand the errata.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

