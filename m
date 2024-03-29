Return-Path: <linux-pci+bounces-5368-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1CD891268
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 05:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5289288C84
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 04:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0362DF73;
	Fri, 29 Mar 2024 04:41:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145782C9A;
	Fri, 29 Mar 2024 04:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711687288; cv=none; b=tGcCBVYqXEbvQjrI6h38Ic+E0Ce/bZVPxn53foKH8v/344fRtUmtS4xNwjgmaUMXXDGbs/hL3S7zRg6e+75yJeuBwv77TFl9/7iPgVLO6jQ+sOpL3GuaODXWsXAw2KRW62xKzNIVVzgHiHB5Ub8eoZyQ8dLSS0L2YECV1d95038=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711687288; c=relaxed/simple;
	bh=xFBtzDrwQogRYJw90bkQgmgiOw9iHxCR+ytb2sDGFUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkFMhDZeM3lY/3bVWDfooylvtYYjHFBxYqN7zgSlbQ96Ez+A9SPsiQbopyZtwqdN9Glf48fNMILyO7eBz9hzuso6vyX3nKvHYiKP6aODS+ii7fB4JRGdP8TjRaqhs0EMYdud8E0GGNEykhXQETGBYV2HYVFOixz2IHHMORZbr7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id C5A742800BB3F;
	Fri, 29 Mar 2024 05:41:16 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B152412BC84; Fri, 29 Mar 2024 05:41:16 +0100 (CET)
Date: Fri, 29 Mar 2024 05:41:16 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, edmund.raile@proton.me,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v2] PCI: Mark LSI FW643 to avoid bus reset
Message-ID: <ZgZGbMj0I3_6Rt0f@wunner.de>
References: <20240326131858.GA140624@workstation.local>
 <20240327150119.GA1502858@bhelgaas>
 <20240328144201.510f6d5e.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328144201.510f6d5e.alex.williamson@redhat.com>

On Thu, Mar 28, 2024 at 02:42:01PM -0600, Alex Williamson wrote:
> On Wed, 27 Mar 2024 10:01:19 -0500 Bjorn Helgaas <helgaas@kernel.org> wrote:
> The original patch proposed for this gave me the impression that this
> was a device used on various old Mac systems, not likely applicable to
> a general purpose plug-in card.

I'm still using one of those "old Mac systems" as my daily driver.

Just checked the ACPI tables and there's an FPEN method below the
FRWR device which toggles GPIO 48 on the PCH.  Checked the schematics
as well and GPIO 48 is marked FW_PWR_EN.  The GPIO controls load
switches which cut power to the FW643 chip when nothing is connected.

Also, FW_PWR_EN feeds into an SLG4AP016V chip where it seems to
internally gate FW_CLKREQ_L.

I'm guessing the driver may need to call the FPEN ACPI method after
issuing a SBR to force the chip on (or perhaps first off, then on)
and thereby re-enable Clock Request.

It's a pity the ohci.c driver doesn't seem to support runtime PM.
That would allow cutting power to the chip when nothing is connected
and thus increase battery life.  The ACPI tables indicate that the
platform sends a notification when something is plugged in, so all
the necessary ingredients are there but we're not taking advantage
of them.

Thanks,

Lukas

