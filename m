Return-Path: <linux-pci+bounces-14761-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 401BE9A1F8A
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 12:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C43EE1F221AD
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 10:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDC41DA0E3;
	Thu, 17 Oct 2024 10:12:24 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFED1D6DB4;
	Thu, 17 Oct 2024 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729159944; cv=none; b=Gf/WTfifdXl742PmityH11P8q9ooIByOtMHc+wRESe7NOajdBcy2gV8KkJFsQpMD6SF3GFSIQMxt9ToXzADSeN1qX6LjhkCAEBgfwAgIMFgfuo9/VUVmswDtwst+XcuYaEiSgP1o208ThwcYdOZWJKnCPV44R7PoVyZ5o04rJ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729159944; c=relaxed/simple;
	bh=YzeVeOLHzuEbx+F9HKk7j53SetYaUbEgSj9ZRMYNBhM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oMhtt8e9RpR7wcFh980FEa6LMB8enPPSvEm5KM1Hute40TNB7g8iKnFpo+XbTkrrNjkCD40cwnVDXbpdtpi9L16vy05hX0OSjIuFd32h09wZdJ0Rh8usN8DSBfqD/6AQee2x8ecauQuM6ki/UukLmEvCOSPwDhYxf9Y6p0btSwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTk9h708Dz6GBxS;
	Thu, 17 Oct 2024 18:10:32 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B37BA1400F4;
	Thu, 17 Oct 2024 18:12:16 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 12:12:15 +0200
Date: Thu, 17 Oct 2024 11:12:13 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Lorenzo
 Pieralisi" <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, "Maciej W. Rozycki"
	<macro@orcam.me.uk>, Lukas Wunner <lukas@wunner.de>, Alexandru Gagniuc
	<mr.nuke.me@gmail.com>, Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Jonathan Corbet <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Amit Kucheria <amitk@kernel.org>, Zhang Rui
	<rui.zhang@intel.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v8 1/8] PCI: Protect Link Control 2 Register with RMW
 locking
Message-ID: <20241017111213.00005d4f@Huawei.com>
In-Reply-To: <20241009095223.7093-2-ilpo.jarvinen@linux.intel.com>
References: <20241009095223.7093-1-ilpo.jarvinen@linux.intel.com>
	<20241009095223.7093-2-ilpo.jarvinen@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed,  9 Oct 2024 12:52:16 +0300
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> PCIe Bandwidth Controller performs RMW accesses the Link Control 2
> Register which can occur concurrently to other sources of Link Control
> 2 Register writes. Therefore, add Link Control 2 Register among the PCI
> Express Capability Registers that need RMW locking.
>=20
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
Totally trivial comment inline.

LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Documentation/PCI/pciebus-howto.rst | 14 +++++++++-----
>  include/linux/pci.h                 |  1 +
>  2 files changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/PCI/pciebus-howto.rst b/Documentation/PCI/pcie=
bus-howto.rst
> index f344452651e1..375d9ce171f6 100644
> --- a/Documentation/PCI/pciebus-howto.rst
> +++ b/Documentation/PCI/pciebus-howto.rst
> @@ -217,8 +217,12 @@ capability structure except the PCI Express capabili=
ty structure,
>  that is shared between many drivers including the service drivers.
>  RMW Capability accessors (pcie_capability_clear_and_set_word(),
>  pcie_capability_set_word(), and pcie_capability_clear_word()) protect
> -a selected set of PCI Express Capability Registers (Link Control
> -Register and Root Control Register). Any change to those registers
> -should be performed using RMW accessors to avoid problems due to
> -concurrent updates. For the up-to-date list of protected registers,
> -see pcie_capability_clear_and_set_word().
> +a selected set of PCI Express Capability Registers:
> +
> +* Link Control Register
> +* Root Control Register
> +* Link Control 2 Register
> +
> +Any change to those registers should be performed using RMW accessors to
> +avoid problems due to concurrent updates. For the up-to-date list of
> +protected registers, see pcie_capability_clear_and_set_word().

If I were super fussy I'd ask for a precursor patch doing the reformat.

Meh - up to Bjorn, but for me this is small enough to not be worth
the effort.

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 573b4c4c2be6..be5ed534c39c 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1274,6 +1274,7 @@ static inline int pcie_capability_clear_and_set_wor=
d(struct pci_dev *dev,
>  {
>  	switch (pos) {
>  	case PCI_EXP_LNKCTL:
> +	case PCI_EXP_LNKCTL2:
>  	case PCI_EXP_RTCTL:
>  		return pcie_capability_clear_and_set_word_locked(dev, pos,
>  								 clear, set);


