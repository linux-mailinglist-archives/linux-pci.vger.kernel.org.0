Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5567B20A6
	for <lists+linux-pci@lfdr.de>; Thu, 28 Sep 2023 17:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjI1PMb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Sep 2023 11:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjI1PMa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Sep 2023 11:12:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482E91A8;
        Thu, 28 Sep 2023 08:12:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985B9C433C8;
        Thu, 28 Sep 2023 15:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695913948;
        bh=Hqro9VXE8P3Msf+mPt73qlFFXuWRyTwJYSf6N/jB9S8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hkvv3AjwF/FfBT73XOvjTQwBEZPy4TELmLlrWZAlrlcHVwS8LNs1grrP2kQvGs/sw
         gJ5Jv9FIoREU7cFRso6OSBO1NQ5aJOLlkYXME2ONDicgTAIl1PEmk0qcfvQ5kcczep
         Tptem295Ky7EmOX08ySvAU26pv0SH+rpmH2GiwFV/dZczgzkWZpn6GWVpVCURFQu33
         5d0hr2TpiEV9SEhwWSuVeVXcG4Z8cQBqzsa6K14wZMI2zI6rfhf4TgzR+0yMxhULwp
         4q3JK6jU17E+HsvgqmOH5XXBSWlDd03Zw+U1XrLYQG/qL0CKQwfrAvhSB6Oy4ndFk3
         SVu7vsoJ3TpLg==
Received: (nullmailer pid 512608 invoked by uid 1000);
        Thu, 28 Sep 2023 15:12:26 -0000
Date:   Thu, 28 Sep 2023 10:12:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jian Yang <jian.yang@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Chuanjia.Liu@mediatek.com, Jieyy.Yang@mediatek.com,
        Qizhong.Cheng@mediatek.com
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: mediatek-gen3: Add support for
 controlling power and reset
Message-ID: <20230928151226.GA424754-robh@kernel.org>
References: <20230928105819.5161-1-jian.yang@mediatek.com>
 <20230928105819.5161-2-jian.yang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928105819.5161-2-jian.yang@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 28, 2023 at 06:58:20PM +0800, Jian Yang wrote:
> From: "jian.yang" <jian.yang@mediatek.com>
> 
> Add new properties to support control power supplies and reset pin of
> a downstream component.
> 
> Signed-off-by: jian.yang <jian.yang@mediatek.com>
> ---
>  .../bindings/pci/mediatek-pcie-gen3.yaml      | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> index 7e8c7a2a5f9b..32031362db58 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -84,6 +84,26 @@ properties:
>      items:
>        enum: [ phy, mac ]
>  
> +  pcie1v8-supply:
> +    description:
> +      The regulator phandle that provides 1.8V power from root port to a
> +      downstream component.
> +
> +  pcie3v3-supply:
> +    description:
> +      The regulator phandle that provides 3.3V power from root port to a
> +      downstream component.
> +
> +  pcie12v-supply:
> +    description:
> +      The regulator phandle that provides 12V power from root port to a
> +      downstream component.
> +
> +  dsc-reset-gpios:

This should be in the downstream component if it is something extra. So 
not the root port node, but the next one down. 

> +    description:
> +      The extra reset pin other than PERST# required by a downstream component.
> +    maxItems: 1
> +
>    clocks:
>      minItems: 4
>      maxItems: 6
> @@ -238,5 +258,10 @@ examples:
>                        #interrupt-cells = <1>;
>                        interrupt-controller;
>              };
> +
> +            pcie@0 {

Missing 'reg'.

> +              device_type = "pci";
> +              pcie-3v3-supply = <&pcie3v3_regulator>;

This is in the root port (which is good), but you've defined the schema 
to put them in the host bridge node. IOW, these need to go in a PCI 
root-port or P2P bridge schema which doesn't yet exist. I have an 
inprogress branch for dtschema to split up pci-bus.yaml for that 
purpose. Will try to finish it up soon.

Rob
