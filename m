Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6D4665782
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 10:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbjAKJc2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 04:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbjAKJbm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 04:31:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A86D120AE;
        Wed, 11 Jan 2023 01:30:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A73961B19;
        Wed, 11 Jan 2023 09:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0ABC433EF;
        Wed, 11 Jan 2023 09:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673429421;
        bh=pNfMIqO9t73o1w5Ym2sYx549qBwB7dkKL+u78E64yg0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FsueOTAIOrGEA4Pg+SXHDGPjBZcoJL8km4y68X6NDgXyfStiYknAv7prSI0U7SSxH
         T41K10gPZqOUT5aQhW8WugjDhW9FdCLYPWp62o5OPxywFlCij8WcUFU6Iz8T3YotGP
         R17mf8Xxs+ftPHgXo3Nfirtb/VUa5ZMuDPnH6J4qTcPZxwbm9Pkv39rn8kSj6UciGD
         Q8/V7Gbf8WPAMvb8an9EhdZdDTCg0lJn5Ta3GqsF//PWHp7Dsna+M7GvYc5QzjbxX/
         HZyp1NqIs/ienbF+iUwPo8NypH22x24WNlPCskL95Bdt6/7CIPRGewawNZ8f3bipvM
         GM7ydKRHCrEgA==
Message-ID: <dccfa004-1d40-acc0-6220-9232193b648f@kernel.org>
Date:   Wed, 11 Jan 2023 10:30:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] dt-bindings: PCI: mediatek-gen3: Add support for
 controlling power and reset
Content-Language: en-US
To:     Jian Yang <jian.yang@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        chuanjia.liu@mediatek.com, jieyy.yang@mediatek.com,
        qizhong.cheng@mediatek.com, rex-bc.chen@mediatek.com,
        david-yh.chiu@mediatek.com
References: <20230111032830.20447-1-jian.yang@mediatek.com>
 <20230111032830.20447-3-jian.yang@mediatek.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230111032830.20447-3-jian.yang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/01/2023 04:28, Jian Yang wrote:
> From: "jian.yang" <jian.yang@mediatek.com>
> 
> Add new properties to support control power supplies and reset pin of
> a downstream component.
> 
> Signed-off-by: jian.yang <jian.yang@mediatek.com>

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

> ---
>  .../bindings/pci/mediatek-pcie-gen3.yaml      | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> index 7e8c7a2a5f9b..46149cc63989 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -84,6 +84,29 @@ properties:
>      items:
>        enum: [ phy, mac ]
>  
> +  pcie1v8-supply:
> +    description:
> +      The regulator phandle that provides 1.8V power to downstream component.
> +
> +  pcie3v3-supply:
> +    description:
> +      The regulator phandle that provides 3.3V power to downstream component.
> +
> +  pcie12v-supply:
> +    description:
> +      The regulator phandle that provides 12V power to downstream component.
> +
> +  dsc-reset-gpios:
> +    description:
> +      The reset GPIO of a downstream component.

Why you cannot use standard reset-gpios property?

> +    maxItems: 1
> +
> +  dsc-reset-msleep:

Wrong property unit/suffix.

> +    description:
> +      The delay time between assertion and de-assertion of a downstream
> +      component's reset GPIO.

Why this should be a property of DT?

> +    maxItems: 1

maxItems of what?

> +
>    clocks:
>      minItems: 4
>      maxItems: 6

Best regards,
Krzysztof

