Return-Path: <linux-pci+bounces-18045-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A6B9EB99D
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 19:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A7F164D35
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 18:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC811AAA28;
	Tue, 10 Dec 2024 18:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVSnX2Al"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A6923ED41;
	Tue, 10 Dec 2024 18:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856542; cv=none; b=q2ecN3tVUDnWOA0T6aVtTL1vbavLchnGP3aaRc0jXW4nNvrn/ztPbDezJFDVKkp1u2BI3Rtq1fnwJ6s8E6waaBIGRrRy01VWzckbdgf6dwGaMCIvi2wUHGyKc6cVIwv8enrVReFqmelSrS1na+uOXYO6yEoA4yrrzSL/MI0zWuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856542; c=relaxed/simple;
	bh=NVCHwBsGay9WTJEPiQETW3pa1CoUcGd4J0Oan7Uw61U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mfL+oGNBj8QSeU2CuXzKJywmEbxBKMv8E13FHwyf+sWu3ipM3AIq9IIvmljTej12eu+KY7AuwOfeKkNpGUVxBnGyanZwCjx70PiMLZRwxd4H4KoQbp/y/w9XxS20tHpeAewRfN4qUtrH9Zdrrli2zOMiygZYIxI12lrC388A6w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVSnX2Al; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E55AC4CED6;
	Tue, 10 Dec 2024 18:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733856542;
	bh=NVCHwBsGay9WTJEPiQETW3pa1CoUcGd4J0Oan7Uw61U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rVSnX2AlGgUUbOi0S1d9e/KDH34Eej1SdylTuyhkcfY0/J78Iq0za0bPPCC7iqb0q
	 9sCBv1fbRVGA0Wwigz7855t8CzC58QIMrjXt8ioziy0tA/QUjnMcO5Cjf2uvgdISFh
	 bjdKuewE6t7U/thKulG7ocL6k9sY/S9t/q2G8fyRwRi+3bIpVpOpX29erkh9zKw19T
	 /N47cchyTB6t8P7tqB2tsXME/aozt2B7p3V731Nmb1hDL0xH7kBW9LF3ffojjz3PpM
	 /7LZkZsrzmXAen1VegCyGsKoJMpXHwCTABSJ3SzQ8e11intlVc4UD0T1lw2DvjDa94
	 e5M+JGEvJA97g==
Date: Tue, 10 Dec 2024 12:49:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, aik@amd.com, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 10/11] PCI/TSM: Report active IDE streams
Message-ID: <20241210184900.GA3079930@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173343745420.1074769.13008006909323222504.stgit@dwillia2-xfh.jf.intel.com>

On Thu, Dec 05, 2024 at 02:24:14PM -0800, Dan Williams wrote:
> Given that the platform TSM owns IDE stream id allocation, report the
> active streams via the TSM class device. Establish a symlink from the
> class device to the PCI endpoint device consuming the stream, named by
> the stream id.

s/stream id/Stream ID/ to match spec usage as a proper noun

> +++ b/Documentation/ABI/testing/sysfs-class-tsm
> @@ -8,3 +8,13 @@ Description:
>  		signals when the PCI layer is able to support establishment of
>  		link encryption and other device-security features coordinated
>  		through the platform tsm.
> +
> +What:		/sys/class/tsm/tsm0/streamN:DDDDD:BB:DD:F

Typical formatting of domain is %04x, including in existing sysfs
docs.

