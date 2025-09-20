Return-Path: <linux-pci+bounces-36572-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2826B8C39E
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 09:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74EA9177627
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 07:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F275F25F780;
	Sat, 20 Sep 2025 07:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jCLFa8cq"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1A01EF38E;
	Sat, 20 Sep 2025 07:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758355065; cv=none; b=uzu72ql6oTan0KqwLUPDUJYbOQ0sZ47RCLDJr7ZM3ZNBosHGQJP/SYX5xVEFnMawObuZPvkPFRUnbH6FGCqU5s8jjuYtjYvvOUIh1gw9+9M8FbBT7fNxjeYQuzx96mjx/6DGPdHE8fGF5UJl6+YUoMjPyTbxcRR6HNd5j5EjGiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758355065; c=relaxed/simple;
	bh=cUBuuElSRX3MDS4sybOgqLga1EjZLdw5MDd6QvzWdjc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AW6xIRkENDcNzSa0hNaQ3DerYLZK2Xj17WigDyR4OBEhZk1RPJ4qM090F9AMeBDOvjFGDm1riMZoI3Suy47m3TbjwcSCdV4ACFhYe9oOTiWzOTKrvCTiotZO9DMDUzywSSjCB2hHg6C+wfxF9jn/7TTegB7RogGKPboG2OETgKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jCLFa8cq; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58K7v7J5388223;
	Sat, 20 Sep 2025 02:57:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758355027;
	bh=T3gkevHKttZ+zKYQgGG9Fj0bcgXN5Z9yfJL6umgFsuI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=jCLFa8cq930P8+yRMuQyL4OSdG9GsvXm0KxiF5xQfmuvqU5VK5PDVeREyNCZh5qk9
	 nIiuHgOd1ngtgDKGjwRA1iDWzYY9DgV8I4Cv//ODZybRcmvKjrCwLIYtUxKJS/73Vi
	 ySJ6+AEelM4Wari0SDzYjyzbni0oq1rEbVEzBBRo=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58K7v74L2919129
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sat, 20 Sep 2025 02:57:07 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sat, 20
 Sep 2025 02:57:06 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 20 Sep 2025 02:57:06 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58K7v5pr3828574;
	Sat, 20 Sep 2025 02:57:06 -0500
Date: Sat, 20 Sep 2025 13:27:05 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <robh@kernel.org>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <christian.bruel@foss.st.com>,
        <qiang.yu@oss.qualcomm.com>, <mayank.rana@oss.qualcomm.com>,
        <thippeswamy.havalige@amd.com>, <shradha.t@samsung.com>,
        <quic_schintav@quicinc.com>, <inochiama@gmail.com>,
        <cassel@kernel.org>, <kishon@kernel.org>,
        <sergio.paracuellos@gmail.com>, <18255117159@163.com>,
        <rongqianfeng@vivo.com>, <jirislaby@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH v2 04/10] PCI: dwc: ep: Export
 dw_pcie_ep_raise_msix_irq() for pci-keystone
Message-ID: <6550c06c-b8e8-437e-a399-d1c8c2e29774@ti.com>
References: <20250912122356.3326888-1-s-vadapalli@ti.com>
 <20250912122356.3326888-5-s-vadapalli@ti.com>
 <kb6jxzyihyuhd4qfvdtgxgopzgyymhsflqmheb3fribovdck23@ahswbufb23sv>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <kb6jxzyihyuhd4qfvdtgxgopzgyymhsflqmheb3fribovdck23@ahswbufb23sv>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sat, Sep 20, 2025 at 12:00:47AM +0530, Manivannan Sadhasivam wrote:
> On Fri, Sep 12, 2025 at 05:46:15PM +0530, Siddharth Vadapalli wrote:
> > The pci-keystone.c driver uses the 'dw_pcie_ep_raise_msix_irq()' helper.
> > In preparation for enabling the pci-keystone.c driver to be built as a
> > loadable module, export 'dw_pcie_ep_raise_msix_irq()'.
> > 
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> 
> This patch could be merged with patch 2.

I will squash this in patch 2 in the v3 series.

Regards,
Siddharth.

