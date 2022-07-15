Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0418D5760A0
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 13:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiGOLfh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 07:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiGOLfg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 07:35:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFD45D5B6;
        Fri, 15 Jul 2022 04:35:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D1A3622EA;
        Fri, 15 Jul 2022 11:35:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2FEC34115;
        Fri, 15 Jul 2022 11:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657884934;
        bh=AVfJz6hAs+kgFPameBwL8dCVrV6mu62fj//RcFwFdVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gUKMR4hnkbs/CLLUl33Nkedzr4Yfirduk8yTGfhmnXXbni528zYlpNoFdDPQ3uLDt
         IGQRs2REVZvf3GznJmTZBf6hh85lFMuujmTya790svjziG1PiHKu/6T5/Fwfv6sSDx
         kYersxM4H7vOJOa/FbyjHB8OqdgEFVmzkxcL5c9G3+HhZZ1zvB4OEM/1kVZ2zO20PH
         GaK9qwjWyGtc69H5pe+WfDtZ2MXMGmV9yM7E6u0vpkfSN2L52H5lWDDxuRXOd+dgwg
         s5qowh61WNJF7tIltDvOXmH4MmEZjMD9bfAAeeSKLHVF2HfjAfx8cKQ+i8hUqdX6lq
         mRypnBH65poTA==
Date:   Fri, 15 Jul 2022 17:05:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-phy@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 1/2] phy: samsung: phy-exynos-pcie: sanitize
 init/power_on callbacks
Message-ID: <YtFRAkt4onP4CZIj@matsya>
References: <YsPZU83Jl/kcqR8h@matsya>
 <20220712201227.GA791612@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712201227.GA791612@bhelgaas>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12-07-22, 15:12, Bjorn Helgaas wrote:
> On Tue, Jul 05, 2022 at 11:55:23AM +0530, Vinod Koul wrote:
> > On 29-06-22, 00:04, Marek Szyprowski wrote:
> > > The exynos-pcie driver called phy_power_on() and then phy_init() for some
> > > historical reasons. However the generic PHY framework assumes that the
> > > proper sequence is to call phy_init() first, then phy_power_on(). The
> > > operations done by both functions should be considered as one action and
> > > as such they are called by the exynos-pcie driver (without doing anything
> > > between them). The initialization is just a sequence of register writes,
> > > which cannot be altered, without breaking the hardware operation.
> > > 
> > > To match the generic PHY framework requirement, simply move all register
> > > writes to the phy_init()/phy_exit() and drop power_on()/power_off()
> > > callbacks. This way the driver will also work with the old (incorrect)
> > > PHY initialization call sequence.
> > 
> > Is the plan to merge thru pcie tree?
> 
> I guess these patches should go together.  I don't see any major
> exynos series pending, but I do have two minor pci-exynos.c patches in
> the queue.
> 
> If you ack it (after resolution of your question below) I'd be happy
> to take both if it doesn't cause trouble for you.

Done now.

-- 
~Vinod
