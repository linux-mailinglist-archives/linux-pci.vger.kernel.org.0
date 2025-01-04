Return-Path: <linux-pci+bounces-19302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39291A0153A
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 15:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161ED160E14
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 14:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C751474B7;
	Sat,  4 Jan 2025 14:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aApIADgm"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD5A20323;
	Sat,  4 Jan 2025 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736000781; cv=none; b=p6T/ziVkbnKbuPW1PrzHfbp7iHx7RJkXV3MnI2fpWGhWbSydoZ9nNynRN55xPIX4q/TGSZb8S1sBhEwC6vfYq3QB/H0IbF8wH1pSq3u468kO+SesZ0XCrDF7PAbBhBeRTac6Ml3HR2IPKxLEbAfbj7rlVXtBIxiOIVDrqi5vz+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736000781; c=relaxed/simple;
	bh=HK59VqWvP7X5vwZMHafoK0umWJM7adlMu6Bf+n8Asio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HNXfd6NWUJ7+yQfD4SDUnJ/P4ZkYFf0Q8a+nBULZUz2AAg6Z9O6SS2hw+PQQ38BrhBG2V6a8pw9+IG+B2N8G0/uE1mstIRE0/5Rgm1EkQ00eEbmHprClfJlKLnZQK7/iLs4jNMGc2ffOMbnDRlD2y/0JR5Bs4INgKg45hcAqRKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aApIADgm; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=b6M8hEEzktQnKcAZb6WgSEOdQR834kGZcJHkayjLAYs=;
	b=aApIADgmTCvA30f4ZLTtKFjiGDcwB+9vbvSQq7U1qsQb4PxEt8XSpC0uRmvSz9
	cD/73hlx3u9mMAFqhDZOeVO0kxUrg5Pb79nFqY24ai5WOiX5UWMiN0fFiLQsNb83
	bzHSBqujifYh+JpKxQ/TCybaEkx5aQfAtANB1lwiRk7i8=
Received: from [192.168.71.44] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3_1jTRHlnCC+FDw--.4900S2;
	Sat, 04 Jan 2025 22:25:24 +0800 (CST)
Message-ID: <9a8437bb-73d3-4b63-af6a-b2704b7034db@163.com>
Date: Sat, 4 Jan 2025 22:25:24 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5] misc: pci_endpoint_test: Fix overflow of bar_size
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kishon@kernel.org,
 arnd@arndb.de, gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, rockswang7@gmail.com,
 kernel test robot <lkp@intel.com>, Niklas Cassel <cassel@kernel.org>
References: <20250103220200.GA9636@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250103220200.GA9636@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3_1jTRHlnCC+FDw--.4900S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUfvPfUUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwTKo2d5QKxHegABss



On 2025/1/4 06:02, Bjorn Helgaas wrote:
>> The return value of the `pci_resource_len` interface is not an integer.
>> Using `pcitest` with an 8GB BAR2, the bar_size of integer type will
>> overflow.
>> Change the data type of bar_size from integer to resource_size_t, to fix
>> the above issue.
> 
> Add blank lines between paragraphs.
> 
> Looks good to me.
> 


Thank you Bjorn.

Regards
Hans


