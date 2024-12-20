Return-Path: <linux-pci+bounces-18916-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C71D39F991A
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 19:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF56216897B
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 18:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81F521A423;
	Fri, 20 Dec 2024 17:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="W4LPknin"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A935C22ACD2;
	Fri, 20 Dec 2024 17:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734717221; cv=none; b=QpcicciLL9IG/mcEBJmmawo5bOY0+QggZN/fQ2ImRaHKAHMiybXvCrmePlL4BY+aav72xbvNjzjaB+IO3vlvxmU5PylSWHm515km08b7t1okd+bgfM5Sdoyuh9pLTqglIwMpzhOr8oC1IlL7za5U+9nZ7y8LSBzKf/XGoLWfFjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734717221; c=relaxed/simple;
	bh=mVglfdLu38aSKc5NdTQ4oSJtWkYEUOLY+Pc5R5Ym90c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUOJIeZwizA8EVdVDdF0ZkDITa1SHPLMAIVq9dLAnMeqhKK2yhJGpFYs/CLu9lnLqf4SAhiYMb34nFyvJP1U06zmsBeSxWDbO8y93XRpnmoHnjsF7sAKpSSUkzoPuGdvoSnkpR/9uQiI7zPNEEkP/bFadJatuIKyZyRidSHbaas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=W4LPknin; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=Yi/4JvRUUSsh+buMB7WAZYO1zqPBkzMk+x1ImfPAemA=;
	b=W4LPkninmAJZj2OgCPMmMkMZDKyt2KrZmAMd5Z1cMy3jhJ3nez2FTVAEgbdHDX
	HcsfMQUkfYpW2v2iXIckEsDMAL3GHsJEmqIBAmhoz35m8M8weRpdG1JP9NtRkKJg
	6iQGHUvL0r46relafLeFPAonoiLMPX47i03RO/fT1RGTQ=
Received: from [192.168.71.44] (unknown [101.87.253.110])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBXu4cIr2VnzUkaDQ--.22459S2;
	Sat, 21 Dec 2024 01:53:13 +0800 (CST)
Message-ID: <7999f3ed-e5f0-4e20-88dc-527dd75038d4@163.com>
Date: Sat, 21 Dec 2024 01:53:12 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] misc: pci_endpoint_test: Fix return resource_size_t from
 pci_resource_len
To: Greg KH <gregkh@linuxfoundation.org>
Cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kishon@kernel.org,
 arnd@arndb.de, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 rockswang7@gmail.com
References: <20241220075253.16791-1-18255117159@163.com>
 <2024122035-stimulant-angling-3f42@gregkh>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <2024122035-stimulant-angling-3f42@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PCgvCgBXu4cIr2VnzUkaDQ--.22459S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4asjUUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxK7o2dlo4P6UgAAsb



On 2024/12/20 16:03, Greg KH wrote:

> The "changes" part goes below the --- line, as the documentation shows.
> 
> Please fix up.
> 

For newcomers submitting patch in the linux kernel community for the 
first time, thanks Greg KH for pointing out my mistake. Gave me a deeper 
insight into the whole submission process. I will fix it in the next 
version.

Regards
Hans


