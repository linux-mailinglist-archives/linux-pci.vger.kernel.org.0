Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C77E6AFFB4
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 08:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjCHHb4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 02:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCHHbz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 02:31:55 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC7A8EA33;
        Tue,  7 Mar 2023 23:31:54 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id r5so17290757qtp.4;
        Tue, 07 Mar 2023 23:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678260714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m+lekfW8SE597I3fxVAXzf1Ag6zuR2v4Z01BX88WWdg=;
        b=KWcqzmmS1gUe2UO4u8EjBOzU97+RzueFRUrkyYDrnIsaWukPPnGScKcXgvEKxBU7R9
         a3CXO/H42MzNhU3qbGrEsl7th8Mw2uBRm6WOzELlKwrxG5hhMCVON0dvj9OXnbzGaO4E
         8vvPL2RomFBVI4yfUNtFG48fvFKYCKcAJ3C5gX4bpUXuyL5XnU0oOoCp8+7nBfxcDQiU
         BHBZ90PXmbF/6v5uINNPjnm1At5X6q37vlUQspTrw1z8dVl8Nq5YSRwu8I/hvuol2DoQ
         TGIwrlzaPoisVwZQ15fEJIne8D8zdi0AyzrIHP8FV2pouKNkvs69OOnX1c3rzlP89NJY
         PhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678260714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m+lekfW8SE597I3fxVAXzf1Ag6zuR2v4Z01BX88WWdg=;
        b=NXFYm9sPHe22lzW4VRQxaUjsT4XiNueRq9l+xmAuxUAt1Dh18LRbWbGYrH6E2NnLUy
         pEiLgJSLMsPZNXQdHmNVCbaC599dtLW8hCTGfDEvw3JHYJchUMCb/tQCvv3RhnoXLTfq
         4rDrmECo1Kaoja4lPjksCgxNM8YOqYeeDXi6AeghzpgY25wMymlbZuKoTuhotSOvSht5
         Q7jF8r74WFQzdxe1tYoV7tcQxCuBuiH8gOqkzkWqpHeG6YHhMFAuic5sC4Ffi8h9jWMz
         DutTh2Fx7bvCT3JVEOVXbN9GuaVBBSz4PsXjSsQKWqAZ0E/AxjzfalUOdfTY9tEyN+4U
         SF0A==
X-Gm-Message-State: AO0yUKV66Ehw6ZkqD4fSr1gT5zTpvuIb+V02hFIGHndG/E6yYwOB9q6h
        IK08jQu+6JYeS9QKuZIf0wY=
X-Google-Smtp-Source: AK7set/GzfyZMC6r1tc162vtRb3NuZXe6pf7PpUrgu4LVmRQ85LWiz6ETC5sv3iUTR34OcFh/IE5mQ==
X-Received: by 2002:ac8:5c13:0:b0:3c0:3b79:9fb0 with SMTP id i19-20020ac85c13000000b003c03b799fb0mr8170442qti.47.1678260713836;
        Tue, 07 Mar 2023 23:31:53 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:4cdf:396a:50a:e093? ([2600:1700:2442:6db0:4cdf:396a:50a:e093])
        by smtp.gmail.com with ESMTPSA id z24-20020ac87cb8000000b003bfa8e1b7d1sm10895654qtv.32.2023.03.07.23.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 23:31:53 -0800 (PST)
Message-ID: <9b4bb45a-f6e4-c95c-d27c-21c7fecb5505@gmail.com>
Date:   Wed, 8 Mar 2023 01:31:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V7 0/3] Generate device tree node for pci devices
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     clement.leger@bootlin.com, Lizhi Hou <lizhi.hou@amd.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, helgaas@kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, larry.liu@amd.com, brian.xu@amd.com,
        stefano.stabellini@xilinx.com, trix@redhat.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Steen.Hegelund@microchip.com" <Steen.Hegelund@microchip.com>,
        "Horatiu.Vultur@microchip.com" <Horatiu.Vultur@microchip.com>,
        "Allan.Nielsen@microchip.com" <Allan.Nielsen@microchip.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
References: <1674183732-5157-1-git-send-email-lizhi.hou@amd.com>
 <af2a6686-ea35-e5fc-7541-27e5d6ca9311@gmail.com>
 <20230227113150.398dcfa7@fixe.home>
 <52b8f136-c73f-a97d-2bb6-48aff3755f98@gmail.com>
 <f927790dc9839cd93902c0d2e5afe5e8@bootlin.com>
 <1886b888-a0e8-b1ee-c48a-ddbc8b5b0c63@gmail.com>
 <CAL_JsqL_ER32ys-yW_7-QKLjEmKK8StOeM5yvH2ChuvX++fe5Q@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CAL_JsqL_ER32ys-yW_7-QKLjEmKK8StOeM5yvH2ChuvX++fe5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/6/23 18:52, Rob Herring wrote:
> On Mon, Mar 6, 2023 at 3:24 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>

< snip >

Hi Rob,

I am in no position to comment intelligently on your comments until I
understand the SoC on PCI card model I am asking to be described in
this subthread.

I'll try to remember to get back to this email once my understanding
is more complete.

-Frank

