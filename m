Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8F71CC4E2
	for <lists+linux-pci@lfdr.de>; Sun, 10 May 2020 00:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgEIWNt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 May 2020 18:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgEIWNs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 May 2020 18:13:48 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E925C061A0C
        for <linux-pci@vger.kernel.org>; Sat,  9 May 2020 15:13:48 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u16so14542927wmc.5
        for <linux-pci@vger.kernel.org>; Sat, 09 May 2020 15:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lD31d7YFceTquxmJsFPQZPEcCiTM+43KicNVCvkKBqk=;
        b=Ia/S2gFcm00jIKuwaz5kSI5Dx0TNSVOE3wST8xvegQacQa6wHM0ySbTqB3S9gvA9yk
         tUTK4j9Lkpati6Tcu0P+G4IX0BTGhrLdYupCOAjclWsmD/YG/9fKqaHtkj/+TM7b71Kd
         6VqNnhL1TDDX3mrynAwJH7gthDLBVgtSbxTPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lD31d7YFceTquxmJsFPQZPEcCiTM+43KicNVCvkKBqk=;
        b=snk8vr1Vd9e5x2wfh9r8cNGxgjVKG8bcpApXjHCtTVQKhZrdkMGr5RMQcx8xwMjMwp
         0kOPISl6iJjUnu5rZH0PVx2SZ84glfwTAjfKv9lM4AQ3fY0QNvh6wb8lmcwfQSVUX03e
         1dbRazCtwIX/W5n3uhY0WuHfQXwJgwRJQF7NZdV1z3RONqLEqfusHlc53M5tCEmg7SF2
         M99PkXax/+tzKWFhcfKcWdcP4iWtP0V3swwOZrs5OfD9ItBe/+WE9QHSQyp7f+hXjFlI
         Ybhz9Gq1B3yvFCBHy7Ce+cDogZM7zSwHLCz1zPE8rWYqk7QXRbHDtoSWQTFN6L10mBiP
         9egg==
X-Gm-Message-State: AGi0PuYRujTKW79RHISWy4XxDWE/D8zgwT3uA30hs+qIZ94pluRgDKVJ
        HInNWkMsgt5y7yFEA4QcjLBKkHp8F9gYfVyUOs4JPw==
X-Google-Smtp-Source: APiQypIUFrX/jGD2s6yJaEK2Vf/IZY6cocpfJr4dUVpQJp+R1wRt/kWM6nTigZL0ZJgnFyqyz/rv2syLdywi6Bj/2Fk=
X-Received: by 2002:a05:600c:2:: with SMTP id g2mr23981017wmc.85.1589062426992;
 Sat, 09 May 2020 15:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200507172020.18000-1-nsaenzjulienne@suse.de>
In-Reply-To: <20200507172020.18000-1-nsaenzjulienne@suse.de>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Sat, 9 May 2020 18:13:33 -0400
Message-ID: <CA+-6iNzeBJ9ioG_=HnthUsRUYUQC2Wm=-BOAdFhShs9dy4ovcA@mail.gmail.com>
Subject: Re: [PATCH] PCI: brcmstb: Assert fundamental reset on initialization
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        s.nawrocki@samsung.com, tim.gover@raspberrypi.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 7, 2020 at 1:20 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> While preparing the driver for upstream this detail was missed.
>
> If not asserted during the initialization process, devices connected on
> the bus will not be made aware of the internal reset happening. This,
> potentially resulting in unexpected behavior.
Hi Nicolas,
I believe that most chips by design have the PERST signal asserted by
default during start-up but this will certainly cover any that do not.
Looks good.
Regards,
Jim
>
> Fixes: c0452137034b ("PCI: brcmstb: Add Broadcom STB PCIe host controller driver")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 0b97b94c4a9a..795a03be4150 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -699,6 +699,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>
>         /* Reset the bridge */
>         brcm_pcie_bridge_sw_init_set(pcie, 1);
> +       brcm_pcie_perst_set(pcie, 1);
>
>         usleep_range(100, 200);
>
> --
> 2.26.2
>
