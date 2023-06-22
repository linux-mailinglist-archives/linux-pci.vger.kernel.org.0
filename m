Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0736739692
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jun 2023 06:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjFVE6j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jun 2023 00:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjFVE6i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Jun 2023 00:58:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB171E9
        for <linux-pci@vger.kernel.org>; Wed, 21 Jun 2023 21:58:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 469C56170C
        for <linux-pci@vger.kernel.org>; Thu, 22 Jun 2023 04:58:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545AAC433C0;
        Thu, 22 Jun 2023 04:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687409916;
        bh=rge/2u0Iuk/kNy6EnSWc/h4MkHuXykVeDA7hSKlF7nQ=;
        h=Date:To:Cc:From:Subject:From;
        b=VNibOnoOk+8OOi6PncQKfA6N5anTQ5Ov8vP/id50dgB+uJpdd60lgm6Fp02m2BXWq
         7u+SWvdxZrnbfwpuFprQwgz261OgFNKut2cVpQaBfFWcDglAnwgZIJyPLEVUiQUfLd
         +kbarK/6b/w64PbsZkwOnQ2ASD357ftrxmtkrxFclBWOUtJBYtPFDGyjUZHhQ9FMVH
         1ZHx8bkIY7Ig5U+3hUSkq0dzyaKoPQ1uOI7swCM2EmnzR6MPWY5hAzWlT1kaDT+A67
         TceZWqR8nKhc5E/Px/PwXirX603s8SH7B98V3bQHLRrQieA1b4fifhaCGQYgJy+FC/
         0iFHm67LNPkJQ==
Message-ID: <d023a76f-93af-4112-7020-d888bb8a0ee3@kernel.org>
Date:   Thu, 22 Jun 2023 13:58:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Subject: Rockchip fixes
Organization: Western Digital Research
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn,

I still do not see Rick's series queued in pci/next to fix the Rockchip endpoint
driver...

https://lore.kernel.org/linux-pci/20230418074700.1083505-1-rick.wertenbroek@gmail.com/

Did this one fall through the cracks ? It was posted and fully reviewed last
cycle. Really need that one upstream.

Or is it in some other branch ?

-- 
Damien Le Moal
Western Digital Research
