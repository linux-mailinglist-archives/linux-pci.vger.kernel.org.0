Return-Path: <linux-pci+bounces-22730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E53A4B701
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 04:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5FC5188D028
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 03:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BEA3D69;
	Mon,  3 Mar 2025 03:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lqVjtRmv"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309EE2AE89;
	Mon,  3 Mar 2025 03:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740973728; cv=none; b=iYoTbiqzfJ7GeyKpOeibQN3UIbJcdeaW/wO0kogpAEeDzyOiiMu1K/Ky3eyxeRZnkIQMgncKxlgqBbomRYnG+s4+dyVZMLUnFQGZddI+/p9UtciVLDz4/xIPeJQskSq8Upwa28e9RX3m+xL6O4fUWpAPXPVm9qtIo2GkzwFDw1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740973728; c=relaxed/simple;
	bh=Kp3f4Rrh+mCGf3WTQfEQsAhjfpEFAQS5wZ0q+lCYepg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IK9ZLWh9Cfrr7yV1ujdUD+rhL+9jY3n7TXYPrCGq1WB1hR3eMZtxumwCSObRdws3Hk81Y2lgCBTltzRN7FI4sQyGSSS6sklb3I7J4tOVwbc6hGOdhDMwrFatglz7mc8UTTozjPBlYvUxiHWkrP2B/yFn14Fu+Q5BNdhnoHuquSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lqVjtRmv; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740973716; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=x6zF8fFARCSUTdMgI1FTCddqWiaaLjFTVKmfeG7gs9E=;
	b=lqVjtRmvoSYvY5ICSMioT8aOEX7NzlGZQsnfFS3tdzxF4MpkkmpC115DucBkZJg69c1Q+LTkKp7EhYShx9WLplWYO1Nds0FmUeftsiPOuhqtRSp55vyjPX3bTJ1L81hJuYUJdqte6zFkzCry1YyLzTLXhOLZGt/KNTPjQB0BNS8=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQY07TD_1740973714 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 03 Mar 2025 11:48:35 +0800
Message-ID: <24c07fb8-8a85-42fb-87fe-9f5dbd53eea3@linux.alibaba.com>
Date: Mon, 3 Mar 2025 11:48:34 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] PCI/DPC: Run recovery on device that detected the
 error
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org
Cc: mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
 terry.bowman@amd.com, tianruidong@linux.alibaba.com
References: <20250217024218.1681-1-xueshuai@linux.alibaba.com>
 <20250217024218.1681-3-xueshuai@linux.alibaba.com>
 <8bb49ca2-6b27-4b05-9ad7-ed10cfa841d5@linux.intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <8bb49ca2-6b27-4b05-9ad7-ed10cfa841d5@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/3 11:36, Sathyanarayanan Kuppuswamy 写道:
> 
> On 2/16/25 6:42 PM, Shuai Xue wrote:
>> The current implementation of pcie_do_recovery() assumes that the
>> recovery process is executed on the device that detected the error.
>> However, the DPC driver currently passes the error port that experienced
>> the DPC event to pcie_do_recovery().
>>
>> Use the SOURCE ID register to correctly identify the device that
>> detected the error. When passing the error device, the
>> pcie_do_recovery() will find the upstream bridge and walk bridges
>> potentially AER affected. And subsequent patches will be able to
>> accurately access AER status of the error device.
>>
>> Should not observe any functional changes.
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
> 
> Looks good to me
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 

Thanks.
Shuai

