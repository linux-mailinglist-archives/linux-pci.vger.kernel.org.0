Return-Path: <linux-pci+bounces-15598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 247EF9B63C6
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 14:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC71828243F
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 13:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53451E909F;
	Wed, 30 Oct 2024 13:11:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570FA1E9066;
	Wed, 30 Oct 2024 13:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730293903; cv=none; b=ruFeowXVgW3JX038ACnvawgv/VdRWyXasZGqMfI9jomRvoIxJhxBt9nWsbxlYotJASA8WBvZvzfdVyiYGrZhUWzY7+7cGseNiXXT/lh0CZx0A82lmOaQVwuM2+KFcBPaXshYj/IULbPQglLk2cA1h4tzfs0cqgRdYKJPF3AO14U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730293903; c=relaxed/simple;
	bh=9zKd0vljKIIy9BErrisZc9NjuLygbyvf4fjLbwwHLQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoCz3EEOqSa+X99CvAc7YHp5xTiEeo08vAak4/8ssrKIe7DR9SnUU4haA9kWbLNJ84v/FGAy+TG+98Njh0F+ci0IeFBcQaiLX3Olh2cV6wVFF2PjapqLGmaFTdPQWHkpK8MuQEc2DcDaUyVaeQ4zg5w67Xoych4ARwtpvgA/N7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id CDBDF2800B3FC;
	Wed, 30 Oct 2024 14:11:31 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C6F23C42C5; Wed, 30 Oct 2024 14:11:31 +0100 (CET)
Date: Wed, 30 Oct 2024 14:11:31 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Esther Shimanovich <eshimanovich@chromium.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rajat Jain <rajatja@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] PCI: Detect and trust built-in Thunderbolt chips
Message-ID: <ZyIwg0nNb_eVzRaz@wunner.de>
References: <20240910-trust-tbt-fix-v5-1-7a7a42a5f496@chromium.org>
 <20241030001524.GA1180712@bhelgaas>
 <ZyIUZfFuUdAbVf25@wunner.de>
 <20241030113108.GT275077@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030113108.GT275077@black.fi.intel.com>

On Wed, Oct 30, 2024 at 01:31:08PM +0200, Mika Westerberg wrote:
> On Wed, Oct 30, 2024 at 12:11:33PM +0100, Lukas Wunner wrote:
> > In any case I haven't heard of any Windows on ARM systems being
> > affected by the issue.
> 
> Well they can do whatever they want without us knowing ;-) This problem
> does not happen even in x86 Windows probably because they do something
> similar than this patch.

I meant Linux on "Windows on ARM" machines. :)

This article claims that UEFI+ACPI is used to boot Windows,
but Qualcomm recommends devicetree is used for Linux:

https://www.heise.de/en/news/Snapdragon-X-notebooks-Ditch-Windows-Install-Linux-9781461.html


> > So it boils down to:  Should we compile the quirk in just in case
> > ARM-based ACPI systems with discrete Thunderbolt controllers and
> > problematic ACPI tables show up, or should we constrain it to x86,
> > which is the only known architecture that actually needs it right now.
> > 
> > My recommendation would be the latter because it's easy to move
> > code around in the tree, should other arches become affected,
> > but in the meantime we save memory and compile time on anything
> > not x86.
> 
> IMHO this should be made generic enough that allows device tree based
> systems to take advantage of this right from the get-go. Note also there
> is already "external-facing" device tree property that matches the ACPI
> one defined in Documentation/devicetree/bindings/pci/pci.txt.

The workaround implemented by Esther's patch (only) becomes necessary
because OEMs followed Microsoft's spec blindly and put the property
below the Root Port, instead of the Downstream Port.

Devicetree-based systems are not bound by Microsoft's spec, so do not
*have* to fall into the same trap.

Thanks,

Lukas

