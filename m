Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41A3362EE4
	for <lists+linux-pci@lfdr.de>; Sat, 17 Apr 2021 11:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhDQJbh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Apr 2021 05:31:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229972AbhDQJbh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 17 Apr 2021 05:31:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D21D611AC;
        Sat, 17 Apr 2021 09:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618651871;
        bh=xYwPw+scmNl/6v0Hr95k1Zl3a29/fvlS1cp9M1X9QDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WVQ+QRMJZUraF4N03WaEcCLSOjsS+Vh2HR0qCQ0sJwffLSN6OjGk2aBKIgQEwm0bV
         UmGIt7G2hEcyzWkP/PNvByq77zJ5Cufw+ksysti5tUkM64BG8uCbYPkvY7eMlVy5yf
         ENSczM3aTqX8Z93hxGo1ODzWQ/k1Kp4CXLSMZstYgQCJDvfPeIXEKrVvEbRquj30W2
         dz6Kv0Numbo4NxGm1H+XbG7iseGt7b3knpT/Lr55xJxtVuiGQCdHmJQhfFz0bxd4k2
         gu7v9UZSm4y5Cyy82LsDF4I6fZv0thwFIbQi2jy5oxJMhPLi0OSh83P2d3fKrqvyK8
         ky0Bimu667cgA==
Received: by pali.im (Postfix)
        id 01EA19F7; Sat, 17 Apr 2021 11:31:08 +0200 (CEST)
Date:   Sat, 17 Apr 2021 11:31:08 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: PCIe: can't set Max Payload Size to 256
Message-ID: <20210417093108.uspm6e6h46k655p2@pali>
References: <20210416173119.d2eq2zetzp5awunj@pali>
 <20210416202941.GB32082@redsun51.ssa.fujisawa.hgst.com>
 <20210416230430.cdzlnifaenzhbsmm@pali>
 <20210417022904.GC32082@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210417022904.GC32082@redsun51.ssa.fujisawa.hgst.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Saturday 17 April 2021 11:29:04 Keith Busch wrote:
> On Sat, Apr 17, 2021 at 01:04:30AM +0200, Pali Rohár wrote:
> > Above NVMe disk is connected to PCIe packet switch (which acts as pair
> > of Upstream and Downstream ports of PCI bridge) and PCIe packet switch
> > is connected to the Root port.
> > 
> > I'm not sure what should I set or what to force.
> 
> Try adding the suggested kernel parameter, "pci=pcie_bus_safe".

Ok, I will try it.

> Unless this is a hot-plug scenario, it is odd the OS was handed
> mismatched PCIe settings. That usually indicates a platform bios issue,
> and the kernel parameter is typically successful at working around it.

This is arm64, no BIOS. Kernel uses native pci-aardvark.c host
controller driver which handles everything related to PCIe.
