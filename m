Return-Path: <linux-pci+bounces-22580-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB96BA4855A
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 17:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 553E03A6180
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 16:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAA51B21B5;
	Thu, 27 Feb 2025 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="akOV67KC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9F51B3955
	for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674385; cv=none; b=aY9EutrXbj4sehfBKY+9PlYPwnyC13/zk2G18abw+E/+JLFCw1m7hdVw38bOMwIHkV/osjbNIqz2TMMusAViY5SRf0L0bLgZH0al5nef7BfxzFwGGFlRoTHYgNlbglA2okGmMoN24N9IK8CjN7AhNlJ8amnmXZ/JVY0vGw1rg2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674385; c=relaxed/simple;
	bh=tSvgh1gnqbBUp+pOKDxBFcFMzDCL9KkB2ZMAPDvL6t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiQwbMQxOLfVRNDDgJY9hUyKpkw0VU72tFSU6Oo8tUOk8e6atI5sDiPD4rZWI+V1Ix/64BHWMOS7HYnMJ9eZtlow5n/vK04uS1BLw5ZEOsE7cxVpCJ/2G8JhTVBqV7HISJtsWwHKBvpWCDbi/sd2SR2NQFBmsPfgwM9UhwVTjFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=akOV67KC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220e83d65e5so22472235ad.1
        for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 08:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740674384; x=1741279184; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lU6TulGrlmG4KlNsYp6ILx7vjJst+VSlmCV1XTMvdnI=;
        b=akOV67KC498bmbxXh+TmewYAFKeIfyYliAugaB81lXztzx6/8tY98G0vQVpOIUaImu
         g+gEkuw94+nwFPYrlze6GVClPda1VH9iVP749luV5mrOYLdeQZfyB2jSU6K2b1Pb1YKC
         G1uE7wvL56YE1tpSHIEPp5bdfK3zOPrubvdXBM57APGbFySkzb00CRZ8xkweJ7+etFE1
         zwzNU69ewuH2JWuh9rL3iQEzJJ+qKPvze/ONhUplzwTTKP53E362JMdO5y8q2PHW51v/
         gBCxhphDWZdz1KJYRLYQygP57LBR95sIUEgssFQC50YqwvVscJWE5wvaWUYEhLde0X2p
         qE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740674384; x=1741279184;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lU6TulGrlmG4KlNsYp6ILx7vjJst+VSlmCV1XTMvdnI=;
        b=KpFUZrRi72uP63RE9lCYWu0Pwc3Aom/8g9eB2MOem0/Io6ROvsdbNQwdyTbKH//HV5
         feeIrNhj9ok3MyX9N//nXFcU2LZ2LqmuDzPB74+y43H5KyiLXSoUVNmC26Dqzpe1WPE8
         3LjDG9GHhbRa6rhFrmfWk5rJ8KphPv+VHWJOy30stOLJn8PtCTaYNKtAkpEhyLKgt3hh
         g95HRewiAyxQG8afEyjr1t2DyjHJdPMn+JbMe370YDeqk1yg+mhgu1egwJN+Oky/JGkj
         ncWSBKuc7c4ufar4vAhD4VW/GWuW5eFEjw7JjCxl32RxLbHkv57lLJmqELb594WEK3Mo
         QRCg==
X-Forwarded-Encrypted: i=1; AJvYcCWvm9HuYuIwj6S/LYHH4NRzJLO1DxpzeBgm8lMu7rxCIAOQTp7R4s9zwNYuuIKO6tcCnvdf6v5NIyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzu0UGcS7xdwKKBTgRMsCF3P07Wyexad+TWnH3IS7yFw9Y4i+A
	w06FoZZqBMaqgq3I9Q4Xf1PnAehRIkUSoPOMT3NUC6PMBQs/592N6KB5huhqA25tz6wdaFSgHKY
	=
X-Gm-Gg: ASbGncsb53RDo0TwQ4bMrDBW9wGv2SRwcXhR19/7NSvQwUPtX0OF/bFzZ0p2sbVKibX
	/KdXtB+gW8l1iWzPkJqfrFK84tJshsM+qeb9FXha/3+6U/hUe4usOCcpHwClNh8jLKtiwSRoAQF
	H8NK+OR65gDmeLMv5/iaJI0lXhN0ZxT0DYmFyqc20hH/3GXyfeMKLKw14cX8IQR2dzi5Ew55pRh
	6p6PnVn77+Lth2X+pT1zviw1nED/2ku1xoeQjeEzA6g2PO/hjn5Z2c3JCbMT5z8+Hv6fZiIqOrF
	PXprj8/R7b5tUXThQNY62pzeuaKjXvC8LJmX
X-Google-Smtp-Source: AGHT+IGjVr6y7dk/NnaehBxWXZ5Z15rh1gbNg00OEsuqQ8qkTGeQI6wsgYKPU0Nh3/UelzRQKc/AYg==
X-Received: by 2002:a17:902:ea0b:b0:220:f91a:4650 with SMTP id d9443c01a7336-22320081109mr134100515ad.19.1740674383644;
        Thu, 27 Feb 2025 08:39:43 -0800 (PST)
Received: from thinkpad ([120.60.51.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223505293ddsm16787555ad.229.2025.02.27.08.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:39:43 -0800 (PST)
Date: Thu, 27 Feb 2025 22:09:37 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: tglx@linutronix.de, kw@linux.com, kwilczynski@kernel.org,
	bhelgaas@google.com, cassel@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq/msi: Add the address and data that show MSI/MSIX
Message-ID: <20250227163937.wv4hsucatyandde3@thinkpad>
References: <20250227162821.253020-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250227162821.253020-1-18255117159@163.com>

On Fri, Feb 28, 2025 at 12:28:21AM +0800, Hans Zhang wrote:
> Add to view the addresses and data stored in the MSI capability or the
> addresses and data stored in the MSIX vector table.
> 
> e.g.
> root@root:/sys/bus/pci/devices/<dev>/msi_irqs# ls
> 86  87  88  89
> root@root:/sys/bus/pci/devices/<dev>/msi_irqs# cat *
> msix
>  address_hi: 0x00000000
>  address_lo: 0x0e060040
>  msg_data: 0x00000000
> msix
>  address_hi: 0x00000000
>  address_lo: 0x0e060040
>  msg_data: 0x00000001
> msix
>  address_hi: 0x00000000
>  address_lo: 0x0e060040
>  msg_data: 0x00000002
> msix
>  address_hi: 0x00000000
>  address_lo: 0x0e060040
>  msg_data: 0x00000003
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  kernel/irq/msi.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index 396a067a8a56..a37a3e535fb8 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -503,8 +503,18 @@ static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
>  {
>  	/* MSI vs. MSIX is per device not per interrupt */
>  	bool is_msix = dev_is_pci(dev) ? to_pci_dev(dev)->msix_enabled : false;
> +	struct msi_desc *desc;
> +	u32 irq;
> +
> +	if (kstrtoint(attr->attr.name, 10, &irq) < 0)
> +		return 0;
>  
> -	return sysfs_emit(buf, "%s\n", is_msix ? "msix" : "msi");
> +	desc = irq_get_msi_desc(irq);
> +	return sysfs_emit(
> +		buf,
> +		"%s\n address_hi: 0x%08x\n address_lo: 0x%08x\n msg_data: 0x%08x\n",
> +		is_msix ? "msix" : "msi", desc->msg.address_hi,
> +		desc->msg.address_lo, desc->msg.data);

Sysfs is an ABI. You cannot change the semantics of an attribute.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

