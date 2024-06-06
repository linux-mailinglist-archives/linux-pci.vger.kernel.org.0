Return-Path: <linux-pci+bounces-8396-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5548FE44A
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 12:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088F91C25598
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 10:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A50194AF7;
	Thu,  6 Jun 2024 10:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fJKOa/ws"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13833BB59;
	Thu,  6 Jun 2024 10:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669857; cv=none; b=X5ZkQXGSlBu8lUVm6jnEzi1AM//SWqSe3hTLbxoISqDYRojm5tmIVRvl4eE9xtmddGDHrM7Q3T5vZy+fgYQx+5fS7jAsvo6I7HPuvfDa6hIoHZe+T11Tcw2WdUWt3hW8ASoCbyOJTzyG6oqyAY+1VUGE6jIwNYB68BHWajJ41yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669857; c=relaxed/simple;
	bh=n8NQZKeOwsHVqFfy3xQydSiac6ZEqPtQOJSNPM1mQvk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oa1ouL90xkoeCYsm9eQozyz7BxgKFifNnA9VbLfdQPm8emD2SpizWdmAZJDP18Iqf8gfWCpSCxvxWlRzPGVbPjCGJzY3lEPURXi3oL1Dz6KKVw0OubMIqYU6TfN8kcIp9WYhi9OWZDa4Mdv4bQO4NEBYlrE/qSQ0ZPY6fnkJzrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fJKOa/ws; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 456ATv4r063258;
	Thu, 6 Jun 2024 05:29:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717669797;
	bh=9ZCEA6cP5eUu5u5Wy7c5Qa6XpiJ0SNZvrvxHy3jwf1w=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=fJKOa/wsX3EBlujkA6t8UrFIGrAbdCE7KR+XE/HH97gbjeGaHaXL8+1qU/H0jK2cx
	 wC5KT1F0rQ2h8e/E6HwyoyY7Yb2Ndc6I6UApNJoGJiIawowiz3rWLsr43MMzL7YLve
	 kn2shltk136jLtQaP9TWHjtZ3qM7fvv3uKDOccqs=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 456ATvxF027716
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Jun 2024 05:29:57 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 6
 Jun 2024 05:29:57 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 6 Jun 2024 05:29:57 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 456ATu3Y111689;
	Thu, 6 Jun 2024 05:29:57 -0500
Date: Thu, 6 Jun 2024 15:59:55 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha
 Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team
	<kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Minghuan Lian
	<minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang
	<roy.zang@nxp.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jingoo Han
	<jingoohan1@gmail.com>,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Marek
 Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>,
        Thierry Reding
	<thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko
 Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu
	<mhiramat@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <imx@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <mhi@lists.linux.dev>, Niklas Cassel <cassel@kernel.org>,
        Bjorn Helgaas
	<helgaas@kernel.org>
Subject: Re: [PATCH 1/5] PCI: dwc: ep: Remove dw_pcie_ep_init_notify() wrapper
Message-ID: <ef98f581-e2a3-419c-90a8-6cb64ca4e835@ti.com>
References: <20240606-pci-deinit-v1-0-4395534520dc@linaro.org>
 <20240606-pci-deinit-v1-1-4395534520dc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240606-pci-deinit-v1-1-4395534520dc@linaro.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Thu, Jun 06, 2024 at 12:56:34PM +0530, Manivannan Sadhasivam wrote:
> Currently dw_pcie_ep_init_notify() wrapper just calls pci_epc_init_notify()
> directly. So this wrapper provides no benefit to the glue drivers.
> 
> So let's remove it and call pci_epc_init_notify() directly from glue
> drivers.
> 
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

[...]

Regards,
Siddharth.

