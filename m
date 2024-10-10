Return-Path: <linux-pci+bounces-14240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8446999530
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 00:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0EE2860B4
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 22:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737991E2839;
	Thu, 10 Oct 2024 22:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pf4BhbzN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B93519A2A3;
	Thu, 10 Oct 2024 22:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728599258; cv=none; b=h74DnQkPjD2RqJmnDY6mK63C2kqDAcM7lV6w7ImOOWGbJ/+JJGkOt/LKuTh8I01khwUdoZCr1GHEcoqk/4DamTLUeJwSOeihjFjNs3Ci+N98wVAB9v/gZdkuh6v4TVEwwfktpiAcyDZXXThFGI763a7D688FG7T6VMxjymqoPj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728599258; c=relaxed/simple;
	bh=oTNzX0Px6F2ZuEdSdbpP0nHju9ehSWKosmu3toVlgy0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ByKnQq39O8NdM3yp3C2bTlDkuG/4SNBVb4gCmMCW/pvak1i1cXLXgM4M9KB7lAMT+j3qq0QIi0ZjdYQaHY4IukHM1Oyid9TloSM0XaOOBBaqgYtMt1cwx2mMDsMGb518D+Ycb9zm9WHG4b0H0apsavVuNjW/0zNKKjwO+24M8rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pf4BhbzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739D1C4CEC5;
	Thu, 10 Oct 2024 22:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728599257;
	bh=oTNzX0Px6F2ZuEdSdbpP0nHju9ehSWKosmu3toVlgy0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Pf4BhbzNjET2vqzRkOWkNObKT9+3v+3g4SHSdy+1tpvL6vl4hEwcRRznlwxWc9SpL
	 2ImhQkURL1Dsm0G/uFMlhz02FywDkPw2ml5J544X1gV81NSDVwgV1rakOLFsmiBbNV
	 EIQ2DwNgm20C5hTNMOUxlG+Xwjn2CJ9o4QJSzRPuscYWDllIHfGQN5orwonzHDa7w7
	 LBlGkdFS4EBJbVMjP+eJCc3tYX/lo4nIx0oyc431qSUO3wcI3TzRdF69JB0LByP5JJ
	 +eL9i4RdpAVTQDveIkREhRXCYwXqng5nPWsiU7lCP12cHtKUPqMPIlBjwvq9Q4f52O
	 FjtjwkQ/xbYhg==
Date: Thu, 10 Oct 2024 17:27:35 -0500
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
Subject: Re: [PATCH v3 4/5] PCI/IOV: Allow extending VF BAR within original
 resource boundary
Message-ID: <20241010222735.GA580854@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241010103203.382898-5-michal.winiarski@intel.com>

On Thu, Oct 10, 2024 at 12:32:02PM +0200, Michał Winiarski wrote:
> VF MMIO resource reservation, either created by system firmware and
> inherited by Linux PCI subsystem or created by the subsystem itself,
> contains enough space to fit the BAR of all SR-IOV Virtual Functions
> that can potentially be created (total VFs supported by the device).

It's *possible* that this is true, but there's no guarantee that
firmware has assigned enough space for all BARs of all possible VFs.

> This can be leveraged when the device is exposing lower than optimal BAR
> size as a default, allowing access to the entire resource when lower
> number of VFs are created.
> It is achieved by dynamically resizing the BAR to largest possible value
> that allows to fit all newly created VFs within the original resource
> boundary.

Add blank lines between paragraphs.

This log doesn't actually say what the patch does.  It describes a
possible configuration and ways that it may be used, and even *how*
something might be done, but something along the lines of the subject
line should be included in the commit log.

> +static void pci_iov_resource_do_extend(struct pci_dev *dev, int resno, u16 num_vfs)

Please wrap to fit in 80 columns like the rest of the file.

> +int pci_iov_resource_extend(struct pci_dev *dev, int resno, bool enable)

Please add kerneldoc here to help users of this exported function.

> @@ -480,6 +560,11 @@ static ssize_t sriov_numvfs_store(struct device *dev,
>  		goto exit;
>  	}
>  
> +	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
> +		if (pdev->sriov->rebar_extend[i])
> +			pci_iov_resource_do_extend(pdev, i + PCI_IOV_RESOURCES, num_vfs);

Wrap to fit in 80 columns.

Bjorn

