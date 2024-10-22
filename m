Return-Path: <linux-pci+bounces-15014-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE379AB1B4
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 17:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 839AAB23FFB
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 15:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0C01A262A;
	Tue, 22 Oct 2024 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGEaNNs2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD071A00D6;
	Tue, 22 Oct 2024 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729609734; cv=none; b=Uoz/VRDQtSILuQY46W4mE/zRnKfCcXvdQIxv3U7/bwcJP/w8aLoPghtj/8HKj7AqsE4mdzZzVJKe0skOOW8coAtjFbq/bmY3+5SUIoCyIcx6M7adgKZgHmoXT7agqJW8+sMWRGb2/8e5OihMl7EtlJwu7RD+73XP9pIz4EioLec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729609734; c=relaxed/simple;
	bh=cIlRnBNJwJrtXoJqLOBSMuVOarun2lZbQOo3Iwvc/uA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZXH8ynhH+dV/TCbO9ryxMFEIfhEOUny/Ut1uCqKOPkOlrojZMEgxMg322HniIjFQHfyW+FWd7XNuy0TDhSjhRIRuCaTmACYFM9SDXO0BJ3me4Fg8x9UXNcCTbVONAuZGyoP+yP29kuI0tsLvXXOHfetP07GriprmYkSCpeXKPYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGEaNNs2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA364C4CEC3;
	Tue, 22 Oct 2024 15:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729609734;
	bh=cIlRnBNJwJrtXoJqLOBSMuVOarun2lZbQOo3Iwvc/uA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lGEaNNs28N20f7sSM85v/4fUXNCln//gN2LyFDKJEGmKAIepmOu1yg/fHDQ+AlpIB
	 9iDiFYJ3jZl0oqnvlyCIIo21gtka/ZlRM8T7InBAGmRWY0UoXS3O/4KJjwhpzt8ZVu
	 knLMAJ3ajEsNKBhJUJk4i2TUL3S0dg7fswQA3XBi60EwY1ddRI347fOaD9Q8GhusZD
	 FxUVp66rI7RdDHfgDSbS8zqlb/fjvdqRAiCpuRWlxGSvHsOEG7rzTb1Bfnj5Z+/ULg
	 P69dM1CByEW5CI5D3Ta1B6Z/gaEm/BjRjFtEEs0f29nhNQvBiP//JPFl5/SD94ok0u
	 SxV4/Dt9SQPsw==
Date: Tue, 22 Oct 2024 10:08:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] PCI: cpqphp: Fix and cleanups
Message-ID: <20241022150852.GA878966@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241022091140.3504-1-ilpo.jarvinen@linux.intel.com>

On Tue, Oct 22, 2024 at 12:11:36PM +0300, Ilpo Järvinen wrote:
> Fix one PCIBIOS_* return value confusion in cpqphp and cleanup a few
> other things.
> 
> v2:
> - Add a warning print if the path missing recursion is executed.
> 
> Ilpo Järvinen (4):
>   PCI: cpqphp: Fix PCIBIOS_* return value confusions
>   PCI: cpqphp: Use pci_bus_read_dev_vendor_id() to detect presence
>   PCI: cpqphp: Use define to read class/revision dword
>   PCI: cpqphp: Simplify PCI_ScanBusForNonBridge()
> 
>  drivers/pci/hotplug/cpqphp_pci.c | 47 +++++++++++++-------------------
>  1 file changed, 19 insertions(+), 28 deletions(-)

Applied to pci/hotplug for v6.13, thanks!

