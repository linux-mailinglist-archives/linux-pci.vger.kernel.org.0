Return-Path: <linux-pci+bounces-14411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF1299B927
	for <lists+linux-pci@lfdr.de>; Sun, 13 Oct 2024 13:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77EB51F215C3
	for <lists+linux-pci@lfdr.de>; Sun, 13 Oct 2024 11:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E8013A868;
	Sun, 13 Oct 2024 11:09:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82038288B5;
	Sun, 13 Oct 2024 11:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728817749; cv=none; b=j6U+zU0PADyqy2tGskhFOTqVv7orTfTx08hqc5R19yR0Atssy6dUA8Xhe/Rv/b6EapXIGZc/Fm/rLS6HvldiODxhW4v/qyLq0FE5EtbWhA5DzKgq/DAUzfD5jWq1cyBvYReEVN6W/tPGVMPINiKhdmps3vNEM+D8GCUy9smgS+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728817749; c=relaxed/simple;
	bh=D0JN78XTZNGXVBuwL79yT9zfMT1m45fzsiml3DMFsdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqLAlKhO1zclcMhMQ5zwSvMCc+kbM8tRpd5+U87wA2PlEcp+Z9kEjKtINcCd8ioUy6zajuXiBHM3mT4tU6juS4iR4Xqq4cWU5NYYqQZy4iGPZeRjJXnz2YZE9s8luHgachWqiD9DQs5HjrEYa0xZPd3gky4YOdtzP6Ln8iyk+lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 64E072800F9A6;
	Sun, 13 Oct 2024 13:08:57 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4C44830279D; Sun, 13 Oct 2024 13:08:57 +0200 (CEST)
Date: Sun, 13 Oct 2024 13:08:57 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Gregory Price <gourry@gourry.net>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	dan.j.williams@intel.com, bhelgaas@google.com, dave@stgolabs.net,
	dave.jiang@intel.com, vishal.l.verma@intel.com,
	Jonathan.Cameron@huawei.com
Subject: Re: [PATCH] PCI/DOE: Poll DOE Busy bit for up to 1 second in
 pci_doe_send_req
Message-ID: <ZwuqSUxno5t_rSFi@wunner.de>
References: <20241004162828.314-1-gourry@gourry.net>
 <20241010221628.GA580128@bhelgaas>
 <ZwkvMIqC2DjLZJrg@PC2K9PVX.TheFacebook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwkvMIqC2DjLZJrg@PC2K9PVX.TheFacebook.com>

On Fri, Oct 11, 2024 at 09:59:12AM -0400, Gregory Price wrote:
> On Thu, Oct 10, 2024 at 05:16:28PM -0500, Bjorn Helgaas wrote:
> > I provisionally applied this to pci/doe for v6.13 with Lukas and
> > Jonathan's reviewed-by.  
> > 
> > Can we include a sample of any dmesg logging or other errors users
> > would see because of this problem?  I'll update the commit log with
> > any of this information to help users connect an issue with this fix.
[...]
> Do you want an updated patch with the nits fixed?

You need to keep an eye on pci.git when contributing to the
PCI subsystem... ;)

https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git

Your patch is on the "doe" topic branch, with all nits already
addressed by Bjorn.  So you don't need to do anything. :)

Thanks,

Lukas

