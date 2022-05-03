Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21F4518AF5
	for <lists+linux-pci@lfdr.de>; Tue,  3 May 2022 19:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbiECRZt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 13:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234526AbiECRZs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 13:25:48 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E632127E;
        Tue,  3 May 2022 10:22:16 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id kd11so12699346qvb.2;
        Tue, 03 May 2022 10:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/xgS2I7wlbvhI/PcSukCCU0u23OSCzvebEggEsNanqg=;
        b=FMyD0QAsPQiW6ssE3TMDKhPdWH1XfJJy1M3JAzOxRmRyhwz79Z17qOCffHrru2D/Kj
         mUeqhgFqg2JZBI994JdWRMY4O9X8YGKtB8DhfAIIt3+0XGD6SOkqHzxer8JuOqB+GRB1
         EYId4xjdJaqTxgA4xn6Pb9megxmi61qGXiDjyZ15+eryRFq8DA5x1gRmZPE/1t2gLdKn
         EaWIVydG6UF84Xth3KZNdO+jNc1nTkdv1gqzrTeRnaakQ2m7IPk5Tl7OAv9IuY+OmBzm
         JUKSjBP+S5eDR7GTDKd0987ngeHTkqhyWasajosp6iViH7/liuf/dDC6xpKCROxeUJsG
         XIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/xgS2I7wlbvhI/PcSukCCU0u23OSCzvebEggEsNanqg=;
        b=Dro36Yln57MuCZdDoT5R2tsGQA0yaHJqsZZj+chqIg1zn//riN93EwhEkqYR7EZAD+
         vbREXBy76n8f9kgW86ZdecBKY04UWWZvsgD36/Y940yMxFGhpBsCg5ktI0k4ItuAhv1J
         Pa9JXiTJ0bYTuq+rOPYcILUfvSJyGVCUZ1QSCmZceKELEi+CMdUtTrQEWQDZLzzjSOGp
         q2VH3ZIObFjnKDjvh2UrvafipvQZYv3W98a5WLngmUVbSs/U1XzXPoxVGDlNUAcjzQcM
         ZLDkz7U0A4CWwQCaWFmOY/76/zAtdP/JVp0R/2BozB3AzkswyF5cQ+nFjtqvc7cjH15h
         q4Zg==
X-Gm-Message-State: AOAM533s8CDGUlet+y+8AGuAHTCoUoCZk+S0rKnhBctr3zywq9/k6i+i
        pTObRmqRz7NtKOAr2V6XNY0=
X-Google-Smtp-Source: ABdhPJzaXt4zhQUxmdwEzXmZOw94i2Z4DV6CmwbanjTBIO0qxaLD41DhWkMH3g0qRyS2Sfs5+THnrQ==
X-Received: by 2002:a05:6214:1946:b0:45a:7d74:5207 with SMTP id q6-20020a056214194600b0045a7d745207mr12378649qvk.43.1651598535326;
        Tue, 03 May 2022 10:22:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:f97a:8e0e:58ed:5519? ([2600:1700:2442:6db0:f97a:8e0e:58ed:5519])
        by smtp.gmail.com with ESMTPSA id b7-20020a05620a118700b0069fc13ce232sm6075741qkk.99.2022.05.03.10.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 10:22:15 -0700 (PDT)
Message-ID: <803917a9-3622-1ffb-548e-6347d8b2dcae@gmail.com>
Date:   Tue, 3 May 2022 12:22:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] of: always populate a root node
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazonni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20220427094502.456111-1-clement.leger@bootlin.com>
 <20220427094502.456111-2-clement.leger@bootlin.com>
 <YnEx5/ni1ddIFCj9@robh.at.kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <YnEx5/ni1ddIFCj9@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/3/22 08:45, Rob Herring wrote:
> On Wed, Apr 27, 2022 at 11:45:00AM +0200, Clément Léger wrote:
>> When enabling CONFIG_OF on a platform where of_root is not populated by
>> firmware, we end up without a root node. In order to apply overlays and
>> create subnodes of the root node, we need one. This commit creates an
>> empty root node if not present.
> 
> The existing unittest essentially does the same thing for running the 
> tests on non-DT systems. It should be modified to use this support 
> instead. Maybe that's just removing the unittest code that set of_root.
> 
> I expect Frank will have some comments.
> 

< snip >

This patch series is next on my list, after what I am currently working
on (updating the .dts -> .dtso patch).  I may get to this today, but
more likely it will be tomorrow.

-Frank
