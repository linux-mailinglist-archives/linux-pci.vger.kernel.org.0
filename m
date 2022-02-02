Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83814A6AF0
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 05:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244413AbiBBEhl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 23:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242010AbiBBEhl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 23:37:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BAAC061714;
        Tue,  1 Feb 2022 20:37:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD1A8B83004;
        Wed,  2 Feb 2022 04:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A754DC004E1;
        Wed,  2 Feb 2022 04:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643776658;
        bh=2MsTA7b4xqOfL4vaY92UZcG7bH+PIh+2toz97qRww+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QXfQtHVhH0qlcARW6XI+27JP9dVUBMuKr4zYnYNuJlrmzDfoXPEWQlNkxDZd1cdy5
         gfkqbISgrd4P6DQrARKdwA9IZ4RT3ohdu4LMn9GeNR9f4orZaQ0xCy5UJXJDNAlYLm
         QKoiwFCjtoKBCQhjbkkQ7MhLbx/HtfY9IfTjAHg1/EjvUgwy7dMcG4IvIkUxAS2dmg
         +WlWLXaAEHIabtH0e0/3Ok1JS7aLXhEMKycZn333AwM9ccRfGdExLLWx0Fo1CoDJee
         hCTVqFINqWtawKLcoXSps8vyZDsbwKRqss/h2KX/o6anBnLGimHrBMy5UX/8zrXl0g
         wACdGNrk/KJMg==
Date:   Wed, 2 Feb 2022 10:07:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 0/3] PCI: qcom: pipe_clk_src fixes for pcie-qcom driver
Message-ID: <YfoKjvWXNxHvoFpg@matsya>
References: <20211218140223.500390-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211218140223.500390-1-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18-12-21, 17:02, Dmitry Baryshkov wrote:
> After comparing upstream and downstream Qualcomm PCIe drivers, change
> the way the driver works with the pipe_clk_src multiplexing.
> 
> The clock should be switched to using ref_clk (TCXO) as a parent before
> turning the PCIE_x_GDSC power domain off and can be switched to using
> PHY's pipe_clk after this power domain is turned on.
> 
> Downstream driver uses regulators for the GDSC, so current approach also
> (incorrectly) uses them. However upstream driver uses power-domain and
> so GDSC is maintained using pm_runtime_foo() calls. Change order of
> operations to implement these requirements.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

> 
> ----------------------------------------------------------------
> Dmitry Baryshkov (3):
>       PCI: qcom: Balance pm_runtime_foo() calls
>       PCI: qcom: Fix pipe_clk_src reparenting
>       PCI: qcom: Remove unnecessary pipe_clk handling
> 
>  drivers/pci/controller/dwc/pcie-qcom.c | 122 +++++++--------------------------
>  1 file changed, 25 insertions(+), 97 deletions(-)

-- 
~Vinod
