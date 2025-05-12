Return-Path: <linux-pci+bounces-27589-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C291AB3B8D
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 17:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48C119E210C
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 15:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A40D235058;
	Mon, 12 May 2025 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYvK4ft2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9A819CC3A;
	Mon, 12 May 2025 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747062063; cv=none; b=FgAwKo0LZE48yYOzbnQZPRaXpC0MC9uGiW9CescIyeykAONI60LzxpMI1fCnTmYyTOjZWnY40K67idstjsB6LYJcPy55/B5h1x9z+ABxQNlEREWsk2BF1Ji2ozbeizYmR4FfFVFhXjgMx163H/z12/yzRntGqRiBIePTKganJHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747062063; c=relaxed/simple;
	bh=5C7uw2IAzf+0ahfXX4uyiw4RInjyFvh4Zkir6Ku/wHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fjFS3o2l+weOLkD0UsSJ6QyebVaJyHPqGyIOd5lM72ZZCqltCM0SQcmKIFO6bU3WzUhjoiDJdlkgwj7NeSTrRmJeqdsJhmKikt2X8rdaNra88mKlfDdyrZqO8LE9PKowuUmQV/SbafQElRcTCNYCmvKWizPslpiPW9pQueUtPFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYvK4ft2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786BCC4CEF2;
	Mon, 12 May 2025 15:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747062062;
	bh=5C7uw2IAzf+0ahfXX4uyiw4RInjyFvh4Zkir6Ku/wHo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gYvK4ft2GqhQv20+FT1wp5aUuEc6T1B9JqsClPd9XNOJneKgc1yFmDSf23LIZyAbw
	 2X4Bdb+dAvMrvelWtS4qmVUkXAHIqHrlMo/XelGJmbk/jHgiXfxgve41fE3vHkN3Ie
	 9PduUHH2Rv1ycZsMB7rLXT5O/SVYAk3ma1/ZqwKBJf8KNKAT1QC5dFEXtjVxRMthtc
	 U7LV5qSbK1I4eYHvdFqEmvM13kTSuC1xSeabn7mX/J3x7V8VNL6gB0hRRrFZ6HHsbv
	 8Pgw6s+yK8EOa8ZHIqjVJBMp1ugHny5zvwWfkdnZTpMZeZz83MMdSN6xD03y7iDNiC
	 bcGm0et8s6h7A==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5f6fb95f431so10753842a12.0;
        Mon, 12 May 2025 08:01:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUJ2CLrKB2JKFxQn0pSLET43AxZVFfByUFa8z4/KplHoApxhWYYGU9/uGirYqJ6fCuKc5TFWetVMZ8@vger.kernel.org, AJvYcCW6Rs//ROvR7RWINq/7U8AgpqOEUBzL0ktr9a51QOUdd9ubp84ZHpo2oQnO3yKe79LB31Js/MNqQsZG0Pd8@vger.kernel.org
X-Gm-Message-State: AOJu0YzDn0+mzdye/B4r6xHo3OpCr2+ii17+gF6Ujo9W0sEV5bUXqJE2
	ojkNPSUeYEtoV/3ZQpxRIdT4EeNtnzS+cRS1FIOKJdU9otDVouRoa4EVVCylTHutj96AIS6aZus
	VbWLL0sYPznPncBEPize+4HYE8g==
X-Google-Smtp-Source: AGHT+IFZbfWKF0hU1sr3jQtNq4U5pRwRKJjmtoMDmn21t01KNRswIOplfLvn34abEZt/poBPFf25QG0+oFit4G41q2A=
X-Received: by 2002:a17:906:f142:b0:ad2:1255:d95a with SMTP id
 a640c23a62f3a-ad21255f466mr1132229266b.30.1747062061044; Mon, 12 May 2025
 08:01:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509222815.7082-1-james.quinlan@broadcom.com> <20250509222815.7082-2-james.quinlan@broadcom.com>
In-Reply-To: <20250509222815.7082-2-james.quinlan@broadcom.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 12 May 2025 10:00:49 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKrbCtiMdxCusBwX8-xewQbi1_X6V8rTN+2vfxh4e=Hjw@mail.gmail.com>
X-Gm-Features: AX0GCFuumEiFtgCX1SqyapCoe6c8e5kN11_tTXkwoByqbbccTk1WS35qw-28a4Y
Message-ID: <CAL_JsqKrbCtiMdxCusBwX8-xewQbi1_X6V8rTN+2vfxh4e=Hjw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: PCI: brcm,stb-pcie: Add num-lanes property
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	"moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 5:28=E2=80=AFPM Jim Quinlan <james.quinlan@broadcom.=
com> wrote:
>
> Add optional num-lanes property Broadcom STB PCIe host controllers.
>
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/D=
ocumentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> index 29f0e1eb5096..f31d654ac3a0 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> @@ -107,6 +107,8 @@ properties:
>        - const: bridge
>        - const: swinit
>
> +  num-lanes: true

Why do you need this? It is already allowed by the referenced schemas.
Though maybe you don't support 16 lanes and need to limit this to
something less? I would also set 'default' if you do that.

Rob

