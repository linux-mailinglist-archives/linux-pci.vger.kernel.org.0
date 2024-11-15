Return-Path: <linux-pci+bounces-16852-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 149789CDB79
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 10:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E0F2B24983
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 09:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2795518E743;
	Fri, 15 Nov 2024 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sR1Qvi1O"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728EE18CC1C;
	Fri, 15 Nov 2024 09:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731662576; cv=none; b=fX0M5puiWpSjfwoFKGH3oUjhMpJUFRPL7B6olIa2rN3dEJKLmU4MG6MZ6NWskbIxoP7RoX5o4+M7ikI76b4Qq4KpwNUpylA16kZWpSJpzph/kg9Z61p/OLUeOo4lqnGZUw1kUVQKkrxi/Rl3lNexyd1C+rrmqihUWfwDh2q6Dr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731662576; c=relaxed/simple;
	bh=HvfeLyx8bM9mz4+sEE+lLsT1rWLWP5byK/u6zORttUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QgjvDP5rzmGYp5+t+tBxNErLa5kiBWLZIN0wtxAN7bIOhVmwWTTb1HiQXlufvFdumQ1Nt9Hz765ww0qLhENL2aBqV1orzUtJQ7+VUPvI07/RWNkk92jLaWFzo1u/wWBXmIvanMDpsQOTbcZy/9NSKrz3iA6Vkf+HaZviVSw1ax4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sR1Qvi1O; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731662571; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jQVm0XiX/O8PJTXPSVm2F+Gp9S8SqG9V8Sljy7gMQ70=;
	b=sR1Qvi1OUkf8VvbSiASuP/sGhleuz7pGyoDk6R2x1IC95d/bRKHfihgKjbFU6MkWpSPamw/yPwSK2+uVt+OkooFeX0n2kHVkp71BZG+c114aY24eoSQDWyb+jurpRTKhQXicJayk1IVl7mRqTMLi1QpYeKIm+hQYnglaJ83UzyI=
Received: from 30.246.162.170(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WJTCOoc_1731662568 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 Nov 2024 17:22:50 +0800
Message-ID: <ae12f2f1-3626-4af7-b42a-b3a16e8a7a95@linux.alibaba.com>
Date: Fri, 15 Nov 2024 17:22:47 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI/AER: Report fatal errors of RCiEP and EP if
 link recoverd
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org,
 mahesh@linux.ibm.com, oohall@gmail.com,
 sathyanarayanan.kuppuswamy@linux.intel.com
References: <20241112135419.59491-1-xueshuai@linux.alibaba.com>
 <20241112135419.59491-3-xueshuai@linux.alibaba.com>
 <ZzcPMxWqtvDWh3cq@wunner.de>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <ZzcPMxWqtvDWh3cq@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/15 17:06, Lukas Wunner 写道:
> On Tue, Nov 12, 2024 at 09:54:19PM +0800, Shuai Xue wrote:
>> The AER driver has historically avoided reading the configuration space of
>> an endpoint or RCiEP that reported a fatal error, considering the link to
>> that device unreliable.
> 
> It would be good if you could mention the relevant commit here:
> 
> 9d938ea53b26 ("PCI/AER: Don't read upstream ports below fatal errors")
> 
> Thanks,
> 
> Lukas

Sure, will add it.

Thank you.
Best Regards,
Shuai

