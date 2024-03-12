Return-Path: <linux-pci+bounces-4740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06473878F3C
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 08:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F9CFB20ED6
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 07:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8DBB657;
	Tue, 12 Mar 2024 07:50:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D616995B;
	Tue, 12 Mar 2024 07:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710229816; cv=none; b=sm8Np5TJnwFIVPGIpk0mNNgna9jk44jRPzuHJi9ZYGoukLs4MvFjjFNpXxGJGrHl+A5XthpxPqqYJMfq8Tvjtfrf9bvQ7VyaNBKx4rgC9bv2/2l6222CN7GiEBcaxTXChBNrkZYjz7PbIyaHiJ0F6MeXRyKHSNolh6xq5Gm+zHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710229816; c=relaxed/simple;
	bh=h6DM/hM1xlKy3Hc7CpFU3ajXUunOj0LnS5nJ9tulN8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqJqZ156dLXGhlCgoE/SGfaDow6HRjfClaT8saaaFOWqS62S9JXMhSuuHSpTg1bCT0o5722HCHDZIys46Mv5feo13c6RH9FyWnbnceM6NDK1uGTu+L5UKQ7/CW4NZrjxGDrDNAnDRA4XJpJfQFZ4RkP3bO1GlhZLvmi0ewNOjyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 5A642100DA1C9;
	Tue, 12 Mar 2024 08:50:10 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3BA1423A014; Tue, 12 Mar 2024 08:50:10 +0100 (CET)
Date: Tue, 12 Mar 2024 08:50:10 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	dan.j.williams@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com, dave@stgolabs.net, bhelgaas@google.com
Subject: Re: [PATCH 2/3] PCI: Create new reset method to force SBR for CXL
Message-ID: <ZfAJMggDhK3DaO3Q@wunner.de>
References: <20240311204132.62757-1-dave.jiang@intel.com>
 <20240311204132.62757-3-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311204132.62757-3-dave.jiang@intel.com>

On Mon, Mar 11, 2024 at 01:39:54PM -0700, Dave Jiang wrote:
> CXL spec r3.1 8.1.5.2
> By default Secondary Bus Reset (SBR) is masked for CXL ports. Introduce a
> new PCI reset method "cxl_bus_force" to force SBR on CXL ports by setting
> the unmask SBR bit in the CXL DVSEC port control register before performing
> the bus reset and restore the original value of the bit post reset.

Hm, why not have a sysfs attribute (or sysctl variable) to unmask SBR?

That would avoid the need to touch pci code as the sysfs attribute could
be kept local to the cxl subsystem.

Thanks,

Lukas

