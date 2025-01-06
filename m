Return-Path: <linux-pci+bounces-19335-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 208F3A02656
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 14:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1F121885863
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 13:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3FB1F5E6;
	Mon,  6 Jan 2025 13:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeuS1ZYz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8BE23A6;
	Mon,  6 Jan 2025 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736169475; cv=none; b=Dkh7mqIYi65/3PwYAzX/osSDas17HWB8nUgtnraLbVl7JleO0Tt0FP8aaeoSPv1k6+T20eX0IooSJIykKkkrNVQDyWrhwM9T4/Sc20anWqyU4zKbBw/BfBx44GWAQE5o2ln2qLxBiCGOJKDUlZfDDfRc7jKbDpYYOONKRvwb2bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736169475; c=relaxed/simple;
	bh=YIImtwtZH5SKw14XzKVyMgDBI//I/aBh3ePe8zFyIVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fCl3MFdCJ1npiSv0Db0lAPtU/+rvBTFdq2rs4yZepDWiF7+uZr1zhD7YloPX7qZTX1M6Mh7FnXS57pooDeOqkBs71YOG7Un1PgCiktgfc8+f42WZkBIik2cI9lq42rREX71HD1qkJsqv9opSAGaB5BcsRYM9Nc66Mh/N8k5fDvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeuS1ZYz; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5161d5b8650so4412110e0c.3;
        Mon, 06 Jan 2025 05:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736169473; x=1736774273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSoVteyukTqX+i5Oj3dGp3+dNiqvEeX8i0bxDc2IFb8=;
        b=DeuS1ZYz3jPS7z8GBiYt6JQ6+LNL8O7uF2gnegnmgFPeppqk2+Dzv4aDQerNCqA8L2
         IndDYPlefZbZEA6B/41+Z8rymRAlMYQexFZJxdZBcE7spMSWxHbKLGA45+vjHMwr+uIy
         /pXVbnwQimFOULDt6Hu5obHS8PCTGDGV681LMwmQujHEvjxsuMbSsex7GrhU0z7/vscw
         BZ8rzGbGcnYqg2JQ6oU1sBQp4wzHauXj70XJ2i+sBUlyi3pni2T5FJg44BPWKTihroNM
         ZPk2vBw63KQn/EaqR3bcxrPXlfofR1OJ5c0V/ZqQo+9ad6tmpvglnAlKzdmr5GHsQc7e
         JfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736169473; x=1736774273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSoVteyukTqX+i5Oj3dGp3+dNiqvEeX8i0bxDc2IFb8=;
        b=QzqfdlFQb67GBcxx1xmp852250QqHWUq9tpC3x5irQ0gDh09my4QE7w1I+IyOO1+aF
         icb1OCOHecCPc8HuW2DAy6e2OB15SoCVRVecJfvPIK0H89ckvbCjKMyUbeLrNS2QmgZO
         vhNoGNa3JSM3z4P1k8KEYR/6hVZUDeyFbd0wxu/dZfAQZHVODmJOGA9FGYnT3lrHe8kx
         wDj8Otp86+8C6+RkcZ2xlj+OfsDv8+1TM0iRy/uNb6BGzVb8A8fdjWUj7gdUIcJftTVA
         12c3KVxNk6NPr6JizLfOmurInrO0nK2sjOWjh+KhTXto5gO2dwH3GXiC4NDFlweHvJBe
         IUpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOXr/qIhW2PDiV98Fp7VG+dHmnt08cyA01Jr+Dr8ncgVxXS8wd1YBPGdPsqdtOaG0ySNmPV0TX8V9AD4yJuvr3EoA=@vger.kernel.org, AJvYcCUR7A+C7zGQmktD0agBSfXbdeHcKYnNEe269q7/LjQuRapT2gQGiAVymU9yQF+rHvvX8lKHr+Nk5TrBK4c=@vger.kernel.org, AJvYcCXwBbyT4XnraKk/gXXh3l/85nCVVJZkvUfJD3A5aakBEm0rKcDrik4/Ta0A0MvXc47hlb3nWkuCVG4G@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoc27Jq/l7fglEy5fpruFTNyh7PZK7+GkPLN5qEqFrB8llNqO2
	ddOM/e9fi2AewHYNpotE4qf/fKUrVCJiq5RqN7JqVRDR6QNkYLPCtvW1xyNvozUAnXT3zK9nmNo
	nYXIwXzQgCLaqyQH1IDlkCjaZCvI=
X-Gm-Gg: ASbGncsNwKOEQO/WPmc/s2gx5lM9RKRTc6TQWDIaic9gCuQ8OjpdM1bH47YFs1/lAR/
	X6rLfKlBY8jyf8H72PuN5x+P5Sl9h1owNgYCEyKw=
X-Google-Smtp-Source: AGHT+IFx4uyN3y/BjQQatnfGrDSvSpAxvuCIlhGWGcM+B4yjcozgFUkBTXG6XBq3araC3fFpuIq/CO9AvQRkQS9pWhU=
X-Received: by 2002:a05:6122:438c:b0:518:865e:d177 with SMTP id
 71dfb90a1353d-51b75d3fc5bmr39679404e0c.9.1736169472668; Mon, 06 Jan 2025
 05:17:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5f8d43fe-25e3-450d-b5c2-2d69b9bc9923@omp.ru> <tencent_6F826F87DF787845466AE67AEFF37E073E08@qq.com>
In-Reply-To: <tencent_6F826F87DF787845466AE67AEFF37E073E08@qq.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 6 Jan 2025 13:17:26 +0000
Message-ID: <CA+V-a8ve-kJoeRgS=kmzBbO_qX2nZ60WH0syMb7MEc9pHp9+9w@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: rcar-ep: Fix the issue of the name parameter when
 calling devm_request_mem_region
To: kingdix10@qq.com
Cc: s.shtylyov@omp.ru, marek.vasut+renesas@gmail.com, 
	yoshihiro.shimoda.uh@renesas.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 5, 2025 at 6:03=E2=80=AFAM <kingdix10@qq.com> wrote:
>
> From: King Dix <kingdix10@qq.com>
>
> When using devm_request_mem_region to request a resource, if the passed
> variable is a stack string variable, it will lead to an oops issue when
> eecuting the command cat /proc/iomem.
>
s/eecuting/executing

> Fix this by replacing outbound_name with the name of the previously
> requested resource.
>
Fixes: 2a6d0d63d999 ("PCI: rcar: Add endpoint mode support")
> Signed-off-by: King Dix <kingdix10@qq.com>
> ---
> Changes in v2:
>   - Fix the code indentation issue.
> ---
>  drivers/pci/controller/pcie-rcar-ep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
With the above fixed,

Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controll=
er/pcie-rcar-ep.c
> index 047e2cef5afc..c5e0d025bc43 100644
> --- a/drivers/pci/controller/pcie-rcar-ep.c
> +++ b/drivers/pci/controller/pcie-rcar-ep.c
> @@ -107,7 +107,7 @@ static int rcar_pcie_parse_outbound_ranges(struct rca=
r_pcie_endpoint *ep,
>                 }
>                 if (!devm_request_mem_region(&pdev->dev, res->start,
>                                              resource_size(res),
> -                                            outbound_name)) {
> +                                            res->name)) {
>                         dev_err(pcie->dev, "Cannot request memory region =
%s.\n",
>                                 outbound_name);
>                         return -EIO;
> --
> 2.43.0
>
>

