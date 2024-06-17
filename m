Return-Path: <linux-pci+bounces-8876-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F92790B6EC
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 18:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBFEA283C13
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 16:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D3E166312;
	Mon, 17 Jun 2024 16:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUYl9lUh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC0F1662F7;
	Mon, 17 Jun 2024 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718642767; cv=none; b=UQFF9/afnvP8hLoOoOLfpndqXbgD59S311R5XlTNmLSJXZJHEWWW3mZvQnkNgHBh9I4E49VszBITXjU8R8QB66EwBiDGs6UTSTXapXYNIgkWVLDBpK05lluku5dvCNQz4FeS09Krmz0dwLcHik6WBeoyMfF2f3gufHwqaKxaHJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718642767; c=relaxed/simple;
	bh=xO8XChDFPCNzZpffI0GKMk7UAMqF5tKfD7aEDZU04+0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DfvVD9njF7UDR0dy3CVVs//Eret6QWsx62E/3BuC0QjAgNsamHHB3nFksF9QRwQcOFV+iqPU1V/If6OPfXYOTItoq8Xknn/oRnLFm9DM4qBNHPLSw67k1F+OkAS+q8hBOeTsJ89riBYYv5czURopq4L0IZ3mYD9vIrlqiiXuDKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUYl9lUh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E4AC3277B;
	Mon, 17 Jun 2024 16:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718642766;
	bh=xO8XChDFPCNzZpffI0GKMk7UAMqF5tKfD7aEDZU04+0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YUYl9lUhjz94BZhQz9/gYarQ4pOP/8GbvmV5pbrZTc53wcOzF6VDfcg6f3DVoi1XT
	 x8/z6mIHV4rBgEd8BjjcFZfKc1JEf01iWfbWijJ6YAJOwcodXaA4WVU6CoKAHAGYhr
	 m7NDyCRTKNMrAPVNySrfPeVCYQf7ENQK19yJNOYXsgBfGE+AVK5PXLb7+eZA30szCJ
	 OhIyGseEwn/ZWqEn2QTNpNkBX005hHX5oZkzXqtuPW8eNr33jGRaY05q6SlX2gCR+E
	 zLi65gBwLERJiF0ogsYdBKnRdtTOlvGk00YuX0weMynueY98RQthvNC40kBra3JjiO
	 VldAMGaR8udNw==
Date: Mon, 17 Jun 2024 11:46:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>, dakr@redhat.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v9 10/13] PCI: Give pci_intx() its own devres callback
Message-ID: <20240617164604.GA1217529@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdfd5c582e7b858d3f32428000d2268228beef5f.camel@redhat.com>

On Mon, Jun 17, 2024 at 10:21:10AM +0200, Philipp Stanner wrote:
> On Fri, 2024-06-14 at 11:14 -0500, Bjorn Helgaas wrote:
> > On Fri, Jun 14, 2024 at 10:09:46AM +0200, Philipp Stanner wrote:
> ...

> > > Apparently INTx is "old IRQ management" and should be done through
> > > pci_alloc_irq_vectors() nowadays.
> > 
> > Do we have pcim_ support for pci_alloc_irq_vectors()?
> 
> Nope.

Should we?  Or is IRQ support not amenable to devm?

Happened to see this new driver:
https://lore.kernel.org/all/20240617100359.2550541-3-Basavaraj.Natikar@amd.com/
that uses devm and the only PCI-related part of .remove() is cleaning
up the IRQs.

