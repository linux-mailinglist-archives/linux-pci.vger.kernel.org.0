Return-Path: <linux-pci+bounces-37493-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B62BBB5BE0
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 03:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF69B423CDD
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 01:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C01E283CBD;
	Fri,  3 Oct 2025 01:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9s4ZLbr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA2827E7F9
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 01:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759455085; cv=none; b=bAHoD7cTQtFVT2PO8r7yYsTQf+xZxIfHfFXihTEo68PIyjKqRGvvsfahFtfy9h+1GjHq2MW5eO/yvHLK80Y25xUCQGcdHDrMLuLrsbLEKxFaPuNh1fgIezR29oG4VL2N8VqOkaZcV1qg42rJlUBlKvFwH06gA9M0/5eJIj4Tj3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759455085; c=relaxed/simple;
	bh=fTJxvF8Q1DDFuWFd9dMHvorkj8j5CzQQpmgbsKK+HdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLOfeZBnWCJLfyrSQuIy+ctGYG6g6NrSONuAfFMCJvtCL2RpviIhBjzADdz1c+d4oalWMUddsNxwdwuEbjTnp0a+HZhJ8bm/NW+jmyXHqKX4bPzIiaLawRAThEugvBRUfF/diTE/dy2XtZsoUg6aFt4mNPtDD/mUN+1/k09Y2Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9s4ZLbr; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b5515eaefceso1480991a12.2
        for <linux-pci@vger.kernel.org>; Thu, 02 Oct 2025 18:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759455079; x=1760059879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o7+7D8S0qgnO3evcGbQu05YzYTgH0CTPiSZF/G7BpCA=;
        b=F9s4ZLbrvXhnsqVWEG9p3/2wja94LI0/rNFSLg0/pDYOzdhLfjfBOYlwnInMh+L0Rd
         4Rj7ViXaiO7+Dd5teL0lq0lwu1jIySJbzIuJR4BcNIdqLsmtddLIGNbI1m47HX6C5aLg
         4m39g5QeD8Y48d8al8SFzcOZzjAualbHdwlIRgmD7ytHqyZHxKjzVU3YAI73Kdosy+mI
         YmFH/mWS+hf/WdYpRIjlHu10J3nTxvFnyJ/2ZGa74/DdphrRDZw7LkzhLSLVVqrjIRyT
         XtFHaYQCUr6fDWxvuHK4zlmqAf4keSjZgmT6PKvWA8XNq1uf3j1s6vQQvF5mQ3vrLsAl
         FS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759455079; x=1760059879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7+7D8S0qgnO3evcGbQu05YzYTgH0CTPiSZF/G7BpCA=;
        b=ndgifCpFWKRQDfoKMFkuyQaNnFf96XFVraH8cjE1jakRyxmfniYVuCTsjzpAk73dFx
         ENviWdH7uH+bPWN0oxiRxK2VMcPOqKqoozKkUPGH+QDiQir58R2mHsuymizqCHStOlWZ
         aEHmSWM0WRDdQo+BbpDDM03iIhtSLRHHR9t9BR1x6F6FyzYxlUPQBZh4aOHvrfw6WXQ8
         TsMbhDmbHrqhwflQrvVXYBcHKRCUrhbjV6E+5oX+bAO/I4v9c1n1ci8yY/mNnf9RiBK9
         WrvW4urkpXuQaC0YKTlzgnDQElFCsbgMlwGC5PNM24zzgl7n/J3bwtlj3237m1WI2Sli
         fwNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD5/XAIx8BfAF9nbgaGkQHpydSUz1c7f98PFoqeeBUePN+KH1hGLYqf0WUKA7iLoO+S8v9wucsrvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbekqUzhmEsKQoVeNOyye1J779I0Y3EpWU7a0TLBlN/UI7F3WA
	B4bUOv8bttey10qD4UI9IQNR07djuAbdHBjqlYC7hvioIVJMRBoU+0fm
X-Gm-Gg: ASbGncsitzlS8mrSwdrWZ4xCHD9HFMBvY9xBElsppo2SpAqAuuUgNePQ8WptmBqRpKn
	r2xvik9/4ewqk+oSv7PAWrZEyqwlvsO3LkTJZdppG6wkEkg/OzVjir7cjQHueVpHotcyH421oYk
	NoxP/FQ+cmZrmj9rvIKtM2TVo/192hMZwZa9UbkNhwUK7QgPlrJW9JMcyeFdcBY53DVkogzqXJx
	OPDYuNWPpQ0cjvrG0LVbR36aWr1oiDrunRIMVQRpfbcLyMT1qc/5uIKI6JTT2R0hD0h1WrbD4Tn
	hoB6OD3sQ5dhLlQ6XB8hXsQEJnkVEKbQcxUYFTgbilSGdyYF19hT85qE1lmpZq3S9bzVPqrcpH/
	KZFSfkAQr63id2YzY2ULdv4LmV3fkq4+xYtlXB+1dsjDNWg==
X-Google-Smtp-Source: AGHT+IELHXAeSgLpF44rgFP/A440u1CySI4cx5rH7o2LkJMszeWxTLXjuldGapBgZiojO/WG7L/EkQ==
X-Received: by 2002:a17:902:f64a:b0:277:3488:787e with SMTP id d9443c01a7336-28e9a565773mr17058015ad.12.1759455079481;
        Thu, 02 Oct 2025 18:31:19 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-28e8d1280a1sm33681945ad.51.2025.10.02.18.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 18:31:19 -0700 (PDT)
Date: Fri, 3 Oct 2025 09:30:46 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Kenneth Crudup <kenny@panix.com>, Inochi Amaoto <inochiama@gmail.com>
Cc: tglx@linutronix.de, bhelgaas@google.com, unicorn_wang@outlook.com, 
	linux-pci@vger.kernel.org
Subject: Re: commit 54f45a30c0 ("PCI/MSI: Add startup/shutdown for per device
 domains") causing boot hangs on my laptop
Message-ID: <gtmre52no2rqbno2tkuh77a6kjd4i7hrjbmfenucduglgqv6hw@gv4idxswvyng>
References: <8a923590-5b3a-406f-a324-7bd1cf894d8f@panix.com>
 <hxyz7e6ebp3hmwyv3ivhy5kwc5skpynzl4djyylusheuv3fmqf@tmh2bygaex4r>
 <05f38588-7759-42ce-9202-2c48c29e2f23@panix.com>
 <feedlab62syxyk56uzclvrltwhaui7qgaxsynsgpfrudmpue52@vbt6zahn5kif>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <feedlab62syxyk56uzclvrltwhaui7qgaxsynsgpfrudmpue52@vbt6zahn5kif>

On Fri, Oct 03, 2025 at 09:18:03AM +0800, Inochi Amaoto wrote:
> On Thu, Oct 02, 2025 at 06:10:25PM -0700, Kenneth Crudup wrote:
> > 
> > lspci output
> > 
> > On 10/2/25 18:06, Inochi Amaoto wrote:
> > > On Thu, Oct 02, 2025 at 05:58:59PM -0700, Kenneth Crudup wrote:
> > > > 
> > > > Resending to re-add linux-pci (Vger thinks my tablet's MUA is "Spammy")
> > > > 
> > > > I'm going to figure out which line is is that's killing my NVMe IRQs.
> > > > 
> > > > FWIW, my NVMe is behind a VMD bridge(? I guess that's what it is):
> > > > 
> > > 
> > > I think so, can you do "lspci -k" for this bridge? So I can know the driver
> > > for it.
> > > 
> > > Regards,
> > > Inochi
> > > 
> > 
> > -- 
> > Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County
> > CA
> 
> [...]
> 
> > 0000:00:0e.0 RAID bus controller [0104]: Intel Corporation Volume Management Device NVMe RAID Controller [8086:467f]
> > 	Subsystem: Dell Device [1028:0af3]
> > 	Flags: bus master, fast devsel, latency 0, IOMMU group 9
> > 	Memory at 603c000000 (64-bit, non-prefetchable) [size=32M]
> > 	Memory at 72000000 (32-bit, non-prefetchable) [size=32M]
> > 	Memory at 6040100000 (64-bit, non-prefetchable) [size=1M]
> > 	Capabilities: [80] MSI-X: Enable+ Count=19 Masked-
> > 	Capabilities: [90] Express Root Complex Integrated Endpoint, IntMsgNum 0
> > 	Capabilities: [e0] Power Management version 3
> > 	Kernel driver in use: vmd
> > 	Kernel modules: vmd, ahci
> > 
> 
> I have found something interesting in this driver.
> 
> ```
> static bool vmd_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
> 				  struct irq_domain *real_parent,
> 				  struct msi_domain_info *info)
> {
> 	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
> 		return false;
> 
> 	info->chip->irq_enable		= vmd_pci_msi_enable;
> 	info->chip->irq_disable		= vmd_pci_msi_disable;
> 	return true;
> }
> ```
> 
> It seems like this driver already have a enable/disable function. It is 
> like a violation for the change of msi domain.
> I think I should change it to adapt the the domain change. I will send
> a draft diff when I finish it.
> 

```
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 1bd5bf4a6097..d87be32cbb50 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -212,6 +212,8 @@ static void vmd_pci_msi_disable(struct irq_data *data)
 
 static struct irq_chip vmd_msi_controller = {
 	.name			= "VMD-MSI",
+	.irq_enable		= vmd_pci_msi_enable,
+	.irq_disable		= vmd_pci_msi_disable,
 	.irq_compose_msi_msg	= vmd_compose_msi_msg,
 };
 
@@ -302,20 +304,10 @@ static const struct irq_domain_ops vmd_msi_domain_ops = {
 	.free		= vmd_msi_free,
 };
 
-static bool vmd_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
-				  struct irq_domain *real_parent,
-				  struct msi_domain_info *info)
-{
-	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
-		return false;
-
-	info->chip->irq_enable		= vmd_pci_msi_enable;
-	info->chip->irq_disable		= vmd_pci_msi_disable;
-	return true;
-}
-
 #define VMD_MSI_FLAGS_SUPPORTED	(MSI_GENERIC_FLAGS_MASK | MSI_FLAG_PCI_MSIX)
-#define VMD_MSI_FLAGS_REQUIRED	(MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_NO_AFFINITY)
+#define VMD_MSI_FLAGS_REQUIRED	(MSI_FLAG_USE_DEF_DOM_OPS |	\
+				 MSI_FLAG_NO_AFFINITY |		\
+				 MSI_FLAG_PCI_MSI_MASK_PARENT)
 
 static const struct msi_parent_ops vmd_msi_parent_ops = {
 	.supported_flags	= VMD_MSI_FLAGS_SUPPORTED,
@@ -323,7 +315,7 @@ static const struct msi_parent_ops vmd_msi_parent_ops = {
 	.bus_select_token	= DOMAIN_BUS_VMD_MSI,
 	.bus_select_mask	= MATCH_PCI_MSI,
 	.prefix			= "VMD-",
-	.init_dev_msi_info	= vmd_init_dev_msi_info,
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
 };
 
 static int vmd_create_irq_domain(struct vmd_dev *vmd)
```

Can you have a try on this fix?

Regards,
Inochi

