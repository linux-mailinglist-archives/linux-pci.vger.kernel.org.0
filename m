Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3346E5587
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 01:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjDQX6g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 19:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjDQX6g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 19:58:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B391101;
        Mon, 17 Apr 2023 16:58:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA0166125D;
        Mon, 17 Apr 2023 23:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4762CC433D2;
        Mon, 17 Apr 2023 23:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681775914;
        bh=PGFpD0GYJaRNOFKJZnEXcZ1DrsfKc5ed2PJqcpwgF0Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nkKVN+uXGoAHBDbhVk0vwkXzGy4vq0aSTi6Rkyf1FmaXdT9VhjSTRBU9COpHZKL9A
         mViTITPqYY3by3YMdcI00WF0wjkw46as3/ebDlcJZrMy2a+eaK6XcxyPkOK6r2mYMu
         7djRfu37gZM2mFS+J5BzMDgzuJrlScxbD2sP1FsxSdwGjpl/VaII5aSe08oPHbFc78
         sO0Nncgm8+UkIzPxttrPigHu3W6nLd/DvynDiSoTcaiQWlMGqy/AxuohT+g4ARMjLT
         nHlvgde9DeCLRb6dPm7fzUBG20fnZRrqtUgNd3QjM4PJCZO9J58o2mjVzHexY8nd6A
         d/a6tCUHC0J6A==
Message-ID: <d4e5d8c8-52ef-3a6c-64a9-ea6c499cb5f0@kernel.org>
Date:   Tue, 18 Apr 2023 08:58:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 01/11] PCI: rockchip: Remove writes to unused registers
Content-Language: en-US
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        alberto.dassatti@heig-vd.ch
Cc:     xxm@rock-chips.com, Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>,
        Caleb Connolly <kc@postmarketos.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230417092631.347976-1-rick.wertenbroek@gmail.com>
 <20230417092631.347976-2-rick.wertenbroek@gmail.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230417092631.347976-2-rick.wertenbroek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/17/23 18:26, Rick Wertenbroek wrote:
> Remove write accesses to registers that are marked "unused" (and
> therefore read-only) in the technical reference manual (TRM)
> (see RK3399 TRM 17.6.8.1)
> 
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> Tested-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


