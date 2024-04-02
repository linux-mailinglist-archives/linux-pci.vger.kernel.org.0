Return-Path: <linux-pci+bounces-5524-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 281E1894CF5
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 09:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92ED4B21F3F
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 07:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED843D0D5;
	Tue,  2 Apr 2024 07:53:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260EC2BD1C;
	Tue,  2 Apr 2024 07:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712044406; cv=none; b=ioIqcC5OOxx2AYJW5aZnnniyZjPDlOthjMsCarGXGaFEdr161QDazevBBBGr11YZl28MRzCzp722yC/gj98+/++dHRgK09KKx7wxDSuYmv9qHHwXmQ1/UpXMpdySMO5xeWJyYJzDph1fuBbORlG6wdMRdET/btBIvAOIsFsiKys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712044406; c=relaxed/simple;
	bh=T/1svwn7eYG5hqU4ksuONqBd8LRcPSNa45Gwide7yRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VimWtUxI8L5t5VTtq3xL6H8stJfB4+oNA559meSBickkqUme/nwmTga4mWY48sb6D5MkenreVuAIKSrFlpaaU4B2k5flhjNeOS0bO9At1l58J0Tftw/KLq2hGWFTm2CD9EiGU+iA/na99bcfacB/iwWPCbfLp3k7XYdctb4jDTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-615053a5252so9283557b3.1;
        Tue, 02 Apr 2024 00:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712044402; x=1712649202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWg+1fJyGKdFnvbvo2K9KM6G1mX2sB/eUJxrYUhr8+M=;
        b=lyzA/WPs29wecl7rtP///SP3XxLjtRGnSmCmGCHWvfJmD4B6WZqDuc30KmvpEAdwnG
         QVuoxCWgFEp//aobhDETaiBMCihO2xGSkU0SQS+uiYdc+b5bntiXcsFGY7P8aPUil8LT
         hMvhlVlQRlQaqWRhvDo1O6tG3MWsuJsTrWBYKnddPCEFznd7LaGcVY1usrpmzhHoYWwJ
         OCQGStb7dl7Nalk4NzenhXD8isfpqbsaoYsfC3wqxpVYi5dUCTjIFHDMlTqVlDIfOhrg
         +BDDNofYywO8sHtl5elz0GpLD6kmkvLTxRS++30xViTW6xCsTncAWMn/z0hPSK92eGpv
         kD5A==
X-Forwarded-Encrypted: i=1; AJvYcCUGsJrrjJUzXIYya5v8ldXN8UHQtVSQyE7p0cyBVAnsbm9n/l7KiCKm+RfMEGF82xb5HX8pwI/iKX9KWIbF5LFbAgGEL4HdPVowm1BRNqb3aE/1PLbuwhVzIYzwQahub1sc1DPgJrMzNXOL/R4oJe07+Bq9uxdnc5BrHIYHCsBVuia83MwQGYu3
X-Gm-Message-State: AOJu0YzVZWWvL8ETacimt2CUzh9L0lWGEj27xpOoeZsrzFSQArx6xr9Z
	ojOgPCyrwEGj+qw2mFMxL1ZfPdSnxDnPHjZN+MSJwXNGnPCqDaHA3+DpCJJMTkQ=
X-Google-Smtp-Source: AGHT+IE3jX1O5Ths7Fmq/ceI6z1EN/gU6/eW0Z5lwmGz3k8CQNRR3OUcsOXiDRSX3GpSvdNwJnqigA==
X-Received: by 2002:a81:8d4c:0:b0:611:9a26:429f with SMTP id w12-20020a818d4c000000b006119a26429fmr9101903ywj.10.1712044401893;
        Tue, 02 Apr 2024 00:53:21 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id r194-20020a819acb000000b0060a0cd01a8fsm2670093ywg.89.2024.04.02.00.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 00:53:21 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dbed179f0faso3779559276.1;
        Tue, 02 Apr 2024 00:53:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbQboyraP8p94A/x7ehONsM7rb7RAtIQs/F1nmkrGUH3NFJhTW7cY6aZwmNWzGjn6+gX61kL84WmxCdJlB4IOrbesrsDjBPV/gyM69XDt0l26UaEHC1yiuY5YQAcR9DHwNN+rituid2Fq27ICeYaVdNFmbE5LPd5QQERfWIlbkIdUxdY5LcaD1
X-Received: by 2002:a5b:589:0:b0:dcc:5b7e:ddfe with SMTP id
 l9-20020a5b0589000000b00dcc5b7eddfemr7810300ybp.4.1712044401276; Tue, 02 Apr
 2024 00:53:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401023942.134704-1-yoshihiro.shimoda.uh@renesas.com> <20240401023942.134704-7-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20240401023942.134704-7-yoshihiro.shimoda.uh@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 2 Apr 2024 09:53:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXCsye4kEP4=1rYNx97VpXHjjNg9BFawnUBADfL2ADQTw@mail.gmail.com>
Message-ID: <CAMuHMdXCsye4kEP4=1rYNx97VpXHjjNg9BFawnUBADfL2ADQTw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] PCI: dwc: rcar-gen4: Add support for r8a779g0
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jingoohan1@gmail.com, 
	mani@kernel.org, marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shimoda-san,

On Mon, Apr 1, 2024 at 4:40=E2=80=AFAM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> This driver previously supported r8a779f0 (R-Car S4-8). Add support
> for r8a779g0 (R-Car V4H).
>
> To support r8a779g0, it requires specific firmware.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Thanks for your patch!

> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c

> +static int rcar_gen4_pcie_update_phy_firmware(struct rcar_gen4_pcie *rca=
r)
> +{
> +       const u32 check_addr[] =3D { 0x00101018, 0x00101118, 0x00101021, =
0x00101121};
> +       struct dw_pcie *dw =3D &rcar->dw;
> +       const struct firmware *fw;
> +       unsigned int i, timeout;
> +       u32 data;
> +       int ret;
> +
> +       ret =3D request_firmware(&fw, RCAR_GEN4_PCIE_FIRMWARE_NAME, dw->d=
ev);
> +       if (ret) {
> +               dev_err(dw->dev, "%s: Requesting firmware failed\n", __fu=
nc__);
> +               return ret;
> +       }
> +
> +       for (i =3D 0; i < (fw->size / 2); i++) {
> +               data =3D fw->data[i * 2] | fw->data[(i * 2) + 1] << 8;
> +               timeout =3D 100;
> +retry_data:
> +               dw_pcie_writel_dbi(dw, PRTLGC89, RCAR_GEN4_PCIE_FIRMWARE_=
BASE_ADDR + i);
> +               dw_pcie_writel_dbi(dw, PRTLGC90, data);
> +               if (rcar_gen4_pcie_reg_check_bit(rcar, PRTLGC89, BIT(30))=
 < 0) {

If you would invert the logic here, you could "break" here, ...

> +                       if (!(--timeout)) {
> +                               ret =3D -ETIMEDOUT;
> +                               goto exit;
> +                       }
> +                       usleep_range(100, 200);
> +                       goto retry_data;

... and convert "retry_data: ... goto retry_data" into "do { ... } while (1=
)",
avoiding the goto.

> +               }
> +       }
> +
> +       rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_0f8, =
BIT(17), BIT(17));
> +
> +       for (i =3D 0; i < ARRAY_SIZE(check_addr); i++) {
> +               timeout =3D 100;
> +retry_check:
> +               dw_pcie_writel_dbi(dw, PRTLGC89, check_addr[i]);
> +               ret =3D rcar_gen4_pcie_reg_check_bit(rcar, PRTLGC89, BIT(=
30));
> +               ret |=3D rcar_gen4_pcie_reg_check_bit(rcar, PRTLGC90, BIT=
(0));
> +               if (ret < 0) {
> +                       if (!(--timeout)) {
> +                               ret =3D -ETIMEDOUT;
> +                               goto exit;
> +                       }
> +                       usleep_range(100, 200);
> +                       goto retry_check;

Likewise.

> +               }
> +       }
> +
> +       ret =3D 0;
> +exit:
> +       release_firmware(fw);
> +
> +       return ret;
> +}

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

