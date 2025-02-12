Return-Path: <linux-pci+bounces-21268-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA7EA31C46
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 03:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684283A8186
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 02:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FE51D515A;
	Wed, 12 Feb 2025 02:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FkMKKbkc"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8D1154426;
	Wed, 12 Feb 2025 02:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739328475; cv=none; b=LCuPU/VPrZJtU/wOvNBUlcJH/gwEYKthw21JJ7QbbpNwjH+vhqAL9gWWgHjkO0JEsp5U60c/z7gkNKbkdu1Pkdk9lKKzjr73HHUZC41M3ZEBtYBJR33nMH9l2njBG0IHSUrhr/hC9ccxaD7/eDWwDFFJ+eJzE+IGNQ06mIzyjfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739328475; c=relaxed/simple;
	bh=JxW37do/Q1NHEtgvS+i0M7r7gl2xFOflp1iJUDTW0VA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aaZ0Zx8G63Z5FQDeAC12PqQEnot5xP9RNFbit0FAVYyboMtgXms4UIvEcmjev5e3slSKFNNAn8O5bFxquY2GUCp4vu8cAI26SLh7rro/xPT4WGodem8SP4/zcYUnANJtqiRsA7yPf9RujikZ3Iz67GUKgjioBzEpOIc635TkcqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FkMKKbkc; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739328469; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8n/C4hqIHv1YHRAmzi0gJ/oE8TghePZSYBhBlvYwJL4=;
	b=FkMKKbkceJf/0IloBbBSXySCnuz1FauE54flDU900Jo4946ABaWoXviSWXHMr+Gi2Jg8hjKbHQI74LodWE324ppuiFAcA3eblPOX2DJB9miwVyjLqsAfFegpJm3LLq+wz7Xto415WcGWYRyp5AJKCDgePQeVb/C0OeZmIMNunAI=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPIHpDm_1739328468 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Feb 2025 10:47:48 +0800
Message-ID: <5452e267-4c96-4fe5-99f7-44610b4a8b85@linux.alibaba.com>
Date: Wed, 12 Feb 2025 10:47:47 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] PCI/DPC: Rename pdev to err_port for dpc_handler
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org
Cc: mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
 terry.bowman@amd.com
References: <20250207093500.70885-1-xueshuai@linux.alibaba.com>
 <20250207093500.70885-2-xueshuai@linux.alibaba.com>
 <f4d2579c-97ab-41d7-a496-7c711243517f@linux.intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <f4d2579c-97ab-41d7-a496-7c711243517f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/12 05:17, Sathyanarayanan Kuppuswamy 写道:
> 
> On 2/7/25 1:34 AM, Shuai Xue wrote:
>> The irq handler is registered for error port which recevie DPC
>> interrupt. Rename pdev to err_port.
>>
>> No functional changes.
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
> 
> I think you can combine patch 1 & 2 into a single patch. Change wise, it looks
> fine to me.
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Will do in next version.

Thanks.
Shuai




