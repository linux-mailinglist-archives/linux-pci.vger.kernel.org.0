Return-Path: <linux-pci+bounces-8573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E69790326B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 08:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 016FAB2213C
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 06:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAE5171646;
	Tue, 11 Jun 2024 06:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKmetdZ2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD0A6116;
	Tue, 11 Jun 2024 06:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718087027; cv=none; b=SYpUJsqxXdCaEAMvx9hljjIE2cmWXOXX0mQsi/VEcjYSUjzUWAmEdamMJsx3CpJwWZ7ZgiGsecwAUUgAYtF4C+SJuAu13maUw6rVSsXN/BC7JOXIBL6/ljPZVxitD+3BvXYPb3cmD8y7egvV76LKT0XX8pxsoDwFVo2JxPHhKGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718087027; c=relaxed/simple;
	bh=3oXdERrdrPMLo1HeKQtJpAcKacaGUYfSyX7rnaT/4fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXwt6Dzuc9fcE3r1WiFoO7J+d1qquPEX3vmWuRkOExOJe7KaRQfuYKov9bjP8Dnf5zk9JCi+P2gjM8dPdcqX+7iG9WavxBZTD54ZBsVoYQHittZAzAgCcm5zoKvC5m2EmnKoBY5KyHyzBmpnHQummdqrIDR+DV0+Xu/fOQsXRHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKmetdZ2; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6f124e97d31so263075a34.1;
        Mon, 10 Jun 2024 23:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718087025; x=1718691825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwu883SfM/0WsE+oHlOP/+rRWsvAVxgU1/13gdyKygQ=;
        b=YKmetdZ2Iyg089nOhHk/IieAz9Me6kUM5KDiMbymc528y9gdH60t/MQ+YPTMmA3Ifq
         6UKYffQLGUynZcIsyQIro6RQJFUC6IXhcrabJOLnSXocWat/arnZurUE6zeuDnVqlffc
         UP5L52VoYTyDMoSorMU375ibTZ+5cd9g2PGoMmZz57ShvHNRmMJDzBp1yKl2Ih2VfPFy
         pr0TQwpXkeurmVwPvFP3FlFV4OBLlbpCGhndQIb43fcfsqwJUTXemfUDGuNidqLZVP+M
         S7FPguLDmmgTcCBsYWO892u+J3dEEXhAJsthRbte9/gfeBXGQxOPbnywV9EbYMAxvPVk
         bblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718087025; x=1718691825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bwu883SfM/0WsE+oHlOP/+rRWsvAVxgU1/13gdyKygQ=;
        b=gu7A986FBDB/NZV8Q/Em5YJ8R1+SRGQwaZ9Eb+h1/5hMQaubNgXIf+7axO+ONzKsDf
         nxaEGK9LrKQq2dNDZpOwW1Fsb5kpL0D6t9OVGvNwpqC1Qv2gdCKqjpTrJRkK+F4xdso4
         bR3L6Pa0OAk3fYBJmhtg7RwoNFQhRyaORvRL1o0lCwSUKc4GF8qLc9j3C8fN895R9avr
         eEjAHpu7e6g2pwhH+gKQIu/TUhh654sGOGPTHMXI34vMKlEnBjF/NEMIhaMt9zWk/7/9
         juSdZ90bt1sEymAzzfBIjozKUAigrZEfhEGTOt3eaX+RmYy5UDcuoXqdh3FSdV5ZcopY
         epJA==
X-Forwarded-Encrypted: i=1; AJvYcCXuXSeiKxnverMsxwM/f7QaZBpLc3hWsb/8coTpKJhHP8okBKnfW466WAsgOKWotsXQ/6LZlb6lXlOIQ3WbsZo1mHu4AC/XJ/sxIR2kGp7vYScCxxaFQ2M02JQ5cyZ1aX5PZEaVeEdOZ7ttf91R++V1nq12xRR8TfrZYd9e8lSQ7Th4RBQ7Qc/wOt3kPscd3k17xLXRElxMz/ASwTUq4JZSS28I1Um1CvCIQkM=
X-Gm-Message-State: AOJu0YyTtk0rBtQL2fT9C0RwNCtFc5Spo+jmq4oebA9XNHbErvU6Z+EM
	gc2WA2Q+hbyhZtb1TBG1BS2P/UgVbbM+0+VI5H1xBN55UesHQHntCrbkm6iVPGtyqK1q2kTA+9z
	2rgGhGCzPJntZiszX2Q77bsMcP4E=
X-Google-Smtp-Source: AGHT+IG7GKYBdo2VQZhbz/IlnZW6BFSpt7hnt+JU/XtiKDIa2WhrA7tPm5LdNleABOooM/PxMePl1/qMK1HEmDC+JC8=
X-Received: by 2002:a05:6870:1719:b0:254:c512:88c6 with SMTP id
 586e51a60fabf-254c5129526mr5243184fac.51.1718087024789; Mon, 10 Jun 2024
 23:23:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610-md-drivers-pci-controller-v1-1-b998c242df55@quicinc.com>
In-Reply-To: <20240610-md-drivers-pci-controller-v1-1-b998c242df55@quicinc.com>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Tue, 11 Jun 2024 08:23:33 +0200
Message-ID: <CAMhs-H--0tbqhQzsA0sEzYKET4uJADZyLPNhRBHUL8BGFvjcSA@mail.gmail.com>
Subject: Re: [PATCH] PCI: controller: add missing MODULE_DESCRIPTION() macros
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Will Deacon <will@kernel.org>, 
	Joyce Ooi <joyce.ooi@intel.com>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Marc Zyngier <maz@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Jianjun Wang <jianjun.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 11, 2024 at 3:04=E2=80=AFAM Jeff Johnson <quic_jjohnson@quicinc=
.com> wrote:
>
> When ARCH=3Dx86, make allmodconfig && make W=3D1 C=3D1 reports:

[snip]

> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/=
pcie-mt7621.o
>
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

[snip]

> diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controlle=
r/pcie-mt7621.c
> index d97b956e6e57..9989e5e614b9 100644
> --- a/drivers/pci/controller/pcie-mt7621.c
> +++ b/drivers/pci/controller/pcie-mt7621.c
> @@ -549,4 +549,5 @@ static struct platform_driver mt7621_pcie_driver =3D =
{
>  };
>  builtin_platform_driver(mt7621_pcie_driver);
>
> +MODULE_DESCRIPTION("MediaTek MT7621 PCIe controller");
>  MODULE_LICENSE("GPL v2");
>

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com> # MT7621

Best regards,
   Sergio Paracuellos

