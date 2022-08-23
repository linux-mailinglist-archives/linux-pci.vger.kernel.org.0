Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9DF59E73A
	for <lists+linux-pci@lfdr.de>; Tue, 23 Aug 2022 18:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240411AbiHWQ1K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Aug 2022 12:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241561AbiHWQ0x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Aug 2022 12:26:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E43119466;
        Tue, 23 Aug 2022 05:51:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FA95614C5;
        Tue, 23 Aug 2022 12:51:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44157C433D6;
        Tue, 23 Aug 2022 12:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661259110;
        bh=euzsWs7Ghu5JJlT1IL0uGtLV4JRhHmAKUQE3naTbSic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dd+Aht/Icr7N2Jll4Wg/zI00IwuUSpROwJnZ8p5M7i5Dy2YKJ3Y6HgtblmleWkFOQ
         IgkxjrDNevzQhV+qTAbU3clfCyoAOfymga6STgddxkb6mBWI8q33CEjfI+ylca61Mv
         +VaTLkj5Nc4J76/cJFporhUgz62iPcDrcbKn0IXLT4ZRAePZeMss8vREiF5Lonr+k5
         meverhWuLOosgpjmHi1Tnqi/E8L93qHdZriGoXQWzGm1wZTQQfroxKEqQWqT+h7yr5
         Wck5XKQHD/b9dWetTIG5nBAkrVrNq8stKXboN33brCHr0bm21+/VtkWQzPgtd6W8rj
         fEwJUZzar7iRA==
Date:   Tue, 23 Aug 2022 14:51:41 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ryder Lee <ryder.lee@mediatek.com>, Rex-BC.Chen@mediatek.com,
        TingHan.Shen@mediatek.com, Liju-clr.Chen@mediatek.com,
        Jian.Yang@mediatek.com
Subject: Re: [PATCH v4] dt-bindings: PCI: mediatek-gen3: Add support for
 MT8188 and MT8195
Message-ID: <YwTNXaaotJW/vUT9@lpieralisi>
References: <20220802120624.19258-1-jianjun.wang@mediatek.com>
 <5c14e959-10cc-5520-e88f-b47a195b99e9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c14e959-10cc-5520-e88f-b47a195b99e9@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 03, 2022 at 08:44:11AM +0200, Krzysztof Kozlowski wrote:
> On 02/08/2022 14:06, Jianjun Wang wrote:
> > MT8188 and MT8195 are ARM platform SoCs with the same PCIe IP as MT8192.
> > 
> > Also add new clock name "peri_mem" since the MT8188 and MT8195 use clock
> > "peri_mem" instead of "top_133m".
> > 
> > Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> > ---
> > Changes in v4:
> > Remove "items" for "mediatek,mt8192-pcie" since it only have one item.
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Should I pick this up ?

Thanks,
Lorenzo
