Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A684C3A1A
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 01:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiBYAIe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 19:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiBYAIe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 19:08:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF2512B765;
        Thu, 24 Feb 2022 16:08:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1136861CDA;
        Fri, 25 Feb 2022 00:08:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DB4C340EF;
        Fri, 25 Feb 2022 00:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645747682;
        bh=YHKuaw/M4cyd4TxRY4j95nETLKiuypiRsUpqY9ivG3I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=egZaxVPgwqFESEvkAeyzXsdfr+7xqa2eZET0pEnR0MXyaInHyw4HfGBJUV6gTzmRo
         kR2UNxxDPkEc77FvYLd77Yk6AzCARd979GaSPQzlekKRYBi84SFzozsDQXuV0j+s+S
         lpYH3GLt74DBnTOnWgrKKueP2jc7ZIugWqADViVculXdgOtcgDkD8fgT9gVC6LAWQ8
         3vSD9ky9dXUEtLALNhNfvxvtUnX5JMEidu7KSS3JY6ShObjxhbF3cM67DsQTMN+yyv
         SX+X0VYkFh8AbtEVV6UE50+V+OKq82/1pzhm5D1nO8d7v8Zc8PeRWV2PsgGURXRUdy
         hqZjYGWX8REng==
Date:   Thu, 24 Feb 2022 18:08:00 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 05/12] PCI: mvebu: Correctly configure x1/x4 mode
Message-ID: <20220225000800.GA304526@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220222155030.988-6-pali@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 22, 2022 at 04:50:23PM +0100, Pali Rohár wrote:
> If x1/x4 mode is not set correctly then link with endpoint card is not
> established.
> 
> Use DTS property 'num-lanes' to deteriminate x1/x4 mode.

I know this is already merged, but if tweaking for any other reason,
s/deteriminate/determine/

> +	 * Set Maximum Link Width to X1 or X4 in Root Port's PCIe Link
> +	 * Capability register. This register is defined by PCIe specification
> +	 * as read-only but this mvebu controller has it as read-write and must
> +	 * be set to number of SerDes PCIe lanes (1 or 4). If this register is
> +	 * not set correctly then link with endpoint card is not established.

True, everything in Link Capability is RO or HwInit, but that's for
the architected access via config space.  I think a device-specific
mechanism like this is fair game as long as you do it before anybody
can read it via config space.

> +	 */
> +	lnkcap = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCAP);
> +	lnkcap &= ~PCI_EXP_LNKCAP_MLW;
> +	lnkcap |= (port->is_x4 ? 4 : 1) << 4;
> +	mvebu_writel(port, lnkcap, PCIE_CAP_PCIEXP + PCI_EXP_LNKCAP);
