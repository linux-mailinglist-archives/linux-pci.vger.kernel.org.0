Return-Path: <linux-pci+bounces-8753-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F11907BBA
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 20:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F03CB2180C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 18:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC978144D0C;
	Thu, 13 Jun 2024 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9eSwAzF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28B712FF76;
	Thu, 13 Jun 2024 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718304433; cv=none; b=nhommrHOHDHIESM0u3mw6l4f3TSrzmuLANK4omW3q3cAJ/x13r4i4254WxdYyNTrFGIp4pYmw7uzmYcw+0WZ2lt1tFYOFbdCuqtGmerSrRNKXIfQfQVGQax47+53OIKkRYcy8Mud2igDf/EkBW2pHFc9cx0nnzv1mmV8/63q9FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718304433; c=relaxed/simple;
	bh=6CfjmERPAvC/8/2dtK9KLsIJQPfSvo/2DU6MYJDWabE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FQh7YvPzNVqXyznw0pqZCLhgsHIdtniw3kMOeFhHkmb4i3tK9V3Fm3XUf8Ns8nkFVT18Ie/ielA93+/CQSP47sFjgjgT5PAdH1BLzBI8LiEyPW7eu3fLNFdtbPWUDOO6xHyZE2S8RSf58Xez0Lw4y/IsSWAvmh8v8Xsf3OYf7AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9eSwAzF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E392C2BBFC;
	Thu, 13 Jun 2024 18:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718304433;
	bh=6CfjmERPAvC/8/2dtK9KLsIJQPfSvo/2DU6MYJDWabE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=G9eSwAzFL/TAvwfSbOZgnbg9fyai0gIxBIozJGDKSH4J0uUHoUz+UyiEW4rjAloW4
	 EgfpsYNd9t0SzTjfplKpzl61omwfIibj/5GpeST/gqH2zNlSWJ6ThukiNfnCSvtJao
	 GjllABGwoV8f/CLolKnTfTg6HGHGRwB3huU7pC/PDhDoPpNydkxuD15MQA2WupbUvK
	 cFUTkSquJsJRAXhrhLqiMQZTFXZyB870KLkO1EF793QHNghAQPcBA9eotv8ZX3reEH
	 0hfrFsTSNUEkQqEK83VjFoNyuaAdgEeObMNV6g3kqV1NAuFYWaM9Mpkclhj561maRp
	 jLakN3XEU9nhw==
Date: Thu, 13 Jun 2024 13:47:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Philipp Stanner <pstanner@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>, dakr@redhat.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 10/13] PCI: Give pci(m)_intx its own devres callback
Message-ID: <20240613184710.GA1072582@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6cd568a9-1332-5a47-bdb2-ea079a8462af@linux.intel.com>

On Thu, Jun 13, 2024 at 08:23:26PM +0300, Ilpo Järvinen wrote:
> On Wed, 5 Jun 2024, Philipp Stanner wrote:
> 
> > pci_intx() is one of the functions that have "hybrid mode" (i.e.,
> > sometimes managed, sometimes not). Providing a separate pcim_intx()
> > function with its own device resource and cleanup callback allows for
> > removing further large parts of the legacy PCI devres implementation.

> > +/* Used to restore the old intx state on driver detach. */
> 
> INTx

Updated locally in v9 series.

> > @@ -392,32 +397,75 @@ int pcim_set_mwi(struct pci_dev *pdev)
> >  }
> >  EXPORT_SYMBOL(pcim_set_mwi);
> >  
> > +
> >  static inline bool mask_contains_bar(int mask, int bar)
> 
> Stray change.

Updated locally in v9 series.

