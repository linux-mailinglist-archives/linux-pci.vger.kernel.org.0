Return-Path: <linux-pci+bounces-2114-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D0082C39E
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 17:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3B86B22D3D
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 16:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F54974E3F;
	Fri, 12 Jan 2024 16:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHK8gBh0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2596E74E3B
	for <linux-pci@vger.kernel.org>; Fri, 12 Jan 2024 16:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B80C433C7;
	Fri, 12 Jan 2024 16:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705077327;
	bh=3SfH0aojykpXf/Wm7N3G+Dn0zaiw9vbJ9in4ZNqXoGI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QHK8gBh05xe6cBI0FUUpOa1d9Hc8BBMNHdPCufkyevZLsdlEd5slm2K9kDxlY8PY5
	 E3ZAVuxX01+Bvo1Yh/JfH+/Ixtcp4HwYgA4BwCZ0sfrlU0vse4dptdBBb+cevAkGJj
	 wHqNoKoDezuzzgtBWTmf7/SwegJDTs6EiZ2/pf/U6DDJpdLImvmRORQcQAd90NSN2/
	 nbuhj6u64WK+WDQZmDPZZo1CYDNjLHaAwYjFNNyzKqPX6P6wunodP7rKSGUVq8tNRl
	 Q6cRl2R55PCr1OeWQGEE4dFySXT9U1sr9k/lJgKgfGJonVIHZb5YrvhIHu+CbL5Cm9
	 Yjyswp+NxOP2Q==
Date: Fri, 12 Jan 2024 10:35:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
Cc: linux-pci@vger.kernel.org, chao.p.peng@linux.intel.com,
	chao.p.peng@intel.com, erwin.tsaur@intel.com,
	feiting.wanyan@intel.com, qingshun.wang@intel.com
Subject: Re: [PATCH 2/4] pci/aer: Handle Advisory Non-Fatal properly
Message-ID: <20240112163526.GA2271206@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111073227.31488-3-qingshun.wang@linux.intel.com>

On Thu, Jan 11, 2024 at 03:32:17PM +0800, Wang, Qingshun wrote:
> If we are processing an Advisory Non-Fatal Error, first check the Device
> Status. If any of Fatal/Non-Fatal Error Detected bits is set, leave it
> to uncorrectable error handler to clear the UE status bit, which should
> be executed right after the CE handler in this case.
> 
> Otherwise, filter out uncorrectable errors that is not possible to
> trigger an Advisory Non-Fatal Error, then clear all the rest status bits.

> +static int anfe_get_related_err(struct aer_err_info *info)
> +{
> +	/*
> +	 * Take the most conservative route here. If there are
> +	 * Non-Fatal/Fatal errors detected, do not assume any
> +	 * bit in uncor_status is set by ANFE.
> +	 */
> +	if (info->device_status & (PCI_EXP_DEVSTA_NFED | PCI_EXP_DEVSTA_FED))
> +		return 0;
> +	/*
> +	 * An UNCOR error may cause Advisory Non-Fatal error if:
> +	 *	a. The severity of the error is Non-Fatal.
> +	 *	b. The error is one of the following:
> +	 *		1. Poisoned TLP
> +	 *		2. Completion Timeout
> +	 *		3. Completer Abort
> +	 *		4. Unexpected Completion
> +	 *		5. Unsupported Request

This could benefit from a reference to the spec that outlines these
conditions.

Bjorn

