Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8721848EF
	for <lists+linux-pci@lfdr.de>; Fri, 13 Mar 2020 15:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgCMOOV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Mar 2020 10:14:21 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2558 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726713AbgCMOOV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Mar 2020 10:14:21 -0400
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 532519DCF870C169B2BA;
        Fri, 13 Mar 2020 14:14:19 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 LHREML712-CAH.china.huawei.com (10.201.108.35) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 13 Mar 2020 14:14:18 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 13 Mar
 2020 14:14:18 +0000
Date:   Fri, 13 Mar 2020 14:14:16 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Qi Liu <liuqi115@huawei.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] perf:Add driver for HiSilicon PCIe PMU
Message-ID: <20200313141416.00002e89@Huawei.com>
In-Reply-To: <49a04327-b58b-3103-f992-97e8838c41df@arm.com>
References: <1584014816-1908-1-git-send-email-liuqi115@huawei.com>
        <49a04327-b58b-3103-f992-97e8838c41df@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 13 Mar 2020 13:23:53 +0000
Robin Murphy <robin.murphy@arm.com> wrote:

> On 2020-03-12 12:06 pm, Qi Liu wrote:
> > From: Qi liu <liuqi115@huawei.com>
> > 
> > PCIe PMU Root Complex Integrate End Point(IEP) device is
> > supported to sample bandwidth, latency, buffer occupation,
> > bandwidth utilization etc.
> > Each PMU IEP device monitors multiple root ports, and each
> > IEP is registered as a pmu in /sys/bus/event_source/devices,
> > so users can select the target IEP, and use filter to select
> > root port, function and event.
> > Filtering options are:
> > event:    - select the event.
> > subevent: - select the subevent.
> > port:     - select target root port.
> > func:     - select target EP device under the port.
> > 
> > Example: hisi_pcie_00_14_00/event=0x08,subevent=0x04,   \
> > port=0x05,func=0x00/ -I 1000
> > 
> > PMU IEP device is described by its bus, device and function,
> > target root port is 0x05 and target EP under it is function
> > 0x00. Subevent 0x04 of event 0x08 is sampled.
> > 
> > Note that in this RFC:
> > 1. PCIe PMU IEP hardware is still in development.
> > 2. Perf common event list is undetermined, and name of these
> > events still need to be discussed.
> > 3. port filter could only select one port each time.
> > 4. There are two possible schemes of pmu registration, one is
> > register each root port as a pmu, it is easier for users to
> > select target port. The other one is register each IEP as pmu,
> > for counters are per IEP, not per root port, the second scheme
> > describes hardware PMC much more reasonable, but need to add
> > "port" filter option to select port. We use the second one in
> > this RFC.
> > 

Whilst it's great to have detailed feedback, just to make it clear...

This is an RFC for the reasons above.  They include that the hardware
is still in development - i.e. we can't test it because they've not finished
implementation yet.

The intention of posting so early is to get some feedback on the general
approach and the specific points in 2,3 and 4 above.

The key fiddly point with this is that it is a shared PMU across a set
of PCIe Root Ports (there are several of these devices on each SoC in
the system covering a set of ports each).
That makes for a somewhat fiddly interface, hence the RFC.

Thanks to everyone who has reviewed though as definitely some stuff for liuqi to
fix!

Jonathan


