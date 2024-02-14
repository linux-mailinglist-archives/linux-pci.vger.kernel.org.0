Return-Path: <linux-pci+bounces-3453-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BE9854C94
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 16:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3982281087
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 15:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5A45BAC2;
	Wed, 14 Feb 2024 15:24:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F265380F;
	Wed, 14 Feb 2024 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924256; cv=none; b=RQFBMAuiKR4bxkuMkbpCUegbPR/cwQwSQQaRP8DLg/acpdDGFzKIEMSv1Vu4CB5bWnMOG1EQve4P9mo4u8waDiXQSW1fiFsK42UrGwwxNonlQxcKvlz+CTwXULi0Wu1/nrJ6jA6M7U2mnJd8/epYmMX6797pT7XBOnig2XSxjqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924256; c=relaxed/simple;
	bh=z22C5eDDUTTe9szBWz3omteky29rE85KJIvfgtvFM8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OaXLynvqviClMhmGOhIYcN7CIcvBvHrDv4H/FhA2Etm/ajv8de0e+OCDR28F88MGxGpRdiRQF5A1f1A73mCLwLm+2Nn8RLkqZeLtmELEZiqPTv7J4n3HsqNlGRqaXMVp0ph5iUM6FF/RedKpj48HGTp2cRf3RV+iKTf0uMlvzhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so5369935276.0;
        Wed, 14 Feb 2024 07:24:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707924253; x=1708529053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4LBEo7R0hSPIqQp/A3corERzBFJ1CJEW7Ujl6/XLAg=;
        b=X1WcoWWLOyRkZz3Zw85mC4n7BNl9PHbku+MzBCAlzXFLe43mPvn/ylvHaXS/1Umfc6
         T+wdAhWZ3SiqcRj0VZt4oiddKjFHf6JDGR23tc9TziSXe1zzmCQiZ2IMhKhN2hsQM17i
         7OtTfRQLCa0WxfkZN7SlMHfxukm0L3OdrCQIJkwJ9gJsM2lA3D7QNknudEkBnKylJSNJ
         a1g6x00O4vVmqx6sK7Q9FEBmKIgixPyv7q3c9sgam31xAJfpRcmCeRMftxAJABXBrcJb
         YteOKX+LLDu/8f04MdQbmXTH5l5HOJ/FcKS2qPrkn3UbmlyKiFGZAflO40GDeoo7GRXB
         C4TA==
X-Forwarded-Encrypted: i=1; AJvYcCX0zpgyW9rDJiw8IU4u2NEMYMEbmVa7wf6esWzAml3EdTsPab52mycZNo5c7ULPEPxvvMfQ/mNWOdu1ij455/kp96x7LK+K2kw9WAQX7JBv79nAgJnES3AP4F2JqDou5cgUPCyFWxoEjJePvLM=
X-Gm-Message-State: AOJu0YwANJWRF8AI/1r0DINgvWOhOAcn3k7orDCfxCwR8g2qb2Qf0iNx
	1zucasT2ed7nl9F7OhspVWdSHqhUuLeWf4L0gpqSrmqSrkjUdfFJ01ms0f/OZwI=
X-Google-Smtp-Source: AGHT+IEoadSLdEc/PIGiaHIS7TbjN3O5MPLjcEDFc6TScPymW1rofaB0zaCuAzdBwTc63Wh0hoYF4g==
X-Received: by 2002:a0d:db83:0:b0:604:93a9:386a with SMTP id d125-20020a0ddb83000000b0060493a9386amr2598751ywe.39.1707924253145;
        Wed, 14 Feb 2024 07:24:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWMPhaT/ihWaDMu5B/NIwPtdwFaxUhwTvK26FU758NQNzG041dON8sDQ3KIZf9uKvDHnul5Dxn6+Sl4IuC9NAuaskWVtsGjskLzLAnzntgSjAEO9E7hMTCG8Cxl981SQMJMRGwZ0SjszLlYv4=
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id h84-20020a815357000000b00607b5cb115bsm133185ywb.51.2024.02.14.07.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 07:24:13 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so5369906276.0;
        Wed, 14 Feb 2024 07:24:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUTnFEBeFKrylLBIMWGyEvLa87YgYh/LhI6Rg8zxziHHl2x0r95H580jTkbo9MP6g5VdN+cACgeSIZ5qThNwYnXqYrQfIXUS97+o1bK1RH8asPWL7H2wzLtErk2mPSX4JBCdw4ga8vv89/lYKM=
X-Received: by 2002:a25:2183:0:b0:dc7:32ae:f0a with SMTP id
 h125-20020a252183000000b00dc732ae0f0amr2428175ybh.65.1707924252702; Wed, 14
 Feb 2024 07:24:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214052122.1966506-1-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20240214052122.1966506-1-yoshihiro.shimoda.uh@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Feb 2024 16:24:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVBCEV_MhqU8CHBSdMecYAgktwOaxwn_KmZjsf0y8rhHw@mail.gmail.com>
Message-ID: <CAMuHMdVBCEV_MhqU8CHBSdMecYAgktwOaxwn_KmZjsf0y8rhHw@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar-gen4: Add vendor-specific registers' setting
 for MSI-X
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shimoda-san,

On Wed, Feb 14, 2024 at 6:22=E2=80=AFAM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> This controller with GICv3 ITS can handle MSI-X, but it needs
> to set vendor-specific registers by using the MSI address value.
> To get the address, add .post_init() for it.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Thanks for your patch!

> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c

> @@ -297,6 +304,25 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_r=
p *pp)
>         return 0;
>  }
>
> +static void rcar_gen4_pcie_host_post_init(struct dw_pcie_rp *pp)
> +{
> +       struct dw_pcie *dw =3D to_dw_pcie_from_pp(pp);
> +       struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> +       struct irq_data *data;
> +       struct pci_dev *dev;
> +       struct msi_msg msg;
> +
> +       if (pp->has_msi_ctrl)
> +               return;
> +
> +       list_for_each_entry(dev, &pp->bridge->bus->devices, bus_list) {
> +               data =3D irq_get_irq_data(dev->irq);

If CONFIG_PCIEPORTBUS is disabled, data is NULL, causing a crash below.

I haven't found where exactly the irq data is filled in, and don't know
where/how the dependency on CONFIG_PCIEPORTBUS should be expressed.

> +               __pci_read_msi_msg(irq_data_get_msi_desc(data), &msg);
> +               writel(msg.address_lo, rcar->base + AXIINTCADDR);
> +               writel(AXIINTCCONT_VAL, rcar->base + AXIINTCCONT);
> +       }
> +}
> +
>  static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
>  {
>         struct dw_pcie *dw =3D to_dw_pcie_from_pp(pp);

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

