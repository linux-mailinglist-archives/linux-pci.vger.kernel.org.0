Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39333A7A7A
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 11:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhFOJ2M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 05:28:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231249AbhFOJ2L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Jun 2021 05:28:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3C4C61432;
        Tue, 15 Jun 2021 09:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623749167;
        bh=ysXE/y+QAGb8h7lBlVwFdUaiG4ulp9691EwnClnpiPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ltj3upRZDSv0lisL9uSpML8p7k8nql/Kcs9bD6lVWV1r+GEaBA9GzFRpJAq+LumR1
         YqkzCIOkfqEBfg2SfNqm9bFcc2MdJvUv0OcF1sduLdF/YrdkPveXM0q+I+qSkzdPWO
         eBPAhtfMYs93tQ4HweLwCgq+xubZnHZrLl+sPkYD3q/0wKWAgbE2X0ot8k6DLCiEoS
         d1qy9dBnOg/3YDuMnZvhZ8W7WGfO7Z7ToB3K61HfxsAKkOAkur/lNg7vkFRim+vdl5
         K0SSGz1+gKrGp27mHThH3Z0RefL3RApX3ro6SxGh/eCRyJ9ckfE9yhkTeGDOPwlVlx
         ODE0elsN2657Q==
Date:   Tue, 15 Jun 2021 10:26:02 +0100
From:   Will Deacon <will@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Qi Liu <liuqi115@huawei.com>, mark.rutland@arm.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangshaokun@hisilicon.com
Subject: Re: [PATCH v6 2/2] drivers/perf: hisi: Add driver for HiSilicon PCIe
 PMU
Message-ID: <20210615092601.GA19878@willie-the-truck>
References: <1622467951-32114-1-git-send-email-liuqi115@huawei.com>
 <1622467951-32114-3-git-send-email-liuqi115@huawei.com>
 <20210611162347.GA16284@willie-the-truck>
 <20210614102025.0000222b@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614102025.0000222b@Huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 14, 2021 at 10:20:25AM +0100, Jonathan Cameron wrote:
> On Fri, 11 Jun 2021 17:23:48 +0100
> Will Deacon <will@kernel.org> wrote:
> 
> > On Mon, May 31, 2021 at 09:32:31PM +0800, Qi Liu wrote:
> > > PCIe PMU Root Complex Integrated End Point(RCiEP) device is supported
> > > to sample bandwidth, latency, buffer occupation etc.
> > > 
> > > Each PMU RCiEP device monitors multiple Root Ports, and each RCiEP is
> > > registered as a PMU in /sys/bus/event_source/devices, so users can
> > > select target PMU, and use filter to do further sets.
> > > 
> > > Filtering options contains:
> > > event        - select the event.
> > > subevent     - select the subevent.
> > > port         - select target Root Ports. Information of Root Ports
> > >                are shown under sysfs.
> > > bdf          - select requester_id of target EP device.
> > > trig_len     - set trigger condition for starting event statistics.
> > > trigger_mode - set trigger mode. 0 means starting to statistic when
> > >                bigger than trigger condition, and 1 means smaller.
> > > thr_len      - set threshold for statistics.
> > > thr_mode     - set threshold mode. 0 means count when bigger than
> > >                threshold, and 1 means smaller.
> > > 
> > > Reviewed-by: John Garry <john.garry@huawei.com>
> > > Signed-off-by: Qi Liu <liuqi115@huawei.com>
> > > ---
> > >  MAINTAINERS                                |    6 +
> > >  drivers/perf/Kconfig                       |    2 +
> > >  drivers/perf/Makefile                      |    1 +
> > >  drivers/perf/pci/Kconfig                   |   16 +
> > >  drivers/perf/pci/Makefile                  |    2 +
> > >  drivers/perf/pci/hisilicon/Makefile        |    3 +
> > >  drivers/perf/pci/hisilicon/hisi_pcie_pmu.c | 1019 ++++++++++++++++++++++++++++  
> > 
> > Can we keep this under drivers/perf/hisilicon/ please? I don't see the
> > need to create a 'pci' directory here.
> 
> https://lore.kernel.org/linux-pci/20190103154439.GC16311@edgewater-inn.cambridge.arm.com/
> 
> Discussion back in 2018 about where to put these...

I don't remember that at all :)

> Though, perf/pci/hisilicon does seem over the top in terms of depth, maybe perf/pci/
> or just give up on that plan and put them (for now at least) in per company directories.

I think perf/hisilicon makes the most sense. We can always move it later
if we need to.

Will
