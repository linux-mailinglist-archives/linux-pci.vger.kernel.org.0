Return-Path: <linux-pci+bounces-22406-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F445A45612
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 07:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D299167D98
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 06:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DCE267B77;
	Wed, 26 Feb 2025 06:53:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2625225E46F;
	Wed, 26 Feb 2025 06:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740552829; cv=none; b=BdJzd3ng2h6i+VHhZHN0CzTzd96IJUKTWzxKsrLAWfUsN1ILo48uklsJpcIq4vufDDO3KxejC1cVukYCVkXRcohzQQ7ZYNlda2mjzNILJWsxKmIrKp6AXvvWZJ9i+rNzmSkpS3pfX7YSUygtv9O6h61S/ALVnc3TA6Pw1RCjYB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740552829; c=relaxed/simple;
	bh=cnRAgNJRCc6VDZ8tFxoYsWu83A9Bi/ovMzqPefKNEiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWqtySb0bG62foyROMgBkJ6LtBzGF/IuIu3YatwCrkPS7faWCEaQJPVNctiqhhuDMt16O6oTUKW2v8FCcJV+3f+07DP7shqU89g4VWfb8oAPoAwoysdln5pQLjGsy5+8VnfFdoZobXTQ71hlBz+7cwujaIP0Ypu9vg3n03RxVko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220c8f38febso135103775ad.2;
        Tue, 25 Feb 2025 22:53:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740552827; x=1741157627;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFQy5yv8F0Ur4ktKjedfp6/xfewAB3bA5wImrMkzGvc=;
        b=UkXFOPKoMIfb8h+NS91R5uRE2q0dZpHZV+ApPJjzqcuGNfeh4OEGK93P7oz9F7RiXY
         F4mBAyJLRVlvO16quljFS5jUVGMTjqisIYlE6FXZAPgiAHXRQFFnJPUCz5Etkt12I1M1
         nBOh+h39JCCUWcalB3pUDYd2DHHGfe/A24Q3I8XCYt7JGP/SWLbIRCy7mLRhUNf4X34F
         I79vPiResSn0ATkRese5W+OLWvLwkbxgFROI295yKaXAbZ49MWCeCqHRfL2KcJQ3y0+Z
         kBBVkM4NoCR3uapgxGRqbQn/hTaXt+sZjgzYpTThODbo9F1GSqaAu76VrD28yhaK/qRg
         aZoA==
X-Forwarded-Encrypted: i=1; AJvYcCU+QpAXTabdCAyOXbxg3vdk5w5cywmEw/Q0G9F1NpIFycwuDYUDTRsIqJN+RoH8m4QZmUfSXKXbsLZu@vger.kernel.org, AJvYcCXeGRs+NZEVxrBzPtqJN2+1aB6Pb2fttBaRqWQOa51gq7gzzovPU3ojlMYLwQPXX+H9LyYkmnH0ppO9IN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlJZ2E3WA5B+4WMgSAU7pt3dWxSK2E7ti6pztHESPb/Gi6hd7y
	t1gkwfAYzBybJVFSKwYFSlX83K3+hZoQqkUpO6n3feJpQIT6gDw4
X-Gm-Gg: ASbGnctFhe22ZlCq4/Svqa5YJdZKa/hETFCf9LzgP5BF9x8MmYlI7QEMyjV6c+W+ixa
	tUhqsaBR/q834RhG1g7sCv1BWgshmK8Km6+7HVxypLdJuD13oX8PzVgWf6rMAIk4IWUVfYJThCk
	uxbAUFx+6nHksrm48iO21elC7PaoxYhdr6DcoeHx0WHu0ma/Z0iGuGCmBjXDuo59UtH4CSbOXjb
	a9wCOxtk+HR7ubTov9dZbUUG1Lh2w4v+1HdCsdJuw4+F6lvmK47xN3k+lZzXzLghafAS+iXkx+J
	BLoxxPcwgWqVJujMNjUuS12y2Ars/vfKTH+tqf18OKEmXKbk6Cx31+i2mLib
X-Google-Smtp-Source: AGHT+IGhhIvtnfl9cbWSjvM/0ifbg6NbMjqNWOrw/CwF3JzbhedQDCrLNQZfwrUSiOsURmZqdxzWbQ==
X-Received: by 2002:a05:6a21:6d99:b0:1ee:5d05:a18f with SMTP id adf61e73a8af0-1eef3daaa38mr36546833637.35.1740552827377;
        Tue, 25 Feb 2025 22:53:47 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7347a6ad32csm2701346b3a.32.2025.02.25.22.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 22:53:46 -0800 (PST)
Date: Wed, 26 Feb 2025 15:53:45 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, shradha.t@samsung.com,
	cassel@kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc-debugfs: Perform deinit only when the
 debugfs is initialized
Message-ID: <20250226065345.GB951736@rocinante>
References: <20250225171239.19574-1-manivannan.sadhasivam@linaro.org>
 <20250225171239.19574-2-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250225171239.19574-2-manivannan.sadhasivam@linaro.org>

Hello,

> Some endpoint controller drivers like pcie-qcom-ep, pcie-tegra194 call
> dw_pcie_ep_cleanup() to cleanup the resources at the start of the PERST#
> deassert (due to refclk dependency). By that time, debugfs won't be
> registered, leading to NULL pointer dereference:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> Call trace:
> dwc_pcie_debugfs_deinit+0x18/0x38 (P)
> dw_pcie_ep_cleanup+0x2c/0x50
> qcom_pcie_ep_perst_irq_thread+0x278/0x5e8
> 
> So perform deinit only when the debugfs is initialized.

Good catch!  With that...

Reviewed-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

Thank you!

	Krzysztof

