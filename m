Return-Path: <linux-pci+bounces-31967-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A3FB02752
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 01:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927CE1C883FD
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 23:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478CE1F5852;
	Fri, 11 Jul 2025 23:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syeIDBXD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D54EEBD;
	Fri, 11 Jul 2025 23:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752274962; cv=none; b=PXRrseuS0+e/PuAOhYgo9DHYK+M41CycP7aHYJMCIADxyEuh8+NfggU5osWvHniMP2VfIui3B86vJk6LiuoZFJoS2E1S/wfFaBjo8LLYB+UdBQ6YJ9pksC/6u3mZLStFD3WK5pVDifYwhV5tXTKAeXKcJ3NBiD6yqaafbOLeyoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752274962; c=relaxed/simple;
	bh=oG+Ngb+WGCiXRiz5YGhrfgqAzOddD81UypLXPgQCJMk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WIaulZ1iuzXzCL4r9edzho9Ox2KZX89RYfFEXM+iKnwaij5Azn7K/UpSE3YlXKNekPM7XQ5NlrLyQx+Wuy7dNYGm9n/0/SM1xv6aCUP49uzQF0dpTKwYTJKXwmB+wl7DHKf3FhHnP55HSWj0ZdeSgBwqD1i533LccgFYgEWfZ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syeIDBXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D71C4CEED;
	Fri, 11 Jul 2025 23:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752274961;
	bh=oG+Ngb+WGCiXRiz5YGhrfgqAzOddD81UypLXPgQCJMk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=syeIDBXDaffdmA7DcgwtYj459mfbugF3AgwlYikU4fCoh31or8C+UvfUZYDvCEmfj
	 qxC5IuuzwC8G5TelfaAkL8b1lOGR0BPcvufaE8zpoI4U7vtxK7Jk3LpzHbZH26yfjg
	 lmp+Eq9Q4YB7eX6U2+DotTGTvDVHtZCvs4yt7BAAlCWajWwlPQdd6z2ChcBMWABQx0
	 4gAdztszDkCoSl0yGRLPqmTw2BZC2Mnw9HkUabLj39j7VQVQ6ep052CrE95p9ebHWb
	 HsWFVtVaiOe7LnYRVhKMufdpgD+yuxCF4GeqINz1IxGiTyJn4ZPAHW6hLPtpxqs/6N
	 kOASnkUPg2i0w==
Date: Fri, 11 Jul 2025 18:02:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
	quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v4 06/11] PCI/ASPM: Clear aspm_disable as part of
 __pci_enable_link_state()
Message-ID: <20250711230240.GA2312867@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609-mhi_bw_up-v4-6-3faa8fe92b05@qti.qualcomm.com>

On Mon, Jun 09, 2025 at 04:21:27PM +0530, Krishna Chaitanya Chundru wrote:
> ASPM states are not being enabled back with pci_enable_link_state() when
> they are disabled by pci_disable_link_state(). This is because of the
> aspm_disable flag is not getting cleared in pci_enable_link_state(), this
> flag is being properly cleared when ASPM is controlled by sysfs.

Mention the name of the function where this happens for sysfs so we
can easily compare them.

