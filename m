Return-Path: <linux-pci+bounces-32640-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 133C2B0C207
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 12:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE2561892157
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 10:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F8F28A1F4;
	Mon, 21 Jul 2025 10:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbMatMRi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC40A284685;
	Mon, 21 Jul 2025 10:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095551; cv=none; b=sRrn0BjHLAcjPK2Nn9rb3jXZkNG1tVxrn1RAnUhb/qOGJEKHF1kJJY+ZWrdcB2zs/HjMgKSb3JgZPekTVW+JY5dn49YGWUhU4zz4Dora8kBj8dsF+WZiZ34lFCHvm5q9Wkr7EWdJ1dK+7/Tpq9nyHu6SUXACXCR0Oywqg2gIbRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095551; c=relaxed/simple;
	bh=FMePtQn6jTkbhBgFm4Etx1K7tp7K/SsiDFNc/g0Hwvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4svirkQWX9ffJU5UgrsZ0nNoiS0huaxP42XgRYkqN2FtHusw+9uRwKH4hSe+3vOzc+ggTf2Z66pwqUnTvPDfySfF+DCzsSEvc5sZqR/U5s+0C+34jxII/3+/CnAltPRJwIybWRl0P6IihJZBB2fdvZsm9qcPc7NBLcvyqZZUqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbMatMRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B7EC4CEED;
	Mon, 21 Jul 2025 10:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753095550;
	bh=FMePtQn6jTkbhBgFm4Etx1K7tp7K/SsiDFNc/g0Hwvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LbMatMRiG/wt7Y6K8SiNC9ZTtWAyjlqz46vXAimjVIEoQvE59pjnysLE1le1swqFE
	 uOYzk1Ma/ZIikQgW3txCdbCp+3ediJmkuE4Buv7J6EtG/SWrRNopblO6w+ToTmEm1H
	 z42J9eUeTBKoiYKCPlh9Jh5KHgRwLe7Rz4rOe1kY6FqaVpTMXiFjvvCrsACvVRqmDf
	 ygW3GvIg03DhJnKLlx+Dh3sASNdTxp31F1s1Y41D8s2EwZ0q9PE1Ijv6lPiUbhq13K
	 dldt8Qe720ZchdCoAMd3wI9H8T06hp4Kvucf7BcF6/8iEpSylLCI1NUmk9E/dVMoMA
	 vTTjzBXyk0m+w==
Date: Mon, 21 Jul 2025 16:29:01 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: qcom: Move qcom_pcie_icc_opp_update() to
 notifier callback
Message-ID: <ekg5lpnqeer5j3vka3rhfh5sf6sid4gnr5bzyxysjqfftxrjcy@bitmxfnhbe5f>
References: <20250714-aspm_fix-v1-0-7d04b8c140c8@oss.qualcomm.com>
 <20250714-aspm_fix-v1-2-7d04b8c140c8@oss.qualcomm.com>
 <b2f4be6c-93d9-430b-974d-8df5f3c3b336@oss.qualcomm.com>
 <jdnjyvw2kkos44unooy5ooix3yn2644r4yvtmekoyk2uozjvo5@atigu3wjikss>
 <eccae2e8-f158-4501-be21-e4188e6cbd84@oss.qualcomm.com>
 <qg4dof65dyggzgvkroeo2suhhnvosqs3dnkrmsqpbf4z67dcht@ltzirahk2mxd>
 <aH4CCUY8RRtUywmE@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aH4CCUY8RRtUywmE@hovoldconsulting.com>

On Mon, Jul 21, 2025 at 11:02:01AM GMT, Johan Hovold wrote:
> On Wed, Jul 16, 2025 at 12:16:42PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Jul 16, 2025 at 10:24:23AM GMT, Krishna Chaitanya Chundru wrote:
> 
> > > How about using enable_device in host bridge, without pci_enable_device
> > > call the endpoints can't start the transfers. May be we can use that.
> > 
> > Q: Who is going to call pci_enable_device()?
> > A: The PCI client driver
> > 
> > This is same as relying on BUS_NOTIFY_BIND_DRIVER notifier.
> 
> It seems to me that enable_device() may be a better fit if we're only
> going to enable ASPM for devices with a driver (or when enabled through
> sysfs).
> 
> PCI core will already have placed the device in D0, and this avoids
> dealing with notifiers.
> 

I'm planning to drop this series in favor of this patch (with one
yet-to-be-submitted patch for pcie-qcom on top):

https://lore.kernel.org/linux-pci/20250720190140.2639200-1-david.e.box@linux.intel.com/

This patch is more elegant compared to this series and also avoids the issue
we are discussing.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

