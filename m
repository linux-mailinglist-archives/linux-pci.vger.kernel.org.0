Return-Path: <linux-pci+bounces-24923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B333A746CB
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 11:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DBF816F6B2
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 10:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F42021423B;
	Fri, 28 Mar 2025 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gRjdAwiz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667C021773D
	for <linux-pci@vger.kernel.org>; Fri, 28 Mar 2025 10:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743156019; cv=none; b=TWlFh5nDvG9UDbt8gemKgsQLbdRfHns0mk+Ol6pB3LzADo91+ySYJ193T1pQDQoNBa2cLdFH8v0ww/Kd+AVQQG6zQt0tWvs0zUnNTTbYFeG4sJaVhjznZthnuKmg7oWuozrd/Rujp6ciViIXmTXbG6+tvLXMi6xYYODyW+53Vrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743156019; c=relaxed/simple;
	bh=VAxMnppZDd0EsjFlPAHPDvkheirt5PDlBP3XZemzIlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOjhDIRwGuyy/4MxqR7FOF4qikl+75pV3T1g2/bMZqY8uCA60LxCW/uN2//J09Zatg5uYfLbWJ9c+CYjus4kOPP5jaUugMadWgx59ZiGtA2XIogsue9Ma7ITaD2iJmbpZk1YQfFiqjy3SsFFWD/NA1OFA7n29V97tO8rVdVHdNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gRjdAwiz; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39bf44be22fso839009f8f.0
        for <linux-pci@vger.kernel.org>; Fri, 28 Mar 2025 03:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743156016; x=1743760816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uMHy4UXVXze7CguX+fTXXYQovkguTPZAbEfyyQdz7+s=;
        b=gRjdAwizbI2GB3mpJ0tuxllHhWl0gs/tAULTfZ2mfewHdZpDlIOeDma/iytqf1UzxN
         ocf+uk72V3eRFg4BWf5h9pgVtsojIXJMWaueALkbX53tK3GmFoW6C27xzQSrVGUSkQ3c
         NdU9FgGqxpTr8LluBHUXTwl6+jIuGlzWW+wB3vW1VHrQU2EhReQhMYiGigPb8Sx9itqp
         bq4jidTcD/JdMVKxBEiGUsmDFn1yFsAo3mooRgLvXEoM2niY+RO8KYvdnpvV5lpnNGGT
         KgkJGYqa+sZjGKKH/y+BUhty9ueYFPUr23INntKMp0GkHj0x+7rZ8RKoQ9SgSVKVuDaW
         sdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743156016; x=1743760816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMHy4UXVXze7CguX+fTXXYQovkguTPZAbEfyyQdz7+s=;
        b=tbuGTqy8CH8nuZPEtVH8BvkO7OiVeZnADU9hm5/2pihTE7zf0hG5rDr9L1gXGCcall
         rpR75ExDVEB/oQ0XdEWa/3JPE1JmeJyWUSYzpojWV6/Hbxt911SJejzG8oaxvDUs6zi0
         fUGqmOX9Fjhh0B8rEHo6F3OpEAKCHaIamQZJ62OafmJDR5ANoHHOrPebqzineJiPGccn
         Gf4xo/fze8p04AX6+g1fXe9IboLGRrnkRDHg3NIiUcH757u4TfxBGltwE4WfryiXN2Uf
         ZHsDzoX+cAwzSiItCtSDkaOUvbeCAh0iJlVw1Ol+gqnZw6Rz9O3VlKQ2hrA9xhXmdcex
         PfIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeFiIaBu+4ejcZ0kTK2SCOaVpEkigCYkiRkaR7SQv9DDI2KsPeSy5zuYBKz9q/zP83/CXEEHPF0xA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlT2w4FAckK9LefohPNKFCeGsr19PWwwMAT5uhzQhXfU7EEOk2
	ZkylOFkku7kaubHzxhFavwPzW+xtvMtLyl11sa6E7wQ+noFEnj9q7bX3IeNdC4A=
X-Gm-Gg: ASbGncv6osuQJTpAWy7HD3RVWY8pdPSEMMYGQrYapymJxel3xDp5Kpb1bW2LDh+qFQG
	dNmnG2Wixs2KipfByLWzzNkWTq1Uh7TT6oOSi/AgIaITZG7w/DoGSA1JHG+8PI2sAfWLkEL3IfD
	ebk7fiCUq5TwY67S1N6HBBB8sK9rqW4nWs9BRbup0vrUtBTAyAV7vm0Z4wMkIDChW6DKqriJYgB
	+PFeZxuh4kwONks9wAl9c6UQB+1Svyml09mx7+HcOZoY65wPx3Xr1EUIO/A0NV6DH2at4xKUfvk
	oDWaPlf+qbDBHdxXM1wRgaxJqqDG7J6Jer6kT8Vn+SSrGmJMf84BFiMAdzlK
X-Google-Smtp-Source: AGHT+IGj9pQvphUGd9QRvl74y+vh1brVfy4aIv4DoMY75sWkzHFUx8Bt1I9v28FP8We3YasMPehrOQ==
X-Received: by 2002:a05:6000:1fa9:b0:399:71d4:b8 with SMTP id ffacd0b85a97d-39ad17505efmr6306834f8f.23.1743156015550;
        Fri, 28 Mar 2025 03:00:15 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d8fccfe2fsm22243795e9.22.2025.03.28.03.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 03:00:15 -0700 (PDT)
Date: Fri, 28 Mar 2025 13:00:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Nishanth Menon <nm@ti.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dhruva Gole <d-gole@ti.com>, Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Dave Jiang <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>,
	Allen Hubbe <allenbh@gmail.com>, ntb@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	linux-hyperv@vger.kernel.org, Wei Huang <wei.huang2@amd.com>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>
Subject: Re: [patch V2 09/10] scsi: ufs: qcom: Remove the MSI descriptor abuse
Message-ID: <f0df759f-42b2-450c-90c6-25953093e244@stanley.mountain>
References: <20250313130212.450198939@linutronix.de>
 <20250313130321.963504017@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313130321.963504017@linutronix.de>

On Thu, Mar 13, 2025 at 02:03:51PM +0100, Thomas Gleixner wrote:
> @@ -1799,8 +1803,7 @@ static irqreturn_t ufs_qcom_mcq_esi_hand
>  static int ufs_qcom_config_esi(struct ufs_hba *hba)
>  {
>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> -	struct msi_desc *desc;
> -	struct msi_desc *failed_desc = NULL;
> +	struct ufs_qcom_irq *qi;
>  	int nr_irqs, ret;
>  
>  	if (host->esi_enabled)
> @@ -1811,47 +1814,47 @@ static int ufs_qcom_config_esi(struct uf
>  	 * 2. Poll queues do not need ESI.
>  	 */
>  	nr_irqs = hba->nr_hw_queues - hba->nr_queues[HCTX_TYPE_POLL];
> +	qi = devm_kcalloc(hba->dev, nr_irqs, sizeof(*qi), GFP_KERNEL);
> +	if (qi)

This NULL check is reversed.  Missing !.

regards,
dan carpenter

> +		return -ENOMEM;
> +
>  	ret = platform_device_msi_init_and_alloc_irqs(hba->dev, nr_irqs,
>  						      ufs_qcom_write_msi_msg);


