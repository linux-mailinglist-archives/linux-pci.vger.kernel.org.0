Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531AE7103FD
	for <lists+linux-pci@lfdr.de>; Thu, 25 May 2023 06:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbjEYET3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 May 2023 00:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236779AbjEYETM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 May 2023 00:19:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0DD1B0;
        Wed, 24 May 2023 21:19:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5A5B6428D;
        Thu, 25 May 2023 04:19:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B785C433EF;
        Thu, 25 May 2023 04:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684988347;
        bh=ghov1HDoXV1gHEgBx2lGI+DkEfipVm5dsjd5Jwtu2Ss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S+X8vnmTTdmjnB7P1TQf76X3YuKJlhJJAwOD3HWld/zcGbFy9bDfXbEWwePQ31Xj9
         Q+Xn42GzJ9yu/zxSJ5dlF/Bet369PAmOMWcPROJMvdC4Ih7EJtLv6TNKgp90Wk+62T
         HaYWYcGoPLDTqrScJfWS82xh4Or7M/XqfnOJd/pCtC1PULbbWxRWHtwO0lfQjPzbsy
         FODe62MB6tLITfzpT4WTZFmC+YamB8U7MUeRzNk+c1Q2kOWrsiKzEKJwJ1pn7ypp8W
         kq+U0bF83bGtmn1vvm2pnAbXfBehbRQz/vDKv69WtuXncjHhUmQFsMuCYA7OpDB3Be
         2syZUDqOsHreg==
Date:   Wed, 24 May 2023 21:22:57 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, bhelgaas@google.com,
        lpieralisi@kernel.org
Cc:     kw@linux.com, agross@kernel.org, konrad.dybcio@linaro.org,
        mani@kernel.org, robh@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/5] dt-bindings: PCI: qcom: Add SDX65 SoC
Message-ID: <20230525042257.merdqif6yuz6ukv4@ripper>
References: <1684432073-28490-1-git-send-email-quic_rohiagar@quicinc.com>
 <1684432073-28490-2-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1684432073-28490-2-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 18, 2023 at 11:17:49PM +0530, Rohit Agarwal wrote:
> Add PCIe EP compatible string for SDX65 SoC.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Bjorn, Lorenzo, please pick this patch through the PCI tree (to avoid
any merge issues).

Thanks,
Bjorn

> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> index b3c22eb..8111122 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> @@ -13,6 +13,7 @@ properties:
>    compatible:
>      enum:
>        - qcom,sdx55-pcie-ep
> +      - qcom,sdx65-pcie-ep
>        - qcom,sm8450-pcie-ep
>  
>    reg:
> @@ -109,6 +110,7 @@ allOf:
>            contains:
>              enum:
>                - qcom,sdx55-pcie-ep
> +              - qcom,sdx65-pcie-ep
>      then:
>        properties:
>          clocks:
> -- 
> 2.7.4
> 
