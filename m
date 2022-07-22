Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDFF57E93E
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 23:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbiGVVzK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jul 2022 17:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbiGVVzJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2022 17:55:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0E7B55;
        Fri, 22 Jul 2022 14:55:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E3FD6219D;
        Fri, 22 Jul 2022 21:55:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91129C385A5;
        Fri, 22 Jul 2022 21:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658526907;
        bh=h9i8TGdwTjPY0igjGyV++2mxwKyAmG2cvztwvqW4Huk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aWJCPhaG+QOZh0VOxh4GKs5wut+5/pWon1H04G+spPkaO0UxezmV7+o8UOctLPBoB
         OvA+J4TK3ncl1f0xtYR4CIZWWBwOqBMtGMfa8K+2RlnyFxwg7AlOY7r/5RsmfLXpCi
         qzyFPzY9yfkCxRHRQjQGP+TrS4agXTo0tT08jBCQ3k9yRpZNrMGPL4Ky1bkaicbr6R
         g10z9xEnDk7fC17wr5NKS4HC84xIMTY5xVPPdrlEqygJ5RIuLTukU1Nwko0yoa/BNu
         eC4ipsuVSH8nnCk/Z0C+CZx7uVaxV6CaK2G9LnFhfZC47LySaE8+l2orLBqbcwMqi+
         gzGyWRw8Ps6Og==
Received: by mail-vs1-f42.google.com with SMTP id k129so5484502vsk.2;
        Fri, 22 Jul 2022 14:55:07 -0700 (PDT)
X-Gm-Message-State: AJIora+h+DPqZK3xLJVO5q1UT/qN2zpSscNt75U7rEiFYeEjFnmkFaMN
        nFa265Aqbngb7P6nAoh0Yj+kjYYeGVxwulw4Zw==
X-Google-Smtp-Source: AGRyM1uRewCBeul1qyf913SX/dTS7WokF9cwfziUu2eLZi3AIRfJCbSRgNJjwKD9m8vxiakRTPN5yMyz1tVKE65zCg4=
X-Received: by 2002:a05:6102:162b:b0:358:418a:4e57 with SMTP id
 cu43-20020a056102162b00b00358418a4e57mr836203vsb.26.1658526906410; Fri, 22
 Jul 2022 14:55:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220721142052.25971-1-vidyas@nvidia.com> <20220721142052.25971-15-vidyas@nvidia.com>
In-Reply-To: <20220721142052.25971-15-vidyas@nvidia.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 22 Jul 2022 15:54:55 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+rzy2Y8sD3BhNMxu5QoGHC8gc_oFWiwnpgf_Y1xEnARw@mail.gmail.com>
Message-ID: <CAL_Jsq+rzy2Y8sD3BhNMxu5QoGHC8gc_oFWiwnpgf_Y1xEnARw@mail.gmail.com>
Subject: Re: [PATCH V6 14/16] PCI: tegra194: Fix link up retry sequence
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof Wilczynski <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krishna Thota <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        sagar.tv@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 21, 2022 at 8:22 AM Vidya Sagar <vidyas@nvidia.com> wrote:
>
> Add the missing DLF capability offset while clearing
> DL_FEATURE_EXCHANGE_EN bit during link up retry.
>
> Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V6:
> * New addition in V6 based on Bjorn's review comment

Fixes first, then features. This either be first or not even in this
series. Unless you want to wait on the whole thing to be reviewed.

Though between this and patch 10, I wonder if this driver even worked upstream?

>
>  drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
