Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0DC47452C
	for <lists+linux-pci@lfdr.de>; Tue, 14 Dec 2021 15:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhLNOeJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Dec 2021 09:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbhLNOeJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Dec 2021 09:34:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAC9C061574;
        Tue, 14 Dec 2021 06:34:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94526B819E4;
        Tue, 14 Dec 2021 14:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594BDC34606;
        Tue, 14 Dec 2021 14:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639492446;
        bh=/6ZvXKp4GZ+WzFC8Fhrsl8D/1N93RLcPiQqbY3GUb1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EfcOSL2JAek2r4kIWlB6D13pRXeUDgUZqMovQfrFrpCqWhp/YjhfdmhboTpYy5PIe
         SGcEFdOcBVTYtzk9llr4x7RAjNJNdG+mWA3/jdyZqKZ5e/7k7xPbpyljD9n5Q38MaS
         /03n+SljBLQ1OAWdDw8gzFD+kzQMjZB6pZEPt/GIPRrrdpLJ3Mgmr5vCHhTeEXXhuV
         IZ0lOZP506Io3Am/0FSB1li092TDBubGDSyEJ8T2zPN4bha2erfKQqAUjBbS3FvNCV
         kdpfUF55SToRI9iGnmx6D+Xhhzklym6Qlr8nTqAbLFcBmhKNaPzKraq3q5OvlBGa5n
         JuNQj5mRIRjDw==
Date:   Tue, 14 Dec 2021 20:04:02 +0530
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
Subject: Re: [PATCH v7 5/8] phy: freescale: pcie: Initialize the imx8 pcie
 standalone phy driver
Message-ID: <YbirWnPTgh+vdNWD@matsya>
References: <1638432158-4119-1-git-send-email-hongxing.zhu@nxp.com>
 <1638432158-4119-6-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638432158-4119-6-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 02-12-21, 16:02, Richard Zhu wrote:
> Add the standalone i.MX8 PCIe PHY driver.

Applied, thanks

-- 
~Vinod
