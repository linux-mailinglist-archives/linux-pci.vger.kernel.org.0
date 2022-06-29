Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1097F56027C
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 16:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiF2OXk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 10:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiF2OXj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 10:23:39 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D5220185;
        Wed, 29 Jun 2022 07:23:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 624E6CE2738;
        Wed, 29 Jun 2022 14:23:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9491DC34114;
        Wed, 29 Jun 2022 14:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656512614;
        bh=SQmNs8OYbMn7yMns1iZx5GI30ScDN/FAnTYvO6197Lo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RTL3j9uy5L3Ur+hVCHKRu9KSrRndHdfwdHCHhuxTyj/TfiqfFfmTS9dQCMGtdsNhj
         0GY43zg2rHndvmiJOyR8IHb+PSo6w8aaCvs3Cbamjl8AGnxqpXZvMVetq/vOzh//C0
         orHERdVPQtwa3UOMTMozUmPQPzxTI7En9x262h3Rc/pbVR4+WPlHJhcJKZ94Iv+Ucj
         n0MbDQIxOC3a6litbhODJETfPM2l7EY33j1xurQIrfVi+P9RsqSqP57ezrcuwEJpsK
         9HGyl7R3olHUOZPGKslodwYsPmM2B+U9bAFkyVY71kP6c/yNx2OpNQ/XH5T9J1P+ag
         5U4JAy+xW+zfQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o6YbN-0004uy-Vx; Wed, 29 Jun 2022 16:23:34 +0200
Date:   Wed, 29 Jun 2022 16:23:33 +0200
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
Subject: Re: [PATCH v15 1/7] PCI: dwc: Correct msi_irq condition in
 dw_pcie_free_msi()
Message-ID: <YrxgZfRmRJbKXwwu@hovoldconsulting.com>
References: <20220620112015.1600380-1-dmitry.baryshkov@linaro.org>
 <20220620112015.1600380-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620112015.1600380-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 20, 2022 at 02:20:09PM +0300, Dmitry Baryshkov wrote:
> The subdrivers pass -ESOMETHING if they do not want the core to touch
> MSI IRQ. dw_pcie_host_init() also checks if (msi_irq > 0) rather than
> just if (msi_irq). So let's make dw_pcie_free_msi() also check that
> msi_irq is greater than zero.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Tested-by: Johan Hovold <johan+linaro@kernel.org>
