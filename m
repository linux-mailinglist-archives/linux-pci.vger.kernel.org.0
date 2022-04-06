Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F358F4F6A5A
	for <lists+linux-pci@lfdr.de>; Wed,  6 Apr 2022 21:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbiDFTuc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Apr 2022 15:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbiDFTt7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Apr 2022 15:49:59 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52826D744B;
        Wed,  6 Apr 2022 11:15:38 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-e2442907a1so3443575fac.8;
        Wed, 06 Apr 2022 11:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s3V1PFwe9rE77F+7x5UasRWtgjGiTdBLaqAI0HJqIdo=;
        b=wGW0lgwaPEg33R0k7JDOHuzlHiRc9J9Zoxtcx4ykrNkhhmWF3D/q9ysRfAFaHniUXG
         2C5Pa5VBSM2Rb+glf5qmBkoxkt5lppkt7WtvUd+M5quyO66Y0318vL4iFKullSDeB6Kp
         U6EfdD6r+5myoqGz5qfb+Bm56jIjrRv3lc0yw/1ZbGUidOXYlY5A7YfLTct2M9yO2krV
         YoG1Bxa+1v0BFmRkwuXfdm57OhclZeCd/aQYQXkSliGvfNGiRmreWPUwYd/HhHQYQgph
         o7d2XOmpKhvtZ5aDCWBM7YGjiixrCq8c4zqbIEj76FUwLImaQvvOjVUqVWZ+aLZKAuxP
         kBiA==
X-Gm-Message-State: AOAM533DITv3pDLoGvith96b/Hq80Zi585799qw611bAw0iQzxJIknYW
        H1hYSnRhQC0n2AdcLU32Tw==
X-Google-Smtp-Source: ABdhPJxaErLxKvwtfnFiclNzDL0x+cHYc94G6xikddI1x3YgPGVmN4GtYn8wVM3GKsgnuKPy9HhmzA==
X-Received: by 2002:a05:6870:32d6:b0:e2:1d27:bd55 with SMTP id r22-20020a05687032d600b000e21d27bd55mr4473906oac.201.1649268937372;
        Wed, 06 Apr 2022 11:15:37 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a17-20020a4ae931000000b0032933be7230sm5547206ooe.4.2022.04.06.11.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 11:15:37 -0700 (PDT)
Received: (nullmailer pid 2525379 invoked by uid 1000);
        Wed, 06 Apr 2022 18:15:36 -0000
Date:   Wed, 6 Apr 2022 13:15:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-pci@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: Re: [PATCH 2/3] dt-bindings: PCI: uniphier-ep: Clean up reg, clocks,
 resets, and their names using compatible string
Message-ID: <Yk3YyFxzonOB2N3j@robh.at.kernel.org>
References: <1649145062-29833-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1649145062-29833-3-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649145062-29833-3-git-send-email-hayashi.kunihiko@socionext.com>
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

On Tue, 05 Apr 2022 16:51:01 +0900, Kunihiko Hayashi wrote:
> Instead of "oneOf:" choices, use "allOf:" and "if:" to define reg, clocks,
> resets, and their names that can be taken by the compatible string.
> 
> The order of their names doesn't change here.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../pci/socionext,uniphier-pcie-ep.yaml       | 84 ++++++++++++-------
>  1 file changed, 56 insertions(+), 28 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
