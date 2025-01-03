Return-Path: <linux-pci+bounces-19239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C48A00C21
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 17:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CFD81884B1E
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 16:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD521FAC59;
	Fri,  3 Jan 2025 16:37:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B916F155C97;
	Fri,  3 Jan 2025 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735922225; cv=none; b=LoQ/CVp98hB29BiP0r6WXy0oo1dLBN+wUuO8op4i/vAI3Ze28i2+PKLRrkC6Yi4boDxvZYLlkgQOmUHxh5MrhdxSq3WQE1sGgIa0WbZMRHI/B4kS68J9s/9+RXxUtUpNE4cJSyVAqgC6dnPkMxRd+9OJyxHdS/A8UDvHmHQSSS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735922225; c=relaxed/simple;
	bh=v6XQeHjfhp+gze3B6SFZwrlp6xLOLJq6KZgFTEi0zgg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gjz6gWBp9dome1KCjdw8QJfCTFaIMrdWFnG8SxSuSQrkZZOyyESMtkrZ8l5CRdwB9F4qwSwSSb187rkbVdaJUl/5TyP/YkxcIMVecNYJMZYlXTNpHJO3TGVFCsInMA7h0UqGSsqmxq8Y5BSboO573lf2BSGh8PusCJheIZf2bSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YPq2c0nJNz6K6K9;
	Sat,  4 Jan 2025 00:36:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 803DF1406AC;
	Sat,  4 Jan 2025 00:37:00 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 3 Jan
 2025 17:36:59 +0100
Date: Fri, 3 Jan 2025 16:36:58 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Lukas Wunner
	<lukas@wunner.de>, Yazen Ghannam <yazen.ghannam@amd.com>,
	<linux-kernel@vger.kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v8 5/7] PCI: Store # of supported End-End TLP Prefixes
Message-ID: <20250103163658.00003c81@huawei.com>
In-Reply-To: <20241218143747.3159-6-ilpo.jarvinen@linux.intel.com>
References: <20241218143747.3159-1-ilpo.jarvinen@linux.intel.com>
	<20241218143747.3159-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 18 Dec 2024 16:37:45 +0200
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> eetlp_prefix_path in the struct pci_dev tells if End-End TLP Prefixes
> are supported by the path or not, the value is only calculated if
> CONFIG_PCI_PASID is set.
>=20
> The Max End-End TLP Prefixes field in the Device Capabilities Register
> 2 also tells how many (1-4) End-End TLP Prefixes are supported (PCIe
> r6.2 sec 7.5.3.15). The number of supported End-End Prefixes is useful
> for reading correct number of DWORDs from TLP Prefix Log register in AER
> capability (PCIe r6.2 sec 7.8.4.12).
>=20
> Replace eetlp_prefix_path with eetlp_prefix_max and determine the
> number of supported End-End Prefixes regardless of CONFIG_PCI_PASID so
> that an upcoming commit generalizing TLP Prefix Log register reading
> does not have to read extra DWORDs for End-End Prefixes that never will
> be there.
>=20
> The value stored into eetlp_prefix_max is directly derived from
> device's Max End-End TLP Prefixes and does not consider limitations
> imposed by bridges or the Root Port beyond supported/not supported
> flags. This is intentional for two reasons:
>=20
>   1) PCIe r6.2 spec sections r6.1 2.2.10.4 & 6.2.4.4 indicate that TLP
>   is handled malformed only if the number of prefixes exceed the number
>   of Max End-End TLP Prefixes, which seems to be the case even if the
>   device could never receive that many prefixes due to smaller maximum
>   imposed by a bridge or the Root Port. If TLP parsing is later added,
>   this distinction is significant in interpreting what is logged by the
>   TLP Prefix Log registers and the value matching to the Malformed TLP
>   threshold is going to be more useful.
>=20
>   2) TLP Prefix handling happens autonomously on a low layer and the
>   value in eetlp_prefix_max is not programmed anywhere by the kernel
>   (i.e., there is no limiter OS can control to prevent sending more
>   than n TLP Prefixes).
>=20
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
Extra explanation looks good to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

