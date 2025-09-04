Return-Path: <linux-pci+bounces-35424-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B41F0B431E7
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 08:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7144B480220
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 06:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D2E2417D4;
	Thu,  4 Sep 2025 06:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eM4xdPD4"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A608227EAA;
	Thu,  4 Sep 2025 06:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756965791; cv=none; b=hIwIo/YleoESsUoa+PUG/cODHQDXyPKurL8e6+Ume0GQBUGUCEEljU5aKM7AGk8cdHlDE/5GVTBNTQQbIIF3iKRzYlJocvhhNllTHb0RMNWzUimlkxpUO9WesM1XQRue12/mqZdLcM4eXiSwcCWi1gHuTc7GMV8lHYEtOcze4gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756965791; c=relaxed/simple;
	bh=Na8D2F1M+Ubbv95BCr971DlBbYNRDFst0cUsqLAgIgY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMCblKc640T4WPRlNWonCJaqlBKEdLXbrgewNHqd6S2yjqjqkA7hVwwUaNHdQeMaxckv690soAjdtSo0oFwg6kLMjY0iw6rCLmT3RA+1+qdPARODB6wKPSI5elVp6oQdsprtMQDcVmf7hfB0E6MSSoreRhwU7MGlbhRBGjBiLZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eM4xdPD4; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5846328V3441617;
	Thu, 4 Sep 2025 01:03:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756965782;
	bh=fM8vAY0Q85Z9EMSXf59mCDlpv1x4CnX0CGNGXY1eJU0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=eM4xdPD4AD/A7nqAs4IOXS9dyQxjN+IwfGqB5NLeMLtTsDQxr1V76Dd3PYdto9XGW
	 y9QCqXLhvA1hho7Zpf0jNMyeyWiRltJWhFzzrCIzr/WnKDRnetXNouYjJ2gSRCxTKb
	 1pSVzkG9SuPdTep53JAWued/gM2XnmQFBsoWYT7Q=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 584632br4155145
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 01:03:02 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 01:03:02 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 01:03:01 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 584630uh2789507;
	Thu, 4 Sep 2025 01:03:01 -0500
Date: Thu, 4 Sep 2025 11:33:00 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <robh@kernel.org>, <bhelgaas@google.com>,
        <helgaas@kernel.org>, <kishon@kernel.org>, <vigneshr@ti.com>,
        <stable@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH v3] PCI: j721e: Fix programming sequence of "strap"
 settings
Message-ID: <a0e1d273-239b-44e5-8ccc-0ba83b2b5839@ti.com>
References: <20250829091707.2990211-1-s-vadapalli@ti.com>
 <oztilfun77apxtjxumx4tydkcd2gsalsak4m2rvsry2oooqjna@2yvcx6cnuemm>
 <b2fb9252-6bfc-45da-973a-31cdfcc86b3d@ti.com>
 <z3ubracmtlq23yicbrhqjgnzrfoqheffm6cvhfnawlvbu4cmmp@ddu2o7xhw5tz>
 <48e9d897-2cd3-48ef-b46a-635ae75f5ac6@ti.com>
 <3wc3t6y5gzzspgfeklsqo3bupfp6gsfy6mls6t66hflcqlqsfk@cu26wv3sow4y>
 <9d2bba15-52e4-432a-8f7f-a0f5d7c2e4ad@ti.com>
 <7hxdcjm7evlphkldct7seytno4is7rjkx5vquvtfhpdkzxdhu6@yocrjgzciwu3>
 <08b87b5f-838b-4f40-ae90-10ded134356e@ti.com>
 <whinfqhjgqbbvlnuzgbukklqi6gocjji4gakqyycovrse4qq6s@6xq5imqbzvux>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <whinfqhjgqbbvlnuzgbukklqi6gocjji4gakqyycovrse4qq6s@6xq5imqbzvux>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Wed, Sep 03, 2025 at 06:51:14PM +0530, Manivannan Sadhasivam wrote:

[...]

> 
> I thought put_noidle() will just reduce the refcount and not invoke the
> idle/suspend callbacks, but I seem to be wrong here.
> 
> Anyway, I guess we have no option here other than to drop the
> pm_runtime_put_noidle() call. This will keep refcount as 1 and will prevent the
> parent (genpd) to not enter runtime suspend, but we have to live with it (this
> was also the previous beahvior as well).
> 
> Btw, pm_runtime_set_active/enable change belongs to a separate patch.

I will work on and post the v4 patch with the following change:
- The commit message and the comment in the code will be updated to
  indicate that the runtime PM APIs are used to cause 'genpd' to power off
  and power on the controller.

I assume that the driver changes can remain as they are in this patch given
that the existing behavior has to be preserved. As j721e_pcie_ctrl_init()
programs the strap settings, powering off the controller via
pm_runtime_put_sync() and powering it on via pm_runtime_get_sync() shall
be implemented within j721e_pcie_ctrl_init() itself leaving the rest of the
probe function as-is. To summarize, the driver changes will be:

	j721e_pcie_ctrl_init()
		...Existing code...
	+	Add pm_runtime_put_sync() here to power off controller
		...Existing code to program strap settings...
	+	Add pm_runtime_get_sync() here to power on controller
		...Existing code...

Please let me know what you think.

Regards,
Siddharth.

