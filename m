Return-Path: <linux-pci+bounces-44784-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB6BD206B1
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4D323037523
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 17:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CEA23C51D;
	Wed, 14 Jan 2026 17:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oX6fE5JY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFACD230D14
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 17:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768410236; cv=none; b=MYDHK+f5NKHWjCcz+6Thjc8kb+1qgk6cYc6xC4yAMzuP6s0X9AUqe8/q8KXFEWOoanw6Vzsnm7H9/IptYX5L5BqsnXFLMq5+L1n8nPpN2+zs9mG49rZzhP90oa+gEe2lYpstZ/ZsJiJNR8VpJpQLKBD/to3oEmSqFZDfBvpU3Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768410236; c=relaxed/simple;
	bh=2P5GtHUykYwRCe23nv7QN+EAVhhXV6Oy8logba2Nv5s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Vpz8OleTc+KO0ikE9LKCsHncMDrv6vZmPgo/qaxo7F4tOUBnU2Ss1SqtKvQH9AF0EnaOdMWhjJ5/KuosWE7nVUY6frY8BZEhnAfzNXU02fqMyl6YLJVT8p2L7Bm4nKCnFhW1iNSQSeoEvfCr8/jQ3uKe/9awEUD0RXyI/i6cu9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oX6fE5JY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55908C4CEF7;
	Wed, 14 Jan 2026 17:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768410236;
	bh=2P5GtHUykYwRCe23nv7QN+EAVhhXV6Oy8logba2Nv5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oX6fE5JY8dE4wYovB535LNMMUGdo4WdUpd9AyZwT5cxb0k9cmWHO34Om+ytudHmJU
	 e9jJbtpmp3bJn8h1ZAn+9fxu47lwkxdu2cwPudrV7iF9Jv/Qv1RPZoP9mLatmlAyBL
	 a864KXIwyl/BuPYhd8ouYh8PAIgpbaXQbXwPGCYPIGfL8fmUWXWxAzBucfD2OByg8l
	 8y8ZVGNgI1x4SCYDIRrLQRUOtzKAb5bJ6Z7OOA4xKbxo3PDAU863vyktwCi5ceAm6g
	 gkqEG04lyaSvRY1eaKnCIkdzyzwQLbUKqOcZEmbILmQI61KuPc4wI95fH5ZhpGizjK
	 w9HfguYjtJHhg==
Date: Wed, 14 Jan 2026 11:03:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: fengchengwen <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, Wei <wei.huang2@amd.com>,
	Eric.VanTassell@amd.com, bhelgaas@google.com,
	jonathan.cameron@huawei.com, wangzhou1@hisilicon.com,
	wanghuiqiang@huawei.com, liuyonglong@huawei.com
Subject: Re: RFC about how to obtain PCIE TPH steer-tag on ARM64 platform
Message-ID: <20260114170355.GA822475@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a841956f-1cf0-40aa-ad18-4fafe260bad2@huawei.com>

On Wed, Jan 14, 2026 at 11:39:27AM +0800, fengchengwen wrote:
> On 1/14/2026 3:07 AM, Bjorn Helgaas wrote:
> > On Mon, Jan 12, 2026 at 11:01:31AM +0800, fengchengwen wrote:
> >> Hi all,
> >>
> >> We want to enable PCIE TPH feature on ARM64 platform, but we encounter the
> >> following problem:
> >>
> >> 1. The pcie_tph_get_cpu_st() function invokes the ACPI DSM method to
> >>    obtain the steer-tag of the CPU. According to the definition of
> >>    the DSM method [1], the cpu_uid should be "ACPI processor uid".
> > 
> >> 2. In the current implementation, the ACPI DSM method is invoked
> >>    directly using the logical core number, which works on the x86
> >>    platform but does not work on the ARM64 platform because the
> >>    logical core ID is not the same as the ACPI processor ID when the
> >>    PG exists.
> > 
> > PG?
> 
> partial good

I still don't know what "partial good" means :)  Is that something
from a spec?

