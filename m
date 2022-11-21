Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A5D631E00
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 11:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiKUKQl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 05:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiKUKQk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 05:16:40 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4868EB54;
        Mon, 21 Nov 2022 02:16:39 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id g7so18117936lfv.5;
        Mon, 21 Nov 2022 02:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=phJFVLoc9/POc6nbD0liFwrgYsKAiaNUs+VrsQZny0U=;
        b=HMQtLNQC6JHUcpQnXKaMPeLJYNEXESjWqW9Jm9fxHdDsyxq3fD2y+gUbum8cazGLlS
         0Nzot0o7wlI3aHmX0JtEp59ASN04zoUP5cBLwhJUS8UWXS1vrDPK5s0nm6MtNyPRkAXr
         i9HRjhzMXJwfcX+oinAm/OP6xU5bC2NyVL00djub62igijCsqVS/+Gs3g8Ob67GV62e5
         lbpACEGBVz+P7gegvEedJPLtYc/UAuXuZCP3D6YMe70yXUQfK1oo2OuCbl17wDJsWOWJ
         juioZPmih2Q2tDZ+3ZlWsJUEwqpG6mEfuUGwVkFA5iKPxQNEPbzHK7gtA/8R8W2wDMdd
         a+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phJFVLoc9/POc6nbD0liFwrgYsKAiaNUs+VrsQZny0U=;
        b=lBnKJ9Fbk84EXn+jTk5HHJfL13AGx3liKDAcE65PTFsCC4hj/XAp3XZ4ZKBow/JdVm
         i+x0Rl/QabSEeU3VVdVsP2pKzP0mmGIk3LuAaihS+X5I64pKlimYo5RnALpb96jSf1zT
         gRFm8ALGZ7I4l92gLZgfS5MeJ63QJLGwi57eBvGq2N7MDKqFxWlhW8Po2Lq6n0uxcIV6
         D/NkxSzLu0edKpySKtePKK/6o7s5i65TrVHL/yGKG0Do8o+5rc5YGIGGpK+HcWuuDdQG
         czPR5mGzseZnR9sZQu1WQ9uN6fNOBkbKboGNFJ+ao6GWVrhWflw3p5nrlz2hdceEOOTQ
         NyNQ==
X-Gm-Message-State: ANoB5pmkH5jlmtpM9VQVH3tX/1Cuw9zIU7rBqKiRQokEFu/QAq15kZNN
        gOaFE3DTi1tP6HmrHlv5M2E=
X-Google-Smtp-Source: AA0mqf4ot1dRfz4XcQJOzbIEVDNmvoy9FxZf/F3Gx+j1WTmSwhOpMtvOjIltFzq0/t2LrM51x6qHTA==
X-Received: by 2002:a05:6512:2521:b0:4a4:5e83:e07d with SMTP id be33-20020a056512252100b004a45e83e07dmr1937785lfb.409.1669025797870;
        Mon, 21 Nov 2022 02:16:37 -0800 (PST)
Received: from [172.16.196.95] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id e8-20020a05651236c800b004a03d5c2140sm1957388lfs.136.2022.11.21.02.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 02:16:36 -0800 (PST)
Message-ID: <20825b50-c2ef-7efb-efbf-ac00cc4ab9f4@gmail.com>
Date:   Mon, 21 Nov 2022 12:16:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH] dt-bindings: Add missing start and/or end of line regex
 anchors
To:     Rob Herring <robh@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Yangtao Li <tiny.windzz@gmail.com>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Mack <zonque@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20221118223728.1721589-1-robh@kernel.org>
Content-Language: en-US
In-Reply-To: <20221118223728.1721589-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/19/22 00:37, Rob Herring wrote:
> json-schema patterns by default will match anywhere in a string, so
> typically we want at least the start or end anchored. Fix the obvious
> cases where the anchors were forgotten.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

>   .../devicetree/bindings/regulator/rohm,bd9576-regulator.yaml  | 2 +-

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


