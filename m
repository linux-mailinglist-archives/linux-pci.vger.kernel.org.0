Return-Path: <linux-pci+bounces-37740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 27915BC6B65
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 23:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A3E1A346062
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 21:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13C6266584;
	Wed,  8 Oct 2025 21:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="TGYhuhUZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA9020296E
	for <linux-pci@vger.kernel.org>; Wed,  8 Oct 2025 21:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759960497; cv=none; b=ohOwWnUH+ueQ6JUdxldnPQaQeKZtVpHBWoo0iwxXCjMSFIBFt7tor2wimj6+dk5YYrHCp/0OtuAij+Y9oxjtJR0LoLMtaBo5uDk9TrUENyEQl5Vcs4hWAU7CCa1obhvdt66vU3i5MYLtwThUnXHZ2pSWCaB1BKeKZ1rW6acXZKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759960497; c=relaxed/simple;
	bh=mzV3wm42ZYodzyVBrXJ7Jca/XFyIthUKVCkPTzaKz9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bkCYFCKfPjDvorHKSR6Wqmk1x+UwbsCTXUKhFbBeEJ/e+UGodWvF5lcTAkJdyJawgmLnf+AnOwRAT9EJr6ESx7UuXU3pegGLzV9k07T+m/wWjPQQzSG6hlVPX/iJVu6V8JD/FFS0K+Wt7/c86HYwmKkoNHQVRR0HKCTEAsCiqug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=TGYhuhUZ; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [10.50.4.39] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4chmy64K7Lz44R0;
	Wed,  8 Oct 2025 17:54:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1759960495; bh=mzV3wm42ZYodzyVBrXJ7Jca/XFyIthUKVCkPTzaKz9E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TGYhuhUZgkxWdO6sFYnpMtsCJAEUspBYQNM4sc7Lx67AresrO02NLmF19D84okVt6
	 ghIVnYk5wlQ+RLNZWP9jidvpwGElmgBagLHGlehERx4MGRF1eE45GdNd+Gkf/p4Byo
	 kk3qqCtb0Xitr5g+GH/RSJFs03hhD8Kxk1B4UA4I=
Message-ID: <45c7e859-8435-484c-b800-3c22ba267add@panix.com>
Date: Wed, 8 Oct 2025 14:54:53 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Commit 4292a1e45fd4 ("PCI: Refactor distributing available memory
 to use loops") gives errors enumerating TBolt devices behind my TB dock
To: Bjorn Helgaas <helgaas@kernel.org>, Kenneth C <kenny@panix.com>
Cc: ilpo.jarvinen@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org
References: <20251008215233.GA645164@bhelgaas>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <20251008215233.GA645164@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/8/25 14:52, Bjorn Helgaas wrote:

 > Can I include a link to your report and your Tested-by?

Just sent one.

-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


