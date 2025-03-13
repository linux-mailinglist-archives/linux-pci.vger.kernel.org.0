Return-Path: <linux-pci+bounces-23671-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1836A5FCD0
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 18:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C24E3B2DE0
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 17:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F057026A08D;
	Thu, 13 Mar 2025 17:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOMJmpg1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88E5269AE6;
	Thu, 13 Mar 2025 17:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885203; cv=none; b=sdeUsGbEJDEVsO4zbTS24VAWCgfllVCwSdYLkBS8iO+li325VV71PSaUy17/qQKisosZz+gs7Z4O2M/QjsGWod7Wf3GHTjekd7AYOVBuA7fIDZAAerXJkloZTDm3OLXZ9p8VuHQmfVJBxJReqB8nK8ne2xvo3ECBLZfenfBx5vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885203; c=relaxed/simple;
	bh=N/Sk6Qy4oI0JP7HDoZt5ci2IDjFnGW5PCPDjLtT2Uuo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CpBOoBJn4UxI7gugnVJK9Aoh9aY8G190SoSUeYYrV1KKklnLAZ9jEH0hb8/Yqy2DUdGkY5R+Qv5ercEWL/OrUkoBMZQ7CZWz8p7XBt0wafGVEpkf+SQTLJhXTrHp7OwqaHVx0oIGoAqwDck4kAqG4UXznOEBTpnuGwB9JtnA8uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOMJmpg1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165B0C4CEDD;
	Thu, 13 Mar 2025 17:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741885203;
	bh=N/Sk6Qy4oI0JP7HDoZt5ci2IDjFnGW5PCPDjLtT2Uuo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nOMJmpg1BHmbTTxLXiglAg+ddOPshoZfEp9X8pVRJTn+dGBoq7TLFiItX6j1wnSjL
	 1wzq8E0JrAcJLBIFmxPvuDMIE3cGpVjr73G6ExwhSMmKf6KWFxF9TI+PA15ZpHYY1r
	 VCnWVKKa81JvsT0ysDJ4xYi2o+qHCypxY9yWWmOTWzWUFRRjde0rVI+ZhdDrLLcVbV
	 X4v4ROwqE09VbDhNbCYB2i/adQtN3X4E7eDWzmnN2gVPUQFhHPoDfHRM9A9DQrZGIx
	 +cmIPM3YblbOXbPPyFfqvVJAReWWCxBxiQCD+inq1jw4+qgroOPXJnscqbVee9F6Tu
	 ZMOXPdj0NUaPg==
Date: Thu, 13 Mar 2025 12:00:01 -0500
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
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 01/10] PCI: update current bus speed as part of
 pci_bus_add_devices()
Message-ID: <20250313170001.GA738398@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-mhi_bw_up-v2-1-869ca32170bf@oss.qualcomm.com>

[+cc Bartosz since this is related to pwrctrl]

On Thu, Mar 13, 2025 at 05:10:08PM +0530, Krishna Chaitanya Chundru wrote:
> If the link is not up till the pwrctl drivers enable power to endpoints
> then cur_bus_speed will not be updated with correct speed.
> 
> As part of rescan, pci_bus_add_devices() will be called and as part of
> it update the link bus speed.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/bus.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 98910bc0fcc4..994879071d4c 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -432,6 +432,9 @@ void pci_bus_add_devices(const struct pci_bus *bus)
>  	struct pci_dev *dev;
>  	struct pci_bus *child;
>  
> +	if (bus->self)
> +		pcie_update_link_speed((struct pci_bus *)bus);

Why the cast?  I guess to discard "const"?  I would prefer to avoid
that if we can.

The only existing callers of pcie_update_link_speed() are from bwctrl,
where it obviously makes sense because bwctrl manages link speed, and
from pci_set_bus_speed() in the pci_alloc_child_bus() path.

If we call pcie_update_link_speed() here, do we still need the
pci_set_bus_speed() in pci_alloc_child_bus()?

Bartosz, so you have any suggestions?  Is there a point in pwrctrl
where it would make sense to do this, similar to what bwctrl does?

>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>  		/* Skip already-added devices */
>  		if (pci_dev_is_added(dev))
> 
> -- 
> 2.34.1
> 

