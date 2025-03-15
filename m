Return-Path: <linux-pci+bounces-23824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DD8A62C2C
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 12:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932E016AD26
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 11:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FEE1F8733;
	Sat, 15 Mar 2025 11:57:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F229D1F583C;
	Sat, 15 Mar 2025 11:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742039854; cv=none; b=WPwf/TWnA1kN+pi6sIzf4tXbVWG8kLwOz8BnYo9Z/1Nte+AHpSR5mkKWFHV16VFbAp/oXhnukYyVq0rYbm5zIOqabvqO16hMEpac92zWkSXzFd/3dbvV/mgn2dT98HAGh7ruG9NKN3IFtS92EgO8ofowNwmMLetjNSHuRYyY+yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742039854; c=relaxed/simple;
	bh=CnEyCWSi3pIVVY33cscVOYALlAkRoSkSONlyJJBvaF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDzMgaZ4/K9zm9Kgk60clENdC0o4nIoRb2UQnXn5kuneQ0iYooHmtcUbpL5SVp9+7mTFp0HFS13W08PkibZM9kai7c0qIfbAT6mHnqRZJ+YOWKOj8ExEbBhNoZ/h1dhY9iBbBpdLmwwU9ykrk3EiGqU50oO+E+pdxRVh7M1So+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 1EE7330000085;
	Sat, 15 Mar 2025 12:57:22 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 065F716BB17; Sat, 15 Mar 2025 12:57:22 +0100 (CET)
Date: Sat, 15 Mar 2025 12:57:21 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Guenter Roeck <groeck@juniper.net>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Rajat Jain <rajatxjain@gmail.com>,
	Joel Mathew Thomas <proxy0@tutamail.com>,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 4/4] PCI/hotplug: Don't enabled HPIE in poll mode
Message-ID: <Z9VrITX60AJ3o60V@wunner.de>
References: <20250313142333.5792-1-ilpo.jarvinen@linux.intel.com>
 <20250313142333.5792-5-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313142333.5792-5-ilpo.jarvinen@linux.intel.com>

On Thu, Mar 13, 2025 at 04:23:33PM +0200, Ilpo Järvinen wrote:
> PCIe hotplug can operate in poll mode without interrupt handlers using
> a polling kthread only. The commit eb34da60edee ("PCI: pciehp: Disable
> hotplug interrupt during suspend") failed to consider that and enables
> HPIE (Hot-Plug Interrupt Enable) unconditionally when resuming the
> Port.
> 
> Only set HPIE if non-poll mode is in use. This makes
> pcie_enable_interrupt() match how pcie_enable_notification() already
> handles HPIE.
> 
> Fixes: eb34da60edee ("PCI: pciehp: Disable hotplug interrupt during suspend")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

There's a typo in the subject line (s/enabled/enable/).

This patch does not depend on the preceding patches in the series
and can be applied by itself.

Thanks,

Lukas

