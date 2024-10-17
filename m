Return-Path: <linux-pci+bounces-14764-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E8E9A2002
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 12:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF33A28377B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 10:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D361D12EB;
	Thu, 17 Oct 2024 10:30:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7021F1D0944;
	Thu, 17 Oct 2024 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729161008; cv=none; b=mNI92IPJZgwLQsoOM4GPqduUi6CVjXsGM7urpIqMc66ZiDZuC+dMAdRRGoMc7NPQ5I4ao/WOb6A5l6Xo5XwuTfqnku3ePywmbzcu99Gbwf/BIc6X3E4cOh0aXK8V4brxT6Aty30WgAxahbz0qf43mD/Gp0ZWbcvqfVilLuiA7qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729161008; c=relaxed/simple;
	bh=XJE56kvNOD6fQ1rlnqy5EQpFTk7WQVoUhShkBv2HmHk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z60iSUb7KlcQ/7idrsw+tj0JaiA7UkH2yuATRL/BeA0kWvAVOz45VAxrXQYSH/tDduZ+7JDXJuWJYTxw3XTR7P6kySW4sSClPJqPEx7NmuxPryolN2oedO7HqyqFN46xavO/tMg9EJJekkoxT6ciPEqlBOIY9RO0JkEyABKe1UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTkbP5mp9z6K9DG;
	Thu, 17 Oct 2024 18:29:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C45D1140119;
	Thu, 17 Oct 2024 18:30:01 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 12:29:59 +0200
Date: Thu, 17 Oct 2024 11:29:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Lorenzo
 Pieralisi" <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, "Maciej W. Rozycki"
	<macro@orcam.me.uk>, Lukas Wunner <lukas@wunner.de>, Alexandru Gagniuc
	<mr.nuke.me@gmail.com>, Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, <linux-kernel@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amitk@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v8 4/8] PCI/quirks: Abstract LBMS seen check into own
 function
Message-ID: <20241017112957.00003782@Huawei.com>
In-Reply-To: <20241009095223.7093-5-ilpo.jarvinen@linux.intel.com>
References: <20241009095223.7093-1-ilpo.jarvinen@linux.intel.com>
	<20241009095223.7093-5-ilpo.jarvinen@linux.intel.com>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed,  9 Oct 2024 12:52:19 +0300
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> The Target Speed quirk in pcie_failed_link_retrain() uses the presence
> of LBMS bit as one of the triggering conditions effectively
> monopolizing the use of that bit. An upcoming change will introduce a
> PCIe bandwidth controller which sets up an interrupt to track LBMS. As
> LBMS will be cleared by the interrupt handler, the Target Speed quirk
> will no longer be able to observe LBMS directly.
>=20
> As a preparatory step for the change, extract the LBMS seen check into
> own function out of pcie_failed_link_retrain().
extract the LBMS seen check from pcie_failed_link_retrain() into
a new function pcie_lmbs_seen()

perhaps is slightly clearer?
>=20
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

