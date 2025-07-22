Return-Path: <linux-pci+bounces-32755-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCE9B0E3F6
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 21:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E3791888BE0
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 19:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC600284678;
	Tue, 22 Jul 2025 19:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxLIOW5g"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9056D288D2;
	Tue, 22 Jul 2025 19:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753211659; cv=none; b=glNfj3pOdol8+0Nypk59cZ4wJb7I9fLMBZpuoDrBLuEOKYSdwbsNmdM+lxsNfoHfqmI4pKQhpZ8bEyE4ZEBu/ZGqhYtOepVw4MdgbKUxtY1Rd0bShRuBpntNEsPtig+HBJynwwYqIpxG4Kpeuiq5NQemfci3ssFeNKTAqXVmS48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753211659; c=relaxed/simple;
	bh=W4wbja6wIegYoeAVWdn+JpMC8E+JkZwkxAxoOpv84w4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ddy0juCDRq4CHEsWj+AAQn0+2gNQbF/mu2zTaXKDCskxzFeHZeIssfuf1edTWLAqCZ9V3TyJ8nRnCQ1o+BKVyHbN5q33yjnh86qKr+3Yoc1AlzBXl3/Z9yYzZB+3QrdU54d64wEieiiz3bYvJ7ajSdr7iVxr8aMNdrEk6BcopBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxLIOW5g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D73C4CEEB;
	Tue, 22 Jul 2025 19:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753211659;
	bh=W4wbja6wIegYoeAVWdn+JpMC8E+JkZwkxAxoOpv84w4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SxLIOW5gozzAsMTs3DRITOu9Te4wgaqCkUEFAgEkfYL1cMwsI66X35rQxaXuRLBY3
	 21I2wvtdaYAUsDAkqUGzqn3AVXmLjiC8XX/OZKyLVKaxWw3akxhszhZ2RkkYyMeayV
	 x9kfXfs3RIfxjlO5SZ8YsAPWvs+EdBSTGRxVfisCUzfUctuXbJMekP4sveqSW5KpLD
	 zG3d7ypntptKXw9R39wU3tSUn2v2NYsOoRQ7QeAD4wtwoqKP+RLPULfu4a5YgyYNms
	 j93v22RzPjH8+OymXHrwm0who1X2zgpmCQFy3uS4nzJuUor1xTHeMDOVFYtQJGpOrM
	 0jgYt0G2rp0gQ==
Date: Tue, 22 Jul 2025 14:14:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, andreas.noever@gmail.com,
	michael.jamet@intel.com, westeri@kernel.org, YehezkelShB@gmail.com,
	bhelgaas@google.com, Sanath.S@amd.com
Subject: Re: [PATCH 2/3] PCI: Add PCI vendor ID for ASMedia USB4 devices
Message-ID: <20250722191417.GA2809926@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722175026.1994846-3-Raju.Rangoju@amd.com>

On Tue, Jul 22, 2025 at 11:20:25PM +0530, Raju Rangoju wrote:
> Add a new PCI vendor ID (PCI_VENDOR_ID_ASMEDIA_USB4) for ASMedia
> USB4 devices. This change enables proper identification and support
> for ASMedia USB4 hardware in the kernel.
> 
> Co-developed-by: Sanath S <Sanath.S@amd.com>
> Signed-off-by: Sanath S <Sanath.S@amd.com>
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---
>  include/linux/pci_ids.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index e2d71b6fdd84..3397954ce96e 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2592,6 +2592,7 @@
>  #define PCI_SUBDEVICE_ID_QEMU            0x1100
>  
>  #define PCI_VENDOR_ID_ASMEDIA		0x1b21
> +#define PCI_VENDOR_ID_ASMEDIA_USB4	0x174C
>  
>  #define PCI_VENDOR_ID_REDHAT		0x1b36

Sort by Vendor ID value (not the name), per the comment at the top.

Use lower-case hex to match style (not universally observed, but
close).

Per https://pcisig.com/membership/member-companies, 0x174c is not
reserved, although the same is true for 0x1b21 and many other Vendor
IDs.  Do you know the history of 0x174c and 0x1b21, or why these don't
show up as reserved?

With these,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Bjorn

