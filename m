Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4545F1D66
	for <lists+linux-pci@lfdr.de>; Sat,  1 Oct 2022 17:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiJAP4f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 Oct 2022 11:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiJAP4d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Oct 2022 11:56:33 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685751116D;
        Sat,  1 Oct 2022 08:56:31 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 18CFB2800B3C7;
        Sat,  1 Oct 2022 17:56:27 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id F3DA56DC9B; Sat,  1 Oct 2022 17:56:26 +0200 (CEST)
Date:   Sat, 1 Oct 2022 17:56:26 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lpieralisi@kernel.org,
        kw@linux.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
        mani@kernel.org, Sergey.Semin@baikalelectronics.ru,
        jszhang@kernel.org, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: Re: [PATCH V1 1/4] dt-bindings: Add "hotplug-gpios" PCIe property
Message-ID: <20221001155626.GA9324@wunner.de>
References: <20220930192747.21471-1-vidyas@nvidia.com>
 <20220930192747.21471-2-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930192747.21471-2-vidyas@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 01, 2022 at 12:57:44AM +0530, Vidya Sagar wrote:
> Provide a way for the firmware to tell the OS about the GPIO that can be
> used to get the Hot-Plug and Unplug events.
[...]
> --- a/Documentation/devicetree/bindings/pci/pci.txt
> +++ b/Documentation/devicetree/bindings/pci/pci.txt
> @@ -32,6 +32,10 @@ driver implementation may support the following properties:
>     root port to downstream device and host bridge drivers can do programming
>     which depends on CLKREQ signal existence. For example, programming root port
>     not to advertise ASPM L1 Sub-States support if there is no CLKREQ signal.
> +- hotplug-gpios:
> +   If present this property specifies the GPIO to be used for Hot-Plug/Unplug
> +   functionality. It is used by the PCIe GPIO Hot-Plug core driver for
> +   PCIe device Hot-Plug/Unplug events.

Please specify the GPIO's semantics in more detail:
Is the pin high as long as presence of a card is detected?
Or does it pulse when a hotplug/unplug event occurs?

Thanks,

Lukas
