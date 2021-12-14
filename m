Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924C2474523
	for <lists+linux-pci@lfdr.de>; Tue, 14 Dec 2021 15:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbhLNOdS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Dec 2021 09:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbhLNOdR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Dec 2021 09:33:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AA1C061574;
        Tue, 14 Dec 2021 06:33:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 249F261528;
        Tue, 14 Dec 2021 14:33:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF81C34601;
        Tue, 14 Dec 2021 14:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639492396;
        bh=z+GniNxRpwIBEVDVvQdypS1hPDj1bVLpv2u1xe80R8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kUmVg0i87tOQyXFIQd5jn6W69jxo5QLUKY2LVDsFtUdVZzw3xQaIfjKtRpWsB4hbb
         EKNvl1tTT9JVieZ/PCW1X6QFMJqmCfZUmQCK+ZGvGGw0Avo2RIIeaIUGeVC2dN4o7f
         GoR6dDbZf7zUk5GyHA1Mjl+/M61jSrC0dirbtnMwhDa15G10ozacjpEcUZhE67r458
         MHhbi82HFmXB+eqmN+Hl9OeQHn9VcOe579zUFcn9n42CoCoDFWTNVtHbeHw8ktgqUU
         YtXba5YksEQzyhRdiZdiUUeAyYeNvvck+OUZ5r0FuvJZSNOhG853K0qXkc55hGSsEI
         lvjynnHe3F7Qw==
Date:   Tue, 14 Dec 2021 20:03:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, kishon@ti.com, robh@kernel.org,
        galak@kernel.crashing.org, shawnguo@kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH v7 1/8] dt-bindings: phy: phy-imx8-pcie: Add binding for
 the pad modes of imx8 pcie phy
Message-ID: <YbirJxaCGIPKwXkU@matsya>
References: <1638432158-4119-1-git-send-email-hongxing.zhu@nxp.com>
 <1638432158-4119-2-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638432158-4119-2-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 02-12-21, 16:02, Richard Zhu wrote:
> Add binding for reference clock PAD modes of the i.MX8 PCIe PHY.

Applied, thanks

-- 
~Vinod
