Return-Path: <linux-pci+bounces-33428-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD1BB1B656
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 16:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0534A1890228
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 14:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCA72571D4;
	Tue,  5 Aug 2025 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BALySto9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6093275B02;
	Tue,  5 Aug 2025 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754403919; cv=none; b=WmH8pmh1Lma7+eWOaill6X/L705zUEvOc3z2YwF/PP0kggsps+Y5fh/g9g43tx7KJKszYtCNbvt3h/bA91lp4a/vDk5QWURUwlNwzOr9DYjn+dfT+TB9R8eJXa3vq8iGFMiweriYWVHwRAvPTGtgcoDtkxseR4NNkBKpTbqZrC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754403919; c=relaxed/simple;
	bh=Qlfe5AXKtXUS04DgaEuEvKiKFgMc3p0BJ8g2tTkzts4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=irVorwcUXAZdTpdu3u3+1z9JblRCdEn4s2QV2x7FrCl4juMm5qImvmKL6++70xv2GuweG7TJfx21SHSFTR4prNhMfyxlQs0u+KbAzxgnpVhcJx5n+NapwrshHq8o0mLXBrcygdmaEOuki4hLeAdOmKubtCb8XtHWcWhQIXJCSWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BALySto9; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-615c29fc31eso9022080a12.0;
        Tue, 05 Aug 2025 07:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754403916; x=1755008716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JwL5zRYEtiklaHm3SpHhcTGST02UpRtHf+IbVq5I8rg=;
        b=BALySto9F5eR1LolU4g+aeILu5adBZofcIPTJ0Z25KKDd8KuKu/BQTJUWXKeFFtHOz
         D/4uczgCQqPg7SdVStkVNQm+HPVO5RzjW8ImKzVpouilADDNaeK9ws496+ZBSkkWk6Vv
         12+Fv8YbRuk0AWVKkVaJVUqDUYfz2SQ9R1U8QNKIrXzbm7vqzK/feD5vRVl6KgAkh0BR
         2Pnm/qACe0I1jKltk347DIaheSWUS3gzbL3b2FocNNN6lzg955RYEyUAUrbGmok+7+LN
         vQ9SxUa3iFXYJ+1MqBPnpyC76gISzySFeiW8GT7TlA0+od4hxvrjCaN06KK9fIiIa3zn
         rbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754403916; x=1755008716;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JwL5zRYEtiklaHm3SpHhcTGST02UpRtHf+IbVq5I8rg=;
        b=EzJBmJ4X94K9eCI6dE5bkOskTIEf3AdVNPIsz+UznF6zFNdDkvhSVzBDuQz0wwVEik
         LHY+cSa+LmwynrUEo+2Loxoisc9hBlOTeXxlZujj4LvNBrsYQ91h4p2d1TugK9ll87KE
         ShocKhY/7RgUZL8l2TFqJLeQ0OlvckgQC6OVXKFnzsdHODE303ZDH9zXMEse+ADwFkJl
         LfzP5Qi8KaXuK1jBK/cQ3aOSVJCYADbs708AqJKOk9GfNWX4ZPS+8uF2yuUW+ZZw/D38
         moHkf6agbMK/r5c/8CgFXRemEwzBTU0rxVOtw3BPRo2BZ75dsNS6NK4smy2xuaAKdVfv
         GK2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTbTolMx8g8Y1WY0g+kNAFcv+6ecZmox78cSe9oD9rCEa5jrscYqRlyZuhwooDP/n6ybdGDBkFyVnzQNM=@vger.kernel.org, AJvYcCWmWDeQIYx5h3MtAvvR1Gifssce45IN9vJlOU4JnFIicfRJIpnTlOwCP2b62e2MklJ68+K6Ed84j9JK@vger.kernel.org
X-Gm-Message-State: AOJu0YxH3xkikOlLyn/bNwOrUUHQ41WgGnRgX9l2Ie19QCgTIPDbWSy4
	5vNMICiaG4pxl7RxcxQBzSvO8RmlqUUOvcSG0zXBlXHYznLuYMFrqmIk
X-Gm-Gg: ASbGnct5TBVANgfsgKWrH0Mi+cHu0UteF2z3dB3zn7YevWfBT6kJ0UpPB47Z8PS+Zv9
	OhB/alAXyqj5qY7+hr4D5/m601/NeyTzwr0pHMxyMGI7LcRK8F/fzcnsY82epdBPvFE1QsChRrD
	Sq63GBGZ83v4MpvpdULo5pXA/b+rVyjW+jivP5jgxWVC9JGpboTM2+GYB7OBUc4UjVxiJoP2KSG
	dEk98y5sQPqBoxO7QOlj1OU+JKcP3zhMFkhfDPxYqcg5zOHw6082gETr7pCBHJjekaFWLVorXoy
	DWsGF13GAqghcFf0OKe6gxWgr3hA+JUVvhU2DxsnG/Qv5r2QEoa9j26LhYa6XLNB0pYkZ4d/A4v
	tkqhWxXEibPCQkPYKNyiHOMSsJyLywAS5dWr5mMR7rM8HpCEJ0p91bnCvIwa+7n9tEHc/F26kEo
	AjBjExdQZiN8tfvXkNfgEwzEqWDHY8Zg==
X-Google-Smtp-Source: AGHT+IFMnbOmPOkh2KoJ9SKdrdwTiw7fxvxwn6Wm4g2NsRxJY1JwJTk04j1ewMhEnfw6wd2bNsxyuw==
X-Received: by 2002:a05:6402:1ecb:b0:615:c5a9:4caf with SMTP id 4fb4d7f45d1cf-615e6eb68f1mr12187369a12.7.1754403915795;
        Tue, 05 Aug 2025 07:25:15 -0700 (PDT)
Received: from [26.26.26.1] (ec2-52-29-20-83.eu-central-1.compute.amazonaws.com. [52.29.20.83])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f000c3sm8599838a12.4.2025.08.05.07.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 07:25:15 -0700 (PDT)
Message-ID: <1e332191-e1b0-49e9-afa9-09e76779f72f@gmail.com>
Date: Tue, 5 Aug 2025 22:25:11 +0800
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
Seems you are using arm64 platform default config item
arch/arm64/configs/defconfig:CONFIG_ACPI_APEI_PCIEAER=y
So the issue wouldn't be triggered on X86_64 with default config.


Thanks,
Ethan

> base-commit: 89748acdf226fd1a8775ff6fa2703f8412b286c8
> change-id: 20250801-aer_crash_2-b21cc2ef0d00
> 
> Best regards,
> --
> Breno Leitao <leitao@debian.org>
> 
> 


