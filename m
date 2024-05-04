Return-Path: <linux-pci+bounces-7075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E0C8BBC9B
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 17:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5261C20FDC
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 15:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA623BBEA;
	Sat,  4 May 2024 15:02:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCE222F00;
	Sat,  4 May 2024 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714834961; cv=none; b=Pw+rPecVMXZiTXNE+opLjDZHkSxcbE0/w28yUyCSDQp+86ta8mckdc+2JlfJ8E+82lg9sD5lKir4wwWsB8CYlUgCx0dDHMXJr/b0mOPcgYgijO3s7Fqk4KnS7sTyKtOSB6n52BXm1/r6JVbNb2t3Fp9NXtfUeC8MbpSkjTPI5NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714834961; c=relaxed/simple;
	bh=XZg0u3kPXV8uWQS8+jwlLEsQrGKyPRpGzYxINexgUf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lg8grW5Nn/mVmVX9eJpV9CxSQDK12F4/TZ2nHLJgWDnBYwKZqD9P8z5/KjrH5tnPTQEP7w6NLrS+gpulVwNDJ76KeA6qjePZEhP+pw3acyRtGuuB/MxYvvF9iQ92MOH6YssD8fk6U0F93emJ/YIBCAQK02DqxFmFWehD7J0Js7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 09DEE3000FF11;
	Sat,  4 May 2024 17:02:35 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D7D7148D184; Sat,  4 May 2024 17:02:34 +0200 (CEST)
Date: Sat, 4 May 2024 17:02:34 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Nam Cao <namcao@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rajesh Shah <rajesh.shah@intel.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] PCI: pciehp: bail out if pci_hp_add_bridge() fails
Message-ID: <ZjZOCj4Cxizsj3iY@wunner.de>
References: <cover.1714762038.git.namcao@linutronix.de>
 <401e4044e05d52e4243ca7faa65d5ec8b19526b8.1714762038.git.namcao@linutronix.de>
 <ZjX3t1NerOlGBhzw@wunner.de>
 <20240504093529.p8pbGxuK@linutronix.de>
 <ZjYFOrGlluGW_GzV@wunner.de>
 <20240504105630.DPSzrgHe@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240504105630.DPSzrgHe@linutronix.de>

On Sat, May 04, 2024 at 12:56:30PM +0200, Nam Cao wrote:
> On Sat, May 04, 2024 at 11:51:54AM +0200, Lukas Wunner wrote:
> > Could you reproduce with pciehp instead of shpchp please?
> 
> Same thing for pciehp below. I think the problem is because without 
> pci_stop_and_remove_bus_device(), no one cleans up the device added in
> pci_scan_slot(). When another device get hot-added, pci_get_slot() wrongly
> thinks another device is already there, so the hot-plug fails.

pciehp powers down the slot because you're returning a negative errno
from pciehp_configure_device().  Please return 0 instead if
pci_hp_add_bridge() fails.

Thanks,

Lukas

