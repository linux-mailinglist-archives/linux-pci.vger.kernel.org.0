Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CC5425743
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 18:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241470AbhJGQCf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 12:02:35 -0400
Received: from marcansoft.com ([212.63.210.85]:55482 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241403AbhJGQCe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Oct 2021 12:02:34 -0400
X-Greylist: delayed 1018 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Oct 2021 12:02:34 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id C128F419BC;
        Thu,  7 Oct 2021 16:00:34 +0000 (UTC)
To:     Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Joerg Roedel <joro@8bytes.org>, kernel-team@android.com,
        Linus Walleij <linus.walleij@linaro.org>
References: <20210929163847.2807812-1-maz@kernel.org>
 <20210929163847.2807812-11-maz@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v5 10/14] arm64: apple: Add pinctrl nodes
Message-ID: <7b1bdd87-076f-0a7d-5e27-5309e2e415b1@marcan.st>
Date:   Fri, 8 Oct 2021 01:00:32 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210929163847.2807812-11-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 30/09/2021 01.38, Marc Zyngier wrote:
> From: Mark Kettenis <kettenis@openbsd.org>
> 
> Add pinctrl nodes corresponding to the gpio,t8101 nodes in the
> Apple device tree for the Mac mini (M1, 2020).
> 
> Clock references are left out at the moment and will be added once
> the appropriate bindings have been settled upon.
> 
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/r/20210520171310.772-3-mark.kettenis@xs4all.nl
> ---
>   arch/arm64/boot/dts/apple/t8103.dtsi | 83 ++++++++++++++++++++++++++++
>   1 file changed, 83 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
> index a1e22a2ea2e5..503a76fc30e6 100644
[snip]

Looks good. Can you resend just this patch with the apple,npins 
properties added? Once that's settled in the binding (which seems to 
just be waiting on some linter issues) I can merge this and the rest of 
the DT changes through my tree.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
