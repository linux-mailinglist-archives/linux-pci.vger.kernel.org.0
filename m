Return-Path: <linux-pci+bounces-13197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5DE978B7D
	for <lists+linux-pci@lfdr.de>; Sat, 14 Sep 2024 00:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AD7B288433
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 22:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1275A1474A5;
	Fri, 13 Sep 2024 22:48:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DDE7489;
	Fri, 13 Sep 2024 22:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726267702; cv=none; b=etEc/MpANb/7QyAGd4l6XJLbd8DdMhOQuc6xp2cy5EwxuPV2btgkEb6cRxN8MuIAcBcr4NsrYgFFSEJH6lV70FOlyIf7RvCRhL3TBIfsaKKAGf5uH1ZcO3DmWOv/OwRdp1aOfD/eg/I6/6eLlTRf8Y/k2Y0ePTFokWicCm1gB98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726267702; c=relaxed/simple;
	bh=mB0p8k+QENt0JpksTJORtmIPt7P7ENdKtGc+Rmcm9Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rT9hgVDScVfdPhapWlMLBit9d1+pyvOe3tDdoedQv/cHqge7NRlYjPpUDZYrN1jXGxKoj+uskEsRfhjuqq57UqxKxMPFSYthh8YIfp0+2poR7i68+aRsTJ+EP9urK2EdiMju7gQ1sRXtC2LXXOZh7guuP3ZI6yCkBtYsHRMsfjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so2738680b3a.1;
        Fri, 13 Sep 2024 15:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726267699; x=1726872499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ul0gHpFHDYmMu9xoOqXG6uubCw0jUvTHcGaMEXXBn+8=;
        b=NJbucuPdrtAZ6jqxrBC6M3yUV7SbTyP3lTiYkb9Cu42VLa6ooPw/oMukOnhYf2/lW0
         NFSy5qyYA3BjHfE54JGP7mAfCPkXtqD3VILQiXX2rUw4y6ZJpKN3JvKzEKL5WJwUks+z
         yEG8uNLQQQj4ogv1zymMmNM5SrlvNh9YDRQm7GwCp48sqjIzVCZS8HtpwflCNmfoNJOu
         jUkxUIhX/McXdvy7+oIw8Jl+wmoFvsdzT1glOWqlx3rO3MCIgcVWzJQWGyIO1SisOuQL
         CNuJK7ExVCieWsHI+z10S/SoWYaZBMhuJGn3jyDPPpgKOIRCKF3ytGKBeF6/ioHiSgIP
         UWfw==
X-Forwarded-Encrypted: i=1; AJvYcCUB1oWqu0cgIKdY8mK9m3GtG2mHMjjrjZC3ELXPbyRCiaV1ihmgostFsmtS4gFsKyQHZm2xfpSRr+2ICMLk@vger.kernel.org, AJvYcCUpGD6PRSwTSiRbWfDqIJrlzV1hZSTHwejVZPYR/tKRY/Z1pQmn5/et6rKk1MRPt8x0WAd55Xpm1AVH@vger.kernel.org, AJvYcCWdN2Tlk59FjRdr+RpNeX87YL4uUkhpYX911T1HE1ScaGYFualUW6Gmh6ozjAiT+uAaN2UMgCICKCywBIEm@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+3whfFCx5Iaqw/rKQpb9QKurLZwqm1nn2VYoJ2lLrpMqrT+ey
	8lw7BjogVEIMR5WBv5QBapNzE9zzcsyCV140Xyugox6S9k1URlzz
X-Google-Smtp-Source: AGHT+IGg1LRbf7CqDfVo/odw0z6LCRW0h3ZADW5mFSuTDiXyni8e92Ad8EyBwskX1xWkCpFEmuaeiA==
X-Received: by 2002:a05:6a20:2443:b0:1c6:8c89:88c9 with SMTP id adf61e73a8af0-1cf5e1ae57bmr19195316637.18.1726267699405;
        Fri, 13 Sep 2024 15:48:19 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db49910131sm171000a12.38.2024.09.13.15.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 15:48:18 -0700 (PDT)
Date: Sat, 14 Sep 2024 07:48:17 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, robh@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v3] PCI: qcom-ep: Enable controller resources like PHY
 only after refclk is available
Message-ID: <20240913224817.GA635227@rocinante>
References: <20240830082319.51387-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830082319.51387-1-manivannan.sadhasivam@linaro.org>

Hello,

> qcom_pcie_enable_resources() is called by qcom_pcie_ep_probe() and it
> enables the controller resources like clocks, regulator, PHY. On one of the
> new unreleased Qcom SoC, PHY enablement depends on the active refclk. And
> on all of the supported Qcom endpoint SoCs, refclk comes from the host
> (RC). So calling qcom_pcie_enable_resources() without refclk causes the
> NoC (Network On Chip) error in the endpoint SoC and in turn results in a
> whole SoC crash and rebooting into EDL (Emergency Download) mode which is
> an unrecoverable state.
> 
> But qcom_pcie_enable_resources() is already called by
> qcom_pcie_perst_deassert() when PERST# is deasserted, and refclk is
> available at that time.
> 
> Hence, remove the unnecessary call to qcom_pcie_enable_resources() from
> qcom_pcie_ep_probe() to prevent the above mentioned crash.
> 
> It should be noted that this commit prevents the crash only under normal
> working condition (booting endpoint before host), but the crash may also
> occur if PERST# assert happens at the wrong time. For avoiding the crash
> completely, it is recommended to use SRIS mode which allows the endpoint
> SoC to generate its own refclk. The driver is not supporting SRIS mode
> currently, but will be added in the future.

Applied to controller/qcom, thank you!

[1/1] PCI: qcom-ep: Enable controller resources like PHY only after refclk is available
      https://git.kernel.org/pci/pci/c/d3745e3ae6c0

	Krzysztof

