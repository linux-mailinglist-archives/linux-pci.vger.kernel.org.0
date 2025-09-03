Return-Path: <linux-pci+bounces-35365-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 779B6B419B5
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 11:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A71416AB6D
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 09:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2E327D77B;
	Wed,  3 Sep 2025 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0GD9JZj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E1F17BA6;
	Wed,  3 Sep 2025 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756890882; cv=none; b=N2SqXSdXWJLt4F+7TRvmHdf91tmsp+/f0FXxHNZKAXSXj6OaZ3sIzm8ecWUGBdAUiuYgRdZgWE+KDtE6swHH2V+4PN7UdvBKKZett5t8XMmoA+CRD1/6cG9ffsrisqu/CknZLGnD24Q20XgQi4WLDoTKxuPzhea9n71ikGQlkU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756890882; c=relaxed/simple;
	bh=sceKBbEjuX10A+AkYDSZ/1ERhAyghC9G3UJ1z+F65x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLU1VmslpqeHf6V3nQE2y7MfGnZ3xhT3qI7MoF8wWzPOvXspca1ik98gmrWc5WMJlmF7pvblGtdgIggMBUPaLaXseyty3IMfz3koMRttpRjQLhZRJEeKHDBuyKbIlpdgEpN9XESk8pHTyWA8DPkOpGlnfF58HBkJAzdNGgUaPl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0GD9JZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1A9C4CEF0;
	Wed,  3 Sep 2025 09:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756890882;
	bh=sceKBbEjuX10A+AkYDSZ/1ERhAyghC9G3UJ1z+F65x0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R0GD9JZjjefoWeI3TbF79xIHLv8wuFwc9BCe+YuMZ4NQJ+IhGu0DVKZJnms7NU5wk
	 fj0RMGdssIHdVWJTwyNqDGV8oo5O8miB+wS3VRybTtoaS/hvS/OiGUHoTawa8zqZy7
	 1UnUI98gRVNtUaxxWSCWdRFWgo1Hxod2qeNyCiaK1Vk8bEkOaBFnbGufpbYmqVFIe3
	 r9deubPalAMiVQ2EjLlzB9sSPKu4TmIZOoqv18LN0g+BKuijRajtIAwcmsZFXqudky
	 fswPb4GxTnOX742c7AMF5ufi0CtZW1W37xgmo+dMMIIofMiZq9zOzzUiPesuaq/iEh
	 mhmhqQFf5X6wg==
Date: Wed, 3 Sep 2025 10:14:37 +0100
From: Lee Jones <lee@kernel.org>
To: Marcos Del Sol Vives <marcos@orca.pet>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Michael Walle <mwalle@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-gpio@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 3/3] mfd: vortex: implement new driver for Vortex
 southbridges
Message-ID: <20250903091437.GF2163762@google.com>
References: <20250822135816.739582-1-marcos@orca.pet>
 <20250822135816.739582-4-marcos@orca.pet>
 <20250902151828.GU2163762@google.com>
 <45b84c38-4046-4fb0-89af-6a2cc4de99cf@orca.pet>
 <20250903072117.GY2163762@google.com>
 <4057768b-82f3-4b5b-b301-afae30bd5bca@orca.pet>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4057768b-82f3-4b5b-b301-afae30bd5bca@orca.pet>

On Wed, 03 Sep 2025, Marcos Del Sol Vives wrote:

> El 03/09/2025 a las 9:21, Lee Jones escribió:
> >> vortex_dx_sb are "struct vortex_southbridge" type, not raw MFD API data.
> > 
> > I like your style, but nope!
> > 
> > vortex_southbridge contains MFD data and shouldn't exist anyway.
> 
> I'm not sure if I follow.
> 
> You're suggesting not using driver_data at all and using a big "if" instead,
> matching manually myself on the correct cells to register against the PCI
> device ID, instead of relying on PCI matching giving me already the cells
> structure inside driver_data?

Yes.

> That seems to increase code size and be more error prone for no reason.

It may make sense for your use-case, but believe me, I've seen some
crazy implementations of this.  I found it's easier just to have a no
cross contamination of early init APSs rule and call it a day.

-- 
Lee Jones [李琼斯]

