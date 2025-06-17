Return-Path: <linux-pci+bounces-29926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F71BADCD9C
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 15:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477323A1EA1
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 13:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C822E7160;
	Tue, 17 Jun 2025 13:36:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C7A23B633
	for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2025 13:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750167398; cv=none; b=iqlF2aUfBAIMvc4uNthzNm4s4A2cmORoIGj8+eHEpOjYLvwB6e5ppAdSbnnmbwEHqCmi46bf9b+7prDKnZEH48QUPO3XIrpxD8Cdm7OIPpM1EkTW6jAdARhHQxJ8yPW2qKCCQplfXuDG9SIlflU5Iuf3g9kZAsPqhNDSYBfbL/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750167398; c=relaxed/simple;
	bh=J5JsoxQ6plPjWX/w9DeLTA9KT+ZAybpgDQczFOgTk5s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fV298UpUO2b+vwcp2HsY1K884RZv+C3usKyxAIoqNaCPYBhY8Mwm6P2ws+CBJefg0uFWGbA2m3KXAw3ZPj2PVQSyauYF1rOdBJSiuDh5gOdxNBkcpeQtq4Bfr2NHjmEfLcVgdqEwAew3WWpkRG503JDN+9peYAL2Egjsya+g3jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bM77x3njxz6L5Xj;
	Tue, 17 Jun 2025 21:31:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 830E71402F5;
	Tue, 17 Jun 2025 21:36:34 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 17 Jun
 2025 15:36:33 +0200
Date: Tue, 17 Jun 2025 14:36:32 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <lukas@wunner.de>, <aneesh.kumar@kernel.org>,
	<suzuki.poulose@arm.com>, <sameo@rivosinc.com>, <aik@amd.com>,
	<jgg@nvidia.com>, <zhiw@nvidia.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Xu
 Yilun" <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 07/13] PCI: Add PCIe Device 3 Extended Capability
 enumeration
Message-ID: <20250617143632.000069cb@huawei.com>
In-Reply-To: <20250516054732.2055093-8-dan.j.williams@intel.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
	<20250516054732.2055093-8-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 15 May 2025 22:47:26 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> PCIe 6.2 Section 7.7.9 Device 3 Extended Capability Structure,
> enumerates new link capabilities and status added for Gen 6 devices. One
> of the link details enumerated in that register block is the "Segment
> Captured" status in the Device Status 3 register. That status is
> relevant for enabling IDE (Integrity & Data Encryption) whereby
> Selective IDE streams can be limited to a given Requester ID range
> within a given segment.
>=20
> If a device has captured its Segment value then it knows that PCIe Flit
> Mode is enabled via all links in the path that a configuration write
> traversed. IDE establishment requires that "Segment Base" in
> IDE RID Association Register 2 (PCIe 6.2 Section 7.9.26.5.4.2) be
> programmed if the RID association mechanism is in effect.
>=20
> When / if IDE + Flit Mode capable devices arrive, the PCI core needs to
> setup the segment base when using the RID association facility, but no
> known deployments today depend on this.
>=20
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

