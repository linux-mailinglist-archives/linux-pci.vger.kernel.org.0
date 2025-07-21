Return-Path: <linux-pci+bounces-32683-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1108B0CC3F
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 23:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3FB4E7A1D
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 21:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECF923B633;
	Mon, 21 Jul 2025 21:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YRAByUK5"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF681A29A;
	Mon, 21 Jul 2025 21:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753132104; cv=none; b=qnFhncO/3eRljbL0uTpv0CMLnN85IgP/dzgWcIcY1LHZXVE5KVodXXkikOD4+Id4sBbSmWlVpNyZg665UiF1CnZGQQR5ShZNqor2xSxvGYf/PWuoHB+DZen2ldpqPhVjyZxkiQr/us3/L1IZV1+glodyBbyyFEny0RgYM3TSxQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753132104; c=relaxed/simple;
	bh=cx0ZLR2WkCjyCv4XZmCX+AVxImfTljAFnzEbN5w79K4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VDYJQ3FJkns424xjbK+cDXZ0o9hNuEtj2mv3dS8WWsSZ+1fDo9CrE6vFmtC2NsvLGVylZVfKf7g4UFWdNcyxdefXxuzy1AbciPTadMQ3/xojI4kohO701I2i7K84srAgbVykkTaeqjez6zxN8ErD1vm3eZdbQW6Ug/nDSrdTfL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YRAByUK5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=3skz3oQGct9D8hSBWjyD5vwW1y3JSAJVDDiw5JuCn9E=; b=YRAByUK553qpivF8yxfspyWjYE
	px2OTkjrE2esDFOJTZcBInVAVHSvnuAgDngc1HFTs0G3Akjg1I3LPAa4rfAbOW/QOiqZcFUMHikfI
	LxfT7IoyClSg9VszTFAOpXn+SdsYMnmSCpVb2MFiI7jib5uW6cAr7ngaHfcfTUhxoy7uR0xT7vleM
	IP05mQqQGnnlAbOBsOo7ChL4LXotMD/TIl+LuZC1DBxGwTStjjIVMG59EOMqcfazH6A3pyhlcQ1+y
	JBLQ6ejZDS4Ho7Hzu1+QEfHOYR4owmAUOFCNpomQvmSMupQIU/OquPNNfXeelxTggV/S4UgvRFwk2
	1elXZ4/g==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udxkE-00000000hS0-30p0;
	Mon, 21 Jul 2025 21:08:22 +0000
Message-ID: <8cecb2ac-9268-4294-b10d-35107479e675@infradead.org>
Date: Mon, 21 Jul 2025 14:08:22 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/sysfs: hide boot_display definition when VIDEO=n
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20250721210248.267962-1-rdunlap@infradead.org>
 <639fffd3-a251-4454-94a4-602fdaf481ae@amd.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <639fffd3-a251-4454-94a4-602fdaf481ae@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mario,

On 7/21/25 2:05 PM, Limonciello, Mario wrote:
> On 7/21/25 4:02 PM, Randy Dunlap wrote:
>> When CONFIG_VIDEO is not set, defining the 'boot_display' attribute
>> causes build errors/warnings, so hide the declaration as is done with
>> other code that uses this variable. Bracket unused code inside
>> #ifdef CONFIG_VIDEO/#endif to prevent other build warnings/errors.
>>
>> include/linux/device.h:199:33: warning: 'dev_attr_boot_display' defined but not used [-Wunused-variable]
>>    199 |         struct device_attribute dev_attr_##_name = __ATTR_RO(_name)
>> drivers/pci/pci-sysfs.c:688:8: note: in expansion of macro 'DEVICE_ATTR_RO'
>>    688 | static DEVICE_ATTR_RO(boot_display);
>>
>> drivers/pci/pci-sysfs.c:683:16: warning: ‘boot_display_show’ defined but not used [-Wunused-function]
>>    683 | static ssize_t boot_display_show(struct device *dev,
>>        |                ^~~~~~~~~~~~~~~~~
>>
>> Fixes: c4f2dc1e5293c ("PCI: Add a new 'boot_display' attribute")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Hi Randy,
> 
> Thanks for the patch.  Stephen raised this last week too and it's 
> brought up some other interesting topics as part of fixing it.
> 
> I have two other approaches on the mailing list right now waiting for 
> review.
> 
> 1) Make a static sysfs file.
> https://lore.kernel.org/linux-pci/20250721023818.2410062-1-superm1@kernel.org/T/#u
> 
> 2) Move out of PCI into DRM.
> https://lore.kernel.org/linux-pci/20250721185726.1264909-1-superm1@kernel.org/T/#me4356b3a172cbdafe83393bedce10f17a86e0da7

Yes, I found the second one just after I sent the patch.
Anyway, my patch is not relevant now.

Thanks.

-- 
~Randy


