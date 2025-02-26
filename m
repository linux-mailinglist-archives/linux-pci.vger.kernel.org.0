Return-Path: <linux-pci+bounces-22413-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BACB7A456EA
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 08:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D28E63A9425
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 07:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4871898FB;
	Wed, 26 Feb 2025 07:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BTzTBsiI"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBC718DB11;
	Wed, 26 Feb 2025 07:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740555998; cv=none; b=V+ZfBLjbchDJw0jRVugFSxR2W1M6V8WjARbijwGcG/GMpwHHTesBenKPNQVVxYQIVXVUQ1V0zHnStlt7Hn8YQfqOK4NuGx2hYprq1YEOqLWADGLwJ7/UUK6VXXy62+hIU+NiaJ8fO/KCrIytIhQtf319WZ6uotIJ8VpHI9TEdGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740555998; c=relaxed/simple;
	bh=htiIrsPneWwoDMjes2uabsPqPPOGfdwTIXYloRnlEnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sPuoPgzs5K89rtUnOUAv3nLK/0o3v6jBPMtvw92a6QqzEJ55RX5HglvITLN3sV9IyuotwY0KFyraL56/tCxnqYxA0IHslcHApp2JrYjoyXOcQ7skBuhVLoFucko3m/y8a7/2kS5hrRMbNpLvEYVo8eZ6GxJGDjgLZBtsbgyBtM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BTzTBsiI; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=GvGqFtLmKyOHXz5diZhctPlmaDYH2nUi5LINlcE7Gig=;
	b=BTzTBsiIIgEAYGVn+6th2oQ2vVpPmEywHgHOppON3fRLINyaMgmFRQQ5DqqZMH
	2awwNxHMvLjWZA/oZs/92MLhcz3TLDKwb6k9QfObDPCYTKBVssBvcYiysha3EE3l
	uI1BO5v3nP4W3pK4ymmiemnR0ZN8N8bfdyX3EBWXzlXLI=
Received: from [192.168.34.52] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBH_zmkxr5nGvUvBA--.18617S2;
	Wed, 26 Feb 2025 15:45:41 +0800 (CST)
Message-ID: <13844a59-ab3a-409c-a43a-b3b29e56a5a0@163.com>
Date: Wed, 26 Feb 2025 15:45:40 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] PCI: dwc-debugfs: Couple of fixes
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org,
 bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, shradha.t@samsung.com, cassel@kernel.org
References: <20250225171239.19574-1-manivannan.sadhasivam@linaro.org>
 <e25e5d68-7fb7-4157-825c-eb973f7e1321@163.com>
 <20250226074339.GE951736@rocinante>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250226074339.GE951736@rocinante>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgBH_zmkxr5nGvUvBA--.18617S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUOXdjDUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiDxUAo2e+xEZPFAAAs5



On 2025/2/26 15:43, Krzysztof Wilczyński wrote:
> Hello,
> 
>> Can you submit after this patch? Otherwise, will my patch conflict?
>>
>> https://patchwork.kernel.org/project/linux-pci/patch/20250223141848.231232-1-18255117159@163.com/
> 
> No worries.  We can resolve conflicts while applying. :)
> 

I see, thanks Krzysztof for replying.

Best regards
Hans


