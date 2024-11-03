Return-Path: <linux-pci+bounces-15885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC659BA7F2
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 21:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D344C281388
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 20:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F531494B3;
	Sun,  3 Nov 2024 20:31:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5E770825;
	Sun,  3 Nov 2024 20:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730665872; cv=none; b=RYRNQXAj7svHKvWT/s5hN8ZgbC4p0H9sMvGH807wryWV+nmQ80S2m40+lJys6APZwp+bb1JpkoqevJe9Zx6IgXTIEkkwUByVcjam+DIUMo4CtKrdecXSk9XAy/NYD5viNcsm/KNYuj+zPXKdQm7tk6LOI7ukAtdH5rJYNENxknw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730665872; c=relaxed/simple;
	bh=UAry3lKNUwyj0oFCm8vVfhqS8cWkBDeEa8VZoXQ4tao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOb3kAFkrordMRnKN786v6eTIu8ncJoT1uzjo3o+71h9h+tP/GD8hCLWrzyOSeK4nERm5Lu37XLN5ndEsZoAYAU6vB9e6VynHK8KCnPPpqOwWAsSAEAtHLGZDC6UKIIiQmn0kp0RhOFTj/dH3swnPaduyOGm27nspxvp1LdrYXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-720d5ada03cso2187397b3a.1;
        Sun, 03 Nov 2024 12:31:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730665870; x=1731270670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTqpDnttes5ii45n7wC5WdRmTqBtUt0Tb3DPQNqk5so=;
        b=b1CMJpspHfygCi6vhvU0USq6KZUu0+Y1jU+G9RISy/lvXeUP+AESu9Aas6kvR4cy5i
         550g6gsETuOoouBi4Wey+lxLzpCNYsZdtrKyEDOYUzbliQUDcLXbMusAkPxBrRHODrul
         HwdgyI6lhi+Hngk3aNx2DqhdGHYizf0XkuG0UNycOVKde7A4sz22XcaVN3XqYcCXZj0V
         YdFw7JU1lR28yr0IIq8zJ9Tq+E6Q59Qp7+12B77L0c1OVOa0Egptw8MsIEcNsz28Th8J
         pUu+tUtNlqA3fR54FjM2nJJy/dVpJgk1mC2FGySM2LlBe9EpcSqkRMspVxK4xngh3zM0
         dfcA==
X-Forwarded-Encrypted: i=1; AJvYcCUS1Qivnh3WHhl5j5ws38xEuHXXaojynrLr5ZLQoMuuojWqgEN7Alrv2LRSfXpt0RaJSy+EJ8ZiEArEJR8=@vger.kernel.org, AJvYcCUzoX6bsd/h9mPH2YGSgB5ucGo9K2Bk7SWAUBIqOBf0xPyUCOdpoq+XdyDxexL+kwF50sUAEeLNhi25@vger.kernel.org
X-Gm-Message-State: AOJu0YyG0LgTj6KCQUXEsNh+w63tA3BJxs3RIQBOZFSBGJ+mkfZmtR6G
	8R8cKPUqbe7TPRYtvlscocuD0b8U74XAEtgEfQHO7ar3IigEpdFCXrJMkSDA
X-Google-Smtp-Source: AGHT+IFH8OtrcPu4u3zbiHDmGStrfT55bwXN1Fh1BJvA7tScvO1jgw1DS196nETuk4einja8hoKWaw==
X-Received: by 2002:a05:6a00:3cc7:b0:71e:8049:4730 with SMTP id d2e1a72fcca58-720b9bb4f66mr20112733b3a.3.1730665869763;
        Sun, 03 Nov 2024 12:31:09 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc316a79sm5985395b3a.205.2024.11.03.12.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 12:31:08 -0800 (PST)
Date: Mon, 4 Nov 2024 05:31:07 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: manivannan.sadhasivam@linaro.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	stable+noautosel@kernel.org
Subject: Re: [PATCH 0/5] PCI/pwrctl: Ensure that the pwrctl drivers are
 probed before PCI client drivers
Message-ID: <20241103203107.GA237624@rocinante>
References: <20241022-pci-pwrctl-rework-v1-0-94a7e90f58c5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022-pci-pwrctl-rework-v1-0-94a7e90f58c5@linaro.org>

Hello,

> This series reworks the PCI/pwrctl integration to ensure that the pwrctl drivers
> are always probed before the PCI client drivers. This series addresses a race
> condition when both pwrctl and pwrctl/pwrseq drivers probe parallely (even when
> the later one probes last). One such issue was reported for the Qcom X13s
> platform with WLAN module and fixed with 'commit a9aaf1ff88a8 ("power:
> sequencing: request the WLAN enable GPIO as-is")'.
> 
> Though the issue was fixed with a hack in the pwrseq driver, it was clear that
> the issue is applicable to all pwrctl drivers. Hence, this series tries to
> address the issue in the PCI/pwrctl integration.

Applied to bwctrl, thank you!

[01/05] PCI/pwrctl: Use of_platform_device_create() to create pwrctl devices
        https://git.kernel.org/pci/pci/c/d2b6619e7419

[02/05] PCI/pwrctl: Create pwrctl devices only if at least one power supply is present
        https://git.kernel.org/pci/pci/c/5f2710a4c275

[03/05] PCI/pwrctl: Ensure that the pwrctl drivers are probed before the PCI client drivers
        https://git.kernel.org/pci/pci/c/4c963d4c13b9

[04/05] PCI/pwrctl: Move pwrctl device creation to its own helper function
        https://git.kernel.org/pci/pci/c/73ae23a6af78

[05/05] PCI/pwrctl: Remove pwrctl device without iterating over all children of pwrctl parent
        https://git.kernel.org/pci/pci/c/5ccc52fd1e5a

	Krzysztof

