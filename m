Return-Path: <linux-pci+bounces-27167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B4AAA96E8
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 17:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E4DE3A7BA4
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 15:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C267025D91E;
	Mon,  5 May 2025 15:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBSqCk/x"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869FD25D1F5;
	Mon,  5 May 2025 15:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746457519; cv=none; b=fjPw9KNB6DpUelc2eekQyoE7rOmOa+PFqnv1936hZEi17naq0/O5ZubgCmPjn6A85pQf6STNJGMfMfHfkDj8QbVMRbmqFdM2aIC5Kqe/o++OC4J1uHjrBqkrMrRsfUJYM55pQfMtAR7eu76VVu6/mVCoLq4/PGwuF6qVVcQXNrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746457519; c=relaxed/simple;
	bh=tVwY1GhHmqP4tNt6PF7NZ89nMFSpxg7uRS+j8Qo6g3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVnKoSZ4BP//ELveHHVzoAfQwcLXVmsaWre3hvzcF1wI6uCmBQA1CYIlmbEFTAXePVJQwKw+EKVwADfsQJhzGe/PiHyTNPg1ui9AnDNlreU+soTJcfTX6V89eAnC1ha2yr6yTeHh9sb3/5iiEIYzswTsobOJ7vKbeYe9IEwRhFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBSqCk/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F76CC4CEE4;
	Mon,  5 May 2025 15:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746457518;
	bh=tVwY1GhHmqP4tNt6PF7NZ89nMFSpxg7uRS+j8Qo6g3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GBSqCk/xbHGCM6+NNMlpLQtOhHa+ERjy2QkOGRQzAhDpyDdOUa/ne7UZQ4uiH2bGy
	 utwN7dvaElYocZWWZ8zV+ilIOEUxgzRxIYWDmAyZwGFBzppVTztXR2ITc7/LUHeVaD
	 l8t58dkIeX9CikCl4ZG3QKczALeaRoEermE6CuDbOzrQ4HKmDj1iZ0sm/egm+N6XFR
	 2ZagUpMpX52vB/uJ/qVM5cSMENXexwQ60phGkPFo5OGKJ3RyTCmFWi3RjWqZ94j+u1
	 8s48ANOuF7cnPTaPjlyFVTKMGhFYvV9JmRJLZ482FwgaxRJO6Qa/cJWEc4cH3jxkQq
	 TN1/EnXSDIdkg==
Date: Mon, 5 May 2025 17:05:10 +0200
From: Niklas Cassel <cassel@kernel.org>
To: manivannan.sadhasivam@linaro.org
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>,
	Will Deacon <will@kernel.org>, Robert Richter <rric@kernel.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Marc Zyngier <maz@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>, dingwei@marvell.com,
	Lukas Wunner <lukas@wunner.de>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, wilfred.mallawa@wdc.com
Subject: Re: [PATCH v3 5/5] PCI: qcom: Add support for resetting the slot due
 to link down event
Message-ID: <aBjTpglI5_P2Q3Aa@ryzen>
References: <20250417-pcie-reset-slot-v3-0-59a10811c962@linaro.org>
 <20250417-pcie-reset-slot-v3-5-59a10811c962@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417-pcie-reset-slot-v3-5-59a10811c962@linaro.org>

Hello Mani,

On Thu, Apr 17, 2025 at 10:46:31PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> @@ -1571,6 +1652,9 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
>  		pci_unlock_rescan_remove();
>  
>  		qcom_pcie_icc_opp_update(pcie);
> +	} else if (FIELD_GET(PARF_INT_ALL_LINK_DOWN, status)) {
> +		dev_dbg(dev, "Received Link down event\n");
> +		pci_host_handle_link_down(pp->bridge);
>  	} else {
>  		dev_WARN_ONCE(dev, 1, "Received unknown event. INT_STATUS: 0x%08x\n",
>  			      status);

From debugging an unrelated problem, I noticed that dw-rockchip can
sometimes have both "link up" bit and "hot reset or link down" bit set
at the same time, when reading the status register.

Perhaps the link went down very quickly and then was established again
by the time the threaded IRQ handler gets to run.

Your code seems to do an if + else if.

Without knowing how the events work for your platforms, I would guess
that it should also be possible to have multiple events set.


In you code, if both LINK UP and hot reset/link down are set,
I would assume that you driver will not do the right thing.

Perhaps you want to swap the order? So that link down is handled first,
and then link up is handled. (If you convert to "if + if "instead of
"if + else if" that is.)


Kind regards,
Niklas

