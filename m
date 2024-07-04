Return-Path: <linux-pci+bounces-9809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C129277AD
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 16:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC1F281CA5
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 14:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819E51822E2;
	Thu,  4 Jul 2024 14:03:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295962F37;
	Thu,  4 Jul 2024 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101839; cv=none; b=fwJL8Mo9R3MYPb3i2MEQJRwy2dpl5VAfL3tenKIFZNNAAroVcpfG0KSpJgWF2Kpg2xduUPrQBXg7PMuc6UURqKx9PWAX09AFphtc4+QPUefN0iLx4eEIGu2AjcZrUz9rDAb0YCF7r0pNrUFAwg3uL/rwKgCZdm2r16sA9nm1fbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101839; c=relaxed/simple;
	bh=MVrBqmDA7ChNGeqJBxGNH6p6O8C0qTo2ty+kIsd+RT4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OvhW2aEbukvsNeK2+VDQPS8fqNW5mDjpN1yXsyLwMRd7P8aeeW1Jfm5SZ/64nTQu5dU1RzR6FgwWGH7MXQhaPhXc9WjN83kfY/176hbPFdFZat2Hs/JSrfORejcgsx7Mpxkv+N+F3lSUSvvLF9VLlzewjyexgEWehwjNrosiP7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFJJ52gxsz6K65F;
	Thu,  4 Jul 2024 22:02:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id DAF781400D1;
	Thu,  4 Jul 2024 22:03:52 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 4 Jul
 2024 15:03:45 +0100
Date: Thu, 4 Jul 2024 15:03:44 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v6 2/2] cxl: Calculate region bandwidth of targets with
 shared upstream link
Message-ID: <20240704150344.00007f46@Huawei.com>
In-Reply-To: <6685f3bb2be5a_4fe7f2942f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240701215020.3813275-1-dave.jiang@intel.com>
	<20240701215020.3813275-3-dave.jiang@intel.com>
	<6685f3bb2be5a_4fe7f2942f@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 3 Jul 2024 17:58:35 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Dave Jiang wrote:
> > The current bandwidth calculation aggregates all the targets. This simple
> > method does not take into account where multiple targets sharing under
> > a switch where the aggregated bandwidth can be less or greater than the
> > upstream link of the switch.
> > 
> > To accurately account for the shared upstream uplink cases, a new update
> > function is introduced by walking from the leaves to the root of the
> > hierarchy and adjust the bandwidth in the process. This process is done
> > when all the targets for a region are present but before the final values
> > are send to the HMAT handling code cached access_coordinate targets.
> > 
> > The original perf calculation path was kept to calculate the latency
> > performance data that does not require the shared link consideration.
> > The shared upstream link calculation is done as a second pass when all
> > the endpoints have arrived.  
> 
> The complication of this algorithm really wants some Documentation for
> regression testing it. Can you include some "how to test this" or how it
> was tested notes?

Hi Dave, Dan,

FWIW I finally managed to get a flexible QEMU setup for testing this
and it looks almost prefect wrt to reported BW. Note I can't
do 2 layer switches without fixing some other assumptions in
the CXL QEMU emualation (shortcuts we took a long time ago) +
I'm hoping your maths is good for any thing that isn't 1 or 2
devices at each level.

I've got one case that isn't giving right answer.

Imagine system with a CPU Die between two IO dies (each in their
own NUMA nodes - typically because there are multiple CPU dies
and we care about the latencies / bandwidths from each to the
Host bridges).  If we always interleaved then we would just
make one magic GP node, but we might not for reasons of what else
is below those ports.  Equal distance, opposite direction on
interconnect so separate BW. Topology wise this isn't a fairy tale
btw so we should make it work.  Also can easily end up with this
if people are doing cross socket interleave.

   _____________  ____________  ____________
  |             ||            ||            |
  |   IO Die    ||   CPU Die  ||   IO Die   |
  |             ||            ||            |
  |   HB A      ||            ||   HB B     |
  |_____________||____________||____________|
        |                            |

etc.

ACPI / Discoverable components.


                 _____________
                |             |
                |  CPU node 0 |
                |_____________|
                  |         |
         _________|___    __|__________
        |             |  |             |
        |   GP Node 1 |  | GP Node 2   |
        |             |  |             |
        |   HB A      |  | HB B        |
        |_____________|  |_____________|
              |                |
             RPX              RPY
              |                |
            Type3J           Type3K

If the minimum BW is the sum of the CPU0 to GP Node 1 and GP Node 2
I'm currently seeing it reported as just one of those (so half what
is expected) I've checked the ACPI tables and it's all correct.

I'm not 100% sure why yet but suspect it's the bit under the comment
/*
 * Take the min of the downstream aggregated bandwidth and the
 * GP provided bandwidth if the parent is CXL Root.
 */
In case of multiple GP Nodes being involved, need to aggregate
across them and I don't think that is currently done.

Tests run.

CPU and GI (GI nearer to GP so access 0 and access 1 are slightly different)

GP/ 1HB / 2RP / 2Direct Connect Type 3
- Minimum BW at GP
- Minimum BW as Sum of Links.
- Minimum BW as Sum of read / write at devices.

2GP in one numa node/ 2HB/ 1RP per HB / 1 type 3 per RP. (should be same as above)
- Minimum BW at GP

2GP in separate numa node - rest as previous
- Minimum BW at GP (should be double previous one as no sharing of the HMAT
  described part - but it's not :()

GP / 1HB / 1RP / Shared Link / SW USP / 2 SW DSP / Separate Link / Type 3.
- Minimum BW at GP
- Minimum BW on the shared link.
- Minimum BW on the sum of the SSLBIS values for the switch.
- Minimum BW as sum of separate links.
- Minimum BW on the type 3.

I'll post the patches that add x-speed and x-width controls to
the various downstream ends of links (QEMU link negotiation is
minimalist to put it lightly and if your USP is no capable
will merrily let it appear to train with the DSP end faster
than the USP end) and also sets all the USPs to
support up to 64G / 16X

To actually poke the corners I'm hacking the CDAT tables
as don't have properties to control of those bandwidths yet.
I guess that needs to be part of a series intended to allow
general testing of this functionality.

I've only been focusing on BW in these tests given that's
what matters here.

The algorithm you have to make this work is complex so
I'd definitely be keen on hearing if you think it could
be simplified - took me a while to figure out what was
going on in this series.

Jonathan

p.s. Anyone like writing tests?  Lots more tests we could
write for this.  I'll include some docs in cover letter for
the QEMU RFC.


