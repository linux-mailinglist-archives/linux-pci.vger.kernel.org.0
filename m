Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82D5A15B8D2
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 06:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgBMFPT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Feb 2020 00:15:19 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46136 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgBMFPT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2020 00:15:19 -0500
Received: by mail-pf1-f194.google.com with SMTP id k29so2410774pfp.13;
        Wed, 12 Feb 2020 21:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Fh8+e0MHgQc517ub6mcnCLJ3IIKeFZfvHhkBKX9KMe8=;
        b=RgvoMhCcy5+AAiFK4p445waTzEkyhCFqRTXNUFx0PqcszqyEXjRAlJ6au5J9fDsYen
         UeEYFHCzPDGD3rbfFsqKiykwSOzx/i4Fz02HOe6i2evkH4J3cmEbdGFBWz+Mc/xOC8UA
         jPWWh6KpHv7gp1nhNB1ZNPFMqmBiog2vj9HdE24wgFwfcZNyIfxCJjDcyy8epFwVA+Xi
         dZ09r22Rm29KTTF7RkmNypJXWk5zXj4JGEvl3dFKTK5jsdqR/eTMwL1qLhbB/qvlneyi
         eALVpWIXkSSZkRu1KBtPRJXO7ZYpY/zHXJ9E72tHnMfFFHtAli/A3Eet/GnYm71IMTIu
         m1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Fh8+e0MHgQc517ub6mcnCLJ3IIKeFZfvHhkBKX9KMe8=;
        b=oU/V9g7N26C3zq5gHc9qjKFhOJnimoiT0DS32wkECEBQ5/xoTSABGrE+eBn7cDBFtz
         ckLbofIzhjoSfpFloIOb2zHjl4LqyWfudO7mu6/NsTCnRj2Am74WCYLxec7koGKQpUWP
         BvGtjcVswmZ8Sw2f+3/MyIRHYjpwM8nOvRR5/cJChK2TNzMDnz3sMAMwhfJ88815NFzW
         g8x/65Mn3ZoTiGmcdnVdLnoe0m46wobPVIRXt1dJgcMjFD22J+TKgfY2GTLDNSZHWM7Y
         tiG55oHvPQm1zkFnxaFwOFMYdHlUXg9JXz402QjY214apQgoo3Do7YTH4hqym8GbmsB9
         yCJQ==
X-Gm-Message-State: APjAAAX7BhBs0kD0wSBzeC+wKmuXbhVFzqSUiHsoWT0d36QKHgpyHL+d
        qj/N09ylu1rWLOGAidxjNoo=
X-Google-Smtp-Source: APXvYqxR8WNATXQylv/cl0HD3MazTyX9n7G+wJGktcOn/tuXVNhgbbTOLAn+ZnuqMR7PkXrBC7981A==
X-Received: by 2002:a63:5525:: with SMTP id j37mr15700855pgb.180.1581570918231;
        Wed, 12 Feb 2020 21:15:18 -0800 (PST)
Received: from [172.16.1.120] ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id c74sm1069028pfb.135.2020.02.12.21.15.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Feb 2020 21:15:17 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH 0/3] PCI: brcmstb: Add Broadcom STB support
From:   Jaedon Shin <jaedon.shin@gmail.com>
In-Reply-To: <6ba4bb21-034b-93f0-d4b7-13ac7c5a925d@gmail.com>
Date:   Thu, 13 Feb 2020 14:15:12 +0900
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Jim Quinlan <james.quinlan@Broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <44052F86-D0DD-4FDD-A62B-09280E956405@gmail.com>
References: <20200213025930.27943-1-jaedon.shin@gmail.com>
 <6ba4bb21-034b-93f0-d4b7-13ac7c5a925d@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> 2020. 2. 13. =EC=98=A4=ED=9B=84 12:54, Florian Fainelli =
<f.fainelli@gmail.com> =EC=9E=91=EC=84=B1:
>=20
> +Jim,
>=20
> On 2/12/2020 6:59 PM, Jaedon Shin wrote:
>> This series enables the ARM based Broadcom STB SoCs and supports GPIO
>> based regulators for its power supplies. and this has an improvement =
on
>> devm_ APIS.
>=20
> Which ARM-based SoCs did you try this on? We still have an issue with
> the multiple dma-ranges that must be handled to support 7445 with =
memory
> in the extension regions as well as 7278 and 7216.


I'm using BCM72604 which has only one memc. and device is Qualcomm =
Atheros
QCA6174 Wi-Fi module.

>=20
> See comments in specific patches.
>=20
>>=20
>> Jaedon Shin (3):
>>  PCI: brcmstb: Enable ARCH_BRCMSTB
>>  PCI: brcmstb: Add regulator support
>>  PCI: brcmstb: Drop clk_put when probe fails and remove
>>=20
>> .../bindings/pci/brcm,stb-pcie.yaml           |  8 +-
>> drivers/gpio/gpio-brcmstb.c                   | 13 +++-
>> drivers/pci/controller/Kconfig                |  2 +-
>> drivers/pci/controller/pcie-brcmstb.c         | 78 =
++++++++++++++++++-
>> 4 files changed, 97 insertions(+), 4 deletions(-)
>>=20
>=20
> --=20
> Florian

