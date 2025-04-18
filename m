Return-Path: <linux-pci+bounces-26212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5739CA93647
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 13:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10053B4164
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 11:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B98215055;
	Fri, 18 Apr 2025 11:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VehwYp+Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F721D5170;
	Fri, 18 Apr 2025 11:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744974196; cv=none; b=i65tgg32Pbbf1Rs9o1TFjOFtdwIeZ9XNfoKJ3/29ZjkpPtv/z8deaGduOXWklJIMBR3oSq5LWqv0FL4da7cGM4Gsjc/lQQ1NvijCnFMNH5BmN8F95yN7A8qGh3FyUe1RfMl23wrTDws9Yujvk3AF3IA7FFFETVoNAAOmJW4d3sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744974196; c=relaxed/simple;
	bh=PjqyHyK5COfrkquZogeuVG2kH6978BWxx66MKNuvwLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBT2F0KY5/PDK9aLtdQ4zqSrTz6oRkmikOHtPAx+9haLt/yfQA5VGqJ/4xQi6xDPtxIPHVxAypP5+teFoGUgE7PF3+kkthz0quk4dpQRljmNVi9jPl164PP/rfs9BM5G13VB8BQD7qE/N6Eqi/hsNqbpb7CzkuwNxGCDlx1kCsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VehwYp+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A8BC4CEE2;
	Fri, 18 Apr 2025 11:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744974195;
	bh=PjqyHyK5COfrkquZogeuVG2kH6978BWxx66MKNuvwLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VehwYp+Zw0bjkfYwTbzP0I7WZY54cQyqybNTZp0YpLjLtFQ+m2fjW7QBdpilF/fiX
	 bM3axOGj4v9YzwXVzb3xM+Qr/Lf0Rqukc52i2RCb2LsgaLuhtGMBlqOa1bUOCuNjPD
	 GfqPkYxqioc/rNtKFlGXZO7SinXX7joS1LDKIu0Q=
Date: Fri, 18 Apr 2025 13:03:13 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	PCI <linux-pci@vger.kernel.org>, linux-s390@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 6.14 000/449] 6.14.3-rc1 review
Message-ID: <2025041852-unlined-rug-e71e@gregkh>
References: <20250417175117.964400335@linuxfoundation.org>
 <CA+G9fYvz0kujF4NjLwwTMcejDF-7k7_nhmroZNUJTBg4H4Kz8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvz0kujF4NjLwwTMcejDF-7k7_nhmroZNUJTBg4H4Kz8Q@mail.gmail.com>

On Fri, Apr 18, 2025 at 12:00:33PM +0530, Naresh Kamboju wrote:
> On Thu, 17 Apr 2025 at 23:23, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.14.3 release.
> > There are 449 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 19 Apr 2025 17:49:48 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.3-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Regressions on arm64 and s390 allmodconfig and allyesconfig builds failed
> on the stable rc 6.14.3-rc1 with gcc-13 and clang-20.
> 
> There are two different types of build errors on arm64 and s390.
> These regressions on arm64 are also found on stable-rc 6.13 and 6.12.
> 
> First seen on the 6.14.3-rc1
>  Good: v6.14.2
>  Bad:  v6.14.2-450-g0e7f2bba84c1
> 
> Regressions found on arm64 s390:
>   - build/gcc-13-allmodconfig
>   - build/gcc-13-allyesconfig
>   - build/clang-20-allmodconfig
>   - build/clang-20-allyesconfig
> 
> Regression Analysis:
>  - New regression? Yes
>  - Reproducibility? Yes
> 
> Build regression: arm64 s390 ufs-qcom.c implicit declaration
> 'devm_of_qcom_ice_get'
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> ## Build log arm64
> drivers/ufs/host/ufs-qcom.c: In function 'ufs_qcom_ice_init':
> drivers/ufs/host/ufs-qcom.c:128:15: error: implicit declaration of
> function 'devm_of_qcom_ice_get'; did you mean 'of_qcom_ice_get'?
> [-Werror=implicit-function-declaration]
>   128 |         ice = devm_of_qcom_ice_get(dev);
>       |               ^~~~~~~~~~~~~~~~~~~~
>       |               of_qcom_ice_get
> drivers/ufs/host/ufs-qcom.c:128:13: error: assignment to 'struct
> qcom_ice *' from 'int' makes pointer from integer without a cast
> [-Werror=int-conversion]
>   128 |         ice = devm_of_qcom_ice_get(dev);
>       |             ^
> cc1: all warnings being treated as errors

Offending commit now dropped from everywhere, I'll push out new -rcs
soon.

> 
> ## Build log s390
> arch/s390/pci/pci_fixup.c: In function 'zpci_ism_bar_no_mmap':
> arch/s390/pci/pci_fixup.c:19:13: error: 'struct pci_dev' has no member
> named 'non_mappable_bars'
>    19 |         pdev->non_mappable_bars = 1;
>       |             ^~

Will go drop the offending commit now too, thanks!

greg k-h

