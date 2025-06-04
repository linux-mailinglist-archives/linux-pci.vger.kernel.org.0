Return-Path: <linux-pci+bounces-28939-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42CFACD7B9
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 08:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9D31718AC
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 06:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA1B2627F5;
	Wed,  4 Jun 2025 06:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rr1sCKih"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58BE237173
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 06:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749017153; cv=none; b=fa1DGG0tj6SA8JAPEWTc3axzrhLrpfHJrfpCKooI2pYGPot8z7k42Anp1AmBbF5BsXHyfjSF0UzbEaMLiKNJ/eKy9SQJBpEXh3fnGFaLdsvaXEIyCJRO0MHmhqur3014s0tnrRoktzU0tVaNdNtAPAjS5kjdeq+FxmowEOcbsMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749017153; c=relaxed/simple;
	bh=BqfaYQx97o+JOP+K1NGE6tuY6VxM7+aD/6TxPpXbrak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1kTzOKqHNdgNi1Xv2S10Wn6bNGRYZdyMUDjSY6sSBddRz9/l0j7CmewyivvQAi8vPoRdrtl4b6Pqp6t8MA/tRZ/Q3imT1dtQNWd3UQlqXzq3xFekufxgAp1nhLKkvzxX1XmNAzk80fPRgIRLs0hr9dfxhv7k/medDdtvf/qNUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rr1sCKih; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so56413865e9.3
        for <linux-pci@vger.kernel.org>; Tue, 03 Jun 2025 23:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749017150; x=1749621950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZH44UMshivXu/WwJMMc2cUDTZKuUc71AWCQOvue4lTc=;
        b=rr1sCKihUY4jHPDdrL1/xCij+xDy6yz+Z7D5UlcAzC4S0lP1vAtZh1RJCfsOnoJaDg
         ryp0oV8GwB3zhUGinz4By7KuRB4E20UXcxZz/OPDMoj9fhzoFugnCs4ZzW06pdAT+n9I
         f1/fTmRMTF+yGRRNEzQi5nVsUxt4YNzHvbMAyP4HkGTwZwANupUzQFTGV5DAkTDbaeUE
         DE0d2gP80ALQgZXdKbuc3D2/9AesNCfYaMV6uXXGOYw7f5xEIkwazopnH/56gMaIFta/
         RibV4xUvZzZD6drL2XZ5XjhI3e5uOneGW8UzAxNEvqOUPDivAAjQwfwdTH8m13kWIJAX
         SCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749017150; x=1749621950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZH44UMshivXu/WwJMMc2cUDTZKuUc71AWCQOvue4lTc=;
        b=M6l+AR4I5EADSFSTOZ368BrPGk9LOdP6s66p+Y76a25dHRZSSsOrOSeUsxIx5HV0rU
         NaP2xqEjUQc26GpNT26UFWNYuaCRlKWU9IoiLfAA+S1fwBn4SEQMkS2gTh/a1jHO4Xo6
         xz+GvUYNiTkPKNzRuNRtVly0vqkn/9rwsWQyjFQJXi018gF9kjIBCQVbhQgoP8iB28+r
         F8tpuzNKufcz3i9x+6CcIwk+pAsdZ6INyy0k8jtVldRb7tbBv0wPQxyI52v8NUL6phVw
         XrCoz9Mvl0XnohEaNQ8qRXzfqorHNeF2vSCrLavbqIy5lfpcjTCfrInZT1hp3qHHjmXm
         rm5w==
X-Forwarded-Encrypted: i=1; AJvYcCU+Q2Z0GMtFDpBWhLT61BLg7JlN80hoFsJ7DawVVQi0kOdjHnsz268aBf4O0Q3p9iidggH4OeMSKG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz21vZYYn0P1/QwlsxkGauygzugp4oapT5YwDsB5mDwqA50ZPuH
	wDFwbC7iYfmtufXcgFDRQVZmNRC2vtIMwWds9o57n4z5xvlh+nqEXxT1jajH+A4hYhg=
X-Gm-Gg: ASbGnctOZOLtqLnQIvvY1G5qzFCgt7FMcZWtuDzOpp/m9Sbfn2J6dyzcX94ul5N2Tnc
	DrJpyOCTMwet/NN8O0eQirBqMYIfoz8mE7MJIShgtNk7zqmKTTNvdbYussAwjxeu0VENscDAxcI
	DrEreRAZHSJvKnBsjLEGgdYKgR504JuazUSfuye9eDVrS3tTiBTnoEAlGM6EMb0jh0rbIZ3fJbR
	dTxM9Ja95SaeOHR/OfwU+8JBcIq6iYN9cd/eCZPNOMOzcpfmeqfbT/cbGvz0/B59A1E/R7Q0IG9
	iV9qQxlVDstAB7V6T5to/sArhw/mzx7cAwwmOmllyqy3k3WnxuMQ1r+f
X-Google-Smtp-Source: AGHT+IGm1afoxcy8lx6vgqoRP0d9Plaozw5hLF59bcfnlN4ynAXn5BG3bAPTyvKW+OZbq0W2nOxEZw==
X-Received: by 2002:a05:600c:530d:b0:450:d3b9:4ba2 with SMTP id 5b1f17b1804b1-451f0b3ce5bmr9739335e9.24.1749017150125;
        Tue, 03 Jun 2025 23:05:50 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a4f0097205sm20706878f8f.79.2025.06.03.23.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 23:05:49 -0700 (PDT)
Date: Wed, 4 Jun 2025 09:05:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: PradeepVineshReddy.Kodamati@amd.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
	bp@alien8.de, ming.li@zohomail.com, shiju.jose@huawei.com,
	Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
	yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org,
	colyli@suse.de, uaisheng.ye@intel.com,
	fabio.m.de.francesco@linux.intel.com, ilpo.jarvinen@linux.intel.com,
	yazen.ghannam@amd.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v9 04/16] PCI/AER: Dequeue forwarded CXL error
Message-ID: <aD_iOk0vxDp88z8U@stanley.mountain>
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-5-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603172239.159260-5-terry.bowman@amd.com>

On Tue, Jun 03, 2025 at 12:22:27PM -0500, Terry Bowman wrote:
> +static struct pci_dev *sbdf_to_pci(struct cxl_prot_error_info *err_info)
> +{
> +	unsigned int devfn = PCI_DEVFN(err_info->device,
> +				       err_info->function);
> +	struct pci_dev *pdev __free(pci_dev_put) =

What?  Why is it freeing the returned pointer?  That should happen in
the caller, surely?

> +		pci_get_domain_bus_and_slot(err_info->segment,
> +					    err_info->bus,
> +					    devfn);
> +	return pdev;
> +}
> +
> +static void cxl_handle_prot_error(struct cxl_prot_error_info *err_info)
> +{
> +	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(sbdf_to_pci(err_info));

Ok, it does happen in the caller, but dropping and then incrementing
the reference count  like this is racy.

regards,
dan carpenter

> +
> +	if (!pdev) {
> +		pr_err("Failed to find the CXL device\n");
> +		return;
> +	}
> +
> +	/*
> +	 * Internal errors of an RCEC indicate an AER error in an
> +	 * RCH's downstream port. Check and handle them in the CXL.mem
> +	 * device driver.
> +	 */
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_EC)
> +		return pcie_walk_rcec(pdev, cxl_rch_handle_error_iter, err_info);
> +
> +	if (err_info->severity == AER_CORRECTABLE) {
> +		int aer = pdev->aer_cap;
> +		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +		struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
> +
> +		if (aer)
> +			pci_clear_and_set_config_dword(pdev,
> +						       aer + PCI_ERR_COR_STATUS,
> +						       0, PCI_ERR_COR_INTERNAL);
> +
> +		cxl_cor_error_detected(pdev);
> +
> +		pcie_clear_device_status(pdev);
> +	} else {
> +		cxl_do_recovery(pdev);
> +	}
> +}
> +


