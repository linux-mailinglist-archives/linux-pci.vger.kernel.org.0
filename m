Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBC360E981
	for <lists+linux-pci@lfdr.de>; Wed, 26 Oct 2022 21:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbiJZTre (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Oct 2022 15:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbiJZTrN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Oct 2022 15:47:13 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAC583F3F;
        Wed, 26 Oct 2022 12:46:37 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-13bef14ea06so7836621fac.3;
        Wed, 26 Oct 2022 12:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqqsaf5zbzWRtIRRFqnKDgNzNJYpjNhboLksCWq9nmo=;
        b=REKZHhKFMqUXi1HBIa/+nWI1zkmsArX0aqRzC6g1Ye5LtZO8pEJQ+HlR/gV1Re40K5
         Ooujt9NXavvuJU4gC4sv3WmatLl5x5HQ716zvUMm1VQwAq81+77HdsPQOz+YoduR6OSS
         /qOrKvKDRbw7koxVL0VbdNrl5/yojYHu4IHQKkUzi7j5MnPootpTixAoyFRqytHTEB2G
         xEa4NKwJYbcY4fZCOMqO2upW2r55PH7JW+zfJQ9IflatZcort9bvVpo64S1+5KucZ/8O
         /IetHfviS9fbPCyfe/PwIDCmT3ofX9E4pFlavaIMDKlk6WpoZJn7J8WWbaqTVQGQZ5qR
         ZyBg==
X-Gm-Message-State: ACrzQf277khOLJqDEuTC6KNJDGdaHcVWDTHr9PvDo00tSd7Qos/OMiMG
        136DuAPKPpIx7wpp7dRiORr4llWEIQ==
X-Google-Smtp-Source: AMsMyM7qrlWNfGN/uF7X0V0dVQU44KC0a4x2WHEmi4Fj1+Qs4NthJn5IbwHLNUx5D6pmFLMpx3v7Pg==
X-Received: by 2002:a05:6870:56a1:b0:13b:c1b:3908 with SMTP id p33-20020a05687056a100b0013b0c1b3908mr3276113oao.208.1666813596356;
        Wed, 26 Oct 2022 12:46:36 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x10-20020a4ae78a000000b00494ed04f500sm531228oov.27.2022.10.26.12.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:46:35 -0700 (PDT)
Received: (nullmailer pid 1053030 invoked by uid 1000);
        Wed, 26 Oct 2022 19:46:37 -0000
Date:   Wed, 26 Oct 2022 14:46:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: PCI: mediatek-gen3: add support for
 mt7986
Message-ID: <166681359601.1052963.122005161549178587.robh@kernel.org>
References: <20221025072837.16591-1-linux@fw-web.de>
 <20221025072837.16591-3-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025072837.16591-3-linux@fw-web.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 25 Oct 2022 09:28:37 +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add compatible string and clock-definition for mt7986. It needs 4 clocks
> for PCIe, define them in binding.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v2:
> - squashed patch 2+3 (compatible and clock definition)
> ---
>  .../bindings/pci/mediatek-pcie-gen3.yaml        | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
