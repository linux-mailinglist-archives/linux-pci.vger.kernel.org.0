Return-Path: <linux-pci+bounces-29437-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347BCAD55A4
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 14:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCBA47A6CFC
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 12:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B64272E63;
	Wed, 11 Jun 2025 12:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiM9yxD6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB33927C864;
	Wed, 11 Jun 2025 12:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749645288; cv=none; b=HfNbkJNDMkA0bdi9rv/P5/xoF3n9KDSH6ocPbdNXdZeRoqA9On5ZwLDCJgXLvfcd4vcCLAWC8Y8FWuX0ZbXe2P39gocTNMPclj35fTyY0QMs4b2kmmFz3YxrvxWsELkr6F+Xy9YRW5mSgf9mLBVczcCAJL7eyuSr0nHj57rrcUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749645288; c=relaxed/simple;
	bh=94aY9ORBcSVbBqk9ahiKUVj4/SWVjjIGCogb4ANaBlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uctrrZvsY3KPHT2sUzRS+8SHloJvmiFZtcWeBgNWciX846f+8AKER0Krv4Nzrqs7+2XcbRUVhrMHaUZtgQUDZMUEbso7VoUWgxwM5o2KGdwLFk8rfG9zgXi7hgirMXszmUUj+0eJRxSg3oZfqTc6j+hAhOlv+PHL/UyjhjgK6Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiM9yxD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27365C4CEF0;
	Wed, 11 Jun 2025 12:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749645288;
	bh=94aY9ORBcSVbBqk9ahiKUVj4/SWVjjIGCogb4ANaBlY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PiM9yxD65tgRtXwanDDohsgWMGPhDG82gyCHdJDYCmjCJ+d1fG5H15TGYVPMmH6R4
	 VByn2DUJ3pS7ex5xhMgmsHoJ7oK3h0lm/OO2himtBgo3WDVwkhHJJ4TU38miQnzIqc
	 JEhrpjtT8/Mdla3HSb7cqN82lAiyt0iUV+p2B/4KnISZvXWyy1y59Qv5gZMKA0qUaE
	 2E8B8WMnF+HI8xfTcHJs8qtmq7KtmSdW5ATS3HRoMoFwk0qVvEH8cYrHdd6vdSc8lS
	 PNWHAW4ymfld8lmyy14KwJ79HO0bXh+v/8MhzV6XqEKCXrWy3l1YMNliL5rBVcHdVl
	 7be8VorZvwwbQ==
Message-ID: <3d745c75-5f41-46ff-a276-cc9b8be84dc3@kernel.org>
Date: Wed, 11 Jun 2025 21:34:46 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] PCI: qcom: Do not enumerate bus before endpoint
 devices are ready
To: Niklas Cassel <cassel@kernel.org>, Manivannan Sadhasivam
 <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 Laszlo Fiat <laszlo.fiat@proton.me>, linux-arm-msm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250611105140.1639031-6-cassel@kernel.org>
 <20250611105140.1639031-8-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250611105140.1639031-8-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/25 19:51, Niklas Cassel wrote:
> Commit 36971d6c5a9a ("PCI: qcom: Don't wait for link if we can detect Link
> Up") changed so that we no longer call dw_pcie_wait_for_link(), and instead
> enumerate the bus directly after receiving the Link Up IRQ.
> 
> This means that there is no longer any delay between link up and the bus
> getting enumerated.
> 
> As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link speeds
> greater than 5.0 GT/s, software must wait a minimum of 100 ms after Link
> training completes before sending a Configuration Request.
> 
> Add this delay in the threaded link up IRQ handler in order to satisfy
> the requirements of the PCIe spec.
> 
> Fixes: 36971d6c5a9a ("PCI: qcom: Don't wait for link if we can detect Link Up")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index c789e3f85655..0a627f3b5e2c 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1565,6 +1565,13 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
>  
>  	if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
>  		dev_dbg(dev, "Received Link up event. Starting enumeration!\n");

Same comment here as for the dw-rockchip. Sleep before printing the message ?

> +		/*
> +		 * As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports
> +		 * Link speeds greater than 5.0 GT/s, software must wait a
> +		 * minimum of 100 ms after Link training completes before
> +		 * sending a Configuration Request.
> +		 */
> +		msleep(PCIE_T_RRS_READY_MS);
>  		/* Rescan the bus to enumerate endpoint devices */
>  		pci_lock_rescan_remove();
>  		pci_rescan_bus(pp->bridge->bus);

Either way,

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

