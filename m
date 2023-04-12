Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0236DF72B
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 15:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjDLN25 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 09:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjDLN2z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 09:28:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B8D30E0;
        Wed, 12 Apr 2023 06:28:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E50D263515;
        Wed, 12 Apr 2023 13:27:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2AA9C433D2;
        Wed, 12 Apr 2023 13:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681306051;
        bh=Ld11dOgUPPLuO+RTfYazRWeuclmWcoDOdBI3Qb45ECQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mWnnd+of213tclhn0KJZvcx97cy3nxc2fIaH4ni51skadPB3ZDfLRxFk7LA6Vy7zz
         TACQOY8/JWyNGLe6Cm0CdFfCRQ40Do7b/5YA0qQJBCgEyd8wJ37t9uA2tVsVJabtAp
         gtiLNM3BWrmSht4g9Sk8xV6vojAhBcIgSb3y6nSaER7LBlCo/IBRMngudTfboeuagj
         fJqXClRCxt9G4HoHBhUmSC4+FVEQ0GZyqAZHEGZhgg7BN54yXuHgkB6klZjPH3lk9e
         bKUU1Q66aLeBMIaZIyyu1qdCF73s3GtFLeoHdrmx0x3rPJ1M3tpoDnj9HODqxax6Dq
         22J9LH36nxCcg==
Date:   Wed, 12 Apr 2023 15:27:24 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bhelgaas@google.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "dt-bindings: PCI: qcom: Add iommu-map properties"
Message-ID: <ZDaxvBK9IqAhZwIM@lpieralisi>
References: <20230411121533.22454-1-manivannan.sadhasivam@linaro.org>
 <20230411174742.GA3428751-robh@kernel.org>
 <20230411184231.GA59982@thinkpad>
 <ZDZouY0PEL64MT6N@lpieralisi>
 <20230412101112.GA9463@thinkpad>
 <ZDaMCcTD/Nwx0vnh@lpieralisi>
 <20230412112918.GB9463@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412112918.GB9463@thinkpad>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 12, 2023 at 04:59:18PM +0530, Manivannan Sadhasivam wrote:

[...]

> > > This is fine. The plan is to remove the "iommus" property from Qcom PCI binding
> > > since we have removed the usage of that property from devicetree [1]. Initially
> > > the iommu properties were not documented at all in the binding. But commit,
> > > "dt-bindings: PCI: qcom: Add SM8550 compatible" added them to the binding to
> > > satisfy dtbs check. But in parallel, the patch removing "iommus" property from
> > > dts got merged to qcom tree.
> > > 
> > > So now we have 2 options here:
> > > 
> > > 1. Amend the commit "dt-bindings: PCI: qcom: Add SM8550 compatible" to remove
> > > the "iommus" property.
> > > 
> > > 2. I will submit a separate patch removing that property.
> > > 
> > > Lorenzo, let me know what works for you. Sorry for the mess! Confusion happened
> > > due to patches getting applied without sync.
> > 
> > You can inline a diff here for (1), I will amend the commit.
> > 
> 
> Here you go:
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index a1318a4ecadf..1548a7114732 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -60,9 +60,6 @@ properties:
>      minItems: 1
>      maxItems: 8
>  
> -  iommus:
> -    maxItems: 1
> -
>    iommu-map:
>      maxItems: 2

Done, please check, thanks.

Lorenzo
