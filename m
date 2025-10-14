Return-Path: <linux-pci+bounces-38007-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F17BD7619
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 07:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B191718A84E3
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 05:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A5A134CB;
	Tue, 14 Oct 2025 05:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tw6Oq6/9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2844242D97;
	Tue, 14 Oct 2025 05:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760418872; cv=none; b=DXuRkqppXYy8UymQ2gF9rUWsTC1LaaZM1NuWvP8MrjkMLF0AUSYHM4pheKZIz7hEeOSqPdQJQsGS6rpffIzBaX/MLCD1cFC7g+x+Qp7bCFJ6WPWPKkLKkXi3cGjyK9T9TlL15ArsgbRT09TgPVsnt0ONUvN11AsmBrIFxApvFIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760418872; c=relaxed/simple;
	bh=Fhp9rQ61n1O0zbFMDcKvk6k8mSPJmAyNXgYPfUA1VW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVuTRRnhmfwEMjqWvCTANHnZFYWRg4hY+ZHTp2xlHDzF9h39DptpeW5uFZk2Xx8XIPKMS7XHgrmci7QTlbDlKHpzCsSMyy76eSOi+yKuyW95RCUigZ6rqnqSDT5nJInW3JHSLKCXeCvyQTjfRZb0Q88mzR525mn77xZlzNGcV4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tw6Oq6/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4725C4CEE7;
	Tue, 14 Oct 2025 05:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760418871;
	bh=Fhp9rQ61n1O0zbFMDcKvk6k8mSPJmAyNXgYPfUA1VW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tw6Oq6/9qV6tacK0zjGLrVBm3gDFd5B5Cx9YIuv8LppuwFnkBLJ80VO2nN9GwCYzX
	 MAYZz+s3y5YazQNR2scxWANm7JnYlYIZC+F1/b6xCGJB6/7qAyQm5NlUkLqqyvlo7X
	 Od+uwAtDmkiUYlO4m5tXQaJLvvxE9jjGcEt/3UZs=
Date: Tue, 14 Oct 2025 07:14:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vincent Liu <vincent.liu@nutanix.com>
Cc: dakr@kernel.org, linux-kernel@vger.kernel.org, rafael@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] driver core: Check drivers_autoprobe for all added
 devices
Message-ID: <2025101452-legacy-gizzard-5bd0@gregkh>
References: <20251001151508.1684592-1-vincent.liu@nutanix.com>
 <20251013181459.517736-1-vincent.liu@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013181459.517736-1-vincent.liu@nutanix.com>

On Mon, Oct 13, 2025 at 07:14:59PM +0100, Vincent Liu wrote:
> When a device is hot-plugged, the drivers_autoprobe sysfs attribute is
> not checked. This means that drivers_autoprobe is not working as
> intended, e.g. hot-plugged PCIe devices will still be autoprobed and
> bound to drivers even with drivers_autoprobe disabled.
> 
> Make sure all devices check drivers_autoprobe by pushing the
> drivers_autoprobe check into device_initial_probe. This will only
> affect devices on the PCI bus for now as device_initial_probe is only
> called by pci_bus_add_device and bus_probe_device (but bus_probe_device
> already checks for autoprobe). In particular for the PCI devices, only
> hot-plugged PCIe devices/VFs should be affected as the default value of
> pci/drivers_autoprobe remains 1 and can only be cleared from userland.
> 
> Any future callers of device_initial_probe will respsect the
> drivers_autoprobe sysfs attribute, but this should be the intended
> purpose of drivers_autoprobe.
> 
> Signed-off-by: Vincent Liu <vincent.liu@nutanix.com>
> ---
> v1->v2: Change commit subject to include driver core (no code change)
> 	https://lore.kernel.org/20251001151508.1684592-1-vincent.liu@nutanix.com

What commit id does this fix?  What devices cause this to happen today
that are seeing this issue?  Should this be backported to older kernels?

thanks,

greg k-h

