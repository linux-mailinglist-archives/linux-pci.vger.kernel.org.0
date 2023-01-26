Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4078267D0A0
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jan 2023 16:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjAZPuC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Jan 2023 10:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjAZPuA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jan 2023 10:50:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5B24ABF8;
        Thu, 26 Jan 2023 07:49:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C141618B6;
        Thu, 26 Jan 2023 15:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9D5C4339B;
        Thu, 26 Jan 2023 15:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674748198;
        bh=tz37H93KJoXT7koLr1H4HT5GaXKxGQjDxvtFWm7fYOY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jqXQMHePLVFSiJqj0BgbGZMSJfFzBNY1s6BwEQB8uiax+WOjHz0lV4186ZtQdvbU3
         VlcXlHGw+7BSYxkQhOdJkzk5JGC3Sjei/OXUTgUyXuis2MgcgbNTcTFDhBGwtHsapv
         BWjzD2QkPbh4tcAjQOAWHKvfEIc7v7GVmCAWqYo0dL1dMpif0lnkTtRgmiIgdyTYnv
         HVwbngVuGhfvugMn/7DfKFiw47VQtQ6TJQaM9BwGmw6P3Q2Xitjm1qmI9trS1Atlk8
         JJoBV0NzEojUnCR5P0ARoBsXnZYnZ7iK+BEISeiOB51RuC05DGjF6/mWBB0AUtiM01
         iL+0jwwg2LTxg==
Date:   Thu, 26 Jan 2023 09:49:56 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc:     alberto.dassatti@heig-vd.ch, xxm@rock-chips.com,
        wenrui.li@rock-chips.com, rick.wertenbroek@heig-vd.ch,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/8] PCI: rockchip: Fix PCIe endpoint controller driver
Message-ID: <20230126154956.GA1278063@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAEEuhq9X0ppqTMp7fnZapbubf9k8xhH=u3gPva3hEpAdawK3w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 26, 2023 at 04:23:57PM +0100, Rick Wertenbroek wrote:
> Le jeu. 26 janv. 2023 à 15:52, Bjorn Helgaas <helgaas@kernel.org> a écrit :
> > Thanks very much for your work.
> >
> > On Thu, Jan 26, 2023 at 02:50:40PM +0100, Rick Wertenbroek wrote:
> > > This is a series of patches that fixes the PCIe endpoint controller driver
> > > for the Rockchip RK3399 SoC. It is based on Linux kernel 6.0.19
> > >
> > > The original driver in mainline had issues and would not allow for the
> > > RK3399 to operate in PCIe endpoint mode. This patch series fixes that so
> > > that the PCIe core controller of the RK3399 SoC can now act as a PCIe
> > > endpoint.
> >
> > So we merged cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip
> > PCIe controller") when it actually didn't work?  Ouch.  Thanks for
> > fixing it and testing it.
> 
> It seems it wasn't fully tested, the code compiles and kernel module loads,
> but further functionality didn't seem to have been tested
> (e.g., lspci, and with the pcitest tool and pci_endpoit_test_driver).

OK, I guess that happens sometimes.  Glad you're getting it into
shape!

> Does this mean I should refer to the commit cf590b078391
> ("PCI: rockchip: Add EP driver for Rockchip PCIe controller") ?
> Because it wasn't working in the first place ?

Yes, I think so.

> Thank you for all the pointers, I'll take them into account for the
> next iteration. This is the first time I actually submitted a series of
> patches to the LKML so it's all relatively new to me.

Welcome to Linux, and great start!

Bjorn
