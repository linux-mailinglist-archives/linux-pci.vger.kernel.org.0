Return-Path: <linux-pci+bounces-19934-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D57EA130EB
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 02:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67329161B0A
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 01:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7F228E37;
	Thu, 16 Jan 2025 01:47:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BDECA4E;
	Thu, 16 Jan 2025 01:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736992071; cv=none; b=jCzJXObo1VMbzbknNoATTI2aqYu6jSH0rYhAJwLzYvFmSWnP1JwKsxS7vtyrEdrUok+JWhsCn1Il5tbrNBN+rVDWTN30rFgMxPYxnf9/fYwMF8TzPgSyEgEp1NobUN4zPwttKyyv8truxwoJB2FU913WdGKyG7CVdJu1mfewQZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736992071; c=relaxed/simple;
	bh=4mQyNmO8TAipm+1tJsd/yT/ncWCjs1Dsr5OhE7y2EOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXRtAvLjl30OV7HVIgJu/zTMGEL1Inslyl0s0V/8BnSUebUfB5hPzQR1/IEKBPj/IikENn+UkICK0+fh2FBTvIjNqMUYki807SZaLLV5y8mxz2sr3jfrHrOWnNPL/Ujljn1SzXeZAdT8PtChXg44+aAV0/atv7K8WOJtdtgJ/4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21661be2c2dso6019585ad.1;
        Wed, 15 Jan 2025 17:47:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736992069; x=1737596869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QNPVQXecLokCMBNU0Zpch+WkI0Q+RjsM7OPeRvuUd8=;
        b=Hzfx2NAGUMteVFS4ObaOBuOYlVL4nCcSJgiTtaITCi7LYcnvjU5D6By9i1Tii2fDTd
         23v/UY835A9roS32XzQmc90CNP6pbj/z+AfT5jUQ8vm/Ze9pBAdQZws2g047YB9VVxQz
         sabUJCWgPE3NvHekJULSNvJFMCwvLlaOK+h6SuotPMy7kpwiyAyONM+h3Do5SsFOPXCf
         1WwAOvqPlc8m3T4OWgh5xfwUH6UATsuSa7HII1Gq0yyFsNvt95NOTFN7olnqigkPd502
         n8cPZLtgygreiUXQgn8QYM0gFh33t32dxJQj8LJg35O6EGBG94D+GRtJP6s16FIh1+RO
         Rm7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAYM7Q6hf9i35Envczmf2Djl7KI0nsXYtHrJMZUmsIBpW7zz2oInETEtLvtcfIN5fcbx7A3vjzZiBn@vger.kernel.org, AJvYcCWpT25pWVFXXz1Z+wGjfDVQ9aPcqb9mX/uzncxolooBOKkEsd+US0emOZ+3ullKjcdZYbIY/9Cb0uhoRQHH@vger.kernel.org, AJvYcCXaTsln5MVBpDH/tdU2wHH9dMeOAOX8SOkQ4xOHWIZc4dsE3oIcHDCucH2PLESn7DlcgOWQ3sGSFt64@vger.kernel.org
X-Gm-Message-State: AOJu0YwIo8J+4/ksBdww/x0n9qJMf8Kn8VlIqmDeIr2mQhgp6x5ArSs0
	6gBz93qL5Vt5lFhN+DJkG23EQD0fRZvPToc+2OjBbeqPnkRBPQVC
X-Gm-Gg: ASbGncvIlP7mBAzOHFA1pzVm+D8iEJe+hbKrkuTu8BoB63xFQ4dotnC7aQGUcBTpkf/
	JXJ8FUzhgdSOVpYK+AE8DbVRwVLYGK2pAmVgjIK8HVTqGSxWounLlQT1bV5nvmoStM084iy/QuT
	aimhHY6ZFHQBmDHAfEVxAvMNiDRYoeKvZoEiBmAh1l6Pyl+YvWjDil0EzrnynXYBYPBWwTH1zLT
	FNpwAiOfW1lioaysPiJQMCTedmCg8y5XpIaFBlG5Y+/B/wCJIPkoYJHM7N2+lqKhuwIyi4R0TcL
	RpWzTEwH/KVfhjQ=
X-Google-Smtp-Source: AGHT+IHIPg+1+HCTsuijQC+DWu9OaoAsxoCVaqGsJ9zBPENZpCBH7mo8AWX3+7KImg14FW/XnuOBQg==
X-Received: by 2002:a17:90b:2642:b0:2ea:aa56:499 with SMTP id 98e67ed59e1d1-2f548e9aed3mr41058488a91.1.1736992069406;
        Wed, 15 Jan 2025 17:47:49 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c1ccf46sm2071655a91.22.2025.01.15.17.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 17:47:48 -0800 (PST)
Date: Thu, 16 Jan 2025 10:47:47 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v8 2/7] PCI: dwc: Use devicetree 'ranges' property to get
 rid of cpu_addr_fixup() callback
Message-ID: <20250116014747.GB2111792@rocinante>
References: <20241119-pci_fixup_addr-v8-0-c4bfa5193288@nxp.com>
 <20241119-pci_fixup_addr-v8-2-c4bfa5193288@nxp.com>
 <20241124143327.6cuxrw76pr6olfor@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241124143327.6cuxrw76pr6olfor@thinkpad>

Hello,

> The newly added warning should be mentioned in the commit message. But no need
> to respin just for this. I hope Krzysztof can add it while applying.

The commit message will include the following:

  To expedite deprecation of the cpu_addr_fixup() callback, warn its users
  if the 'ranges' property is missing from the Devicetree or the address
  translation information is somewhat incorrect.

Let me know if anything needs to be changed.

	Krzysztof

