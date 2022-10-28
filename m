Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC5D6117E5
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 18:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJ1Qqt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 12:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJ1Qqs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 12:46:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E531E8B83;
        Fri, 28 Oct 2022 09:46:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE99FB82B85;
        Fri, 28 Oct 2022 16:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42388C433D6;
        Fri, 28 Oct 2022 16:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666975604;
        bh=HkwIdD9sgudsitA/h+6n7+Upcze9LHSGz8IOAQP6Az4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LnEYjCLBxwfhuW0CVXwpS9/RllE6Oe6QzBIoZtG4S2XrvNd1IHrRRZkno/CCOIk1L
         GzL790nySls62QHLYRD+0BWCa754fqI+T2uc0l98UV/wazxDebw7lgM2qOEtJGAfEl
         qwanr2v3kvYqo4++JmXqpVKinsY+NcqVnATAmWloibQxjcznjsFcvzb9Yd4c1dqJ9R
         I4eczRMDizji/qoXUh+fOgfGZw0rTSMY0K+1TuKbJW29vWabIOlaD4PkY+66vy48zX
         3yeSuwDM0ikF+nEKNwe8oSJaQVrlN3cEsA+X5faVCzhA4islhxEpRt9DwEuVvdUTwO
         yEVL9b8PyJ+ZQ==
Date:   Fri, 28 Oct 2022 11:46:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, stanimir.varbanov@linaro.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: Re: [PATCH] MAINTAINERS: Add Manivannan Sadhasivam as the Qcom PCIe
 RC maintainer
Message-ID: <20221028164642.GA897608@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028160029.44483-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 28, 2022 at 09:30:29PM +0530, Manivannan Sadhasivam wrote:
> Stan is moving out of mm-sol and decided not to carry on the maintainership
> duties of the Qcom PCIe RC driver. Since I'm already maintaining the Qcom
> PCIe EP driver, I'm volunteering myself to maintain the RC driver also.
> 
> Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to for-linus for v6.1, thanks!

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cf0f18502372..05ca3a7f6967 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16036,7 +16036,7 @@ F:	Documentation/devicetree/bindings/pci/microchip*
>  F:	drivers/pci/controller/*microchip*
>  
>  PCIE DRIVER FOR QUALCOMM MSM
> -M:	Stanimir Varbanov <svarbanov@mm-sol.com>
> +M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>  L:	linux-pci@vger.kernel.org
>  L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
> -- 
> 2.25.1
> 
