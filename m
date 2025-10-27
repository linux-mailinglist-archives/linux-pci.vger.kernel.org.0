Return-Path: <linux-pci+bounces-39412-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35628C0CE1B
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 11:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56BF4054AA
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 10:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816A72FABE5;
	Mon, 27 Oct 2025 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eR4q/mss"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548C92F5301;
	Mon, 27 Oct 2025 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761559273; cv=none; b=HtE3oCmYYG+Pd9KGFUWGhjZDRQWJro7nvGoT7K1yvhJ0FAFuiWUaXoD3JDG8lZsuxKAif+8X4o4gqVmvGXzJP/FLesQ2gngU4QgKr4EVKml/4Q27uiaMGy7RMHH2eAZMkpnKkctjqwt0Jpgb8fXtNwTFRDUc70XhHbNr6wxwzS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761559273; c=relaxed/simple;
	bh=52vy/DXiNMqe58JgniHWD3MuKuU2gGtli4d2TX90clc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uGrmGNkN1hbvtaM6TPADWcr4Nwa8V7680O0EOMrOiIUT3VFslQnd/I2UoYBZkq0gM1mMwlGpVLfDgIIxscfEy23WE7vobTT1oYhKNXJSHj66PJkH7xPCb02rzpF8p26xNktV9Rf/3HcOnVUHBe0+U4GgSx3Azju9Rxk+zYCcELE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eR4q/mss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6656AC4CEF1;
	Mon, 27 Oct 2025 10:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761559272;
	bh=52vy/DXiNMqe58JgniHWD3MuKuU2gGtli4d2TX90clc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eR4q/msssHdjQkchMLDu0MZBix9RKUjZGu4Us15UPh2IRqJ4t2NJfIUafmjnAuh71
	 ppepvu5ro+bbh3JOCIs7KEbJDV+OPuWpLxXLMXZFaLkK9CbL7Gkx7l/vXVnWp7nwXB
	 hYCbgt9BxM7tiGd3zZRblLMPPpZoeEpspG5+y8lWtwKPXrVk10HczCS/b+G2yoWE59
	 iX7aOATKG6iVViV2kwxj1mxYmbErg7jToaY9dV6W6HGZa3DaESdS6ApYsQkV105Yq2
	 ukx7IVQbRScnvlA4mZw6TO8oRWbkWelBjPP9aMdX3Kv/51FuGrza4q5BIK0Kpkaum+
	 LCZRIPRVWxTiA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: aik@amd.com, yilun.xu@linux.intel.com, bhelgaas@google.com,
	gregkh@linuxfoundation.org,
	Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>
Subject: Re: [PATCH v7 0/9] PCI/TSM: Core infrastructure for PCI device
 security (TDISP)
In-Reply-To: <20251024020418.1366664-1-dan.j.williams@intel.com>
References: <20251024020418.1366664-1-dan.j.williams@intel.com>
Date: Mon, 27 Oct 2025 15:31:06 +0530
Message-ID: <yq5azf9coe8t.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Williams <dan.j.williams@intel.com> writes:

> Changes since v6 [1]:
> - Rebase on v6.18-rc2
> - Drop @owner from 'struct pci_tsm' and lookup @ops through @tsm_dev
>   (Alexey)
> - Drop CONFIG_PCI_IDE_STREAM_MAX, only require pci_ide_set_nr_streams()
>   for host bridge implementations that limit streams to something less
>   than topology max (Aneesh)
> - Convert Stream index allocators from bitmaps to ida (preparation for
>   solving Stream ID uniqueness problem reported by Alexey)
> - Misc whitespace cleanups (Jonathan)
> - Misc kdoc fixups
> - Fix nr_ide_streams data type, a u8 is too small
> - Rename PCI_DOE_PROTO_ => PCI_DOE_FEATURE_ (Alexey)
> - Rename @base to @base_tsm in 'struct pci_tsm_pf0' (Aneesh)
> - Fix up PCIe r6.1 reference for PCIe r7.0 (Bjorn)
> - Fix to_pci_tsm_pf0() failing to walk to the DSM device (Yilun)
> - Add pci_tsm_fn_exit() for sub-function cleanups post DSM disconnect
>   (Aneesh)
> - Move the samples/devsec/ implementation to a follow-on patch set
>
> [1]: http://lore.kernel.org/20250911235647.3248419-1-dan.j.williams@intel.com
>
> This set is available at
> https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/log/?h=staging
> (rebasing branch) or devsec-20251023 (immutable tag). That branch
> additionally contains address association support, Stream ID uniqueness
> compability quirk, updated samples/devsec/ (now with multifunction
> device and simple bind support), and an updated preview of v2 of "[PATCH
> 0/7] PCI/TSM: TEE I/O infrastructure" (fixes x86 encrypted ioremap and
> other changes) [2].
>
> [2]: http://lore.kernel.org/20250827035259.1356758-1-dan.j.williams@intel.com
>
> It passes an updated regression testing using samples/devsec/. See this
> commit on the staging branch for that test:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/commit/?id=44932bffdcc1
>
> Status: ->connect() flow is settled
> -----------------------------------
> At the risk of tempting fate, the goal is this v7 goes to linux-next via
> a stable tsm.git#next branch. Enable one or more TSM driver
> implementations to queue on top for v6.19-rc1 via arch-specific trees
> for TDX, TIO, CCA, or COVE-IO. I.e. target v6.19 to support baseline
> link encryption (IDE) / secure-session establishment without
> confidential device-assignment.
>
> That tsm.git#next goal still needs follow-on patches like the following
> to settle:
>
> Alexey Kardashevskiy (1):
>       PCI/IDE: Initialize an ID for all IDE streams
>
> Xu Yilun (1):
>       PCI/IDE: Add Address Association Register setup for downstream MMIO
>
> ...but otherwise the core infrastructure is ready to support IDE
> establishment via a platform TSM.
>
> Next steps:
> -----------
> - Stage at least one vendor ->connect() implementation on top of a
>   tsm.git#staging snapshot, for integration testing.
>
> - Additionally get at least one vendor ->connect() implementation queued
>   in an arch tree for linux-next in time for v6.19, otherwise
>   tsm.git#next may need to wait for v6.20.
>

Arm CCA changes can be found https://lore.kernel.org/all/20251027095602.1154418-2-aneesh.kumar@kernel.org

-aneesh

