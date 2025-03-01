Return-Path: <linux-pci+bounces-22702-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC5BA4AC5B
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 15:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE118188F819
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 14:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6C01E1025;
	Sat,  1 Mar 2025 14:48:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6291DE2C5;
	Sat,  1 Mar 2025 14:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740840515; cv=none; b=QbHRLmhD5J0VdIr1X8T3vqRCRdbCWifXkmZVfe5YVtuBdLWGwthGJ9Ei6CEgk+AkLMTaQ4537LpzCU2sf2+HLKC3ji0OsRL5QzZiwG3FZvFGUcI/fJJptITYi0WtYX5aRkRpVMEo4bxE8F9bIvCsoz+/SLnQxi33kjxsbQec37A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740840515; c=relaxed/simple;
	bh=oEof2d65Y4ijW9SCYkxX17wvrnpghi/bJmR8xi9/hAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPI6zYxvKiQmrU9IXbN0VrGjyUWdzs4a4wuxbaIasTG1qCJLmBAJTz3HKZ7RWW34/vwAlzo/hshsWvvqirnz7XNOJ72QGM/tYrQv/pENEdFLoEW2s1Wd422zY6kQ6lSNHLn1kGVV1hu459OfK3A2NzQ0yXydURTsssTBAJrXQCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2234daaf269so17438795ad.3;
        Sat, 01 Mar 2025 06:48:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740840513; x=1741445313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kxirebw5kDkF1+wRXCoNpE/6TwpkidGg4t4NyZVsJ/w=;
        b=qJJLQVojiU1MtKcK+rc5L8ZATnny61YFsdUdxtLhvWjPespIwUe4Jabx++rv9ej/rN
         5g2wJWlR/M01ejlnA1kpbOVJqvulEDUH+U/3szB338pyhkyjuM192K0qOcHocIxsp4u6
         Cv99XL1D6BrgLjV3pYGK1MI+iNciYrBGWfVoXSrvHY9ceAPGD8jJZFo5eN3S7IXdYBS3
         AaL1tH80iGq9TxtKNasDTaOv1/NVdMvzH2grc0GSf1jWHlnUQWRoPGgcP/BG7ZMSRleB
         RxvQx12dT8foaR4D+ih4SlqSTZi0NpKvH9STyPNHWc2XnirFa1Dtr39RK555VimWGUSA
         j53A==
X-Forwarded-Encrypted: i=1; AJvYcCWJVFVpIboMiU+V2o+MLua5+msTMd7HPrD4p9V7hNLrxkGH+SS2oIu3h9OA3U7slYVmVadmP5bHGzpcEeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsYWjbDRfg2cuBLQHd4DQW2EGPs/ZOKYhm+Eam2VCNnbu30Hyz
	hEXXO73+e8Rt74TyTOi3KlWIJ1WnLgw629iSC0mrK+91opkbajrwXbXAwlpITSE=
X-Gm-Gg: ASbGncuevfHbMN/dMQ+75LxNM6BlLU80oyJef08IAOTYZEbECc7/4aA0zxhByOiTv+A
	cjnnOsuE03+OZeeLzFxH4+Xb7mFLmWBva+0jJdDtApjLT1x0WSr+Js7lHflMBdn+CsZXvy/hqwI
	6TKKUxS3pMWe92PVPaQlDXKM6r+3O71yTvtzMG8CtDV6AAYN44qBS5QdA0Rob2Hd9I0e0jrBoSz
	fh+BSCEIRjzMhcLdoNGuecPIlWB2JR2Sd12pq0bsKQn3FdGeJw0bQiugcgfaoDmVn/M+fGcOrEF
	BCln6O+18JXcNmvDVQCtLrIUYyvyNkQHUrRj1sWMmEA9qkg2koM/fO4uczqPCE9up0V8FLl/dbi
	+pqI=
X-Google-Smtp-Source: AGHT+IHG4g0PEDW0krzlx5kdodp+yvsIBSjDMcx+eciBkPw4wgN7QvM+HqAQBJgdzNXvy+rEnV1R2w==
X-Received: by 2002:a17:902:fc84:b0:220:d28a:c5c7 with SMTP id d9443c01a7336-22368fc267emr124814875ad.21.1740840513441;
        Sat, 01 Mar 2025 06:48:33 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223501f9d8bsm49585955ad.81.2025.03.01.06.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 06:48:32 -0800 (PST)
Date: Sat, 1 Mar 2025 23:48:31 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Andrew Murray <amurray@thegoodpenguin.co.uk>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 0/8] PCI: brcmstb: Misc small tweaks and fixes
Message-ID: <20250301144831.GA846783@rocinante>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214173944.47506-1-james.quinlan@broadcom.com>

Hello,

[...]
>   Six small fixes and improvements for the driver.  This may be applied
>   before or after Stan's V5 [1] on pci-next (they should not conflict).

Applied to controller/brcmstb, thank you!

	Krzysztof

