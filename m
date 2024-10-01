Return-Path: <linux-pci+bounces-13678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE1A98BA8A
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 13:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC98B1F23AD1
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 11:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914D2188A08;
	Tue,  1 Oct 2024 11:02:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1271885A4;
	Tue,  1 Oct 2024 11:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727780576; cv=none; b=LyHWiJ6kdhPZVtyJq9gjqIVllh1QH3gRdnGwudfnUkSWubbYW1Dy5NtiXSksIkSUkU2wO9hXw1pG9olfs1R3hjGE5N0tMh7dIN5sB23spwlENadr9BwjZhsuUITizXzsBLFzSk2Y1Lz6deXRxRMZ3xnOfhZTLpFR4Aas6ukaCwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727780576; c=relaxed/simple;
	bh=U8G0GaWCxBo32O5qvT2qm7PwwTvKoSsH0VDCHUaOYMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvvpsYl7c/UgyJNZMw16HLAY6Y3ZQNVw0sOlRpnWSzdGLbfBciU5TVz2gGzBcbhO0o8wGkmmOkGme+EHA6NupUGYumUQw9FvheXKGpGNe1KP3HNry/Pvz5ha0UXz6aDrYiNZh1V+lMnCx25dIwScmHBUV69pacoZiVIbwa1ugxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 35A07100DA1D3;
	Tue,  1 Oct 2024 13:02:46 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 0DE47208266; Tue,  1 Oct 2024 13:02:46 +0200 (CEST)
Date: Tue, 1 Oct 2024 13:02:46 +0200
From: Lukas Wunner <lukas@wunner.de>
To: AceLan Kao <acelan.kao@canonical.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Fix system hang on resume after hot-unplug
 during suspend
Message-ID: <ZvvW1ua2UjwHIOEN@wunner.de>
References: <20240926125909.2362244-1-acelan.kao@canonical.com>
 <ZvVgTGVSco0Kg7H5@wunner.de>
 <CAFv23Q=5KdqDHYxf9PVO=kq=VqP0LwRaHQ-KnY2taDEkZ9Fueg@mail.gmail.com>
 <ZvZ61srt3QAca2AI@wunner.de>
 <Zvf7xYEA32VgLRJ6@wunner.de>
 <CAFv23QkwxmT7qrnbfEpJNN+mnevNAor6Dk7efvYNOdjR9tGyrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFv23QkwxmT7qrnbfEpJNN+mnevNAor6Dk7efvYNOdjR9tGyrw@mail.gmail.com>

On Mon, Sep 30, 2024 at 09:31:53AM +0800, AceLan Kao wrote:
> Lukas Wunner <lukas@wunner.de> 2024 9 28 8:51:
> > -       if (pci_get_dsn(pdev) != ctrl->dsn)
> > +       dsn = pci_get_dsn(pdev);
> > +       if (!PCI_POSSIBLE_ERROR(dsn) &&
> > +           dsn != ctrl->dsn)
> >                 return true;
> 
> In my case, the pciehp_device_replaced() returns true from this final check.
> And these are the values I got
> dsn = 0x00000000, ctrl->dsn = 0x7800AA00
> dsn = 0x00000000, ctrl->dsn = 0x21B7D000

Ah because pci_get_dsn() returns 0 if the device is gone.
Below is a modified patch which returns false in that case.

I've only changed:
-	dsn = pci_get_dsn(pdev);
-	if (!PCI_POSSIBLE_ERROR(dsn) &&
+	if ((dsn = pci_get_dsn(pdev)) &&
+	    !PCI_POSSIBLE_ERROR(dsn) &&


> Did some other test
> TBT HDD -> TBT dock -> laptop
>    suspend
> TBT HDD -> laptop(replace TBT dock with the TBT HDD)
>    resume
> Got the same result as above, looks like it didn't detect the TBT dock
> has been replaced by TBT HDD.
> 
> In the origin call trace, unplug TBT dock or replace it with TBT HDD,
> it returns true by the below check
>         if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) ||
>            reg != (pdev->vendor | (pdev->device << 16)) ||
>            pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) ||
>            reg != (pdev->revision | (pdev->class << 8)))
>                return true;

Hm, that's odd.  Why is that?  Is reg == 0xffffffff in one of those cases?

I guess that could happen if the Thunderbolt tunnels are not yet
established at that point (i.e. in the ->resume_noirq phase),
but normally they should be.  Does this system use ICM-controlled
tunnel management or kernel-native (software-controlled) tunnel
management?

Thanks,

Lukas

