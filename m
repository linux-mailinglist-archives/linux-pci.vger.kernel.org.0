Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EB6504A53
	for <lists+linux-pci@lfdr.de>; Mon, 18 Apr 2022 02:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbiDRA65 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 17 Apr 2022 20:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbiDRA65 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Apr 2022 20:58:57 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC9CC643A;
        Sun, 17 Apr 2022 17:56:19 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 18 Apr 2022 09:56:19 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 436FB2058B50;
        Mon, 18 Apr 2022 09:56:19 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 18 Apr 2022 09:56:19 +0900
Received: from [10.212.182.6] (unknown [10.212.182.6])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 50D1DB62B7;
        Mon, 18 Apr 2022 09:56:18 +0900 (JST)
Subject: Re: [PATCH v2 2/2] arm64: dts: uniphier: Remove compatible
 "snps,dw-pcie" from pcie node
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1648617814-9217-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1648617814-9217-3-git-send-email-hayashi.kunihiko@socionext.com>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <b6bd1a3c-f9a4-7e2f-b8ac-0676b9873e08@socionext.com>
Date:   Mon, 18 Apr 2022 09:56:18 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1648617814-9217-3-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/03/30 14:23, Kunihiko Hayashi wrote:
> UniPhier PCIe host controller doesn't use "snps,dw-pcie" compatible, so
> this is no longer needed. Remove the compatible string from the pcie node
> to fix the following warning.
> 
>    uniphier-ld20-akebi96.dtb: pcie@66000000: compatible:
> ['socionext,uniphier-pcie', 'snps,dw-pcie'] is too long
>        From schema:
> Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>   arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 2 +-
>   arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

This patch 2 is for the devicetree and patch 1 has already been merged,
so I'll post it as a new patch series along with other devicetree patches.

Thank you,

---
Best Regards
Kunihiko Hayashi
