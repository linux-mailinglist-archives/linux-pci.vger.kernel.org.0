Return-Path: <linux-pci+bounces-43559-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA89ECD8613
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 08:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B6ED3010CFA
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 07:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D7330BBA0;
	Tue, 23 Dec 2025 07:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqNJxkmG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7494830B524;
	Tue, 23 Dec 2025 07:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766474672; cv=none; b=TErJMOtk+Gy/gxEMLqaABnH38koeU9xL7n/8GAkDXh1Tjziffzvko6Mq5VCSEpm9AWDrWXSOd4L7e3IM5WvFE+5avyyI7v/COCUdf70hETIcJBHOzOQ1f/eQFskkZT+HzmfbdlDO1MH/BZILgvHH8l7BWP23hBqOLi2ZCepBjFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766474672; c=relaxed/simple;
	bh=34FfPNCZ3zJKC5FaRd1apWttSEZLajbqxZypsCUapz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fF6pLLsqkT9AEt7/Y2pP70M0lTugULrr+gp1Gbsh1wzOd699JwywnzMtJrWSy1ytEPD6beNpstiR4HJDu4qN7+m60IT5zH4c1NUzNs8QfIdp9k+GJnabKzqby8sK1XWRzfMC94D9Ib2ql2pHq6iApoWpBptrpQeXhDYwK6/9UH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqNJxkmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B25DC113D0;
	Tue, 23 Dec 2025 07:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766474672;
	bh=34FfPNCZ3zJKC5FaRd1apWttSEZLajbqxZypsCUapz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FqNJxkmGyHU0zfzOk824zGse417eVgD4tbTSne5GYA6+sbyvIV6GjAyyKGmpkOD6B
	 KQMSLIdKD4mRiUuhHZYci5tqbdNGZY8GAs00lYE5Mi85igQjGRpSQZxINYYkFAqnBv
	 uwY+GoCj17ZUdGPQmkGDJg/0+Bu+cM7gRz4Yt8HQveb4IQB/XEd2MNGU0vjR+r6JEe
	 InDo6ESG3/O1HYmtCD/Ty5lsU5XXKyVCklgSL7JXal8r3MH5wiRrW4R70SPRzWE7hg
	 W1RTq33WO4I/yPOIebWSx1DT+LVPnRKpqdXP6/60Np0qBtwM5BqN2X8CQchuAVtu6d
	 2+YTX9OxS4Ftg==
Date: Tue, 23 Dec 2025 08:24:26 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Subject: Re: [PATCH 2/5] PCI: dwc: Add new APIs to remove standard and
 extended Capability
Message-ID: <aUpDqu8598J4yNHb@ryzen>
References: <20251109-remove_cap-v1-0-2208f46f4dc2@oss.qualcomm.com>
 <20251109-remove_cap-v1-2-2208f46f4dc2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109-remove_cap-v1-2-2208f46f4dc2@oss.qualcomm.com>

Hello Qiang Yu,

I just saw that this patch was queued up.

dw_pcie_remove_ext_capability() basically seems to be identical to:
dw_pcie_ep_hide_ext_capability(), only that your new function does
not require previous cap as an argument (so it seems better).

It seems a bit silly to have two functions that do the same thing,
perhaps you can send a patch that removes dw_pcie_ep_hide_ext_capability()
and updates the only user of that function to use your new function?

Sorry for not seeing this earlier.


Kind regards,
Niklas

On Sun, Nov 09, 2025 at 10:59:41PM -0800, Qiang Yu wrote:
> On some platforms, certain PCIe Capabilities may be present in hardware
> but are not fully implemented as defined in PCIe spec. These incomplete
> capabilities should be hidden from the PCI framework to prevent unexpected
> behavior.
> 
> Introduce two APIs to remove a specific PCIe Capability and Extended
> Capability by updating the previous capability's next offset field to skip
> over the unwanted capability. These APIs allow RC drivers to easily hide
> unsupported or partially implemented capabilities from software.
> 
> Co-developed-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
> Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 53 ++++++++++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h |  2 ++
>  2 files changed, 55 insertions(+)

