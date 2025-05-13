Return-Path: <linux-pci+bounces-27608-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D73AAB4AA1
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 06:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 730E33AC796
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 04:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D461B1ADC7C;
	Tue, 13 May 2025 04:47:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744282AD0B;
	Tue, 13 May 2025 04:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747111676; cv=none; b=a56MhzwlSXHk/NJtPKoONiudpogdJ4lhFMTEDqbWImD0wAfjW0O8bnWEObG+q/nNQSjeEZUJAFBopS0PaA4MzHWWgSL3/Ek2VVkQr5hEdLByT0+Wx7tsx73/051PWwDdVP1agjWb25HGafXcgDtLhLPokTHDQl+mVLXW5XAIEq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747111676; c=relaxed/simple;
	bh=bpZLwoDCmcfWVclWahXyItixibHQBMwEXcHwhLN6ux0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejaF+C1mHqEFU6iOrjHDCGDWoqnN8kWY5Z3s9RE2i0B3LMUWA4/xAigOLCniP1TWq+nq7QAFnq07wG8lms2R4XG9DD8+H5BI1xILOrRgWPE9bdJoGGa7nWrmp5pKwfUPnFUBzESt/541ZeF9wM/67t3hlMjQUWAlo4TMvxNa1Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 6D254200A2AD;
	Tue, 13 May 2025 06:41:04 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 206BB20868C; Tue, 13 May 2025 06:41:31 +0200 (CEST)
Date: Tue, 13 May 2025 06:41:31 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Raag Jadav <raag.jadav@intel.com>
Cc: rafael@kernel.org, mahesh@linux.ibm.com, oohall@gmail.com,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	aravind.iddamsetty@linux.intel.com
Subject: Re: [PATCH v3] PCI: Prevent power state transition of erroneous
 device
Message-ID: <aCLNe2wHTiKdE5ZO@wunner.de>
References: <20250504090444.3347952-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250504090444.3347952-1-raag.jadav@intel.com>

On Sun, May 04, 2025 at 02:34:44PM +0530, Raag Jadav wrote:
> If error flags are set on an AER capable device, most likely either the
> device recovery is in progress or has already failed. Neither of the
> cases are well suited for power state transition of the device, since
> this can lead to unpredictable consequences like resume failure, or in
> worst case the device is lost because of it. Leave the device in its
> existing power state to avoid such issues.

Have you witnessed this on a particular platform / hardware combination?
If so, it would be good to mention it.  If I'd happen to find this
commit in the future through "git blame", that's the first question
that would come to mind:  How and on what hardware was this actually
triggered, how can I reproduce it.

> +	/*
> +	 * If error flags are set on an AER capable device, most likely either
> +	 * the device recovery is in progress or has already failed. Neither of
> +	 * the cases are well suited for power state transition of the device,
> +	 * since this can lead to unpredictable consequences like resume
> +	 * failure, or in worst case the device is lost because of it. Leave the
> +	 * device in its existing power state to avoid such issues.
> +	 */

That's quite verbose and merely a 1:1 repetition of the commit message.
I'd recommend a more condensed code comment and anyone interested in
further details may look them up in the commit message.

Thanks,

Lukas

