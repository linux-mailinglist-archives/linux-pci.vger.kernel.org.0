Return-Path: <linux-pci+bounces-5982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7BA89E598
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 00:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BEC71F22461
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 22:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE90158D7A;
	Tue,  9 Apr 2024 22:18:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDFE12BE9C;
	Tue,  9 Apr 2024 22:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712701138; cv=none; b=Lyxw3oCqfCa51IKx85w4QX1wEwBnJKs8yD+15XgNvYOYIiSaNWjiX7tTbVKE/kQOEjxo8wGmF90Ul/Xe8h17Hd5NPSpcj4t0Gm2RbmdwWi2E7wqPsQ6M7QPHZKqlExJowor25/H0uAgOpWk4YIrADT0OHZntXTxPQ9p+gVs1GvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712701138; c=relaxed/simple;
	bh=y2tszdaM1fC5YIc0Gm6ueqCafjpPYIuDlP4nL1uDwj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uu4SwJr/owRNrLwUk45Q2OSNl5I6aN2W00gsg9nG16Hfe4kzZKKx8rfX8BysK+jmyz0tcmvPRpvJdW4KGwdgy2lbYapdudEkL4ORXI5Auj+1+Vo89scv0n2nrl/4WaFOXrwHuEMxvF8D/QO6GcZPz9sKZy7CgvNjKbhwWluY7qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 57C1B2800BD90;
	Wed, 10 Apr 2024 00:18:48 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 385AB992F90; Wed, 10 Apr 2024 00:18:48 +0200 (CEST)
Date: Wed, 10 Apr 2024 00:18:48 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>,
	kobayashi.da-06@jp.fujitsu.com, linux-cxl@vger.kernel.org,
	y-goto@fujitsu.com, linux-pci@vger.kernel.org, mj@ucw.cz,
	dan.j.williams@intel.com
Subject: Re: [PATCH v4 3/3] cxl/pci: Add sysfs attribute for CXL 1.1 device
 link status
Message-ID: <ZhW-yBR-u6DP9N3p@wunner.de>
References: <20240409073528.13214-4-kobayashi.da-06@fujitsu.com>
 <20240409150540.GA2076036@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409150540.GA2076036@bhelgaas>

On Tue, Apr 09, 2024 at 10:05:40AM -0500, Bjorn Helgaas wrote:
> On Tue, Apr 09, 2024 at 04:35:28PM +0900, Kobayashi,Daisuke wrote:
> > Add sysfs attribute for CXL 1.1 device link status to the cxl pci device.
> > 
> > In CXL1.1, the link status of the device is included in the RCRB mapped to
> > the memory mapped register area. Critically, that arrangement makes the link
> > status and control registers invisible to existing PCI user tooling.
> 
> Idle thought: PCIe does define RCRB, even pre-CXL.  Maybe the PCI core
> should be enhanced to comprehend RCRB directly?

The way CXL 1.1 (ab)uses the RCRB differs from what the PCIe Base Spec
envisions:

Per PCIe r6.2 sec 7.2.3, the RCRB contains additional Extended Capabilities
of a Root Port -- in addition to those in the Root Port's Config Space.
What we could do in the PCI core to support this is to amend our helpers
which search for Extended Capabilities to also search for them in the RCRB.

In fact, two years ago I cooked up a patch which does exactly that:

https://github.com/l1k/linux/commit/3eb94f042527

And I cooked up another patch to fetch the RCRB's address from the CXL
Early Discovery ACPI table:

https://github.com/l1k/linux/commit/d9d3cf45cf8c

The reason I never submitted the patches?  I realized after the fact that
CXL 1.1 uses the RCRB in a completely different way:

Per CXL r3.0 sec 8.2.1, RCH Downstream and RCD Upstream Ports do not
actually possess a Config Space.  Instead, they possess *only* an RCRB.
And that RCRB contains a Type 1 Configuration Space Header.

But because the PCIe Base Spec prescribes that there has to be an
Extended Capability at offset 0 of the RCRB, the CXL spec puts a
Null Extended Capability at offset 0 so that the Type 1 Config Space
Header is skipped.

However this means that the first dword of the Type 1 Config Space
Header does not contain a Vendor ID and Device ID.

So what we could do is create a fake pci_dev for each RCH Downstream and
RCD Upstream Port plus a specially crafted struct pci_ops whose ->read()
and write() callbacks access the RCRB.  But how do we know which Vendor
and Device ID to return from a ->read()?  There is none in the RCRB!

The CXL Consortium seems to have realized the mess they made with
CXL 1.1 and from CXL 2.0 onwards everything is now a proper PCI device.
I talked to Dan about my findings and his decision was basically to
not enable any of that legacy CXL 1.1 RCRB functionality in the kernel.

Thanks,

Lukas

