Return-Path: <linux-pci+bounces-22383-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE52A44DB4
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 21:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE611176995
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 20:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E189220D51E;
	Tue, 25 Feb 2025 20:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHf0cPdM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ECB20D4FF;
	Tue, 25 Feb 2025 20:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515426; cv=none; b=OGqS+zYA8Rvx4rhJ/Ztj97raP7R2exFtjf5K2T3A4wi0dQMbh11r7IjgZZmKtMSTB182xLpUDQgjjccuav/z/H4xflSk0i6csU/GD9Jsdf8Fq+wLvZ5N2hzNwa30nJHe4aBW5CxjSrHQWsD7cavSQXYcHGiS9HhrM6jHxea8jJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515426; c=relaxed/simple;
	bh=rovhXK4tfCJIYykPC7TY04RQpYyM+0gQ2VvPGXE/Yuk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KvzqcgbDfBG5vn3lYjPBabLcxRcdS/H4edFIhz9JeffDwlazlMUGRFUdxVQhnfkGnT1c00bsa1rn1PvPWcAc6ZHKm6uurIS4J8vNfv7nCqzBbwueVRHmraLH69TrcVT01N4EX0eENS1XuyBJm/S1VDe2rlw8Z2CgkbKpOAZ5DB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHf0cPdM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2324C4CEDD;
	Tue, 25 Feb 2025 20:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740515426;
	bh=rovhXK4tfCJIYykPC7TY04RQpYyM+0gQ2VvPGXE/Yuk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iHf0cPdMNyr+SfdTQ6MirU675NOHmGp9hQvw4v9c5KCbQi8bWOgY7K5VioqSQkCn6
	 YPjReAOaSs66s3suFj25s4dVLkI4oThna0W5oIdOQX80PLiieLT56N/V/hkjnGy7UC
	 vlHgD4LcQyvuapnKabZ7dqhJVXRH+Xo7S8Ywm/UJIaIi8KbITp8d5g6iFpHbDZwLaj
	 c4FR09tBO7po8pcmcOsZne2DKCYshzVOyigxMIjibSYAAAVNleD3w5USJ/oIvZYSCv
	 sZMaapDJOXvte1BJHIIpL5xPiDGtMr37t4K7rdfc72kN7wdMrIDZxSj2G5/J6oDcQ3
	 jdFcnp6LkMuNg==
Date: Tue, 25 Feb 2025 14:30:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Gupta, Anshuman" <anshuman.gupta@intel.com>
Cc: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"De Marchi, Lucas" <lucas.demarchi@intel.com>,
	"Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	"Nilawar, Badal" <badal.nilawar@intel.com>,
	"Nasim, Kam" <kam.nasim@intel.com>,
	"Gupta, Varun" <varun.gupta@intel.com>
Subject: Re: [RFC 1/6] PCI/ACPI: Implement PCI FW _DSM method
Message-ID: <20250225203024.GA516174@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR11MB62113F649A1AF98D33ACE0AC95C32@CY5PR11MB6211.namprd11.prod.outlook.com>

On Tue, Feb 25, 2025 at 06:25:52PM +0000, Gupta, Anshuman wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> ... redundant headers snipped

> > On Mon, Feb 24, 2025 at 10:18:44PM +0530, Anshuman Gupta wrote:
> > > Implement _DSM method 10 and _DSM Method 11 as per PCI firmware
> > specs
> > > section 4.6.10 and 4.6.11.
> > 
> > Please split into two patches, one for each _DSM.  Include spec
> > citations, e.g., PCI Firmware r3.3, sec 4.6.10.  Section numbers
> > are not guaranteed to stay consistent across spec revisions, so we
> > need both the revision and section number.
> > 
> > Include some descriptive words about the DSM in each subject line,
> > e.g., "D3cold Aux Power Limit", "PERST# Assertion Delay".
> > 
> > > Current assumption is only one PCIe Endpoint driver (XeKMD for
> > > Battlemage GPU) will request for Aux Power Limit under a given Root
> > > Port but theoretically it is possible that other Non-Intel GPU or
> > > Non-GPU PCIe Endpoint driver can also request for Aux Power Limit and
> > > request to block the core power removal under same Root Port.
> > > That will disrupt the Battlemage GPU VRAM Self Refresh.
> > 
> > I guess this is sort of an acknowledgement of the r3.3, sec 4.6.10 spec text
> > about system software being responsible for tracking and aggregating
> > requests when there are multiple functions below the Downstream Port?

> AFAIU apart from multiple function below the Downstream Port (from
> same PCIe Card), there can be possibility of another PCie card
> connected via a switch to same root port like below topology.
> 
> 			                 |-> PCIe PCIe Downstream Port -> End Point Device 	
> Root Port -> PCIe Upstream Port   |-> PCIe PCIe Downstream Port -> End Point Device	
> 			                 |-> PCIe PCIe Downstream Port -> PCIe Upstream Port ->  PCIe Downstream Port -> *EndPoint Device 	
> 
> *Endpoint Device from different PCIe card can also request to block the core power removal under same Root Port ?

Of course.

>  How to document such limitation ?

> > If so, remove the Battlemage-specific language and just say something about
> > the fact that this implementation doesn't do any of that tracking and
> > aggregation.

^^ Here's a hint about how to document this.  My point is that this
has nothing to do with Battlemage in particular, so the text about
Battlemage-specific things is a distraction from the real point, which
IIUC is this:

  Note that this implementation assumes only a single device below the
  Downstream Port because it does not track and aggregate requests
  from all child devices below the Downstream Port as required by sec
  4.6.10.

> > > One possible mitigation would be only allowing only first PCIe
> > > Non-Bridge Endpoint Function 0 driver to call_DSM method 10.

