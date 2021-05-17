Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14AB382D16
	for <lists+linux-pci@lfdr.de>; Mon, 17 May 2021 15:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbhEQNQ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 09:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbhEQNQ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 09:16:58 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F000C061573;
        Mon, 17 May 2021 06:15:42 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id x13so3081901vsh.1;
        Mon, 17 May 2021 06:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=64iLNFarXR/0X5C3MD+uhPh/ufsHsIi9Z+svs3XdY94=;
        b=QICmOlfDKxH8Rl5tqpmIV1hlkb/+dVXIS9wyOj94ugM7StLFfX9YH4g0VmGLMwsE1O
         DIa2EnfMlPB2ngrcWJJNcbov3bjPCyjXsSCzoYRAy3AirCW6CXsV0HcFv6b807UsyEdB
         LhoijPsZxApRRgFAUt8hxfB5iPd0n/F/jxFBMdpmIgjRNN7gAUbDrpNBrqILEK/fZowF
         +8oOkMjYEaLydRCJc4QnRc3SGOAcYPP1ldabJR13fVcdXzvNYZ6Z6v+YwwXYypUlF2FI
         y4WFvbbuUwMMjYnCpewLkBqhAQkp20ZVEt0D27/gHFm9mC9Y5/TpAO2OIJ5xxxL0sT5N
         YTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=64iLNFarXR/0X5C3MD+uhPh/ufsHsIi9Z+svs3XdY94=;
        b=g0jFUYZks5l/qyQbOMtdHjzx86Z+Tv3TGL4/6BBnEMuY+NYc+fK86T4JE3W8Bh+ZI+
         sHcc8Erl+LoDYZpGLFOf76Tb+DpvmVi/z+1dWlJXbQegcxEZl1MCghL9zI5UNkx9E4xn
         V3Mrpl/pQu8TJHi7qtq16mJDOkSuq0Ot1JOkr1PSnwAVHgsG0MMrjLHhS1W0MBiSCJ1F
         U7+HMiE6cbWoGSNOpFbd4GUqfKtj9m8cHq0bGBZFyIGbz8b7RVcVnkuihLqiYjscbdqG
         WVdYwqyn2ZLLb+hiMOQlBTXMaTluzxEXbEvyIw+jBXcA9BHPaJYpf1RCeSEq3lpLhQD8
         tXjg==
X-Gm-Message-State: AOAM530EhQT3bHzNPoBuLKhx0JnonHCRdpOigdTBb+qhPEykBU70Si5L
        8Vs6G66MYtiwfneNAStMzbQVVWLVlAt46bbNEso=
X-Google-Smtp-Source: ABdhPJwhS9/DrVSwXKUJZOZ1dipQaZqv7hS1icQ2AOlYxQVS4mCjURvnh6C0qj12mpT6F5LCux65SjidjOhm+UZQCgY=
X-Received: by 2002:a67:cb15:: with SMTP id b21mr52611553vsl.29.1621257341885;
 Mon, 17 May 2021 06:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210325090026.8843-1-kishon@ti.com>
In-Reply-To: <20210325090026.8843-1-kishon@ti.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Mon, 17 May 2021 15:15:31 +0200
Message-ID: <CAH9NwWeOysq9yLheFAXgX0c7bOZAAX7ZuQHXM9Rmb1an_Z5ZYg@mail.gmail.com>
Subject: Re: [PATCH 0/6] PCI: Add legacy interrupt support in Keystone
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Lokesh Vutla <lokeshvutla@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi

Am Do., 25. M=C3=A4rz 2021 um 10:04 Uhr schrieb Kishon Vijay Abraham I
<kishon@ti.com>:
>
> Keystone driver is used by K2G and AM65 and the interrupt handling of
> both of them is different. Add support to handle legacy interrupt for
> both K2G and AM65 here.
>
> Some discussions regarding this was already done here [1] and it was
> around having pulse interrupt for legacy interrupt.
>
> The HW interrupt line connected to GIC is a pulse interrupt whereas
> the legacy interrupts by definition is level interrupt. In order to
> provide level interrupt functionality to edge interrupt line, PCIe
> in AM654 has provided IRQ_EOI register. When the SW writes to IRQ_EOI
> register after handling the interrupt, the IP checks the state of
> legacy interrupt and re-triggers pulse interrupt invoking the handler
> again.
>
> Patch series also includes converting AM65 binding to YAML and an
> errata applicable for i2037.
>
> [1] -> https://lore.kernel.org/linux-arm-kernel/20190221101518.22604-4-ki=
shon@ti.com/
>
> Kishon Vijay Abraham I (6):
>   dt-bindings: PCI: ti,am65: Add PCIe host mode dt-bindings for TI's
>     AM65 SoC
>   dt-bindings: PCI: ti,am65: Add PCIe endpoint mode dt-bindings for TI's
>     AM65 SoC
>   irqdomain: Export of_phandle_args_to_fwspec()
>   PCI: keystone: Convert to using hierarchy domain for legacy interrupts
>   PCI: keystone: Add PCI legacy interrupt support for AM654
>   PCI: keystone: Add workaround for Errata #i2037 (AM65x SR 1.0)
>
>  .../bindings/pci/ti,am65-pci-ep.yaml          |  80 ++++
>  .../bindings/pci/ti,am65-pci-host.yaml        | 111 ++++++
>  drivers/pci/controller/dwc/pci-keystone.c     | 343 +++++++++++++-----
>  include/linux/irqdomain.h                     |   2 +
>  kernel/irq/irqdomain.c                        |   6 +-
>  5 files changed, 440 insertions(+), 102 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/ti,am65-pci-ep.=
yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/ti,am65-pci-hos=
t.yaml
>
> --
> 2.17.1
>

Is there somewhere an updated version of this patch series?

--=20
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
