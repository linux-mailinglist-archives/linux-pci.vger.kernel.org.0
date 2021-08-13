Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2753EB6DB
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 16:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239604AbhHMOk7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 10:40:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233567AbhHMOk7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Aug 2021 10:40:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D21FB60C41;
        Fri, 13 Aug 2021 14:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628865632;
        bh=TEm9YvfBKh/4TWLPQEvxHMgFmR94Ffoma7V7+FbCf2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oSCyvDo4v9AGN0vHNPFNmb/eBr3a05wA1I/dtDxU+F0kPtqz2V2oCZST0tF6qpSG6
         F6nwfyutMDLHKGQnPOP0gRuuBST9jfg1HI0qiMdgKmWXRPHAHLggu6upXL/PepcRU0
         gY9asf9N/izvW3UwDG2yAF1TMpu9+YPWS0Fl2iUJ/yOP9ZGjyzZyGqP9TASQj73iJW
         XW53Vli/h05uRyviNstjvjNh1KVjlG4IyRwBTgId6CiKN7XKZY/BM66MwiepaldIXV
         iXiL1UJdtNAAs/Iy1SgUa8qsS7ic8RS5qtD39IgxqLrFGS8PelOq8D+kgckJ3pJu8X
         SVCmWe/hs7/tg==
Date:   Fri, 13 Aug 2021 15:40:27 +0100
From:   Will Deacon <will@kernel.org>
To:     "liuqi (BA)" <liuqi115@huawei.com>
Cc:     Linuxarm <linuxarm@huawei.com>, mark.rutland@arm.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhangshaokun@hisilicon.com
Subject: Re: [PATCH v8 2/2] drivers/perf: hisi: Add driver for HiSilicon PCIe
 PMU
Message-ID: <20210813144026.GA8451@willie-the-truck>
References: <20210728080932.72515-1-liuqi115@huawei.com>
 <20210728080932.72515-3-liuqi115@huawei.com>
 <20210802100343.GA27282@willie-the-truck>
 <a56266c4-c434-f078-6027-f30c021bd593@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a56266c4-c434-f078-6027-f30c021bd593@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 04, 2021 at 03:29:54PM +0800, liuqi (BA) wrote:
> 
> Hi Will,
> > Hmm, I was hoping that you would expose all the events as proper perf_events
> > and get rid of the subevents entirely.
> > 
> > Then userspace could do things like:
> > 
> >    // Count number of RX memory reads
> >    $ perf stat -e hisi_pcie0_0/rx_memory_read/
> > 
> >    // Count delay cycles
> >    $ perf stat -e hisi_pcie0_0/latency/
> > 
> >    // Count both of the above (events must be in the same group)
> >    $ perf stat -g -e hisi_pcie0_0/latency/ -e hisi_pcie0_0/rx_memory_read/
> > 
> > Note that in all three of these cases the hardware will be programmed in
> > the same way and both HISI_PCIE_CNT and HISI_PCIE_EXT_CNT are allocated!
> > 
> > So for example, doing this (i.e. without the '-g'):
> > 
> >    $ perf stat -e hisi_pcie0_0/latency/ -e hisi_pcie0_0/rx_memory_read/
> > 
> > would fail because the first event would allocate both of the counters.
> 
> I'm confused with this situation when getting rid of subevent:
> 
> $ perf stat -e hisi_pcie0_0/latency/ -e hisi_pcie0_0/rx_memory_read/
> 
> In this case, driver checks the relationship of "latency" and
> "rx_memory_read" in pmu->add() function and return a -EINVAL, but this seems
> lead to time division multiplexing.
> 
> 	if (event->pmu->add(event, PERF_EF_START)) {
> 		perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
> 		event->oncpu = -1;
> 		ret = -EAGAIN;
> 		goto out;
> 	}
> 	...
> out:
> 	perf_pmu_enable(event->pmu);
> 
> This result doesn't meet our expection, do I miss something here?

This is how perf works. If you don't want multiplexing, put the events in a
group. What's the problem with that?

Will
