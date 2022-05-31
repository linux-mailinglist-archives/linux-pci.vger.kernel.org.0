Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402ED5393CE
	for <lists+linux-pci@lfdr.de>; Tue, 31 May 2022 17:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344272AbiEaPTc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 11:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237532AbiEaPT3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 11:19:29 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB98633A3;
        Tue, 31 May 2022 08:19:27 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-f2cd424b9cso18768420fac.7;
        Tue, 31 May 2022 08:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oX9QTG72uvUjCp13va2yVca12L+ce3N3hvWeuX63b8U=;
        b=NQPkSrA1z5M2C6EGzUseBfKcf5ytqRz/lKQ1o9MpSJFadBpyLyYDP8KZUw5/RYzv66
         fXBS9uNZ6q5g5wfGYZATmB+W6HO59A100B49LkH/T6+QN0HV1qnzG252N4J77TU9Wjve
         GiUrD4VkmX1hqz0MSbCXt1cQAZ2JMIHOJRoWq8yxzURdNidLfESoEua+ac9a2Pne3YQA
         RXEZwU4eFqQ8Sk4x752FtHnZ4tUX5NGqTp/+6PJ78os+UQ8poSt77AFopfJ74qkC3MlS
         CbsQaIqcIoiohf8vf5SSl44morwxYkzr887d1VCzTmXk0jJdlihdeZNER+Shet9psRtB
         eNwg==
X-Gm-Message-State: AOAM531ncOH9IN4ZZ91ARqxfyXH8ReFXWEGXziMFIsYAB5mZmY+hUNKc
        kqL7/Vo24EtKqH7DYKjq+w==
X-Google-Smtp-Source: ABdhPJxzf77LSthNLbFbo6lAtfLsdhW9KdO0DslxaCAPtiz6bqPIjJN5tlyfz4GR3oz2XNVGywKivQ==
X-Received: by 2002:a05:6870:15c3:b0:ed:9d61:a56c with SMTP id k3-20020a05687015c300b000ed9d61a56cmr13966693oad.152.1654010367023;
        Tue, 31 May 2022 08:19:27 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bq17-20020a05680823d100b0032b99637366sm5813658oib.25.2022.05.31.08.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 08:19:26 -0700 (PDT)
Received: (nullmailer pid 1783581 invoked by uid 1000);
        Tue, 31 May 2022 15:19:26 -0000
Date:   Tue, 31 May 2022 10:19:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: socionext,uniphier-pcie: Add missing
 child interrupt controller
Message-ID: <20220531151926.GE1742958-robh@kernel.org>
References: <20220525210117.2489333-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525210117.2489333-1-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 25, 2022 at 04:01:16PM -0500, Rob Herring wrote:
> The Socionext interrupt controller internal to the the PCI block isn't
> documented which causes warnings when unevaluatedProperties check is
> also fixed. Add the 'interrupt-controller' child node and properties and
> fixup the example so that interrupt properties can be parsed.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/pci/socionext,uniphier-pcie.yaml | 23 ++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)

Applied, thanks.
