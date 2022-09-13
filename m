Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50225B6854
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 09:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiIMHDO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 03:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiIMHDN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 03:03:13 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B58B2C132;
        Tue, 13 Sep 2022 00:03:08 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id s13so8500082qvq.10;
        Tue, 13 Sep 2022 00:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zi/Hgax/DtCoSoa6AKPgDXly+a2EYtz9m5LdTuw4u9s=;
        b=Hg6GLb1JJtkmFqD+lx8nxbPARFjPx4b3MQGCUOZWfvXHeioaOmVTEo2cNtxloqkJA1
         2EqM2ebASEbg/4StWjn6lcA/nj+CM1aYpuH9fuqBd3dK/m0XpW8BrESElsoeFypxhPag
         hIbHFSlNW764TTbfk0f36yX9QvgsDhfH5kI5aBXAYiOMVgOmigmT9yHUDeqZ5j/wIYz+
         OoPdQfMqUtzacDVprTbdGR+jan6vi9aNFVYO2j3RA4cqlE3/GvmMlGmosP1qat3DyeBV
         8VXEvC22FWP/8kchotmhrBQupaOD8bZ/pd7kF2el3bfkSzcJ81E1XS/37lv/fXIGjXho
         SH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zi/Hgax/DtCoSoa6AKPgDXly+a2EYtz9m5LdTuw4u9s=;
        b=VGlmTX+s4392ZvnzuvilC+BHdaPD4QB3GC1vQijmjjosYM276DNefd6LhuOHg8h6Nv
         GVBPlZn2GTxh0yuGjCZXUOrcCbJE3eyPHzbLdYYDzcDQSAPcqqdE7Ue8lTd6NZy5U/XF
         W00ZG6dyNOyAhH0udm3nChw8/1H/sIRLfoNR31ZyTVkcIJz3vsGzh+sob6xd8b+JEG31
         uyRVPWuAmFVi+JRXFrKmZnQ19cNxZh5Vr7W9/Rio9i52rozF/tqLJ0WxuwQnW3EW0gsO
         FYLV/I4sLuIVgkorwO6HkrM5TBHyP03PA0Df/hTZUqAnvEbhFzRXbM9P/DTEHA2IwuHw
         bLJw==
X-Gm-Message-State: ACgBeo3K318Nba0fa2T8HaR3sPLZJbodBmGDLyw4OJw5ddQJq79LktiK
        J5eKdcTSOYYcQHPpgu86qsc=
X-Google-Smtp-Source: AA6agR4d/qzUc7E3KbfN17eJqbHXKUGxio82mnsQ3zaMKVJqyPghez642srViMoQypoLWrp0HxPSMg==
X-Received: by 2002:ad4:5c8b:0:b0:4aa:8a44:8810 with SMTP id o11-20020ad45c8b000000b004aa8a448810mr26399830qvh.4.1663052587666;
        Tue, 13 Sep 2022 00:03:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:216d:1a77:16d6:2f68? ([2600:1700:2442:6db0:216d:1a77:16d6:2f68])
        by smtp.gmail.com with ESMTPSA id q7-20020a05620a0d8700b006bb9e4b96e6sm9445935qkl.24.2022.09.13.00.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 00:03:07 -0700 (PDT)
Message-ID: <63c31198-ac4d-f3c7-9259-ea7dc6373b23@gmail.com>
Date:   Tue, 13 Sep 2022 02:03:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH RFC 2/2] pci: create device tree node for selected devices
Content-Language: en-US
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh@kernel.org>, Lizhi Hou <lizhi.hou@amd.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, helgaas@kernel.org,
        clement.leger@bootlin.com, max.zhen@amd.com, sonal.santan@amd.com,
        larry.liu@amd.com, brian.xu@amd.com, stefano.stabellini@xilinx.com,
        trix@redhat.com
References: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com>
 <1661809417-11370-3-git-send-email-lizhi.hou@amd.com>
 <20220902185403.GA173255-robh@kernel.org>
 <dd823b9c-fe7f-7c47-520c-bad5a798efc2@gmail.com>
In-Reply-To: <dd823b9c-fe7f-7c47-520c-bad5a798efc2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/12/22 01:33, Frank Rowand wrote:
> On 9/2/22 13:54, Rob Herring wrote:
>> On Mon, Aug 29, 2022 at 02:43:37PM -0700, Lizhi Hou wrote:
>>> The PCI endpoint device such as Xilinx Alveo PCI card maps the register
>>> spaces from multiple hardware peripherals to its PCI BAR. Normally,
>>> the PCI core discovers devices and BARs using the PCI enumeration process.
>>> And the process does not provide a way to discover the hardware peripherals
>>> been mapped to PCI BARs.
> 
> < snip >
> 
>>
>> The above bits aren't really particular to PCI, so they probably 
>> belong in the DT core code. Frank will probably have thoughts on what 
>> this should look like.
> 
> < snip >
> 
> I will try to look through this patch series later today (Monday 9/12
> USA time - I will not be in Dublin for the conferences this week.)
> 
> -Frank

I have collected nearly 500 emails on the history behind this patch and
also another set of patch series that has been trying to achieve some
somewhat similar functionality.  Expect me to take a while to wade through
all of this.

-Frank
