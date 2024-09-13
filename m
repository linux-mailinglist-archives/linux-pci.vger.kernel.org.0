Return-Path: <linux-pci+bounces-13198-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD81978B81
	for <lists+linux-pci@lfdr.de>; Sat, 14 Sep 2024 00:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19C21C216BE
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 22:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F21158A2E;
	Fri, 13 Sep 2024 22:49:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724101494DC;
	Fri, 13 Sep 2024 22:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726267785; cv=none; b=H4EZnlQhjR3us+M71VNENrRFxtH/e9B9AsFcsq4uok2Bd5dSFnoxjvHYuu7ZciLi7mLGrBvRkisj8qqHWEAbP8V26v6YF0DlYZ964GrYSe+g/zAJgCCFBD0qEea6ST1Jk4Ruuj7becDvRoBM6BeqsVdxVwNd3j5dHbILURjd2mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726267785; c=relaxed/simple;
	bh=g8Qb060ypz4qws5lQ7TXDGnQom5ZoNetKSiXPaJde7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXq3mqKdeHYh/WpRe73Te9TPlOyXVs3zxswvWjmsT6rMqNfS/99LvRg/ccfL8QNTMdZsIvDrqQdmPdI5RQq3XQjXzwmrHBHf97du3HnBTZBhOfUex1MfWOv+kK5RjWsj0ouxzt3OcyvgdVy/wgUa+/AW/wGk3RKlLLsrwqnTETA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20792913262so2544065ad.3;
        Fri, 13 Sep 2024 15:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726267784; x=1726872584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvjD4P7L33hm+SfH0+CG3X96DfNJu81XzBnavQ84R+c=;
        b=BRNT/re47J+XKXjrfOg89UNDQioP2IZWIGHuriTvJxjEP+QH7AlCDf2rjZfpa7zKea
         2GeWDtVBxOcXvXLI/UAFxT81XtefIp9uCSjKNQ2fmL0HNW/YIRwD0skI4vvpPfoctX/3
         IT4n/91ts/zB5GPKpXsIzf0lM6xCYiXMeBMX96CE86d9npQbx2cRnbr59iIxJu7HjHkl
         6VdJ+7RDM12zBVadVgUpyYp26KBtFNLl2IEIMhK+h91vAhfCM+CEK8Fu+85GrHwVee9K
         Nq1QLTi4FMk+r2oCVqW/UTrlMjdLRDCFX32jL8T3snOyw6pj33tSXNoNvz8cXFzbFboY
         gN2w==
X-Forwarded-Encrypted: i=1; AJvYcCUVjymYri+Tx9RbYlGZTS9ajprN3erFREnPF4LJ/Ig+t147OhatR49VYdRrBVQtwS6WWQXQH8scQV5Vgj9t@vger.kernel.org, AJvYcCVY5Igjh+ZM2cbxfGwxW1zxChyPhYgnlGNq4qjtH2vrIITeTa6k7reTYoEOgxDkmjh3SrUaGSihtbH0lRVH@vger.kernel.org, AJvYcCVqzMQboarBGnHelSV+jgi5DdvtFZUfOus1VLhe225ebwnqosRmd5uYoPYnIFDyh519SobJwqbh2nABUwI=@vger.kernel.org, AJvYcCWSce/U0iXFE3q/iR6znJxWTHVFeKHqkB5/DCn82Y+KgI1bJyTxPhmii2nZ3hSrifpMuBy0G+0wW6Ya@vger.kernel.org, AJvYcCWaSZy8lugj2aFXpiK9O9YU/uohIvDPF3nbpiG5qYtpMMo9AY9aajNa+PvkuJNFtEknBWTMQKp72RUuAj3V9r0aKQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsF3aEfwEgOEHS4ip4/a09uqNWJJEwN3JqjpzbALwHglF5irO+
	zAewYX/YNkPNV9ruUMCAV75lXhfatrpHRCXd3BH7aHciiUCoDKa+
X-Google-Smtp-Source: AGHT+IGffhv4YzRcwOzc1EUmqXH+8+XynznIDD+5xBCaM4EbCHFFItgrUN1MptJ5qWG02Y+hhYkfhA==
X-Received: by 2002:a17:902:ce86:b0:205:4885:235e with SMTP id d9443c01a7336-20782a69abbmr69743905ad.39.1726267783736;
        Fri, 13 Sep 2024 15:49:43 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945da63fsm1217015ad.38.2024.09.13.15.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 15:49:43 -0700 (PDT)
Date: Sat, 14 Sep 2024 07:49:42 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: manivannan.sadhasivam@linaro.org
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Chuanhua Lei <lchuanhua@maxlinear.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, abel.vesa@linaro.org,
	johan+linaro@kernel.org,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>,
	linux-tegra@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v7 0/4] PCI: qcom: Add 16.0 GT/s equalization and
 margining settings
Message-ID: <20240913224942.GB635227@rocinante>
References: <20240911-pci-qcom-gen4-stability-v7-0-743f5c1fd027@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911-pci-qcom-gen4-stability-v7-0-743f5c1fd027@linaro.org>

Hello,

> This series adds 16.0 GT/s specific equalization and RX lane margining settings
> to the Qcom RC and EP drivers. This series is mandatory for the stable operation
> of the PCIe link at 16.0 GT/s on the Qcom platforms.
> 
> NOTE:
> =====
> 
> I've taken over the series from Shashank based on the discussion [1]. In order
> to apply the equalization/margining settings properly in the Qcom driver, I
> added the first 2 patches to the series which inevitably touches other vendor
> drivers also.

Applied to controller/qcom, thank you!

[01/04] PCI: dwc: Rename 'dw_pcie::link_gen' to 'dw_pcie::max_link_speed'
        https://git.kernel.org/pci/pci/c/2cebf68a24ab

[02/04] PCI: dwc: Always cache the maximum link speed value in dw_pcie::max_link_speed
        https://git.kernel.org/pci/pci/c/19a69cbd9d43

[03/04] PCI: qcom: Add equalization settings for 16.0 GT/s
        https://git.kernel.org/pci/pci/c/d45736b59849

[04/04] PCI: qcom: Add RX lane margining settings for 16.0 GT/s
        https://git.kernel.org/pci/pci/c/d14bc28af34f

	Krzysztof

