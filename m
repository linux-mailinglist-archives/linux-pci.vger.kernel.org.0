Return-Path: <linux-pci+bounces-19133-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA01D9FF12B
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 19:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C783A3331
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 18:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F149154430;
	Tue, 31 Dec 2024 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbwIvcTB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF1D29415
	for <linux-pci@vger.kernel.org>; Tue, 31 Dec 2024 18:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735668818; cv=none; b=OirnROfg2oFVLlYH4g/rs9pJhNXE/WyY4HSNLE9elFm1xqa+1e/zGrF+HN5mlsWqRG0SdEOZAveyjp7Kno8ouPCJKSClMnqoVRyDefLwB7GbC8JN+Kn4nRXR69SB7QoJl+FN6KidZG/YofXRpMY7WdprjZMj52vlF7h8j9UjUrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735668818; c=relaxed/simple;
	bh=kfVA9Fw+YAUQ75SJrC7MRF1gZanYOSfE6nQjpjVx+dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWAsAh4DC+puv6jPXvDVtVF1TwBUwfzyzdLaGHGKs2zJVbaiSfY0dK06gTKwKcaENblNcwZoMS3ca8ni7JlpZQClThvOiHFm2T1RzfSohOYHXcJSCEVSzCRK5nGdDiX+MDLr5zQe8eZAb603iZ9/9zFPYoJm9OTRPFBHhNWGk68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbwIvcTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E62C4CED2;
	Tue, 31 Dec 2024 18:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735668817;
	bh=kfVA9Fw+YAUQ75SJrC7MRF1gZanYOSfE6nQjpjVx+dM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RbwIvcTB1J/tsFtrwC3bM/PZFqsQAALjBPcwFoAxiToR42R6xo3PO0CnKzTfcQwd1
	 D68aQoz8pK3IlbRSCc1j/2jL04Rh3jeNRGRvy6vogmamljiTgv5GsV7wpqIV5BAL8W
	 Z4eBRzLpxShI23AJ4dqQVs515NwPe+D/jAAzUvlAKhUpEF8ZxTouUnFUGLCf/k90LC
	 Oby2P1qo/PlBUqWm6kgtM3E5/isvdcXyfxKMqYHAZdvcGWRcMXPEq37xPQkpHr/VfC
	 o7pXqrw2XqApZLTQfSz3OFBQ30HEWsdYXm4NyUfNddMEKTA1FxDLvKnqMXNSFOeZ5+
	 9P0QwXG+r21gA==
Date: Tue, 31 Dec 2024 19:13:33 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Reject a negative nr_irqs value in
 dw_pcie_edma_irq_verify()
Message-ID: <Z3Q0TY873woxmsEC@ryzen>
References: <20241220072328.351329-2-cassel@kernel.org>
 <20241231155158.5edodo2r5zar3tfe@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241231155158.5edodo2r5zar3tfe@thinkpad>

On Tue, Dec 31, 2024 at 09:21:58PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Dec 20, 2024 at 08:23:29AM +0100, Niklas Cassel wrote:
> > Platforms that do not have (one or more) dedicated IRQs for the eDMA
> > need to set nr_irqs to a non-zero value in their DWC glue driver.
> > 
> > Platforms that do have (one or more) dedicated IRQs do not need to
> > initialize nr_irqs. DWC common code will automatically set nr_irqs.
> > 
> > Since a glue driver can initialize nr_irqs, dw_pcie_edma_irq_verify()
> > should verify that nr_irqs, if non-zero, is a valid value. Thus, add a
> > check in dw_pcie_edma_irq_verify() to reject a negative nr_irqs value.
> > 
> 
> Why can't we make dw_edma_chip::nr_irqs unsigned?

dw_edma is defined in drivers/dma/dw-edma/dw-edma-core.h
in struct dw_edma.

struct dw_pcie (defined in drivers/pci/controller/dwc/pcie-designware.h)
simply has a struct dw_edma as a struct member.

If you bounce on nr_irqs in:
drivers/dma/dw-edma/dw-edma-core.c
and in
drivers/dma/dw-edma/dw-edma-pcie.c
you can see that this driver uses signed int for this everywhere.

I didn't feel like refactoring a whole DMA driver.


dw_pcie_edma_irq_verify() is supposed to verify that nr_irqs is either
initialized to a valid value by a DWC PCIe glue driver, or that common
code initializes it.

If nr_irqs is initialized by a glue driver && "pci->edma.nr_irqs != ch_cnt",
dw_pcie_edma_irq_verify() returns error and avoids calling dw_edma_probe(),
thus it made sense for dw_pcie_edma_irq_verify() to also return error on
negative nr_irqs.


Kind regards,
Niklas

