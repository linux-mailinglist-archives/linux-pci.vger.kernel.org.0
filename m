Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B04C523F19
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 22:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347905AbiEKUyZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 16:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347892AbiEKUyX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 16:54:23 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCD31C12F5
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 13:54:22 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id p12so3042048pfn.0
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 13:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QV6Lz2aGs3anXJW4RYiy6Oo8doNy37ZheOo8iqMeyZc=;
        b=iA99rpcmBzeEFSjsItohY9n35a4ST68mji3JjLkvtvtg89fRWoyXOiMsMpz5gSC4kx
         x1ghp/xOg0FCXeLNOhGt7aSGYbhxwptIq2IeTWDN2EzDiJ7W4hKdsh3oRc/ULM5rSfWu
         Zyo+/1u6z+YD+rNsuDe+kTrAmVgIZHu8DDXz1ZxoI91iqxBs71HZRHxxHnYiZPjy4Yl0
         rlOD/qDIa+6SMUbmiBacTswBVDTVbU4jmeKDUjH5P4u+u4jSzum1wxUgZSESlqC55FAR
         Q/kDi6zuwb48bfUHblH2aGPxoCgoGtmMB3SasPrZggdMFsVPdP/GGLIrEnmBRjgshEdH
         DSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QV6Lz2aGs3anXJW4RYiy6Oo8doNy37ZheOo8iqMeyZc=;
        b=vccEFqRrjj+0PksQ68AqSZoHMgoFCX7pguPF8rHckfET3NTTWFbrdDfloArFZlrpww
         6dWwRzOIEJvDdINaqE/Y+SXEyyqkj5udxtiup0+gESFW07tpYyh1rzo4fskveuMF0yMU
         jhkt4StWJXhOBd+fFFeOON5DnjVtgxA76/ZdNz71OnNXb8nhMbOZCmqhuwSK1JbzyYGL
         GmZaDtCjV0NGaLaXOOKVQpxp1WcMBsBpGsfeuN/oKPCJYlR9dOeL8VeqR4Xc6Pc1uJ0P
         SE4lCcsvjeWH9pxNyUVCvVJbHL7duF3rREcMe2HLj2g7d1HaKfjByCuhm5vsXHmu+tmI
         2PVQ==
X-Gm-Message-State: AOAM531ooTNVZ2W/i8xR9elh8JF0XFKwpZat+doBhmjtLhvE4NIwebQq
        P4de3Mz16TlAcenHROKAy8M=
X-Google-Smtp-Source: ABdhPJzr8f9t0y8LGvXFf9E1amAAkPWPQmK7W4sPkYo8GzGbDOSDYoPTWukDpxE5xoYHHmtYoOcBjw==
X-Received: by 2002:a65:6954:0:b0:3c6:42cd:bd38 with SMTP id w20-20020a656954000000b003c642cdbd38mr21863158pgq.331.1652302462089;
        Wed, 11 May 2022 13:54:22 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id q5-20020a170903204500b0015e8ddeac5dsm2240770pla.252.2022.05.11.13.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 13:54:21 -0700 (PDT)
Message-ID: <aaa4b4d5-486d-869c-10b7-f88c87c450fd@gmail.com>
Date:   Wed, 11 May 2022 13:54:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 0/4] PCI: brcmstb: Revert subdevice regulator stuff
Content-Language: en-US
To:     Cyril Brulebois <kibi@debian.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
References: <20220511201856.808690-1-helgaas@kernel.org>
 <f9be7d36-d670-ef6c-8877-5b38e828e97f@gmail.com>
 <20220511203946.nr2qqzjlintrgxmi@mraw.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220511203946.nr2qqzjlintrgxmi@mraw.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/11/22 13:39, Cyril Brulebois wrote:
> Florian Fainelli <f.fainelli@gmail.com> (2022-05-11):
>> How about we get a chance to fix this? Where, when and how was this even
>> reported?
> 
> I started downstream:
>    https://bugs.debian.org/1010365
> 
> did some more debugging and moved upstream (the link is mentioned in
> each commit message) roughly 10 days ago:
>    https://bugzilla.kernel.org/show_bug.cgi?id=215925
> 
> As I wrote in response to Thorsten Leemhuis (regressions@), who looped
> in a bunch of people:
> 
>     I had spent so much time bisecting that issue that I concentrated on
>     trying to summarize it properly in Bugzilla, failing to check
>     reporting guidelines and best practices (I even missed the
>     Regression: yes flag in my initial submission).
> 
> Again, sorry for failing to notify everyone in the first place, I tried
> to have the contents of the report squared away.
> 
> That being said, as mentioned on regressions@ & linux-pci@, I'm happy to
> test any attempts at fixing the issue, instead of a full-on revert. I'll
> also try to track mainline more closely, so that such obvious issues
> don't go unnoticed for ~1.5 release cycles.

No worries, I don't have a CM4 board at the moment but will try to order 
one so we can get to the bottom of this quicker.
-- 
Florian
