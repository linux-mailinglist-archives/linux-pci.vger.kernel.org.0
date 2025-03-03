Return-Path: <linux-pci+bounces-22739-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EBAA4BA00
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 09:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0811893448
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 08:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF551EFF9A;
	Mon,  3 Mar 2025 08:54:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14B622611;
	Mon,  3 Mar 2025 08:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740992056; cv=none; b=PgeyRoWLEUZshZjHHcARPhQ6vB7SlIiC6mOOS85bxCQt+Izd1FUv/m7bDy3322/Xp3iCikLeQ4Evn3tLqwFjtELR6+/ZvilP4vl1ZTastVbwCj8ou+r9hFtwDBTEw/FWlBmZ9XDO7axmMQet+f9XNS0ESO6guIqfZ58Ge7XRIkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740992056; c=relaxed/simple;
	bh=hnHH00LWmBKWv6Wtab7kQkUQiZNpaAeLHRDxXshMdX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GG43AspgSeeUVfHG368vKNUYLnK0Uuuc++CGjGqsHw85dek4IEUYYbr0AocCwUSw9XYd+nhVUyTLE60y3/YEikZ7doI3KGkBbTay7/C4ZAWyfh0Xx+Eo/MR3DSKf/r2jf0O8ksbzzfvTH1yrnMlCrIkI612Y5qQNap2gFVzHyVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 942A1100DA1D0;
	Mon,  3 Mar 2025 09:54:06 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6ABB5449B4B; Mon,  3 Mar 2025 09:54:06 +0100 (CET)
Date: Mon, 3 Mar 2025 09:54:06 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Liguang Zhang <zhangliguang@linux.alibaba.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>, rafael@kernel.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PCI/portdrv: Only disable hotplug interrupts early
 when needed.
Message-ID: <Z8VuLl8Os5BrsjrE@wunner.de>
References: <20250303023630.78397-1-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303023630.78397-1-feng.tang@linux.alibaba.com>

On Mon, Mar 03, 2025 at 10:36:30AM +0800, Feng Tang wrote:
> There was problem reported by firmware developers that they received
> two PCIe hotplug commands in very short intervals on an ARM server,
> which doesn't comply with PCIe spec, and broke their state machine and
> work flow. According to PCIe 6.1 spec, section 6.7.3.2, software needs
> to wait at least 1 second for the command-complete event, before
> resending the command or sending a new command.
> 
> In the failure case, the first PCIe hotplug command firmware received
> is from get_port_device_capability(), which sends command to disable
> PCIe hotplug interrupts without waiting for its completion, and the
> second command comes from pcie_enable_notification() of pciehp driver,
> which enables hotplug interrupts again.
> 
> One solution is to add the necessary delay after the first command [1],
> while Lukas proposed an optimization that if the pciehp driver will be
> loaded soon and handle the interrupts, then the hotplug and the wait
> are not needed and can be saved, for every root port.
> 
> So fix it by only disabling the hotplug interrupts when pciehp driver
> is not enabled.
> 
> [1]. https://lore.kernel.org/lkml/20250224034500.23024-1-feng.tang@linux.alibaba.com/t/#u
> 
> Fixes: 2bd50dd800b5 ("PCI: PCIe: Disable PCIe port services during port initialization")
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

