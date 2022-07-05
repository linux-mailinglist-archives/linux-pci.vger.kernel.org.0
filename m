Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0A95662F9
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jul 2022 08:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiGEGPM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 02:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGEGPL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 02:15:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED76F764B;
        Mon,  4 Jul 2022 23:15:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A5E7612F0;
        Tue,  5 Jul 2022 06:15:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCD7C341C7;
        Tue,  5 Jul 2022 06:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657001709;
        bh=GwzhUSg5G4GfWQMVGLNDGN64SfJXQ9e12gzTQs9kIcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JHR8AHajN8RoxF8rmzeQ+z16cDidjgXd9tLwFuQrFAKVz306SAdrHYHwEM5lzHjTQ
         buD8ZEPlXq57NAGL6pANfcuL0DoT7E/UFm6v1dlmNjB96y6wbuEGjxq0ia6J0XDfeH
         4Wvx1Rt3Fmvkq0Bi3Oj72gUITMP56aar4VQRTyVl/BB2J90xRjXcf1pQL0wbHJr4Er
         ++Ykwt1nEpTVVscDWXIhbhJOsIdnUSlccP5WdxFNI/PV2V/NjHNvNucsMAN2Ul1fHd
         c8oHVlwuf3coYmxAHV2eUEhwJPyO4VmhTEm82Mk4WQlm3rajrxeDxEmBq6XfE9L9fk
         2udx4UkmKXPQw==
Date:   Tue, 5 Jul 2022 11:45:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@ti.com,
        kw@linux.com, krzk@kernel.org, p.zabel@pengutronix.de,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3 08/11] phy: tegra: Add PCIe PIPE2UPHY support for
 Tegra234
Message-ID: <YsPW6VKjMGP0qKSg@matsya>
References: <20220629060435.25297-1-vidyas@nvidia.com>
 <20220629060435.25297-9-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629060435.25297-9-vidyas@nvidia.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 29-06-22, 11:34, Vidya Sagar wrote:
> Synopsys DesignWare core based PCIe controllers in Tegra234 SoC
> interface with Universal PHY (UPHY) module through a PIPE2UPHY (P2U)
> module. For each PCIe lane of a controller, there is a P2U unit
> instantiated at hardware level. This driver provides support for the
> programming required for each P2U that is going to be used for a PCIe
> controller.

Applied, thanks

-- 
~Vinod
