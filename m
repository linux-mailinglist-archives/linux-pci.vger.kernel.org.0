Return-Path: <linux-pci+bounces-14410-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75FE99B922
	for <lists+linux-pci@lfdr.de>; Sun, 13 Oct 2024 13:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A212818F3
	for <lists+linux-pci@lfdr.de>; Sun, 13 Oct 2024 11:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE104086A;
	Sun, 13 Oct 2024 11:04:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C20288B5
	for <linux-pci@vger.kernel.org>; Sun, 13 Oct 2024 11:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728817447; cv=none; b=Xt1Xyrzj5qokR5uM6kxCXQhNJ4Xp8fP/1cRa3mU3KZfOGpyCLEbj7iz1AjqmNaOhcx9piVwvZRe00qMOZOymRcfAwZzSx99K43hnmGUWoS1nmbyG7t4xFUcVTQdkA7c+EYjcFBCz9wpT3UCWlw9+bvmKGPSS4hxaw/130Svlkag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728817447; c=relaxed/simple;
	bh=V18cflFrrJsAxoyeOhedM7bo8HkF6OsJRWyEnjh0ZqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T81izuS4WgySg9cH5EeIwyxYaaoQqh+Q9JraK2dyof3HdrsXBw+kB8D7zEv4e8KjiC9n7aEoFs6Kh0bmOOTn5JTnXIK0XwkJzSZ+ZjgxhPVUrAgiokdAcCr0BSoo4lj95gAYssZ1C7UxJextxy2l5IFre3DOoxwEpzbJm9BwoKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 42A0E100DEC90;
	Sun, 13 Oct 2024 13:03:56 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1A5AA1F3E15; Sun, 13 Oct 2024 13:03:56 +0200 (CEST)
Date: Sun, 13 Oct 2024 13:03:56 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Marek Vasut <marex@denx.de>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] [RFC] PCI/PM: Do not RPM suspend devices without drivers
Message-ID: <ZwupHAAwTo5mDyyA@wunner.de>
References: <20241012004857.218874-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012004857.218874-1-marex@denx.de>

On Sat, Oct 12, 2024 at 02:48:48AM +0200, Marek Vasut wrote:
> The pci_host_probe() does reallocate BARs for devices which start up with
> uninitialized BAR addresses set to 0 by calling pci_bus_assign_resources(),
> which updates the device config space content.
> 
> At the same time, pci_pm_runtime_suspend() triggers pci_save_state() for
> all devices which do not have drivers assigned to them to store current
> content of their config space registers.
[...]
> Work around the issue by not suspending pci_bus_type devices which do
> not have driver assigned to them, keep those devices active to prevent
> pci_save_state() from being called. Once a proper driver takes over, it
> can RPM manage the device correctly.

It sounds like you may want to acquire a runtime PM reference
or disable runtime PM for the duration of the bus scan (or at
least device scan) rather than the proposed workaround.

Thanks,

Lukas

