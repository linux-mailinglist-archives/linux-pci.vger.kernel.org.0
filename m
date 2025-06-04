Return-Path: <linux-pci+bounces-28943-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2920ACDA10
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 10:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83C3216EC03
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 08:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F5728A3EF;
	Wed,  4 Jun 2025 08:40:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43499248878;
	Wed,  4 Jun 2025 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749026443; cv=none; b=tZTjaEq2vDQGlQwJ7Z9/6fmhGnXtQqD95jYwtX6XqAji66DAOpMMBBmuiumGOFSF2TvQ5i7hwYURnaZFOf78HRhYebtlCJFZYPVY/kzg0xk+yfzhGLOP5PReWjSj7jvn+BlP6bYcmbzi771TVqWZNvQ00sotrnyU9PfqbkkXfrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749026443; c=relaxed/simple;
	bh=yqaLRaFfT6O9njZap+NVHAgsBEggTlcJqgOFYRpiOGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luHKnIiZp+LKu7VhaAELhnsdCsoA72ImG+qaHE8C9TqBrp1TZZNTOUngBo1QM4Binay5Z/rZSzCQtLaDzEMwNnAWKd7VilqmTDY6t98jiVvHpoCJWN0LTKHDNjuIzkeoAcKI3H+0fSTmjIxrfE9cMRlFnzbWKURMPqU7l9Y41Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4e58a9bb8fcso2115503137.2;
        Wed, 04 Jun 2025 01:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749026438; x=1749631238;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhxUNZMk782m8rVDbncnLrWZuVZ5QZ3Bs0hyS8RTdoM=;
        b=D3zwPGC2mE+FcGohESlLy0ziK08wVJPGnMx4kppk0UGhGa6ARbfcMCcDaQizbaRsOP
         h1c9h15N6VQjfmwWSEXzMcowpsyOR1TKZWArokCZ4FyBlme2vV6105MEyh362f/2NgBM
         jhtpkxL2Utl7yidrbzBkWPeaXH5nsPNgGyBndYRn5LBnrSpcoDMDnJh3TSi1yCYxXgjp
         hF4ulaZFKd1UWsuHL7TrGcNNSlLGMRtl7TTGCFYKOly9gR+gjFOeID51Au2kZEqRQZwm
         uJbBox8KCQNUCerYsi2XPFFk3/zVmzaN6fo+07bpGl+89LS1RVKUUoCZ3mScDB6l2JEz
         VruQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTalFYOGWbXtEgxiXIdvQp6PNDjgEV9PPK8WelmYSfKEKXSSFn4GFfwR16ZR0uJ54Ojl2vfaawY7i0@vger.kernel.org, AJvYcCVk00CmKbeYSLT57jeqF9nJqZi0G6SkmPKO8QBxl5FWREnclsLGgKMrEEqp8NJRsz0sPod6p00Wxy6cbiU6rTWsZmI=@vger.kernel.org, AJvYcCXrRANGKz0TcdS98UmmmCRhG19lI/qCJo1h0tHxNSyGdGV8EkTTg7LjxBS3OVo/mjnqC3QGdEyRA2rW@vger.kernel.org, AJvYcCXv20CnwJhWNEP57PkwrPSiahDb27OjyIdLwkXyGdjIgU1pPa0NMCEIvgewUmPyqUl11505snMXvqRo5pZs@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/k4yCvpvSktpaDUoLSEbJIyO3Eot/RiLQ3GchpW+LQwOhK/Mv
	XKhfQewOxu7SAKMLGhA4jZjh8ismNzfNp41G7aLDzF0uDznAz0/P7kjAurTQbVpc
X-Gm-Gg: ASbGncsRQqxUGNkpcp9T+uFB2V85kJHQY8Ps45/kn5OABq/4nWaxrlpvfhoAOv0zQ6R
	Fy/ERpBOyF8/xmi7R3duisPceJXlssSSUsSehAjwTtjzL437tPEMRzjZIjrm+j/oj4saz8V42oM
	W6VF/g4aXNL0dAnZfBQxfEMWC5d9wpDtlAm0e3ZFShaxL4XOAh31Cl/h5sxL9CKFihp5F/mHEy9
	z23J5AK0iMG/d8AxY4gcC5j0D1qoEI/LfRA+6aTOfF7suz7hRkO/tuJkt2tICXeAz6Nfa340UnF
	y9TIZiZZh3eTv0DaxfEbCFEtkV96OZVcBK96niNOcKX+fWSimbURaZlTBVFaUJctL70FW0OitBr
	JsS1kiqkWXMsGQrNmihMglHxili4lR7OgUycxYm0=
X-Google-Smtp-Source: AGHT+IGVatC1Iqvgzujcx8ydhnlS44fmHGXRdNf6IfeUytgJaXe51vk+62XXPQOgM31wQ1tWrce6dg==
X-Received: by 2002:a05:6102:688d:b0:4df:93e0:fb3 with SMTP id ada2fe7eead31-4e746e0cc4cmr850976137.20.1749026438519;
        Wed, 04 Jun 2025 01:40:38 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87ea70e5ac1sm395553241.17.2025.06.04.01.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 01:40:38 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-530bdd90964so562558e0c.1;
        Wed, 04 Jun 2025 01:40:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsyRvfIQoNHnioKyws3oevNL+oQf++MCMCjpZExAD/iVRz5QCtd9Wi6x6nYXkJzXJUAuTxXAQD8E3t@vger.kernel.org, AJvYcCVV+nZSFXbICl73UlKRQ80QsNcEqF26H7QEIkrCQtlaFhve4MS/Q3JmOisn48Cjk8fiyV/mmdRfh75Z2/x5@vger.kernel.org, AJvYcCWGb5wvH5MjqOKoh+Zn7E8qDSf5k1UTKV90Pg0mKPC2K7befzd8nn0ZiXTkiR1jOJFfPSOdMKbefsO5oFNhZzAC3x8=@vger.kernel.org, AJvYcCWOdu06J/WdKCE1In4JIX9iKe5h14yhbu/lUfCyxuUThnCeLIOfMwicrzROgsXlCYkT8z3lfqbb2whi@vger.kernel.org
X-Received: by 2002:a05:6102:26ca:b0:4e4:5e11:6832 with SMTP id
 ada2fe7eead31-4e746d02e4bmr961072137.7.1749026437616; Wed, 04 Jun 2025
 01:40:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530225504.55042-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250530225504.55042-1-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 4 Jun 2025 10:40:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUFHKHKfymqa6jwfNnxZTAuH3kbj5WL+-zN=TR6XGd0eA@mail.gmail.com>
X-Gm-Features: AX0GCFt2fyoFoIK_LxeiOZfQp_iroUz4k9ILNbeuJExEwejZlhTah3i6hKjIVnU
Message-ID: <CAMuHMdUFHKHKfymqa6jwfNnxZTAuH3kbj5WL+-zN=TR6XGd0eA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] PCI/pwrctrl: Add optional slot clock to pwrctrl
 driver for PCI slots
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, Anand Moon <linux.amoon@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

Thanks for your patch!

On Sat, 31 May 2025 at 00:55, Marek Vasut
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

I assume this should be documented in
dtschema/schemas/pci/pci-bus-common.yaml, too?

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
> Reviewed-by: Anand Moon <linux.amoon@gmail.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

> --- a/drivers/pci/pwrctrl/slot.c
> +++ b/drivers/pci/pwrctrl/slot.c

> @@ -30,6 +31,7 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
>  {
>         struct pci_pwrctrl_slot_data *slot;
>         struct device *dev = &pdev->dev;
> +       struct clk *clk;
>         int ret;
>
>         slot = devm_kzalloc(dev, sizeof(*slot), GFP_KERNEL);
> @@ -50,6 +52,13 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
>                 goto err_regulator_free;
>         }
>
> +       clk = devm_clk_get_optional_enabled(dev, NULL);
> +       if (IS_ERR(clk)) {
> +               ret = dev_err_probe(dev, PTR_ERR(clk),
> +                                   "Failed to enable slot clock\n");
> +               goto err_regulator_disable;
> +       }

You are adding this block in the middle of the regulator handling.
Please move it below, under the devm_add_action_or_reset() call
(which is handled wrong, I have sent a patch[1]).

> +
>         ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_slot_power_off,
>                                        slot);
>         if (ret)

[1] https://lore.kernel.org/f60c445e965ba309f08c33de78bd62f358e68cd0.1749025687.git.geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

