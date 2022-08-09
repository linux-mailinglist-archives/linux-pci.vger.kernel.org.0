Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F4858E01A
	for <lists+linux-pci@lfdr.de>; Tue,  9 Aug 2022 21:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245608AbiHITV4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Aug 2022 15:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346699AbiHITVJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Aug 2022 15:21:09 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CAFE6
        for <linux-pci@vger.kernel.org>; Tue,  9 Aug 2022 12:21:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 97553CE193D
        for <linux-pci@vger.kernel.org>; Tue,  9 Aug 2022 19:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C2BC433D6;
        Tue,  9 Aug 2022 19:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660072864;
        bh=tKMYoRRNrw7s9C1u1VUizQSkNhOJEAukDhZ5r3U923c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=U8yvOBycT+Ib1E2+PR98/FayttiKC9Otp2p8gnB5cQnlURjyMyLMfC6NxmC5PdWVY
         Ydu7V0Ib0ucTeQClxXazs9yxSJh81CSjPQmbFQ75R64F05d5vmdC3PeGxKgPwisFqJ
         Fw4P9+6fGLPuBg/Ggtnhzs6H9q8TnQ6w8H4eLafiKze97QFvn6cGO+KBWoADO2/G+D
         qMO37QVVXTnXpxHjefJpqHd2oLkN0lsQQ70cebYf7CxqR0pHvBISLDU26pv1ulIp14
         tiDxyBNx2BNLQsRSceJ009vzmWpReSV8UfZFGgmVu4jXBK6NhPZrXNv3hghwjiPVC5
         1FCQf+jtm364A==
Date:   Tue, 9 Aug 2022 14:21:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        bhelgaas@google.com, gregkh@linuxfoundation.org,
        linux-pci@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION] changes to driver_override parsing broke DPDK script
Message-ID: <20220809192102.GA1331186@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809112943.393684af@hermes.local>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc regressions list]

23d99baf9d72 appeared in v5.19-rc1.

On Tue, Aug 09, 2022 at 11:29:43AM -0700, Stephen Hemminger wrote:
> This commit broke the driver override script in DPDK.
> This is an API/ABI breakage, please revert or fix the commit.
> 
> Report of problem:
> http://mails.dpdk.org/archives/dev/2022-August/247794.html
> 
> 
> commit 23d99baf9d729ca30b2fb6798a7b403a37bfb800
> Author: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Date:   Tue Apr 19 13:34:28 2022 +0200
> 
>     PCI: Use driver_set_override() instead of open-coding
>     
>     Use a helper to set driver_override to the reduce amount of duplicated
>     code.  Make the driver_override field const char, because it is not
>     modified by the core and it matches other subsystems.
>     
>     Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>     Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>     Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     Link: https://lore.kernel.org/r/20220419113435.246203-6-krzysztof.kozlowski@linaro.org
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> 
> The script is sending single nul character to remove override
> and that no longer works.
> 
> Source code to dpdk-devbind
> https://github.com/DPDK/dpdk/blob/main/usertools/dpdk-devbind.py
