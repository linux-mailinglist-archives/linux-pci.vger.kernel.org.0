Return-Path: <linux-pci+bounces-20924-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4E1A2CA96
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 18:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4157016339A
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 17:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A125192590;
	Fri,  7 Feb 2025 17:54:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8A2175D5D;
	Fri,  7 Feb 2025 17:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738950883; cv=none; b=TzEmcqR0iEPYuQjE1yiCp7QcE484kjV/61YtvCmrphImom9zs8AFRSmqgx+fvAOZKHSiquIbybDfhZfxlMUNBX6paT/KVqE6fftdI9gCFzGzT+J9a20pk4pXmX3roiiahoCHCIM9K7zj7+edSOr7CqV22kfjYVKKM/mR6kiOuSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738950883; c=relaxed/simple;
	bh=+ZlAUDYXjVATgKZDHxmYjkw0Po2FvBcmpeCykALulDk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hT7uhmwdyUhc2okT8mmWvyfavkPiLCEoV+uYZ38JfuvS1Ukm25U8DUDNHBt98hFEEIdfrBEahyZetjiW75JBNB5n7kuTfx5IitR8VaCvniK3TQofZuc4g1bcbU/Kn3oX4ZZaotr0dhxYCeR0kbiBztto/4aZWKzNBfTHDIgkS00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YqM5r2gYFz6JB2n;
	Sat,  8 Feb 2025 01:53:36 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 13C13140A30;
	Sat,  8 Feb 2025 01:54:38 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Feb
 2025 18:54:37 +0100
Date: Fri, 7 Feb 2025 17:54:36 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: Terry Bowman <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nifan.cxl@gmail.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>,
	<alucerop@amd.com>
Subject: Re: [PATCH v5 05/16] PCI/AER: Add CXL PCIe Port correctable error
 support in AER service driver
Message-ID: <20250207175436.0000666b@huawei.com>
In-Reply-To: <Z6UAk_L22eqiWCix@gourry-fedora-PF4VCD3F>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
	<20250107143852.3692571-6-terry.bowman@amd.com>
	<Z6UAk_L22eqiWCix@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 6 Feb 2025 13:33:55 -0500
Gregory Price <gourry@gourry.net> wrote:

> On Tue, Jan 07, 2025 at 08:38:41AM -0600, Terry Bowman wrote:
> > The AER service driver supports handling Downstream Port Protocol Errors in
> > Restricted CXL host (RCH) mode also known as CXL1.1. It needs the same
> > functionality for CXL PCIe Ports operating in Virtual Hierarchy (VH)
> > mode.[1]
> > 
> > CXL and PCIe Protocol Error handling have different requirements that
> > necessitate a separate handling path. The AER service driver may try to
> > recover PCIe uncorrectable non-fatal errors (UCE). The same recovery is not
> > suitable for CXL PCIe Port devices because of potential for system memory
> > corruption. Instead, CXL Protocol Error handling must use a kernel panic
> > in the case of a fatal or non-fatal UCE. The AER driver's PCIe Protocol
> > Error handling does not panic the kernel in response to a UCE.
> >  
> 
> Naive question: is a panic actually required if the memory is a userland
> resource?

It's a protocol error, not a contained memory issue.
You'd need to find everything using that memory and kill it.

Maybe longer term if it's DAX and we know whole device is allocated
to only a few apps can resolve more smoothly.


> 
> The code in arch/x86/kernel/cpu/mce/core.c suggests we may not panic
> if an uncorrectable error occurs in this fashion, but simply a SIGBUS.
> 
> Unless this is down the wrong pipe - in which case disregard.
> 
> I'm still digging through background on this patch set so I may be
> barking up the wrong tree.
> 
> ~Gregory


