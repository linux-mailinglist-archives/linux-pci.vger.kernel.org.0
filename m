Return-Path: <linux-pci+bounces-29551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97BCAD718F
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 15:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B93B07AFAC9
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 13:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2C92441A7;
	Thu, 12 Jun 2025 13:17:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740B52744D;
	Thu, 12 Jun 2025 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734223; cv=none; b=djPz2oHq1kZLa2wFGWs6d4bgnSJJzm6izmkMtaCtK6E18KRMbVKrzVfwtVcXjV9P1DfywkJVaHJGBreOR5g7OGB6ltXhlM/hvI0JfRTM4gKZhdSsjcTxl9qO2qlQjZbQRAhBajhSmanjTUgUNwwkqLluLy7PDNrNhsmqJywOAhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734223; c=relaxed/simple;
	bh=k4w6XpEXch4GCu7oMZGMsN4hvcVpxo8CKqiDW6bTfUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWOjLKnbiiUlXkWCkkZGirarBaOeyuN3m9Ramrv/d5cuEG/2RQWTs33KblpDuVsAv5nPysHNszMtllImfbfF4Vv3rSs7phBJXL96o7ZMUwd8fBw99Mz+Wbq69tCSFEL9ht2zV+I5qfnmJ6m7bg95O7p35pC9c03/e7uiVr88wmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2cc57330163so624481fac.2;
        Thu, 12 Jun 2025 06:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749734219; x=1750339019;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TNonWCq6tQmbQ5Q8JG6wz2OIxHKwlgX2o++VTeBoqTY=;
        b=EoTNoCSz0afw5lpwbcGC0ld79ohtzQg3hXSS3EIdYiu/JObsI5otdeeJ8kjJ5cDA7K
         Kav5kazRlypZxpt9iH+skpvbvpF6FEP1FJKFu4v115+bZfVAUiHyNDugZsY879bOjnxI
         /rmiGqEOXAkpATd2iLEQG/CzzXEMf0Z0IAbdMLOKdQvZe/q6VF7n5aHsM+hP+E7Onc/u
         wIpdl0dHiPeZO3TS4p/ixgE8fTcnZrZkWkm8VGsWCSfg7q7QhBVkN0xIPHDJG0cB+nYE
         N7YGIARZo6KqKfbBUoxC7GU5eiXsA09KGsRian9a9oakNpRcCF1KQEYlWCxfmDmh1Cem
         WPjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH+FvWR02nRqke880uBC8fM5abm6XI8w4ijY+hDp/aj0M+b+1YzSovrrbZ19adYXDrJu2zyhxWKHy6m0zmvIdU+yo=@vger.kernel.org, AJvYcCUf3fAj83kpQ++KfeZVmGDMJUsKM/Ja6gFckeWbvp/XoLIJePVALN/RrAPvVZwdbtuJ3pvNmPmftTQH@vger.kernel.org, AJvYcCVHNPLSURwmh/bTx1AWsJid7CXx2lgnjhI1Ysh4PrlnRpekHsg7rxxZZUHam6/72uM+xS3y5c2ELKWv@vger.kernel.org, AJvYcCX0ZxZvl40gNv6oVcNF6nrC8i1KM9mFUNC9lGkfyC/Sx2FY0/dKd6adlJhek38XLQr05w7JyN+hW8YHsGOm@vger.kernel.org
X-Gm-Message-State: AOJu0YxggYUxDTghCT93JLvq0uGdfR15TQL+JE0MvAombKQ+cJL6tQHq
	4u9LPccvA4malAaaPdip6T6OKTKJgWHWTr0FkG7tBYoELd1IH7S3sB5pmMy8yx8F
X-Gm-Gg: ASbGncs4Xseb3tFFpYoUEX3aJ6JxuOiFbzIJdmUk34IGbGmXYzLU9cv0qYOq7pdQ0C5
	9Y2Fi4bjPD3xxH5RIDo5GaBoT5ZMz+YtYTb/PtTdd0xKJGtnbYnErGKOl1xuTt31iK8FwMsGIST
	cfGFN1HvvtPTjTITNmx8D2sBqexPzcdjeHhDIPCY5o2WJB15QXu3+0jZRWdcddGDkdK3LfaiIea
	L+epG7YKK6Olh6OuAMyO1eHT7HV208+gN1b7ac+5s6XgXCdFcN2mIl23mI6NkRoxhwLyuWTdCAy
	6WxPoeQ2FFYgyiGtanf6Ou7uUtNZbbXvRBo3GkmpiMth4FVZWr904BcOzjuXll/mv1Mqwwky5TT
	/XaNekJOGmJXGIgEkPqN5zczpJdcD
X-Google-Smtp-Source: AGHT+IFrc2S7d8JXsxh6+5kpeaxchbVsS6LjK7xsAVK86NxxgIJvIS7pTe2FPklIeBdpO1mSSQXc/w==
X-Received: by 2002:a05:6870:d68b:b0:2d5:2955:aa6b with SMTP id 586e51a60fabf-2ea96b7aee4mr4294786fac.5.1749734219489;
        Thu, 12 Jun 2025 06:16:59 -0700 (PDT)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com. [209.85.167.177])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2eab8e6cdbasm291000fac.38.2025.06.12.06.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 06:16:59 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4066a0d0256so593029b6e.3;
        Thu, 12 Jun 2025 06:16:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUnAEC3Ao9uHOeCTwb3roLaguny9bhdWOj2AtKHSFhg6A4h5riFRk5AiOdaAr40PwGeH2dGDoepx0ni/xWYY195UOo=@vger.kernel.org, AJvYcCVt+i/lAzvxxZiFJy/2fDAo8R91zfgOvVKqsFSUQLhVSfN/X2P5Nyh4NW1XUIvdK1FXr5pPhHssRdOj@vger.kernel.org, AJvYcCXYDlM4qHE7LYXao/2bFM/fTX0ydW+IYjqsG5Go3N91HZ715ybzUgTWISFo9uQzlKhZ3vGFdBaXHo2+@vger.kernel.org, AJvYcCXmUon39oCc6wzPb4tx4yoqZwyPUC63/sCzgSzJ7dL98x1nRBKYv2pxbsL+mVrvx0vd7U3LITgSuwvl9FM6@vger.kernel.org
X-Received: by 2002:a05:6808:1794:b0:406:6e31:18a1 with SMTP id
 5614622812f47-40a5d05f586mr5488096b6e.2.1749734218150; Thu, 12 Jun 2025
 06:16:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250607194541.79176-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250607194541.79176-1-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Jun 2025 15:16:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW_89naftFMo881zp=7QGJDznFzzqLQ-kLEuyJ=KJWQnA@mail.gmail.com>
X-Gm-Features: AX0GCFuXLlnarexsZjEK1q0rakNUWi7gsoLxdkLO2FqaNoBwunA3MuELiFSEafs
Message-ID: <CAMuHMdW_89naftFMo881zp=7QGJDznFzzqLQ-kLEuyJ=KJWQnA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] PCI/pwrctrl: Add optional slot clock to pwrctrl
 driver for PCI slots
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-arm-kernel@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Anand Moon <linux.amoon@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 7 Jun 2025 at 21:46, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> Add the ability to enable optional slot clock into the pwrctrl driver.
> This is used to enable slot clock in split-clock topologies, where the
> PCIe host/controller supply and PCIe slot supply are not provided by
> the same clock. The PCIe host/controller clock should be described in
> the controller node as the controller clock, while the slot clock should
> be described in controller bridge/slot subnode.
>
> Example DT snippet:
> &pcicontroller {
>     clocks = <&clk_dif 0>;             /* PCIe controller clock */
>
>     pci@0,0 {
>         #address-cells = <3>;
>         #size-cells = <2>;
>         reg = <0x0 0x0 0x0 0x0 0x0>;
>         compatible = "pciclass,0604";
>         device_type = "pci";
>         clocks = <&clk_dif 1>;         /* PCIe slot clock */
>         vpcie3v3-supply = <&reg_3p3v>;
>         ranges;
>     };
> };
>
> Example clock topology:
>  ____________                    ____________
> |  PCIe host |                  | PCIe slot  |
> |            |                  |            |
> |    PCIe RX<|==================|>PCIe TX    |
> |    PCIe TX<|==================|>PCIe RX    |
> |            |                  |            |
> |   PCIe CLK<|======..  ..======|>PCIe CLK   |
> '------------'      ||  ||      '------------'
>                     ||  ||
>  ____________       ||  ||
> |  9FGV0441  |      ||  ||
> |            |      ||  ||
> |   CLK DIF0<|======''  ||
> |   CLK DIF1<|==========''
> |   CLK DIF2<|
> |   CLK DIF3<|
> '------------'
>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Reviewed-by: Anand Moon <linux.amoon@gmail.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Bartosz: Any chance you can apply this patch to an immutable branch,
so I can merge that before taking the other two patches?
The alternative is to postpone the DTS patches for one cycle.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

