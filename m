Return-Path: <linux-pci+bounces-24921-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B0DA7467E
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 10:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53AB83AE73A
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 09:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983502144DB;
	Fri, 28 Mar 2025 09:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PSF77Uf5"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73713213E74;
	Fri, 28 Mar 2025 09:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743154930; cv=none; b=ILflX1HFHIJh5cX9fhO+BZUGEsF1ongw3OQgNw2KBwg4RMQHOd2Y2hUX5+sjOs6oyl40Dh3z/rG734KF0Pjsx8Oqv48i60Of2BCdLacXFRZX6DZa8C9g/UPEephz6VjIYqxxhk/+48aLTi7KK85ODAfOi+4LLhnFTK3CLYM27/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743154930; c=relaxed/simple;
	bh=1tOm1RRKmLyexiYQKGJ5XtYsSWNwz4bNWr8NW7Dxk68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZNR/gcQD5HdtO8weDi8wzrLjx7XjYs2hVeEA2qtg1hJ+QaTYKJFV2cFsRhukW06JrXU2jhBh2U5RW/z+banLYH9IoFK0Hwea1QmUJ6gaTnqt5fWWCANU7/2YxLmJjtAtHN3T1kBRk9OAz35BIwOko8OM6r17OqOkgykFyibneCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PSF77Uf5; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=EOYaYwk+UihroShXmru2lDzirG7g3AnPW3s/+OsmehU=;
	b=PSF77Uf5Xl6x3/wlxeAGJmzQ4WF8w60Y/gkCyBXt+Ga8U5Z+ulT0mjbnr/EIW/
	TSwH/ObGiSopA7EJG3dGlrdRLFFmH23ev6ltZrsNXPE1SWVbu6NoJLAJRTpx7guE
	U5GiX+xLVhKDp5y+HoeXWBMnYbaaPbOi5BNin3Swvsn7M=
Received: from [192.168.60.52] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCXJl65buZnZnI1Ag--.13974S2;
	Fri, 28 Mar 2025 17:41:17 +0800 (CST)
Message-ID: <3ab30a8f-0dca-42cd-a79c-2e6f660a0999@163.com>
Date: Fri, 28 Mar 2025 17:41:13 +0800
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
 <xvu4vmk5gxhf5gkftgiycm5ler3vawesgw6zirw5bhba2kqxzt@sytribs5ir6u>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <xvu4vmk5gxhf5gkftgiycm5ler3vawesgw6zirw5bhba2kqxzt@sytribs5ir6u>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PygvCgCXJl65buZnZnI1Ag--.13974S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GryrurW3Gw1xGF1fJF18Xwb_yoW3ZrbE93
	4j9F13AFyq9Fy2kr1YyrsYvFyYk3WDWw4vgayktas3Za4Fqr1aga48ZFWYvw17Ja15JrnI
	v3y0yF48uFyj9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjdgA7UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDw8eo2fmaxpo2QAAs8



On 2025/3/28 00:57, Manivannan Sadhasivam wrote:
>> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
>> index 9800b7681054..0020a892a55b 100644
>> --- a/drivers/pci/controller/Kconfig
>> +++ b/drivers/pci/controller/Kconfig
>> @@ -132,6 +132,23 @@ config PCI_HOST_GENERIC
>>   	  Say Y here if you want to support a simple generic PCI host
>>   	  controller, such as the one emulated by kvmtool.
>>   
>> +config PCI_HOST_HELPERS
>> +	bool
>> +	prompt "PCI Host Controller Helper Functions" if EXPERT
> 
> User is not required to select this Kconfig option so that his driver can build.
> Please make this symbol invisible to user and make it selected by the required
> controller drivers only.
> 

Hi Mani,

Thanks your for reply. Will change.

Best regards,
Hans


