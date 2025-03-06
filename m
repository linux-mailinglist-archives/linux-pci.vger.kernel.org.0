Return-Path: <linux-pci+bounces-23078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B636FA55ACC
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 00:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4652A3A3C61
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 23:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7095227CB3D;
	Thu,  6 Mar 2025 23:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hjvu9ZPb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473E72054FD;
	Thu,  6 Mar 2025 23:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741302721; cv=none; b=N4r6LA4d3NS7gHwGyMITzPuU6RlsLQWdODkZFmkMzR46YPQP6dsD+3D1Ml1esVHAaFMEQIdI7ZusYpdrb0FLvmnAXgV6suwwYytbi7BIAr2f2c6fHVxYgr3SgsPH3d3c9BT/62bPgzkFOF9yybemUdyMI4OSF6uf7f3zNoYaeic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741302721; c=relaxed/simple;
	bh=jeTCp9djGS7SKzrcM6HBeX1BuHmA4JFlGfZiUsL9kBI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=k2fBHxEV6NLJImIcyo4W4QMCQPwbmKaqa+9gyjYbYdZ+zFK9O0vH87cGcwBlFSl/dwJi+ktIUL7GoDbf2RrdfcSiNnPu41xan5B/v8DstFrUdArTvzix+j8EGusOvbSZJsAAclHF+U4CDZGr9+Kj9FNDK4C14A+UXEMCy7NY5+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hjvu9ZPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882A1C4CEE0;
	Thu,  6 Mar 2025 23:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741302720;
	bh=jeTCp9djGS7SKzrcM6HBeX1BuHmA4JFlGfZiUsL9kBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Hjvu9ZPb8Ih4sgBRxpCKhYpJvRzKnDC/IQFmcmSG8YNd6S6bQ3ZkVDQ9MnHZcTMJF
	 g+uZOwocGvVwGE8vxOoBElKbukUuoyeSWigQcYqlkRL5wMDHbnAVc8jA5g+kcseh8d
	 pZkS3oGeZ5a+pCXF35usA7hMTnE/basrPeZp6olIuxOMXX7TlKVCu5semrQBHJ++kG
	 P1QuU3kwIRfJTvRPel8tyMv7cLS0X8GbeehvDEs01LK7RJsKGKiWi4lklnVFtZvm5Y
	 W1S4GWPw7fRn67PngAbLbU8TlQKzjihe2hAYTRSMesoD068LRto5AclW8YwEFK7G5l
	 2NbUW0Geh5HEA==
Date: Thu, 6 Mar 2025 17:11:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Alistair Francis <alistair@alistair23.me>,
	oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [pci:doe 3/4] drivers/pci/pci.h:464:70: error: 'return' with a
 value, in function returning void
Message-ID: <20250306231159.GA381539@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202503070631.aZNf56QY-lkp@intel.com>

On Fri, Mar 07, 2025 at 06:33:08AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git doe
> head:   d7706150d71eca96b6eb8865152bb9fd9830e9fc
> commit: c4cef7f8f8202238f89668e1c0d013a94c0069fd [3/4] PCI/DOE: Expose DOE features via sysfs
> config: riscv-randconfig-001-20250307 (https://download.01.org/0day-ci/archive/20250307/202503070631.aZNf56QY-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250307/202503070631.aZNf56QY-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202503070631.aZNf56QY-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from drivers/pci/quirks.c:37:
>    drivers/pci/pci.h: In function 'pci_doe_sysfs_init':
> >> drivers/pci/pci.h:464:70: error: 'return' with a value, in function returning void [-Wreturn-mismatch]
>      464 | static inline void pci_doe_sysfs_init(struct pci_dev *pdev) { return 0; }
>          |                                                                      ^

I dropped this "return 0;"

See https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=87f7d1a95d2f

