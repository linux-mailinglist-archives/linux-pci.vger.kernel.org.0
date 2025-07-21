Return-Path: <linux-pci+bounces-32630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E64E5B0BF8D
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 11:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA577189CB45
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 09:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C9C223DD7;
	Mon, 21 Jul 2025 09:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJqeqmXv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539EC17BED0;
	Mon, 21 Jul 2025 09:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753088533; cv=none; b=FhnwUCry+0gxVMKTdNn8O/ES20GGUyT2p2klSienVcZHEHB7jqm3vTwRoTj2Y6d6PoqeL6CtbZqO2BMcA6cWBuzkIU6YsUBArIMg2Upk+rDs36yCGw8jQx8JtJime4fJlB4HNs877nLs4D2hKUYnXkteSXA64kC3fJuRVcmH67A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753088533; c=relaxed/simple;
	bh=KIdN64ipZJ4ISL1W603t70Mk64Vr8RjKNYo+RdK1dic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2hgAN1B+MWy3WF1aAZ78sO1T/4X4fkDXK055TV9ZYKM8/auJg5qtlXGWVEFCRdAqhzBcV8AWUo2Wydw+W5ryUb1Tg207c0NLPC2uSnJI6vjYZx0uWEBEnbBEFGA1nWf4+IEH0w6Zb8pU9vRhfOsmcjvoWFRO8/uGvbRhmFqRR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJqeqmXv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC9DC4CEED;
	Mon, 21 Jul 2025 09:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753088532;
	bh=KIdN64ipZJ4ISL1W603t70Mk64Vr8RjKNYo+RdK1dic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KJqeqmXvaUt7Zal7F/1V/iYSSVsTBPj3vQhJG5BflXK8A557zkHUhjAKna1aB8a0w
	 tJqvurVjy9tePFeNsVTvk9pqQOapsyOiwqiKEV7EQObZDJXXpaDobNWb0gsvoCsNsl
	 oBOFWMKGJeYM0add0BU0CZsTwTFA+p9k+tG2KTr98sXj3hwZd7P3kuYcq9hD2sW+Qh
	 dqwGIC2AsKHmhtkltqpeYvGKv5ko5tcjnzeP9UPB4HLYqyMg/8AkSFN4oWbTN5AvnH
	 xY5KY49S4eDPqmg0RQxplFjS6XwAT8fv/Z2HemAVaH4Onsj+dtiu2E5pALWEpEqYqT
	 Pw7Fss7uIMgfQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1udmPJ-000000000BY-0zPu;
	Mon, 21 Jul 2025 11:02:01 +0200
Date: Mon, 21 Jul 2025 11:02:01 +0200
From: Johan Hovold <johan@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: qcom: Move qcom_pcie_icc_opp_update() to
 notifier callback
Message-ID: <aH4CCUY8RRtUywmE@hovoldconsulting.com>
References: <20250714-aspm_fix-v1-0-7d04b8c140c8@oss.qualcomm.com>
 <20250714-aspm_fix-v1-2-7d04b8c140c8@oss.qualcomm.com>
 <b2f4be6c-93d9-430b-974d-8df5f3c3b336@oss.qualcomm.com>
 <jdnjyvw2kkos44unooy5ooix3yn2644r4yvtmekoyk2uozjvo5@atigu3wjikss>
 <eccae2e8-f158-4501-be21-e4188e6cbd84@oss.qualcomm.com>
 <qg4dof65dyggzgvkroeo2suhhnvosqs3dnkrmsqpbf4z67dcht@ltzirahk2mxd>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qg4dof65dyggzgvkroeo2suhhnvosqs3dnkrmsqpbf4z67dcht@ltzirahk2mxd>

On Wed, Jul 16, 2025 at 12:16:42PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Jul 16, 2025 at 10:24:23AM GMT, Krishna Chaitanya Chundru wrote:

> > How about using enable_device in host bridge, without pci_enable_device
> > call the endpoints can't start the transfers. May be we can use that.
> 
> Q: Who is going to call pci_enable_device()?
> A: The PCI client driver
> 
> This is same as relying on BUS_NOTIFY_BIND_DRIVER notifier.

It seems to me that enable_device() may be a better fit if we're only
going to enable ASPM for devices with a driver (or when enabled through
sysfs).

PCI core will already have placed the device in D0, and this avoids
dealing with notifiers.

Johan

