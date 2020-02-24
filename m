Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10F68169BCA
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 02:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgBXB3P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Feb 2020 20:29:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:47214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbgBXB3O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Feb 2020 20:29:14 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0DA22067D;
        Mon, 24 Feb 2020 01:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582507754;
        bh=uZkT34d6dn8NI6fV5wBHUlsvKm6dzl4F1u8gl0GTubM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qfyhZ+8sUkR8XfTwu8yGmRgaNaGMMDl88owv0hung6LssD3VgCnuiLtBhbToQ2KYP
         CgtgTJv4vSIUx2f+11a2yDEEImmhkcu4Ik/tvg//axjEhaRD8mtlz5J68VyJZrzGjm
         0WCtyY0csLYfZ94YY7NBdbr851bW4GCqSZd5mW/k=
Date:   Mon, 24 Feb 2020 09:29:07 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, andrew.murray@arm.com,
        arnd@arndb.de, mark.rutland@arm.com, l.subrahmanya@mobiveil.co.in,
        m.karthikeyan@mobiveil.co.in, leoyang.li@nxp.com,
        lorenzo.pieralisi@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com,
        Xiaowei.Bao@nxp.com
Subject: Re: [PATCHv10 13/13] arm64: defconfig: Enable
 CONFIG_PCIE_LAYERSCAPE_GEN4
Message-ID: <20200224012907.GC14331@dragon>
References: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
 <20200213040644.45858-14-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213040644.45858-14-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 13, 2020 at 12:06:44PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Enable the PCIe Gen4 controller driver for Layerscape SoCs.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>

Applied, thanks.
