Return-Path: <linux-pci+bounces-19303-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F127A01540
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 15:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD41018844C4
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 14:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A5F1C3F06;
	Sat,  4 Jan 2025 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="o/O+KIUA"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307BC18A6AE;
	Sat,  4 Jan 2025 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736001021; cv=none; b=nwlJLlXQZpMXQZ099T2Gj7KYg3mDGzTkuLY2zIGpBbNji+yopNuQTD46xx4qmu4DxTwJaSchiK0zCXRIwePYx0RRuRbsn1QQ5btLXH4QLIcp1bYRiOCxGXjhYaOvBcp0Hn/HxkjPvtsf8HhY60dmKzI8eWarxgnY1WDfEv3grEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736001021; c=relaxed/simple;
	bh=wRkERf5rWJBVKkh9qQ2ihNA80X/kyAicVHBfs6mJxMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WmuEeoFkDJzw/w7SqYNNqeKHe0Ry5cbqChPGDY0ilSiCTMsSFR9RiuCrAvPjw+CqxFOS7VbEWeQCwgniR6JUvGjmg7wczZiyscYtfbUK1Nw+zVJ+ADqciaKJr8J3KNXtip9Lxevrno5Ux3m7p8uYa7ctWkmZ/18MGvJ5mghvDMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=o/O+KIUA; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=HEvQL4H9ugmnzz4dCHNiRr202YDDMrOUgBTSCeAZpbY=;
	b=o/O+KIUAk6T2iys80uNnamrXegZ/dEoxLGhAm49hhHCOgTTP39AJF9ouNVX1ou
	WbomhnoRs/+Eue1UiitRqYaeyMq390PcgB8CGHYf2D2ny6LRc6O5OheOAjBrsKQj
	Ysi91fwMZTQBDejD2M+HISfWam0cazYNNkmkLufdSAjTU=
Received: from [192.168.71.44] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wA3iz5sRXlnEtVZDw--.53763S2;
	Sat, 04 Jan 2025 22:27:57 +0800 (CST)
Message-ID: <63b8f8f5-1558-41b0-8392-901d287f4eb4@163.com>
Date: Sat, 4 Jan 2025 22:27:58 +0800
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
References: <20250103221222.GA10177@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250103221222.GA10177@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wA3iz5sRXlnEtVZDw--.53763S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUfvPfUUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiDxrKo2d5QqBGlAAAsS



On 2025/1/4 06:12, Bjorn Helgaas wrote:

> Apart from the kernel test robot error [1], of course.  Obviously that
> needs to be resolved.
> 
> [1] https://lore.kernel.org/r/202501021000.7Cwcopot-lkp@intel.com


I will fix it in version 7.

Regards
Hans


