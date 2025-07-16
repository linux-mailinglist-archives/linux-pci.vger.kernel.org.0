Return-Path: <linux-pci+bounces-32235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25A6B06E3E
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 08:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1D8F4A4EE3
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 06:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C65288529;
	Wed, 16 Jul 2025 06:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BfTX5mhR"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B0C1E5710;
	Wed, 16 Jul 2025 06:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752648776; cv=none; b=FNoEv/e1GvzQt+IQR/zxqoq+sN+kzQxUiIjl6nubbqx4+JeVs9ywv0W2i4Movk+PQhpey3xNpF+i3/7ZmufMWSssbld6BT+0xPtDz/l3tx+bXH55DoijcdrXXF1M1bqaBm+cqPPwWjgA+JMvpLcJKU1BjAmV1nErLtJa2BvdysM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752648776; c=relaxed/simple;
	bh=H6vCCdGW4YE+2tVt8Z2xJf4qKonwpd31Lc4SgowK3Y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iu4jqBDuMeXa2Fv4EkGBvodN6PmnhYrkF34XPO5T32707Rr/Cg/fJ1SuNV5Lthr2aztCYyBAnMr+//N1yDlMp51pL3R2jyOjMpm8zD2HKfKVo33hsyfP2Ifko3FerlFEEos8+VWRbEh9dfM98Ji3JgICGoGQUEK302pjgXR8R/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BfTX5mhR; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752648769; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Jg5+hTykA+NCNsPBG1Mp9R4UAmpqZTPj9R/aTV0n+bk=;
	b=BfTX5mhRcsyZseVIPuUFqgcZbSZwHI5b9q1ftKt91/2HayR++zo4Ap76VARigr3r2fZfJM/Y4tmo1candXSIRLWLtGTdzqi2U9YFyinNlN1E8tP4QU5tOP/jBa7dzN6/4Ioah+S3Q+oqSDdXTbvQsb/+UUqdkqiBpHHhMVur7o4=
Received: from 30.246.162.71(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wj33koc_1752648765 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Jul 2025 14:52:47 +0800
Message-ID: <8b797eb0-dead-4049-b7cc-53763759144e@linux.alibaba.com>
Date: Wed, 16 Jul 2025 14:52:45 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for hotplug
 event
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 rostedt@goodmis.org, LKML <linux-kernel@vger.kernel.org>,
 linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 helgaas@kernel.org, tony.luck@intel.com, bp@alien8.de, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
 davem@davemloft.net, anil.s.keshavamurthy@intel.com, mark.rutland@arm.com,
 peterz@infradead.org, tianruidong@linux.alibaba.com
References: <20250512013839.45960-1-xueshuai@linux.alibaba.com>
 <87b1f8c6-bd72-b1a8-40a6-bbf552552806@linux.intel.com>
 <650cd4e4-561b-4d50-9cf2-c601518c9b9f@linux.alibaba.com>
 <31693574-e8bc-9a56-bad0-6a22280c4b6b@linux.intel.com>
 <aCxdFm_BpgOTFFUv@wunner.de> <aCxxA-4HEnZ-O2W0@wunner.de>
 <9b46a12b-90e2-c1ba-9394-5caa23a5cad7@linux.intel.com>
 <aCx_aXy9MEs6XKZE@wunner.de>
 <6af283ea-bd36-44a7-949a-2ab8c80cf136@linux.alibaba.com>
 <aDsPDTVkH5kkc_Fk@wunner.de>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aDsPDTVkH5kkc_Fk@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/31 22:15, Lukas Wunner 写道:
> On Thu, May 22, 2025 at 05:50:05PM +0800, Shuai Xue wrote:
>> As @Lukas points out, link speed changes and device plug/unplug events are
>> orthogonal issues.
>>
>> Based on this thread discussion, I believe we need additional tweaking to
>> introduce a new tracepoint (perhaps named PCI_LINK_EVENT) to handle
>> link speed changes separately.
>>
>> Regarding our next steps, would it be acceptable to merge the
>> PCI_HOTPLUG_EVENT to mainline first, and then work on implementing
>> the new link event tracepoint afterward?
> 
> Yes I think so, I think this patch is ready to go in.
> 
> However I'm not part of the PCI maintainer team,
> it would have to be applied by them (barring any objections).
> 
> We're now in the merge window and it may be too late to squeeze it
> into the v6.16 pull request, but maybe it can be applied after
> the merge window has closed (in 1 week).
> 
> Thanks,
> 
> Lukas

Hi, Bjorn

Gentle ping.

Are you happy with this patch?

Thanks
Shuai

