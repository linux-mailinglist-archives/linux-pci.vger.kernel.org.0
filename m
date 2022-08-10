Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323B858E90B
	for <lists+linux-pci@lfdr.de>; Wed, 10 Aug 2022 10:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiHJIuK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Aug 2022 04:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiHJIuH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Aug 2022 04:50:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCBC6D567
        for <linux-pci@vger.kernel.org>; Wed, 10 Aug 2022 01:50:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 891F460FA6
        for <linux-pci@vger.kernel.org>; Wed, 10 Aug 2022 08:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B911C433D7;
        Wed, 10 Aug 2022 08:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660121405;
        bh=uX0qx6JS7G4I1Ll9bxyuKI02HeVaRxAtbCIIk3YzWBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KoDnu+s5ygOxN9ES/uPtnZGLXUYcIbvJpKb/4oPRmcUiiyn581KCPjjo8ofrl9fh3
         CxMrV1KLLEfF/K9fMv5u040ASvVUMvN/XMp64GJtIqMgReoqi9zzZn5+44Qg+CzHoi
         2pkaV1YS9wD2lcBtEXqxx+4CoDbWt/VbK6mCj6WA=
Date:   Wed, 10 Aug 2022 07:45:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [REGRESSION] changes to driver_override parsing broke DPDK script
Message-ID: <YvNGFTD/XjXpwWnk@kroah.com>
References: <20220809112943.393684af@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809112943.393684af@hermes.local>
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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

Ah, that's messy.  I'll try to fix up driver_override() to handle a \0
being sent as the string, we should treat that as an empty write.  Let
me think about that later today...

thanks,

greg k-h
