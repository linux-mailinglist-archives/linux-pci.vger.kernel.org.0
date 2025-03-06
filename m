Return-Path: <linux-pci+bounces-23047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72715A545C0
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 10:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E639164BAA
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 09:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6B419D880;
	Thu,  6 Mar 2025 09:02:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919171EDA10;
	Thu,  6 Mar 2025 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251760; cv=none; b=QEN6MsD0vt/SBM6U0hmXqtKhAT0BCN+7h0e2BtylbAXZRc9VVn6mhahOeRuK+MlsAXli+lMsxjCxU4jCCWK6BuFVJ4FObaL1S4kZlxlJAsF3b4+zQovxtCLeCc50LZXLOQonyv3nBY/MI0MvPyvV8CIXfsIVHg4Rk3VQaiLYJdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251760; c=relaxed/simple;
	bh=EmzY32j5rrDzC9R6X90mqEI/cN8KHLb58ft9sgUPtjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofUhNJX/mQ+8zqs0Gk/TdLKCvvwW7HJd1ONpqG8VXR77bRMIkNje0isVZfjQ3BqA1uyG4hdMnpr/CFsnJPiwEZWtph8Nj8XM5+qafoOOxcGF6lQrXpY0LOqsUmulRtnwSWfq8zRAz0Deq151Ot2TBDOzSkuCenAoRo4OaovwBJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2feb91a25bdso666538a91.1;
        Thu, 06 Mar 2025 01:02:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741251758; x=1741856558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61ZqbVDQw/xvqBk0WBOL0pupyCSc6ErVs2yZMS/tx8g=;
        b=AQ5FqP6VfPPNcJYnrmq4XpuuJUSq07vOciGMMquxTeXLO4mgsJCK6ir5+QB+BeTBjj
         hVhTmrFddAm8saH2cuDrlUai4JiXBHZZypqfQ99b9LwGldbkb+lZkTBv7GLWeWpDlvF4
         F4QeWOGJanJ2KAHJkqGS2fIJT7gRy+wblfYRbxlHb7sbqmV3mUPEXHe//+VhQ3Ccl5ZK
         kwNhDqfO+tE+cG1q6/MW4apXONeUkF7Iar8VL6vUmW+HdF65KhLNMOCEeIV5QPv8GtFV
         mHdA/3iVbSNN07pb/GwYidMSiCDSH3o5GQ4QjfELqJ6mOyYwxmhan3FD+0KHJLCCd0b2
         XHKw==
X-Forwarded-Encrypted: i=1; AJvYcCUfArC9EKanpeTNI6iMvsdyO4LuiH6gwetQZWZU2Czp08t0Ckuq8WN6qUKaV6vas1+kvvvhkMtQ1IHn@vger.kernel.org, AJvYcCWmRtKSSUCc2x5bHtX8dwGmW4hmRCPPagr3OhcqQuZP2NmvsIFTeYt/9d0q3vxhn+DLQ16UhMizsscvrsJHTzVkLQ==@vger.kernel.org, AJvYcCXlXvaerZWUNODoU3oqOvGajzWhBoa1Oh4vEZ4gu6VmXMm8zC+xyUHQ1n/9O1FemHuvo2oku2A/QVgfipYXJJEr2dk=@vger.kernel.org, AJvYcCXn1k4xkNsbR9W0DaQoUV84Af9S8nryi2Chh9WlY5oOR+XMUcmL261J+cvNrf+hvCj+x286oDqqH69a0zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaaAvOdf35JnE70AkrYp2A0xtagsau6wH+NsRqPNFlibtRb8JM
	M5sgLtVophYz8U6dothx+KY2X8lSHJIkkQD2GOy7A+emn0rCj51B
X-Gm-Gg: ASbGncvZCkaZAC+czwhUqNv0MYc3f2KlDuTbGau0R9FwrMLLof3oN6peGk/aSCoeVKY
	TkfOoDq9Hdn+IvIGSxIPsWp3gLbSS5lNJzb5OCZRB5us3XnK4OoZYwrMmIZpjNPM8woYqN1prjG
	PRLHOs+XuCV4gaohM5cuM4FOF3KrHWtlwqo6Ty37DGaPA5CfswVIyjNGHacgueAFxgFGEW4qmy+
	UDs3MhlSGEvJWeJJC7YK12ZC5eBTaYKs19ANCH6juO5OP5nhw4oYqzBzhzSb9y0OCkGwg6p3Tnm
	xt1mQTZNTm9kxeofNYJPLlI5+qHvTnmZqGGhpSFzqr5ey2wMGtMXo5NkeNrkEzpTRALL/IWqwbH
	GNf0=
X-Google-Smtp-Source: AGHT+IEVObRPs9r9DCgAFKVxTkcg7YE/ev/oTYXjSeBAHqcHwBFpzXUfu6D3RSOSTJvuqgree5Nh5A==
X-Received: by 2002:a17:90b:4c07:b0:2ff:6ac2:c5a6 with SMTP id 98e67ed59e1d1-2ff6ac2c770mr1605779a91.31.1741251757794;
        Thu, 06 Mar 2025 01:02:37 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ff4e75ed7csm2641751a91.3.2025.03.06.01.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 01:02:37 -0800 (PST)
Date: Thu, 6 Mar 2025 18:02:34 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <helgaas@kernel.org>, Fan Ni <nifan.cxl@gmail.com>,
	Shradha Todi <shradha.t@samsung.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, lpieralisi@kernel.org,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@huawei.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, cassel@kernel.org, 18255117159@163.com,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	will@kernel.org, mark.rutland@arm.com,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v7 3/5] Add debugfs based silicon debug support in DWC
Message-ID: <20250306090234.GA390800@rocinante>
References: <20250304171154.njoygsvfd567pb66@thinkpad>
 <20250305173826.GA303920@bhelgaas>
 <20250305182833.cgrwbrcwzjscxmku@thinkpad>
 <20250305190955.GK847772@rocinante>
 <CAMuHMdVRSjkss3gPnocXpfPQ=mEo4AevpaU=fdGvm=kb3RTmcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVRSjkss3gPnocXpfPQ=mEo4AevpaU=fdGvm=kb3RTmcQ@mail.gmail.com>

Hello,

[...]
> Another issue is that the caller does not handle failures correctly,
> given (A) the irqdomain WARNING I got, and (B) the half-registered
> PCI bus, oopsing on "lspci"...

This is something we will look into.  A more robust DesignWare core is
something we would definitely want to have.

Sorry about the issues with this...

[...]
> > -int dwc_pcie_debugfs_init(struct dw_pcie *pci)
> > +void dwc_pcie_debugfs_init(struct dw_pcie *pci)
> >  {
> >         char dirname[DWC_DEBUGFS_BUF_MAX];
> >         struct device *dev = pci->dev;
> > @@ -174,17 +174,15 @@ int dwc_pcie_debugfs_init(struct dw_pcie *pci)
> >         snprintf(dirname, DWC_DEBUGFS_BUF_MAX, "dwc_pcie_%s", dev_name(dev));
> >         dir = debugfs_create_dir(dirname, NULL);
> >         debugfs = devm_kzalloc(dev, sizeof(*debugfs), GFP_KERNEL);
> > -       if (!debugfs)
> > -               return -ENOMEM;
> > +       if (!debugfs) {
> > +               dev_err(dev, "failed to allocate memory for debugfs\n");
> 
> There is no need to print an error message when a memory allocation
> fails, as the memory allocation core already takes care of that.
> So please drop the dev_err() call.

Done.  Thank you!

	Krzysztof

