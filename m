Return-Path: <linux-pci+bounces-29861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C32B8ADB0A3
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 14:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E80818854A2
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 12:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE008292B4D;
	Mon, 16 Jun 2025 12:52:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B600D292B26;
	Mon, 16 Jun 2025 12:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750078334; cv=none; b=QVia7qIzCyTugIVOQ+f+ubpVHOVR6uVfoofgrG0I7sGAmCJBhTKFveLTZnKwtBD13ClOO+geGcY+i10ZgL6x190RwkLG7AYvjO9a3Yt+DTo/LMNvVn8gCGMwyDcW7lp9KH8RMTILJsNFKRfSlyRSTLo+bq28H8XMNbu/wv+1lB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750078334; c=relaxed/simple;
	bh=6xuUaOxVjIGGdUPU2zBAW95dgaz27lfobqcLbo33+48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbQQvJIBWfGVb0snrReKu0t42jGtaFyHx+jkgWZjKCoNd6UAxrear0ODggFyDomKiLnu1lM+rmR7cuYAVBYCsG+Dt/+lpLqGPu0LzeDaJLqCmeQa/M95ZIZp6gW77+RJQ0i55LA/lwCC6cuvxiWGvIUmfM+UyLMEsywQvvdiSqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id D10012C06842;
	Mon, 16 Jun 2025 14:52:03 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C953E71D00; Mon, 16 Jun 2025 14:52:03 +0200 (CEST)
Date: Mon, 16 Jun 2025 14:52:03 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: brgl@bgdev.pl, kernel test robot <lkp@intel.com>, bhelgaas@google.com,
	oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jim Quinlan <james.quinlan@broadcom.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v3] PCI/pwrctrl: Move pci_pwrctrl_create_device()
 definition to drivers/pci/pwrctrl/
Message-ID: <aFATcxj0ulo1RKxU@wunner.de>
References: <20250616053209.13045-1-mani@kernel.org>
 <202506162013.go7YyNYL-lkp@intel.com>
 <ji3pexgvdkfho6mnby5jumkeaxdbzom574kbiyfy4dcqumtgz2@h4nmwjvox7nl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ji3pexgvdkfho6mnby5jumkeaxdbzom574kbiyfy4dcqumtgz2@h4nmwjvox7nl>

On Mon, Jun 16, 2025 at 06:07:48PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jun 16, 2025 at 08:21:20PM +0800, kernel test robot wrote:
> >    ld: drivers/pci/probe.o: in function `pci_scan_single_device':
> > >> probe.c:(.text+0x2400): undefined reference to `pci_pwrctrl_create_device'
> 
> Hmm, so we cannot have a built-in driver depend on a module...

Does it work if you export pci_pwrctrl_create_device()?

Thanks,

Lukas

