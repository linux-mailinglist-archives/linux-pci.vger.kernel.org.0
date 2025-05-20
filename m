Return-Path: <linux-pci+bounces-28068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE50ABD025
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 09:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F13D4A362B
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 07:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE28EEC8;
	Tue, 20 May 2025 07:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIrAdWso"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9284B25D1E0;
	Tue, 20 May 2025 07:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747725433; cv=none; b=Pr3h7T2YAnZzk/lmeQh4D2ctRvxsMU03hH5aAxTeyOq6ag8JmD1ydRv30Ni9p/ukYPM0ECJ0IUGYWvDvP8OIhCouN4T65/w2K8FZ+Z5uWVcNd092Kk9r0OcZyyUM5Egeah6GVDlhZiPQC4Z1NImUS6T36orWlyf0iSQ9tGGeE5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747725433; c=relaxed/simple;
	bh=7530pRYil8UrifWj40lC9piqC1X7iX+KFiCMEYE3IlA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lekYC0mfVvourLkGFJXd0IbI1QA9sTOqSaf4O8SFaT9CVTJfDm9L7ooEV6fPTEuj0e5I4/U6i2MwFfy+s5PsyjwB+cKf7AdIono0DZyokfMGqZz7dy01N5qZ/WcgSGkqqZFHtKf/EE9T5ECu9CZpPKdzSJDX62nzvOiZQxHoV88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIrAdWso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C670C4CEF0;
	Tue, 20 May 2025 07:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747725433;
	bh=7530pRYil8UrifWj40lC9piqC1X7iX+KFiCMEYE3IlA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oIrAdWsoV2ncldDS4YM5BO1qMA0Q/lmx8P5snMFmxcbgxYTaiZXQ0TflUWpAOEUkV
	 H9pxDsfkY+BCCgmaiGaMcZ6CkiY1fV5KyRveE7Z6ds2FpTEgmnCcX2CqX77iS75e9h
	 3yctHdq7vIiTvU/AqJ0sSPigiK4DX0f/IFFf5dM/WcYTEv3qvZDbFEOp6edI9TEyF0
	 Ls188XdmIFV7ZneMq3x02VEEL++NS9dUJZAPrCOVxJr3SYglGLbJ2E2Ccc6VzWhEyL
	 83kSVHVTAYa2zcSYmlOltFyl5okjT2Xs3/Df1jo+OAuGeMGTk/4OXAHKqb6ry2eW/R
	 asFvjRrfVeajw==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org, lukas@wunner.de, suzuki.poulose@arm.com,
	sameo@rivosinc.com, aik@amd.com, jgg@nvidia.com, zhiw@nvidia.com
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for
 host TSM driver
In-Reply-To: <aCbglieuHI1BJDkz@yilunxu-OptiPlex-7050>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-13-dan.j.williams@intel.com>
 <aCbglieuHI1BJDkz@yilunxu-OptiPlex-7050>
Date: Tue, 20 May 2025 12:47:05 +0530
Message-ID: <yq5awmab4uq6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Xu Yilun <yilun.xu@linux.intel.com> writes:

> On Thu, May 15, 2025 at 10:47:31PM -0700, Dan Williams wrote:
>> From: Xu Yilun <yilun.xu@linux.intel.com>
>> 
>> Add kAPIs pci_tsm_{bind,unbind,guest_req}() for PCI devices.
>> 
>> pci_tsm_bind/unbind() are supposed to be called by kernel components
>> which manages the virtual device. The verb 'bind' means VMM does extra
>> configurations to make the assigned device ready to be validated by
>> CoCo VM as TDI (TEE Device Interface). Usually these configurations
>> include assigning device ownership and MMIO ownership to CoCo VM, and
>> move the TDI to CONFIG_LOCKED TDISP state by LOCK_INTERFACE_REQUEST
>> TDISP message. The detailed operations are specific to platform TSM
>> firmware so need to be supported by vendor TSM drivers.
>> 
>> pci_tsm_guest_req() supports a channel for CoCo VM to directly talk
>> to TSM firmware about further TDI operations after TDI is bound, e.g.
>> get device interface report, certifications & measurements. So this kAPI
>> is supposed to be called from KVM vmexit handler.
>
> To clarify, this commit message is staled. We are proposing existing to
> QEMU, then pass to TSM through IOMMUFD VDEVICE.
>

Can you share the POC code/git repo implementing that? I am looking for
pci_tsm_bind()/pci_tsm_unbind() example usage.

-aneesh

