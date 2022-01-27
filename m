Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB34249DA28
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jan 2022 06:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbiA0F2i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jan 2022 00:28:38 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52054 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbiA0F2h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jan 2022 00:28:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 325146184D;
        Thu, 27 Jan 2022 05:28:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D65EC340E4;
        Thu, 27 Jan 2022 05:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643261316;
        bh=2NdSwzXs0/J0PSIuKmSGKLJE4Qf81V0hg2EpWJnok/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ujHo/YpLgkZeQuyqHISrAmgajrE+2lJ3N+DAFYvdzpaEIfL742n81byiUFDUCgxKL
         bTOGu9hQqQgwwYSeE+32Md0E0ljTTmlZy3tuJ/1CYQ5CXXvW1kpkR8FC3rSnsvAllQ
         SnBl2U0N23bgGTDNdUNRlsiqACFegDkVEarr7kkzOy0joKEF5yqWFT9W59T+4WQY5n
         LQmqbONWmXS3vgRduXoBFFRSkIfPU97J2RNLOjnpy26pohrR4u2ZHvarpaiYw6ZumW
         oK4pHQirHaXBjT/ZxXI+OD6HIc08RhZdg9bri8QFnYIz1aOTuKr+s29punp+pnZp80
         9L6fimuhGDntA==
Date:   Thu, 27 Jan 2022 10:58:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-phy@lists.infradead.org, linux-next@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tim Harvey <tharvey@gateworks.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-pci@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2] phy: freescale: pcie: cosmetic clean-up
Message-ID: <YfItgKZ4eCeFB5ZX@matsya>
References: <20220113090321.119880-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113090321.119880-1-marcel@ziswiler.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13-01-22, 10:03, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Sort includes alphabethically and add a new line before the dt-bindings
> one as usually done.

Applied, thanks

-- 
~Vinod
