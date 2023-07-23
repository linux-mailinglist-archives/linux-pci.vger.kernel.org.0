Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C47475DFA9
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jul 2023 04:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjGWCDN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Jul 2023 22:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjGWCDM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Jul 2023 22:03:12 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C79138;
        Sat, 22 Jul 2023 19:03:10 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666edfc50deso2073874b3a.0;
        Sat, 22 Jul 2023 19:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690077790; x=1690682590;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eg6TbyeOVcQsY9Q8Ckx4fXoTDSkrQFOQaolkev87oCg=;
        b=HcXcQ5nDr9I47fFsVtJ9AdboECTu8+ij46DkwZYqdSK3Xu/XVL7BgQ6jwIcOtENl3V
         uy0dh4QSZKmo6QmuT5oLISmW4F5b5eTvDnEr4OoAD7aSsjMKkuPaFVpdHnGSLw4ds0Qa
         Z71gF38sgVm0qtYl3v30RAPcd7Up5VwRaYLSHeqvEW53otBzJf8rofWxVRvdDpEqUxqy
         aKy01wNb7M8sJeiL001UhB4OjTYpw/Xn3gET00jnPBIrpOjbxO8pbcooyWK9Ilq5/Ln3
         G+G9tFhm0ogSIdqUTdJDsP2Z2Q/MJ0kdDwUkhHu2VeZe/YsEZ9L6ng8HUyH6wK3qDfuA
         b6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690077790; x=1690682590;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eg6TbyeOVcQsY9Q8Ckx4fXoTDSkrQFOQaolkev87oCg=;
        b=BaEOJ/mWnmqcUpxoY5bY6FnmzzBr5to43LAXv8twSdP+CXZxzuPemBJVin/Y+yTU5s
         UxAAi5S0oNh6ZKbrSUD5nVtC+5XjZJduhH4zzmWkkRP7sHpN8p8+Levf/kXdmBBJjb+V
         lIxRK3bSDnONcz3mEVpuS990zOo4A6OpFtNQSRQy+v27psEJf1mBTxM+qYRXr33r/cQd
         Js1nKFLaKNyH1iasY9ikpVjsPsTjuoe9iLP9wwsnjYXGu3JsooxGCpHPiB7/xcrgcke6
         4R/vT347pSJo1V5rlsd8kTtlXwxCHYtAy8E5GJt1O+6Mb9Z9665YiLqIKPVf3RY0uVPg
         oskw==
X-Gm-Message-State: ABy/qLZeYiVFNtnmBJoq5QBpYp8ml2VJp6LSTlPKuxDaceY1rDTeZczE
        8R/PNr6GiXywYU4RgcRsppY=
X-Google-Smtp-Source: APBJJlGnc1N/Fmf+WcuRP0kVxZ9IoI6ZEidxjh5Pxa5hR3B6RiMbbtYo5KPj5HwB5oAjC+X9qXBtgA==
X-Received: by 2002:a05:6a21:999f:b0:12b:40d3:aeb1 with SMTP id ve31-20020a056a21999f00b0012b40d3aeb1mr9860694pzb.25.1690077790204;
        Sat, 22 Jul 2023 19:03:10 -0700 (PDT)
Received: from [192.168.0.104] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id y8-20020a62b508000000b00663b712bfbdsm5145424pfe.57.2023.07.22.19.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jul 2023 19:03:09 -0700 (PDT)
Message-ID: <871f22f4-c456-db15-3466-085971bd1221@gmail.com>
Date:   Sun, 23 Jul 2023 09:03:03 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>, jiaxun.yang@flygoat.com,
        Aurelien Jarno <aurel32@debian.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Loongarch <loongarch@lists.linux.dev>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: PCI: Loongson: 8b3517f88ff2 breaks PCIe on some system
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> After 8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS increases") backported to stable, we have received multiple regression reports including one from Debian build farm[1] that some systems failed to initialize some PCIe devices.
> 
> I was able to reproduce on one of my Loongson-3A4000+7A system. It seems like the root cause is firmware on those systems didn't set MRRS properly but 8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS increases") assumed firmware's maximum MRRS is always valid.
> 
> [1]: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1035587

See Bugzilla for the full thread.

The linked Debian BTS entry have debugging details on this regression
(boot log, cpuinfo, and lspci).

Anyway, I'm adding this regression to regzbot:

#regzbot introduced: 8b3517f88ff298 https://bugzilla.kernel.org/show_bug.cgi?id=217680
#regzbot title: LS7A MRRS quirk fails to initialize PCIe devices
#regzbot link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1035587

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217680

-- 
An old man doll... just what I always wanted! - Clara
