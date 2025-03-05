Return-Path: <linux-pci+bounces-23012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8746A50BA9
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 20:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180AC1894E51
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 19:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DBB25335D;
	Wed,  5 Mar 2025 19:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlvWTlSK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D319C78F3A;
	Wed,  5 Mar 2025 19:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203718; cv=none; b=K981Y3WFING14KU1cfOYsGUZBqWPmj7xnZwbYX8I2dxM+Oc2nC8yln3HfrhIqCdfvUOdZuj89LqDpORmsrJJwhneJ4QJYIaOLNB8drnxJfB/+TIWeScE3oSePRFOXLRl0qn51K5D2SS4oKg7+mirp0LdMvkOX1ICs8q1S2a67lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203718; c=relaxed/simple;
	bh=09KBCtyH3qwfcdlEzXR7ea7uD5dPwadkoEZ6N270w3o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GjilmFgSMjX+JVcUieJifsZYrtIYJjlNRGebdxFvXF+YibTVP4A7IYMY2CsCSCM+bt7+3xvM7S7UD870u4pulezMxpJ7sri+fcvdiAuHvG80OwTuLNTyHZ32S+pLi12jvk1kHth9njuYOltO4pjTjL/yrD6q7zzj6eN0e9e2HqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlvWTlSK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEB8C4CED1;
	Wed,  5 Mar 2025 19:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741203718;
	bh=09KBCtyH3qwfcdlEzXR7ea7uD5dPwadkoEZ6N270w3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LlvWTlSKtMBLCbW9eWVCFYRmw1xkWNmLquOTZdbteQJ7HUx0YVK1cMzh+Jmbd5QO2
	 q9hXWUHKoccY+WTucWtIi0aUlFs17vRPtziTTY5kya7G5jVGvwuXWCenQh1c+Mt/EN
	 HAL96lHMmmuv69+auFfqEc00iEblXZo1BCNseTvGXaKDB/75Ap5l7oq9GOPzS0S4rW
	 BbTDNPtzGOLX53OgdVCMo60VeZ61OYwef3p7GgJPhfgwEbP1MTVsp8mqL8wsDWzxRZ
	 /Ht1p/Q+2W27tYmfP15Ah0fZavshfKjvAwtHlnX9TZnhH0xXPESWynFVzjzTJ1ybTK
	 t4FLVX4+XH5Yw==
Date: Wed, 5 Mar 2025 13:41:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alistair Francis <alistair@alistair23.me>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com, lukas@wunner.de,
	alex.williamson@redhat.com, christian.koenig@amd.com,
	kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
	linux-kernel@vger.kernel.org, alistair23@gmail.com,
	chaitanyak@nvidia.com, rdunlap@infradead.org
Subject: Re: [PATCH v16 3/4] PCI/DOE: Expose the DOE features via sysfs
Message-ID: <20250305194156.GA309932@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227043404.2452562-3-alistair@alistair23.me>

On Thu, Feb 27, 2025 at 02:34:02PM +1000, Alistair Francis wrote:
> The PCIe 6 specification added support for the Data Object
> Exchange (DOE).
> When DOE is supported the DOE Discovery Feature must be implemented per
> PCIe r6.1 sec 6.30.1.1. The protocol allows a requester to obtain
> information about the other DOE features supported by the device.

> +What:		/sys/bus/pci/devices/.../doe_features
> +Date:		March 2025
> +Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
> +Description:
> +		This directory contains a list of the supported
> +		Data Object Exchange (DOE) features. The features are
> +		the file name. The contents of each file is the raw vendor id and
> +		data object feature values.
> +
> +		The value comes from the device and specifies the vendor and
> +		data object type supported. The lower (RHS of the colon) is
> +		the data object type in hex. The upper (LHS of the colon)
> +		is the vendor ID.
> +
> +		As all DOE devices must support the DOE discovery protocol, if
> +		DOE is supported you will at least see the doe_discovery file, with
> +		this contents
> +
> +		# cat doe_features/doe_discovery
> +		0001:00
> +
> +		If the device supports other protocols you will see other files
> +		as well. For example is CMA/SPDM and secure CMA/SPDM are supported
> +		the doe_features directory will look like this
> +
> +		# ls doe_features
> +		0001:01        0001:02        doe_discovery

Does this text need to be updated with s/protocol/feature/ as in the
first patch?

