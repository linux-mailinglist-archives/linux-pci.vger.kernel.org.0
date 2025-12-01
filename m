Return-Path: <linux-pci+bounces-42363-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC65BC974B2
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 13:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8B0EC34460F
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 12:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0598F30BB95;
	Mon,  1 Dec 2025 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XvWvQ6DF"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583572556E
	for <linux-pci@vger.kernel.org>; Mon,  1 Dec 2025 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764592308; cv=none; b=KGoh9OZRPMKtd/U1aDHnGXHWM4j24smTLv8Crm+fA0ziLClKwgkMn5dzP1mbLlUpUF6kLxlcK9CiJ7v4m+Es3A7USTDEiIGbZnBj9Qu4VJr151d4FeLn/ngfG1BkpF2EtnRYgdQ0v6XcKoLM9NUN4B++wig5jq/5N2dyKC3avME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764592308; c=relaxed/simple;
	bh=lzIyxrF0/MyivCTK14yPOg4t/6lOlvHKtIeXdj/IC9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jewtPROlMfMrPQPRFsMJI8uyMJeHXXdivGHFVW+07vU41cYUB0NEFE/J87eDDS2aVq+o0IoLsXUrHYNKd40ukIAYfzRmbLHknxPkO3YcLW45dKa757BwWSPVQyp1+uA/8W72HqVbgWJjp/UTzUWr/JHHdMhvl3k3rZxdhwYVjh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XvWvQ6DF; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764592295; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lzIyxrF0/MyivCTK14yPOg4t/6lOlvHKtIeXdj/IC9I=;
	b=XvWvQ6DFpu3No7K+EAiEeSQTZFaROORjP6acHZMZ9M+bSbNNGBqw/Aa4QW3aTQmxnfkUNqoggOazfYdhiWGhY7tpHITEbt4D5UHIfio63aSXD9jnI3jQrhvp8DdUcE/5y9sWPIeiFAYhR9pvYSH8XFxp3ez5AmvYMnABzLCugis=
Received: from 30.221.129.232(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0WtrNtcS_1764592285 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 01 Dec 2025 20:31:35 +0800
Message-ID: <907ca8a3-b0ac-41d0-b28a-d5e786e2cbf6@linux.alibaba.com>
Date: Mon, 1 Dec 2025 20:31:24 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Fix PCIe SBR dev/link wait error
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 alikernel-developer@linux.alibaba.com
References: <2e3a1e6b-40ae-3878-e237-fb9032796af8@linux.intel.com>
 <20251130051735.3123755-1-guanghuifeng@linux.alibaba.com>
 <1086aed0-584b-4ab3-1b84-687e53ddddf9@linux.intel.com>
From: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <1086aed0-584b-4ab3-1b84-687e53ddddf9@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/12/1 17:24, Ilpo Järvinen 写道:
> On Sun, 30 Nov 2025, Guanghui Feng wrote:
>
>> When executing a PCIe secondary bus reset, all downstream switches and
>> endpoints will generate reset events. Simultaneously, all PCIe links
>> will undergo retraining, and each link will independently re-execute the
>> LTSSM state machine training. Therefore, after executing the SBR, it is
>> necessary to wait for all downstream links and devices to complete
>> recovery. Otherwise, after the SBR returns, accessing devices with some
>> links or endpoints not yet fully recovered may result in driver errors,
>> or even trigger device offline issues.
>>
>> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
>> Reviewed-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
> The review comment I gave to v2 still stands to this v3 as well.
>
> Please don't send new versions too rapidly but give people time to comment
> on the previous version. And please remember to explain what you changed
> in each version (below the -- line).

Thanks.

Compared to v2, patch v3 only modifies the implementation of

pci_bridge_wait_for_secondary_bus.

Patch v2 directly used a longer msleep timer, while v3 modifies

it to use a sequentially amplified msleep timer, allowing for more

timely detection of switch, link, and device recovery completion,

thus reducing the overall SBR waiting time.



