Return-Path: <linux-pci+bounces-22100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E4DA40964
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 16:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF6B3B449C
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 15:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD9F1C84A0;
	Sat, 22 Feb 2025 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bsqs+OeG"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EB714A095;
	Sat, 22 Feb 2025 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740237237; cv=none; b=Bz/oA129W8J1ADT5Kexg73e4DLbHtMv+jDXCimxSCl7vOFXvV0CNVk38PJE6rd3f+0sv3ccDLE0KCrWPXNkHb17Xn5CpiYiq/a6HOlhbBXV3IEz6+0T89+9WQ0Qs0I3lv0DfbhvB+fqHjNcNd4h15zGryLIenvYasDXiQRBk4mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740237237; c=relaxed/simple;
	bh=eLv2WdGE3WLS+Gl4dAZC9ujQ6wHTetrgJNGQuU1OzEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=muILyz0/6NlVwygA7R+57FMoTweHvtLDTpK83TKux1D88KSefgXpe0ZZnBO9j23kKW+3lTtkOpl4GBcmKbGqx+C4UVH2iMggdWcgivRJWlPdWfFQDbNXkMHtvXBoI9Jfha8I01eOa4ZMj3kmcuGTL1yLIQz19NlcIncFtqnVfkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bsqs+OeG; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=O+cGUJzx3X/N/qwTMlrB2dvbfUXp6VQLkctIKKwJYig=;
	b=bsqs+OeGrSo0ZCswBU6TLzrnBouf9zYV0H0MfkxNBqUEfF3zzwpGhxXMnEGE9X
	qLtWfO8tuWGCdfwrRFEKmyju//9SKmfNAJLDPkpaPZE58jeb6JfVr5xEnX8tOjUF
	hjlck12TPmO85F+i7MBwqEGNO4TU9P6z5KFsVQLltXfzY=
Received: from [192.168.71.44] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3V+KH6blnkkvWNw--.56540S2;
	Sat, 22 Feb 2025 23:13:12 +0800 (CST)
Message-ID: <a0ea01af-ecbe-4006-a068-2e21d55ada8b@163.com>
Date: Sat, 22 Feb 2025 23:13:10 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4] PCI: dwc: Add the debugfs property to provide the LTSSM
 status of the PCIe link
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: jingoohan1@gmail.com, shradha.t@samsung.com,
 manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, robh@kernel.org,
 bhelgaas@google.com, Frank.Li@nxp.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, rockswang7@gmail.com,
 Niklas Cassel <cassel@kernel.org>
References: <20250222143335.221168-1-18255117159@163.com>
 <20250222145432.GB3735810@rocinante>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250222145432.GB3735810@rocinante>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3V+KH6blnkkvWNw--.56540S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUF_MaUUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDw-7o2e55YhANgAAsd



On 2025/2/22 22:54, Krzysztof Wilczyński wrote:
> Hello,
> 
> [...]
>> +What:		/sys/kernel/debug/dwc_pcie_<dev>/ltssm_status
>> +Date:		February 2025
>> +Contact:	Hans Zhang <18255117159@163.com>
>> +Description:	(RO) Read will return the current value of the PCIe link status raw value and
>> +		string status.
> 
> The description could be refined a bit to make it easier to read.  But this
> is not a blocked and the changes otherwise look good.
> 
> Thank you Niklas for testing!
> 
> I will pick this up if there are no objections.
> 

Thank you very much. I have no objection.

Best regards
Hans


