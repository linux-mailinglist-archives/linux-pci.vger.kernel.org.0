Return-Path: <linux-pci+bounces-6959-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C69BF8B8D4A
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 17:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76A901F2125E
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 15:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED0A12F5A0;
	Wed,  1 May 2024 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKd5kWRV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E2712F395;
	Wed,  1 May 2024 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714577861; cv=none; b=QsaEjB28UVIk3O6MnUo0dFx7Cel7EgZpWwPwoZlxJ8F/h06RbsWfEXBZxUBNMb9M+RxbOqBkn+t7Xt4f7EwxuTed6cza0Q4stdx0KFiyj2Bi+saJLjvResYNDqFZhuG0Oc5Ty5s8nzUKFD5vZS2wbmUiN5E/JUp8zf5XH4bz9RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714577861; c=relaxed/simple;
	bh=Nx+ASExoAjGZ0n554bHrH9BRmqUf4KRCywOGEdOHt1Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IrMhUUsVVStplxogd6AcwqtbHUnO2GYh6O4exrDSiB58mz4bbv5HHN15HrX/O0DHUEbAkn1qFG1J4Lj2wyOyLG1rKCYLeTvg0V1mcq/Huns2V3+z/DWokwx1gy4WYGF5/K6J5/SOvUBKyUlhmhbci/e0LxnEnn4wW7BK7j95/CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKd5kWRV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B55EC072AA;
	Wed,  1 May 2024 15:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714577860;
	bh=Nx+ASExoAjGZ0n554bHrH9BRmqUf4KRCywOGEdOHt1Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=bKd5kWRVCgg5bJmt/O9bOAQE9JmNO8JEuR/1M5tNqg074cdLkl0ESqnQBzN42loxI
	 I2xIQQORMkMY+6/HMZMlYhXWbYdlmXeklW4Os8cuNNoaC8vXsoMklqPYpA1LiRHZwp
	 6Mrh6fz+gS3F8p5llEhNkeSxH2za48RUUtsezXcqix4NgcxYMHV18exCDYHXbFLRgH
	 Fel9m4BFMr6FeOrSjUz91fVW8GcnLBXwvLXfaADOFs89/gB1qlKuwDO75zmjzKr9Ky
	 xNOeDQ9cYgRqA4KeGb03PCc8b91PRNVG+IpCssW/IRdaKoeBY5wooyMlLhYjBX0GNk
	 MdFHYSRs6F9Og==
Message-ID: <91fe797284f433a76bdc1f804a6d86e0077a905f.camel@kernel.org>
Subject: Re: [PATCH v5 1/4] PCI/cxl: Move PCI CXL vendor Id to a common
 location from CXL subsystem
From: PJ Waskiewicz <ppwaskie@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org, 
	linux-pci@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
  alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
 dave@stgolabs.net,  bhelgaas@google.com, lukas@wunner.de, Bjorn Helgaas
 <helgaas@kernel.org>,  Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>
Date: Wed, 01 May 2024 08:37:38 -0700
In-Reply-To: <20240429223610.1341811-2-dave.jiang@intel.com>
References: <20240429223610.1341811-1-dave.jiang@intel.com>
	 <20240429223610.1341811-2-dave.jiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-29 at 15:35 -0700, Dave Jiang wrote:
> Move PCI_DVSEC_VENDOR_ID_CXL in CXL private code to PCI_VENDOR_ID_CXL
> in
> pci_ids.h in order to be utilized in PCI subsystem.
>=20
> When uplevelling PCI_DVSEC_VENDOR_ID_CXL to a common locatoin Bjorn
> suggested making it a proper PCI_VENDOR_ID_* define in
> include/linux/pci_ids.h. While it is not in the PCI IDs database it
> is a
> reserved value and Linux treats it as a 'vendor id' for all intents
> and
> purposes [1].

Would you consider a patch, after this series merges, to upstream
pciutils to sync up lspci's name of this value as well?  It would be
less confusing to anyone looking at both codebases and trying to line
up #define's.

-PJ

