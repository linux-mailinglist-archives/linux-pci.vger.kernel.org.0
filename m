Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4024C362CDB
	for <lists+linux-pci@lfdr.de>; Sat, 17 Apr 2021 04:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbhDQC3g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 22:29:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231997AbhDQC3g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Apr 2021 22:29:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A19361107;
        Sat, 17 Apr 2021 02:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618626550;
        bh=MkZ55fhOE2UVmwHvdNH3+MUIVx/iosMlHG3iup0vMgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K2NqayQvUgBGoMzNJT+sUI3oFJ4FtJNGs9Askm2fa8ShvewJdH0+6iwqtLPN9oY0j
         qazQXFt9mMQIH8hqldWgHCCLGNkEc5wWQP2+1t0scRK+RpvgTKc1TSQNDF1ad+SCHF
         5BrLD7TkZ0P4L6ZKo49KU9oSsXVhQbdeIz4E2xHW1uoBJIBEjodgQhEk+WO/U2Mz7K
         jpFKFBR86bc/TNiDbYpspCSdONRJi6wmYVqK/ZMQupgPtYiMlMBRh21TmOYWpGZ1ob
         xb84uA8sRBq4SYcMrLUf9+NcDuZvNgKW6CzxVJn3k/zJNsXjmQZJJPfLbTnavmkke7
         h3uOjYe7IldCA==
Date:   Sat, 17 Apr 2021 11:29:04 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: PCIe: can't set Max Payload Size to 256
Message-ID: <20210417022904.GC32082@redsun51.ssa.fujisawa.hgst.com>
References: <20210416173119.d2eq2zetzp5awunj@pali>
 <20210416202941.GB32082@redsun51.ssa.fujisawa.hgst.com>
 <20210416230430.cdzlnifaenzhbsmm@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210416230430.cdzlnifaenzhbsmm@pali>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 17, 2021 at 01:04:30AM +0200, Pali Rohár wrote:
> Above NVMe disk is connected to PCIe packet switch (which acts as pair
> of Upstream and Downstream ports of PCI bridge) and PCIe packet switch
> is connected to the Root port.
> 
> I'm not sure what should I set or what to force.

Try adding the suggested kernel parameter, "pci=pcie_bus_safe".

Unless this is a hot-plug scenario, it is odd the OS was handed
mismatched PCIe settings. That usually indicates a platform bios issue,
and the kernel parameter is typically successful at working around it.
