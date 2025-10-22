Return-Path: <linux-pci+bounces-38988-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E01A9BFB69D
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 12:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71E71898374
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 10:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D77B281368;
	Wed, 22 Oct 2025 10:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mHgk+ZFv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBCF28031C;
	Wed, 22 Oct 2025 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761129125; cv=none; b=YHFJsPcRmbz4BWyiUWFmdSHibWwy++2YewegwTMkmWUxt+u3qikAT5MCaiQLZeu/EQ1OxLF30wla1YFwl4ug1SFYcTXbbPBY0YtqOMlYQ3p5YYodYMLeXKAdY9grOfr7xKcOxuH/GPkTt42parMkgA/Fv4xv8YSTTO0tSFCJPzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761129125; c=relaxed/simple;
	bh=SM2Ndt5UnN+fZKr9vejhQ5gKAcVwpkMQaAlbB+JdKyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQKsRBP9ryTzttYy03SiwaWvpLAly/O/dgAURJdYB6K23U9BmR6QAInoCxkNvlg3dFyVx0qYHkAOGITDDLg1uZ+N+FD+Gi7qM28IOUePGVYYXDUJkGDdobJ5yFtjwSNxuvtOfnn6TAblOAXYokgR+iDNmouNGlFRl/hOmU4Lar4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mHgk+ZFv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48521C4CEE7;
	Wed, 22 Oct 2025 10:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761129122;
	bh=SM2Ndt5UnN+fZKr9vejhQ5gKAcVwpkMQaAlbB+JdKyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mHgk+ZFvPSLpE8s8aNbPYbS4x3xFJlHz5KB/tvh41VnEhcd9Gb5hVG7vwbO8fcf3e
	 vm5PbEE46AZLYAvidXAnSFCHxJROX9xXxUGgFSgOnTkp3hZsSzw7+8prdkluMfrkwM
	 Ord2n9AJs0DCX3uu3NUj+KTTVSkTC2S3c2EHuxGU=
Date: Wed, 22 Oct 2025 12:32:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vincent Liu <vincent.liu@nutanix.com>
Cc: "dakr@kernel.org" <dakr@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] driver core: Check drivers_autoprobe for all added
 devices
Message-ID: <2025102252-nearest-hangover-5346@gregkh>
References: <20251001151508.1684592-1-vincent.liu@nutanix.com>
 <20251013181459.517736-1-vincent.liu@nutanix.com>
 <2025101452-legacy-gizzard-5bd0@gregkh>
 <8B3127BD-2892-46D5-8EE9-C75D812466DB@nutanix.com>
 <6ECEA944-12A6-43C0-A4F4-F73F73FDDACE@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ECEA944-12A6-43C0-A4F4-F73F73FDDACE@nutanix.com>

On Tue, Oct 21, 2025 at 12:49:21PM +0000, Vincent Liu wrote:
> > On 14 Oct 2025, at 13:10, Vincent Liu <vincent.liu@nutanix.com> wrote:
> > 
> > On 14 Oct 2025, at 06:14, Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> >> What commit id does this fix?
> > 
> > I am not entirely sure if there is a particular commit that causes this issue,
> > the device_attach call was added in pci/bus.c 58d9a38f6fac, and then the
> > device_add was removed in 4f535093cf8f6. At this point I think the
> > drivers_autoprobe stopped working because driver_attach that’s left in
> > pci_bus_add_device does not check for that.
> > 
> > The drivers_autoprobe check in base/bus.c has been there a long time 
> > since b8c5cec23d5c.
> > 
> >> What devices cause this to happen today that are seeing this issue?
> > 
> > I am observing this for hot-plugged PCIe devices and VFs.
> > 
> >> Should this be backported to older kernels?
> > 
> > I suppose not since this was not working for a long time?
> > 
> 
> Are you happy with this reply Greg? Do you want me to update the commit
> message to include some of these commit ids?

Please do.

