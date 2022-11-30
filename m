Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CB163CF83
	for <lists+linux-pci@lfdr.de>; Wed, 30 Nov 2022 08:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiK3HEI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Nov 2022 02:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiK3HEH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Nov 2022 02:04:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4D756EE1;
        Tue, 29 Nov 2022 23:04:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08E7661A36;
        Wed, 30 Nov 2022 07:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA02C433D6;
        Wed, 30 Nov 2022 07:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669791845;
        bh=X2hPhN+EYjcCTx3ChJ6TWYuinHRDF7JJBXdPbw05/5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CHsf1QVv9nH0bbZCg4lJSQyjpYf9tGr9BYNjQHL6FWKen9L8u99MN6OJyyonVqet7
         6mu/L1XRnUn7nb6q2xZA3lEkKj1nxOX//lxv1RP4UFlR9sdYUuAw19OODOEeqMZxqp
         vKaTgnKVmok2zWRHphYGF9HZcS88BrEWYslg89s00Zqd1Y3NVIfjtNc2/t3YBPKpvg
         /rE5jqqn7tmSL1aG3A001PeKMz5EV/kPHepbLh3ShLz6HB11n43xGYA2IBz6A7bmjO
         fse/lpKjukDYdTrON4nlKfPf87evDNkio4sik0p2YCU/cLrx9PqAYAbqSrrwSZMkdh
         nGUCp4ov5SQcg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p0H8Z-0007n8-Mz; Wed, 30 Nov 2022 08:04:07 +0100
Date:   Wed, 30 Nov 2022 08:04:07 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom-ep: Fix PERST register description
Message-ID: <Y4cAZ8ZqnRvR350Z@hovoldconsulting.com>
References: <20221018093115.7537-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018093115.7537-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 18, 2022 at 11:31:15AM +0200, Johan Hovold wrote:
> The 'qcom,perst-regs' property holds a single phandle array with the
> phandle of the TCSR syscon and offsets of the two PERST registers, but
> the current schema does not capture this.
> 
> Update the binding to describe the single phandle array and its three
> elements.
> 
> Fixes: 31c9ef002580 ("dt-bindings: PCI: Add Qualcomm PCIe Endpoint controller")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-ep.yaml          | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> index 977c976ea799..7574291646ad 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> @@ -42,13 +42,13 @@ properties:
>      maxItems: 8
>  
>    qcom,perst-regs:
> -    description: Reference to a syscon representing TCSR followed by the two
> -                 offsets within syscon for Perst enable and Perst separation
> -                 enable registers
> +    description: PERST TCSR registers
>      $ref: "/schemas/types.yaml#/definitions/phandle-array"
>      items:
> -      minItems: 3
> -      maxItems: 3
> +      - items:
> +          - description: phandle of TCSR syscon
> +          - description: offset of PERST Enable register
> +          - description: offset of PERST Separation Enable register
>  
>    interrupts:
>      items:

Lorenzo, it seems this one has not yet been picked up so sending a
reminder.

Johan
