Return-Path: <linux-pci+bounces-8759-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DEE907DCE
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 23:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B57FB24573
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 21:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2502013B58A;
	Thu, 13 Jun 2024 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYPR2Ky4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAB4139CE2;
	Thu, 13 Jun 2024 21:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718312777; cv=none; b=jjy0DLzkDPSpqUS9XEbXYRsRSDu8NJQ+Mj0yof9GfNMq1F3HkFSqsb/8bTzOD7FTLVybfFt1b9SDQOS8Kv/JpBcQJfuOCMPfOr1U8zKrTv2uDK2lX1O5JuOpwo7IJJidJlpTTR7jxKlvLQdnPGv++0dcNLrIPHh6nU1UR+uEeU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718312777; c=relaxed/simple;
	bh=dZba39hnCowmc0pZmrIXvEi2zoYdUdHjuntIBlNjS8E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HyN1C/1vCGK4E722uuYr0Ykcs4WXoEbCffkzexCYBnJ25BGG21VuQ598OIea2TxQF6zcgEZpzBWuu3v1KaLqbmCxXHjNIG4KT1BRf0oLCz8YuUHPzvzi5avFTsphhV5hKbfw/yX2Kv0UaA/s1Cbg8gPAm/LQb44tIiEpWQmCq4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYPR2Ky4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54530C2BBFC;
	Thu, 13 Jun 2024 21:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718312776;
	bh=dZba39hnCowmc0pZmrIXvEi2zoYdUdHjuntIBlNjS8E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BYPR2Ky4Du7wsrS+bltF98D9HrMCtHL4ExMmzEOpEKnRxdTDqkwRpQ4yPby6cTU01
	 q//gRWX7lSxAEigiQ9CqUrSw9S+kAnm7PZQkUkr0P0IElkYBWjHJhX9sB/NnGi7FpD
	 yRipPbdfd9g+pIAc8AdvuxAPNwCIQ33vTGpzwnvDhjyGmbDDzxjk0363KxJWVEKZxy
	 48UF8xEmOVWq5Z/Dktpf4n8oR8X5nr9bo3za1TYgAN0DYd4/hata3qOKou2/yKPke6
	 mKPhASsvQ2J9zWml1w0GqcX/YxG1jV8NdKx6v5TWPccjnXWMInKgB8sN02iUOpK5RC
	 E2e7d80jw9jmA==
Date: Thu, 13 Jun 2024 16:06:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>, dakr@redhat.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v9 10/13] PCI: Give pci_intx() its own devres callback
Message-ID: <20240613210614.GA1081813@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613115032.29098-11-pstanner@redhat.com>

On Thu, Jun 13, 2024 at 01:50:23PM +0200, Philipp Stanner wrote:
> pci_intx() is one of the functions that have "hybrid mode" (i.e.,
> sometimes managed, sometimes not). Providing a separate pcim_intx()
> function with its own device resource and cleanup callback allows for
> removing further large parts of the legacy PCI devres implementation.
> 
> As in the region-request-functions, pci_intx() has to call into its
> managed counterpart for backwards compatibility.
> 
> As pci_intx() is an outdated function, pcim_intx() shall not be made
> visible to drivers via a public API.

What makes pci_intx() outdated?  If it's outdated, we should mention
why and what the 30+ callers (including a couple in drivers/pci/)
should use instead.

Bjorn

