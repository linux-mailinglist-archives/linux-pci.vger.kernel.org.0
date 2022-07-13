Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960A0573B03
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 18:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbiGMQTC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 12:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbiGMQS6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 12:18:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787A36408;
        Wed, 13 Jul 2022 09:18:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AF196193B;
        Wed, 13 Jul 2022 16:18:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27939C34114;
        Wed, 13 Jul 2022 16:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657729136;
        bh=QTzzGeFgwUf/BHfBON8kDgs4IpA+E1xpHy9xRVCxvPU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JKFFejtEj/Q5ofWJdtnnOCVk+/PHVXRT8+zg+qiRNBfnbUI5Aep2guRis8pcsQScp
         CSWG+sdeOMSBd0HZKXCo8xhhGTshj883BJh3oYsoDb8VI4uNNNPXpZplgOvtpryZ1P
         bZHLH+REw/9O8KKH5ifyyNf5grZgc1NSJKnRSgS+hzMXeCtxvjWdbXYO1kkKK4BNYE
         d2tntqFY6zddJJpyXMuiqvGH0z4e2WNBTk7dtY+7y+Ss73FbT5nQRN3ByzRu57TBCb
         oK5kv95sq4MUOCnaZFFreLCkGIa9dAMR8i49BGRqRnJcziNeIpWEoPkBd2ASqBuoTe
         BZFcMwcazN6oQ==
Date:   Wed, 13 Jul 2022 11:18:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] dt-bindings: PCI: qcom: Fix reset conditional
Message-ID: <20220713161854.GA828851@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629141000.18111-2-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 29, 2022 at 04:09:51PM +0200, Johan Hovold wrote:
> Fix the reset conditional which always evaluated to true due to a
> misspelled property name ("compatibles" in plural).
> 
> Fixes: 6700a9b00f0a ("dt-bindings: PCI: qcom: Do not require resets on msm8996 platforms")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

I applied this patch to pci/ctrl/qcom-pending for v5.20, thanks!

I'd like to see an ack from Stanimir (per get_maintainers.pl) for the
rest.

> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 7e84063afe25..ed9f9462a758 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -615,7 +615,7 @@ allOf:
>    - if:
>        not:
>          properties:
> -          compatibles:
> +          compatible:
>              contains:
>                enum:
>                  - qcom,pcie-msm8996
> -- 
> 2.35.1
> 
