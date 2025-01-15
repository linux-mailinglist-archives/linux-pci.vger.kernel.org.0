Return-Path: <linux-pci+bounces-19881-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908A4A122BF
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 12:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E7B3A1FC1
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 11:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8BE20F968;
	Wed, 15 Jan 2025 11:38:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E69248BDD;
	Wed, 15 Jan 2025 11:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736941083; cv=none; b=JLY9FYctXVJP1ESc5MejPaYZSgV25YGfDdUJwuWH5M7B4Zv1OVa4QAQDTyWrafhdCWlUe9w2p6srkjYHSJ3RmLjaH0H0AhCdEG1n0kpKFrRohX6+ucJ1H0yYmytzHprIwvgsoV9N9gbJkP9osaEUpwCXaRQ+NoWtrkyoqGr0WPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736941083; c=relaxed/simple;
	bh=10XO6NeQ2gQ7U9/3Iyhh7c2d5YQjaG9c3qMuTZu6YCs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fjAVKmSk6YthIdmU26c7B5+rdfA6etsTJUOCnVNZTmS+5lZ2cLgE8wBmmm/FPrF/M2k/xFYrgq+me2WsX0Kn2ovnxqTBxB/iJG6evL+JU/DE5nbWIlVU3U9GP6fAjuMFpWbXwE7jlG83z4WBBVUwJfz6NtdiJoQL65YHq/+lM8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YY3qK26CNz6K6Q7;
	Wed, 15 Jan 2025 19:36:29 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 430CE140257;
	Wed, 15 Jan 2025 19:37:59 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 15 Jan
 2025 12:37:58 +0100
Date: Wed, 15 Jan 2025 11:37:56 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Bowman, Terry" <terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>, <alucerop@amd.com>
Subject: Re: [PATCH v5 07/16] PCI/AER: Add CXL PCIe Port uncorrectable error
 recovery in AER service driver
Message-ID: <20250115113756.00005561@huawei.com>
In-Reply-To: <eba67f31-57cd-49b1-b062-c56fce306a47@amd.com>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
	<20250107143852.3692571-8-terry.bowman@amd.com>
	<20250114113347.00006865@huawei.com>
	<eba67f31-57cd-49b1-b062-c56fce306a47@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 14 Jan 2025 14:28:13 -0600
"Bowman, Terry" <terry.bowman@amd.com> wrote:

> On 1/14/2025 5:33 AM, Jonathan Cameron wrote:
> > On Tue, 7 Jan 2025 08:38:43 -0600
> > Terry Bowman <terry.bowman@amd.com> wrote:
> >  
> >> Existing recovery procedure for PCIe uncorrectable errors (UCE) does not
> >> apply to CXL devices. Recovery can not be used for CXL devices because of
> >> potential corruption on what can be system memory. Also, current PCIe UCE
> >> recovery, in the case of a Root Port (RP) or Downstream Switch Port (DSP),
> >> does not begin at the RP/DSP but begins at the first downstream device.
> >> This will miss handling CXL Protocol Errors in a CXL RP or DSP. A separate
> >> CXL recovery is needed because of the different handling requirements
> >>
> >> Add a new function, cxl_do_recovery() using the following.
> >>
> >> Add cxl_walk_bridge() to iterate the detected error's sub-topology.
> >> cxl_walk_bridge() is similar to pci_walk_bridge() but the CXL flavor
> >> will begin iteration at the RP or DSP rather than beginning at the
> >> first downstream device.  
> > I'm still holding out for making pci_walk_bridge() do the same and seeing
> > what if anything breaks.  
> 
> I can test AER fatal UCE on a PCIe device. Do you have any other ideas for specific
> testing? A specific device or topology in mind ?

It's the interaction with runtime power management usage that worries me and
might need wider testing.  Maybe it is just a case of sending a patch marked
RFT.

The other paths are no-op where it matters.

Jonathan

> 
> Regards,
> Terry
> 
> > Other than that I'm fine with this patch.
> >  
> >> Add cxl_report_error_detected() as an analog to report_error_detected().
> >> It will call pci_driver::cxl_err_handlers for each iterated downstream
> >> device. The pci_driver::cxl_err_handler's UCE handler returns a boolean
> >> indicating if there was a UCE error detected during handling.
> >>
> >> cxl_do_recovery() uses the status from cxl_report_error_detected() to
> >> determine how to proceed. Non-fatal CXL UCE errors will be treated as
> >> fatal. If a UCE was present during handling then cxl_do_recovery()
> >> will kernel panic.
> >>
> >> Signed-off-by: Terry Bowman <terry.bowman@amd.com>  
> 


