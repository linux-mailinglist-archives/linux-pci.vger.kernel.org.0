Return-Path: <linux-pci+bounces-41174-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F05C598C1
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 19:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B6C94F40AB
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 18:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2847311954;
	Thu, 13 Nov 2025 18:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="y8WfZTN6"
X-Original-To: linux-pci@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A39312803;
	Thu, 13 Nov 2025 18:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763058945; cv=none; b=K6olud1zvuYQtkxNWvZe8IZfj0CSQjWFe43NzH02cVMr7ul2J47bDQ/PKGZML/x4QyPHUHjkp+n7KfOSbbwe5yUyslCcTWyN9kofhf/LbmYyADKg1aOUj8oQ8F3k53Rc9rse+3Mw2xxYC57+RgDt/pxrBXCJKd8gGrQdXFrEpfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763058945; c=relaxed/simple;
	bh=CUSQQBYvITqU0HTI2fP/xDXv1rhNqQ36+dINrdy/4sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rtuf6JT9clJ4F+0rbAaN+bdazNmqpO83nbJ5XidAybtz+1KHbsmGnzW546qDUnbOGsDIU5w6MvBpnW/Y43pLoCfX57Twnr48L9Q3cTsbJbZnUwtshfNUz9WTx97zSG/q3MKvsPffttgCu59z9LXbX+eE+8dpVy9AW1eChIqcDpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=y8WfZTN6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6t2p8YbLBHcslktU0UoaLjCR0MumsgT3xwVUYNWTUxA=; b=y8WfZTN6cL6otaUWpXfGU52xBx
	ma4BsYIpHqG6zDl+oXONdln+e99CHmTERVcpqyn3iIEYioR8FkoIKAaMY1CT9q6rgsTLddIYKMRni
	7O/qqMj/ytuAIlcj3b9DZyM7f/+UR5nJOXcIsnHOP6xXCbv1YXQp0W6HCC4QHThfkYEX4W7YXune+
	Vc+chLKOhjfatyvpx/w+qblGKqgBAQfByQUX/ia4vgFq9rIoLn9CWTgIw5B/WgWLoA2s8+r7Nh3xI
	9QqjjavTiaObmkqvttkC0m0AzAmeqRp864xfUT2dwnG9SAa01+ozlylkbq83PYr+lckC+oht+alM/
	ENxiyWXQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43958)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vJcAC-000000005rZ-0epR;
	Thu, 13 Nov 2025 18:35:20 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vJcA5-0000000054u-2qcp;
	Thu, 13 Nov 2025 18:35:13 +0000
Date: Thu, 13 Nov 2025 18:35:13 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	christian.bruel@foss.st.com, krishna.chundru@oss.qualcomm.com,
	qiang.yu@oss.qualcomm.com, shradha.t@samsung.com,
	thippeswamy.havalige@amd.com, inochiama@gmail.com,
	fan.ni@samsung.com, cassel@kernel.org, kishon@kernel.org,
	18255117159@163.com, rongqianfeng@vivo.com, jirislaby@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v5 4/4] PCI: keystone: Add support to build as a loadable
 module
Message-ID: <aRYk4Xj1SNEFYW-J@shell.armlinux.org.uk>
References: <20251029080547.1253757-5-s-vadapalli@ti.com>
 <20251113181355.GA2293401@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113181355.GA2293401@bhelgaas>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Nov 13, 2025 at 12:13:55PM -0600, Bjorn Helgaas wrote:
> >  config PCI_KEYSTONE_HOST
> > -	bool "TI Keystone PCIe controller (host mode)"
> > +	tristate "TI Keystone PCIe controller (host mode)"
> >  	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
> >  	depends on PCI_MSI
> >  	select PCIE_DW_HOST
> > -	select PCI_KEYSTONE
> > +	select PCI_KEYSTONE if ARM
> > +	select PCI_KEYSTONE_TRISTATE if !ARM
> 
> This is kind of a lot of dancing to make keystone built-in on ARM32
> because hook_fault_code() is __init, while making it modular
> everywhere else.
> 
> Is hook_fault_code() __init for some intrinsic reason?  All the
> existing callers are __init, so that's one reason.  But could it be
> made non-__init?

Yes. To discourage use in modules, because there is *no* way to safely
remove a hook.

While one can call hook_fault_code() with a NULL handler, that doesn't
mean that another CPU isn't executing in that function. If that code
gets unmapped while another CPU is executing it (because of a module
being unmapped) then we'll get another fault.

Trying to throw locks at this doesn't help - not without holding locks
over the execution of the called function, which *will* be extremely
detrimental on all fault handling, and probably introduce deadlocks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

