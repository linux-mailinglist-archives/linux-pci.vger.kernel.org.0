Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1374A661A99
	for <lists+linux-pci@lfdr.de>; Sun,  8 Jan 2023 23:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjAHWwa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 Jan 2023 17:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjAHWw2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Jan 2023 17:52:28 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4A49FCD;
        Sun,  8 Jan 2023 14:52:27 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id s5so2190331qtx.6;
        Sun, 08 Jan 2023 14:52:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgynu7nhsfTLikdDDiF3tR6jiexexiBETtRvoB73o5I=;
        b=J0dH0lWiTYZCTD0WCMgFrOgCs3lMwueabihtVRW/4w5RDxlc1xRg6YhIb+yuzFnRys
         XIEUuP8pVHVMfl8n5qDuiZ+PGtI64n+dRS9pz6a43zmTzIQivnowp2QL+9F2dIgNaZxp
         yQbsW0F/CO+s1ZCrtmLaloIG5M05fGTcAAFZ4buCBBjSZvfrtwDK8llK56ldxINVHy9R
         gz8u2bmBBlP6eSoVwC444n/LHaaeMSKJkyalvDFucS4zrnCHQkDlaObfFkooFKnqXUpq
         x86evnT6FRr7iHM8jJIOZcns5IwC8mZVWBJ1ysbg+fUSK+933POey6stG/xY4Y7mY/0O
         uIig==
X-Gm-Message-State: AFqh2krkXo1B9Gkdw1hksAZK0DEkhZJpXyy+I04rvLqb9tm4IjtwgW5S
        00B+BvM304kVz7WozHx3fg==
X-Google-Smtp-Source: AMrXdXuq48EJT//TfqDk4EqRCxeeHkxc7XsrDFmnC+B99Ce5Ep8we86AG30gF1iNXJJ3KJ7islJCZw==
X-Received: by 2002:ac8:4f16:0:b0:3a7:ec99:56e4 with SMTP id b22-20020ac84f16000000b003a7ec9956e4mr98611248qte.39.1673218346175;
        Sun, 08 Jan 2023 14:52:26 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80a5:9b51:39ae:24d1:33f3:811e])
        by smtp.gmail.com with ESMTPSA id b5-20020a05620a04e500b006ee8874f5fasm4308662qkh.53.2023.01.08.14.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 14:52:25 -0800 (PST)
Received: (nullmailer pid 388493 invoked by uid 1000);
        Sun, 08 Jan 2023 22:52:22 -0000
Date:   Sun, 8 Jan 2023 16:52:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-pci@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: qcom: add oneOf to compatible
 match
Message-ID: <167321834112.388423.1847446372887431422.robh@kernel.org>
References: <20230106081203.14118-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106081203.14118-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Fri, 06 Jan 2023 09:12:01 +0100, Krzysztof Kozlowski wrote:
> Prepare for extending compatible list by adding oneOf keyword.
> No functional changes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Split from previous patch as Bjorn requested.
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 39 ++++++++++---------
>  1 file changed, 20 insertions(+), 19 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
