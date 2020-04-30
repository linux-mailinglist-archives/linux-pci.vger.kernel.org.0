Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5571BF29E
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 10:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgD3IWs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 04:22:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbgD3IWs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Apr 2020 04:22:48 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 814A020838;
        Thu, 30 Apr 2020 08:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588234967;
        bh=GnPZmnr/Ofem6uvXDZbMnuc5+odjfx382ISo2nPA2og=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uh2AnTdVFUsSdIHfIkORGr321QfK0oEdiFejgkEUQ5lDxRtZwf8MOcw4JsKHMlIGz
         8i56R/ssfr+b+as/IcpFK2aMwau3MmjF+Wy9xA80kyYMn3KXAATa+/mRQEv1ZEICdV
         E0TunFx47hWEaxJco2lF1Czpzn+IgVVwxtzoIhi0=
Received: by pali.im (Postfix)
        id 931537AD; Thu, 30 Apr 2020 10:22:45 +0200 (CEST)
Date:   Thu, 30 Apr 2020 10:22:45 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 05/12] PCI: aardvark: Issue PERST via GPIO
Message-ID: <20200430082245.xblvb7xeamm4e336@pali>
References: <20200430080625.26070-1-pali@kernel.org>
 <20200430080625.26070-6-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200430080625.26070-6-pali@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 30 April 2020 10:06:18 Pali Rohár wrote:
> +static void advk_pcie_issue_perst(struct advk_pcie *pcie)
> +{
> +	u32 reg;
> +
> +	if (!pcie->reset_gpio)
> +		return;
> +
> +	/* PERST does not work for some cards when link training is enabled */
> +	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
> +	reg &= ~LINK_TRAINING_EN;
> +	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
> +
> +	/* 10ms delay is needed for some cards */
> +	dev_info(&pcie->pdev->dev, "issuing PERST via reset GPIO for 10ms\n");
> +	gpiod_set_value_cansleep(pcie->reset_gpio, 1);
> +	usleep_range(10000, 11000);
> +	gpiod_set_value_cansleep(pcie->reset_gpio, 0);
> +}

Just note about delay between changing GPIO reset:

In V2 there as only 1ms, but be figured out that it is not enough for
WLE900VX cards when they were already initialized in u-boot.

I tried to find in PCI specs if there is a defined timeout for this
operation. I found following 3 delay definitions which could be related:

TPVPERL - PERST# must remain active at least this long after power becomes valid
TPERST - When asserted, PERST# must remain asserted at least this long
TPERSTCLK - PERST# must remain active at least this long after any supplied reference clock is stable

In another spec they have defined also minimal values:

TPVPERL - Power stable to PERST# inactive - Min 100 ms
TPERST - PERST# active time - Min 100 us
TPERSTCLK - REFCLK stable before PERST# inactive - Min 100 us

After experimenting with those Compex WLE900VX cards, I know that 100us
delay is not enough. And I'm not sure if TPVPERL is really relevant for
this case. I understood that TPVPERL is needed when initializing power
again. And because delaying boot by another 100ms is does not have to be
acceptable if there is not strict reason for it, I rather decided to
stay with just 10ms delay.

If you know what is the correct timeout between changing GPIO reset,
please let me know and in future I can fix/reimplement it.
