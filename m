Return-Path: <linux-pci+bounces-21299-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7EAA32E1E
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 19:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF0883A8FA3
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 18:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC2B25B66C;
	Wed, 12 Feb 2025 18:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ad6Y00Hx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28DE209663;
	Wed, 12 Feb 2025 18:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739383460; cv=none; b=nTmXjpjhLRwedyx74MyMRKSIFpDQ4wKsmyD1hhxOwUxhWXFtgJOtX33juVkVa3vuKDb69CNLIGJLkSLegBCnOJWe2YUqKSkEs3vXFqa2dIyEdcSdOVtnC7d/Sp3gzMvLZs+LZWtzTjIvDkhO2xJWc+dqwWVPUhSgf/ZgFtK+dDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739383460; c=relaxed/simple;
	bh=WS+R/MsKFg8gFxvOplGbhuZvpxRikRAbX5wBQj9Cnjk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eDzYjaMzh9LOsxmFneUVa0BSNZpogrbiJQn8+TDmS2rws+2Oq5F8Bnij0LQqKVnI0XeGp0Sgdqc2Bd5BM9PF3P1rIigED/2O+vt0qbEpZe379iopjdC9dGwCV3/E4dsZxEIthOCuIPHmjPR91EZcKY/ovM0R7AA5jQjSWbXxWFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ad6Y00Hx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC491C4CEE2;
	Wed, 12 Feb 2025 18:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739383460;
	bh=WS+R/MsKFg8gFxvOplGbhuZvpxRikRAbX5wBQj9Cnjk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ad6Y00Hxis2VHNE+cLwsU1pGxEAgDcklFFThTU3lTKWlQEkO53CLvt6/yvyOE9vL1
	 xPzPSsqbISnQ/0bjC3XVm4y16gziqZuV0252ZL8tUB8HBB9bgzmE/ytl350C6b3ryJ
	 aq5XDJSj1CM5tQEsXNopN28X6to4bUQbLDi1xWzjlfcE8nK8qvACpcLCEaEEoxLS4k
	 qzUZ5NBOCtLUhAIlY/p04DuY205BpRJtzUOJhjJlN2QV3TZ6nmcwAWYWS3psncyobs
	 +V3Fe1KvyOeYSpLD1CIMHja55bMZ3J2U8nSHz6yzM29U5zArLuTkRuEYHMz0uVThus
	 aNnePWVa/TpAA==
Date: Wed, 12 Feb 2025 12:04:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v5 -next 00/11] Add PCIe support for bcm2712
Message-ID: <20250212180416.GA86064@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a74f5917-af94-42a1-9a7a-dd449d34dbfc@suse.de>

On Tue, Feb 11, 2025 at 03:30:22PM +0200, Stanimir Varbanov wrote:
> Hi Bjorn,
> 
> Do I need to send a new version with the collected Acked/Reviewed tags?

No need to resend unless you change the code.

Bjorn

