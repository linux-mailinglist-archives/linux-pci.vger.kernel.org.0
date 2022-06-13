Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E4554A226
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 00:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbiFMWhf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 18:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiFMWhe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 18:37:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DFD25D9;
        Mon, 13 Jun 2022 15:37:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D2FF614E9;
        Mon, 13 Jun 2022 22:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65555C34114;
        Mon, 13 Jun 2022 22:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655159852;
        bh=/bbkJolXeiGsEqrWXwBlYNrYYRCjulQTJj4jSQb4AhA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eAdmrV2pP6F5bObmQ2ddoAXA+B6FDnpiZ57seuydUGUGz5G2nS9p5dJSonKKsvctP
         /y3i9oECx/GINaeh19E2UI02c8ccEi5bI9RkJNGRv8XjRvZefasIgsRPKS3JNuD1sS
         Dstmq3E3lGHrTpiCLvq/h2TK0pRM8cVGn9u0HWyzrCArCGbm3BpqYmIfXTTUX2ZOwr
         /Gh6KHd+i/gv/jZDb+Yp4wAVFjCv6LXwsw793MT6962NCSIRkXyKId8qNaGErEzt7A
         p+C2z0Ez5ye/Pzfaj78WL3kb1Iy8Oab5H3SkpSjFzsHNC+bRCr4cdSOTGhQid/2StK
         1CroNp9/f09aw==
Date:   Mon, 13 Jun 2022 17:37:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] dt-bindings: PCI: qcom: fix description typo
Message-ID: <20220613223730.GA722421@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e08b53be6cdf8d94a5a002d5b74c8a884b2ff3c6.1655100158.git.baruch@tkos.co.il>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 13, 2022 at 09:02:38AM +0300, Baruch Siach wrote:
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Applied to pci/ctrl/qcom for v5.20, thanks!

> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 0b69b12b849e..c40ba753707c 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -11,7 +11,7 @@ maintainers:
>    - Stanimir Varbanov <svarbanov@mm-sol.com>
>  
>  description: |
> -  Qualcomm PCIe root complex controller is bansed on the Synopsys DesignWare
> +  Qualcomm PCIe root complex controller is based on the Synopsys DesignWare
>    PCIe IP.
>  
>  properties:
> -- 
> 2.35.1
> 
