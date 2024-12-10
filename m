Return-Path: <linux-pci+bounces-18046-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B389A9EB9A9
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 19:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7330163718
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 18:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9069A1A01B0;
	Tue, 10 Dec 2024 18:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+Hw3XPM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680E923ED41;
	Tue, 10 Dec 2024 18:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856777; cv=none; b=IMT1xa6yoeGZxVr6I+FOuj35j/9jvL4qGvc/dbjnEmRTrYGGGpRTFZtL52T2368ORW26rM5HkI4VYUhzsM22tG7CwbR3mMPU0HbYtokrD52a/1FwbrkRyOqEMsIXfTkSkzLn4y+WlHJf6MhCU7UGs3iwAlCOd7VqkZfzNbwjhis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856777; c=relaxed/simple;
	bh=7EMn15M2kNbrawFFSVapj3ytlO0cjTCCmEuvYATmaww=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ajmfCZDziDPGuLXvzTY45Th647fQp+iKnJkedAWq8NuQDWu4mg7a59QQ3wp1gT6k+PZgv7mvRuLWFmsrt4PN0xig4myGz1haqnu8KrfwTaHq8vmCo+9QpcX4FA221M2kZvtSHWowlVC/4iq+UlGvXT8yPRoUfP0o3zjO1aUbpM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+Hw3XPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26171C4CEDD;
	Tue, 10 Dec 2024 18:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733856777;
	bh=7EMn15M2kNbrawFFSVapj3ytlO0cjTCCmEuvYATmaww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=H+Hw3XPM/ZmVPl3SO2wRwwqt8pcgMEPNAPcbIT8eJIaO8nWNOts03ya5ANFb/G9c8
	 y3Hz+IU5tqaahFGrdDdTkGreRZgBpQHTesc8IbyVlGtOIap0OFO+OBe+kB8KJgzHzb
	 CGJVFBUjNGidjocxlQ+pOb/oUHk9HxQGPGV/O5ZW6kgNAmWnh09mvYfJ2VuhTWI4C1
	 vBtU37vMiCmdVQGiZXPKaP7uAdzhkq9P0LZL53/AEX+3Qjn7PMd1Bl7BWoL0du//OQ
	 6N6tmxOUacKMHwYW9Mx76HN4n1G2T+VvgoL6KRThANtpzjW+Nf/DxPxh+f3stN/ofJ
	 5w6jg2zBMaHfA==
Date: Tue, 10 Dec 2024 12:52:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 05/11] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <20241210185255.GA3251438@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173343742510.1074769.16552514658771224955.stgit@dwillia2-xfh.jf.intel.com>

On Thu, Dec 05, 2024 at 02:23:45PM -0800, Dan Williams wrote:
> The PCIe 6.1 specification, section 11, introduces the Trusted Execution
> Environment (TEE) Device Interface Security Protocol (TDISP).  This
> interface definition builds upon Component Measurement and
> Authentication (CMA), and link Integrity and Data Encryption (IDE). It
> adds support for assigning devices (PCI physical or virtual function) to
> a confidential VM such that the assigned device is enabled to access
> guest private memory protected by technologies like Intel TDX, AMD
> SEV-SNP, RISCV COVE, or ARM CCA.

> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -583,3 +583,45 @@ Description:
>  		enclosure-specific indications "specific0" to "specific7",
>  		hence the corresponding led class devices are unavailable if
>  		the DSM interface is used.
> +
> +What:		/sys/bus/pci/devices/.../tsm/
> +Date:		July 2024
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		This directory only appears if a physical device function supports
> +		authentication (PCIe CMA-SPDM), interface security (PCIe TDISP), and is
> +		accepted for secure operation by the platform TSM driver. This attribute
> +		directory appears dynamically after the platform TSM driver loads. So,
> +		only after the /sys/class/tsm/tsm0 device arrives can tools assume that
> +		devices without a tsm/ attribute directory will never have one, before
> +		that, the security capabilities of the device relative to the platform
> +		TSM are unknown. See Documentation/ABI/testing/sysfs-class-tsm.

Wrap to fit in 80 columns like the rest of the file.

> +
> +What:		/sys/bus/pci/devices/.../tsm/connect
> +Date:		July 2024
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(RW) Writing "1" to this file triggers the platform TSM (TEE Security
> +		Manager) to establish a connection with the device.  This typically
> +		includes an SPDM (DMTF Security Protocols and Data Models) session over
> +		PCIe DOE (Data Object Exchange) and may also include PCIe IDE (Integrity
> +		and Data Encryption) establishment.

