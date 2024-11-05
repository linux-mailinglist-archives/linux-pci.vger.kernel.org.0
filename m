Return-Path: <linux-pci+bounces-16019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C25C9BC1DD
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 01:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30DBD1F225A3
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 00:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE66383;
	Tue,  5 Nov 2024 00:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCjxpZ7c"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2378FB65C;
	Tue,  5 Nov 2024 00:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730765528; cv=none; b=IC4cudCZ7ZN0LP+LLQMTl94PKKp4TsJyPMY0klHLbe7NxX1qb/lXC+x2uHBFIsq+XWRFvGcnsxx7vdnzcwmEBpJyju+MGrcbPLHq1Ggx7hE3dBnz/cF+CnxqRjnX5gX/bYGxUZmb4+ZbEGyutU7grbTrHQLcZZfKxt72hDdCHcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730765528; c=relaxed/simple;
	bh=8s123z+scoMed9PWx1Biv+IXZ2kOI4lB+0FzIru1EPM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Om4sLyonC8pCkJ2M1ZwSp6DUbcVYJXPFWEj/K/4mtxFL02TBW7ldoS+emDf79drrKyMf1XQMArNpuNTsEA1ykHVZGSuR7jNCL235DnnCVnSJea5/w4Gh+8QmB+R3x750oAyPHOaSbLTyMYHfR/R+0mA6WKr0C053DbMW3KC7tIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCjxpZ7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF328C4CED4;
	Tue,  5 Nov 2024 00:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730765528;
	bh=8s123z+scoMed9PWx1Biv+IXZ2kOI4lB+0FzIru1EPM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TCjxpZ7cwLyzHAZT25UzA5zCfJJ6O5QeWw8H/8+ocXqmqPm4ySVHyQM0C3sJMtfNw
	 KRqKrWsU0YoZ+m6Ob+MR19yxLPfgrpPEhOV72rIlt764kUVQ5SQEmc5ROI71wZyTIp
	 sK2C5RWvyEFV38o5dLKV1oxl0uOfPwjhTO3K8wuW4+D5ZQ8s9/vkLf/Ug0FTxzUFtt
	 yugV1IZmpUeGzupeERQ+d7UazIo8JD7TMRaor4K25ArXkTFUTjaOGBuOPROE8zB5Os
	 A8yMiRkA2ZTp0LEPQAsnOECw4OEZE+vd9woW8uPgqEXM9eqomXF7xyztjg77dKeXiw
	 KxcAFqY9r7xDA==
Date: Mon, 4 Nov 2024 18:12:06 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: manivannan.sadhasivam@linaro.org, Bjorn Helgaas <bhelgaas@google.com>,
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
Message-ID: <20241105001206.GA1447985@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241103203107.GA237624@rocinante>

On Mon, Nov 04, 2024 at 05:31:07AM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> > This series reworks the PCI/pwrctl integration to ensure that the pwrctl drivers
> > are always probed before the PCI client drivers. This series addresses a race
> > condition when both pwrctl and pwrctl/pwrseq drivers probe parallely (even when
> > the later one probes last). One such issue was reported for the Qcom X13s
> > platform with WLAN module and fixed with 'commit a9aaf1ff88a8 ("power:
> > sequencing: request the WLAN enable GPIO as-is")'.
> > 
> > Though the issue was fixed with a hack in the pwrseq driver, it was clear that
> > the issue is applicable to all pwrctl drivers. Hence, this series tries to
> > address the issue in the PCI/pwrctl integration.
> 
> Applied to bwctrl, thank you!

Should be pci/pwrctl.  bwctrl (bandwidth control) and pwrctl (power
control) are quite different despite the confusingly similar names.

> [01/05] PCI/pwrctl: Use of_platform_device_create() to create pwrctl devices
>         https://git.kernel.org/pci/pci/c/d2b6619e7419
> 
> [02/05] PCI/pwrctl: Create pwrctl devices only if at least one power supply is present
>         https://git.kernel.org/pci/pci/c/5f2710a4c275
> 
> [03/05] PCI/pwrctl: Ensure that the pwrctl drivers are probed before the PCI client drivers
>         https://git.kernel.org/pci/pci/c/4c963d4c13b9
> 
> [04/05] PCI/pwrctl: Move pwrctl device creation to its own helper function
>         https://git.kernel.org/pci/pci/c/73ae23a6af78
> 
> [05/05] PCI/pwrctl: Remove pwrctl device without iterating over all children of pwrctl parent
>         https://git.kernel.org/pci/pci/c/5ccc52fd1e5a
> 
> 	Krzysztof

