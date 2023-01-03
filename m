Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A04665B9B9
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jan 2023 04:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbjACDfG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Jan 2023 22:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjACDfF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Jan 2023 22:35:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3905C749;
        Mon,  2 Jan 2023 19:35:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DBE9B80D75;
        Tue,  3 Jan 2023 03:35:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22051C433EF;
        Tue,  3 Jan 2023 03:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672716900;
        bh=dCkckECAvLQtZaeZmpoNgVJKnT+aYXzBTqQgYjJLq80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S9eq+dx75O+t277fS2OQTxltcXQoA5NqAL7Q/02fwyulyXbhd97EmBz9ROiMF6NWd
         +hlVuil9QGMpGmbem/7ir0Vk+zwS5B3Y8nhvInCHpm5C6Rn1wNLFxpvNvlo+8PQcxM
         VejYjAMLtE/k6E9AKxeeGfSQRjFlR3YVuiwuq6xfIBn8Kps3z3qg7MuU+ixFqtN/E6
         VTdyb56OyFo9eojisdUjD+/LzJhp4h9GAhz4lSyGnf81xoCxJ8uGW7fAW+z/7wIfj8
         Kj7xdqrJ4qbOeQtOslCBvqsPeBoXJ6JD9Nhuvll8zcDuG63mK4nvL29rEyhlexLsZV
         Bs1ThJ1j6f1PQ==
Date:   Mon, 2 Jan 2023 21:34:58 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        bhelgaas@google.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lpieralisi@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: PCI: qcom: Update maintainers
Message-ID: <20230103033458.kdtylqhnlkrk46oh@builder.lan>
References: <20230102105821.28243-1-manivannan.sadhasivam@linaro.org>
 <20230102105821.28243-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230102105821.28243-2-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 02, 2023 at 04:28:19PM +0530, Manivannan Sadhasivam wrote:
> Stanimir has left mm-sol and already expressed his wish to not continue
> maintaining the PCIe RC driver. So his entry can be removed.
> 
> Adding myself as the co-maintainer since I took over the PCIe RC driver
> maintainership from Stanimir.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Acked-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index a5859bb3dc28..a3639920fcbb 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -8,7 +8,7 @@ title: Qualcomm PCI express root complex
>  
>  maintainers:
>    - Bjorn Andersson <bjorn.andersson@linaro.org>
> -  - Stanimir Varbanov <svarbanov@mm-sol.com>
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>  
>  description: |
>    Qualcomm PCIe root complex controller is based on the Synopsys DesignWare
> -- 
> 2.25.1
> 
