Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55FBA16A03D
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 09:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgBXInS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 03:43:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:55138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgBXInR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Feb 2020 03:43:17 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 543AB20661;
        Mon, 24 Feb 2020 08:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582533797;
        bh=9veiwHQ321Wt5pyHqEi/01Nw1+0zBBW21SsYQPjAqOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U0n5WXGRRH/yQhjuQyGKM/mRikRUbqKQ4zz6qfsZ+Gowv69j8/VHm2lzuTmD9hJvn
         /kSOKy0zDgzWKceEvlzewW3AnxCtUEaQKmNAjGFnbeHsgsAY+AfCxD9MOMPm+D4G/x
         4Y6PxQOrEdSh8ieKEQVtvoGvSkQCfIglQ6GLai5k=
Date:   Mon, 24 Feb 2020 16:43:10 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     xiaowei.bao@nxp.com, Zhiqiang.Hou@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lorenzo.pieralisi@arm.com, mark.rutland@arm.com,
        minghuan.Lian@nxp.com, mingkai.hu@nxp.com, robh+dt@kernel.org,
        roy.zang@nxp.com
Subject: Re: [PATCH v6 2/3] arm64: dts: ls1028a: Add PCIe controller DT nodes
Message-ID: <20200224084307.GD27688@dragon>
References: <20190902034319.14026-2-xiaowei.bao@nxp.com>
 <20200224081105.13878-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224081105.13878-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 24, 2020 at 09:11:05AM +0100, Michael Walle wrote:
> Hi Xiaowei, Hi Shawn,
> 
> > LS1028a implements 2 PCIe 3.0 controllers.
> 
> Patch 1/3 and 3/3 are in Linus' tree but nobody seems to care about this patch
> anymore :(
> 
> This doesn't work well with the IOMMU, because the iommu-map property is
> missing. The bootloader needs the &smmu phandle to fixup the entry. See
> below.
> 
> Shawn, will you add this patch to your tree once its fixed, considering it
> just adds the device tree node for the LS1028A?

The patch/thread is a bit aged.  You may want to send an updated patch
for discussion.

Shawn

> 
> > 
> > Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
