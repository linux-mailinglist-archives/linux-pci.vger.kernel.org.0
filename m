Return-Path: <linux-pci+bounces-8579-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 440E39038D3
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 12:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2165B20CDD
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 10:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27ED214F9F5;
	Tue, 11 Jun 2024 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="T1wzQjsn"
X-Original-To: linux-pci@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877FD54750;
	Tue, 11 Jun 2024 10:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718101630; cv=none; b=E7wnskbiykMLbhdp3RrlGHE/1J92edCTm4sdRFCzRWcN4oXuIKcjDx90lcduWGpuPybA0xXpx6SllEusz3dxoAMouUmAscIQho5I92ypBsV187kjW/Cx/KrMRWIZJ5yiAczKf1Eoq+pTgsWnC9mjpxjspRGFuOLcraDjyn666qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718101630; c=relaxed/simple;
	bh=YjCgBc+r+06nJ6IVpW13RFBeFFzWdG5LhXvUogE3Vjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CT6oQbADF0EHrAbdcxlYjQFZVQkFm1t/87ZlMl4VT8QjLtEkgB0mYF0KfHLVapYz3sLdewTjKArt4rIkcvYJeX7q6uFc2s3YEcLKd8nabg1XFBwhNROC6WgxdicQX2RbvDFhv853w3eSj0OcDb/QZFfqxoxfaYtF5oKT0NJnUc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=T1wzQjsn; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718101626;
	bh=YjCgBc+r+06nJ6IVpW13RFBeFFzWdG5LhXvUogE3Vjo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T1wzQjsnI/PhpuS+7t5fBwGZr6+q2ZAxBqLXqQMriXE7BFH57QT/sDcseACk0hDbf
	 mHUK99ISk7TYaw9IvJz4Xm7/Msho3y10Pk6CMVUBQYEqCG+1Ej59FukA/UQ5wJFC8I
	 oVoWIgnJte49b4dtn9P85C2PivUVwZocQfrRDJ97i8rroBx750ogE3mmEFdPUBqUjJ
	 i/LBCZuyz+fTPYHH1Ff1dXDOYKvtyP418oMSiCapdk2sHf7eX/KpklshnpPfaOlRlU
	 C8MdxapQvg9t/dnqMlIFQZwAoQOn2tna9za2GKGJjRbmIruV1oX/VQrIVf6Pc9G1yr
	 T45pI9gg3cHSA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D799237804C6;
	Tue, 11 Jun 2024 10:27:04 +0000 (UTC)
Message-ID: <6d4173cd-ffe1-427d-ac04-bb9374b4b8d8@collabora.com>
Date: Tue, 11 Jun 2024 12:27:04 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: controller: add missing MODULE_DESCRIPTION() macros
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Will Deacon <will@kernel.org>,
 Joyce Ooi <joyce.ooi@intel.com>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Marc Zyngier <maz@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
 Jianjun Wang <jianjun.wang@mediatek.com>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Nirmal Patel <nirmal.patel@linux.intel.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
References: <20240610-md-drivers-pci-controller-v1-1-b998c242df55@quicinc.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240610-md-drivers-pci-controller-v1-1-b998c242df55@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 11/06/24 03:04, Jeff Johnson ha scritto:
> When ARCH=x86, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/dwc/pci-exynos.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/pci-host-generic.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/pcie-altera.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/pcie-altera-msi.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/pcie-mediatek.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/pcie-mediatek-gen3.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/vmd.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/pcie-apple.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/pcie-mt7621.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

For MediaTek

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



