Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 978D015D61E
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2020 11:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgBNKzn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Feb 2020 05:55:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:48358 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbgBNKzn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Feb 2020 05:55:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 49556ADDA;
        Fri, 14 Feb 2020 10:55:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20200213025930.27943-4-jaedon.shin@gmail.com>
Date:   Fri, 14 Feb 2020 11:55:23 +0100
From:   "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>
To:     "Jaedon Shin" <jaedon.shin@gmail.com>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     "Mark Rutland" <mark.rutland@arm.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        <linux-gpio@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Jaedon Shin" <jaedon.shin@gmail.com>,
        "Bartosz Golaszewski" <bgolaszewski@baylibre.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Gregory Fong" <gregory.0xf0@gmail.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        "Andrew Murray" <amurray@thegoodpenguin.co.uk>
Subject: Re: [PATCH 3/3] PCI: brcmstb: Drop clk_put when probe fails and
 remove
Message-Id: <C0LTYJ7DK8YA.1TZ11JH5XC7JB@linux-9qgx>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu Feb 13, 2020 at 11:59 AM, Jaedon Shin wrote:
> devm_clk_get* APIs are device managed and get freed automatically when
> the device detaches. so there is no reason to explicitly call clk_put()
> in probe or remove functions.
>
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Thanks!

> drivers/pci/controller/pcie-brcmstb.c | 1 -
> 1 file changed, 1 deletion(-)
>
> diff --git a/drivers/pci/controller/pcie-brcmstb.c
> b/drivers/pci/controller/pcie-brcmstb.c
> index 0e0ca39a680b..3e48d9e238bb 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -972,7 +972,6 @@ static void __brcm_pcie_remove(struct brcm_pcie
> *pcie)
> brcm_pcie_turn_off(pcie);
> brcm_pcie_regulator_disable(pcie);
> clk_disable_unprepare(pcie->clk);
> - clk_put(pcie->clk);
> }
> =20
> static int brcm_pcie_remove(struct platform_device *pdev)
> --
> 2.21.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

