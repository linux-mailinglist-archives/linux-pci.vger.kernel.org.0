Return-Path: <linux-pci+bounces-22724-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C2AA4B41C
	for <lists+linux-pci@lfdr.de>; Sun,  2 Mar 2025 19:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D9D3AE620
	for <lists+linux-pci@lfdr.de>; Sun,  2 Mar 2025 18:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8AD1EB185;
	Sun,  2 Mar 2025 18:35:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8FD192B84;
	Sun,  2 Mar 2025 18:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740940515; cv=none; b=I5IuiBhKcf1MpgDnOrjkVjb51tsK6QMDlZ+m0Akefvl6RQ74zvnVkGybYn7iPRxZaXZiR+iEXMAIvuqIuNxnvbtZFP7ZQvzK17X+tsPBm0we6M1ue9gpvXRgj0OzZAbqo8+xSwqOjyrbxn55/c+fLlIbZDKgAQBCy3fUsF1wc88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740940515; c=relaxed/simple;
	bh=l7d0QPHN7b0W2j7m6Dh4f5tT9UCp/3+opsCpaQ/6RcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUuui/SE2wMHF8ggAAmk6m42ZIt/82kJtGBfmO6ClrV0MCgz6vBsh0QbZEzBCYsvkOMGB1sQs2fkH6o2nUmpZhH+NhDwXaSj4BdTvwFZODHO5Opj6VdPFDsk2xv7EAfYq6MvtK2mTg1mWjmBEgE/QRn5xGsBlmqccADk3R3XVwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2239f8646f6so10749715ad.2;
        Sun, 02 Mar 2025 10:35:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740940513; x=1741545313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qrJarovt3JRo1+J2xc9vBIGut4SqnHN/YV1pZmTFs4=;
        b=lK++hNYTVvgtNIc2JRogvF1odwPZMAKefIpMW6oTHlcpKnV+kCD5znEor3xWXGwArK
         cPI5pxQGzs0F0vSFfJ13tbyAFil2KQoMiYp9MHGCOFuIcM0v3P9cKOOllQYNpHDBVMlw
         /2nslFM2/DQdXr80OvKAPKC8jhehOpq0GKg6LHCxULEvEoN0y3xHxtS6QhQaAHScfBTl
         fRavw4bfIqzrJZc0Bbl3O/Xu3TGOONv1egVtITXTZqT4vBMQ2argyOBHlyRXaFwNuF3L
         sqdtVEjjUF8+eZWJkIXIYfbRAFr1ENUiC4dfJ+3W/20ArMmfil4WqPScpwW1UNyH2UR2
         PEog==
X-Forwarded-Encrypted: i=1; AJvYcCXqq676QVeQRJdlaryBcQ5xRbBg6QAQCxv09ekTrwBXGbPr9EC5jfBs08/xWTVTyoHkQY77A9TvVZaA@vger.kernel.org, AJvYcCXsutvRS6UB7IQhyrxv1ZufKjppN/3i9w5qxf11tJX3VY8WaftVKISdDwwci1nWL5QTesvHpvAYUo4o86mh@vger.kernel.org, AJvYcCXzz2dTs3GO7r2BZ/bHJtXrFy3Q+2dT4Y8BjKKXNOSo7hJiBk5cCtaMA0L4cNul0YNcPnhwc7yek3p6@vger.kernel.org
X-Gm-Message-State: AOJu0YyZs8fVFFGCANCmCS+P4VJBagDcmrsv2Iz8U0YgbFFY6iQYERQ7
	TVsd1Rp6W7sZtjcSZvtuROJu4U4dEQ+3OmF0mdSwl8NSJdY5j564
X-Gm-Gg: ASbGncuTxr1iZHdIh/G3vmG5koHbpWq38T4DuBN4UMcmrIEToR2l/cBE77DAdHnxBxE
	ptdZPaz7puszy/3U/19regqf8UsV22X7SBUZXZkrbs10b0uu3lHAp8nnMrlwVbsko5IJ7kUQLUy
	Dp+ZMJMOGaIWRpVmqO80kKhXaof1AYQcWzqFsC8WpBLz7lkceXd8HARDuCsisELXsgHTeXru5ZV
	g6aSnvZPT2Zf3MtSQVn3E8grizm8i4KthfDyJ10JJgAUEuDMAZlEPz5kHgfno874Hk1UPIVTr9l
	j56OhGTpZeVmkndfJMlLByKQ0wwZym4Ek2teSxUKmEantPDSGfSDtWBuk0vp08mQaeTd/u+yC+p
	vuFs=
X-Google-Smtp-Source: AGHT+IGoynSMPy+RMsWdESjFujJFalxEFNEELF6K6YTs5uQHfejUEC8hC2gbL9gbP247vvHeUXSXsA==
X-Received: by 2002:a17:90b:3b8e:b0:2fa:228d:5b03 with SMTP id 98e67ed59e1d1-2febab7a2e4mr14947794a91.19.1740940513656;
        Sun, 02 Mar 2025 10:35:13 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fea698ff95sm7297319a91.43.2025.03.02.10.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 10:35:12 -0800 (PST)
Date: Mon, 3 Mar 2025 03:35:10 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	bhelgaas@google.com, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com,
	jingoohan1@gmail.com
Subject: Re: [PATCH v15 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Message-ID: <20250302183510.GC3374376@rocinante>
References: <20250228093351.923615-4-thippeswamy.havalige@amd.com>
 <20250228163721.GA56317@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228163721.GA56317@bhelgaas>

Hello,

[...]
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes:
> > | https://lore.kernel.org/oe-kbuild-all/202502191741.xrVmEAG4-lkp@intel.
> > | com/
> 
> Drop these reported-by: and closes: tags.
> 
> Krzysztof K. already said this:
> https://lore.kernel.org/r/144202cc-057c-4a7d-852a-27e979284dd2@kernel.org
> 
> Don't repost the series just for this.  If there are no other
> comments, we can remove this when merging it.

I removed these when applying.  Thank you!

	Krzysztof

