Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7BE560283
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 16:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiF2OX5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 10:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiF2OXz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 10:23:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8906821267;
        Wed, 29 Jun 2022 07:23:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2609061EEA;
        Wed, 29 Jun 2022 14:23:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74545C34114;
        Wed, 29 Jun 2022 14:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656512633;
        bh=LVcX+gEHvX3SRiMBbTCFQli0cTPVNevpVq4F9iJEz3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VlQKkyYrd9+Qf8Jk5YRkF08EMZeS3TrPm4KLTmMKv3dpLW2VCZK7nZnOYXdpFV+4k
         KHRHbPOAQEQKMbPaju2C02yHt7EgSJCwLqR6JRrZzRqFKGvUnaLpwAmDUDui7Zja6W
         9AMMqcgmWByyv3zm0x5ZIx9MIxkuF9se/38Dq89p3fULGn6gT54sdEVhtgD/auCpFi
         Wl7ambY4XR/PMJmbUIH4UAk3vp2w2q6mMHUwW/uoQlH55+GGrUArK89ocqrSimMkz3
         0Z0ZwvkMY7Ui2/aoQt7dmbcVLZm8sqxz4P5QitrrSzfEOOSUB4auGYFBfohdpVu/oU
         UryceVe+9QBIw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o6Ybh-0004vQ-0D; Wed, 29 Jun 2022 16:23:53 +0200
Date:   Wed, 29 Jun 2022 16:23:52 +0200
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
Subject: Re: [PATCH v15 2/7] PCI: dwc: Convert msi_irq to the array
Message-ID: <YrxgeLFmJQ27HpUY@hovoldconsulting.com>
References: <20220620112015.1600380-1-dmitry.baryshkov@linaro.org>
 <20220620112015.1600380-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620112015.1600380-3-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 20, 2022 at 02:20:10PM +0300, Dmitry Baryshkov wrote:
> Qualcomm version of DWC PCIe controller supports more than 32 MSI
> interrupts, but they are routed to separate interrupts in groups of 32
> vectors. To support such configuration, change the msi_irq field into an
> array. Let the DWC core handle all interrupts that were set in this
> array.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Tested-by: Johan Hovold <johan+linaro@kernel.org>
