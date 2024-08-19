Return-Path: <linux-pci+bounces-11808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEAA956B1C
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 14:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 123D31F21249
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 12:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251F816B741;
	Mon, 19 Aug 2024 12:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ksp9Tf2V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD1D16B3B6
	for <linux-pci@vger.kernel.org>; Mon, 19 Aug 2024 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724071490; cv=none; b=J2IE4gUC1EkFLw5cB0P3eZFRQt4d25H4OYdwF954qRg4g1blK8gAuhhEtD6nPKA/kZBJGqdUg0zKcBQPLjZhMCXVLR8FmmVDxpqWx5MkvxJy/yShqboZYzJOTQcFskfPje07UqfD1NvCTmL+cwKeGBqZ0Rf+qiEV/BrX4bhdQ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724071490; c=relaxed/simple;
	bh=BiDU3wwLWIOmkaWOsRNvboTL7E0sucZGvP82y9Nl4S8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LiepdGM0d5NrttSUvTNjWpcng+O32REUTIqVlsqH7pmbCc7itCVT66Si5EgsmJ+QH1z08IYKo50Hm/cUqIfoZCx/AT6akGM+UVHKsg4XApOpIyrZwwSFoYXzo/XtMwHbTgPFOIz+KdZpjmd0XoKWEC5DOtILu7iKUwo3U7ICv2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ksp9Tf2V; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42816ca782dso35906335e9.2
        for <linux-pci@vger.kernel.org>; Mon, 19 Aug 2024 05:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724071486; x=1724676286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ujIZQ7D6prr652aSqf+cQ2VlnvPKhxcOC5kzD8WqFg=;
        b=Ksp9Tf2VElrwnARB49IFUXIwA2GgYzCmbva4gOqLJI82gb+sOTIOfn2lBAvJyDOlKV
         EqPH8stHSHoO+sqvODdxGCZuFjEQf6kI2/9MlMVXJXiIyov/bW8FouoPParRDSusNc6I
         W8TTpmerjQlWoaDK4vVbwQzmW3cbY9wMWmoS8NOg0TfTOs2HGEqhtuTnlcdu6ns2B/JD
         AULC/iTh/+aCeAncV7lw7sPLAfqQThPc/73bRfFWP9ebeT6Ef6/WJCuMw9/6tda+8Ypn
         tF+VE84JCMfFXcXdN5O0LRidu7I1RTIqXDoct67UsG19809jfdXS54ZzCXxem45FmJZx
         oPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724071486; x=1724676286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ujIZQ7D6prr652aSqf+cQ2VlnvPKhxcOC5kzD8WqFg=;
        b=b5m7+kUNDOgC7DK1iSr19uqb/6rZxTnt1tDSKuz3uwG3tyYAKFpzpzuhvMtBJSxjhv
         JU6hookFGNs7oEO7Vghkrhyt9/P15pONLSbXElpbLMcUnehN5vwE3tNO8MXzSmU069MQ
         l2z+d0sD0ddhlEa3tn1Os012nB+zPa6KYZfPnGQd1sI8AZB55Y515pvzwgDMdyD+rwov
         n7CWvHrn+tspL9O6+j6M9E31jbwAS8aAzcvrIDRPj9JHofxC5NOAPGWm+/U3w4prg6rA
         QxmA5SldODvxbhG4holC8k3/+wE0xXIXzAC5ATKjkFqe9Slb9K3/Qf9rOecHe8xm+oYw
         APFA==
X-Gm-Message-State: AOJu0YzpkZ0Iv0RFg62+F4uYvfqMjpyD8rhbc9vqtXUdKsZjWAuuhQcQ
	V5zbhjIVfknyP5PsIpFCWuOHNg1G7piJd90GkU8VflY29c+ClMygleyS7wmfKFM=
X-Google-Smtp-Source: AGHT+IGN7yDOR+FStJwU5ChdHCHQDdg6SU7Ji6RPjXPMPRC+5H4Dd7przkQlEyB0rAj9mjP+3DGwHA==
X-Received: by 2002:a05:600c:6b0f:b0:426:5440:854a with SMTP id 5b1f17b1804b1-42aa823b802mr51921845e9.1.1724071486052;
        Mon, 19 Aug 2024 05:44:46 -0700 (PDT)
Received: from ?IPV6:2001:a61:13a3:1901:d59d:e84c:bc1b:2ae2? ([2001:a61:13a3:1901:d59d:e84c:bc1b:2ae2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed4a857bsm110688425e9.0.2024.08.19.05.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 05:44:45 -0700 (PDT)
Message-ID: <2c5dd04f-8ac0-41eb-a11d-cc48c898c8f3@suse.com>
Date: Mon, 19 Aug 2024 14:44:43 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] PCI: Decouple D3Hot and D3Cold handling for
 bridges
To: manivannan.sadhasivam@linaro.org, Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, lukas@wunner.de,
 mika.westerberg@linux.intel.com, Hsin-Yi Wang <hsinyi@chromium.org>
References: <20240802-pci-bridge-d3-v5-0-2426dd9e8e27@linaro.org>
 <20240802-pci-bridge-d3-v5-3-2426dd9e8e27@linaro.org>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20240802-pci-bridge-d3-v5-3-2426dd9e8e27@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.08.24 07:55, Manivannan Sadhasivam via B4 Relay wrote:

> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1434,7 +1434,7 @@ void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
>   	 * reason is that the bridge may have additional methods such as
>   	 * _DSW that need to be called.
>   	 */
> -	if (pci_dev->bridge_d3_allowed)
> +	if (pci_dev->bridge_d3cold_allowed && pci_dev->bridge_d3hot_allowed)

Are you sure you want to require both capabilities here?

	Regards
		Oliver


