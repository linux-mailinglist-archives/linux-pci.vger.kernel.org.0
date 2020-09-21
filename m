Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA770272537
	for <lists+linux-pci@lfdr.de>; Mon, 21 Sep 2020 15:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgIUNQ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Sep 2020 09:16:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:44732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgIUNQy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Sep 2020 09:16:54 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9461C21789;
        Mon, 21 Sep 2020 13:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600694213;
        bh=k7wbqZQpaAKTI8yeTGsEwezOg+Nwq7YoOLM6qiKEKiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PzNgUW5AKZ4oPpuFwLke4kMknfGVDs9ERq4LryF12ceRD1YOw/2C07PLtCMV/i6I5
         pzG2um10m9aYc5lDqaRRX0vZ3Tm2jt6EP0IJMhIxQBt7kW8p4+kh0gxn3/ajAQZ6sL
         exDt5+mHtbx+ouSfbvyFtt+58LbiwtsmqnDI5JbM=
Date:   Mon, 21 Sep 2020 21:16:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        robh+dt@kernel.org, leoyang.li@nxp.com, lorenzo.pieralisi@arm.com,
        gustavo.pimentel@synopsys.com, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, roy.zang@nxp.com
Subject: Re: [PATCH 6/7] dts: arm64: ls1043a: Add SCFG phandle for PCIe nodes
Message-ID: <20200921131646.GC25428@dragon>
References: <20200907053801.22149-1-Zhiqiang.Hou@nxp.com>
 <20200907053801.22149-7-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907053801.22149-7-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 07, 2020 at 01:38:00PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The LS1043A PCIe controller has some control registers
> in SCFG block, so add the SCFG phandle for each PCIe
> controller DT node.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

'arm64: dts: ...' for subject prefix.

Shawn
