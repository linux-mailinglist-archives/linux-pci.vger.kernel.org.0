Return-Path: <linux-pci+bounces-36574-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1409CB8C3AE
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 10:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3225822A0
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 08:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43C226E146;
	Sat, 20 Sep 2025 08:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NjVf81lp"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2800627603C;
	Sat, 20 Sep 2025 08:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758355507; cv=none; b=FS39sA7u5xuG3cUn304f5cs/FLMPmH1XjqRC93RSNePqeNYIbIMc9YNOXNjVeFLu1E+rU9wiUldKVSlNh9dKcZ03s5S/VQRBUJ9hKSg1K+Lac07DH1UUu9t1oBjgTJ8yfg2pvndHKhedS+LATDRwtiium2V2YEsHbFAI5G4GYo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758355507; c=relaxed/simple;
	bh=ESzNdBgonA4pbu28ihXqlEQt4V7fScSrASnlJ9I8e3k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIGR+EN5XgpE9EBoGlqFqguStRoVq6JJ/qc0W0rtSf9f3UXXjEJ/DUzK3VmRVoXRI8s6pQK+3uLFnvuzG9bEsJL25Asar5kgao9tJmdo/rEvvk2V2SlHc8OwgbVPqXWcN8RwWhT6Le5kV2UQRdLLWW+lWRBhCH1PHNtPqlYet1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NjVf81lp; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58K84mEI399043;
	Sat, 20 Sep 2025 03:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758355488;
	bh=LQ4+CroMOZ6+PrKqvO9PJnzfWlXXz0wdVIsgyy9cDU8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=NjVf81lp9CGtBb9U7brcJn+6oC5L1NoaSWr7eowTWa1Zcoi5zk6Oph7qXtBfx7l5p
	 QmqEBJE1zRWRdeGP0pyc8wj6yCyG5ZpD9lQGvZ6/H1Zh4E1XZfDf4XlV9G4X3GeerJ
	 cxFR/EQsJPZpqL2e/ZWxSa4J9Z2XcsYi+8wwhJiw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58K84mmv3496308
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sat, 20 Sep 2025 03:04:48 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sat, 20
 Sep 2025 03:04:48 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 20 Sep 2025 03:04:48 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58K84lIN3564491;
	Sat, 20 Sep 2025 03:04:47 -0500
Date: Sat, 20 Sep 2025 13:34:46 +0530
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
Subject: Re: [PATCH v2 06/10] PCI: keystone: Add ks_pcie_free_intx_irq()
 helper for cleanup
Message-ID: <0cab2a15-92bd-4ace-943d-ba82ede49b8b@ti.com>
References: <20250912122356.3326888-1-s-vadapalli@ti.com>
 <20250912122356.3326888-7-s-vadapalli@ti.com>
 <7sbyvk6vyrbyox5ghvhokrv67r2el4s4f6k42aygmfo3rltj27@6v5pjxbhdl5w>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7sbyvk6vyrbyox5ghvhokrv67r2el4s4f6k42aygmfo3rltj27@6v5pjxbhdl5w>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sat, Sep 20, 2025 at 12:05:38AM +0530, Manivannan Sadhasivam wrote:
> On Fri, Sep 12, 2025 at 05:46:17PM +0530, Siddharth Vadapalli wrote:
> > Introduce the helper function ks_pcie_free_intx_irq() which will undo the
> > configuration performed by the ks_pcie_config_intx_irq() function. This
> > will be required for implementing a future helper function to undo the
> > configuration performed by the ks_pcie_host_init() function.
> > 
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> 
> Please squash all patches introducing new helpers.

I will squash them in the v3 series.

Regards,
Siddharth.

