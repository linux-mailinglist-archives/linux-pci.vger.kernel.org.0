Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41DF3A5F06
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jun 2021 11:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbhFNJWf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Jun 2021 05:22:35 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3231 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbhFNJWf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jun 2021 05:22:35 -0400
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G3QfT0cPDz6G9Jq;
        Mon, 14 Jun 2021 17:10:57 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 14 Jun 2021 11:20:31 +0200
Received: from localhost (10.52.126.149) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Mon, 14 Jun
 2021 10:20:30 +0100
Date:   Mon, 14 Jun 2021 10:20:25 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Will Deacon <will@kernel.org>
CC:     Qi Liu <liuqi115@huawei.com>, <mark.rutland@arm.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangshaokun@hisilicon.com>
Subject: Re: [PATCH v6 2/2] drivers/perf: hisi: Add driver for HiSilicon
 PCIe PMU
Message-ID: <20210614102025.0000222b@Huawei.com>
In-Reply-To: <20210611162347.GA16284@willie-the-truck>
References: <1622467951-32114-1-git-send-email-liuqi115@huawei.com>
        <1622467951-32114-3-git-send-email-liuqi115@huawei.com>
        <20210611162347.GA16284@willie-the-truck>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.126.149]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 11 Jun 2021 17:23:48 +0100
Will Deacon <will@kernel.org> wrote:

> On Mon, May 31, 2021 at 09:32:31PM +0800, Qi Liu wrote:
> > PCIe PMU Root Complex Integrated End Point(RCiEP) device is supported
> > to sample bandwidth, latency, buffer occupation etc.
> > 
> > Each PMU RCiEP device monitors multiple Root Ports, and each RCiEP is
> > registered as a PMU in /sys/bus/event_source/devices, so users can
> > select target PMU, and use filter to do further sets.
> > 
> > Filtering options contains:
> > event        - select the event.
> > subevent     - select the subevent.
> > port         - select target Root Ports. Information of Root Ports
> >                are shown under sysfs.
> > bdf          - select requester_id of target EP device.
> > trig_len     - set trigger condition for starting event statistics.
> > trigger_mode - set trigger mode. 0 means starting to statistic when
> >                bigger than trigger condition, and 1 means smaller.
> > thr_len      - set threshold for statistics.
> > thr_mode     - set threshold mode. 0 means count when bigger than
> >                threshold, and 1 means smaller.
> > 
> > Reviewed-by: John Garry <john.garry@huawei.com>
> > Signed-off-by: Qi Liu <liuqi115@huawei.com>
> > ---
> >  MAINTAINERS                                |    6 +
> >  drivers/perf/Kconfig                       |    2 +
> >  drivers/perf/Makefile                      |    1 +
> >  drivers/perf/pci/Kconfig                   |   16 +
> >  drivers/perf/pci/Makefile                  |    2 +
> >  drivers/perf/pci/hisilicon/Makefile        |    3 +
> >  drivers/perf/pci/hisilicon/hisi_pcie_pmu.c | 1019 ++++++++++++++++++++++++++++  
> 
> Can we keep this under drivers/perf/hisilicon/ please? I don't see the
> need to create a 'pci' directory here.

https://lore.kernel.org/linux-pci/20190103154439.GC16311@edgewater-inn.cambridge.arm.com/

Discussion back in 2018 about where to put these...

Though, perf/pci/hisilicon does seem over the top in terms of depth, maybe perf/pci/
or just give up on that plan and put them (for now at least) in per company directories.

Jonathan
