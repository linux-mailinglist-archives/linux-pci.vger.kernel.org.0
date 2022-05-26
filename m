Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5FC534F97
	for <lists+linux-pci@lfdr.de>; Thu, 26 May 2022 14:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239811AbiEZMqc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 May 2022 08:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239939AbiEZMqa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 May 2022 08:46:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E481C136;
        Thu, 26 May 2022 05:46:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52F7761A7C;
        Thu, 26 May 2022 12:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B123BC34116;
        Thu, 26 May 2022 12:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653569187;
        bh=aX3XkTNFlbddfM2Uz7FkBiXfKfSrDGVietK6gQgDZCM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B0ofxPknLB25PRikCSM7JL2+HYZFxCccCBk/ytV+jnoPy8FCWWj45nqSnDmL/CXlf
         WnE797DjnXyaKAVoGBV7QnDpKkvdOjhqn19BVljcYXPfmPhcn1RXT39rcf29R7coEC
         06pdXoQkd+SjQuhBGgade787urI7WT7wy2x2mjhothB8J3FYKC0n5WYc7nLzu7FiTN
         ZMhuHwhTKW6uuMDh71F/tCGSCm7sTbkg3mCi6GHHsApuCI3tV80A3ng/zEU3i/1MAp
         sTCOqyK/HkaodGygf0qC1580ELm5uQ6k5YgMjuhJD4uXs0wccTn3VZ5UNLZA71qwQ1
         J4DHqAxtFfEWw==
Received: by mail-ej1-f50.google.com with SMTP id y13so2845532eje.2;
        Thu, 26 May 2022 05:46:27 -0700 (PDT)
X-Gm-Message-State: AOAM5330szRZVbqr7qg5kksG2thX9MP6a/s1Oq/g9gBpKQOUss0GBXfk
        4/Wax34Snq4venM6+dBl7m4d2MRXUs9NigyzGg==
X-Google-Smtp-Source: ABdhPJxdAvZ5Z3oR1GucLvBj6d6cfGXYzMzHQadqJjpxVYxGkdqtexgfAKaP9HSSbaBey8Xgwc/lhfdaEAWDD/9EmGI=
X-Received: by 2002:a17:906:ae43:b0:6fe:a207:5cc3 with SMTP id
 lf3-20020a170906ae4300b006fea2075cc3mr29379554ejb.19.1653569185897; Thu, 26
 May 2022 05:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220525210117.2489333-1-robh@kernel.org> <35c700f6-ce67-89d5-0f29-426acd33efa9@socionext.com>
In-Reply-To: <35c700f6-ce67-89d5-0f29-426acd33efa9@socionext.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 26 May 2022 07:46:12 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJqdLrhjCiQ3a1PZvfnW715HhXNMQZea2H78T4U2BqDzA@mail.gmail.com>
Message-ID: <CAL_JsqJqdLrhjCiQ3a1PZvfnW715HhXNMQZea2H78T4U2BqDzA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: PCI: socionext,uniphier-pcie: Add missing
 child interrupt controller
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 26, 2022 at 4:02 AM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> Hi Rob,
>
> On 2022/05/26 6:01, Rob Herring wrote:
> > The Socionext interrupt controller internal to the the PCI block isn't
> > documented which causes warnings when unevaluatedProperties check is
> > also fixed. Add the 'interrupt-controller' child node and properties and
> > fixup the example so that interrupt properties can be parsed.
>
> Surely internal interrupt controller isn't described, and should be documented.
> And the child node name "legacy-interrupt-controller" also should be fixed.
>
> Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Thanks.

>
> BTW I can't reproduce such warnings with my environment.
> Can you show the command line to reproduce the warnings?

"causes warnings when unevaluatedProperties check is also fixed"

You won't. I have a fix in dtschema pending, but first all the
warnings that appear need to be fixed.

Rob
