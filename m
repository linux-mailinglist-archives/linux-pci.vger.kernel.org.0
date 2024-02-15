Return-Path: <linux-pci+bounces-3554-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD03856FA4
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 22:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C591F22F6C
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 21:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A041419A2;
	Thu, 15 Feb 2024 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOvlQEKK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CA86A349;
	Thu, 15 Feb 2024 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708034257; cv=none; b=bJf53mMO2P0J7PzX1eQVsTIIag/h8NnShIBFphohBU8z5dXmazxveXFkugqpBr8uK+GuTE3oI1fEMcXVnnFCfNU9ZMfUUo/tIddj/AceJu8M4YyywGj742SIxY1CRils9r0oWYVpJZ/PnrWJIPnt5sasVhggsKUqtm+2toyzdgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708034257; c=relaxed/simple;
	bh=aQbRS9eEXJfe/7NR9s+OgBYKqHJuauwbiDJcjNinAYY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ab6ZSJKbdi6BngRQMvif5wlXDxnirg1ea4h6MRq0HQkd5YUNDRiXsuknoDH1YH3CFnXU+t/h06B3kBhQ4ZzXRz/sEU7dCwSfTMwAV6BJwYpH/8lipJ+nSMrHgb61wJVEEb80L6SQ+0i8ZdIzpmih/awo5yAig5BaMa2PIVv9wkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOvlQEKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC96C433F1;
	Thu, 15 Feb 2024 21:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708034256;
	bh=aQbRS9eEXJfe/7NR9s+OgBYKqHJuauwbiDJcjNinAYY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OOvlQEKKr2uxLE6A7cgTnmRWDG3ksyKZkcSdfqIgUIsbExdWe9R59CTXmVJ6MH1q+
	 JEzdJDQU2hcIKR5qeCiQ2HUMukZGv6cn6RTC+/tKc2q0CD1Bz/kqglJbfky4aKz2Ng
	 E4b3vUMtSs+EjB3v+liJSMbMaAhNDk21Dhu9740LEwMgY01qICPXzAxlULLa3rB6cF
	 uc8652Cb+un3andr4HlQZYBSoHSkN+QqxG4wYA+/nzvRDsUE+7EtRqY/H+ljW+Uwmh
	 /xqPnoFwqBeDiaQ6Wox3N1Tf7lLP4OGBkuPuMNzfhTWLf82cKbNtNvKwVog3d8+TuS
	 VCXWl18X8UCsw==
Date: Thu, 15 Feb 2024 15:57:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, bhelgaas@google.com
Subject: Re: [RFC PATCH 6/6] pcie/cxl_timeout: Add CXL.mem Timeout &
 Isolation interrupt support
Message-ID: <20240215215735.GA1311372@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215194048.141411-7-Benjamin.Cheatham@amd.com>

On Thu, Feb 15, 2024 at 01:40:48PM -0600, Ben Cheatham wrote:
> Add support for CXL.mem Timeout & Isolation interrupts. A CXL root port
> under isolation will not complete writes and will return an exception
> response (i.e. poison) on reads (CXL 3.0 12.3.2). Therefore, when a
> CXL-enabled PCIe root port enters isolation, we assume that the memory
> under the port is unreachable and will need to be unmapped.

> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -10,6 +10,7 @@
>  #define _PORTDRV_H_
>  
>  #include <linux/compiler.h>
> +#include <linux/errno.h>

This doesn't look required by portdrv.h.  If it's only needed by
something that *includes* portdrv.h, I think errno.h should be
included by that .c file instead.

