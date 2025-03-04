Return-Path: <linux-pci+bounces-22834-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 874C7A4DC79
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 12:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8062B18844E3
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 11:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5A51FECCE;
	Tue,  4 Mar 2025 11:23:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27581F9F73;
	Tue,  4 Mar 2025 11:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741087436; cv=none; b=XHFkMByKFRsPaYCWaX6Zog3R55zk6deF2aEk560lY4Y7j8a3CJO8wSLqeYcQZVhALAKdRllCt4khqgrZ8Mh8dYW3qX8BcYz+yxGKoKzTk+jgENPLT3ZFFswEGtwrpkJrxAFtdu7klvH9MAQAp+4E9MqEuzLpjisliyLgpyqWunE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741087436; c=relaxed/simple;
	bh=JOYjasouVRO3o6RgMExrK3pQmulScXxTN9o2B86UVrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4PTi4azkNu/CKIXEISdpERf6qyOIEtxKtsgtZHA3WSIlGA/YVkY5vVeMqcBiViUhz8WyPMoMEKJLX7VgMzZ839hsAJH+ckIT9AcaNpW5TBnYmDeqN0DHXKL0IkssEnc4EjQZ2XLHI94sOvb9KCVSnJw+h+CyKeFkNXi+gOtVKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22185cddbffso108045395ad.1;
        Tue, 04 Mar 2025 03:23:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741087434; x=1741692234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ta+9BN55K6L6GjGyvObgWVr1yZ4SW90dTHxigz1cLy0=;
        b=ZznE2dQGYJrempHSG5Dp1A9ZRTFYNSfmadltdGmku6c7i9J1hgAHl48PxZzOrHkXZL
         e6Exqli/OkY15HsuO07tXZoq+eAKAt73t0KP6goyZ9HvJ9h6sURgMSystLFnjnk+vaZB
         GYSPO8mnBLkEc5mJumwhKus/dV0aKSKDqegjY3zr7v9bJtpY7UTXOrkrgreWc0XlW1KS
         bQFFLJ4W09BPX0RPjJupJ8uyL5ftWzmcyNJDxqE+aNtgxokqJpdfoHnxHF6BZd2+Vc+0
         UaU6wHwgidqtXr8L7nP57TRfsAJaNbzZusJKuV3n/A2XvYSa+A+mX5YCw0fwJeQNn4KS
         LfHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGlOVcw7Bc5/u225MoYVh0dPHbJD4/kOi4ww7wOHPFsDyd4uBL/BI+MjEdirgJzjbksNnK0zE8yXs1BQg=@vger.kernel.org, AJvYcCXOV3KD9jyqMm9Wd9atS3T0aRVc2raAL5vkPGgpyn4VwLt6ET2OiOBA1JPWQoVaN6vMTBcjo5oKe775@vger.kernel.org
X-Gm-Message-State: AOJu0Yznen1R487JmD3bY+nUJE4da9nNIcneL2xHWFraMiT3MTcqB+kO
	3tvsf5QG7iyOCE2Y8ZnTpCfR/vGVorrbq3r3gzYQxwbk+q7oXSUi
X-Gm-Gg: ASbGncvS9EgeiT5FBNQYI6Mu5KxRXKq0oefyLdyUCsrB8SAS9iaLyKBXoWOCRvbfv78
	8v4Mm85pdiUQ8EWQEDmsCn1tP+67FlWjpzyoLrIpNi78JTIX39PThIJ8Y5HInA10lFX+1DYW9ol
	9cHjp8mK65VBjH6E2kF4LBRBxQcm4oWuxF2idpfrtflh7IOoKw6S+KG8lf5dMY4pcRt6KxPUVXf
	AJpr8s3Ns+01H1mtDiGGEgtnHepXANgcWSxPMxaNQvT6MuSXyof3gIljrqFfIuEcn8xzLN9DgxE
	t2OKQDYLvzZFHrePzCja8OeVmOcb8ZvpWIRfFHpAGWCzO6CTUTuulA0hEh6cFXfxsEGvGODTXCS
	1s5I=
X-Google-Smtp-Source: AGHT+IGn13wDvrhCbjxdWuP7Ai0Mmx1XcETMxA3SEyux2k86dVwD5n40nX57aEx3i5RAbD7djFsKGQ==
X-Received: by 2002:a05:6a00:ccc:b0:728:f21b:ce4c with SMTP id d2e1a72fcca58-7366e5b53c2mr4923560b3a.5.1741087434158;
        Tue, 04 Mar 2025 03:23:54 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7364d4fd2e0sm4423784b3a.120.2025.03.04.03.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 03:23:53 -0800 (PST)
Date: Tue, 4 Mar 2025 20:23:51 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, bwawrzyn@cisco.com,
	cassel@kernel.org, wojciech.jasko-EXT@continental-corporation.com,
	a-verma1@ti.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rockswang7@gmail.com
Subject: Re: [v4] PCI: cadence-ep: Fix the driver to send MSG TLP for INTx
 without data payload
Message-ID: <20250304112351.GB4101682@rocinante>
References: <20250214165724.184599-1-18255117159@163.com>
 <20250303190602.GB1466882@rocinante>
 <20250304110134.GA4101682@rocinante>
 <f51a60de-65f9-459e-9c1f-dd4f10ed65c6@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f51a60de-65f9-459e-9c1f-dd4f10ed65c6@163.com>

Hello,

[...]
> > > > Cadence reference manual cdn_pcie_gen4_hpa_axi_ips_ug_v1.04.pdf, section
> > > > 9.1.7.1 'AXI Subordinate to PCIe Address Translation' mentions that
> > > > axi_s_awaddr bits 16 when set, corresponds to MSG with data and when not
> > > > set, MSG without data.
> > > 
> > > Would it be possible to get the full name of the reference manual mentioned
> > > about?  I want to properly reference the full name, version, revision, etc.,
> > > like we do for other documentation of this type where possible.
> > 
> > Hans, I came up with the following, have a look at:
> > 
> >    https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/cadence&id=09f4343a59cc2678a3a5b731d16e55c697246a40
> > 
> > Let me know if this is OK with you.  Thank you.
> > 
> > 	Krzysztof
> 
> It's OK with me.
> 
> Can you add an email address of our company as Signed-off-by? Because it
> involves Cadence documentation.
> 
> My company email: Hans Zhang <hans.zhang@cixtech.com>
> 
> Like this:
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>

Done.  Thank you!

	Krzysztof

