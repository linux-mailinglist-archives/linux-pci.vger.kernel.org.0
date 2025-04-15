Return-Path: <linux-pci+bounces-25897-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F466A891E9
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 04:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9159C189737F
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 02:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40562DFA4F;
	Tue, 15 Apr 2025 02:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="S0E+rW5+"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736C117A31F
	for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2025 02:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744684559; cv=none; b=e8HzV+4J0F6eqBXwQVNicZrdEEtG8gA8kAGCaBRCiDW/yS2dWG3/4QQ82JSmHrz/wGyy+F02XcO2rMWqBHQ4F1PIyF60lyb/xWd2YdmzHz7U2S8wtXla4ZjFmzbU0tDIzVV/jnYKWFXXXIUJM4wuGMhFp1W7A+UFnhkRPFglKE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744684559; c=relaxed/simple;
	bh=ryTR1RcYewUAZky/UNu4UUQv6KO0u9MkhTjUkDjk1Tw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=escfK5cuHX/LOvcJcKvMEjUVEKEl1R9MUNBv1mmZ37Q8tE4J9m526fQkcf1lI1jjZVa/7vc766cFCZVlnnoROUFgxa45Qzy/l/v+Z3ZOQUqeRJJzCRiNVo40UhBSKWZUN6epiUAqKjA3b+1W29hQ+yM9gVpOLFyVv8CzNHvG4J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=S0E+rW5+; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744684551; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=Z1FimAkpPccILl5FAYTHB46rmwyeC8RLOfe7+nvk4RA=;
	b=S0E+rW5+aS+/VasANw4XtHln0oyvL8fBcra8FmUPB5EsJN0gzYD9aKW6LVwHvjdCD7QYEFW1H1s6h9QKPtFS4cHIS3gF37DbjfrzSAKVVjfLiXERVXorB9y2x1gGfZQ1wk7NNXFZDFLcTeEX9xAqVqzFg7DtmAqUXUZNjPoYJm8=
Received: from 30.178.82.11(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WX1OlvJ_1744684550 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Apr 2025 10:35:51 +0800
Message-ID: <9b87cc5e-076e-4f0c-9ac3-2b873b5849db@linux.alibaba.com>
Date: Tue, 15 Apr 2025 10:35:50 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] PCI/IOV: Make the display of vf_device more readble
From: Guixin Liu <kanie@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
References: <20250324131233.116341-1-kanie@linux.alibaba.com>
In-Reply-To: <20250324131233.116341-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Gently ping...

在 2025/3/24 21:12, Guixin Liu 写道:
> Add "0x" prefixes and set its print width to enhance formatting.
>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   drivers/pci/iov.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 9e4770cdd4d5..df40663c1881 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -500,7 +500,7 @@ static ssize_t sriov_vf_device_show(struct device *dev,
>   {
>   	struct pci_dev *pdev = to_pci_dev(dev);
>   
> -	return sysfs_emit(buf, "%x\n", pdev->sriov->vf_device);
> +	return sysfs_emit(buf, "0x%04x\n", pdev->sriov->vf_device);
>   }
>   
>   static ssize_t sriov_drivers_autoprobe_show(struct device *dev,

