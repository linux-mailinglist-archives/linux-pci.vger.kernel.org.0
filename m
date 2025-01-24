Return-Path: <linux-pci+bounces-20341-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076F1A1B848
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 16:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DCB3169164
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 15:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEA686352;
	Fri, 24 Jan 2025 15:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LS0NeLy4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254714206E;
	Fri, 24 Jan 2025 15:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737730903; cv=none; b=TVkj9wxIAJ+YNDqz/1ancmgmnU0pbEdDqwgkhStDlRIoDJHKwbh4fhrrlr2n9NBvd5saFpS3wRK+F+e0dSq/rKcyxnBlPrcuVMabNw0NJRpByR9yIENZbqSjAbiIFKGP6T8YUlBnCryplSrwpmged3NBDXMVSP4kNel1jjf9zM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737730903; c=relaxed/simple;
	bh=+sKWvutBnhoT3u6vmgXqQEluf5+44IlXaH1XhyuWoKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUgTbKgCVr9qCGRMXfrBcfBFQvpOw7yiAao1xiy2aRfNNmZ8+P163Tv/gYVMqB7PR0Fux3xXSebkgvxgnGly4IIpDzOry71wRO1HsNGWub9rHZ6rOdKihkxN749kUpipb8S4kP1LlyDmc+1uTMHzeGqFKpxrOiCUnqxUoxMAJho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LS0NeLy4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A7DC4CEE6;
	Fri, 24 Jan 2025 15:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737730902;
	bh=+sKWvutBnhoT3u6vmgXqQEluf5+44IlXaH1XhyuWoKg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LS0NeLy4JLmappwJK6o68N9jqtBZ33UoCKaSLDeeVV/9kAazwpqRTXPYTdC1edHsJ
	 AiErkPb0Oeb/il89/iHADnjfwHVJhajZAkMac3uoL+L6YLCPecp8SqtYlntWmjrU+S
	 cJYab8rsCptKvAYl6vuk3Ctx/A+crPv2a5Dztua36MMnIKdBMjVckAzs2KYSNZM4+u
	 exdObxrolbGYdEg40/HB5YVZiDJRYXDYR8i+B0S1aj9OokQxfYq3UPNTR89QxiUiqM
	 ur19ovsnnhUk185L5jyTLu4Tss/1G5ykNDsPjiyj3kknkB7PhZ7FJqFWfluEXoRadv
	 As3fy0g3Z8vrw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53e384e3481so2060967e87.2;
        Fri, 24 Jan 2025 07:01:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWKkMRBeRpPlZwmZoVEcYKxxvQJahwTh/WWPyZ0dPCtEu1IwVzK6I/4dAcWnH5rjJLq+CwL+f/y3ixA/Q==@vger.kernel.org, AJvYcCWSoXuPzccw9dMDReDac/tEzCPMZUNVhEc5V3ujKSko6Gbud4xQoIesaYe/yF56vISRaPcAmxekFC9Ono/Chg==@vger.kernel.org, AJvYcCWr3l1Hq2cOzmawGdj1j5cfDTZIefSyG+2UeOLXOmp4cmfQiiktF+x7EgHRbXi0mI4X6UIiiJ67VFzeFAIELMA=@vger.kernel.org, AJvYcCXNPdL9R5BhNvDeyvivH/IrWrm2ddWxxN1y8lGMHjaU6dcPiAOgzsdOoV1DfXVCZPvq0CsWOwiHGirN@vger.kernel.org, AJvYcCXS+ab9cRGrCnrY4fUgW8oPh3rkzSfgk8ATuUo1z2JyeaI6/bzdPCMQnxbFMSStPHXx03MRXxYUh6MWYl/o@vger.kernel.org
X-Gm-Message-State: AOJu0YzdnWYKbuQebxKuBOuXc5/f3dcf4FQ7+Q7RAJQMvvFaoqTGRi2w
	/08o9/jT4Lfg0XtX0OCOrpRdsQFXtG6tXWIVBwEQkK8g/kEamDqkHKQEg/N87wV6/KossnUJwvc
	Wy36LCUUWy/EUmKx3XXXJ4FcKzA==
X-Google-Smtp-Source: AGHT+IFhSnvfCuiCvL0OttX5PAnYoRXrSbi4TViakpq1cAbRQhI69YWUaroaQ+b8YKbg+lHMfXE6iddIvuIgn3sY5aM=
X-Received: by 2002:ac2:4c56:0:b0:53e:fa8b:8227 with SMTP id
 2adb3069b0e04-5439c27b239mr12676852e87.45.1737730900608; Fri, 24 Jan 2025
 07:01:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124101038.3871768-1-krishna.chundru@oss.qualcomm.com> <20250124101038.3871768-3-krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250124101038.3871768-3-krishna.chundru@oss.qualcomm.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 24 Jan 2025 09:01:27 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJE2x7XVkVKQuECTYfrML9V2TxdVNF-=EyTBbnGUEvhzw@mail.gmail.com>
X-Gm-Features: AWEUYZlZJKsHinlSKqERUaTFlBEcUmg36ma0x9e7aGVnEsRJpf41kGM_GSo4ajU
Message-ID: <CAL_JsqJE2x7XVkVKQuECTYfrML9V2TxdVNF-=EyTBbnGUEvhzw@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] schemas: pci: bridge: Document PCIe N_FTS
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: andersson@kernel.org, dmitry.baryshkov@linaro.org, 
	manivannan.sadhasivam@linaro.org, krzk@kernel.org, helgaas@kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	lpieralisi@kernel.org, kw@linux.com, conor+dt@kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree-spec@vger.kernel.org, quic_vbadigan@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 4:11=E2=80=AFAM Krishna Chaitanya Chundru
<krishna.chundru@oss.qualcomm.com> wrote:
>
> Per PCIe r6.0, sec 4.2.5.1, during Link training, a PCIe component
> captures the N_FTS value it receives.  Per 4.2.5.6, when
> transitioning the Link from L0s to L0, it must transmit N_FTS Fast
> Training Sequences to enable the receiver to obtain bit and Symbol
> lock.
>
> Components may have device-specific ways to configure N_FTS values
> to advertise during Link training.  Define an n_fts array with an
> entry for each supported data rate.
>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>
> ---
>  dtschema/schemas/pci/pci-bus-common.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/dtschema/schemas/pci/pci-bus-common.yaml b/dtschema/schemas/=
pci/pci-bus-common.yaml
> index a9309af..968df43 100644
> --- a/dtschema/schemas/pci/pci-bus-common.yaml
> +++ b/dtschema/schemas/pci/pci-bus-common.yaml
> @@ -128,6 +128,15 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      enum: [ 1, 2, 4, 8, 16, 32 ]
>
> +  n-fts:
> +    description:
> +      The number of Fast Training Sequences (N_FTS) required by the
> +      Receiver (this component) when transitioning the Link from L0s
> +      to L0; advertised during initial Link training
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    minItems: 1
> +    maxItems: 5

You still need to define what each entry is.

> +
>    reset-gpios:
>      description: GPIO controlled connection to PERST# signal
>      maxItems: 1
> --
> 2.34.1
>

