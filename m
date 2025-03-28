Return-Path: <linux-pci+bounces-24922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9BCA74680
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 10:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 857A47A51F0
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 09:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818A2214213;
	Fri, 28 Mar 2025 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XDVcsD7a"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041C9214201;
	Fri, 28 Mar 2025 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743154991; cv=none; b=mwxAl7vWfdUO8n0fGHNYn83njhR6dM2eBq/193R/x7h59JXJ8IIQm4km0lBPXcciRSfTFC4DQkiyqZAb8zi8ME7oO2IcWXRFHjSJ4kBp69IPnxtPb1pxtu6og+3DzIzXr0Xeus8/mFw9H5oqJvR8ZHshT7yESz5JNUlsiuSRjcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743154991; c=relaxed/simple;
	bh=Uz2cDuHEufOtFymUNpC9MI6xr2RYgh/8dlmJ3aRQGh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMHGwvyd8jLZ4wlohe8s4UEzV0v8O3ElgTxTLRcpLD4s2FG+zm2tdUHDwd7YAhhBNe0/7AIVoM1C3n7r8IAct+p4gwZBb924xmRAFM22oXuGVJF/WSP7c08coPm0oOLbvzUqTa3Kaag7GffTZaSywQ4/n8U7/bDW1zin7i3ajog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XDVcsD7a; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=s5K9D8SsJxQwlxf37IRSWRjNqJqbccG3Q43+UCSor/4=;
	b=XDVcsD7ax/npWG1RqJcshjeXth64PIoDFv9lGTjN8FzvUPdw+tMM7WtQ+HBBsq
	kRmLkdflLmzSZ8CG8cBtcFDo/Ld9vOYFjf+8lzQI1RGrIN8KiPOVvBdKGCOZbwVL
	txlAL9F8H1ApM8gDeHcNykfmwqaLGjJ5GOCJ73JCggi8k=
Received: from [192.168.60.52] (unknown [222.71.101.198])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAXw7MJb+Znt92fSg--.53600S2;
	Fri, 28 Mar 2025 17:42:35 +0800 (CST)
Message-ID: <d73128b8-0d51-4a59-9a05-56339d5dfa59@163.com>
Date: Fri, 28 Mar 2025 17:42:34 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 1/5] PCI: Introduce generic capability search functions
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
 bhelgaas@google.com, jingoohan1@gmail.com, thomas.richard@bootlin.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250323164852.430546-1-18255117159@163.com>
 <20250323164852.430546-2-18255117159@163.com>
 <d6bxw26swugn6kmod5faycruzcmz4mbjcck3mhljikhmm7h4y3@o5voponyug2w>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <d6bxw26swugn6kmod5faycruzcmz4mbjcck3mhljikhmm7h4y3@o5voponyug2w>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:QCgvCgAXw7MJb+Znt92fSg--.53600S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUwg4SUUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhAeo2fmbkgVmAAAs9



On 2025/3/28 00:58, Manivannan Sadhasivam wrote:
> On Mon, Mar 24, 2025 at 12:48:48AM +0800, Hans Zhang wrote:
>> Existing controller drivers (e.g., DWC, custom out-of-tree drivers)
> 
> Oh, you should not mention 'out-of-tree drivers' as this patch is not anyway
> intented to benefit them. We certainly do not care about out of tree drivers.
> 


Hi Mani,

Thanks your for reply. Will delete.

Best regards,
Hans


