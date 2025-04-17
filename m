Return-Path: <linux-pci+bounces-26144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D00A92BD1
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 21:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5331B4A3565
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 19:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F401FF1D1;
	Thu, 17 Apr 2025 19:30:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6121BC9F4
	for <linux-pci@vger.kernel.org>; Thu, 17 Apr 2025 19:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744918252; cv=none; b=Ad65FaVS1vchKEqBmG3eZcPhlqSOC3fU4x8ka73O++BS7sr79fmVfPUam+gdIVRvd8PwJp6px7a9lQBgNzjVoiR8jg9fWeQ3OJTeQV3W+7DiYmADrMCxMuMpaXRNxgmRqXeg5xWbwQjmNOJOISyqI/MfGf0pS+gvuvv2oJBmWr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744918252; c=relaxed/simple;
	bh=at3QSj1UEXNVEw4QNe7UQl3ZClCAIWLwgKEKukNd85A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnTnEMrTQ5XapMqdm9hzB/SbEFDRxDEIxLhvt7AXJlE1EzEO7oCmZFvD3lZ37RiXTpEvM+kPPXhJZXJTxCVg5KC/lETDHWV10G3qdQrZpqdKH0v3RfCPfHkoP7hT7MefWsJf+UgdkVAJQDAVHpCAd6OoV6dFOBZMjaHEYa+N7Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 668482C4C3F7;
	Thu, 17 Apr 2025 21:30:33 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9ABC918B42C; Thu, 17 Apr 2025 21:30:40 +0200 (CEST)
Date: Thu, 17 Apr 2025 21:30:40 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: hotplug: Drop superfluous #include directives
Message-ID: <aAFW4Bsgl8JLnjog@wunner.de>
References: <c19e25bf2cefecc14e0822c6a9bb3a7f546258bc.1744640331.git.lukas@wunner.de>
 <20250415203354.GA34031@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415203354.GA34031@bhelgaas>

On Tue, Apr 15, 2025 at 03:33:54PM -0500, Bjorn Helgaas wrote:
> On Mon, Apr 14, 2025 at 04:25:21PM +0200, Lukas Wunner wrote:
> > In February 2003, historic commit
> > 
> >   https://git.kernel.org/tglx/history/c/280c1c9a0ea4
> >   ("[PATCH] PCI Hotplug: Replace pcihpfs with sysfs.")
> > 
> > removed all invocations of __get_free_page() and free_page() from the
> > PCI hotplug core without also removing the #include <linux/pagemap.h>
> > directive.
> > 
> > It removed all invocations of kern_mount(), mntget() and mntput()
> > without also removing the #include <linux/mount.h> directive.
> > 
> > It removed all invocations of lookup_hash()
> > without also removing the #include <linux/namei.h> directive.
> > 
> > It removed all invocations of copy_to_user() and copy_from_user()
> > without also removing the #include <linux/uaccess.h> directive.
> > 
> > These #include directives are still unnecessary today, so drop them.
> > 
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> 
> Applied to pci/hotplug for v6.16, thanks!

A small issue snuck into the commit message while applying:

There's a sentence which ends abruptly:

    It removed all invocations of lookup_hash() without also removing the

The remainder of the sentence should have been:

    #include <linux/namei.h> directive.

While rewrapping the paragraph, the word "#ifdef" ended up at the
beginning of the line and "git commit" interpreted that as a comment
and stripped the line from the commit message.

I think just prepending a blank to the line may stop git from doing that.

Thanks,

Lukas

