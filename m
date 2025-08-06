Return-Path: <linux-pci+bounces-33450-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B002B1BE80
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 03:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 175237B06C6
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 01:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E5A1922C0;
	Wed,  6 Aug 2025 01:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPUJx5rA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A52218871F;
	Wed,  6 Aug 2025 01:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754445311; cv=none; b=Q8wlMp+Ify/n4CbvIQE8nZwjrAZuMrFu6KBmHih/NhvompMljcO8LMGjRqSfUJm3/SJFiGbYvNmDNae49wgZNkBAOs3FTjH1eURLGv/CHjIklM9vAJI+X+rispBNwG8S7S3N1fTt4G80ZiOz8QEJmakfwfTo/2rb73q+4CnduD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754445311; c=relaxed/simple;
	bh=q5ByKzQynwkhLQXkGHWWF678LQ0VDVFdELvCTD8hz58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EqIavrQL3FOYITQ2boUWHOrB9u/JrZNQsJhw9D8S1MJT5zCjYkabUTcVecZAAXnZftSCOIxmCBjrvxZ1Y8uBszUzV3Z0GfcOofkiLwbKyoUUsHVP9WvrbAMz1pRwDVDTO/fqwwGwJKi7KL3wI/J3WeUtSfoRPD3lxZ9THVxLZlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPUJx5rA; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-6152faff57eso10671437a12.1;
        Tue, 05 Aug 2025 18:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754445308; x=1755050108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SwUvDCDGNTjgSGRxvkjU5V1Z70GTc/BlM8QTHRxaQ9I=;
        b=hPUJx5rASUsMxL3kKa/JTj6X8O1KXES5kUIEHULI+siYQXi9h9Tsop75MURCduuuNp
         Hk2hmmJeudx7XL1RdE6igKWF4NUOe2HpoYFuNL9Dt9afmzf9Hq6F0b8YtEh10QtwuMbq
         vyaz07Npoclw9i9vhA6wi/F2vUMwrZCZVe9+CAUFm/hOGjXHXRNNpV6CGhUCpjS6rUll
         Gx8cOcJaKGAAmMtIuc2Wb6yQTWeTGcS2QgoH8A9mzSI34eFx2moKxraWm3VUZsypZK0/
         KZfdcIsqRSLtEXSQPnm1CUkt+akmYLP9dKycIQF5a7J2x/euuTv9o/nG5/zljkztmV0g
         UQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754445308; x=1755050108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SwUvDCDGNTjgSGRxvkjU5V1Z70GTc/BlM8QTHRxaQ9I=;
        b=xLwbmmIsfZcGCr3fsn/LKVue1Sez/cOUj/TvjmBD7Uk/ROKSGbnYfh+LPakAvY8L+6
         b0ZKZ8ffTC/+BfMwJMEFCRobM9KIan1VexKNN4VLwKNmgHl2MQamb2vzaht1DjpGqPX9
         FuASL//11WCQHPlFt5Q5Xi6C5G2FcusHcVP5ThTW8zYs3NP+94ZHKg8muPfOmp0dUlG6
         MSmpC4wAVjx4+jJQ3AFy7YfnEpEzJlmdL2nY2BbLcn57btT/Bm8NVuKYtZZGJMMHhSF5
         B7nWrgx4k9p5iwY9/O8uBRpnXswOYo5HfB1a4kPX2K8vLcIpY+YdRoSbrKbSBpKEYCSl
         3Hhw==
X-Forwarded-Encrypted: i=1; AJvYcCWUbmTIfY57HXySH89eHPjMdVOmnQsPGSrWqBNq2emKd4DJRUUZ/ONohsPfFRsFcCUTBMrTNCdTFXYL@vger.kernel.org, AJvYcCWsUD9Yklhs8dKabSzQ7kGqsNwCbLxvtfk43VTey99YP97VYFrB7IhteTaQ0ZdXJ4mgw5gLHQ3ohh7tU/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx9eEWLkFk5Ttb0/SnAxYu+nvmVj26iT9v9BIjPXcxHaWJ3gdP
	eD5i1Wj5dVyBGL96ZBgQ675ZU8jmfZzA5S/UokrhVKul3dN+ZWSDZ5Gl
X-Gm-Gg: ASbGncuPTiRnA2G7J16Z0AZ7iRycvKNoMP6qIfQ6CMCkklA+2hP49fQhBjBfTTToZjj
	68wK6fndLjYWswpT3qziZm5Kdlwg5DXc+EjcQgT3tiPpKAfUcF4h3wEiZuWDCtS4M4sumD9kys7
	qkMNfkzKIt4/YshdJYuTxXfweHQ3UXq+ezBbNj5eKEw/zI++2PwId7fdYwPH4x0d3/Cm13+Gp4r
	iR0RM5P0vIyWZIppSlfyMfFrGQ6y/s4OIk1PvA1lfsp+nFiGzfedPSj7hRHuG0nqXiwD3DP8Urw
	6etMX7ee/hKu5VS1gGOBZw105CSSqi+kcOjmumrvoxgTaIx4V92rPdOBBfnx47Y7mD+6p3MPlKw
	fT8N3tf+hD73X3FLNU72MjPVwKBGPeOkP04/hQWcnp+YG8S4KQY5hVjA3nS1BVgNsVtWBhSzKWw
	gInOyzuEkq/U7PfvFGPqp7G4An74nIzQ==
X-Google-Smtp-Source: AGHT+IGHGjRRe6J/8f38FMv+b/ctFpC2mzgoSfGhiIh3DMk0vlEB5YMRV5JVbv1qLNEU4LSdMZOlEQ==
X-Received: by 2002:a17:907:1c0f:b0:ae3:7022:b210 with SMTP id a640c23a62f3a-af99005e566mr101376466b.12.1754445308254;
        Tue, 05 Aug 2025 18:55:08 -0700 (PDT)
Received: from [26.26.26.1] (ec2-3-72-134-22.eu-central-1.compute.amazonaws.com. [3.72.134.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c076sm976544866b.102.2025.08.05.18.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 18:55:07 -0700 (PDT)
Message-ID: <50f6c23f-1f46-4be1-813a-c11f2db3ec4f@gmail.com>
Date: Wed, 6 Aug 2025 09:55:05 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/AER: Check for NULL aer_info before ratelimiting in
 pci_print_aer()
To: Breno Leitao <leitao@debian.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Jon Pan-Doh <pandoh@google.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20250804-aer_crash_2-v1-1-fd06562c18a4@debian.org>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <20250804-aer_crash_2-v1-1-fd06562c18a4@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/4/2025 5:17 PM, Breno Leitao wrote:
> Similarly to pci_dev_aer_stats_incr(), pci_print_aer() may be called
> when dev->aer_info is NULL. Add a NULL check before proceeding to avoid
> calling aer_ratelimit() with a NULL aer_info pointer, returning 1, which
> does not rate limit, given this is fatal.
> 
> This prevents a kernel crash triggered by dereferencing a NULL pointer
> in aer_ratelimit(), ensuring safer handling of PCI devices that lack
> AER info. This change aligns pci_print_aer() with pci_dev_aer_stats_incr()
> which already performs this NULL check.
> 
The enqueue side has lock to protect the ring, but the dequeue side no 
lock held.

The kfifo_get in
static void aer_recover_work_func(struct work_struct *work)
{
...
while (kfifo_get(&aer_recover_ring, &entry)) {
...
}
should be replaced by
kfifo_out_spinlocked()

as
static void aer_recover_work_func(struct work_struct *work)
{
...
while (kfifo_out_spinlocked(&aer_recover_ring, 
&entry,1`,&aer_recover_ring_lock )) {
...
}


Thanks,
Ethan

> Signed-off-by: Breno Leitao <leitao@debian.org>
> Fixes: a57f2bfb4a5863 ("PCI/AER: Ratelimit correctable and non-fatal error logging")
> ---
>   drivers/pci/pcie/aer.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 70ac661883672..b5f96fde4dcda 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -786,6 +786,9 @@ static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
>   
>   static int aer_ratelimit(struct pci_dev *dev, unsigned int severity)
>   {
> +	if (!dev->aer_info)
> +		return 1;
> +
>   	switch (severity) {
>   	case AER_NONFATAL:
>   		return __ratelimit(&dev->aer_info->nonfatal_ratelimit);
> 
> ---
> base-commit: 89748acdf226fd1a8775ff6fa2703f8412b286c8
> change-id: 20250801-aer_crash_2-b21cc2ef0d00
> 
> Best regards,
> --
> Breno Leitao <leitao@debian.org>
> 
> 


