Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8948578BD8
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jul 2022 22:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbiGRUeJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jul 2022 16:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbiGRUeH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jul 2022 16:34:07 -0400
X-Greylist: delayed 256 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Jul 2022 13:34:06 PDT
Received: from mailserv1.kapsi.fi (mailserv1.kapsi.fi [IPv6:2001:67c:1be8::25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1497D13F0A;
        Mon, 18 Jul 2022 13:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=ext.kapsi.fi; s=20161220; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:To:Cc:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FUjmCWMfdylwcInvEYUETAOsUwria0g3AbZHAKaUqW4=; b=EiuExEjkHryQbrY2xtFWxciW8/
        wmOX4ticI+z8wKgudBCEpmKQnPLWBqeRfXPy7hbEuWRWIb7bmCWwybqXL6RqkKiQp1SONswG/emUj
        /Y3xDXeLci6GHkJVXzvEpBJ0r75D1ShgkkUiLJ5X94tzwrcA5PEGus1AnQJO1sfQTa+Lz7iHZFjgK
        ZprwbtwzHxZBN1QaAylr6DFBiNDgkizxzZ+wBnHh0CpSjLnMq/Bot1qYNovQsSw6so9jOx4ryqoMZ
        r7AC/bnnbLzjpB4E3kcU7hz2wO9R69EuNTxaZzROXcQ2yaRTOJu0T9ZA86puICDgBLhu6CfFbk7Xn
        vKOrxd6w==;
Received: from a82-197-11-249.mpynet.fi ([82.197.11.249]:56892 helo=[10.0.2.15])
        by mailserv1.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <maukka@ext.kapsi.fi>)
        id 1oDXRG-00G7Ns-E6; Mon, 18 Jul 2022 23:33:59 +0300
Message-ID: <61920aeb-3abc-e1c2-d40d-f4736db7eb76@ext.kapsi.fi>
Date:   Mon, 18 Jul 2022 23:33:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     maukka@ext.kapsi.fi, bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        linux@armlinux.org.uk, lpieralisi@kernel.org, kw@linux.com,
        thomas.petazzoni@bootlin.com, pali@kernel.org
Content-Language: en-US
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220718202843.6766-1-maukka@ext.kapsi.fi>
 <20220718202843.6766-3-maukka@ext.kapsi.fi>
From:   Mauri Sandberg <maukka@ext.kapsi.fi>
In-Reply-To: <20220718202843.6766-3-maukka@ext.kapsi.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 82.197.11.249
X-SA-Exim-Mail-From: maukka@ext.kapsi.fi
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH 1/6] dt-bindings: PCI: mvebu: Add orion compatible
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mailserv1.kapsi.fi)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This one is include in the set by a mistake, please ignore it.
Apologies.

On 18.07.22 23:28, Mauri Sandberg wrote:
> Add a compatible string to bindings to indicate that orion5x PCIe is
> supported too.
> 
> Signed-off-by: Mauri Sandberg <maukka@ext.kapsi.fi>
> ---
>   Documentation/devicetree/bindings/pci/mvebu-pci.txt | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mvebu-pci.txt b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
> index 6d022a9d36ee..ced5d030fe55 100644
> --- a/Documentation/devicetree/bindings/pci/mvebu-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
> @@ -7,6 +7,7 @@ Mandatory properties:
>       marvell,armada-xp-pcie
>       marvell,dove-pcie
>       marvell,kirkwood-pcie
> +    marvell,orion5x-pcie
>   - #address-cells, set to <3>
>   - #size-cells, set to <2>
>   - #interrupt-cells, set to <1>
