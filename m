Return-Path: <linux-pci+bounces-28493-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C50EDAC6138
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 07:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C874D9E7937
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 05:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE341FE461;
	Wed, 28 May 2025 05:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WK0fNyRS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FEC1FFC41;
	Wed, 28 May 2025 05:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748409973; cv=none; b=Py4TEKZlhz00SqRuMI/kmryRZxD/Sz0jccwDCYGr3Tzk+Obp1hwIDM+0CdJyav0ny88unehWoLB0QmfR4zrEBILmeOjEkTeF5W1nrHuPXXlpi6KMmsQhfhvAkPzd/L7C9X08LdbJjQndjK6/59xw5JNsqR9g67vfGuEw8wzRe4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748409973; c=relaxed/simple;
	bh=ENSPcoDU8pkE9gqV7fe6vQxO9rHxe7aKvomwqpl+fXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SaZhNIX8/EqsBQtRSOXNJE2kKKznPjDrYJxTkx1xEE2OK6WIn2KDVBjSS44UN1PdZ5X6eZV6MC+Ad5Wdus2xYbLS2CBBk6HuNTdqckSRN+Flryg8WMRpMIX6h/NxH5Z4LPQZl1CrCVmFzJA2In8gNoZFIwSkcQHUpgBqo9Xr7sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WK0fNyRS; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-acacb8743a7so86558766b.1;
        Tue, 27 May 2025 22:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748409970; x=1749014770; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eGClTHgroxBcfOqGpSNsGz5pDhgYGNK3UlpzTs482Pc=;
        b=WK0fNyRSDtYetaujGrwvZJbt2SWLqsztd59Fa0qJjslBEL6xW5EPJ3WI9DsrYUzsci
         Moqr4Xlbhj7XEh7dh6vIiX84aKVtElBGuk5g4HXG2wb9bTGePqlxUS032Fcccfi6GMtZ
         tmqqGmaQhuV0VTo7g4UoVtB7GIVaWw985MfZeo0+bv23pCNONp3+0Eik+2r0fD2GDhw3
         UWIFLyFadoy6Fqxr6eTdlRbKIbshRxcu7ODd+7uyGKUakn/lTw6oZQh9aRvx9sOE0wEl
         mHwelZmG1w48ffzHYIPEBVC/prfe24hPdOXLO9fncdjl+QFkBxooPFBdNsuEHomIZVJ/
         bRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748409970; x=1749014770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eGClTHgroxBcfOqGpSNsGz5pDhgYGNK3UlpzTs482Pc=;
        b=uKsU6Tl8JRCZ8T+dtPppjO1fy1zpFUp7mNV7SLvFODexXmQ3ebY6xfX96Tqj1VOwd7
         u7/Eu7dz4AtHXVQ//nF+CZx2TH/+GxzC5X+RE3n9oXEyE79Dqtp+tov/4IRDMkqimaDz
         Q9nJ5fOrcL2AEcJG7rlW0EPIuF5W33HcjMYa8P3q0KGk7KbrNmk4YtiCZTky7qFimhWv
         abtPNRMgWsQqVarP9O9jAdJa9DP2ngp3zDsiBYsLUxcpMg7ygFA8Rw0RHml3T+PjSf81
         FwVWmJ5SSc91GlyYZ6v5Jyo8MIvcbIaetBfLLkHYgUkGQ9hRLpWL+eifLGuOU+tQ/WN3
         DAew==
X-Forwarded-Encrypted: i=1; AJvYcCUTVJlXLipukaLpXdKduQMYAFCxnLPMsNkSXxbjUPV354W+7dt7LCKswJX5964uDnAfjKJ3F4GrXjuq@vger.kernel.org, AJvYcCVABDb/y8rFUU9bNWQ22o3tSYYe8cnBKGFDsEvac1s2HGwuarkz2jpZLJkpaoC52EZW06Hg+GV0toL0@vger.kernel.org, AJvYcCX6zaFI/RPCDTooaqviDnF7xEmW++ziksJrhzxjSacM1BL9Bj5sIk83yLCCElWwNa4ytfp0zEn6XDO6B2g+uPyof2c=@vger.kernel.org, AJvYcCXhINVgAwGK1QKbGfu0WUZJ4N8el8UYVlF7XXYQvrJklrgSw2IZBh62Tj4+rqQh6vIebz0sCvWNydGmGh3M@vger.kernel.org
X-Gm-Message-State: AOJu0YwNZWetQIrVyl6qdvat5RIbEMk3+K0twLXZDcj27G5y6asJzFaH
	WKJfxa1DiNSSu3m9mzEOQAe0DSYD8lba0BSHYYB7Oo8mQz2+7WjdS3Pa7M95y+g3qUV8E8Zu52l
	8Pygij5gHa2Uf3UNzfDGedHweQLWa3BI=
X-Gm-Gg: ASbGnctdQWVp7XxxfmblQalPhkqiaauIbk4KhIvCg5TOb1dXbiEMX4m0Db5ESzbu3Mi
	JHsgzJHoSnGbVnzK0i0wqn6HZ87ub48PfOS44tw6BrJkV0S6a18LBQZyHarqKTNFZNqEkAe36cx
	1FvzZ9/Fd1e7koZ4YfLrEDDhjJJmmG74BFIpCcGvjxWg==
X-Google-Smtp-Source: AGHT+IGtzXS7r014ksMOyLWyv3PY+eL9kVmReP9BCXuY+JhbQJHaBU9SpOog9pV/WyubUhLYHA04NIb+oVSmRa6PrEA=
X-Received: by 2002:a17:907:1c2a:b0:ad5:9ff3:c6ce with SMTP id
 a640c23a62f3a-ad89886abebmr283385766b.4.1748409969604; Tue, 27 May 2025
 22:26:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250525160513.83029-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250525160513.83029-1-marek.vasut+renesas@mailbox.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 28 May 2025 10:55:52 +0530
X-Gm-Features: AX0GCFvOx05IZ5_kXJ72iIXw3IbiUdPuTxyEyjCQN5yHvmLpaXyXqe_dfeV4Hz8
Message-ID: <CANAwSgRXDLGAaXGXHfiS2rA3=+r2is2g557Bozu+SocQoBMySQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI/pwrctrl: Add optional slot clock to pwrctrl
 driver for PCI slots
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Sun, 25 May 2025 at 21:35, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
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
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>  drivers/pci/pwrctrl/slot.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
> index 18becc144913e..222c14056cfae 100644
> --- a/drivers/pci/pwrctrl/slot.c
> +++ b/drivers/pci/pwrctrl/slot.c
> @@ -4,6 +4,7 @@
>   * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>   */
>
> +#include <linux/clk.h>
>  #include <linux/device.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
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
> +               ret = PTR_ERR(clk);
> +               dev_err_probe(dev, ret, "Failed to enable slot clock\n");
you can user the return from ret = dev_err_probe()
> +               goto err_regulator_disable;
> +       }
> +
>         ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_slot_power_off,
>                                        slot);
>         if (ret)

with that change.
Reviewed-by: Anand Moon <linux.amoon@gmail.com>

Thanks
-Anand
> --
> 2.47.2
>
>

