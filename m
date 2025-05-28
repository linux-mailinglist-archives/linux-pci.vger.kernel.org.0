Return-Path: <linux-pci+bounces-28496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC23DAC62BA
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 09:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F619189ADA8
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 07:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE8A24469C;
	Wed, 28 May 2025 07:14:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE5B242D98;
	Wed, 28 May 2025 07:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748416471; cv=none; b=mXZYBrgG6XoBW/4mVxCbfoMGNN7M2sbZNDmE5UI8CZjCAgXXJtxVt2hE2/BsQRJvJB9R47mfD4Sw+Z1V3oKvq6UUoFHDpJiZgXvn3woQJ+w8tkfQyC288liEgK7RPvzRbHm/En+YcvgZ3a1Y5A4V7KI93ymLp2ypORQW+aWcMRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748416471; c=relaxed/simple;
	bh=dsYr2+VPVIPpGKKHj9pv38/YtMjGpdlE9wKnObX7AGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OM8VK0N1oQs6LqJpCZ/qh+aJMTtC60hucLfe4AkfAoU69ILnvOUcIP/o5GV4is7PJy6MVfJEBnV2lm9oRtRHHoRInidaN+ZffmrSQKUo1cygJlg3t95qCM6nTZ6Ze4VgMLiBWeo/hL17YKXakHu0sk8WoUxKuOkCm2wkq8fDRE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-52eff44a661so1134288e0c.3;
        Wed, 28 May 2025 00:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748416465; x=1749021265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W3AwXVgZWJIPFDmEkzHtoSPmnRnszxQ34o1b/XJWM3Q=;
        b=exj82UyqxFgIVvd/BPzwZNXIwSTB3c50PU6U2dVTi5RJTIUO/6irdWlLe09JGHprME
         F9Vg/IBuowU1UhXnROfaNoLohOyEWyDCtXB2sZqHloc244fuiPVZ6wVodowJd3a8Ohq0
         GOTXxPfhDo6xz3cHoQnvlAKQj0Q4kL6qmRPzmOyZhay3KoqurqwDr0ghonVxY0vdaxcK
         hI1jDT11nfG46sHK17O96kXocL9EBz3SGKIaCcPwqFviFwazZBdDDUFBIXvym4etCwjd
         uPzCmyHyIcjH+vnAZbS/JNgLE88SC99hTmc4TCdRGEiDPHc2u50sZ/qouktRktaSYeAo
         3kYA==
X-Forwarded-Encrypted: i=1; AJvYcCVWDGtePctpvyYVGj+aE+WL8jkIR6HbSKh8Khqpnnpj6hEYjCR1eKFD3vGthPUU288qx2NZM96uRQ6W@vger.kernel.org, AJvYcCWEzEycTxnT929lw0Y8EM7vF5S2W8ym56MGm6SBHYDVaOCylr3xGuPEBHVeJ+UBCMdWbgUDNsgtLQSt@vger.kernel.org, AJvYcCX3Nu/2QIkeG728VXY3Ngwve9em33eGjU80duNtNCcEEHz/4uJ0t+QZiLQ0Z/np1Sc3lSweJ7U2f/X1q6a8QRVW2hg=@vger.kernel.org, AJvYcCXwopdTE/aCuaqACykuJ6ImR86njnmDlkgv9K7g0lKB0Zuth965F0tBjWCtjY5zrjwKzYGImsD0D+YotUVg@vger.kernel.org
X-Gm-Message-State: AOJu0YxSUdfxr7rBZXwp8K1PacJCqF7uKQ+0FJVsvicBpLALpsVmFbTs
	TXd7HNI9euG4L/fDiQTx4/uly1GQe8SGX0JKgH/nuLzvdjQ0qDaTbugPrZZ8AzIz
X-Gm-Gg: ASbGncsZMV53fXqkUe+X3sxq09L0MXPB8nCcc0YdwrJEQilXzecxCq4PQx5Z6zIOWY1
	SlfoT6OvyACyFT+lBsoFjc82/Kp7YtgPFbU5u2a7pylqinXt5SKRns5sOkHuIrP5QPbvRGLDT68
	mkCkKuKdhwxgqu3jcu461X5gRyszUi0sHoeZ4JrcmLBOQOhgigiCZq2V4AkV9hOYLy6N76E/BSB
	FflDtQ59kUS/HMsG6ilETHIYAOAC2o35uiOllFpPs60AMNP86JsaTo/TxIXDVODLoybJhlYCpeu
	DafyOO2ehg7MjHjLXY6KBsEp16M1aT6tS5pBQBS/krtu4oxLdFcYj8zAS4jMJuR0/nwfSWAQ02T
	RPdQXiTpdKEKFFA==
X-Google-Smtp-Source: AGHT+IFldSN9qBJ9ZXoQbnFKrU9RqinI8/7yeYamScCKQoCpsABqGm9CPcEkwuDppDJh7YYIHSLnlA==
X-Received: by 2002:a05:6122:8b04:b0:520:997d:d0b4 with SMTP id 71dfb90a1353d-52f2c4c8022mr12582574e0c.4.1748416465497;
        Wed, 28 May 2025 00:14:25 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53066843ecesm490180e0c.4.2025.05.28.00.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 00:14:24 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4e58d28ebb0so552102137.3;
        Wed, 28 May 2025 00:14:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVOBmmEYShbq5PFw/t5dXdn14ZiqjQXXuwW7ApuWq60zbOxyB0dbzFYa120qFp8hnaHp3wtAr3fDogx@vger.kernel.org, AJvYcCWgTceBj2IMW3Vkwx17iCaKg0puM7Q21HoaSlg/s3jy/ly2Sj2JA03fWR6HdXuS+E1JckW3bCEzdyQUJzXeVkdkXF0=@vger.kernel.org, AJvYcCX6DC6VtBHnR7VxeiVK6IOznU50QdA/wCiSIZzvKIGYi3q3N7I4arDWl+FWP3u/tHvSHwq0Ytnz7xtv@vger.kernel.org, AJvYcCXt9b5CImezcRpfWbIEeXyfK92LdRKzvOqs3yXOuRtzJc1qVgjzuxJyInilD5iZmvJ3mln1OuMpHy8ukbNn@vger.kernel.org
X-Received: by 2002:a05:6102:5244:b0:4dd:b82d:e0de with SMTP id
 ada2fe7eead31-4e42415fc45mr12232806137.17.1748416463800; Wed, 28 May 2025
 00:14:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250525160513.83029-1-marek.vasut+renesas@mailbox.org>
 <20250525160513.83029-2-marek.vasut+renesas@mailbox.org> <b7vnm66igh3b3ahyjqhegnbteij3bj2ypxcq6ccwi4i77k3af6@g62yhfervtvt>
In-Reply-To: <b7vnm66igh3b3ahyjqhegnbteij3bj2ypxcq6ccwi4i77k3af6@g62yhfervtvt>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 28 May 2025 09:14:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU==_1o9LNMWxvChNtvrtvJ0nGb3Kp-uLmCX+Kbv_Ajjw@mail.gmail.com>
X-Gm-Features: AX0GCFtOFIkdeyrU5qOoeF12WCRAZB7wo5Pks_9rfthiicfvECxoWJx-OjXflDE
Message-ID: <CAMuHMdU==_1o9LNMWxvChNtvrtvJ0nGb3Kp-uLmCX+Kbv_Ajjw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: renesas: r8a779g3: Describe split PCIe
 clock on V4H Sparrow Hawk
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-arm-kernel@lists.infradead.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Mani,

On Wed, 28 May 2025 at 05:50, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> On Sun, May 25, 2025 at 06:04:04PM +0200, Marek Vasut wrote:
> > The V4H Sparrow Hawk board supplies PCIe controller input clock and PCIe
> > bus clock from separate outputs of Renesas 9FGV0441 clock generator chip.
> > Describe this split bus configuration in the board DT. The topology looks
> > as follows:
> >
> >  ____________                    _____________
> > | R-Car PCIe |                  | PCIe device |
> > |            |                  |             |
> > |    PCIe RX<|==================|>PCIe TX     |
> > |    PCIe TX<|==================|>PCIe RX     |
> > |            |                  |             |
> > |   PCIe CLK<|======..  ..======|>PCIe CLK    |
> > '------------'      ||  ||      '-------------'
> >                     ||  ||
> >  ____________       ||  ||
> > |  9FGV0441  |      ||  ||
> > |            |      ||  ||
> > |   CLK DIF0<|======''  ||
> > |   CLK DIF1<|==========''
> > |   CLK DIF2<|
> > |   CLK DIF3<|
> > '------------'
> >
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > ---
> > Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Conor Dooley <conor+dt@kernel.org>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-pci@vger.kernel.org
> > Cc: linux-renesas-soc@vger.kernel.org
> > ---
> >  .../dts/renesas/r8a779g3-sparrow-hawk.dts     | 45 ++++++++++++++++++-
> >  1 file changed, 43 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts b/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
> > index b8698e07add56..7c050a56290fd 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
> > +++ b/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
> > @@ -130,6 +130,13 @@ mini_dp_con_in: endpoint {
> >               };
> >       };
> >
> > +     /* Page 26 / PCIe.0/1 CLK */
> > +     pcie_refclk: clk-x8 {
> > +             compatible = "fixed-clock";
> > +             #clock-cells = <0>;
> > +             clock-frequency = <25000000>;
> > +     };
> > +
> >       reg_1p2v: regulator-1p2v {
> >               compatible = "regulator-fixed";
> >               regulator-name = "fixed-1.2V";
> > @@ -404,6 +411,14 @@ i2c0_mux2: i2c@2 {
> >                       reg = <2>;
> >                       #address-cells = <1>;
> >                       #size-cells = <0>;
> > +
> > +                     /* Page 26 / PCIe.0/1 CLK */
> > +                     pcie_clk: clk@68 {
> > +                             compatible = "renesas,9fgv0441";
> > +                             reg = <0x68>;
> > +                             clocks = <&pcie_refclk>;
> > +                             #clock-cells = <1>;
> > +                     };
> >               };
> >
> >               i2c0_mux3: i2c@3 {
> > @@ -487,24 +502,50 @@ msiof1_snd_endpoint: endpoint {
> >
> >  /* Page 26 / 2230 Key M M.2 */
> >  &pcie0_clkref {
> > -     clock-frequency = <100000000>;
> > +     status = "disabled";
> >  };
> >
> >  &pciec0 {
> > +     clocks = <&cpg CPG_MOD 624>, <&pcie_clk 0>;
> >       reset-gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
> >       status = "okay";
> > +
> > +     /* PCIe bridge, Root Port */
> > +     pci@0,0 {
>
> PCIe bridge mostly is integrated into the SoC itself. So it should be defined
> in the SoC dtsi. Only the vpcie3v3-supply is board specific, so it should live
> in board dts.

... and the clocks property, of course, which is the main subject of this patch.

> > +             #address-cells = <3>;
> > +             #size-cells = <2>;
> > +             reg = <0x0 0x0 0x0 0x0 0x0>;
> > +             compatible = "pciclass,0604";
> > +             device_type = "pci";
> > +             clocks = <&pcie_clk 1>;
> > +             vpcie3v3-supply = <&reg_3p3v>;
> > +             ranges;
> > +     };
> >  };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

