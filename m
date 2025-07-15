Return-Path: <linux-pci+bounces-32124-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E324AB053B7
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 09:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C090F3B235F
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 07:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B45B272E6F;
	Tue, 15 Jul 2025 07:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4PiMWDx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B4A272E44;
	Tue, 15 Jul 2025 07:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752565906; cv=none; b=dhbqrIO7XxQU5UFdx0T6jbObHRBebA1rlP+nGhI2nHG+SFHiB0UoxZcRAPPzVapJwe8x1Vij/UdIwMis3cKVtO/EnTaJtxb/newH8qjjKBPQUxeHaxbVPpOM07hdHI1x/JZI5tzWcXXZjhsYUc+klzg9Y3qtGbOpC4RYLTDZP/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752565906; c=relaxed/simple;
	bh=6x1KRSzdomSDsRyshFJ77N8rRIUyIQmJlOGqX3b1hTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEsCJNoOhOJ1GnJK0Pr9GxdQbjHH2O1hRBuaqQLzVSLYQYjx09oO4JRgzoQK83n6OG2JAf3YVoTNVP4WfpRZJHOcWmNR5DDl/zUFUECPa2mD8jWpleN4M/VHPeiIxV+/I8amMDmFbGXHqoLdwqgMobCDGBmKhY7MDYTJNSQeuUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4PiMWDx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA46C4CEE3;
	Tue, 15 Jul 2025 07:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752565905;
	bh=6x1KRSzdomSDsRyshFJ77N8rRIUyIQmJlOGqX3b1hTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M4PiMWDxDPbEANW2afC+ina1KFhv5pLN87srpE1+AcX8LvVvz2DlIZ5Di0W/qanT0
	 QpIk/qvksHcmNd8FKPk6cET5mXgNoai45vTAf16XQVSPsGS4I5zrL/SGOnbnSM84rV
	 BlzQndx8nwG8izYMoZCeJBb6QcJ+bxzMTqWjKpoBVx9vh/9x1bDtNo1/Ui08TVxufr
	 /5cSw4D/CAqS4nOFKNPr5WmKbOGjJ42VYpHxENoo+ek+3lL5+YoSnXj1IUn3M482vE
	 iB5JBkWZfpH8TzbOy4t3+ogMt/kcWEkmbjXO/WFZRQyHtwAFwx+iel38V+l8QwoC+E
	 NqgunYITYtKDw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1ubaRw-000000002do-3OyH;
	Tue, 15 Jul 2025 09:51:40 +0200
Date: Tue, 15 Jul 2025 09:51:40 +0200
From: Johan Hovold <johan@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] PCI: qcom: Move qcom_pcie_icc_opp_update() to
 notifier callback
Message-ID: <aHYIjEbOhM4xvavJ@hovoldconsulting.com>
References: <20250714-aspm_fix-v1-0-7d04b8c140c8@oss.qualcomm.com>
 <20250714-aspm_fix-v1-2-7d04b8c140c8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714-aspm_fix-v1-2-7d04b8c140c8@oss.qualcomm.com>

On Mon, Jul 14, 2025 at 11:31:05PM +0530, Manivannan Sadhasivam wrote:
> It allows us to group all the settings that need to be done when a PCI
> device is attached to the bus in a single place.

This commit message should be amended so that it makes sense on its own
(e.g. without Subject).

> @@ -1616,8 +1616,6 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
>  		pci_lock_rescan_remove();
>  		pci_rescan_bus(pp->bridge->bus);
>  		pci_unlock_rescan_remove();
> -
> -		qcom_pcie_icc_opp_update(pcie);
>  	} else {
>  		dev_WARN_ONCE(dev, 1, "Received unknown event. INT_STATUS: 0x%08x\n",
>  			      status);
> @@ -1765,6 +1763,7 @@ static int pcie_qcom_notify(struct notifier_block *nb, unsigned long action,
>  	switch (action) {
>  	case BUS_NOTIFY_BIND_DRIVER:
>  		qcom_pcie_enable_aspm(pdev);
> +		qcom_pcie_icc_opp_update(pcie);

I guess you should also drop the now redundant
qcom_pcie_icc_opp_update() call from probe()?

>  		break;
>  	}

Johan

