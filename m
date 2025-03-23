Return-Path: <linux-pci+bounces-24457-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EBEA6CF21
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 13:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41B43B3190
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 12:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7122202C2A;
	Sun, 23 Mar 2025 12:21:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAAC16B3A1
	for <linux-pci@vger.kernel.org>; Sun, 23 Mar 2025 12:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742732463; cv=none; b=kAuH0othitPabzRctfmIFlICLX4vr67B9UxmDEV3CWLzUXlCv5DBLMkb97iLehlE8rPo6UOUNiMoNNt23dC8AZ9ii0/8zSC8WBXgS2ggQi+ISJWAhHeX2bn7GHVAV2PNRhrmdQpz92/7FQI6j56q47nAWsWRi24kyGzMA1F6n0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742732463; c=relaxed/simple;
	bh=0Kj5ulhLext7lP40+hN3ydrVy50dbiOgiQUC3DTj20o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9peL9QjbG64zkOHNpDStIU0xn4IVf/56fHat4xaMB/Y8ul3jZKzBCQBSIUYUenwBNRJmK5ewHXtvvWeOlwi71cJ7mQXP9FpCFtJCbF8yeC8AfYlFRgEX2J/4Q6ssLKypncGBUxiYv1wYYmsG6hY/wGcgX/lGEDxTM71QIR98Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-227aaa82fafso7443605ad.2
        for <linux-pci@vger.kernel.org>; Sun, 23 Mar 2025 05:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742732462; x=1743337262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqFyAAa68l2/H0/BNfDY/O6jxUtCbEe6n0nmqHVUXf0=;
        b=EyHpYSdcy3EN+ReZy0vjBB0IrbASs+9vh7NPppTAi1lNmsqlaNzwR5W+iW6BXEqot0
         q2MKuUg9KGe5wPdHnXVi3c2u0yA8cH0AsA5+63ObgqU9U4Vn6l7T9WvSUn8gr/U8fEoD
         lSN8Jyix7TZrhWK2CX8NJCCxq+GJXL+8K5ZjJpiRqvINls3QWj7qz1gT9FYL11huzcN9
         ylr6Vn4+TaGSMsjc3jRDhnTvPTwyet9Otwc1deV8PpSQEXrFWm1x5jIsQKfTXl2CtLtD
         QK/jyywZUUKQIwj/NQEQ02tcFzxOd07+yOPdVKdJ/F1buJ+94zaep6tS6kWuVTOp9uRS
         6gLA==
X-Forwarded-Encrypted: i=1; AJvYcCVLamdmiyBdO8KWy32Se/Rn+o/n66UI7Sjtp+glU+M4HW3lB0ruPKNl3u0kQVQqtS9S3WRhVrAzMnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr9XWN8SzX2J7D8HrrUeqqmmC01jjGiDlzBuiXV7TdL0ZA+1hl
	z4m6fP2z3zEvMC7ghESl+vYh8e+HMLcRGeYZr07KyF43TDgo/FVs
X-Gm-Gg: ASbGncurt6q6MPLe/x00URJEsfn1ADZr3ekOGwSYgXDJxky1hcE1/3TIXI/Fh6JzlB4
	J/H84Ri4gMu2kkZgS2iTCpp5w44rFXMRaNTYhjlV5+KtVC3b4M+gN7eKN7kzWgnvV6WTTWNv7e+
	9SGLvy/VZG1zsqZdv65HSAmYwPv3qoPZbl4uaRGB8PbxUJmU31r5nJfbbREAUGUTmvQk49QW1qn
	4oW54vI5lY4sp0hmzC8Awi7p/6Mv9v2wOSyAlVUBp4VbX5PRPZN4sIIjgggf54uVDzOamHNQrE4
	4LaV2yrLC7UCCvSEwg1m/ztwz43UcXAsFOjTjC1DFJibqY810HLYnks4op1Qm5ZorY+AX7SAtu7
	2bx4=
X-Google-Smtp-Source: AGHT+IHGqVjSb6eXOnMuGOCjvlXhmnFBtterHJaYSfOZlqG0zPNEuWyhKak62OnYxyAU2n2EMqmPCQ==
X-Received: by 2002:a17:903:2f47:b0:223:fdac:2e4 with SMTP id d9443c01a7336-22780c5574dmr139753185ad.1.1742732461495;
        Sun, 23 Mar 2025 05:21:01 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22781207f2fsm50420475ad.248.2025.03.23.05.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 05:21:01 -0700 (PDT)
Date: Sun, 23 Mar 2025 21:20:59 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Jon Pan-Doh <pandoh@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	linux-pci@vger.kernel.org,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v5 8/8] PCI/AER: Add sysfs attributes for log ratelimits
Message-ID: <20250323122059.GF1902347@rocinante>
References: <20250321015806.954866-1-pandoh@google.com>
 <20250321015806.954866-9-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321015806.954866-9-pandoh@google.com>

Hello,

A few small comments.

> +/*
> + * Ratelimit enable toggle
> + * 0: disabled with ratelimit.interval = 0
> + * 1: enabled with ratelimit.interval = nonzero
> + */

Move the above comment so it hugs ratelimit_log_enable_store().  Also,
perhaps "Ratelimit enable toggle:", while at it, and feel free to indent
both choices for readability.

That sad, I am not sure if we really  need to explain here how this
particular store() function works.

> +static ssize_t ratelimit_log_enable_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	bool enable = pdev->aer_report->cor_log_ratelimit.interval != 0;
> +
> +	return sysfs_emit(buf, "%d\n", enable);
> +}

Perhaps "status" or "enabled" for the variable name above.

> +static ssize_t ratelimit_log_enable_store(struct device *dev,
> +					  struct device_attribute *attr,
> +					  const char *buf, size_t count)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	bool enable;
> +	int interval;

I would love if we could add the following here:

	if (!capable(CAP_SYS_ADMIN))
		return -EPERM;

To ensure that only privileged user also sporting a proper set capabilities
can modify this attribute.

> +	if (kstrtobool(buf, &enable) < 0)
> +		return -EINVAL;
> +
> +	if (enable)
> +		interval = DEFAULT_RATELIMIT_INTERVAL;
> +	else
> +		interval = 0;
> +
> +	pdev->aer_report->cor_log_ratelimit.interval = interval;
> +	pdev->aer_report->uncor_log_ratelimit.interval = interval;
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(ratelimit_log_enable);

[...]
> +	static ssize_t							\
> +	name##_store(struct device *dev, struct device_attribute *attr,	\
> +		     const char *buf, size_t count)			\
> +{									\
> +	struct pci_dev *pdev = to_pci_dev(dev);				\
> +	int burst;							\

Same as earlier comment.  Add the following:

	if (!capable(CAP_SYS_ADMIN))
		return -EPERM;

> +	if (kstrtoint(buf, 0, &burst) < 0)				\
> +		return -EINVAL;						\
> +									\
> +	pdev->aer_report->ratelimit.burst = burst;			\
> +									\
> +	return count;							\
> +}									\
> +static DEVICE_ATTR_RW(name)

Thank you!

	Krzysztof

