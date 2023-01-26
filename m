Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6506E67CE7E
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jan 2023 15:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjAZOmw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Jan 2023 09:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjAZOmv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jan 2023 09:42:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748606A334;
        Thu, 26 Jan 2023 06:42:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3195EB81D0C;
        Thu, 26 Jan 2023 14:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BDDC433D2;
        Thu, 26 Jan 2023 14:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674744148;
        bh=CCnYelU7vTWlPZSDl5BT9muUMJjl8j5MAppunZabsV4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ehJKrCD8jcjfhoDgsR6ecGQVWtuWDx5JLIwvHsueNlXIxaIYuVjIx9Pv1DPonDJIi
         SEwF2sFyaI+no5tUS1i9CWP+akisKqLIYBwBtFGv0+AuiYrfpnyr30bCkLXoTrRYiu
         hsJJYi7r0t6ihexW55XaFpla7rPjYVvBZ+421W8fKfzXfB2Lys1c8hDZ7TQ3dfDaHi
         sjXRIFp7x8G339EFwAncZTmkwFEonMXS8WIeo/lIDLnUAYkOqeKoY8GDfxNasDQb8s
         GBrKXLK8JqMcpA676/E+eJTJsi72j2OTEIjowtO4ug5dU7vY0yfQA1o2Rnc+nGv7dE
         /xg3Eg1MvyDwg==
Date:   Thu, 26 Jan 2023 08:42:27 -0600
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
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/8] PCI: rockchip: Added poll and timeout to wait for
 PHY PLLs to be locked
Message-ID: <20230126144227.GA1271912@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126135049.708524-5-rick.wertenbroek@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 26, 2023 at 02:50:44PM +0100, Rick Wertenbroek wrote:
> The Rockchip PCIe controller did not wait until the PHY PLLs were locked.
> This could cause hangs. Now the PHY PLLs status is checked through a side
> channel bit with a poll and timeout. If the PHY PLLs cannot lock an error
> is generated. This is documented in the TRM section 17.5.8.1 PCIe
> Initalization Sequence.

s/Initalization/Initialization/
