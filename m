Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0A4525E2A
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 11:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378714AbiEMI6p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 04:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378574AbiEMI6o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 04:58:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED732B24D7;
        Fri, 13 May 2022 01:58:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4821E62171;
        Fri, 13 May 2022 08:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997CAC34100;
        Fri, 13 May 2022 08:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652432322;
        bh=y5hNXUrGNvO6cEunrd+P8GV2IaK4KDe9YPvw8H7DMF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g+QV87M3tdWV5smAyn+8sRCKFz9jK2E+B97C/kP1V0wK4E5fLM053u2uRdcgZ70v2
         IfcXyJ6B7hjiDMG2ejbI/gcY5CjS+O01EnGcm+ly7bao1pcN6uB6NTNGI7gWJeGDkZ
         98WfcXiKiofN7G43igJGQopjGZfHburt+hIWLnC27bWNkSKIfwJX6UFW8XoW9yu1/o
         GYgOc1ITjNo1Sosn93qmSU4CMRoocQQGuQ8ebAIajGj+dTkdMtyAxteqKMzC8jBgcf
         3Cwqw+5uGlhQQoSqZjmLR3le+kxlpRc+1Z/2dTXj62/sgxc3gjHk/9r0tKjf+4JiFq
         D9JxQeSr15QLg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1npR8A-0007U9-8a; Fri, 13 May 2022 10:58:39 +0200
Date:   Fri, 13 May 2022 10:58:38 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 00/10] PCI: qcom: Fix higher MSI vectors handling
Message-ID: <Yn4dvpgezdrKmSro@hovoldconsulting.com>
References: <20220512104545.2204523-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512104545.2204523-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 12, 2022 at 01:45:35PM +0300, Dmitry Baryshkov wrote:
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
> Changes since v7:
>  - Move code back to the dwc core driver (as required by Rob),
>  - Change dt schema to require either a single "msi" interrupt or an
>    array of "msi0", "msi1", ... "msi7" IRQs. Disallow specifying a
>    part of the array (the DT should specify the exact amount of MSI IRQs
>    allowing fallback to a single "msi" IRQ),

Why this new constraint?

I've been using your v7 with an sc8280xp which only has four IRQs (and
hence 128 MSIs).

Looks like this version of the series would not allow that anymore.

Johan
