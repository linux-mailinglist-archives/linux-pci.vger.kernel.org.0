Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF0C3A9C5A
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 15:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbhFPNpN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 09:45:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233470AbhFPNpI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Jun 2021 09:45:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A19C6100A;
        Wed, 16 Jun 2021 13:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623850982;
        bh=PNvqZ58yryGZzUwSLjIqM5T0z2MfgSz+KfhEckS1YcY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q1BG8w9PPDB1NFZMuqv7M0Lt6zCOOccDKk4LSEH/fGGvYcAr3ieHpffdGcYh3vTDd
         j5OzoLzh5TKFs2Ce0YMG+/5s2CmCEt7dy7fFBd3LqO3m2YdixpetQlc5mPxjMG3Z40
         GFSJ6NVsCe4gnfvcbuCJrsnUnQQCpcTVo1EatEc5ZH5R+M/cC8G2wEWKNJ4vD3bWYt
         PxXIj1W3hiDAIQIZsbRsdh1ScRGYgrEKSdK8YBMjwcKLB6Ktpd5UvG0R7hHofhNKdE
         DqR/xYiTJWl7/mHLzrhfOkddt3ViP3isVs59lDur9oWBJd8wYKYTrKmsh3z/SRC+vR
         w88G1okk6oBMQ==
Date:   Wed, 16 Jun 2021 14:42:58 +0100
From:   Will Deacon <will@kernel.org>
To:     "liuqi (BA)" <liuqi115@huawei.com>
Cc:     Linuxarm <linuxarm@huawei.com>, mark.rutland@arm.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhangshaokun@hisilicon.com
Subject: Re: [PATCH v6 2/2] drivers/perf: hisi: Add driver for HiSilicon PCIe
 PMU
Message-ID: <20210616134257.GA22905@willie-the-truck>
References: <1622467951-32114-1-git-send-email-liuqi115@huawei.com>
 <1622467951-32114-3-git-send-email-liuqi115@huawei.com>
 <20210611162347.GA16284@willie-the-truck>
 <a299d053-b45f-e941-7a2e-c853079b8cdd@huawei.com>
 <20210615093519.GB19878@willie-the-truck>
 <8e15e8d6-cfe8-0926-0ca1-b162302e52a5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e15e8d6-cfe8-0926-0ca1-b162302e52a5@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Wed, Jun 16, 2021 at 09:54:23AM +0800, liuqi (BA) wrote:
> On 2021/6/15 17:35, Will Deacon wrote:
> > On Tue, Jun 15, 2021 at 04:57:09PM +0800, liuqi (BA) wrote:
> > > On 2021/6/12 0:23, Will Deacon wrote:
> > > > On Mon, May 31, 2021 at 09:32:31PM +0800, Qi Liu wrote:
> > > > > +	/* Process data to set unit of latency as "us". */
> > > > > +	if (is_latency_event(idx))
> > > > > +		return div64_u64(data * us_per_cycle, data_ext);
> > > > > +
> > > > > +	if (is_bus_util_event(idx))
> > > > > +		return div64_u64(data * us_per_cycle, data_ext);
> > > > > +
> > > > > +	if (is_buf_util_event(idx))
> > > > > +		return div64_u64(data, data_ext * us_per_cycle);
> > > > 
> > > > Why do we need to do all this division in the kernel? Can't we just expose
> > > > the underlying values and let userspace figure out what it wants to do with
> > > > the numbers?
> > > > 
> > > Our PMU hardware support 8 sets of counters to count bandwidth, latency and
> > > utilization events.
> > > 
> > > For example, when users set latency event, common counter will count delay
> > > cycles, and extern counter count number of PCIe packets automaticly. And we
> > > do not have a event number for counting number of PCIe packets.
> > > 
> > > So this division cannot move to userspace tool.
> > 
> > Why can't you expose the packet counter as an extra event to userspace?
> > 
> Maybe I didn’t express it clearly.
> 
> As there is no hardware event number for PCIe packets counting, extern
> counter count packets *automaticly* when latency events is selected by
> users.
> 
> This means users cannot set "config=0xXX" to start packets counting event.
> So we can only get the value of counter and extern counter in driver and do
> the division, then pass the result to userspace.

I still think it would be ideal if we could expose both values to userspace
rather than combine them somehow. Hmm. Anyway...

I struggled to figure out exactly what's being counted from the
documentation patch (please update that). Please can you explain exactly
what appears in the HISI_PCIE_CNT and HISI_PCIE_EXT_CNT registers for the
different modes of operation? Without that, the ratios you've chosen to
report seem rather arbitrary.

I also couldn't figure out how the latency event works. For example, I was
assuming it would be a filter (a bit like the length), so you could say
things like "I'm only interested in packets with a latency higher than x"
but it doesn't look like it works that way.

Thanks,

Will
