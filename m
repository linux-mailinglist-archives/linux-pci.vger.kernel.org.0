Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E738953533D
	for <lists+linux-pci@lfdr.de>; Thu, 26 May 2022 20:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348980AbiEZSTP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 May 2022 14:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348488AbiEZSTN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 May 2022 14:19:13 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133BE579BB;
        Thu, 26 May 2022 11:19:12 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-edeb6c3642so3155112fac.3;
        Thu, 26 May 2022 11:19:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kFD7k/6/Yi0uJtYta5YfK2y2lJGD9433Ffp8uwrqHc0=;
        b=AtCWjeZgvboiqa/TpNzdV8tUDMjnNoXtdlbwHVd73J/41qWYTUFOhKFcSLiH72xsDV
         4RyK/1Yyw7XtZ1tIHMTyE/jmPzkNqrbiO6K1/P+8WSz9GylAeLZuj+Y8mLXzm162pnG2
         Qf1futYxVD+dFTYqJHbMZUlmduOMqTQHdNero8cCaWBUSggYCcY8gVi4/bCrMdvpMl0h
         ac1jf2+d2dLvO+U2/nQvJfyznvemoRPuFducd7VDa6zZldy3cy2VaCJmDA+OX/ZZCcJS
         8gxbdjxW+s6xnUc7jr24V0gbHCpcDh+KTlLhtiH2GDIyTVO8UUy/KjsvZSL4/wzDi3ze
         6DqA==
X-Gm-Message-State: AOAM530oNIuMFNFt7VFChqRbPuLIaYWMtOwHbb8pKvxIJfRshOZ86vt8
        jHmhAEUUUEUL+1+a9RU62Q==
X-Google-Smtp-Source: ABdhPJys8XnYAlw/I/F5WSYE/Waihvj/CEzaNGOWkZuSxhvF/Al8vYzot/X7QaqOchUE+xkYuy/QTg==
X-Received: by 2002:a05:6870:e616:b0:f2:6a4e:2d7b with SMTP id q22-20020a056870e61600b000f26a4e2d7bmr1958068oag.67.1653589151260;
        Thu, 26 May 2022 11:19:11 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k3-20020a4ad103000000b0040e68c9dce6sm892227oor.31.2022.05.26.11.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 11:19:10 -0700 (PDT)
Received: (nullmailer pid 91777 invoked by uid 1000);
        Thu, 26 May 2022 18:19:09 -0000
Date:   Thu, 26 May 2022 13:19:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v12 7/8] dt-bindings: PCI: qcom: Support additional MSI
 interrupts
Message-ID: <20220526181909.GE54904-robh@kernel.org>
References: <20220523181836.2019180-1-dmitry.baryshkov@linaro.org>
 <20220523181836.2019180-8-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523181836.2019180-8-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 23, 2022 at 09:18:35PM +0300, Dmitry Baryshkov wrote:
> On Qualcomm platforms each group of 32 MSI vectors is routed to the
> separate GIC interrupt. Document mapping of additional interrupts.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 53 +++++++++++++++++--
>  1 file changed, 50 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
