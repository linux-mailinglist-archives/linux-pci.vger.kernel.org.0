Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C5357D552
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 22:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbiGUU61 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 16:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233559AbiGUU6Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 16:58:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30BB904CA;
        Thu, 21 Jul 2022 13:58:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F04260AD8;
        Thu, 21 Jul 2022 20:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71230C3411E;
        Thu, 21 Jul 2022 20:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658437101;
        bh=H/aHhtlRLOeWCCQ5QG+qxA0GsTmdnIKgv+5n5V0Q6n8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KLeVB7ABm4ecgcmx0viupligXKNnNx1xb7evo72pn3Zlb4f9eDbW8miXjfzrZzyoE
         FRiZz2NHq5lMMXydznLM7Q7iz+GaZAz8bIarL8okiQT673X1g0Wj/itVgSQrKUVjZS
         Ww/Sd1cwfSQuLKvqe4oz5WZuRpcOyiOkRbRtp1aFR12hbBzDAvbGF6iN+4IAuJ0P18
         xxyjw3TAuOlcTEOauJkLKoUVcL/AB3FBE6OCKZImLVtRjPmYzO6C64O4WgFgwzwgF6
         daVATJG/L3yJWqYc4RcpjVzTk//ao+3Vun3a2HC7TXVVW/OAiSwydS/vidV7KXF892
         ZUFONRMtOpNLg==
Date:   Thu, 21 Jul 2022 15:58:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     wangseok.lee@samsung.com,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>,
        Yeeun Kim <yeeun119.kim@samsung.com>
Subject: Re: [PATCH v4 3/5] PCI: axis: Add ARTPEC-8 PCIe controller driver
Message-ID: <20220721205819.GA1753070@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <226ac31e-2ac4-cb73-ab67-62f86d5e5783@linaro.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 21, 2022 at 11:04:00AM +0200, Krzysztof Kozlowski wrote:
> On 20/07/2022 08:01, Wangseok Lee wrote:
> > Add support Axis, ARTPEC-8 SoC. ARTPEC-8 is the SoC platform of Axis
> > Communications. This is based on arm64 and support GEN4 & 2lane. This
> > PCIe controller is based on DesignWare Hardware core and uses DesignWare
> > core functions to implement the driver. "pcie-artpec6. c" supports artpec6
> > and artpec7 H/W. artpec8 can not be expanded because H/W configuration is
> > completely different from artpec6/7. PHY and sub controller are different.
> > 
> > Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>
> > Signed-off-by: Jaeho Cho <jaeho79.cho@samsung.com>
> > ---
> > v3->v4 :
> > -Remove unnecessary enum type
> > -Fix indentation
> > 
> 
> Thanks for the changes. This starts to look good, however I am not going
> to ack it. This is also not a strong NAK, as I would respect Bjorn and
> other maintainers decision.
> 
> I don't like the approach of creating only Artpec-8 specific driver.
> Samsung heavily reuses its block in all Exynos devices. Now it re-uses
> them for other designs as well. Therefore, even if merging with existing
> Exynos PCIe driver is not feasible (we had such discussions), I expect
> this to cover all Samsung Foundry PCIe devices. From all current designs
> up to future licensed blocks, including some new Samsung Exynos SoC. Or
> at least be ready for it.

I would certainly prefer fewer drivers but I don't know enough about
the underlying IP and the places it's integrated to to know what's
practical.  The only way I could figure that out would be by manually
comparing the drivers for similarity.  I assume/expect all driver
authors are doing that.

Bjorn
