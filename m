Return-Path: <linux-pci+bounces-43502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E73CD4D51
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 08:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AA173007ECC
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 07:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5236946A;
	Mon, 22 Dec 2025 07:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsVPbODU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D633A1E66;
	Mon, 22 Dec 2025 07:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766386863; cv=none; b=MF8FNXVz/3ZMGL6kd+RtrHXvUHlyLtZ59fkC1OyJL6sTxru4balGgXKcsTNwwVQKanjO+7iYJhn2nqVemOVmYTYofRR7Kv2HCg1I+qa6zp/PxBcQ+hjmqp5BkLi9jINhu+4JlQy0Jpa18stZwPnQt8LkTIoFohQHPZqlNx663CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766386863; c=relaxed/simple;
	bh=l6Le9EfF5iu3J3eDZsIQ4DQ27umO6XIZS6ESVUTIYGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k428Ag8HFd3+nWBVkD3qY1l+YUzMBqZf1PJwy5rkFJDInbkWnX9PwTlFiQ0OfOazJ8dDVc5GIKk88L+E06avUrl30uZpUSNbWL4OrxeqXUqBXRjpYsAjv+f8ukvltMgZTIxAiyVQMXJljB62tx4o1UQS9GLegUKaL/BIh8JAZv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsVPbODU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058EFC4CEF1;
	Mon, 22 Dec 2025 07:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766386863;
	bh=l6Le9EfF5iu3J3eDZsIQ4DQ27umO6XIZS6ESVUTIYGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YsVPbODUGO1S7bocQG0KpzlrAButeEUnV6Xc4ckq2w33Mtr5TopNCXFcSBwtsmRs0
	 zgqzFTCr4cYs8P9ymC+gLr1aMDHmN1nEw1QRLZykHqi+kQ4FO7PEZ2BJtLt7jjIYWh
	 BI5QDPLFQ2mL7lJwzow26UC9Oki1QuO4bPDcHXRPlDGiNGxowpn8TG7P8bJPK0pY5T
	 ieotUgprtfZi+zCsLV5O5pzCSGyMk2ylVChmB5M0SGI58LVgb5hVfQ7UiDDmuqNZI1
	 rVlXW2j4JvXGesEcAcAq8KkNv2b7QegcNAGzCPqDPxHKJatY+EpPsq6YspUplF0LBo
	 CcCzZkxIan9hg==
Date: Mon, 22 Dec 2025 08:00:57 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Damien Le Moal <dlemoal@kernel.org>, stable@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 4/6] Revert "PCI: qcom: Enable MSI interrupts together
 with Link up if 'Global IRQ' is supported"
Message-ID: <aUjsqbIaL86Kj1AA@ryzen>
References: <20251222064207.3246632-8-cassel@kernel.org>
 <20251222064207.3246632-12-cassel@kernel.org>
 <6f4eba26-86ba-4510-ac0d-b6e54fd5f51c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f4eba26-86ba-4510-ac0d-b6e54fd5f51c@oss.qualcomm.com>

On Mon, Dec 22, 2025 at 12:18:32PM +0530, Krishna Chaitanya Chundru wrote:
> > @@ -1982,8 +1981,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> >   			goto err_host_deinit;
> >   		}
> > -		writel_relaxed(PARF_INT_ALL_LINK_UP | PARF_INT_MSI_DEV_0_7,
> > -			       pcie->parf + PARF_INT_ALL_MASK);
> MSI's needs to be enabled irrespective of this series as part of global IRQ
> otherwise
> MSI's will not be triggered in few platforms.
> 
> Mani, exclude this patch while applying.

From the commit message of the reverted patch:

  The MSI bits in PARF_INT_ALL_MASK register are enabled
  by default in the hardware, but commit 4581403f6792 ("PCI: qcom: Enumerate
  endpoints based on Link up event in 'global_irq' interrupt") disabled them
  and enabled only the Link up interrupt.


Thus, applying this patch should be safe, or at least bring back the
original behavior as it was before the Link Up IRQ patches got applied.

But if you prefer to enable the MSI bits explicitly, in order to not
rely on HW defaults, that should also be fine.


Kind regards,
Niklas

