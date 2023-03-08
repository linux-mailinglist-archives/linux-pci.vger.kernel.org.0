Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACBA6B07E2
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 14:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjCHNEG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 08:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjCHNDr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 08:03:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCFE87D9B;
        Wed,  8 Mar 2023 05:01:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 289C7B81C65;
        Wed,  8 Mar 2023 13:00:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E385DC433EF;
        Wed,  8 Mar 2023 13:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678280446;
        bh=VXLaDi+vDgA7iCsnJUlPJJL4CJf4xHIfDOzkGIyWk3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X46hJS8UEJb72RizkjelKypisT7MosFzrIdkm0nCQlzN1x40RGtbt+rhnJIkMcrLr
         C54dN8QdTu2VkUv3WMkDgHnPDzVnU9kgmOXnO5T7iZr5iZBZRBR1IMldSKw3Y3AJQ2
         cRoBEX0PTaDZXfonFO1VCD2yv1+N7xbo95c9vd7vTbhFIwiJtBCCFBC2cjoudr0JtH
         VFftJq6Hwhf/CMp1m1g84G5+yNVOgVkDsYPjE9OtdxpRGypF1spB7KX1dGKfRs167J
         VrZTbYPX5iwy/EGgGSkxXzWqs8N9gwCDtbTf5bFaAV4gc8hUADW0lmrq+qYoLRAQ4C
         vA/Jwqs4HA28A==
Date:   Wed, 8 Mar 2023 13:00:40 +0000
From:   Lee Jones <lee@kernel.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mani@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, manivannan.sadhasivam@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: mfd: qcom,tcsr: Add compatible for
 sdx65
Message-ID: <20230308130040.GG9667@google.com>
References: <1678277993-18836-1-git-send-email-quic_rohiagar@quicinc.com>
 <1678277993-18836-2-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1678277993-18836-2-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 08 Mar 2023, Rohit Agarwal wrote:

> Add the qcom,sdx65-tcsr compatible.
>
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

--
Lee Jones [李琼斯]
