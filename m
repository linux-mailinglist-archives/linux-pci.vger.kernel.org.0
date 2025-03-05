Return-Path: <linux-pci+bounces-23009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B696A50B17
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 20:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75111889BA7
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 19:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177F0252912;
	Wed,  5 Mar 2025 19:10:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7433A2E339F;
	Wed,  5 Mar 2025 19:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741201800; cv=none; b=Rw3LJ5BTJv8QMKQ8Q8npFgTAA93LqzqCbGUz9NlMhpSFTMm7xoL5vWhUCouthtvx9bU4g/8PozzTe02iePq6fnspZUFsOCk2z6w+BhrCzcJzFtt3HO/nputvd/YAHreGJ2pRAOdmtQpKYo837jGLJhRLSVAyBK+2XY/75glVarQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741201800; c=relaxed/simple;
	bh=KW8symAa9+ElA7tol8KYpclJp8NcgDvhtncZvNKzDks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpTNBoBS0rU415N/pBq0KRuk4MGh3TYkk55r7NcaftjBLLSw7GwIMyyiNm9EiBurGIFUurirtsjcGF62g+LCZeefeEo0ATiV0c8soHc/sgqyXR3ah8M0G/N79m6EoYFc7I5ZKXUppDoj/MtyOjv5/m4eeme3IsunRupQRo4zzYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ff615a114bso306894a91.0;
        Wed, 05 Mar 2025 11:09:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741201798; x=1741806598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zodeiabiec4o+24nRPQhB7bjurm79o/P+gs1t8Gp0w0=;
        b=a6qjIMSEtnzUT0DE0JD6g7ecO+bUMzqm9xFhijJqyfx+GiaSAprV5VPtfgXes09hV/
         mwtJuGkrFPh3qagG2n9aSdpEdYZohi4QHlMqcbOAPPFs3oxe82UcNJeJwF+8OKNGPpX8
         Jm86/biXjK2gH5eEesQQav4KpiTbAw5FB+Zh+JzBS1PvdMQ8OaIxHk8WPSBpKgdtqrt7
         Ha9c40XlIzkObFz/ihGwm7a035eN/3jYJ9ScQyIwl9jCbj5JP2jwKa0Et9JREaz/Rdzx
         v1lqFpG/2Q21URm3RlM/hOEGBCVikZOg9AnIVUGDQ0M//evr8FsgLNrHpMX7bBEkPEzv
         NPeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyxAmHRBnDgjkZVJemCXEaFHgTMincMIepQixOT1FYNtZMjhHL+gF2Fuw2ha5KvQU5XCSFTI8jLDjARRU=@vger.kernel.org, AJvYcCW1g2/3le/85SCV1lQIK2p0uMPxUwZa9N5Nr6lHjZeRC1gxa1rK2t3m/n2QetXJnYFQJ1JL2zkQn8CO@vger.kernel.org, AJvYcCWEDegVTSIqphc+M0zDp3jXn5Cf2QDAn3w64iKQrBPV36zBk7RtXezEZcVCQk+H6jjWSl7S5d67z0kFGtT7aCIR4TA=@vger.kernel.org, AJvYcCXef0zkBurVqxdRS3EypgQlAFAK1D2+g9GQ2iqaiCHN89XB0DIXSJZN+or53xCvh7sPsTPDKS+PZ166LbrP4eXF3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyshFbjHYlb/LRLlnXxidSlUW/xB7V9VEzFqQopkysjZvrKpdAL
	ERhKWfJfrPr5AHFc0IEpeyleeBTmBAl6td0M+eg20odOQ6lnwBSo
X-Gm-Gg: ASbGnctZvhEi/V0J7AB4tzfah+wCSyCdRhvxqj7IboqvW1caeEC8iICA/cMew3Cvy78
	4t85P5mBYuZ8MIyadrZQhhOeBnpOk5BA9RIvmFxedw0q13Me82C08eC3mEX2uUbvcJrCb5r+Byh
	E6umDsQhmJ18fMNCh7IOSZ8GxbN4LZwA9CznYIT/f934Y6SMGoqRq8LClxgJHdlui++vcN6xlus
	6Bw4U2Gzywa2wqjsodrx2KpLCN9jULuL/oazg4+C8dF6LXzurkP8PUa84BM7oQsuyA5GbZFfEMK
	cXAC0Nyd+2uDZDkfZKhzRq5t60iOcUYkZW9Sz5JagrTDmzGiXJ6MI9SW3hxinU5bLIR6nd3bGSb
	FKlM=
X-Google-Smtp-Source: AGHT+IGNbRJpJbMeXjomF31jB4KIZE5TJ2wjy21GKVWmGQR/3PyTIYjAGlF+BWxQ8A3iKolTn3utJQ==
X-Received: by 2002:a17:90b:3ec5:b0:2ea:8aac:6ac1 with SMTP id 98e67ed59e1d1-2ff617b5145mr663825a91.15.1741201797566;
        Wed, 05 Mar 2025 11:09:57 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ff53eda418sm1213607a91.45.2025.03.05.11.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:09:57 -0800 (PST)
Date: Thu, 6 Mar 2025 04:09:55 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Fan Ni <nifan.cxl@gmail.com>, Shradha Todi <shradha.t@samsung.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, lpieralisi@kernel.org,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@huawei.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, cassel@kernel.org, 18255117159@163.com,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	will@kernel.org, mark.rutland@arm.com,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v7 3/5] Add debugfs based silicon debug support in DWC
Message-ID: <20250305190955.GK847772@rocinante>
References: <20250304171154.njoygsvfd567pb66@thinkpad>
 <20250305173826.GA303920@bhelgaas>
 <20250305182833.cgrwbrcwzjscxmku@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305182833.cgrwbrcwzjscxmku@thinkpad>

Hello,

[...]
> > > Even though debugfs_init() failure is not supposed to fail the probe(),
> > > dwc_pcie_rasdes_debugfs_init() has a devm_kzalloc() and propagating that
> > > failure would be canolically correct IMO.
> > 
> > I'm not sure about this.  What's the requirement to propagate
> > devm_kzalloc() failures?  I think devres will free any allocs that
> > were successful regardless.
> > 
> > IIUC, we resolved the Gray Hawk Single issue by changing
> > dwc_pcie_rasdes_debugfs_init() to return success without doing
> > anything when there's no RAS DES Capability.
> > 
> > But dwc_pcie_debugfs_init() can still return failure, and that still
> > causes dw_pcie_ep_init_registers() to fail, which breaks the "don't
> > propagate debugfs issues upstream" rule:
> > 
> >   int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
> >   {
> >           ...
> >           ret = dwc_pcie_debugfs_init(pci);
> >           if (ret)
> >                   goto err_remove_edma;
> > 
> >           return 0;
> > 
> >   err_remove_edma:
> >           dw_pcie_edma_remove(pci);
> > 
> >           return ret;
> >   }
> > 
> > We can say that kzalloc() failure should "never" happen, and therefore
> > it's OK to fail the driver probe if it happens, but that doesn't seem
> > like a strong argument for breaking the "don't propagate debugfs
> > issues" rule.  And someday there may be other kinds of failures from
> > dwc_pcie_debugfs_init().
> > 
> 
> Fine with me. I was not too sure about propagating failure either.

What if we do this?

diff --git i/drivers/pci/controller/dwc/pcie-designware-debugfs.c w/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index 586a9d107434..fddf71f014c4 100644
--- i/drivers/pci/controller/dwc/pcie-designware-debugfs.c
+++ w/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -162,7 +162,7 @@ void dwc_pcie_debugfs_deinit(struct dw_pcie *pci)
 	debugfs_remove_recursive(pci->debugfs->debug_dir);
 }

-int dwc_pcie_debugfs_init(struct dw_pcie *pci)
+void dwc_pcie_debugfs_init(struct dw_pcie *pci)
 {
 	char dirname[DWC_DEBUGFS_BUF_MAX];
 	struct device *dev = pci->dev;
@@ -174,17 +174,15 @@ int dwc_pcie_debugfs_init(struct dw_pcie *pci)
 	snprintf(dirname, DWC_DEBUGFS_BUF_MAX, "dwc_pcie_%s", dev_name(dev));
 	dir = debugfs_create_dir(dirname, NULL);
 	debugfs = devm_kzalloc(dev, sizeof(*debugfs), GFP_KERNEL);
-	if (!debugfs)
-		return -ENOMEM;
+	if (!debugfs) {
+		dev_err(dev, "failed to allocate memory for debugfs\n");
+		return;
+	}

 	debugfs->debug_dir = dir;
 	pci->debugfs = debugfs;
 	err = dwc_pcie_rasdes_debugfs_init(pci, dir);
-	if (err) {
-		dev_err(dev, "failed to initialize RAS DES debugfs, err=%d\n",
-			err);
-		return err;
-	}
-
-	return 0;
+	if (err)
+		dev_warn(dev, "failed to initialize RAS DES debugfs, err=%d",
+			 err);
 }
diff --git i/drivers/pci/controller/dwc/pcie-designware-ep.c w/drivers/pci/controller/dwc/pcie-designware-ep.c
index c6e76a07c2c9..11ff292ca87d 100644
--- i/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ w/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -838,9 +838,7 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)

 	dw_pcie_ep_init_non_sticky_registers(pci);

-	ret = dwc_pcie_debugfs_init(pci);
-	if (ret)
-		goto err_remove_edma;
+	dwc_pcie_debugfs_init(pci);

 	return 0;

diff --git i/drivers/pci/controller/dwc/pcie-designware-host.c w/drivers/pci/controller/dwc/pcie-designware-host.c
index 2081e8c72d12..6501fb062c70 100644
--- i/drivers/pci/controller/dwc/pcie-designware-host.c
+++ w/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -548,9 +548,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (pp->ops->post_init)
 		pp->ops->post_init(pp);

-	ret = dwc_pcie_debugfs_init(pci);
-	if (ret)
-		goto err_stop_link;
+	dwc_pcie_debugfs_init(pci);

 	return 0;

diff --git i/drivers/pci/controller/dwc/pcie-designware.h w/drivers/pci/controller/dwc/pcie-designware.h
index 7f9807d4e5de..dd129718fb41 100644
--- i/drivers/pci/controller/dwc/pcie-designware.h
+++ w/drivers/pci/controller/dwc/pcie-designware.h
@@ -815,12 +815,11 @@ dw_pcie_ep_get_func_from_ep(struct dw_pcie_ep *ep, u8 func_no)
 #endif

 #ifdef CONFIG_PCIE_DW_DEBUGFS
-int dwc_pcie_debugfs_init(struct dw_pcie *pci);
+void dwc_pcie_debugfs_init(struct dw_pcie *pci);
 void dwc_pcie_debugfs_deinit(struct dw_pcie *pci);
 #else
-static inline int dwc_pcie_debugfs_init(struct dw_pcie *pci)
+static inline void dwc_pcie_debugfs_init(struct dw_pcie *pci)
 {
-	return 0;
 }
 static inline void dwc_pcie_debugfs_deinit(struct dw_pcie *pci)
 {

I think this would be fine, especially given the rules around debugfs and
a quick look around Git history to see what the prefernce would be typically.

Thank you!

	Krzysztof

