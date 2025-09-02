Return-Path: <linux-pci+bounces-35329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F990B40891
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 17:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041E83B52C2
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 15:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68B731AF24;
	Tue,  2 Sep 2025 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uIUIUklK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E712314B61;
	Tue,  2 Sep 2025 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756825732; cv=none; b=hMlyjU8aBMDM9tIaaZod5s9hG7iCdUnkiQ1APeSaSkP7+Nw/E4n+cXaqhRGCxpAv/AvZIaG5c2HNcyk95vd/qjB5qkH4tUyoVq2ujfmG1uUqWko+ncgt1qKWkbiRgqvWYwcDGfVI+WXJTsQfX4+QVC1umm5Yx7v6ecWUKTS8hN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756825732; c=relaxed/simple;
	bh=LCfotUZXlnwyca+0R61H/DwmUEI4rm/XH/Qm7g3jMUc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k+CjaGVzeqJge7K0TWrzV323rcFxrNdOYsMs53gZbZhqZBVTSx3L85vDcZODiW2umESZ9K9kZx2FB7T9aVwkZBRQnlOEQESg+dLNJXSEBHsFvY7tVVxpjBjkpE6Lh/H8SgNfykXVaEQVWmY89Z5WtqTN9xLTVL55j7+WmfNagRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uIUIUklK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FDCC4CEED;
	Tue,  2 Sep 2025 15:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756825732;
	bh=LCfotUZXlnwyca+0R61H/DwmUEI4rm/XH/Qm7g3jMUc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=uIUIUklK8A2i1GUKPdeLV5cNsuSc+Q+4p7rITEU93UtP+qEd4NIzBFxAdV7gb/3uv
	 JA2+NK7AOlDYaQ8P8X7CkmW8YsL5awoGk2x8H1IPYgdOn05iYZx7XPfHsg4cykdo6C
	 ee25XJROj79CrEYuZBWTftBaApwn8Wo9qOspL7iyWhXp6hnDcy5Fs3mRKurMApvHPD
	 jv4kXNGxsJeyqObKDX0T8jGJ1w916f/5smpAXqJulZWN2ABNeFacF5wkm8++VZCgBz
	 SpZMKWH8Bxi1BNZ+Zo9oHU67A2YDZkGm2H8X5odzq4pgblCA6Skth+mJ9jCGeyLcWe
	 qj+sNrYTztS+w==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: yilun.xu@linux.intel.com, aik@amd.com, gregkh@linuxfoundation.org,
	Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 04/10] PCI/TSM: Authenticate devices via platform TSM
In-Reply-To: <20250827035126.1356683-5-dan.j.williams@intel.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-5-dan.j.williams@intel.com>
Date: Tue, 02 Sep 2025 20:38:44 +0530
Message-ID: <yq5a4itk3n9f.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Williams <dan.j.williams@intel.com> writes:

> The PCIe 7.0 specification, section 11, defines the Trusted Execution
> Environment (TEE) Device Interface Security Protocol (TDISP).  This
> protocol definition builds upon Component Measurement and Authentication
> (CMA), and link Integrity and Data Encryption (IDE). It adds support for
> assigning devices (PCI physical or virtual function) to a confidential VM
> such that the assigned device is enabled to access guest private memory
> protected by technologies like Intel TDX, AMD SEV-SNP, RISCV COVE, or ARM
> CCA.
>
> The "TSM" (TEE Security Manager) is a concept in the TDISP specification
> of an agent that mediates between a "DSM" (Device Security Manager) and
> system software in both a VMM and a confidential VM. A VMM uses TSM ABIs
> to setup link security and assign devices. A confidential VM uses TSM
> ABIs to transition an assigned device into the TDISP "RUN" state and
> validate its configuration. From a Linux perspective the TSM abstracts
> many of the details of TDISP, IDE, and CMA. Some of those details leak
> through at times, but for the most part TDISP is an internal
> implementation detail of the TSM.
>
> CONFIG_PCI_TSM adds an "authenticated" attribute and "tsm/" subdirectory
> to pci-sysfs. Consider that the TSM driver may itself be a PCI driver.
> Userspace can watch for the arrival of a "TSM" device,
> /sys/class/tsm/tsm0/uevent KOBJ_CHANGE, to know when the PCI core has
> initialized TSM services.
>
> The operations that can be executed against a PCI device are split into
> two mutually exclusive operation sets, "Link" and "Security" (struct
> pci_tsm_{link,security}_ops). The "Link" operations manage physical link
> security properties and communication with the device's Device Security
> Manager firmware. These are the host side operations in TDISP. The
> "Security" operations coordinate the security state of the assigned
> virtual device (TDI). These are the guest side operations in TDISP. Only
> link management operations are defined at this stage and placeholders
> provided for the security operations.
>
> The locking allows for multiple devices to be executing commands
> simultaneously, one outstanding command per-device and an rwsem
> synchronizes the implementation relative to TSM
> registration/unregistration events.
>
> Thanks to Wu Hao for his work on an early draft of this support.
>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

you dropped pci_tsm_doe_transfer from an earlier version of this patch
in this series. Any reason for that?

-aneesh

