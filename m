Return-Path: <linux-pci+bounces-39495-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C600C12FE4
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 06:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691253BB4A9
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 05:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC2A285CBC;
	Tue, 28 Oct 2025 05:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X051DoMX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28511D5CFB;
	Tue, 28 Oct 2025 05:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761630119; cv=none; b=RgmV2/cTWtiFXs3TgyJnD4D9o+DOjFrkQ7TRL0e5VdiqMa3lyDcj75N9NCfl4O+PSUrmXk/r9jWTz4NYT+9SesaMaoltnY90LhsQnKsCiqSk0Z7UHyMOV5aEH0xYkDt3o7K1mjYyzvSO69BAjK72S5rt2oyNsB0G1SbXm9z/BVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761630119; c=relaxed/simple;
	bh=8/uXmi+XIXvQ4p/XkUFktl68m0B/Pf+rWms2Wo9JxpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqdU8yBAXlgnOKgPO+2UdwsSjaa/Gfq1KOFvx4u7OfvyPdqtWyLsoKn0fzCoOxxZo36rjQQaefBJfuMkDfUD19s2ZJxa2tICFsxHqm5Q04eab3JcjvMKiTnS/tTcKtfpzxif/GZYNSOBpL0V62keSFNiQifte/8E2qg+CzMSw/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X051DoMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93C1C4CEE7;
	Tue, 28 Oct 2025 05:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761630118;
	bh=8/uXmi+XIXvQ4p/XkUFktl68m0B/Pf+rWms2Wo9JxpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X051DoMXaxOsnsF//9xEG2wmCbJ8s2fsxGCKNVTPdSyK+Fv8Znw4qfQCRKIB6Pw1b
	 TKwMqluyOV6QHjNqomD1sJ8DGqF3qSyDNOZCJz7fY1LU35sbCDyNzIc7E13pv+FFpO
	 CvOr8nPe5JFrkr0POXov6UvL0CmMpEf2mmTPAJUUA/DB83e/aI+nUMcqWF+6bY5MJm
	 JLXqUwkSzzNl7kloBOI9muF7mQ9VAtBeVUfw5pPSuLsYShSuVRAL91uygPDbhUPiK9
	 enqYy4teQjJxmuZV1NCqrr+PyIZNpdnm+K/NTTeBcE/TZL5hN1xLT9UI6FTxSrdYE1
	 PMx407Bjbg/Lg==
Date: Tue, 28 Oct 2025 11:11:46 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Vitor Soares <ivitro@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Vitor Soares <vitor.soares@toradex.com>, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: PCI: ti,j721e-pci-host: Add optional
 regulator supplies
Message-ID: <wg2wpwex4vbwwxynk5salk6mbpneww76wfvznn442a2xyqrrck@a7qqqn3hjzcg>
References: <20251014112553.398845-1-ivitro@gmail.com>
 <20251014112553.398845-2-ivitro@gmail.com>
 <20251020-kickass-fervent-capybara-9c48a0@kuoka>
 <2c3e4bdefb306dc89c15bebc549d854ea2b4cc32.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c3e4bdefb306dc89c15bebc549d854ea2b4cc32.camel@gmail.com>

On Mon, Oct 27, 2025 at 11:22:26PM +0000, Vitor Soares wrote:
> Hi Krzysztof,
> 
> Thank you for the feedback.
> 
> On Mon, 2025-10-20 at 13:14 +0200, Krzysztof Kozlowski wrote:
> > On Tue, Oct 14, 2025 at 12:25:48PM +0100, Vitor Soares wrote:
> > > From: Vitor Soares <vitor.soares@toradex.com>
> > > 
> > > Add optional regulator supply properties for PCIe endpoints on TI SoCs.
> > > Some boards provide dedicated regulators for PCIe devices, such as
> > > 1.5V (miniPCIe), 3.3V (common for M.2 or miniPCIe), or 12V
> > > (for high-power devices). These supplies are now described as optional
> > > properties to allow the driver to control endpoint power where supported.
> > 
> > Last sentence is completely redundant. Please do not describe DT, we
> > all can read the patch. Driver is irrelevant here.
> > 
> > 
> Ack, I will remove last sentence.
> 
> > 
> > How you described here and in descriptions, suggests these are rather
> > port properties, not the controller.
> 
> You are right - these supplies power the PCIe slot/connector, not the controller
> itself. However, as per my understanding, the current kernel practice is to
> place slot supplies in the root complex node rather than the endpoint node. as
> seen in e.g.:
> - imx6q-pcie.yaml
> - rockchip-dw-pcie.yaml
> - rcar-pci-host.yaml
> 
> This seems consistent with those existing bindings, but please let me know if
> I’m overlooking something specific to this case.
> 

We do not properly document it, but defining the slot supplies in host bridge
(controller) node is deprecated. Some bindings still do it for legacy reasons,
but the new ones should define them in the Root Port nodes as they belong to. We
do not have a separate DT node for PCI slots, but rather reuse the Root Port
node.

There are also bindings that define supplies in the endpoint node. They do it
for devices directly connected to the PCI bus without a connector (like in PCB).

- Mani

-- 
மணிவண்ணன் சதாசிவம்

