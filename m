Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1E157C4B4
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 08:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbiGUGvi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 02:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiGUGvh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 02:51:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D9242ADA;
        Wed, 20 Jul 2022 23:51:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C752061D96;
        Thu, 21 Jul 2022 06:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A1BC3411E;
        Thu, 21 Jul 2022 06:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658386296;
        bh=vmVX9bnmGimudbWeAcntQ9Q8n8YB6rg9wKjyHxHE1Rg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D0sP2Y5BF9BX4KbXc6RGH2xefa/cpPfdKM+EXSigmJlyPYlUtAd2b6Q/On8yw7Lu8
         IP0DF4iUgtzK5Y0BOuwL8kQB+Sw5wO8NmbQIHZvjzyTQuN3Fc1ns/JjlxTiehde2zk
         6bsVotR3iAyn49ouWMSbw4lcPINxiDZIY22Lr7JkltvppygcNMaWaoNLadNmrQ/Aj7
         oy3U7uIsj7/jVJA9GHZ07WHVb022YpcCZofBxqYE+UM4Gs5bui1FZhfc52L581adpN
         Jt6SOJGusXzeh7xzG9oL5KhwCZqJ7u7AdinDsts9kWD8T9K3LJycZaI7KaKDOmj14A
         2FGnR8h+zr+sA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oEQ23-0002pw-Qv; Thu, 21 Jul 2022 08:51:35 +0200
Date:   Thu, 21 Jul 2022 08:51:35 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Add support for modular builds
Message-ID: <Ytj3dzQveHhf/0+P@hovoldconsulting.com>
References: <20220519094646.23009-1-johan+linaro@kernel.org>
 <20220720212053.GA1659584@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720212053.GA1659584@bhelgaas>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 20, 2022 at 04:20:53PM -0500, Bjorn Helgaas wrote:
> On Thu, May 19, 2022 at 11:46:46AM +0200, Johan Hovold wrote:
> > Allow the Qualcomm PCIe controller driver to be built as a module, which
> > is useful for multi-platform kernels as well as during development.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> This no longer applies on my pci/ctrl/qcom branch:
> 839fbdee4c08 ("dt-bindings: PCI: qcom: Fix reset conditional")
> 
> Do you want to refresh it, or should we wait until the next cycle?

I just sent a rebased v2 (the context had changed due to the addition of
the ipq6018 device-id entry):

	https://lore.kernel.org/all/20220721064720.10762-1-johan+linaro@kernel.org/

Johan
