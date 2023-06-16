Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8965732F66
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jun 2023 13:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245370AbjFPLFX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jun 2023 07:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345668AbjFPLFB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jun 2023 07:05:01 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0E483DF;
        Fri, 16 Jun 2023 03:59:09 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b43a99c887so6646501fa.2;
        Fri, 16 Jun 2023 03:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686913148; x=1689505148;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dUWCxuHQ8in5DxE2T0YCH5bwAXst66aM81pUfth5QkM=;
        b=fz8zCd5w8W6aAZ+vJQ7uwA8T3b6dQH2EaG6ukoYeiQGvCILCxDCNVt+nRMeMar9a5p
         V6YeuitHvCXWxWgH1hldRyV1GgBQphnJznkVx8zuicOpR7pVzJLRlAHWPkzV5t3QrQXG
         ln4XCHrGSU5NfXHOoGo37yNYyz13XUqsGLYqYiTOjit9Cw3JLTbaVrFY5ZK1SWwtLXAh
         cZgl5qxN8PL1glHOyAQVBnKs5H2iu2R+UjffVIAwfXjH2B+kGLxq0sTzzyj7I/gFUxKj
         H9Ztl0+DCT9lWglC5npWWORzuO16o20XLuN8AR2y+DLsYaxhwdoGGoSV1YOhhJm2g+iI
         8gIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686913148; x=1689505148;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dUWCxuHQ8in5DxE2T0YCH5bwAXst66aM81pUfth5QkM=;
        b=I6m4dZmHj4uRRPqPTSaGwCQu5zga9Gz/aZr078vv4RXp8reUkH7DONGc52pU388iIz
         2Gn4/WsfQk7nNDBAyOd6blCyTTak5NO/3L6Ld8L4Mfzs7yj21IIUekcM5f6Ak6jVdy6W
         xg/sQKBq9uKpunYriTYJbIaUubfTi1UWo4odzwl0dHuzXxeh2bhP742HTJf6DR/nQhAU
         5ruReDieeaPYNlYQLzIaQHZLdbbQ+r1VzdykmNHVttVvufNK39ouy/6I75ipUsNov5sp
         d0oJlTw/7mp8Es9vhlWEdm/iCHgz/aeINkSoCv/ZKq8Ywh7J00pLsZg0ExivW0shfkiC
         ws1A==
X-Gm-Message-State: AC+VfDwML9oSVLE9Y4+tq7yigrNVvyMyIhIFY6kCZ6x7W8dhE5DJtMRv
        MOcgmZkPms2sQvApEfmd07AYQgGbSG150XPx
X-Google-Smtp-Source: ACHHUZ6kOEnIBIg2UJAOJAWbU63kq1NhzKdzBsq1h9lx/I7J6dicurWwVVj1+Nb2b6TuNuoulJMefA==
X-Received: by 2002:a19:e019:0:b0:4f6:ab8:bc12 with SMTP id x25-20020a19e019000000b004f60ab8bc12mr1358190lfg.20.1686913147774;
        Fri, 16 Jun 2023 03:59:07 -0700 (PDT)
Received: from ?IPV6:2a0b:6204:4302:5f00:f401:444b:6444:44af? ([2a0b:6204:4302:5f00:f401:444b:6444:44af])
        by smtp.gmail.com with ESMTPSA id d24-20020ac25458000000b004f8424ed05esm704884lfn.63.2023.06.16.03.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 03:59:07 -0700 (PDT)
From:   "bibo, mao" <bibo.mao@gmail.com>
X-Google-Original-From: "bibo, mao" <maobibo@loongson.cn>
Message-ID: <8e310bd1-1fbc-36f7-7abc-5553fc20a85d@loongson.cn>
Date:   Fri, 16 Jun 2023 18:59:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4] PCI: Align pci memory space base address with page
 size
To:     Will Deacon <will@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn
References: <20230609022047.2195689-1-maobibo@loongson.cn>
 <20230616093116.GA10423@willie-the-truck>
In-Reply-To: <20230616093116.GA10423@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2023/6/16 17:31, Will Deacon 写道:
> On Fri, Jun 09, 2023 at 10:20:47AM +0800, Bibo Mao wrote:
>> Some PCI devices have only 4K memory space size, it is normal in general
>> machines and aligned with page size. However some architectures which
>> support different page size, default page size on LoongArch is 16K, and
>> ARM64 supports page size varying from 4K to 64K.
> 
> Shouldn't we also select this new Kconfig option on arm64 then?
OK, will add this option on arm64 also in next version.

Regards
Bibo, Mao

> 
> Will
