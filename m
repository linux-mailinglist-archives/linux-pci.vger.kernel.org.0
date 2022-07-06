Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEBA56916D
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 20:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiGFSLq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jul 2022 14:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbiGFSLp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2022 14:11:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB4E29C92;
        Wed,  6 Jul 2022 11:11:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CAE561FE3;
        Wed,  6 Jul 2022 18:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB382C3411C;
        Wed,  6 Jul 2022 18:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657131103;
        bh=c7Cx7lWTrDQaho+shcjrP2iASNe68MqPSBAKq2zNm4w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ooydOsgIWt4EHDZ2OXmRHLrdlmzSbtfypB3EJnw1yD0ZCs0+Glj/m6e+856RxARxQ
         uy71BTVy45+LbMfmNx4Z1KuiuwwZrEBJIBa8jl1pAuhlCvxbNOWVhYNLY1JcvczHyM
         CVOJhXLsXXKgsVVEYrsCXBLjDBE13H1m/q3ZxGPB2QWVXugNL/5Rc+evqtBvV7on2D
         L6q5mrWTXqhop6F1z6VAU0lKaTQpSQSiV+Vj9Gp0XUuoSLY9MrZdEDBHzaZxOo980l
         cap/p6ZApUL/aEGvQ0t5wib5RQ0rOvAPvh6OpRJGFN59lCkyPbafmyF8yJ4s3RSSK0
         8c0my55tAfIyA==
Received: by mail-vs1-f44.google.com with SMTP id a184so6816414vsa.1;
        Wed, 06 Jul 2022 11:11:43 -0700 (PDT)
X-Gm-Message-State: AJIora/kUx48csSvOyIDuh1Nhj0LbypuMOAogzLd+CSLL1heC+RJgDKw
        2POs4RwgMF9wdpC8hG4OU7xqQgWP/GsJUSSOVg==
X-Google-Smtp-Source: AGRyM1trwyvSUtHyHigzbb6dGeQLAewwyn/Ih2DDQyVDcW25FgSTk48k8uDxAPcTpwGjJUVaOHaJHNB/o6IeRy5qfXQ=
X-Received: by 2002:a67:c187:0:b0:354:3ab2:ba65 with SMTP id
 h7-20020a67c187000000b003543ab2ba65mr23005594vsj.53.1657131102853; Wed, 06
 Jul 2022 11:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220629060435.25297-1-vidyas@nvidia.com> <20220629060435.25297-3-vidyas@nvidia.com>
 <20220630210449.GA3283899-robh@kernel.org> <e971a557-3387-efcf-87ec-983b998c5e93@nvidia.com>
In-Reply-To: <e971a557-3387-efcf-87ec-983b998c5e93@nvidia.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 6 Jul 2022 12:11:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJQVJerfojCku9tmSa1_b2EDkvVgCs+2SvCmjCMe+gfyA@mail.gmail.com>
Message-ID: <CAL_JsqJQVJerfojCku9tmSa1_b2EDkvVgCs+2SvCmjCMe+gfyA@mail.gmail.com>
Subject: Re: [PATCH V3 02/11] dt-bindings: pci: tegra: Convert to json-schema
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod <vkoul@kernel.org>, Krzysztof Wilczynski <kw@linux.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        Krishna Thota <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        sagar.tv@gmail.com, Thierry Reding <treding@nvidia.com>
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

On Wed, Jul 6, 2022 at 3:53 AM Vidya Sagar <vidyas@nvidia.com> wrote:
>
>
>
> On 7/1/2022 2:34 AM, Rob Herring wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Wed, Jun 29, 2022 at 11:34:26AM +0530, Vidya Sagar wrote:
> >> From: Thierry Reding <treding@nvidia.com>
> >>
> >> Convert the Tegra194 PCIe bindings from the free-form text format to
> >> json-schema.
> >>
> >> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> >> Signed-off-by: Thierry Reding <treding@nvidia.com>
> >> ---

> >> +  nvidia,bpmp:
> >> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> >> +    description: |
> >> +      Must contain a pair of phandle to BPMP controller node followed by controller ID. Following
> >> +      are the controller IDs for each controller:
> >> +
> >> +        0: C0
> >> +        1: C1
> >> +        2: C2
> >> +        3: C3
> >> +        4: C4
> >> +        5: C5
> >> +    items:
> >> +      - items:
> >> +          - minimum: 0
> >> +            maximum: 0xffffffff
> >
> > That's already the limit. Just a description is fine.
> >
> >> +          - enum: [ 0, 1, 2, 3, 4, 5 ]
> >
> > maximum: 5
>
> Setting the maximum to '5' is resulting in the following error.
>
> pcie-ep@141a0000: nvidia,bpmp:0:0: 4294967295 is greater than the
> maximum of 5
>
> Could you please help me understand why I'm seeing this error?

This is what you need:

items:
  - items:
      - description: phandle to BPMP controller node
      - description: controller ID
        maximum: 5
