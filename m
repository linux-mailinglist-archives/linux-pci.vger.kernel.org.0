Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E0B68F3EF
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 18:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjBHRCL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 12:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjBHRCK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 12:02:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0A02A9B8;
        Wed,  8 Feb 2023 09:02:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8542EB81EFF;
        Wed,  8 Feb 2023 17:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EF0C433D2;
        Wed,  8 Feb 2023 17:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675875726;
        bh=3ZyZSuxLgOVSbmsiuApSazgDfWS8B/5XcDR6ffVD+no=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HPiujLZmQNiWayDi2UAfZQZEuvbAZsbFUgzwLHCz+RBFiRymkyNTTFKpejhfpS2DM
         TfxH6dVkPfxBxw+HeHaP3SIZOmwN/VwmY1Dv7kzuwDV2eIqEuXhFFzoCT70M5v0C0A
         eErw/w+H9tl7D7BogvAB0BkDSaUKxbTgYF/6mAT1/fMCs/97Oft2jFE03AkKaXJuep
         /ocp7c9ZxTmXAflVRD9GODrLq7RbYK++pX5iNmA1WyiAqCCiBnwfhaaJyZn9hHoS/i
         66hxbgHXEiAW2/Rd4YvltlLhgOQmMZyQL45432mn80pZTIzAw8epu2pyGdtriK71Bk
         g6Ua73fwFptCg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pPnqF-00064K-0i; Wed, 08 Feb 2023 18:02:43 +0100
Date:   Wed, 8 Feb 2023 18:02:43 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 11/11] arm64: dts: qcom: sm8550: Fix PCIe PHYs and
 controllers nodes
Message-ID: <Y+PVs8JFKVslbELE@hovoldconsulting.com>
References: <20230206212619.3218741-1-abel.vesa@linaro.org>
 <20230206212619.3218741-12-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206212619.3218741-12-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 06, 2023 at 11:26:19PM +0200, Abel Vesa wrote:
> First, move the pinctrl related propeties out from SoC dtsi and into the
> board dts and add blank lines before status properties in the PHY nodes
> to be consistent with the rest of the nodes. Then drop the pipe clock
> from the controller nodes. Rename the aggre0 and aggre1 clocks to more
> generic noc_aggr. Add the cpu-pcie interconnects to both controller nodes.
> Rename the pcie1 second reset to link_down and drop the unnecessary
> enable-gpios. Switch the aux clock to GCC_PCIE_1_PHY_AUX_CLK for the pcie1
> PHY and drop the aux_phy from clock-names. Also rename the nocsr reset to
> phy_nocsr. With this changes we are now in line with the SC8280XP bindings.
> 
> Fixes: 98a4dc3a78fa ("arm64: dts: qcom: sm8550: Add PCIe PHYs and controllers nodes")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> This time, this patch actually fixes the already merged PCIe related
> nodes. When compared to the earlier version of this patchset, this patch
> leads to the PCIe nodes looking the same. Sorry for all this mess.

Looks good now. 

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
