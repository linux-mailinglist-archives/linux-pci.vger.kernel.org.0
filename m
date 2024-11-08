Return-Path: <linux-pci+bounces-16339-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A11E9C2184
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 17:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0C22867C3
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 16:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8298A86250;
	Fri,  8 Nov 2024 16:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5A5yZT1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E44784A3E;
	Fri,  8 Nov 2024 16:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081823; cv=none; b=luiGfxlOKSOnBGSjVSeo0bqednajaKgnosFqHpz0fUWVPgivatN1+DRjKelujfkdOHpdO+gcsbAAvWG5+HIJ8mQ4sIrKfwUMZAM7j3yaLLqZKXjdTsJ6OLJD/Jv4oqg7/z7msQtznRvfYGfZzXHmk3lrG1nAYwAdoCJdA7ToX30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081823; c=relaxed/simple;
	bh=maMZkEugr9XaHE38h7W9LihVbwTF3bu+pXRtcFwJZn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9MQ9urlgkvwA/6hqIRY8wrnDwjW1q19zbScl6X8PKnSanPLUCjC22ZRuDBU9WHHk8yiXjWykxFuXH2FqTpLvqP14ekq411KqelEBuZRkNpxVEVU7VQWUjtBX8O4n5Z57OufQ5+1tlKn7j3Krmnjz0qMQeZSYpKABAsgtMYk/iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5A5yZT1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A23C4AF0B;
	Fri,  8 Nov 2024 16:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731081823;
	bh=maMZkEugr9XaHE38h7W9LihVbwTF3bu+pXRtcFwJZn4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s5A5yZT16dxdKIQzyyfIHAEJywy0ymtVJT/p2XBKpcRvGNXwNPwKfmSHkmMBV+VLE
	 7MDgtslW1h2LyFTDtKCeoBHxFHWq1DE3/OygRaNRe48Uptm+hT2iGRsmgGqkxMGTLO
	 g1AnmeHI/D3QCGLTjp57CPHfRU/qzFJPdI3coalOXsZN2aysPoJAUkfAOuFpyY+go5
	 bGZ6qLXihovzRTxfQwevNhod9uT3tw6QSle/ixHAmkdzPhjbTlFq5EiAVjYYKiXAKU
	 Tj4/EYzXqYkzzpkIo8DZL+WsqCvtlNkoITyyNbzy2uyGm8iR6GN1/+Mj3oIS4fwEFy
	 sqZ3otD3WMnBA==
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e30d821c3e0so2294958276.1;
        Fri, 08 Nov 2024 08:03:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV001P4iQivTPhaKugy16inA/w7G71nAowZeKYjnhDkQPsB+R5a3Zd7x18c83NK0h2k/ua2/g/JaeNh@vger.kernel.org, AJvYcCW1LKsUHK/VlB4nPYqlQPEEq3N9OFKGp7WYYKIyZuW2Yd6rd5UhRMEebj0Af2xpEUmijJg8uvK5YUEw@vger.kernel.org, AJvYcCW9vpIN0MX9XXGm5DvIaeajOtYz26q9bDF1XvYMHpqwuyCdpqvzQOmEkUYjsJGxk4Ah7ocksjG6QFKHkBkQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1lxCKc4UhlVLCghOIfVc65KYjcngUqTT1Nsnp2m7BeL0FfWGN
	EbulQLjLDPOLicz5x4uuWDd32kg0Vz1mMCGhj5sVwgxwSLKfHTqHXfAeoPiwsq1N5+rBm1XJ6rn
	effJj9AW7k7YPPJ15kcsaGTVJXQ==
X-Google-Smtp-Source: AGHT+IH2U9EUnCV98zgKoRRMSggJstFM3Mb3m+gw5EJ9rqdsBqYdZQCvPu7KqnlK3tLQNCNIxdGvFFXJXrU2mmN5zSg=
X-Received: by 2002:a05:690c:4d05:b0:6ea:7c35:e2ab with SMTP id
 00721157ae682-6eaddd94216mr40875087b3.15.1731081822222; Fri, 08 Nov 2024
 08:03:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108143600.756224-1-herve.codina@bootlin.com> <20241108143600.756224-6-herve.codina@bootlin.com>
In-Reply-To: <20241108143600.756224-6-herve.codina@bootlin.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 8 Nov 2024 10:03:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ-05tB7QSjmGvFLbKFGmzezJhukDGS3fP9GFtp2=BWOA@mail.gmail.com>
Message-ID: <CAL_JsqJ-05tB7QSjmGvFLbKFGmzezJhukDGS3fP9GFtp2=BWOA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] of: Add #address-cells/#size-cells in the
 device-tree root empty node
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lizhi Hou <lizhi.hou@amd.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 8:36=E2=80=AFAM Herve Codina <herve.codina@bootlin.c=
om> wrote:
>
> On systems where ACPI is enabled or when a device-tree is not passed to
> the kernel by the bootloader, a device-tree root empty node is created.
> This device-tree root empty node doesn't have the #address-cells and the

and the?

> This leads to the use of the default address cells and size cells values
> which are defined in the code to 1 for address cells and 1 for size cells

Missing period.

>
> According to the devicetree specification and the OpenFirmware standard
> (IEEE 1275-1994) the default value for #address-cells should be 2.
>
> Also, according to the devicetree specification, the #address-cells and
> the #size-cells are required properties in the root node.
>
> Modern implementation should have the #address-cells and the #size-cells
> properties set and should not rely on default values.
>
> On x86, this root empty node is used and the code default values are
> used.
>
> In preparation of the support for device-tree overlay on PCI devices
> feature on x86 (i.e. the creation of the PCI root bus device-tree node),
> the default value for #address-cells needs to be updated. Indeed, on
> x86_64, addresses are on 64bits and the upper part of an address is
> needed for correct address translations. On x86_32 having the default
> value updated does not lead to issues while the uppert part of a 64bits

upper

> address is zero.
>
> Changing the default value for all architectures may break device-tree
> compatibility. Indeed, existing dts file without the #address-cells
> property set in the root node will not be compatible with this
> modification.
>
> Instead of updating default values, add required #address-cells and

and?

>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/of/empty_root.dts | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/empty_root.dts b/drivers/of/empty_root.dts
> index cf9e97a60f48..5017579f34dc 100644
> --- a/drivers/of/empty_root.dts
> +++ b/drivers/of/empty_root.dts
> @@ -2,5 +2,11 @@
>  /dts-v1/;
>
>  / {
> -
> +       /*
> +        * #address-cells/#size-cells are required properties at root nod=
e
> +        * according to the devicetree specification. Use same values as =
default
> +        * values mentioned for #address-cells/#size-cells properties.

Which default? We have multiple...

There's also dtc's idea of default which IIRC is 2 and 1 like OpenFirmware.

> +        */
> +       #address-cells =3D <0x02>;
> +       #size-cells =3D <0x01>;

I think we should just do 2 cells for size.

Rob

