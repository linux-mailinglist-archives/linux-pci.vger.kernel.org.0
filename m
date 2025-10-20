Return-Path: <linux-pci+bounces-38762-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C8CBF1D3B
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 16:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239EC188695C
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 14:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BCF2EC0A0;
	Mon, 20 Oct 2025 14:24:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746811DDC28;
	Mon, 20 Oct 2025 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760970297; cv=none; b=aEfbx8GDukx9jD/3cEgN9jUt4hfV0Ii7l5qagnBrcikWyHkzNSybdzyUeRcK42buFwWQf9hZFU+3uAIwZN2yuKy8KbDvjV3GR587w4cKj7Lnd0lCyaJEe1H5+q0ed8Xnimy2pi+GVoy7uvRUebCEB9P/XTfKHtjTCKoFVvFxiNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760970297; c=relaxed/simple;
	bh=Y5pWNFXphYmf+c/smwTg27tadPgyii7jSwEHNg0ZXO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsGWRvGID424Ux9hVtUZxhJb4lBv4TlSYygvZOcXQZK+X3HUHyUNR2T/Ydj3+9D58EBd3ggemLLtW2VIl0Rvk04daVs56g1C4w2xkJwGRxw7zqbEdB9f2uYNJVFY3lj/S4kES4OUoVig5IaMHROvxSj6SRLHwZ5mHFfl1ukBMEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 783182C0664D;
	Mon, 20 Oct 2025 16:24:52 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6146D4A12; Mon, 20 Oct 2025 16:24:52 +0200 (CEST)
Date: Mon, 20 Oct 2025 16:24:52 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	kbusch@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
	terry.bowman@amd.com, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v6 3/5] PCI/AER: Report fatal errors of RCiEP and EP if
 link recoverd
Message-ID: <aPZGNP79kJO74W4J@wunner.de>
References: <20251015024159.56414-1-xueshuai@linux.alibaba.com>
 <20251015024159.56414-4-xueshuai@linux.alibaba.com>
 <aPYKe1UKKkR7qrt1@wunner.de>
 <6d7143a3-196f-49f8-8e71-a5abc81ae84b@linux.alibaba.com>
 <aPY--DJnNam9ejpT@wunner.de>
 <43390d36-147f-482c-b31a-d02c2624061f@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43390d36-147f-482c-b31a-d02c2624061f@linux.alibaba.com>

On Mon, Oct 20, 2025 at 10:17:10PM +0800, Shuai Xue wrote:
> void aer_report_frozen_error(struct pci_dev *dev)
> {
>     struct aer_err_info info;
> 
>     if (dev->pci_type != PCI_EXP_TYPE_ENDPOINT &&
>         dev->pci_type != PCI_EXP_TYPE_RC_END)
>         return;
> 
>     aer_info_init(&info);
>     aer_add_error_device(&info, dev);
>     info.severity = AER_FATAL;
>     if (aer_get_device_error_info(&info, 0, true))
>         aer_print_error(&info, 0);
> 
>     /* pci_dev_put() pairs with pci_dev_get() in aer_add_error_device() */
>     pci_dev_put(dev);
> }

Much better.  Again, I think you don't need to rename add_error_device()
and then the code comment even fits on the same line:

	pci_dev_put(dev);  /* pairs with pci_dev_get() in add_error_device() */

> > >    .slot_reset()
> > >      => pci_restore_state()
> > >        => pci_aer_clear_status()
> > 
> > This was added in 2015 by b07461a8e45b.  The commit claims that
> > the errors are stale and can be ignored.  It turns out they cannot.
> > 
> > So maybe pci_restore_state() should print information about the
> > errors before clearing them?
> 
> While that could work, we would lose the error severity information at

Wait, we've got that saved in pci_cap_saved_state, so we could restore
the severity register, report leftover errors, then clear those errors?

Thanks,

Lukas

