Return-Path: <linux-pci+bounces-34301-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD57B2C574
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 15:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123CA3A2618
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 13:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483EB253F21;
	Tue, 19 Aug 2025 13:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sQkgxP8J"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6782D2EB87C;
	Tue, 19 Aug 2025 13:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609534; cv=none; b=BiSsrEiUQmjtw19jKztq0xWbU9hwQ6gFOTkS2bCaG2Tsls3fLx52X5JwIDvZcuhtX5/e0cCdwpLYIfihMZEgPfhYRi0thPQuisamftysebQ8htwCIucTydXA+9yWMfS5kKIjfEBo/pFVPrjaQs52rLLyLaXcs4aUZ3uYqb6edKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609534; c=relaxed/simple;
	bh=QCjWNvDQ7orwkY75alNFw0kz2KO8dEVMqrDeOIpYfX4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPQcQB/phpHgWkpFNhWTMmD0jdhk+vEvzo3pfUbKeEequvVFZkQAQK1wMtlbSMw3OmVMxG5dRXeozazZmxxFgQlXXlQTmY4zdZMW+2bKXxnZspY3ubKcjTrY6Kq7kp2+o4G2TKXVkyBppvSPQ6kGnglx1hFfcAaQoEyc+l2ExQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sQkgxP8J; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57JDIatB2960068;
	Tue, 19 Aug 2025 08:18:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755609516;
	bh=1FqbUz67mQuKjoGVkln7n7YBB1Sc9BIygUfegEpUCsY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=sQkgxP8J1r+mwUr4iR9eblLRqx35Ke+JkqP1Cjzf/r+OQCy/R6cDvxEyLJrih3Rfk
	 99koeWg0YYX/ScgMhHB4WYaSh54FZLsF+Eo2ojvf2jjP+xUB8YV469N3CY8oeSe73M
	 1QnnPRtXfW9TAdpTZwpirQXAx3ExMbj2yl8gTF0k=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57JDIZVA610086
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 19 Aug 2025 08:18:36 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 19
 Aug 2025 08:18:35 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 19 Aug 2025 08:18:35 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57JDIYwI3045996;
	Tue, 19 Aug 2025 08:18:35 -0500
Date: Tue, 19 Aug 2025 18:48:33 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam
	<mani@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Niklas Cassel <cassel@kernel.org>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Hans Zhang
	<18255117159@163.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: keystone: Use kcalloc() instead of kzalloc()
Message-ID: <0671bdc2-883e-4fb3-aa69-9e4d1579a38f@ti.com>
References: <20250819131235.152967-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250819131235.152967-1-rongqianfeng@vivo.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Tue, Aug 19, 2025 at 09:12:33PM +0800, Qianfeng Rong wrote:
> Replace calls of devm_kzalloc() with devm_kcalloc() in ks_pcie_probe().
> As noted in the kernel documentation [1], open-coded multiplication in
> allocator arguments is discouraged because it can lead to integer
> overflow.
> 
> Using devm_kcalloc() provides built-in overflow protection, making the
> memory allocation safer when calculating the allocation size compared
> to explicit multiplication.
> 
> [1]: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
> v2: Modified the commit message.

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.

