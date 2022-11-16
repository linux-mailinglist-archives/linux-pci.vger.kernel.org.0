Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8496E62C75E
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 19:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238781AbiKPSPL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 13:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238775AbiKPSOx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 13:14:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC20363BA3;
        Wed, 16 Nov 2022 10:14:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6339FB81DFB;
        Wed, 16 Nov 2022 18:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72CDC433B5;
        Wed, 16 Nov 2022 18:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668622488;
        bh=ZbvWhNXLnawHqCFvLKSoqvTe4ZGBq4urDiURbMd5tIQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=t6zrV32zUKhntxysWQus4Co5jV1dQLykPnLCa2DRr83G31IBPsPAS3/SkqMHlbSy4
         7CgdIOHqmHnLJ/TMTB2taeVYINP76l3OrSk1k2dqU4m+CXkB2SsgbLPWOq7SZlTSSY
         DzoF+OnxqC5YeWH4TmfGN0kQsIpklwagCg1CLMRiKMRwxAuioUeLyh+R5tRawrl5j+
         AcDJ6yhmBPZHWGFZREvBSrPATs9Z+vfz1qlMbv80TqZdDEEwreTM3rDOnaBofORz2h
         LMUR4nLJHVvKTQNeLFtKqgxGtc7GLr4PUcdWg70RZsr9HwMBh+NXs+drPXq8HCy1xj
         zQZcjK/rHvA1Q==
Date:   Wed, 16 Nov 2022 12:14:46 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Liu Peibao <liupeibao@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        wanghongliang <wanghongliang@loongson.cn>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5] PCI: loongson: Skip scanning unavailable child devices
Message-ID: <20221116181446.GA1126453@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdf78e6a-3be9-2b5c-ac57-9df8341a2fcc@loongson.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 05:57:46PM +0800, Liu Peibao wrote:
> On 11/15/22 1:11 AM, Bjorn Helgaas wrote:
> > On Mon, Nov 14, 2022 at 03:43:46PM +0800, Liu Peibao wrote:

> > I assume there's a single device in the hardware, and both the
> > "platform device" and the PCI device" refer to that single device?
> > 
> > And there's some reason you prefer to use the platform device
> > interface to enumerate that device?
> 
> No, they are not the same device. For example, GMAC1(on chip PCI device) and
> GPIO(platform device, not PCI device) 14 use the same pin. The function for
> this pin can be configured by one bit in general register, eg, 0 for GPIO 14,
> 1 for GMAC1. Sometimes, GPIO 14 is preferred, so configure the pin with
> function GPIO 14 and disable GMAC1.

Ah, I see, so there's some circuit that can be driven by either the
platform (GPIO) device or the PCI (GMAC1) device.

> Overall, how about the following refactored commit log:
> 
> "This patch adds a mechanism to disable on chip PCI devices by DT. Typically,
> when there are pins shareable between the platform device and the on chip PCI
> device, if the PCI device is not preferred, add `status = "disabled"` property
> to this PCI device DT node.
> 
> For example, on LS2K1000, GMAC1(on chip PCI device) and GPIO(platform device,
> not PCI device) 14 share the same pin. If GMAC1 is not preferred, add
> `status = "disabled"` property in GMAC1 DT node."

  Add a mechanism ...

(Instead of "This patch adds ..."; no need to say "this patch" because
it's obvious that the commit log applies to *this patch*)

Add spaces before "(", e.g., "GMAC1 (on-chip PCI device)".

Looks good!

Bjorn
