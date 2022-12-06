Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7606564419F
	for <lists+linux-pci@lfdr.de>; Tue,  6 Dec 2022 11:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiLFK4o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Dec 2022 05:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiLFK4m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Dec 2022 05:56:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D0D38AC;
        Tue,  6 Dec 2022 02:56:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91CB661648;
        Tue,  6 Dec 2022 10:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0EFC433C1;
        Tue,  6 Dec 2022 10:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670324200;
        bh=7ls6/K3/852A+4TeLFUd3O/wBZF1AkjFJ6Ub7H+PRlk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kYcIZ5NnGXtzfGHMtMsYKIyF14FjmmyTDMt8auiNxUBpQAJDdL4xzCqgtKu9P2Kfl
         D/idGK+aHa+0LJTyIvrEwJKx40l1tDwRQJ50kqYvpXAJq1E4kj0P3QrAxPhw5V/m0I
         UgqnGR2nFFnqiJ2T6QSOtfTW07ofBSvQF7Q0EUDYkMNDevpyomYB01iAUp1yFtEUlQ
         YIywv0oY1wTNbwWREfdPUqJnuylv7Z2P8ozdOFtrBnpYtko8mI28PMj8WWFbtSfSep
         QdkPn69i2pdEC6wU1aRLfNHxVxQ1m3UjHzwnVAHQ56Zih4ctyJLNP+NA/aqiXCOROg
         uLnEErQ5E2VKg==
Date:   Tue, 6 Dec 2022 11:56:34 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom: Allow 'dma-coherent' property
Message-ID: <Y48f4ktAwsPBW60y@lpieralisi>
References: <20221205094530.12883-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205094530.12883-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 05, 2022 at 10:45:30AM +0100, Johan Hovold wrote:
> Devices on some PCIe buses may be cache coherent and must be marked as
> such in the devicetree to avoid data corruption.
> 
> This is specifically needed on recent Qualcomm platforms like SC8280XP.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
> 
> Lorenzo, the corresponding SC8280XP DT fix is heading for 6.2 so it
> would be nice if this one could be merged for 6.2-rc1 (or -rc2) as well
> to avoid the corresponding DT validation warnings.

What's the commit base for this patch ? I tried applying to my pci/dt
branch to no avail, please let me know and I will merge it.

Lorenzo

> 
> Johan
> 
> 
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 2f851c804bb0..a5859bb3dc28 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -62,6 +62,8 @@ properties:
>      minItems: 3
>      maxItems: 13
>  
> +  dma-coherent: true
> +
>    interconnects:
>      maxItems: 2
>  
> -- 
> 2.37.4
> 
