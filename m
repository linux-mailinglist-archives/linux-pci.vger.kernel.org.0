Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918164515F6
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 22:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239516AbhKOVDK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 16:03:10 -0500
Received: from server220-5.web-hosting.com ([198.54.116.164]:38885 "EHLO
        server220-5.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350081AbhKOUVh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 15:21:37 -0500
X-Greylist: delayed 1597 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Nov 2021 15:21:37 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=westernsemico.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=N106bhCLQ+s4+KP2V+oVs4rM8QER8S2Y5+PhxVBoSa8=; b=Fugvd3gQAXlbSMsnvVUJ6b3yrx
        lOZVB92B/N4GlzfSFnE3c2lsOKqHh5pq8HMT1kCdlq01eGwf1tZ3YA0SZ1YJby+b8r2V0OH07H9Jt
        nwXj92f3jRCOJI/hjGPgdcuq5EnvAiKZfHzTEtST7jgejQ1LttPYwH+2TZvin8mH2Cp5diDgFlwpN
        b2vlMMPPGew7FN8qZz1igavtx6GMzvkI/4Q/oce/DLwbjxez9RJhULwuPco48Q4dHLrRqXPBz2HKh
        bzR3/ZREE9HL2F9jXw7e0YbU2IXu1YusqJPe7E42OYu9iJ5d+W++7x+mdow/WpZNkgTwLX2jJwpLf
        QhNSNqJA==;
Received: from static-198-54-131-168.cust.tzulo.com ([198.54.131.168]:46724 helo=snowden)
        by server220.web-hosting.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <adam@westernsemico.com>)
        id 1mmi18-00Gn0K-Qw; Mon, 15 Nov 2021 14:51:55 -0500
Date:   Mon, 15 Nov 2021 11:50:04 -0800
From:   Adam Joseph <adam@westernsemico.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Peter Geis <pgwipeout@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-pci@vger.kernel.org
Subject: Re: [Question] rk3399 vfio-pci/sr-iov support
Message-ID: <20211115115004.7d043c5b@snowden>
In-Reply-To: <b597b9a6-870a-8fbd-6490-59734c04367f@arm.com>
References: <CAMdYzYoPXWbv4zXet6c9JQEMbqcJi6ZEOui_n82NVmrqNLy_pw@mail.gmail.com>
        <b597b9a6-870a-8fbd-6490-59734c04367f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server220.web-hosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - westernsemico.com
X-Get-Message-Sender-Via: server220.web-hosting.com: authenticated_id: westwhdn/from_h
X-Authenticated-Sender: server220.web-hosting.com: adam@westernsemico.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 9 Dec 2019 14:07:02 +0000
Robin Murphy <robin.murphy@arm.com> wrote:
> On 09/12/2019 1:28 pm, Peter Geis wrote:
> > I'm back with more pcie fun on the rk3399.
> > I'm trying to get pcie passthrough working for a vm on the rk3399,
> > and have encountered some roadblocks.
> 
> That much I can help with somewhat: the major impediment is that
> RK3399 doesn't have an IOMMU in front of PCIe.

For the more limited case of defending against attacks from
hostile/buggy firmware on PCIe devices: is it possible to use the
RK3399 PCIe "inbound address translation" support instead of an IOMMU?

The RK3399 TRM, v1.3 "Part 2", section 17.5.5.2.1 explains how to
configure address translation (including a base/bounds check) for
inbound-to-SoC memory writes, but details are quite sparse.

Linux appears to not use this functionality; from
drivers/pci/controller/pcie-rockchip-host.c we can see that it
disables the base/bounds (sets them to the entire 32-bit space, which
is all RAM on RK3399 since it supports only 4GB) and passes all 32
bits of incoming memory writes:

static int rockchip_pcie_prog_ib_atu(struct rockchip_pcie *rockchip,
                                     int region_no, u8 num_pass_bits,
	                             u32 lower_addr, u32 upper_addr)
...

static int rockchip_pcie_cfg_atu(struct rockchip_pcie *rockchip)
{
...
	err = rockchip_pcie_prog_ib_atu(rockchip, 2, 32 - 1, 0x0, 0);

Is this a dead end?  If not I might pursue it, if I can get the
necessary documentation.  I couldn't find any mention of ATS in the
RK3399 manual; if the PCIe RC allows that then all bets are off anyways.

  - a
