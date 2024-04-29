Return-Path: <linux-pci+bounces-6752-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EEE8B50DB
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 07:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5FBF1F22058
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 05:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D9CDF5C;
	Mon, 29 Apr 2024 05:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2OoIamw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE74DDD8;
	Mon, 29 Apr 2024 05:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714370235; cv=none; b=PHw91w2wBcXruHLvrlSKil8QC1+DMRpJY3CYcNQc+3VC+t9U3hhQHXDUfioM0+tXFkekYPvt+fbjuJsP07VyD/dUxu4hZ6SgEDtdkGnjXpo5T4aqlBVs6VmRlaUN0000yIjSY+B4shnuTZL0p/Can1qEPs+b6pIxpvXuAvF1j70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714370235; c=relaxed/simple;
	bh=Y3JTxXiA/2VBJh7i4el44QgN8SPiNeyLeGOOlvqfmP0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nJgdMVa12/SirUBkEmIefz/rcY4OfqqxvNkrGTRX0F3y4Wv4yYbnPRTPXRoCqXJN/IDhacqDCKtel12xYqCpgLUD4qgCLI95jqOlzr726OmYD5jDCFS8p652OE/9LlDIfJvnh1KB52pxx4lRHQPvsPtRxEEMuP10PxXL+CLS5NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2OoIamw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95946C113CD;
	Mon, 29 Apr 2024 05:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714370234;
	bh=Y3JTxXiA/2VBJh7i4el44QgN8SPiNeyLeGOOlvqfmP0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=i2OoIamw2CGACWO/JQNbAGxyr7rJdGVbGok+nc8nzzVIZxeZvjG0Qr9HYAF5x1zO6
	 oJb/RNUsBYCfzCGKKylsm5WBZK8QmyjceFnIyDuj33+CEgD2AX82GDJBFmq8sOxpDt
	 GpXyVmV0jgPa4B+6HfVu7lrJWocleE4an4FaCmwXDmRCxZzrE4EWcZhtUjnLIqDzTF
	 yLnH8XfVKc5qNZOY6ouR16LRwSm+fr50ek46uPWZIEIyfy2iCpfN6UHNOEcTRPvqSs
	 nuPY1Gdu6ek6en/jw4r5cKNXDzAeUgvZ+EgltFrnweJ924jq2OB+ivLkQ5qUnwevFC
	 LWWJCOR8HpWlA==
Message-ID: <ce49c67c24f57ffab166d688a1c9e3139733f412.camel@kernel.org>
Subject: Re: [PATCH 1/1] cxl/acpi.c: Add buggy BIOS hint for CXL ACPI lookup
 failure
From: PJ Waskiewicz <ppwaskie@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 28 Apr 2024 22:57:13 -0700
In-Reply-To: <20240409132241.GA2071709@bhelgaas>
References: <20240409132241.GA2071709@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-09 at 08:22 -0500, Bjorn Helgaas wrote:
> On Sun, Apr 07, 2024 at 02:05:26PM -0700, ppwaskie@kernel.org=C2=A0wrote:
> > From: PJ Waskiewicz <ppwaskie@kernel.org>
> >=20
> > Currently, Type 3 CXL devices (CXL.mem) can train using host CXL
> > drivers on Emerald Rapids systems.=C2=A0 However, on some production
> > systems from some vendors, a buggy BIOS exists that improperly
> > populates the ACPI =3D> PCI mappings.
>=20
> Can you be more specific about what this ACPI =3D> PCI mapping is?
> If you already know what the problem is, I'm sure this is obvious,
> but
> otherwise it's not.

Apologies for the delay in response.  Things got a bit busy with travel
and whatnot...

On one of these particular hosts, in /sys/bus/acpi/devices/ACPI0016:00,
for example, the UID would be something like CX01.  It isn't an u64 at
all, and there's no atoi() or other conversions that would match what
the UID should be.

In my case, /sys/bus/acpi/devices/ACPI0016:02/ is my CXL device in
question. The UID that is presented from enumeration was CX02.=20
However, if I scour the CEDT manually, the UID of my particular CXL
device is really UID 49.

So, if I went from the PCI/CXL device side, and called something along
the lines of to_cxl_host_bridge() and tried to go from the pci_dev to
the acpi_handle, I'd get CX02 back.  Then trying to use that to call
acpi_table_parse_cedt() would fail.

The BIOS fix from the vendor corrected the UID enumeration on the ACPI
side.  This allowed things to properly line up when traversing through
the kernel APIs and parsing the ACPI tables.

Let me know if this helps clarify!  If not, I can try and get more
detailed info.

-PJ

