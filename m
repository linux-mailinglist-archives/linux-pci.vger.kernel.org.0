Return-Path: <linux-pci+bounces-17081-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2BC9D2CD6
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 18:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62FB5B36D6F
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 17:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646191D2238;
	Tue, 19 Nov 2024 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBxcQb29"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377C51D1E8E;
	Tue, 19 Nov 2024 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732037230; cv=none; b=dIgeTtxYwbo4K1lJsUG2DTjjm5b9toutTJQzL3yFxEF8lRYtI21qJWvNQ5HDacdyldrAYrKChy7KwH2nxbeGkTg8T/ru2svBJ7Py03iLkjtRxxi5kVe6D/55EiyQT7PAC/PRpkv1u29QTC6B7KLUChyuZUEiM9LYXA4qI6m9MfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732037230; c=relaxed/simple;
	bh=DaA+xZ+OZeK05SotfgPNfTPRkNsT8TPkrpHepr+rIvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AlQDsdQI4xt7AdU8mDR/QrKKMfFYFp08i4wgb7Gp7QqPfMA1/hPXVZNgpE9qUKtmMz+VRJUXaZV4ESpHs9hwqS3fikZbB+/q7TwwWhoXrsqaV15HD7cj4jbSS7LTf2zjbe3YIM8mnoO3xN9NSU5wmefzbT/dRgsHv5GWAxvh3c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBxcQb29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24DAC4AF09;
	Tue, 19 Nov 2024 17:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732037229;
	bh=DaA+xZ+OZeK05SotfgPNfTPRkNsT8TPkrpHepr+rIvE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UBxcQb29tAr7n2K7HH7/HhMJmwaW67adu0dNvOU8oWiYH5Zmh4MbSzxB0fOfVid5m
	 8S/jKfVEklCUMzRwdvpgQL8g91sPKsjfNzcPWMoIfDNrsjEbuh2gxMqVbNEXpsd0yP
	 qdC6D65fS+LTU3BIHTZOHwUPAoz6P7AR4gWZROuXkkR/XTqpjVCWTCnRHc8QDqCVhX
	 Urrtw+fS3zCR0H1iL3oxzLCRlksFnTC656zrgjc+U1dFJgZJ2HlCka+m033h7ttNO8
	 cPdUgvwR+VlJPs/FYYj0CoAH6GuUY6Y3rKiiCQkqYxPNq7k2PjJVqplrNt3lFKCu2s
	 R6pYvz2xOT9dw==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ea339a41f1so38256137b3.2;
        Tue, 19 Nov 2024 09:27:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVNGqhxucAN9kRX0ZTYWHkbaacJHJ3uFbwAwfM3WA+oO3djbmBYFFUiY4qXzCOT+da6On13y/2VFWKYR3rD@vger.kernel.org, AJvYcCVfomINOHvr47uzxV+WGjHse1bVP+CtK7bOeD9MwIHYzrB993gPT9MEyvqK+cfKLoqfO9pVh70w9Fnk@vger.kernel.org, AJvYcCX+XeslPu5jo7dcNAvvmqIZCAOf2qVcf93xLcdRj4cKiuR0Krb908kxW4nnWQtOlqDl2XzDfa7x09uz@vger.kernel.org
X-Gm-Message-State: AOJu0YwaBK7PifidZmtp4tSDU66RD1y3NYHCWIODb0decXlN3QnVM2zs
	Sj/iVJ4Ilhg59ovM+tg9j99eH0V4yMnlcO5LiHc7mJp/niOssOOgUhkW7GdskGk4IMOb+Vhs2Z8
	bNbe2QTz/2wPgBGIQIEGKnMv+2w==
X-Google-Smtp-Source: AGHT+IHkteJ/psAzQJmr8xucfqpuL92nsGtTyCx9eKYX8nx+clTDPGwCQ1VJMa6h1sFnHAnY6yxduBndo5IYsN6W3C0=
X-Received: by 2002:a05:690c:dc7:b0:64b:5cc7:bcbc with SMTP id
 00721157ae682-6ee55c56725mr180226977b3.32.1732037228801; Tue, 19 Nov 2024
 09:27:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105213217.442809-1-robh@kernel.org> <20241115072604.yre2d7yiclt5d3w5@thinkpad>
 <CAL_JsqLkVUSgL-r1YvdSOTQGeN0r4Co=NRxvX1WL6q6yt0zN6g@mail.gmail.com> <20241119170421.xxku2gkp3wea2xvf@thinkpad>
In-Reply-To: <20241119170421.xxku2gkp3wea2xvf@thinkpad>
From: Rob Herring <robh@kernel.org>
Date: Tue, 19 Nov 2024 11:26:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJY43z5exVft4vYvbrMSoVFFD4E7KVJ+isC1mdQ5H3=CA@mail.gmail.com>
Message-ID: <CAL_JsqJY43z5exVft4vYvbrMSoVFFD4E7KVJ+isC1mdQ5H3=CA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: PCI: snps,dw-pcie: Drop "#interrupt-cells"
 from example
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 11:04=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Fri, Nov 15, 2024 at 08:07:07AM -0600, Rob Herring wrote:
> > On Fri, Nov 15, 2024 at 1:26=E2=80=AFAM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Tue, Nov 05, 2024 at 03:32:16PM -0600, Rob Herring (Arm) wrote:
> > > > "#interrupt-cells" is not valid without a corresponding "interrupt-=
map"
> > > > or "interrupt-controller" property. As the example has neither, dro=
p
> > > > "#interrupt-cells". This fixes a dtc interrupt_provider warning.
> > > >
> > >
> > > But the DWC controllers have an in-built MSI controller. Shouldn't we=
 add
> > > 'interrrupt-controller' property then?
> >
> > Why? Is that needed for the MSI controller to function? I don't think s=
o.
> >
>
> No. I was asking from bindings perspective.
>
> > Now we do have "interrupt-controller" present for a number of MSI
> > providers. I suspect that's there to get OF_DECLARE to work, but I
> > doubt we really need MSI controllers initialized early.
> >
>
> Again no, for this case. I was under the assumption that all interrupt
> providers should have the 'interrupt-controller' property in their nodes.

Yes. What interrupts is the DW controller providing? Only the PCI
legacy interrupts which are optional. An msi-controller and an
interrupt-controller are 2 distinct providers. An MSI provider is not
an interrupt provider, but an interrupt consumer. Some bindings define
both, but I think many of those cases are probably wrong.

Rob

