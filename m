Return-Path: <linux-pci+bounces-9883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C358929524
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 21:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 553C028207A
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 19:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4D31C6A7;
	Sat,  6 Jul 2024 19:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="VkjvcB/8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4116E57D;
	Sat,  6 Jul 2024 19:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720295322; cv=none; b=bXMscXeCLCY8izToxJDbzqGFKQgyeqIia/Z+212ATYTwQDli9kxuFBJFDeASmWNL7/pDuVKD4x3KmO/HqOJvYO+QM2OCmCaGsovv1jztOMtkXhUMWtFCq6rE7BjescpgZ/s9Y4HQgb4HZ1QlJ3vLsRnNwAfQ2qK/Jell3ibHUsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720295322; c=relaxed/simple;
	bh=ZJ3kjsRtnV+Z9M5mT8xD6eZ2Kf5uiU2EvhO5/CmjxiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kODjE+1bhXoRhOSNSitflRUDPdztLtPAWx/sbf7djwTBMU/9CwB6FigdEwycAWeUk7j4CNPHk538zuSWeBINw80pMlo2Vhi2rYS7inrPmhvrr6hEMn/M0rDq5fJKcSqWDY6nkBQ2h3zBSs18N0ZGpfyu9528OHuh6ointo52o2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=VkjvcB/8; arc=none smtp.client-ip=80.12.242.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id QBNMsmBHHK26NQBNMsyAUD; Sat, 06 Jul 2024 21:47:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1720295245;
	bh=BUVn5fYLcYqSz64cCRRxVo01KmZD7kSc3CeEKO1G28g=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=VkjvcB/8hjjcrrVBRSVM5SVLt8wXF+1lbyANR4V8RR4BG0dAiGHatj8jLKsJn4Mjc
	 wy07COTz0T10wyE9o4yNOBsd7/KELjjZRWBacibOdllCP1DqLzHUngIXlunoHq5tFV
	 RFsfIctuP+OFvthnDRy4hjmRy4y+Aro+p6tnN421C4P1qKaccwzyrOutzeSTVBqoup
	 oFhYcariA1peKAryCH61tL5X5O1aXx1ENpRc76ua2We0ohuWiPphUDtzPHuFpiKNg5
	 PKIE3Ae9NkUuuPhrJZmW5RN72spLh5tuhKZCm95T+2vVh/hkGFBCyvyd5b+56dbvX3
	 NrUEa+OzL5rSA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 06 Jul 2024 21:47:25 +0200
X-ME-IP: 86.243.222.230
Message-ID: <d42b25da-44d9-465f-b651-134c2179981b@wanadoo.fr>
Date: Sat, 6 Jul 2024 21:47:14 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: kirin: use dev_err_probe() in probe error paths
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Xiaowei Song <songxiaowei@hisilicon.com>,
 Binghui Wang <wangbinghui@hisilicon.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@Huawei.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240706-pcie-kirin-dev_err_probe-v1-0-56df797fb8ee@gmail.com>
 <20240706-pcie-kirin-dev_err_probe-v1-1-56df797fb8ee@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240706-pcie-kirin-dev_err_probe-v1-1-56df797fb8ee@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 06/07/2024 à 17:07, Javier Carrasco a écrit :
> dev_err_probe() is used in some probe error paths, yet the
> "dev_err() + return" pattern is used in some others.
> 
> Use dev_err_probe() in all error paths with that construction.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---

...

> -			if (ret < 0) {
> -				dev_err(dev, "failed to parse devfn: %d\n", ret);
> -				return ret;
> -			}
> +			if (ret < 0)
> +				return dev_err_probe(dev, ret,
> +						     "failed to parse devfn: %d\n", ret);

Hi,

with dev_err_probe(), there is no more need to add 'ret' explicitly in 
the message.

CJ

