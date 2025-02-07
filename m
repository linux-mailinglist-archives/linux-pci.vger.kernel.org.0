Return-Path: <linux-pci+bounces-20857-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D34A2BB44
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 07:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 673E53A5F01
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 06:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8C01552F5;
	Fri,  7 Feb 2025 06:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DzOSZZY7"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689B942AB4;
	Fri,  7 Feb 2025 06:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738909038; cv=none; b=EmR5dOPyjBcu9NqnTdA7VXcn+bU/4pZhfrjE784TaZMNoZVs4XWyendR8+CT4s/Ng+TsL8Qn7TCdsfyhBrqTx1jRZil/0IFkSnH4mJoQOpHSBxH2e+9o6Ly7JlqAR7OG5XHULq5cUGLH84cxfiZbuZC4xqp0oKLATZzD/xUl8zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738909038; c=relaxed/simple;
	bh=BoigqwLejTiy6WOwR+LnLI+62cWTTtAoeFaLAurGVgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEKedgR6soHOGbf6zcMg/zKxoZKtRuidOnBVJfLMejvk6dDs4maik8i5klBjxzAQOIuIv75pkAcsym4dppFhuqq97dJabOenWtxqXzhmUapNVoeAkFAiTf8Jz1DNc1xlGoXLQyzEvbik9XO6suHmSwZPmaivbKu5LI62rX6uT70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DzOSZZY7; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738909029; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=zmB4+fPDEzx6le1QnJ4899+cMimXu8esoXeDNGgAD1k=;
	b=DzOSZZY7cio+F9uqC+DLNTXl+RoAGsSRZKHa4YfDEBN1Hi4PSPwR6YHt2Lu71C+iMXsv6zur7vpphldl6Ji53nDkcqLorYWOpsjMsWKVFosk7h2hi/75YPpUilIvC5fpYBLkf324jmzFPZ4wRbgyXEF7CFqeFJ3U1H68DztZ8G4=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WOyMQuC_1738909028 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Feb 2025 14:17:09 +0800
Date: Fri, 7 Feb 2025 14:17:08 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonthan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI/portdrv: Add necessary delay for disabling
 hotplug events
Message-ID: <Z6WlZGcnXExWLITZ@U-2FWC9VHC-2323.local>
References: <20250204053758.6025-1-feng.tang@linux.alibaba.com>
 <7e5e9bad-b66b-4a7f-8868-af5f1ab2fda1@linux.intel.com>
 <Z6QqGRNQ0UQZSKBB@U-2FWC9VHC-2323.local>
 <11a01c9b-5e52-46b8-ab13-e68ae79083ff@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11a01c9b-5e52-46b8-ab13-e68ae79083ff@linux.intel.com>

On Thu, Feb 06, 2025 at 08:26:13PM -0800, Sathyanarayanan Kuppuswamy wrote:
> 
> On 2/5/25 7:18 PM, Feng Tang wrote:
> > Hi Sathyanarayanan,
> > 
> > On Wed, Feb 05, 2025 at 10:26:59AM -0800, Sathyanarayanan Kuppuswamy wrote:
> > > On 2/3/25 9:37 PM, Feng Tang wrote:
> > > > According to PCIe 6.1 spec, section 6.7.3.2, software need to wait at
> > > > least 1 second for the command-complete event, before resending the cmd
> > > > or sending a new cmd.
> > > > 
> > > > Currently get_port_device_capability() sends slot control cmd to disable
> > > > PCIe hotplug interrupts without waiting for its completion and there was
> > > > real problem reported for the lack of waiting.
> > > Can you include the error log associated with this issue? What is the
> > > actual issue you are seeing and in which hardware?
> > For this one, we don't have specific log, as it was raised by firmware
> > developer, as in https://lore.kernel.org/lkml/Z6LRAozZm1UfgjqT@U-2FWC9VHC-2323.local/
> > 
> > When handling PCI hotplug problem, they hit issue and found their state
> > machine corrupted , and back traced to OS. They didn't expect to receive
> > 2 link control commands at almost the same time, which doesn't comply to
> 
> Which 2 commands from OS? Did you identify both commands?

Firmware developer saw 2 programming to PCIE Slot Control register of
one root port, first is writing 0x5ca, the second is writing 0x15f8. 

IIUC, the first one is to disable CCIE/HPIE here from get_port_device_capability()

Thanks,
Feng


