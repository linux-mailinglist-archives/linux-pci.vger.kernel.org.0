Return-Path: <linux-pci+bounces-2238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B18B482FCE1
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 23:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDDE51C27FBE
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 22:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0D83D3B1;
	Tue, 16 Jan 2024 21:40:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A494364C5
	for <linux-pci@vger.kernel.org>; Tue, 16 Jan 2024 21:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705441230; cv=none; b=f86n5B0wP2iP2DZtegv7VMBJdCbxTyjfmuGN7NaGPJ9wzDUw1ZBra4U9rUz3JO/ZqeTM2yeTgSZJTBDI7UpH2kl3GMNEcqjYHF9xug6bpXUzfQWZaPw7wKovNBDopuaiwbpobfbJRv2YV7Oi/CMxBI3X90GRIXAmwfQbWWJepgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705441230; c=relaxed/simple;
	bh=tvdMsm9MAbU2KTmtR20qA5yN6GLHmSzIv222nnd1ZZ0=;
	h=Received:From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=VtGCnnz3tRgYERog5NRkQKor0OcSYTQ36Z5Zfab1RloLSFDFvpNe7gHMIwwMBxb0ZApXcSh1An6Frq3nfJ28gmG7iWBpbsQAg7msLQ1LvKfhdoTNWW0zKrXmkZesJ6tEEdJ/EYhWQ8AKMUuu1HkoyrIJ5RzAMC1YJ5SYUz1a+hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-24-108.elisa-laajakaista.fi [88.113.24.108])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id dc7f56ef-b4b7-11ee-abf4-005056bdd08f;
	Tue, 16 Jan 2024 23:40:26 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Tue, 16 Jan 2024 23:40:26 +0200
To: Philipp Stanner <pstanner@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>, dakr@redhat.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 09/10] pci: devres: remove legacy pcim_release()
Message-ID: <Zab3yr6J1S-2ujT9@surfacebook.localdomain>
References: <20240115144655.32046-2-pstanner@redhat.com>
 <20240115144655.32046-11-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115144655.32046-11-pstanner@redhat.com>

Mon, Jan 15, 2024 at 03:46:20PM +0100, Philipp Stanner kirjoitti:
> Thanks to preceding cleanup steps, pcim_release() is now not needed
> anymore and can be replaced by pcim_disable_device(), which is the exact
> counterpart to pcim_enable_device().
> This permits removing further parts of the old devres API.
> 
> Replace pcim_release() with pcim_disable_device().
> Remove the now surplus get_dr() function.

...

> +	devm_add_action(&pdev->dev, pcim_disable_device, pdev);

No error check?

> +	return pci_enable_device(pdev);

Maybe

	ret = pci_enable_device(...);
	if (ret)
		return ret;

	return devm_add_action_or_reset(...)?

I could think of side effects of this, so perhaps the commit message and/or
code needs a comment on why the above proposal can _not_ be used?

-- 
With Best Regards,
Andy Shevchenko



