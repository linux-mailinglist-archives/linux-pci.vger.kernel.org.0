Return-Path: <linux-pci+bounces-33658-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEA1B1F3D3
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 11:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C543AE557
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 09:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BDC21FF53;
	Sat,  9 Aug 2025 09:43:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1374217578
	for <linux-pci@vger.kernel.org>; Sat,  9 Aug 2025 09:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754732617; cv=none; b=KE6rQ3lrkdySy1Bj2Rc3NHKJ4b7jKWn8YTwgMEM2+Z+6HXGO0PdRt+StBjd4jnXNzdvBFA2QtnainMQ5r9DQjx//yad4GTldIJGvmOQwLudqLYsnWTyC2dalXFAA4iFIcLwjiWAJu6OHJqU6743pvgyUKRxetONQVF3ymR5yyng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754732617; c=relaxed/simple;
	bh=7LOoxV+FPVQ1yIXqHk3twaOKiR/zoULojqq0YafANDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ma7PspTih73vL7mT5BYpoxwtORix6QcdJPZVWIw7KSI153UHTIh6m942BzmLUScYoLKXPJ4PBlovLkXGqv5kRa559tPXZyvO4qSTEKMubdocL0WkHCtsTSCimncZ+PCNLGyjKWlMSPqpkaMW19HToKAKCXpG2Z68/ijY5abhw+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 1957C2C0667D;
	Sat,  9 Aug 2025 11:43:26 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 127FB3E94DF; Sat,  9 Aug 2025 11:43:26 +0200 (CEST)
Date: Sat, 9 Aug 2025 11:43:26 +0200
From: Lukas Wunner <lukas@wunner.de>
To: andreasx0 <andreasx0@protonmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [BUG] PCI: build failure in pci_bus_add_device() due to missing
 pci_dev_allow_binding() declaration (v6.16)
Message-ID: <aJcYPmUm8toqd7Uo@wunner.de>
References: <w_kdHQ9WkOAZaKa2b4PYXiI1fTbeRd0Xi2TQNxCsqJ2hy-Um4039DBYDgmqj46h5D4S8rUFrx9nQU4WhdfTplMsaa5I-vVfNfghCOl4v1OE=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w_kdHQ9WkOAZaKa2b4PYXiI1fTbeRd0Xi2TQNxCsqJ2hy-Um4039DBYDgmqj46h5D4S8rUFrx9nQU4WhdfTplMsaa5I-vVfNfghCOl4v1OE=@protonmail.com>

On Sat, Aug 09, 2025 at 01:22:13AM +0000, andreasx0 wrote:
> When building Linux kernel v6.16 for x86_64, I encountered the following build error:
> 
>  drivers/pci/bus.c: In function 'pci_bus_add_device':
>  drivers/pci/bus.c:373:17: error: implicit declaration of function 'pci_dev_allow_binding' [-Wimplicit-function-declaration]
>   373 |         pci_dev_allow_binding(dev);
>       |         ^~~~~~~~~~~~~~~~~~~~~
>  make[4]: *** [scripts/Makefile.build:287: drivers/pci/bus.o] Error 1
>  make[3]: *** [scripts/Makefile.build:555: drivers/pci] Error 2

pci_dev_allow_binding() was introduced by ce45dc4bb22e ("PCI: Limit
visibility of match_driver flag to PCI core"), which indeed first
appeared in v6.16.

However I don't quite see how you'd get that error message.

pci_dev_allow_binding() is a static inline declared in drivers/pci/pci.h
which is not guarded by any #if or #ifdef (except DRIVERS_PCI_H).

drivers/pci/bus.c #includes "pci.h".  So that all looks fine.

This build error hasn't been seen by 0-day bot or anyone else.
Would you mind uploading your .config somewhere (e.g. to a new
bug on bugzilla.kernel.org or GitHub gist)?

Is this an unmodified v6.16 kernel or are you applying custom
patches on top?  Could the build error be explained by a local
git merge or git rebase gone awry?

Thanks,

Lukas

