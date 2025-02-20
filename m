Return-Path: <linux-pci+bounces-21895-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1707A3D568
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 10:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6F43BDDDC
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 09:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687371F1536;
	Thu, 20 Feb 2025 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hd0VHDU0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DDB1F0E38
	for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044915; cv=none; b=YZdYuy61d5U57WGhNZqUBMbuK3DF0qet7xwIAsgggPms/u29xODq1kUaJEXqr2nWtr010s2rbHYQNCrbstoZaMsaYkixA9JqZ30+scF8+/eXBhQQfEJyehV3W1Z3w7gRTMlY0YUitJRGfeMVa6ATTdtnXf2JK9Ki4Ka2TIYi4LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044915; c=relaxed/simple;
	bh=wkIIVni6B5hqhOxCyIDWV70k/71CKF+whrBn28HHMzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhaUXIvlfTho3zBVPizbxe20jQ2s/5c02YPk7YyRhMcUWVbblpYG+SiORew0XtcijDtsFW58sJ943ApWqANyniDg0ouY/xlJLfvThUpRlKOWg/3tLh12EMhoS7rN8+G8qV7uv1Q49wHa3dnlCkyd0QqBNqJ3W+wlsibE3qgUIA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hd0VHDU0; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-219f8263ae0so13863895ad.0
        for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 01:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740044913; x=1740649713; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2H1MlQwDqY4gHtZvtzxymuM1fxgAewM2EX9NkpggOfY=;
        b=Hd0VHDU0I27yHRVgO4CC/ihbMPdTce+fGASFjFdv/oU93FgDWdJAYR9VrDClqYrhMA
         0a2kvSZVlwfjRyr3OiTjJnj3UMVr5+WkquriDkWLYpAT5Q9wa8/lJP3h5zHmcXlYf80N
         m8cQ1ugBxa3O+w0hGbbuYkPgitH11t1W6K2uCDi6fOtB92avaxpgpyTMZyTpyCRRhc7R
         pRUUv/L3HHdMfsmkwaJqio1+AwT3+iPowntAfTOcim8IL2Gviu+fadEa0+wy1vMW7BdP
         ClJh0TBTRjiL4dnG1JKAHuFJjZul5XptTmEWwyx7od3MJtsfct+wNCrWJvLAVfIXTQIi
         WDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740044913; x=1740649713;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2H1MlQwDqY4gHtZvtzxymuM1fxgAewM2EX9NkpggOfY=;
        b=LNz2CY43xE1syhy3NZ6XRBdX5pzKz1+6lPJf0lFTkDHBwDTAS3+qNHfkU8v9PVvUWD
         jy0cchsUKBgYH8tInbQlXbe68bEEye3Lh8XEQriCnrWPv8VTUgJWhUl2JEjI1AJypcUd
         SkSOQcYywKFvVSfLgmd6sdz/bzDI15q1zUhhOogUwNIPCo+r7DLSEIs3wjL9m1JpoP25
         W/v+yQhKG+Lnbn23Vf2knKiPhCY8/23JUYBWTP2Z25XOtsSIS7UTOrc2Mv3kcDDk2TXo
         aWFPiNZi/4oXzFKH0g/fnQ+oCUgMbscCqlrvta5KPpNXCXBkrrJR572WQ4A+NIJo7J6m
         5zGA==
X-Forwarded-Encrypted: i=1; AJvYcCVjOrctyxfOsn2NkE1/0ikR9SgmfCIBN1rY02g9EU5RFkUnY0vESEUH/kIgJ4ZJKQR/Le5P2z+vNJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx57g+qANFDStP/3vOspJYTpSWAwteXBoeYZovScaJkRtALdueh
	qR7mrICBnC4tuqYU7IdUfI/bAKeUSqKchaFUOIU0zjtrLCpOY61I0ynTXCy1Ow==
X-Gm-Gg: ASbGncsLEvQUguagYKz4kk9A1DCogYTLTDIn75aQdXvAW/+rY53QaAHx39T09wBIJ1f
	ErA6+g40Zts3fpMl5qWHTUDtcmDvlfYL6TzAC2aB7vnTV2Nm2EUwevgN0K8RAOaYsA2ebGh+6FB
	w0ouxBsxgqMkGD695XiR3MfhYhNBFPp+MOZ8qnYDmeqU3cpYy9gp6bMu2REQoayeC1dGfRr0HRs
	0CCkkXwCKBKSXocT91zn1IbeO9bwTvHYM9Y7rylAOEM47Y194cKoxsRGxs72BEVx0GD/n83e1Cu
	+BEAwqDVyElfK7RwSMyCk7rxOA==
X-Google-Smtp-Source: AGHT+IGDrYz4r/0p4Sw8EqLETFPMW3Qgrtc4FnstWsmQZ7/m7iB+t4YxN2YZIMjD8pXulTOwEq8J1A==
X-Received: by 2002:a17:902:ea04:b0:21f:4c8b:c511 with SMTP id d9443c01a7336-221040bd73cmr334825575ad.33.1740044912672;
        Thu, 20 Feb 2025 01:48:32 -0800 (PST)
Received: from thinkpad ([120.60.70.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d537bd1asm117751755ad.102.2025.02.20.01.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 01:48:32 -0800 (PST)
Date: Thu, 20 Feb 2025 15:18:25 +0530
From: 'Manivannan Sadhasivam' <manivannan.sadhasivam@linaro.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@Huawei.com, fan.ni@samsung.com,
	nifan.cxl@gmail.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, cassel@kernel.org, 18255117159@163.com,
	quic_nitegupt@quicinc.com, quic_krichai@quicinc.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v6 2/4] Add debugfs based silicon debug support in DWC
Message-ID: <20250220094825.2idjwpuo2yo5n6tc@thinkpad>
References: <20250214105007.97582-1-shradha.t@samsung.com>
 <CGME20250214105341epcas5p11ea07dba0a55700bc098077eb53e79b8@epcas5p1.samsung.com>
 <20250214105007.97582-3-shradha.t@samsung.com>
 <20250218150239.mnylvhyfnw6dtzag@thinkpad>
 <02f501db8378$5fce2060$1f6a6120$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02f501db8378$5fce2060$1f6a6120$@samsung.com>

On Thu, Feb 20, 2025 at 02:48:12PM +0530, Shradha Todi wrote:
> 
> 
> > -----Original Message-----
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Sent: 18 February 2025 20:33
> > To: Shradha Todi <shradha.t@samsung.com>
> > Cc: linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org; lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> > bhelgaas@google.com; jingoohan1@gmail.com; Jonathan.Cameron@Huawei.com; fan.ni@samsung.com; nifan.cxl@gmail.com;
> > a.manzanares@samsung.com; pankaj.dubey@samsung.com; cassel@kernel.org; 18255117159@163.com;
> > quic_nitegupt@quicinc.com; quic_krichai@quicinc.com; gost.dev@samsung.com
> > Subject: Re: [PATCH v6 2/4] Add debugfs based silicon debug support in DWC
> > 
> > On Fri, Feb 14, 2025 at 04:20:05PM +0530, Shradha Todi wrote:
> > > Add support to provide silicon debug interface to userspace. This set
> > > of debug registers are part of the RASDES feature present in
> > > DesignWare PCIe controllers.
> > >
> > > Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> > > ---
> > >  Documentation/ABI/testing/debugfs-dwc-pcie    |  13 ++
> > >  drivers/pci/controller/dwc/Kconfig            |  10 +
> > >  drivers/pci/controller/dwc/Makefile           |   1 +
> > >  .../controller/dwc/pcie-designware-debugfs.c  | 207 ++++++++++++++++++
> > >  .../pci/controller/dwc/pcie-designware-ep.c   |   5 +
> > >  .../pci/controller/dwc/pcie-designware-host.c |   6 +
> > >  drivers/pci/controller/dwc/pcie-designware.h  |  20 ++
> > >  7 files changed, 262 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/debugfs-dwc-pcie
> > >  create mode 100644
> > > drivers/pci/controller/dwc/pcie-designware-debugfs.c
> > >
> > > diff --git a/Documentation/ABI/testing/debugfs-dwc-pcie
> > > b/Documentation/ABI/testing/debugfs-dwc-pcie
> > > new file mode 100644
> > > index 000000000000..e8ed34e988ef
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/debugfs-dwc-pcie
> > > @@ -0,0 +1,13 @@
> > > +What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_debug/lane_detect
> > > +Date:		Feburary 2025
> > 
> > Please align these fields
> 
> The fields are already aligned in my patch (when I check in git), not sure why the mail misaligns it. Can you suggest how
> should I fix this?
> 

You should consistently use tabs or space after colon throughout the file. Don't
mix them.

> > 
> > > +Contact:	Shradha Todi <shradha.t@samsung.com>
> > > +Description:	(RW) Write the lane number to be checked for detection.	Read
> > > +		will return whether PHY indicates receiver detection on the
> > > +		selected lane. The default selected lane is Lane0.
> > > +
> > > +What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_debug/rx_valid
> > > +Date:		Feburary 2025
> > > +Contact:	Shradha Todi <shradha.t@samsung.com>
> > > +Description:	(RW) Write the lane number to be checked as valid or invalid. Read
> > > +		will return the status of PIPE RXVALID signal of the selected lane.
> > > +		The default selected lane is Lane0.

[...]

> > > +static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct
> > > +dentry *dir) {
> > > +	struct dentry *rasdes_debug;
> > > +	struct dwc_pcie_rasdes_info *rasdes_info;
> > > +	const struct dwc_pcie_vsec_id *vid;
> > > +	struct device *dev = pci->dev;
> > > +	int ras_cap;
> > > +
> > > +	for (vid = dwc_pcie_vsec_ids; vid->vendor_id; vid++) {
> > > +		ras_cap = dw_pcie_find_vsec_capability(pci, vid->vendor_id,
> > > +							vid->vsec_id);
> > > +		if (ras_cap)
> > > +			break;
> > > +	}
> > > +	if (!ras_cap) {
> > > +		dev_dbg(dev, "no rasdes capability available\n");
> > > +		return -ENODEV;
> > > +	}
> > 
> > This will also go inside a new API, dw_pcie_find_rasdes_capability(pci).
> > 
> 
> Okay, are we planning to make a function for each VSEC? Or should we just pass the rasdes_vids to the
> dw_pcie_find_vsec_capability?
> 

dw_pcie_find_vsec_capability() is a static function in my series. We should
add separate function for each VSEC.

> > > +
> > > +	rasdes_info = devm_kzalloc(dev, sizeof(*rasdes_info), GFP_KERNEL);
> > > +	if (!rasdes_info)
> > > +		return -ENOMEM;
> > > +
> > > +	/* Create subdirectories for Debug, Error injection, Statistics */
> > > +	rasdes_debug = debugfs_create_dir("rasdes_debug", dir);
> > 
> > _debug prefix is not needed since the directory itself belongs to debugfs.
> > 
> 
> It's not for the debug in debugfs. So the DES features are
> Debug
> Error Injection
> Statistics.
> The debug here is for the "D" in DES.
> 

Sorry, I missed it.

> > > +
> > > +	mutex_init(&rasdes_info->reg_lock);
> > > +	rasdes_info->ras_cap_offset = ras_cap;
> > > +	pci->debugfs->rasdes_info = rasdes_info;
> > > +
> > > +	/* Create debugfs files for Debug subdirectory */
> > > +	dwc_debugfs_create(lane_detect);
> > > +	dwc_debugfs_create(rx_valid);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +void dwc_pcie_debugfs_deinit(struct dw_pcie *pci) {
> > > +	dwc_pcie_rasdes_debugfs_deinit(pci);
> > > +	debugfs_remove_recursive(pci->debugfs->debug_dir);
> > > +}
> > > +
> > > +int dwc_pcie_debugfs_init(struct dw_pcie *pci) {
> > > +	char dirname[DWC_DEBUGFS_BUF_MAX];
> > > +	struct device *dev = pci->dev;
> > > +	struct debugfs_info *debugfs;
> > > +	struct dentry *dir;
> > > +	int ret;
> > > +
> > > +	/* Create main directory for each platform driver */
> > > +	snprintf(dirname, DWC_DEBUGFS_BUF_MAX, "dwc_pcie_%s", dev_name(dev));
> > > +	dir = debugfs_create_dir(dirname, NULL);
> > > +	if (IS_ERR(dir))
> > > +		return PTR_ERR(dir);
> > 
> > debugfs creation is not supposed to fail. So you should remove the error check.
> > 
> 
> There was no error check until v3. Got a comment from Jonathan in v3:
> 	"Check for errors in all these."
> I think he wanted to add in all the debugfs creations but I just added in the topmost directory.
> I checked that error will be returned in case someone turns off debugfs mounting as early param.
> So, if the first directory gets made, there would be no issues in subsequent subdirectories.
> 

Please see the Kdoc comments for this API:

 * NOTE: it's expected that most callers should _ignore_ the errors returned
 * by this function. Other debugfs functions handle the fact that the "dentry"
 * passed to them could be an error and they don't crash in that case.
 * Drivers should generally work fine even if debugfs fails to init anyway.

> > > +
> > > +	debugfs = devm_kzalloc(dev, sizeof(*debugfs), GFP_KERNEL);
> > > +	if (!debugfs)
> > > +		return -ENOMEM;
> > > +
> > > +	debugfs->debug_dir = dir;
> > > +	pci->debugfs = debugfs;
> > > +	ret = dwc_pcie_rasdes_debugfs_init(pci, dir);
> > > +	if (ret)
> > > +		dev_dbg(dev, "rasdes debugfs init failed\n");
> > 
> > RASDES
> > 
> > > +
> > > +	return 0;
> > > +}
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > index f3ac7d46a855..a87a714bb472 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > @@ -642,6 +642,7 @@ void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)  {
> > >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > >
> > > +	dwc_pcie_debugfs_deinit(pci);
> > >  	dw_pcie_edma_remove(pci);
> > >  }
> > >  EXPORT_SYMBOL_GPL(dw_pcie_ep_cleanup);
> > > @@ -813,6 +814,10 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep
> > > *ep)
> > >
> > >  	dw_pcie_ep_init_non_sticky_registers(pci);
> > >
> > > +	ret = dwc_pcie_debugfs_init(pci);
> > > +	if (ret)
> > > +		goto err_remove_edma;
> > > +
> > >  	return 0;
> > >
> > >  err_remove_edma:
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index d2291c3ceb8b..6b03ef7fd014 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -524,6 +524,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > >  	if (ret)
> > >  		goto err_remove_edma;
> > >
> > > +	ret = dwc_pcie_debugfs_init(pci);
> > > +	if (ret)
> > > +		goto err_remove_edma;
> > > +
> > 
> > Why can't you move it to the end of the function?
> 
> So the debugfs entries record certain debug values that might be useful to read
> in case link does not come up. Therefore, I'm adding it before starting link up so that users can 
> read it in case some failure occurs in further steps.
> 

I don't understand this. Even if you move it to the end of the function, users
can still read the attributes and learn what happended with the link. We don't
fail if the link doesn't come up.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

