Return-Path: <linux-pci+bounces-28327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5998EAC25C2
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 16:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10184A0271
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 14:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CA4295DBF;
	Fri, 23 May 2025 14:59:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F50295DBC
	for <linux-pci@vger.kernel.org>; Fri, 23 May 2025 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748012353; cv=none; b=W21apg+AOfyId4HCxgADGV7lyiWYwbeN3OhPbD6F8MrZjSz/EHt9wjEjJP8wTLMTuWwKmr2PsTOh1OLNwW0bDisa2IKeNmDTSy4Db0FsOWSQC2Ip5I6YbA59uRV0JemTlKEPLJkyQDbAsXzaLkXwXmQiff5vjJTz6XrpESxYDXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748012353; c=relaxed/simple;
	bh=9ulCI84BHvWjNXO5zNCm16GokvVLsdc3huAM9Xccbzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2S89m1WZGOFfop+D7hePnhTht28gu8ophn3Tj3HFLwlIh4wkX6RDzRz8jeO3A3IHQi0UO3f28jAi8AXutiVbHWUc2sJ6TL5lhMZIJHlSKl2mOngxi4Wac5OwjIT0wAhDBX2HlIlruTzd4iC/m0uLbAscORDiq0L8HL0Oy++ixA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 983222009D2D;
	Fri, 23 May 2025 16:59:08 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7D4932473EC; Fri, 23 May 2025 16:59:08 +0200 (CEST)
Date: Fri, 23 May 2025 16:59:08 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: reset_slot() callback not respecting MPS config
Message-ID: <aDCNPFBwHSPe9WLi@wunner.de>
References: <aC9OrPAfpzB_A4K2@ryzen>
 <aDAInK0F0Qh7QTiw@wunner.de>
 <aDAdjie1jGBQ-mKf@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDAdjie1jGBQ-mKf@ryzen>

On Fri, May 23, 2025 at 09:02:38AM +0200, Niklas Cassel wrote:
> I kind of liked the earlier revision of Mani's series where we kicked the
> devices off the bus, that way, we would re-use the exact same code paths
> as when doing the initial enumeration.
> 
> Also, by removing the device, the exact same solution works fine both for
> link-down (since the device might never come back again), and for a sysfs
> initiated reset.

PCI drivers such as NVMe are capable of recovering gracefully from reset.
That's a very important feature for data center use cases.

The PCIe hotplug driver goes to great lengths to avoid de-enumeration
and re-enumeration and instead allow for recovery from reset (see e.g.
the invocation of pci_dpc_recovered() and pciehp_ignore_dpc_link_change()
in pciehp_ist()).

So no, we do not want to remove devices in response to reset if we can
help it.  We generally only de-enumerate and re-enumerate devices on
hotplug or if explicitly told to do so via sysfs "remove" / "rescan"
attributes.

Thanks,

Lukas

