Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C08535D5B
	for <lists+linux-pci@lfdr.de>; Fri, 27 May 2022 11:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347836AbiE0J12 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 May 2022 05:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240813AbiE0J11 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 May 2022 05:27:27 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F20AC63C4;
        Fri, 27 May 2022 02:27:24 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 27 May 2022 18:27:23 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 38E212058456;
        Fri, 27 May 2022 18:27:23 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 27 May 2022 18:27:23 +0900
Received: from [10.212.245.54] (unknown [10.212.245.54])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 98E1DB62E2;
        Fri, 27 May 2022 18:27:22 +0900 (JST)
Subject: Re: [PATCH] dt-bindings: PCI: socionext,uniphier-pcie: Add missing
 child interrupt controller
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
References: <20220525210117.2489333-1-robh@kernel.org>
 <35c700f6-ce67-89d5-0f29-426acd33efa9@socionext.com>
 <CAL_JsqJqdLrhjCiQ3a1PZvfnW715HhXNMQZea2H78T4U2BqDzA@mail.gmail.com>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <82815ff7-08ad-5f31-a249-448f990863e5@socionext.com>
Date:   Fri, 27 May 2022 18:27:22 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJqdLrhjCiQ3a1PZvfnW715HhXNMQZea2H78T4U2BqDzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/05/26 21:46, Rob Herring wrote:
> On Thu, May 26, 2022 at 4:02 AM Kunihiko Hayashi
> <hayashi.kunihiko@socionext.com> wrote:
>>
>> Hi Rob,
>>
>> On 2022/05/26 6:01, Rob Herring wrote:
>>> The Socionext interrupt controller internal to the the PCI block isn't
>>> documented which causes warnings when unevaluatedProperties check is
>>> also fixed. Add the 'interrupt-controller' child node and properties and
>>> fixup the example so that interrupt properties can be parsed.
>>
>> Surely internal interrupt controller isn't described, and should be
>> documented.
>> And the child node name "legacy-interrupt-controller" also should be
>> fixed.
>>
>> Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> 
> Thanks.
> 
>>
>> BTW I can't reproduce such warnings with my environment.
>> Can you show the command line to reproduce the warnings?
> 
> "causes warnings when unevaluatedProperties check is also fixed"
> 
> You won't. I have a fix in dtschema pending, but first all the
> warnings that appear need to be fixed.
I understand. I don't care abort the warning on the way to fix.

Thank you,

---
Best Regards
Kunihiko Hayashi
