Return-Path: <linux-pci+bounces-37996-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 940B2BD6DED
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 02:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5551C345203
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 00:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3344207A0C;
	Tue, 14 Oct 2025 00:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngW5NAls"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7204D35979
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 00:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760400844; cv=none; b=rxP7cUDzL4x72uMyRL4r5z7Z+/5Q7pdrbTsnMV1JHTxb7AhbBOg8h5x1lt5vdkZ1yEkhm+mQsh2VZ9RIJiQ/ooeJkB8OBQ6dKZvcbcuMVlVjWePaWy3wu5DPr4mTZN/h1PDBoNV+AJ2dXHJXrJu0IaQ211cO/vr/2FnViGFC0Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760400844; c=relaxed/simple;
	bh=YR2XzL29ABdV/6G0cgpTieR0AvfACRzJPyvZXJ/o8SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpScDPhFpVXoJQDyjdGuVSt0QLbKAFGUcNOCpAxBbClQ5ZaOkXjWhDc0sYMEz9suZKo9PXPKIM6QFPHzC6YMYqutXwmYcNfKcDdRiUAdDnFkMkrMDsFlq4rYvnW1BICJp4S1Klgcfbp27dVXwuj2w/NXVkZ7NTESOjwGkw39Yn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngW5NAls; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2907ba47f71so998415ad.3
        for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 17:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760400843; x=1761005643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dLxjPN+v/L3LLQw86RQoupfX8GI9eJaSmstxsSeeCWQ=;
        b=ngW5NAlsIhILYeFUjkCWNwgxoY7xr2hxi1I7swM9qEYcePfpfbLiKatpDFlqWHE8dC
         kH8TNAlkEku0WdA+H3wMFB0G4bmumtfIX8BPz3OEBsGMrLwXQ6zHY3BEUdbmkHQKlTD5
         PJZ2rhIfKU8NtgtLvofBsGVMfKF/icfgM4FdyjFkx5UARCZqbH5ZkobRPZy/BwS7owDY
         LyAoEW6JSQaNxTEKWP3H0XjF11pGfzmKCh8C/xQUAtoAD50MiuxBd6cp2PAaZWFZYX8E
         HpoAc1igFy2lI8l/y1JIyLMB0fIu63GiS/sGCQiEkyGCyWQlL5/SLvRtnaXoP1chJEUx
         oX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760400843; x=1761005643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLxjPN+v/L3LLQw86RQoupfX8GI9eJaSmstxsSeeCWQ=;
        b=owaVaZs41uhe3i/a/WpwDQH+2OGQeagElS+diyhPLwqEysxUphD4QLc3e8Ypl6rRkL
         ewh2j8PBwSdD0Hs4CAO+o2RYM6Ni9HYu9DEOVIgCd8bGcIdU3u58NQD+73/8wEKBXYhK
         rytaDn9EC80VbQUQ2Z0m7Cy/D721DztpFFT3gByANLJsP8m6HaasVHGRSMiRPzmdfNrq
         5bB3t7Ty6ZAVLZ+Mj8ccKO2cBccfyhfvu+SP/M7sVxchjttDc0aAueb/LP8x5raGdufn
         M88oXe5spYzi5Lt+HThDwj2XPb8V0jcKPzttYnDBKgBn6WVjoabafEEZYApKiImHQx0X
         DAiA==
X-Forwarded-Encrypted: i=1; AJvYcCVk7RgHoSPcPuZkGlsSPQJGjdYVcwqqwjNd38EqB8SmUuE8NWNB1k27hrMrz56pISxjUaP7iABtO1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO8qlRsYgGlxpZ/J6t912lBZnSi8/DacYIhtqXBloSEYAm3yb/
	r36bu/eddDz2x+VO4Z5toGLGbggaa5WHZfqq3643qxj4ksnvzSHzQLUo
X-Gm-Gg: ASbGncut/Yf6mbvGR0IWLbEGRd0iMgx0hSgK/yIi0d9TVnOxBgNHndA2MzPktmtK2vL
	RcHI/UthThtZ4E0Pu0h5UmkFzdcWwZHOK6eXD8s1FrAQ31ToKu++bPcQkn22Kcx3Z0HBa8oJjO5
	1GQP0WjJirhu9bpdM0iWPL3pFKAH4UfX30PGPWbFTnWpi30Q61I/U+ro6GaEqezjgFQwmp/wlCt
	Zqq+pbP7nzyt1yDSsC1AiWzd1JSS2PfBXEiXAKbcx3k+b6gUiJmgw5whZSxDyipm29roCMe2Eaa
	gi/8ojPDTDjcGoc/dFRVEXVtYk+ItZ+VdhJZv/sMskuDqfAZBY3AW6UOCSm0OKktpyVzu6wk0nY
	hnQw2o9ItOvSs9vyVhI4rh8Mm/2GlGqejn8eBPtAWEivR185vX2Q=
X-Google-Smtp-Source: AGHT+IFyBvowbtHgj59ZzUUjwHfMbgKWclrSVn2bG7DcCfbMw7A2Cj/IW4bTfeO8CfOoglelYl8fyA==
X-Received: by 2002:a17:903:3c27:b0:262:79a:93fb with SMTP id d9443c01a7336-290272c07b4mr255281265ad.32.1760400842677;
        Mon, 13 Oct 2025 17:14:02 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29034e2062fsm145337655ad.48.2025.10.13.17.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 17:14:02 -0700 (PDT)
Date: Tue, 14 Oct 2025 08:13:17 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Kenneth Crudup <kenny@panix.com>, inochiama@gmail.com
Cc: tglx@linutronix.de, bhelgaas@google.com, unicorn_wang@outlook.com, 
	linux-pci@vger.kernel.org
Subject: Re: commit 54f45a30c0 ("PCI/MSI: Add startup/shutdown for per device
 domains") causing boot hangs on my laptop
Message-ID: <2hyxqqdootjw5yepbimacuuapfsf26c5mmu5w2jsdmamxvsjdq@gnibocldkuz5>
References: <af5f1790-c3b3-4f43-97d5-759d43e09c7b@panix.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af5f1790-c3b3-4f43-97d5-759d43e09c7b@panix.com>

On Thu, Oct 02, 2025 at 10:04:17AM -0700, Kenneth Crudup wrote:
> 
> I'm running Linus' master (as of 7f7072574).
> 
> I bisected it to the above named commit (but had to back out ba9d484ed3
> (""PCI/MSI: Remove the conditional parent [un]mask logic") and then
> 727e914bbfbbd ("PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in
> cond_[startup|shutdown]_parent()") first for a clean revert.)
> 
> I have a Dell XPS-9320 laptop, and booting would hang before it switched to
> the xe video driver from the EFI FB driver (not sure if this is a symptom or
> partial cause) and I'd see a message akin to "not being able to set up DP
> tunnels, destroying" as the last thing printed before it hangs. (If it's
> important to see those messages I believe I can force a pstore crash to get
> them where they can be saved off, let me know).
> 
> LMK if you need further info,
> 
> -Kenny
> 
> -- 
> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County
> CA
> 

Hi, can you test the following?

```
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 1bd5bf4a6097..b4b62b9ccc45 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -192,6 +192,12 @@ static void vmd_pci_msi_enable(struct irq_data *data)
 	data->chip->irq_unmask(data);
 }
 
+static unsigned int vmd_pci_msi_startup(struct irq_data *data)
+{
+	vmd_pci_msi_enable(data);
+	return 0;
+}
+
 static void vmd_irq_disable(struct irq_data *data)
 {
 	struct vmd_irq *vmdirq = data->chip_data;
@@ -210,6 +216,11 @@ static void vmd_pci_msi_disable(struct irq_data *data)
 	vmd_irq_disable(data->parent_data);
 }
 
+static void vmd_pci_msi_shutdown(struct irq_data *data)
+{
+	vmd_pci_msi_disable(data);
+}
+
 static struct irq_chip vmd_msi_controller = {
 	.name			= "VMD-MSI",
 	.irq_compose_msi_msg	= vmd_compose_msi_msg,
@@ -309,6 +320,8 @@ static bool vmd_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
 		return false;
 
+	info->chip->irq_startup		= vmd_pci_msi_startup;
+	info->chip->irq_shutdown	= vmd_pci_msi_shutdown;
 	info->chip->irq_enable		= vmd_pci_msi_enable;
 	info->chip->irq_disable		= vmd_pci_msi_disable;
 	return true;
```

