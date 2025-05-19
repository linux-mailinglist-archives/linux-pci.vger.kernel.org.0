Return-Path: <linux-pci+bounces-27992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CEBABC198
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 17:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4BB23A74C6
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 15:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB15283FEE;
	Mon, 19 May 2025 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7m+R5C/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C48F1D5AD4;
	Mon, 19 May 2025 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747667063; cv=none; b=JmM0Kt6jW/oHXUvbVH9HpZSS9EaINIfFwfs0FmKkv0fcCcENStEFziYm37Ue+3ZSoFDdwffa8AhG4vud5M4nmyHDkJrNT61PLG2AeaCkcKi/qedBy5TKH5mX90nhADA1AdAg0CRn12C6ia+TJA5lKAz4wvhb9YPK9x10p6Tnt9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747667063; c=relaxed/simple;
	bh=nAKO8OGKF4AztbuJv40zpDcb5wqiwnzv4Jv2Yx8mPxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJTkM0QipSL/oS9APdapYbzdtga+Z75FBmdoMyNP+F4BAGgM1bt3/xTfkZKoamQPM8S3M05DsW9nE1EBsThzyfVShaeYFvRtL7CYBoi22UZTZ45ViJ+DxXA0NWxQMJZWEVqYKqwMrzrvPQzQ1/5g+DjToQUFUEbtLXUn+deW5K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7m+R5C/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FACC4CEF0;
	Mon, 19 May 2025 15:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747667062;
	bh=nAKO8OGKF4AztbuJv40zpDcb5wqiwnzv4Jv2Yx8mPxM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N7m+R5C/jhx04v1Ku24Up2mCG2BgcATKFVraI7sIUo7XAP8u2dbPtlv7vuRw62vlY
	 /8w1gYzG4m1CAMDzFMPiA6++CPaui6KCJRuc9SQiDWSyxz8U+TGzg+Wz+2wijWHeJR
	 pcbDFfSFXeWMUJFp94GP30An33VJ7g5GxaFCwVELPKRUgWACMTu+FJMQgI+PEYZXY4
	 B65fte8czpFnla/yA2iZ4Qp657HKfk8Q5nXa23Cvx/H/zYzumLQJqixh9DI5wocQRW
	 96EjH6KJRzUJL+SRG7gl/Xtdkbkl1f4JAMelVxLM9quBPIcbqwh3SfxD8NvCASyYhW
	 oDxBWY7VKxX7g==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad56829fabdso213549966b.1;
        Mon, 19 May 2025 08:04:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjjXTAxyHI9sNPqmkymLeG7HkABwMeOxIyMYfgrQpeX5scGkIXt7OqE0wzolcwIpmfi5k5eV5Yb7IsgAZv@vger.kernel.org, AJvYcCWGaHlHldxWs4GxcrYGJ5iMfSh/+G902dtXCARczgW6QCG3ZkhtOCBjAlUSRqT3JbS6HC95+0MP6SXD@vger.kernel.org, AJvYcCWVVBtivOTYE3/TWgWhsZkz6o69QaGJ22CJ+bCBVc6iO2Q/JF9mu3b8aEn+VnPzck89J/k3D5LO5OObtnkqpHXakpY=@vger.kernel.org, AJvYcCWZPGBHvGSOMF9S9w404Or1RKllr4/YVx6/M55klam87MQ97wK1CiSdNpXsnH7dY0RBlWTDCNvGk9Vk@vger.kernel.org
X-Gm-Message-State: AOJu0YyxY2iAa+Rrotuyj8x90fGJcKJbtfh5F0vrKsQMztYgD5hzs1oK
	2d+ZAq9rAK35++vCAYm6Mixluzls1ls53hMs5gPHJQdEVhfAMeL4D8y7TbAkpbu+4EVuxC1t7L7
	98b+QotkBolnpPKlmxIVexkKozGBEAg==
X-Google-Smtp-Source: AGHT+IGkl7mO31GpM00ETtQQyjB2apn3OWsMMvOjL6selmU0XxKcDg4XZbV6haY504eFAB8x2LaMP/Ud26Cg5eKnkMA=
X-Received: by 2002:a17:907:9624:b0:ad5:59c5:a50a with SMTP id
 a640c23a62f3a-ad559c5e012mr679198866b.41.1747667061193; Mon, 19 May 2025
 08:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250406144822.21784-1-marek.vasut+renesas@mailbox.org>
 <20250406144822.21784-2-marek.vasut+renesas@mailbox.org> <2ny7jhcp2g5ixo75donutncxnjdawzev3mw7cytvhbk6szl3ue@vixax5lwpycw>
 <84cc6341-a2c1-4e3c-8c9e-2bc6589c52a6@mailbox.org> <ne4injlr4nwvufjdg7uuisxwipqfwd5voohktnbjjvod5om3p3@eriso5cw77ov>
In-Reply-To: <ne4injlr4nwvufjdg7uuisxwipqfwd5voohktnbjjvod5om3p3@eriso5cw77ov>
From: Rob Herring <robh@kernel.org>
Date: Mon, 19 May 2025 10:04:09 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+GdeKFPVpEOz+588QxkF-Uq=oNF5WJU+TK31Q6mkqaDA@mail.gmail.com>
X-Gm-Features: AX0GCFuM-ijojC5S5c880VBpsAMf0vcAyjr7rPNQjkwKwo82o_lhFRSIQX6xj28
Message-ID: <CAL_Jsq+GdeKFPVpEOz+588QxkF-Uq=oNF5WJU+TK31Q6mkqaDA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: PCI: rcar-gen4-pci-host: Document
 optional aux clock
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-arm-kernel@lists.infradead.org, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Aradhya Bhatia <a-bhatia1@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Heiko Stuebner <heiko@sntech.de>, Junhao Xie <bigfoot@classfun.cn>, 
	Kever Yang <kever.yang@rock-chips.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 6:57=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Mon, May 12, 2025 at 10:42:20PM +0200, Marek Vasut wrote:
> > On 5/9/25 9:37 PM, Manivannan Sadhasivam wrote:
> > > On Sun, Apr 06, 2025 at 04:45:21PM +0200, Marek Vasut wrote:
> > > > Document 'aux' clock which are used to supply the PCIe bus. This
> > > > is useful in case of a hardware setup, where the PCIe controller
> > > > input clock and the PCIe bus clock are supplied from the same
> > > > clock synthesiser, but from different differential clock outputs:
> > >
> > > How different is this clock from the 'reference clock'? I'm not sure =
what you
> > > mean by 'PCIe bus clock' here. AFAIK, endpoint only takes the referen=
ce clock
> > > and the binding already has 'ref' clock for that purpose. So I don't =
understand
> > > how this new clock is connected to the endpoint device.
> >
> > See the ASCII art below , CLK_DIF0 is 'ref' clock that feeds the contro=
ller
> > side, CLK_DIF1 is the bus (or 'aux') clock which feeds the bus (or endp=
oint)
> > side. Both clock come from the same clock synthesizer, but from two sep=
arate
> > clock outputs of the synthesizer.
> >
>
> Okay. So separate refclks are suppplied to the host and endpoint here and=
 no,
> you should not call the other one as 'aux' clock, it is still the refclk.=
 In
> this case, you should describe the endpoint refclk in the PCIe bridge nod=
e:
>
>                 pcie@... {
>                         clock =3D <refclk_host>;
>                         ...
>
>                         pcie@0 {
>                                 device_type =3D "pci";
>                                 reg =3D <0x0 0x0 0x0 0x0 0x0>;
>                                 bus-range =3D <0x01 0xff>;
>                                 clock =3D <refclk_ep>;
>                                 ...
>                         };
>                 };
>
>
> and use the pwrctrl driver PCI_PWRCTRL_SLOT to enable it. Right now, the =
slot
> pwrctrl driver is not handling the refclk, but I can submit a patch for t=
hat.

There's another discussion about PCIe clocks here[1]. Seems there's a
variety of options here with spread-spectrum layered on top.

Rob

[1] https://lore.kernel.org/all/20250425092012.95418-2-cassel@kernel.org

