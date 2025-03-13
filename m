Return-Path: <linux-pci+bounces-23676-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F03A5FD83
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 18:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9B4420C50
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 17:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BC418FDBD;
	Thu, 13 Mar 2025 17:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLb1Bgxl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD29613C689;
	Thu, 13 Mar 2025 17:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886199; cv=none; b=DhbqpbUGPuNkyIVlVL0b7M5Kxm5fEC6fJGrlk/ypeNDf6BN/ffEhsh7DRMN48LHCMBklu0ttROBtfDKid6+BHczidKJ9x5duDx2aFGPQHjlLk4PRSX2bh3vk7IqtRBv19/Arpk+/FbWHQoJ37cPJ5M8H1feH0gfSc0SXN83XSlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886199; c=relaxed/simple;
	bh=zWvKTNAKlfaKyLmnxPyqzWeB+4hJOUxXXjAo9PVxwlw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PfiVFKjuNgRlSMp6hCW8x4vJelkgO/mcNetyyfly6Y7PUMy1s6jsOcBa2avGndnn8/6lgz+nMW331262bLZWjqdW6qE/aRiZUSan4OIW7rXH+xS9LTNYhZDmLtEo4cN02OwAuN1V+Gpy6/94QnfOa6ym7KaStYqy6mCxAxXMIhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLb1Bgxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD82C4CEDD;
	Thu, 13 Mar 2025 17:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741886199;
	bh=zWvKTNAKlfaKyLmnxPyqzWeB+4hJOUxXXjAo9PVxwlw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pLb1BgxlqzOdfw15QvV14UuHOIGAwS0A0KCRTc/zF4KFJ7WyCwHGxUQIcnFJAKREH
	 K9p9N6lwlw4tnSxiEogbx+3fsQUSRRuqWPIaBKn7WeUAjzZxR6oL+s7ZiCgBUbDMdp
	 q4ekXP7Ufa8kTZ7QrGo9tILd3LPsGdUe7+NLVD81D4IAfAGQDFNL+j3Yz1C3vPqZvg
	 wmIEzGBxozhlPGNvcRAaLdJZehx8vOqsUfWBRVdrSuIZy2BYykPdMdQPB0qBm8sDvZ
	 7ktxPUB+rmqCKWUyjY6BJ8Jg5ZRBv6995rtd7Nxsb9pRKIt0tPnAsWvnTL+Wt9m5xH
	 0lDyuwxydXp4w==
Date: Thu, 13 Mar 2025 12:16:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	mhi@lists.linux.dev, linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org, quic_pyarlaga@quicinc.com,
	quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com,
	quic_mrana@quicinc.com,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v2 09/10] PCI: Add function to convert lnkctl2speed to
 pci_bus_speed
Message-ID: <20250313171637.GA739165@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-mhi_bw_up-v2-9-869ca32170bf@oss.qualcomm.com>

On Thu, Mar 13, 2025 at 05:10:16PM +0530, Krishna Chaitanya Chundru wrote:
> Add a exported function to convert lnkctl2speed to enum pci_bus_speed,
> so that other kernel drivers can use it.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/pci.c   | 12 ++++++++++++
>  include/linux/pci.h |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 869d204a70a3..75505437a9c9 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6011,6 +6011,18 @@ int pcie_link_speed_mbps(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL(pcie_link_speed_mbps);
>  
> +/**
> + * pci_lnkctl2_bus_speed - converts lnkctl2 speed to pci_bus_speed

I try to use imperative mood ("convert lnkctl2") to match commit log
style.

> + * @speed: LNKCAP2 SLS value
> + *
> + * Returns pci_bus_speed

Not sure how strict kernel-doc is about this, but I've been told
it wants "Return:" with a colon here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/doc-guide/kernel-doc.rst?id=v6.13#n142

