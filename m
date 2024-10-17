Return-Path: <linux-pci+bounces-14785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8C09A243E
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 15:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87119B25C0A
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 13:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AC81DDC07;
	Thu, 17 Oct 2024 13:50:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224F5C147;
	Thu, 17 Oct 2024 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173033; cv=none; b=O4YlsCd37CO/eiNGjnuE1iNASl4mQPvElU8gPRc3fiSY6QAcuRUafg3okHVVGN6KqQnw6HKhekjP/vNNkRqWX3WJY57OvcjagWEiIb4eWqh/cmFriwxkYRSFmvzAEsjMe/hjoOEXaRRAMOgZDgV06ED1pZwT9wIWLLzeQ5AD+WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173033; c=relaxed/simple;
	bh=5xPrhuKuYkqwxlo94JQl2Xs8SYAd5QckIzmBS+1GY5k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nmL7DlGhbCSxYi1GZZlFvjQyNzGDP0MmDDGRdko+VPqMOTQvMUweq840sVgH1K8CowgGh7jXOe+BX3I8BAiu3jnDh+o+DZEJ9iEuprpveBhfuWLRarzei8YBOT5qYn1aQjfbUKXz9KqY9SIFSYR3g7+EZE1GP1t7LBnP+jS/K3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTpyD10pRz6D9BV;
	Thu, 17 Oct 2024 21:45:56 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BD13E1400F4;
	Thu, 17 Oct 2024 21:50:27 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 15:50:26 +0200
Date: Thu, 17 Oct 2024 14:50:25 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <Terry.Bowman@amd.com>
CC: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <oohall@gmail.com>,
	<Benjamin.Cheatham@amd.com>, <rrichter@amd.com>, <nathan.fontenot@amd.com>,
	<smita.koralahallichannabasappa@amd.com>
Subject: Re: [PATCH 09/15] cxl/pci: Map CXL PCIe downstream port RAS
 registers
Message-ID: <20241017145025.00002fd3@Huawei.com>
In-Reply-To: <4a298643-28f0-4aac-be2d-32b8ff835e2a@amd.com>
References: <20241008221657.1130181-1-terry.bowman@amd.com>
	<20241008221657.1130181-10-terry.bowman@amd.com>
	<20241016181459.00000b71@Huawei.com>
	<4a298643-28f0-4aac-be2d-32b8ff835e2a@amd.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 16 Oct 2024 13:16:34 -0500
Terry Bowman <Terry.Bowman@amd.com> wrote:

> Hi Jonathan,
> 
> On 10/16/24 12:14, Jonathan Cameron wrote:
> > On Tue, 8 Oct 2024 17:16:51 -0500
> > Terry Bowman <terry.bowman@amd.com> wrote:
> >   
> >> RAS registers are not mapped for CXL root ports, CXL downstream switch
> >> ports, or CXL upstream switch ports. To prepare for future RAS logging
> >> and handling, the driver needs updating to map PCIe port RAS registers.  
> > 
> > Give the upstream port is in next patch, I'd just mention that you
> > are adding mapping of RP and DSP here (This confused me before I noticed
> > the next patch).  
> 
> Ok. Good point, 
> 
> >>
> >> Refactor and rename cxl_setup_parent_dport() to be cxl_init_ep_ports_aer().
> >> Update the function such that it will iterate an endpoint's dports to map
> >> the RAS registers.
> >>
> >> Rename cxl_dport_map_regs() to be cxl_dport_init_aer(). The new
> >> function name is a more accurate description of the function's work.
> >>
> >> This update should also include checking for previously mapped registers
> >> within the topology, particularly with CXL switches. Endpoints under a
> >> CXL switch may share a common downstream and upstream port, ensure that
> >> the registers are only mapped once.  
> > 
> > I don't understand why we need to do this for the ras registers but
> > it doesn't apply for HDM decoders for instance?  Why can't
> > we map these registers in cxl_port_probe()?
> >   
> 
> We have seen downstream root ports with DVSECs that are not fully populated 
> immediately after booting. The plan here was to push out the RAS register 
> block mapping until as late as possible, in the memdev driver. 

That needs debugging because simply pushing it later like this is
only going to make the race harder to hit unless we understand the
'why' of that.   If there is a reason to delay, my gut feeling would
be to delay the cxl_port_probe() until things are stable rather
than just trying this a bit later.

This might be the whole link must train before CXL registers are
presented thing (a less than ideal corner of the CXL spec) but not
sure it would mean they weren't available in cxl_port_probe()

Jonathan



> 
> 
> > End of day here, so maybe I'm completely misunderstanding this.
> > Will take another look tomorrow morning.
> >   
> 
> Thanks for your reviews.
> 
> Regards,
> Terry
> 


