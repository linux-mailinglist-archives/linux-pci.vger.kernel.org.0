Return-Path: <linux-pci+bounces-36081-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7678AB55EEC
	for <lists+linux-pci@lfdr.de>; Sat, 13 Sep 2025 08:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B7B07B632B
	for <lists+linux-pci@lfdr.de>; Sat, 13 Sep 2025 06:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15742E7624;
	Sat, 13 Sep 2025 06:20:45 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA3C1F03DE
	for <linux-pci@vger.kernel.org>; Sat, 13 Sep 2025 06:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757744445; cv=none; b=ApUd1vx7ROyGSahsLILM3iWCKXRCDKSQBiHPbLYdX6OgkRGf5xpbw2QxqR+5EZNfwm5rqxZzLABqNuixNDu3LgbHH1qc6jzouIqQ2LUf9FJd9IXRtnQg6b8UD1PYb5Uui/9UsyMeQ4d7to+upiTFi2NfDspFJO5LfmXugWCKeDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757744445; c=relaxed/simple;
	bh=eKqGAKGnvYVVr650P1zWrcUeP5ASxo6BtaEVJZ9ebMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Na0LVuO00LlYMbCSU8zibv+Pz6tBIikS6NrQFeH3Xlzrn471sMV2FdRyDN6ekwU9WREMxCNk+nfPNyjx4SrQQd9y/oSFS0x0lqeMbJNt/Si2gkzLUG9NODWAi+PbG+o3L6yrzZ2kR5ZcxDTm7vBs77PJUL3dxMpevQkXxmXw82I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7761b83fd01so1030319b3a.3
        for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 23:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757744443; x=1758349243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMbcUGKbGoswq7yrabTwHGQfkgjayENehQjNWLCUge0=;
        b=lVhlCNd+deACPV9NqYXzzQhhmm97OuYoH0g+0sb06VBtioePu9pPf7IOj+gPH0DQXN
         9g82iYHtLIxW8BSlsk3b61VneO7AH/FTBcTBqX9jB/uIT0KH1ebUlYuP5yiAKe9cJZkZ
         IXA3Yetgm3NDYVSb4jKy9eAq5m0D4h74PW3RAdMh3pubhqzeXjHqQki4j0YkgeVfSoZS
         +YLMk5IND+eYoFgoh0FyRg2xbNIQoHy7Tc9WlxHGeaa6rgBA4Ts8WCJwGwjYGfdeH8JS
         fp/JocdoQ1fJ/cPqwXd6gXmY0fmA+n2pVJIx6GNM4uQxxwiKDhijHTFGSMb5T/drhRdl
         i9LA==
X-Forwarded-Encrypted: i=1; AJvYcCU4kQK44xw5Us3wjCu45T4vuzJdErNSr43gvavIUOT/LZHX969R/uoKpwqcVC45rotV23sgahoep3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRZiQk41lI4tFKXzmkk2p97CAeRh/qpb8SOYSgOJkDyXiAm47M
	UitTreOLwEJBS02xuBAlWq2G6mL/QvZf8TTRXq5rp7xz81DlKLdHvGwy
X-Gm-Gg: ASbGncv8zAD+3pW58hboXSZhwg3E+CNnTk6EwuPmdXpXmRLzsID+1xhJivLXOgKm8KD
	pUUapU07xT/RndRM4kI00tGuGjaUB5kIphtEd7185WEkidPSfh2HTjp8DMT0uQMQmAwLzM5Y1qu
	MAFr9Rc2xgNDRFAAn8eJJnhxNpf+4F7jOq/eay9t62pnftHTpcskyv17CunI1ZTogFO09PJCfOv
	x56ncfMGdunSO/lCNH4riBIt/MIirhlufm/Hj9zvJrsgyIFhVkPVFvahnzGCHo9Bfz1VLRzlBxY
	GOdklT/BnEzTm375bEX2Yjyu5chlNMWTFUI684UGL3esi1cWT5SHFZiTbAb66/XnPLJkgvsJY8e
	DTBJU9XYG1GGylQfyT6CU5VRxJfHnvp6blvkszy3gKi2uuqKPAyAaa/UQ5g==
X-Google-Smtp-Source: AGHT+IFy9e7Y+/3SbtDW/asZcyygm87uuiMiZExwIokWjMs3W5ZFuROkIGjwyYGhm6DkItSwVFqgEw==
X-Received: by 2002:a05:6a00:2289:b0:772:823b:78b5 with SMTP id d2e1a72fcca58-77612091336mr6531461b3a.8.1757744443383;
        Fri, 12 Sep 2025 23:20:43 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7762088ab63sm1669689b3a.69.2025.09.12.23.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 23:20:42 -0700 (PDT)
Date: Sat, 13 Sep 2025 15:20:41 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mario Limonciello <superm1@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND PATCH v7 1/1] PCI/sysfs: Expose PCIe device serial number
Message-ID: <20250913062041.GB1992308@rocinante>
References: <20250821232239.599523-1-thepacketgeek@gmail.com>
 <20250821232239.599523-2-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821232239.599523-2-thepacketgeek@gmail.com>

Hello,

> @@ -1749,10 +1767,13 @@ static umode_t pcie_dev_attrs_are_visible(struct kobject *kobj,
>  	struct device *dev = kobj_to_dev(kobj);
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  
> -	if (pci_is_pcie(pdev))
> -		return a->mode;
> +	if (!pci_is_pcie(pdev))
> +		return 0;
>  
> -	return 0;
> +	if (a == &dev_attr_serial_number.attr && !pci_get_dsn(pdev))
> +		return 0;
> +
> +	return a->mode;

It would be fine to have this sysfs attribute present all the time, and
simply return error when the serial number is not available.  Not sure if
hiding it adds a lot of value.  This is how some of the existing attributes
currently behave.

But it does add extra code to pcie_dev_attrs_are_visible() where it is now
a special case, somewhat.

Thank you,

	Krzysztof

