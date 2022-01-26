Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7648249C147
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jan 2022 03:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236351AbiAZC0K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jan 2022 21:26:10 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36544 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbiAZC0B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jan 2022 21:26:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00F9FB81BDF;
        Wed, 26 Jan 2022 02:26:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02A8C340E0;
        Wed, 26 Jan 2022 02:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643163958;
        bh=RmgzmvNM3U88+c1923i7TOMfJnQBr8QzL2GLg1H5+ug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=In4Rrh/bYyNC6EHa3YVOy+PmmZTzXzW2TtCDuW6jazHo1cQCGBFoZcl6d2e0oY/3b
         QXTvHSnTmxQni9PZRkEf3+ZANu+mdl/lNPOgFfUYAwXgvp3Rhaoiek47BriA5JHhel
         AxmA6wf8Fn++WP2v+37pA0GvRPFx9I5IVEs+1YELa4QVi+dnvkSEAjMhKttk+5zHvH
         1xF+ZT8HTVOUz46u0k201ipNnjZ8pgaa/dCn7w3cL4xzp7kYTYCqAknfvFjv+qtbr7
         XE7pQ3K73xd3qPsXARmznPqD+Kk53Z5KkMmQKBuDYe5cWA1QNDyliI9V4DbC2Unuia
         H3s2YRwobxuxA==
Date:   Wed, 26 Jan 2022 10:25:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, kishon@ti.com, vkoul@kernel.org,
        robh@kernel.org, galak@kernel.crashing.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH v7 6/8] arm64: dts: imx8mm: Add the pcie support
Message-ID: <20220126022552.GC4686@dragon>
References: <1638432158-4119-1-git-send-email-hongxing.zhu@nxp.com>
 <1638432158-4119-7-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638432158-4119-7-git-send-email-hongxing.zhu@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 02, 2021 at 04:02:36PM +0800, Richard Zhu wrote:
> Add the PCIe support on i.MX8MM platforms.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Tim Harvey <tharvey@gateworks.com>
> Tested-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
