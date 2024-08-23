Return-Path: <linux-pci+bounces-12141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C3295D856
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 23:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5DA5B20E40
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 21:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978441C7B91;
	Fri, 23 Aug 2024 21:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbuk5SJz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A521191F8F;
	Fri, 23 Aug 2024 21:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724447576; cv=none; b=KtM7ybLVpDq46oeTWh/89t5MDZ+3Uso6Kv3sBFn9e9LiEIiY2RDHT4Hpv2ZEre6a53sGr30s4yYFmxKQw62NCqDwkNfoZNEsOgAiNtZ7JxmSXLBuEJlxWbmJj2vggd+AhjaZKv68TxRIOC6MVppDa98ypVSOrPe/M6MKC0QIs5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724447576; c=relaxed/simple;
	bh=LQKVwpMp7vYA/2Gg3LUgcaCHxAp/8DRrdXx+MEYslWw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DYBvvoEECnWl3k4xVdKkLnOh/P/9lC3e2xzR0uZm0AIQTd688wcCKOA9q7rAbo/8OEC6edchDOVfD8KwonybgDACVEevXRG8g8461mRD/Esmz6HFdtPSpxhrkPx2qPbSdI6VkneGAjlxONa1PHaswAkc9Oceozfn3zpn7GjUqsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbuk5SJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DBCC32786;
	Fri, 23 Aug 2024 21:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724447576;
	bh=LQKVwpMp7vYA/2Gg3LUgcaCHxAp/8DRrdXx+MEYslWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mbuk5SJza3vHmCXtGndQ8oEDK7MBiyMz4VouiWT+mqiiY5jDaeYJAOW59W+l77ETJ
	 oXbZQ5RBjQhPxLWF8t8rY04hTbsX0g/bEhVKRiwI7f1v2/jWQtM9iWmv+VRFVBNIjN
	 4mXxeSFgr/AA8GQYvRZgrbEXEs2uEfuR/1zd0d6ELHFPpMhLv8Bcs3N6hHTX5gekPB
	 J2xIc+hLnO5iqhgEDKk5I5ASwcJ1YMy6sXSucn01WE1duzkAFdvfc79bw3a8YW98yE
	 YUuNmSWjcaZku45kDm/bjdXstlEsevYYk5o42x9zDdJgxjO7zZFqOqeT65+jj77+J1
	 QlTUTZp14oHdQ==
Date: Fri, 23 Aug 2024 16:12:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Esther Shimanovich <eshimanovich@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	iommu@lists.linux.dev, Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PCI: Detect and trust built-in Thunderbolt chips
Message-ID: <20240823211254.GA385934@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823-trust-tbt-fix-v4-1-c6f1e3bdd9be@chromium.org>

On Fri, Aug 23, 2024 at 04:53:16PM +0000, Esther Shimanovich wrote:
> Some computers with CPUs that lack Thunderbolt features use discrete
> Thunderbolt chips to add Thunderbolt functionality. These Thunderbolt
> chips are located within the chassis; between the root port labeled
> ExternalFacingPort and the USB-C port.

Is this a firmware defect?  I asked this before, and I interpret your
answer of "ExternalFacingPort is not 100% accurate all of the time" as
"yes, this is a firmware defect."  That should be part of the commit
log and code comments.

We (of course) have to work around firmware defects, but workarounds
need to be labeled as such instead of masquerading as generic code.

> These Thunderbolt PCIe devices should be labeled as fixed and trusted,
> as they are built into the computer. Otherwise, security policies that
> rely on those flags may have unintended results, such as preventing
> USB-C ports from enumerating.
> 
> Detect the above scenario through the process of elimination.
> 
> 1) Integrated Thunderbolt host controllers already have Thunderbolt
>    implemented, so anything outside their external facing root port is
>    removable and untrusted.
> 
>    Detect them using the following properties:
> 
>      - Most integrated host controllers have the usb4-host-interface
>        ACPI property, as described here:
> Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#mapping-native-protocols-pcie-displayport-tunneled-through-usb4-to-usb4-host-routers
> 
>      - Integrated Thunderbolt PCIe root ports before Alder Lake do not
>        have the usb4-host-interface ACPI property. Identify those with
>        their PCI IDs instead.
> 
> 2) If a root port does not have integrated Thunderbolt capabilities, but
>    has the ExternalFacingPort ACPI property, that means the manufacturer
>    has opted to use a discrete Thunderbolt host controller that is
>    built into the computer.

Unconvincing.  If a Root Port has an external connector, is it
impossible to plug in a Thunderbolt device to that connector?  I
assume the wires from a Root Port could be traces on a PCB to a
soldered-down Thunderbolt controller, OR could be wires to a connector
where a Thunderbolt controller could be plugged in.  How could we tell
the difference?

>    This host controller can be identified by virtue of being located
>    directly below an external-facing root port that lacks integrated
>    Thunderbolt. Label it as trusted and fixed.
> 
>    Everything downstream from it is untrusted and removable.
> 
> The ExternalFacingPort ACPI property is described here:
> Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-externally-exposed-pcie-root-ports

