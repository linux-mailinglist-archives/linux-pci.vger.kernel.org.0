Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D9553BA9B
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 16:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbiFBOVX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 10:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbiFBOVW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 10:21:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9C725D5D9;
        Thu,  2 Jun 2022 07:21:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3795B81F5D;
        Thu,  2 Jun 2022 14:21:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812E9C385A5;
        Thu,  2 Jun 2022 14:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654179679;
        bh=IiJxTBcEwl7M5vIZS8teso/henc5AJqsVFL+AueJTAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MhSDMXnA9TMiAPAoEYzQgCs+A92HzGKHckeOllnT5D7A72ZFaHbYE/kVcX7pV30fx
         Bg/v8Z/O/W0ih95pa3+A5Zd8xxvkcWk8pWdW4nfoROrSbc0rFRk9rOTgGmefA/Q9Rs
         F+C5ZbojAqRP0njyUfkLGlGpzMIDW+VxwsQEdPQ7HD94g9oexZqMW0HOzYUZGUcJpU
         9qcp/gitEp/uYUeoX+M8imMX7zV0N4n6sAkayQBa31AuieDgn7PW+BX+9xqX2E27Ad
         sI6Q6qdlTR6Pwm6qo6fV8bdaMEsAXu6oG8K5zxQYe+PrG4hAlmE6lusTFchtiTX7Gf
         XiUyIKrz9La5Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nwlhM-0007nD-Fh; Thu, 02 Jun 2022 16:21:16 +0200
Date:   Thu, 2 Jun 2022 16:21:16 +0200
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
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v12 0/8] PCI: qcom: Fix higher MSI vectors handling
Message-ID: <YpjHXIbCoLC394dJ@hovoldconsulting.com>
References: <20220523181836.2019180-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523181836.2019180-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 23, 2022 at 09:18:28PM +0300, Dmitry Baryshkov wrote:
> I have replied with my Tested-by to the patch at [2], which has landed
> in the linux-next as the commit 20f1bfb8dd62 ("PCI: qcom:
> Add support for handling MSIs from 8 endpoints"). However lately I
> noticed that during the tests I still had 'pcie_pme=nomsi', so the
> device was not forced to use higher MSI vectors.
> 
> After removing this option I noticed that hight MSI vectors are not
> delivered on tested platforms. After additional research I stumbled upon
> a patch in msm-4.14 ([1]), which describes that each group of MSI
> vectors is mapped to the separate interrupt. Implement corresponding
> mapping.
> 
> The first patch in the series is a revert of  [2] (landed in pci-next).
> Either both patches should be applied or both should be dropped.
> 
> Patchseries dependecies: [3] (for the schema change).
> 
> Changes since v11 (suggested by Johan):
>  - Added back reporting errors for the "msi0" interrupt,
>  - Stopped overriding num_vectors field if it is less than the amount of
>    MSI vectors deduced from interrupt list,
>  - Added a warning (and an override) if the host specifies more MSI
>    vectors than available,
>  - Moved has_split_msi_irq variable to the patch where it is used.

You forgot to CC me this version. Please remember to keep reviewers on
CC.

Johan
