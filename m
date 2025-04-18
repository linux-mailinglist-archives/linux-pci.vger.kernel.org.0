Return-Path: <linux-pci+bounces-26249-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301EAA93E9C
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 22:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683DF8E58A5
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 20:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55B022DFA7;
	Fri, 18 Apr 2025 20:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyFX7Po8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7313B22DF9E;
	Fri, 18 Apr 2025 20:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745006458; cv=none; b=PWAa0jzJtY1qu32q6xWZPHVyigrNcs50kPbA6644OtpTOi7opX9SxNNrR4hMrA4Jvq8/RK/ZYsmkGCRWO0LqV5BTE5p3RhlVrHCGzsxFAzalfMwlM6NtHa3ZaUUmKDdcBYHRpIrjrBLIir78uTj4M+m11ET0/zn0XvkJsEmPShg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745006458; c=relaxed/simple;
	bh=3q9TKD2x5VDzKBJu2prJXFQuhkx3tP3jH8Ldntpil1g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=joapVyyfi9H3qeDS9nPHnZ7ZBCb7KcJy+WVA4enPpPilj6QCHXhtr0Fr3t441yNgANBnkzyim8sT39QLotun9nZEdF3ZDhiU4PJeF+WuM+yFN+q6Arnjfxb3y86CsQEnhgRSxzKak0n6ImemfdbxcCM5GFCf/jy6QQr0BOjMHv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyFX7Po8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE884C4CEE2;
	Fri, 18 Apr 2025 20:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745006457;
	bh=3q9TKD2x5VDzKBJu2prJXFQuhkx3tP3jH8Ldntpil1g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JyFX7Po8qVu5weXZLE7NBquSFcMZtilTX3M24p7jANI9VyBdof2zXOazxu7/JlYV5
	 rJCJa1f//Q8oE4hiLssGOfID+ZGmnago0/rYrdUZ6yc9awI725c5LL8inN9PZHQfTo
	 0uiwsaOl4b48etwzw+rwkRSbgFeOmsMNBTDBBWBB1DBCwzhJBg13Y79SXZnNzpKI4g
	 zJFcnklT3I068Be+mGzHSmIq6BdLz54bzpPj5wSZQmqe3B7S4v6jCAgzhrx0ydJA+L
	 KmpSpsBoJbc/1310AupQLh0BnpY8Ck9YCHBb3y/HYS/DGnsikrnfaskFw4gZiI3DVU
	 H7srMQnW55fgg==
Date: Fri, 18 Apr 2025 15:00:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	chaitanya chundru <quic_krichai@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com,
	amitk@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
	Dmitry Baryshkov <lumag@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v5 0/9] PCI: Enable Power and configure the TC9563 PCIe
 switch
Message-ID: <20250418200056.GA82278@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412-qps615_v4_1-v5-0-5b6a06132fec@oss.qualcomm.com>

On Sat, Apr 12, 2025 at 07:19:49AM +0530, Krishna Chaitanya Chundru wrote:
> TC9563 is the PCIe switch which has one upstream and three downstream
> ports. To one of the downstream ports ethernet MAC is connected as endpoint
> device. Other two downstream ports are supposed to connect to external
> device. One Host can connect to TC956x by upstream port.

I guess this topology is for one specific platform that includes the
TC9563?  Since it's a PCIe switch, I assume it could also be used in
other platforms with other topologies?

> TC9563 switch power is controlled by the GPIO's. After powering on
> the switch will immediately participate in the link training. if the
> host is also ready by that time PCIe link will established. 
> 
> The TC9563 needs to configured certain parameters like de-emphasis,
> disable unused port etc before link is established.
> 
> As the controller starts link training before the probe of pwrctl driver,
> the PCIe link may come up as soon as we power on the switch. Due to this
> configuring the switch itself through i2c will not have any effect as
> this configuration needs to done before link training. To avoid this
> introduce two functions in pci_ops to start_link() & stop_link() which
> will disable the link training if the PCIe link is not up yet.
> 
> This series depends on the https://lore.kernel.org/all/20250124101038.3871768-3-krishna.chundru@oss.qualcomm.com/

How so?
https://lore.kernel.org/all/20250124101038.3871768-3-krishna.chundru@oss.qualcomm.com/
adds a schema "n-fts" property, but this series doesn't mention
"n-fts".  This series *does* add this:

  of_property_read_u8_array(node, "nfts", cfg->nfts, 2);

Is that supposed to be the same thing, or does "nfts" magically match
"n-fts"?

Bjorn

