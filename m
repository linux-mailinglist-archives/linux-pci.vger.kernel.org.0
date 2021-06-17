Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CEB3ABAFB
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jun 2021 19:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhFQR7S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Jun 2021 13:59:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231800AbhFQR7R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Jun 2021 13:59:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 590D8613CE;
        Thu, 17 Jun 2021 17:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623952629;
        bh=EhSsmsI9iGJevWK6dFC1JCY+kzfJnsUdrl+be5LxLiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f125yxtkpG4p0zjEUVnwR25SUAoSZfM1gPA1tkxmH0FlV+r/AcE3al5sqb7AOw8ma
         V49i6NeTJOv0IBS93Bn1Jp71Df3+wAleDXVYRkMNKUo4jJDWPylnS5Sv25X2AxBU0A
         lHppEjiIUhrJocXFpqhaqGlRY83eDe6EvLXcNUOt1ZXAIcdiXKszhIOuWzQTPwDeG+
         S0smvRD5gaqcSW8JsrjwuXWMOS2Or5X1Ejg8VCYHvP3zhZCIjQwDM/K5TiLJua0jO5
         6tl7rlUlevzUvWZm/3ibhzMnBaVvqG7zy+sz//cB7ZAiIC/mFR1VSM2XnLTkd9Qpj+
         XrQEl+3SYp7ug==
Date:   Thu, 17 Jun 2021 18:57:05 +0100
From:   Will Deacon <will@kernel.org>
To:     "liuqi (BA)" <liuqi115@huawei.com>
Cc:     Linuxarm <linuxarm@huawei.com>, mark.rutland@arm.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhangshaokun@hisilicon.com
Subject: Re: [PATCH v6 2/2] drivers/perf: hisi: Add driver for HiSilicon PCIe
 PMU
Message-ID: <20210617175704.GF24813@willie-the-truck>
References: <1622467951-32114-1-git-send-email-liuqi115@huawei.com>
 <1622467951-32114-3-git-send-email-liuqi115@huawei.com>
 <20210611162347.GA16284@willie-the-truck>
 <a299d053-b45f-e941-7a2e-c853079b8cdd@huawei.com>
 <20210615093519.GB19878@willie-the-truck>
 <8e15e8d6-cfe8-0926-0ca1-b162302e52a5@huawei.com>
 <20210616134257.GA22905@willie-the-truck>
 <678f7d55-9408-f323-da53-b5afe2595271@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <678f7d55-9408-f323-da53-b5afe2595271@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 17, 2021 at 07:00:26PM +0800, liuqi (BA) wrote:
> 
> 
> On 2021/6/16 21:42, Will Deacon wrote:
> > Hi,
> > 
> > On Wed, Jun 16, 2021 at 09:54:23AM +0800, liuqi (BA) wrote:
> > > On 2021/6/15 17:35, Will Deacon wrote:
> > > > On Tue, Jun 15, 2021 at 04:57:09PM +0800, liuqi (BA) wrote:
> > > > > On 2021/6/12 0:23, Will Deacon wrote:
> > > > > > On Mon, May 31, 2021 at 09:32:31PM +0800, Qi Liu wrote:
> > > > > > > +	/* Process data to set unit of latency as "us". */
> > > > > > > +	if (is_latency_event(idx))
> > > > > > > +		return div64_u64(data * us_per_cycle, data_ext);
> > > > > > > +
> > > > > > > +	if (is_bus_util_event(idx))
> > > > > > > +		return div64_u64(data * us_per_cycle, data_ext);
> > > > > > > +
> > > > > > > +	if (is_buf_util_event(idx))
> > > > > > > +		return div64_u64(data, data_ext * us_per_cycle);
> > > > > > 
> > > > > > Why do we need to do all this division in the kernel? Can't we just expose
> > > > > > the underlying values and let userspace figure out what it wants to do with
> > > > > > the numbers?
> > > > > > 
> > > > > Our PMU hardware support 8 sets of counters to count bandwidth, latency and
> > > > > utilization events.
> > > > > 
> > > > > For example, when users set latency event, common counter will count delay
> > > > > cycles, and extern counter count number of PCIe packets automaticly. And we
> > > > > do not have a event number for counting number of PCIe packets.
> > > > > 
> > > > > So this division cannot move to userspace tool.
> > > > 
> > > > Why can't you expose the packet counter as an extra event to userspace?
> > > > 
> > > Maybe I didn’t express it clearly.
> > > 
> > > As there is no hardware event number for PCIe packets counting, extern
> > > counter count packets *automaticly* when latency events is selected by
> > > users.
> > > 
> > > This means users cannot set "config=0xXX" to start packets counting event.
> > > So we can only get the value of counter and extern counter in driver and do
> > > the division, then pass the result to userspace.
> > 
> > I still think it would be ideal if we could expose both values to userspace
> > rather than combine them somehow. Hmm. Anyway...
> > 
> > I struggled to figure out exactly what's being counted from the
> > documentation patch (please update that). Please can you explain exactly
> > what appears in the HISI_PCIE_CNT and HISI_PCIE_EXT_CNT registers for the
> > different modes of operation? Without that, the ratios you've chosen to
> > report seem rather arbitrary.
> > 
> 
> PCIe PMU events can be devided into 2 types: one type is counted by
> HISI_PCIE_CNT, the other type is counted by HISI_PCIE_EXT_CNT and
> HISI_PCIE_CNT, including bandwidth events, latency events, buffer
> utilization and bus utilization.
> 
> if user sets "event=0x10, subevent=0x02", this means "latency of RX memory
> read" is selected. HISI_PCIE_CNT counts total delay cycles and
> HISI_PCIE_EXT_CNT counts PCIe packets number at the same time. So PMU driver
> could obtain average latency by caculating: HISI_PCIE_CNT /
> HISI_PCIE_EXT_CNT.
> 
> if users sets "event=0x04, subevent=0x01", this means bandwidth of RX memory
> read is selected. HISI_PCIE_CNT counts total packet data volume and
> HISI_PCIE_EXT_CNT counts cycles, so PMU driver could obtain average
> bandwidth by caculating: HISI_PCIE_CNT / HISI_PCIE_EXT_CNT.
> 
> The same logic is used when calculating bus utilization and buffer
> utilization. Seems I should add this part in Document patch,I 'll do this in
> next version, thanks.
> 
> > I also couldn't figure out how the latency event works. For example, I was
> > assuming it would be a filter (a bit like the length), so you could say
> > things like "I'm only interested in packets with a latency higher than x"
> > but it doesn't look like it works that way.
> > 
> > Thanks,
> > 
> latency is not a filter, PCIe PMU has a group of lactency events, their
> event number are within the latency_events_list, and the above explains how
> latency events work.
> 
> PMU drivers have TLP length filter for bandwidth events, users could set
> like "I only interested in bandwidth of packets with TLP length bigger than
> x".

Thanks for the explanations, I think I get it a bit better now. But I still
think we should be exposing both of the values to userspace instead of
reporting the ratio from which the individual counters are then
unrecoverable.

It will complicate the driver slightly, but can we instead expose the
events independently and then allowing scheduling some of them in groups?

That way we just treat HISI_PCIE_CNT and HISI_PCIE_EXT_CNT as separate
counters, but with a scheduling constraint that events in a register pair
must be in the same group.

Will
