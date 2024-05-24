Return-Path: <linux-pci+bounces-7817-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9538CE77A
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2024 17:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85707281F3F
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2024 15:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E17912CD9D;
	Fri, 24 May 2024 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f8qgCiBF"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FB848CCC
	for <linux-pci@vger.kernel.org>; Fri, 24 May 2024 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716562991; cv=none; b=KBD3QNaAhZui2AB54WjagViWbrYB/ljjGUpBBu6X4umAylybOLw0FNXDqe8pcMzMLtbFNaxGK4hFGrsEcftyDE5w9bUxyUnOZeEgrvIPKeC1R7dnnH8jUzAawcIW+ESsHScIMt6FsDQBzSMHEUPnowpbZF9MJ5S9Wh0mUO/3BqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716562991; c=relaxed/simple;
	bh=CpUZTSZfj0nKfLtWsHuCSEpWRiKnvmgNyl6rkup5g5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MaGK/WjKfdgBf2IajUt9qLuMOtsxcIFh+4P7AbAa6OUDG0uSXpy/1/mcjR71eY/fg0JjefRBuQtI5BFvuMZZmxfzCL6V+M6r1SzUoMyN9Pj6QcJPcaFqj+ZclosJQnaPrAnrfwB8TQ/sJ98/zjebyfM1jxnDPHamgaNHL53QMYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f8qgCiBF; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: dan.carpenter@linaro.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716562986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t9bLVr+GkFcIRkLEE2xi6Gq4uQdgtVR2m96QalOewfs=;
	b=f8qgCiBFT0iKngbIh5yIVDsyEoWOcyhplL8DknaJjzEX7VyBJJGzwU+rjsKXIvx5V6tqZ/
	mvzSvjZRBUad4tbniOCyKf9A3iSo49GZ1l1e9wvqCLucL1uvlpS/8W7wpQoZiR6Yoqwxgn
	C2DMzuJ40deEHhdzGzxEAmH7xA8I5CA=
X-Envelope-To: helgaas@kernel.org
X-Envelope-To: lpieralisi@kernel.org
X-Envelope-To: kw@linux.com
X-Envelope-To: robh@kernel.org
X-Envelope-To: linux-pci@vger.kernel.org
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: thippeswamy.havalige@amd.com
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: bhelgaas@google.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: stable@vger.kernel.org
X-Envelope-To: bharatku@xilinx.com
Message-ID: <3e7a23ae-6423-4455-9ffb-4820ee2dc92d@linux.dev>
Date: Fri, 24 May 2024 11:03:01 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/7] PCI: xilinx-nwl: Fix off-by-one in IRQ handler
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
 Michal Simek <michal.simek@amd.com>,
 Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
 linux-arm-kernel@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Bharat Kumar Gogada <bharatku@xilinx.com>
References: <20240522222834.GA101664@bhelgaas>
 <9299ee92-a32b-4b82-aa37-c7087a5c1376@linux.dev>
 <c2e1d87c-14e2-4efd-a5cd-f173b52dad35@moroto.mountain>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <c2e1d87c-14e2-4efd-a5cd-f173b52dad35@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/24/24 10:56, Dan Carpenter wrote:
> On Thu, May 23, 2024 at 11:21:52AM -0400, Sean Anderson wrote:
>> On 5/22/24 18:28, Bjorn Helgaas wrote:
>> > On Mon, May 20, 2024 at 10:53:57AM -0400, Sean Anderson wrote:
>> >> MSGF_LEG_MASK is laid out with INTA in bit 0, INTB in bit 1, INTC in bit
>> >> 2, and INTD in bit 3. Hardware IRQ numbers start at 0, and we register
>> >> PCI_NUM_INTX irqs. So to enable INTA (aka hwirq 0) we should set bit 0.
>> >> Remove the subtraction of one. This fixes the following UBSAN error:
>> > 
>> > Thanks for these details!
>> > 
>> > I guess UBSAN == "undefined behavior sanitizer", right?  That sounds
>> > like an easy way to find this but not the way users are likely to find
>> > it.
>> 
>> It's pretty likely they will find it this way, since I found it this way
>> and no one else had ;)
>> 
>> > I assume users would notice spurious and missing interrupts, e.g.,
>> > a driver that tried to enable INTB would have actually enabled INTA,
>> > so we'd see spurious INTA interrupts and the driver would never see
>> > the INTB it expected.
>> > 
>> > And a driver that tried to enable INTA would never see that interrupt,
>> > and we might not set any bit in MSGF_LEG_MASK?
>> 
>> And yes, this would manifest as INTx interrupts being broken.
>> 
> 
> It's so weird that it's been broken for seven years and no one reported
> it.  :/

If I had to guess it's because most PCIe hardware uses MSIs. Unless you
plugged in a PCI bridge there's almost no reason to use INTx at all.

--Sean

