Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5A8560282
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 16:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiF2OYK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 10:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiF2OYJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 10:24:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223D420F74;
        Wed, 29 Jun 2022 07:24:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B08C361F05;
        Wed, 29 Jun 2022 14:24:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105C8C34114;
        Wed, 29 Jun 2022 14:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656512648;
        bh=/j6cigFgAc839Q5Dl2bIi4gQ98lzWu89G+fywUIgRKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rHB4ehxPuAhLNPdouO0fiaPEfIINnEMo0XSeqtWy2Gdc72RChmPPQ7cgpG3KtSDO5
         52/Ep8u8DX8FtatqW861aD+LbFJ8D1S54LUYv3aLbD07ZC2s7gsJBLwsEeSeiEYQ9P
         EYTchIQP79EAI0mVr7LbA1mmu9X4F9HWBkmbYVMVwgEcQRmNmtwAgYG//AzOFbGOC4
         d7/flW9iaJE6jyFWXj2uFfuvM1nfe+TuHD38b67nZvGarBZUlixxNCXoh1EjXRpf8i
         4DvndaJAfkPhzrh0VRYqkloZmggb2uKOfDCNNIgQ+QKgb0UUXMWM1cHb30QabUOlKw
         5re4pyjEZb32w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o6Ybv-0004vx-Nx; Wed, 29 Jun 2022 16:24:07 +0200
Date:   Wed, 29 Jun 2022 16:24:07 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v15 3/7] PCI: dwc: split MSI IRQ parsing/allocation to a
 separate function
Message-ID: <Yrxgh2DIkWPOxKjD@hovoldconsulting.com>
References: <20220620112015.1600380-1-dmitry.baryshkov@linaro.org>
 <20220620112015.1600380-4-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620112015.1600380-4-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 20, 2022 at 02:20:11PM +0300, Dmitry Baryshkov wrote:
> Split handling of MSI host IRQs to a separate dw_pcie_msi_host_init()
> function. The code is complex enough to warrant a separate function.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Tested-by: Johan Hovold <johan+linaro@kernel.org>
