Return-Path: <linux-pci+bounces-45076-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 255D3D385EA
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 20:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2DA9C30082F1
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 19:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C26521770A;
	Fri, 16 Jan 2026 19:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdHLFqpJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EB62853E9
	for <linux-pci@vger.kernel.org>; Fri, 16 Jan 2026 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768591925; cv=none; b=fPi1Al+3xsZW5C5Tqz+QtmHnwWPfY0PLbGyuyWwFwUd/IZHMpQYN9iHk7Oy5ocLVlrxq7hcv/Ooj+XSv4M0QDsMeINWVtU+hLQQqRl4op8sSVVUVoLa0rBRt2h7Iou1VdxpdWKNRS5he7sDmKAuN0lucyat3OJYjBh2m4736O8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768591925; c=relaxed/simple;
	bh=WjlXhjzehPTRTBKfaodANcY5xdbA/Ttgspw7hyyPaVw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=k/1gbEJmgIKb6EI7LcnT2wCC4N05opy8A6PzYd2i4k4nW6TTIpC9FgO1R/HzDil2TehmHuO1DtLBlYQUDpDUTGfde+5Ii+FhFe/uUsbkSn0IGA51hrgxUNIYRSLAdMowukyERjK69HCXlEVDMFTeCvd0/Frb+3Md0vQhAeHSOW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdHLFqpJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638C3C116C6;
	Fri, 16 Jan 2026 19:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768591924;
	bh=WjlXhjzehPTRTBKfaodANcY5xdbA/Ttgspw7hyyPaVw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WdHLFqpJa1u+KlcpY1Nr/RjOJh32opiPqECZBUECO8OtUp40Aqq7fKFs40O2eX1YO
	 EivP8njCidU9DC3Om5DPxnN6bGQgOxrQqn7cas/gA3EYimVc52FYzHMco+ydpqIYG+
	 RavFpieT5f2LoS36o8+AVVuNJ1UJmsWXhHksOBTyMulFwDpv6A/Cpj/DiUCD+hlesX
	 ZmStJH6Osdt4KxiN2azedSDetz2axX9Nbf7eo/nFglqjPMzEuX25S2MxU16yRMk3ba
	 M5Qn+NY9PA4yxYatIaYxEIjOAQutULj1i1VRGOd0nFdQprxDP4mEX2KMiQxanqbOtc
	 artWay5Q3WBeA==
Date: Fri, 16 Jan 2026 13:32:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: fengchengwen <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, Wei <wei.huang2@amd.com>,
	Eric.VanTassell@amd.com, bhelgaas@google.com,
	jonathan.cameron@huawei.com, wangzhou1@hisilicon.com,
	wanghuiqiang@huawei.com, liuyonglong@huawei.com
Subject: Re: RFC about how to obtain PCIE TPH steer-tag on ARM64 platform
Message-ID: <20260116193203.GA959102@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5106e61-adec-4c7f-af64-9782a81a5954@huawei.com>

On Fri, Jan 16, 2026 at 08:21:30AM +0800, fengchengwen wrote:
> On 1/15/2026 1:03 AM, Bjorn Helgaas wrote:
> > On Wed, Jan 14, 2026 at 11:39:27AM +0800, fengchengwen wrote:
> >> On 1/14/2026 3:07 AM, Bjorn Helgaas wrote:
> >>> On Mon, Jan 12, 2026 at 11:01:31AM +0800, fengchengwen wrote:
> >>>> Hi all,
> >>>>
> >>>> We want to enable PCIE TPH feature on ARM64 platform, but we encounter the
> >>>> following problem:
> >>>>
> >>>> 1. The pcie_tph_get_cpu_st() function invokes the ACPI DSM method to
> >>>>    obtain the steer-tag of the CPU. According to the definition of
> >>>>    the DSM method [1], the cpu_uid should be "ACPI processor uid".
> >>>
> >>>> 2. In the current implementation, the ACPI DSM method is invoked
> >>>>    directly using the logical core number, which works on the x86
> >>>>    platform but does not work on the ARM64 platform because the
> >>>>    logical core ID is not the same as the ACPI processor ID when the
> >>>>    PG exists.
> >>>
> >>> PG?
> >>
> >> partial good
> > 
> > I still don't know what "partial good" means :)  Is that something
> > from a spec?
> 
> Because of some issues (like manufacturing variances), certain circuits
> (e.g., some cores) might not work normally. For these cases, we can use
> the part at a reduced specification, which is the PG mentioned here.

Ah, got it :)  If you go this direction, maybe you can expand that
part of the commit log a bit, since I don't think "PG" or "partial
good" is a widely-known term.

