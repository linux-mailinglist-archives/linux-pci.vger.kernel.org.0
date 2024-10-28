Return-Path: <linux-pci+bounces-15464-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BEE9B3710
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 17:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9DA1F22238
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 16:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43ECB1DED59;
	Mon, 28 Oct 2024 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkI5kqhF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E751DED57;
	Mon, 28 Oct 2024 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730134234; cv=none; b=P2NFcxjcoHyCwCtAHzYCv2T/uzNQPm3yhkbkamelIOYFfwxnCw1DiQDpOQxHGKVfK0TIL9kgeON9I+umOulyJmLTVSMFw+IQwINJy/zyPGvRLsVpKij2m+zyZLcQSeEUM70pUA0fmZv2QUWhKVNamPNJqCXMR1lN1is5HRiOvcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730134234; c=relaxed/simple;
	bh=pMWXPesuF8JzrcGMxw6QNKDodBCUrn/XJfWhJqOIi/k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MpGXK3spTOSGCJeS7js+h4QmXNoLnybeHZFbCqkykG7hEYbyQliovZaRm5qf0NBHYIeGo3dXr3UYn1llUyP3VRIZcICA3NiOxtHrbCYT9sTSyfm8VwDFZeYOmpH7F+P5f4K0gcwrYdrU9BmFwEMccQArgneAaK7haxGtCpjCQ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkI5kqhF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EDE5C4CEC7;
	Mon, 28 Oct 2024 16:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730134233;
	bh=pMWXPesuF8JzrcGMxw6QNKDodBCUrn/XJfWhJqOIi/k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pkI5kqhFOL4hPrCJsofC2stUnspJjm6zGrt4OxWKdikOpGkx9D4nmXJx4C/VcJftq
	 mE/iv5zzaJNUwYeH+8UGSMffivBEWZTqJMxCYzZ/9RFDHN5GNWtEv594Vs8OqFbqFC
	 KvHQ6yoKZLdlFCOHSacP0wOL0jLUNBLI+n9RCK3vySApUKgsE0v84V1CxaSLOD4/et
	 Cwwgtu2Hp9Ae77Da0pXA4iasz1yvXST1obtG2ttbSY9QAIHmWR8QgQNkU9M3rHvNrv
	 o2jLzg4XdR80Z4O+4l7LuGU2IhXufItbN14hvCNEZt4ssz6b4CVBKdRM0a6Jlr6sbV
	 SgNclE/avtfMQ==
Date: Mon, 28 Oct 2024 11:50:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Cc: linux-pci@vger.kernel.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Matt Roper <matthew.d.roper@intel.com>
Subject: Re: [PATCH v4 6/7] PCI: Allow drivers to control VF BAR size
Message-ID: <20241028165031.GA1106195@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241025215038.3125626-7-michal.winiarski@intel.com>

On Fri, Oct 25, 2024 at 11:50:37PM +0200, Michał Winiarski wrote:
> Drivers could leverage the fact that the VF BAR MMIO reservation is
> created for total number of VFs supported by the device by resizing the
> BAR to larger size when smaller number of VFs is enabled.
> 
> Add a pci_iov_vf_bar_set_size() function to control the size and a
> pci_iov_vf_bar_get_sizes() helper to get the VF BAR sizes that will
> allow up to num_vfs to be successfully enabled with the current
> underlying reservation size.
> ...

> + * pci_iov_vf_bar_get_sizes - get VF BAR sizes that allow to create up to num_vfs
> + * @dev: the PCI device
> + * @resno: the resource number
> + * @num_vfs: number of VFs
> + *
> + * Get the sizes of a VF resizable BAR that can fit up to num_vfs within the
> + * resource that reserves the MMIO space (originally up to total_VFs) the as
> + * bitmask defined in the spec (bit 0=1MB, bit 19=512GB).

This sentence doesn't quite parse; something is missing around "the as".

I'm guessing you mean to say something about the return value being a
bitmask of VF BAR sizes that can be accommodated if num_vfs are
enabled?  If so, maybe combine it with the following paragraph:

> + * Returns 0 if BAR isn't resizable.
> + *
> + */
> +u32 pci_iov_vf_bar_get_sizes(struct pci_dev *dev, int resno, int num_vfs)
> +{
> +	resource_size_t size;
> +	u32 sizes;
> +	int i;
> +
> +	sizes = pci_rebar_get_possible_sizes(dev, resno);
> +	if (!sizes)
> +		return 0;
> +
> +	while (sizes > 0) {
> +		i = __fls(sizes);
> +		size = pci_rebar_size_to_bytes(i);
> +
> +		if (size * num_vfs <= pci_resource_len(dev, resno))
> +			break;
> +
> +		sizes &= ~BIT(i);
> +	}
> +
> +	return sizes;
> +}
> +EXPORT_SYMBOL_GPL(pci_iov_vf_bar_get_sizes);

