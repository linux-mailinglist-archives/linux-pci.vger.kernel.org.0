Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32F0765754
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jul 2023 17:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbjG0PVd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jul 2023 11:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjG0PVc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jul 2023 11:21:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A791BC1;
        Thu, 27 Jul 2023 08:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=HbvXpPPcY/mtss3n7QDDW7e1ZzXg2VcdFJci2fYdwG0=; b=itsRPG4Zd+Hxc1LA8yWHqGSMMU
        r3CcuytBqmQwN3uD1pcwqmAI4b+DcyhJLuQn3q/UC9+BVmO8XZk41yfWB13Tk0L5SvlSZBqotnbyc
        yDJ1id6FPpHzJSr9OlTqxN36CsVNHh6qoieC8HWG242oz4sk8SBABIrAUv8cIyhMWXhmMqMfhXg1V
        Kao51wMBx63OTvJO7Mr3vI2cZEtOssByqK8EhA9JR/vO0SqlJScLoF++8dFgQw6Oe/WBb3lQ1ytCY
        u6fRmFlaArJKqbKPCBo83HGC56wWBFf8+t/Bp2vI7oO5bLrQXMM38ZjXPUIG0UifzQ92g4/8TYMLp
        N5vztD6Q==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qP2ni-00FoB8-1s;
        Thu, 27 Jul 2023 15:21:14 +0000
Message-ID: <6e85db42-b946-14a5-fe2b-d90f01cb24d2@infradead.org>
Date:   Thu, 27 Jul 2023 08:21:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/4] PCI: plda: Get common codes from Microchip
 PolarFire host
Content-Language: en-US
To:     Minda Chen <minda.chen@starfivetech.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
References: <20230727103949.26149-1-minda.chen@starfivetech.com>
 <20230727103949.26149-3-minda.chen@starfivetech.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230727103949.26149-3-minda.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi--

On 7/27/23 03:39, Minda Chen wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8e4f9d5dca55..ec59c6d00bf9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16170,6 +16170,14 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/cdns,*
>  F:	drivers/pci/controller/cadence/
>  

This new entry is not in the correct location.
It should be in alphabetical order, so it goes between

PCI DRIVER FOR NXP LAYERSCAPE GEN4 CONTROLLER
and
PCI DRIVER FOR RENESAS R-CAR

Thanks.

> +PCI DRIVER FOR PLDA PCIE IP
> +M:	Daire McNamara <daire.mcnamara@microchip.com>
> +M:	Kevin Xie <kevin.xie@starfivetech.com>
> +L:	linux-pci@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/pci/plda,*
> +F:	drivers/pci/controller/plda/*plda*
> +
>  PCI DRIVER FOR FREESCALE LAYERSCAPE
>  M:	Minghuan Lian <minghuan.Lian@nxp.com>
>  M:	Mingkai Hu <mingkai.hu@nxp.com>

-- 
~Randy
