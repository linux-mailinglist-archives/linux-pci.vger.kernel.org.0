Return-Path: <linux-pci+bounces-19653-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB935A0B414
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 11:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7FA218880E1
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 10:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459541FDA7B;
	Mon, 13 Jan 2025 10:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="RF5Vqlhb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBA81FDA77
	for <linux-pci@vger.kernel.org>; Mon, 13 Jan 2025 10:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736762852; cv=none; b=oWAy5/CWrf+rQ8QeAJRQHlZRo14mjCKLN8ssAkYs+88YcZT4I6h8LNIZH9ow6EvPPrM6koSoxOh5i/eYsfOoyXdPVSJkOuWnbGZjt+1T3NRWHqpASJOrGjKok0KRsGqt8LeKCxgUdLH3Qhb/Ssbpt3UE9smnJkpf2j+QTD5m2n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736762852; c=relaxed/simple;
	bh=uVlzrz3E6vH4q34gF/dYh6m4EUQgd1t+Iyw8+OhmVRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EK7aqtP7hYWZfssLY0Mj6kn2dSneysB/+yrMlT5gV+LlA/p1F2rc2oMYHrew0ZjQQeqtW0aBxIl1LS4eWar7opsThx99TXDYQPTCQqsauNmLhwpZ6ZVIhenMjiFhf1iFhYYsqLHfruPxEH+b7fR5Z0kQnGRRjfOmeUCgWv3ks6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=RF5Vqlhb; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d90a5581fcso6872313a12.1
        for <linux-pci@vger.kernel.org>; Mon, 13 Jan 2025 02:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1736762849; x=1737367649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GQ8hBilHaiJrXdn1x4pZcUJFv7XAxAtU+AZUJTBvXks=;
        b=RF5VqlhbGNzoSm5Z2lDK2QOo3n49FyuHfnORYXC8b/RToi+ZtICPHZJF7b2s+UKLrk
         4nw8I46Jwb9TaB04ph4H7weZ8MZw2e1vbyaw/Nf6Qqgjprap3Ce+FqVrSL18tVBFEKqq
         3TiA4SqcbRKQONCMJGGy0kwTDe/pEg73sc57M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736762849; x=1737367649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQ8hBilHaiJrXdn1x4pZcUJFv7XAxAtU+AZUJTBvXks=;
        b=toobnd+cfjODUOiopr4meZCmBZ3JsT0cgiaNAqqi8cHuetG2jeL7Esnb9iE0Tr3RfW
         n7Q0uimgDUerMnApPPsfmlgx989EnmLsKlBWINWSl/yy960q4S16RLYPE10dDDuj5f+m
         JTKx73Ddr/L6Dh1dv6kEnehpvWNV/MZ8LHr7mN9JZEb9L1wr66LDvKD5hYysSHVUYR9h
         bH2Y3eiYdvcxwjTxXd+exvEANQQHBmmNahpgflAi5AmGZvF/yUsQ4/VIGnLzrCi0nseU
         zL+LJRN9mRm0aC1Vr1nJuGMDaLTZwKVBr8Ai0eVxJxa71lBNXKC28eJgwm/p3lrDW6Rw
         R7ig==
X-Forwarded-Encrypted: i=1; AJvYcCWgUUZG3rNqlikHEMXuQFEbB9+deU9drshLl6W1QbisTsPeqCsnI3BsVoaJKXADANAAP2j/N8R4ykA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo4nKzpzCVS99B6cVzLITCdinhyZrdMVDoa0KaXD2FRHqucbs6
	YFc4HzVFH97f22nXthD+YKO/R91gx+p41LlTP70kZZtFs+oBwcryo3GLX0KNf1Y=
X-Gm-Gg: ASbGnctgTed7CGLhXCtJLafRQol2PRvHT1pulDV2/F70XMLrOWUv7/AYOTDNBdQSZSe
	9X3H84yJYH+t32fPZ2UKc2hD8Ur9xbk3ZMgyA2SCsWnjmfofIVBZUN92/60dWY5gy5rWdaZ7vxJ
	YhRBs9IIUVOjbIfvicDTf8I/wYv8N4ZvdfSKXAxyRJKtcuAFTvYWNtRWPui2zsY8LEPjH0hvqqK
	PewZmLz1kQlFVyCtyj7sv+7Pj8ooC5nwPAz6Gr4GdWFhuXQNffGVRjX86fIYg==
X-Google-Smtp-Source: AGHT+IG0+0hZDzdp4js5X9Qv1pwIacDTz8sB7g6BrtwD/4COxyJ2JYTA+74n/qblZAnNxdkdxaGgnw==
X-Received: by 2002:a05:6402:50d0:b0:5d6:37e9:8a93 with SMTP id 4fb4d7f45d1cf-5d972dfbbcdmr14241323a12.2.1736762848818;
        Mon, 13 Jan 2025 02:07:28 -0800 (PST)
Received: from localhost ([84.78.159.3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99008c2ccsm4765038a12.18.2025.01.13.02.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 02:07:28 -0800 (PST)
Date: Mon, 13 Jan 2025 11:07:27 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Jonathan Derrick <jonathan.derrick@linux.dev>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/3] vmd: disable MSI remapping bypass under Xen
Message-ID: <Z4Tl33MHEhgrHg1A@macbook.local>
References: <20250110222525.GA318386@bhelgaas>
 <bcb30b80-0902-4561-94f9-a6e451702138@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bcb30b80-0902-4561-94f9-a6e451702138@linux.dev>

On Fri, Jan 10, 2025 at 10:02:00PM -0700, Jonathan Derrick wrote:
> Hi Bjorn,
> 
> On 1/10/25 3:25 PM, Bjorn Helgaas wrote:
> > Match historical subject line style for prefix and capitalization:
> > 
> >    PCI: vmd: Set devices to D0 before enabling PM L1 Substates
> >    PCI: vmd: Add DID 8086:B06F and 8086:B60B for Intel client SKUs
> >    PCI: vmd: Fix indentation issue in vmd_shutdown()
> > 
> > On Fri, Jan 10, 2025 at 03:01:49PM +0100, Roger Pau Monne wrote:
> > > MSI remapping bypass (directly configuring MSI entries for devices on the VMD
> > > bus) won't work under Xen, as Xen is not aware of devices in such bus, and
> > > hence cannot configure the entries using the pIRQ interface in the PV case, and
> > > in the PVH case traps won't be setup for MSI entries for such devices.
> > > 
> > > Until Xen is aware of devices in the VMD bus prevent the
> > > VMD_FEAT_CAN_BYPASS_MSI_REMAP capability from being used when running as any
> > > kind of Xen guest.
> > 
> > Wrap to fit in 75 columns.
> > 
> > Can you include a hint about *why* Xen is not aware of devices below
> > VMD?  That will help to know whether it's a permanent unfixable
> > situation or something that could be done eventually.
> > 
> I wasn't aware of the Xen issue with VMD but if I had to guess it's probably
> due to the special handling of the downstream device into the dmar table.

Nothing to do with DMAR or IOMMUs, it's just that on a Xen system it
must be Xen the one that configures the MSI entries, and that requires
Xen being aware of the VMD devices and it's MSI or MSI-X
capabilities.

None of this is currently done, as Xen has no visibility at all of
devices behind a VMD bridge because is doesn't even know about VMD
bridges, neither about the exposed ECAM-like region on those
devices.

Thanks, Roger.

