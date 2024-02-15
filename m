Return-Path: <linux-pci+bounces-3551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8638856F64
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 22:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB26B1C20F6C
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 21:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AFC13AA41;
	Thu, 15 Feb 2024 21:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqWyWELS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED07213EFE6;
	Thu, 15 Feb 2024 21:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708032922; cv=none; b=USn8piPTtHttvzvlg4WVpG8RY7VvP8VY8KUUHRLMJTeGd2XPOWRLgqZ4Vc/jY3I+qVLQQtGI8SEJXnGhQNpKAvUnCFTYvpeZcywPNMCSB/BiJrC3T04YSBsXWTuEB4Xqjd9XuMmqUrAye0xhlUFFU/QMb4vp4qPGuxBXICeHP8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708032922; c=relaxed/simple;
	bh=6kZMrYUTK+8RIK7CA7iJ7iqLd3rf7GYU3znn7y70b0U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uzVcY8UrQq5gzKuQQfyqHz/WkNRkoFRgfdUUfG7KyeK/FH5nIouaNEUg8l676MgBWdhfPYcDUhIma1El/Xmd/KxJAyaKaRHLN1oFOcWHabpDWBxm/HxmLayhrGZZtQE71FHtXvSUq42coCvMD5n8fO8ApBjPbpS1hjRMW7rSTGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqWyWELS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490BDC433C7;
	Thu, 15 Feb 2024 21:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708032921;
	bh=6kZMrYUTK+8RIK7CA7iJ7iqLd3rf7GYU3znn7y70b0U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZqWyWELSRE+I+Tg0UwUcOZN4hObWJI1/Vfhd4Untq6o+gLnhivqwKHCnVAuZ32JVc
	 WeHx4IaNLCajaTv5s9fTc+xf8f4QFTmJOUfQrsR6WmtZfjMaMsd+/TTI5Su7wFs8C2
	 A7sANVJWLo9xih+yYwOQ5z/L8WVIWXSxS5v1amFQ7VbEFBMZKnYHzK7Bkdim7Us6o+
	 lsxv+Ok29UVf/RySb5HfpbxYwKkZQHGek8ScE4ifYnvBSbBaBOe7sk4/n3azt9d8Ku
	 MF6D5lmVnujKfNMwDAg1WxX416sKgKB+/I8fva4AuVjNLsos2e1ZJzeZPWlu84OwE2
	 fk6VUeEtAUPlQ==
Date: Thu, 15 Feb 2024 15:35:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, bhelgaas@google.com
Subject: Re: [RFC PATCH 3/6] pcie/cxl_timeout: Add CXL.mem timeout range
 programming
Message-ID: <20240215213519.GA1309984@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215194048.141411-4-Benjamin.Cheatham@amd.com>

On Thu, Feb 15, 2024 at 01:40:45PM -0600, Ben Cheatham wrote:
> Add programming of CXL.mem transaction timeout range (CXL 3.0 8.2.4.23.1
> bits 4 & 11:8) through sysfs. To program the device, read the ranges
> supported from "available_timeout_ranges" in the PCIe service device
> directory, then write the desired value to "timeout_range". The current
> value can be found by reading from "timeout_range".
> 
> Example for CXL-enabled PCIe port 0000:0c:00.0, with CXL timeout
> service as 020:
>  # cd /sys/bus/pci_express/devices/0000:0c:00.0:pcie020

I would really, really like to avoid adding sysfs dependences on
portdrv.  Is there any chance these files could go in the normal
/sys/bus/pci/devices/ hierarchy instead?

> +/* CXL 3.0 8.2.4.23.2 CXL Timeout and Isolation Control Register, bits 3:0 */
> +#define CXL_TIMEOUT_TIMEOUT_RANGE_DEFAULT 0x0

> +#define CXL_TIMEOUT_TIMEOUT_RANGE_D2 0xE

Looks like the single other example in this file of hex constants
using A-F uses lower-case.

Does "TIMEOUT_TIMEOUT" add information over just "TIMEOUT"?

> +#define NUM_CXL_TIMEOUT_RANGES 9

I don't think we actually need this constant, do we?

> +static bool cxl_validate_timeout_range(struct cxl_timeout *cxlt, u8 range)

"validate" is not a very name for a function returning "bool" because
you can't tell what true/false means from the name.  "valid" would be
fine.

> +	pci_dbg(cxlt->dev->port,
> +		 "Timeout & isolation timeout set to range 0x%x\n", range);

I don't know CXL, but "timeout ... timeout" reads sort of strange.  Is
it actually a timeout for a timeout?  Maybe it was supposed to be
"transaction timeout"?

> +const struct cxl_timeout_range {
> +	const char *str;
> +	u8 range_val;
> +} cxl_timeout_ranges[NUM_CXL_TIMEOUT_RANGES] = {

Static?

Bjorn

