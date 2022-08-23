Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760C459E8F0
	for <lists+linux-pci@lfdr.de>; Tue, 23 Aug 2022 19:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344706AbiHWRQT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Aug 2022 13:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244541AbiHWROx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Aug 2022 13:14:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E9D100977;
        Tue, 23 Aug 2022 06:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F8386154C;
        Tue, 23 Aug 2022 13:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BCBC433C1;
        Tue, 23 Aug 2022 13:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661262023;
        bh=2+G8RngWyxAqke4bxt5usQSl46UvUFATARmSK6gRm08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UR4Yhx5x3P7UUehzGuqNuzCVIf2gG92TqIHiUZCgn2xLTwYRb2BVaZrDxywPFMTuS
         DfZsw9vCLLbY7N/bQZC23Zkjy41FwvdEeo5Tun5uOeKnzCyF74pyaeEisT3P6+PjEs
         BsgOioP5FYI114KFoLroQy1P5Lnh4LYS0nwkjlMLhNMEg8PJQXqgj+lwFwiN+c9KN8
         8lYKt4V/iCZLVw0/KJPCUfWw+PNu4zvZrY0ehvbtPOVGWPXckhaBR3eX9u+geCzmem
         W4PXWcPnwonjUG5yfZfHDDOds0GFC5E483C5vp3iorMnxsgwARYXAeEgllZNj0blXb
         AiehE9Npm4yuQ==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        Rex-BC.Chen@mediatek.com, Liju-clr.Chen@mediatek.com,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jian.Yang@mediatek.com, TingHan.Shen@mediatek.com
Subject: Re: [PATCH v4] dt-bindings: PCI: mediatek-gen3: Add support for MT8188 and MT8195
Date:   Tue, 23 Aug 2022 15:40:15 +0200
Message-Id: <166126199986.63298.9651112044432926221.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220802120624.19258-1-jianjun.wang@mediatek.com>
References: <20220802120624.19258-1-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2 Aug 2022 20:06:24 +0800, Jianjun Wang wrote:
> MT8188 and MT8195 are ARM platform SoCs with the same PCIe IP as MT8192.
> 
> Also add new clock name "peri_mem" since the MT8188 and MT8195 use clock
> "peri_mem" instead of "top_133m".
> 
> 

Applied to pci/dt, thanks!

[1/1] dt-bindings: PCI: mediatek-gen3: Add support for MT8188 and MT8195
      https://git.kernel.org/lpieralisi/pci/c/7f08e806a03e

Thanks,
Lorenzo
