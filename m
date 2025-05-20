Return-Path: <linux-pci+bounces-28066-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AB6ABCE90
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 07:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 494E03A4375
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 05:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368DA2566FD;
	Tue, 20 May 2025 05:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULROJ0ty"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E341EEC8;
	Tue, 20 May 2025 05:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747718428; cv=none; b=qZViuhcb/oxtWd+cgQSXqvzDHxtfuLaEFjTj0rjRXWQ1rAC7CKx/wbeumx6ybg3cJZtEROJqqip9xYzVyH9k1EZ8SNpJVOK0CFLx/QiT85rbQ1YLea8p/sk1/mFFD9EVbahZbh7Qu/J0CPEPCsXt21fH7pJKosl9HsrBrBc/8Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747718428; c=relaxed/simple;
	bh=MRg6crhCZ8wmoVvNWizhvbY+H6QV9+VMBMb7G/vYrns=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tNhPCzs8a+SyKaBMyyw8wnrm06+CXFQ2is3uMrHHePFFeKIn11wYJQdvOpfzmpzo6+1h8JD1m2fpV2y+uYC/pdkPNRxARkBf/nSsbv4iwFZCfGyL2SMH0zxMN0H8I4Rn/IyQfAEl+wkPAZJUCRSUaM9xdFPtbSO/xbWmTx9RYlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULROJ0ty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA411C4CEE9;
	Tue, 20 May 2025 05:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747718427;
	bh=MRg6crhCZ8wmoVvNWizhvbY+H6QV9+VMBMb7G/vYrns=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ULROJ0tySjI6icwSGASvOUuljEd9Nq7jTkxU3JV0FjGCd8qW6yt22tZusN7EadhO5
	 P7Tux/HJlL4h9Uc26IZ7/2+qjblq6ONkGPAgilVZk1LXNyFpwr7hzF8mmZGNwfmh/n
	 uadnc84lU97U3WsGzlT7a1dyCMDdLXemFZ1btsV2XFSFYpNqss32QXxaXWW1YKp/Mf
	 eEN3DR7pkMVGNQY1mpA03se4cxRR9j7Cv0cCmKw4pIXdfsnl2J3ik8MFfB55WqVtPr
	 CHYzi3rbbkdIj3+IJKU1cWADVeiqfwmp3LQrxUweJDOKOtwkT3aQy/gU8TXNThgOs+
	 RXPCHhWC/4tIg==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, lukas@wunner.de, suzuki.poulose@arm.com,
	sameo@rivosinc.com, aik@amd.com, jgg@nvidia.com, zhiw@nvidia.com,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for
 host TSM driver
In-Reply-To: <20250516054732.2055093-13-dan.j.williams@intel.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-13-dan.j.williams@intel.com>
Date: Tue, 20 May 2025 10:50:19 +0530
Message-ID: <yq5a1psj6ep8.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Williams <dan.j.williams@intel.com> writes:

> From: Xu Yilun <yilun.xu@linux.intel.com>
>
> Add kAPIs pci_tsm_{bind,unbind,guest_req}() for PCI devices.
>
> pci_tsm_bind/unbind() are supposed to be called by kernel components
> which manages the virtual device. The verb 'bind' means VMM does extra
> configurations to make the assigned device ready to be validated by
> CoCo VM as TDI (TEE Device Interface). Usually these configurations
> include assigning device ownership and MMIO ownership to CoCo VM, and
> move the TDI to CONFIG_LOCKED TDISP state by LOCK_INTERFACE_REQUEST
> TDISP message. The detailed operations are specific to platform TSM
> firmware so need to be supported by vendor TSM drivers.
>
> pci_tsm_guest_req() supports a channel for CoCo VM to directly talk
> to TSM firmware about further TDI operations after TDI is bound, e.g.
> get device interface report, certifications & measurements. So this kAPI
> is supposed to be called from KVM vmexit handler.
>
> A problem to solve here is the TDI operation lock. The TDI operations
> involve TDISP message communication with devices, which is transferred
> via PF0's DOE. When multiple VFs or MFDs are involved at the same time,
> these messages are not intended to interleave with each other. So
> serialize all TSM operations of one slot by holding the DSM device (PF0)
> pci_tsm.lock.
>
> Add a struct pci_tdi to represent the TDI context, which is common to
> all PFs/VFs/MFDs so embedded it in struct pci_tsm. The appearing of the
> tsm::tdi means the device is in BOUND state and vice versa. So no extra
> enum pci_tsm_state value is added for bind. That also means the access
> to tsm::tdi must with the DEM device (PF0) TSM lock.
>

Now that we have guest kernel also susing tsm_register, should we have
patch [PATCH 01/13] coco/tsm: Introduce a core device for TEE Security
Managers add tsm-core.c to drivers/virt/coco/ ?

Something similar to https://git.gitlab.arm.com/linux-arm/linux-cca/-/commit/2e83f71b4b3a71ee56a77b45f5214b6223dda3b5

-aneesh

