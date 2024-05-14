Return-Path: <linux-pci+bounces-7459-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8866E8C56F1
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 15:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645E0280C8E
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 13:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5EF1552EF;
	Tue, 14 May 2024 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/72oiVi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B393154C1E;
	Tue, 14 May 2024 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692673; cv=none; b=kFa5CDBELWpjgqJwvSXURHqSiMAip2F/UF6M8l4qy6uAuI8ns/b+JfCepUog9RzY7qGlopA2SqGOCF5nnju6BD6cul43o2UsbF1K0mhQmZt/flB4wI+vK/uE2Fak9mG7fLn6RzSrl0ipqxJ8VVNgMSmNdONXxbqeAmFEj56wKUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692673; c=relaxed/simple;
	bh=MzymZe5AeNOy0Hys7FWPDKvERmnV15f9sS+TqgjbX8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6BsVrmA3LBdWAm5WAExs5ik0Q1ilX7bs4W8ne/Xxc/y80MpbObN0ylqR6xufybtgDnRdYI38n7MO9bNJDOFQdCDyzGwuWstbZKXM3eFCbUQqw5ibSNW5e0Ti+X6uX3huMIMPjL0/xLDcHL2Igtkb+uArMzaRBFMlddWorpn8z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/72oiVi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9D6C4AF0D;
	Tue, 14 May 2024 13:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715692672;
	bh=MzymZe5AeNOy0Hys7FWPDKvERmnV15f9sS+TqgjbX8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V/72oiViDqsWQvKmqmyN40qLGPky9eHG2WoE0hkT1b707HnFKH88hWVYmpJ874Z/w
	 6xuJMVhr80CCQo3v4IgQiOORTsZg/jgb+SlShgIBPI6qVOeq65OexVc67prVVsv8MO
	 ofdYqK1BI9jXaoYhh8AVDFqpENruOPASnQVOkFBxc4tkd7SBsMpO1vOeNpTgXTfgCY
	 fMzXYtxOD7I0J+njh6F7JwLh47u1CebSb6FczGKlQ+droxVIZK49i+bYfqEYCPtY1k
	 HnacziYsZZM2Re2LJNESxUpDFiv0fAvrD9cdb0CHrD+N5jErhJomMKy3FLEh6qFh4z
	 LFs2rD7aAyGgg==
Date: Tue, 14 May 2024 08:17:50 -0500
From: Rob Herring <robh@kernel.org>
To: matthew.gerlach@linux.intel.com
Cc: linux-kernel@vger.kernel.org, conor+dt@kernel.org,
	lpieralisi@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5] dt-bindings: PCI: altera: Convert to YAML
Message-ID: <20240514131750.GA1214311-robh@kernel.org>
References: <20240513205913.313592-1-matthew.gerlach@linux.intel.com>
 <171563836233.3319279.14962600621083837198.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171563836233.3319279.14962600621083837198.robh@kernel.org>

On Mon, May 13, 2024 at 05:12:42PM -0500, Rob Herring (Arm) wrote:
> 
> On Mon, 13 May 2024 15:59:13 -0500, matthew.gerlach@linux.intel.com wrote:
> > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > 
> > Convert the device tree bindings for the Altera Root Port PCIe controller
> > from text to YAML.
> > 
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > ---
> > v5:
> >  - add interrupt-conntroller #interrupt-cells to required field
> >  - don't touch original example dts
> > 
> > v4:
> >  - reorder reg-names to match original binding
> >  - move reg and reg-names to top level with limits.
> > 
> > v3:
> >  - Added years to copyright
> >  - Correct order in file of allOf and unevaluatedProperties
> >  - remove items: in compatible field
> >  - fix reg and reg-names constraints
> >  - replace deprecated pci-bus.yaml with pci-host-bridge.yaml
> >  - fix entries in ranges property
> >  - remove device_type from required
> > 
> > v2:
> >  - Move allOf: to bottom of file, just like example-schema is showing
> >  - add constraint for reg and reg-names
> >  - remove unneeded device_type
> >  - drop #address-cells and #size-cells
> >  - change minItems to maxItems for interrupts:
> >  - change msi-parent to just "msi-parent: true"
> >  - cleaned up required:
> >  - make subject consistent with other commits coverting to YAML
> >  - s/overt/onvert/g
> > ---
> >  .../devicetree/bindings/pci/altera-pcie.txt   | 50 ----------
> >  .../bindings/pci/altr,pcie-root-port.yaml     | 93 +++++++++++++++++++
> >  2 files changed, 93 insertions(+), 50 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/pci/altera-pcie.txt
> >  create mode 100644 Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/altr,pcie-root-port.example.dtb: pcie@c00000000: interrupt-map: [[0, 0, 0, 1, 2, 1, 0, 0, 0], [2, 2, 2, 0, 0, 0, 3, 2, 3], [0, 0, 0, 4, 2, 4]] is too short
> 	from schema $id: http://devicetree.org/schemas/altr,pcie-root-port.yaml#

You need 3 address cells after the phandles since the interrupt parent 
has 3 address cells. 

What does your actual DT contain and do interrupts work because 
interrupts never would have worked I think? Making the PCI host the 
interrupt parent didn't even work in the kernel until somewhat recently 
(maybe a few years now). That's why a bunch of PCI hosts have an 
interrupt-controller child node.

Rob

