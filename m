Return-Path: <linux-pci+bounces-35012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E16A5B39E04
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 15:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24F881896038
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 13:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C552E093F;
	Thu, 28 Aug 2025 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5j+dL3z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD3A1990A7;
	Thu, 28 Aug 2025 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386194; cv=none; b=E2uH317IyPiiuMviwIU5XEJpPOkNx0b+a6s9UttTXK6ZulD91WVyit9Txt6tURF9p8Plu9fnFRZKJ7ahF1n0C0RLjWzWlOqCm/Rmaw91mvts/V27t4QOIS0bEY0e0woF2QpDMQZfU3Dnibdfzh/z5bvlwZhyJq+C6pKUKvDOXi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386194; c=relaxed/simple;
	bh=UqGgExGSmmczCApYtSEd4+hLi+6rKVLvaHJaF8/jUQM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gvwKE3yckqc8q9IpTfPiTyUkW8CLEDWvojAorWZF5gSU1+rHxbbXyPmwQ4ZbSfTwlPWsNbZdabJnP3SydHkdFSKVCGahxzhs9DbDDKihkOmytmKs5cISg/AYQzThlG7lQnAFbvnRk7a+NsQkUVf1WgVVYk/KYqi5egkevFvepxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5j+dL3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16BBC4CEF5;
	Thu, 28 Aug 2025 13:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756386193;
	bh=UqGgExGSmmczCApYtSEd4+hLi+6rKVLvaHJaF8/jUQM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=m5j+dL3zcHSC9249V7PVPQ1WI3yOkJZSJgrUMRnek5Q1CwrkNogjU2ohpHwb5vnY3
	 aitvmovpyLcVRN2BtS4O9zUNat7v2W+E/Q5SnOzCRovyqHDKITN2drokLrnZPosN7i
	 szsBLBzfNHx1gfYi3NANX1ZdeMBSp5rcN0trj6R+AO3YML71s+fJ3GFZ2ASRyASe5/
	 oQ61NtxH6/VUeZ3IGkMei9L/iwtBs6F4/EpweOl8fOEJNCxM8ebfznXA7KmnCoT3lO
	 bPV2Pjkk7e6oEQ/uJo2kxjdWXQpsEt9D1tat18434/E6rHhiG+eFS2EAAEiMIPdJhG
	 wnCmXjPv+oJrw==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bhelgaas@google.com, yilun.xu@linux.intel.com,
	aik@amd.com
Subject: Re: [PATCH 2/7] PCI/TSM: Add pci_tsm_guest_req() for managing TDIs
In-Reply-To: <20250827035259.1356758-3-dan.j.williams@intel.com>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-3-dan.j.williams@intel.com>
Date: Thu, 28 Aug 2025 18:32:59 +0530
Message-ID: <yq5awm6nppj0.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dan Williams <dan.j.williams@intel.com> writes:

> +/**=20
> + * enum pci_tsm_req_scope - Scope of guest requests to be validated by T=
SM
> + *
> + * Guest requests are a transport for a TVM to communicate with a TSM + =
DSM for
> + * a given TDI. A TSM driver is responsible for maintaining the kernel s=
ecurity
> + * model and limit commands that may affect the host, or are otherwise o=
utside
> + * the typical TDISP operational model.
> + */
> +enum pci_tsm_req_scope {
> +	/**
> +	 * @PCI_TSM_REQ_INFO: Read-only, without side effects, request for
> +	 * typical TDISP collateral information like Device Interface Reports.
> +	 * No device secrets are permitted, and no device state is changed.
> +	 */
> +	PCI_TSM_REQ_INFO =3D 0,
> +	/**
> +	 * @PCI_TSM_REQ_STATE_CHANGE: Request to change the TDISP state from
> +	 * UNLOCKED->LOCKED, LOCKED->RUN. No any other device state,
> +	 * configuration, or data change is permitted.
> +	 */
> +	PCI_TSM_REQ_STATE_CHANGE =3D 1,
> +	/**
> +	 * @PCI_TSM_REQ_DEBUG_READ: Read-only request for debug information
> +	 *
> +	 * A method to facilitate TVM information retrieval outside of typical
> +	 * TDISP operational requirements. No device secrets are permitted.
> +	 */
> +	PCI_TSM_REQ_DEBUG_READ =3D 2,
> +	/**
> +	 * @PCI_TSM_REQ_DEBUG_WRITE: Device state changes for debug purposes
> +	 *
> +	 * The request may affect the operational state of the device outside of
> +	 * the TDISP operational model. If allowed, requires CAP_SYS_RAW_IO, and
> +	 * will taint the kernel.
> +	 */
> +	PCI_TSM_REQ_DEBUG_WRITE =3D 3,
> +};
> +

Will all architectures need to support all the above pci_tsm_req_scope
values?

For example, on ARM, I=E2=80=99ve implemented a simpler approach [1] by usi=
ng an
architecture-specific pci_tsm_req_scope / type. This simplifies
the implementation, as I can access `info->req` and `info->resp`
directly within the same callback, without needing an additional
structure to carry arch-specific request types like
`ARM_CCA_DA_OBJECT_SIZE` or `ARM_CCA_DA_OBJECT_READ`.

[1] https://git.gitlab.arm.com/linux-arm/linux-cca/-/commit/ae6e667a6426fde=
ff9cdf9f6807acb8a5d5d601f

-aneesh

