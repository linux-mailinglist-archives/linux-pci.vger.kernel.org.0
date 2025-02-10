Return-Path: <linux-pci+bounces-21128-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20A2A2FDBC
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 23:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 536313A8285
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 22:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1B225A2BF;
	Mon, 10 Feb 2025 22:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkfJYXDP"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C81D2586DD
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 22:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739227615; cv=none; b=axV6R2tAiM+KJcFyIMzlJXRTDTsfozA/5c/GH3bRMcly1oJXxHRqeEwuClaPEbNqMHCANkv8WsQNNrPwvkXg1tsihOOw+jcc/1+cphvPCqDuOXb/NBOhrsYnC6oMiohYl8z7t7IDvdKohjuCD55j4DifNp06QGRyv+GL0hdQ8Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739227615; c=relaxed/simple;
	bh=zn0b5FXEtro91qXSK9PMPMd8PchrIJqar6gJZ6bLBbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2GRQKFWv0X2yMPoIGJ1OOPCAdANjZuu1lbhMAilGuPmaOHjMeWz2abDPi4tRKzGqO6RtBQSwHVLR4vmHVXX1UNur5xXjOAxF+3CHHMDTo9Hj95u7HKKzxrqOdkZRqWcvNV1UaD1oNlWgDrd3q68z7WTtCmwBXzi8P3INM+w6e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CkfJYXDP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739227612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WObvk3zO4HetFPfsvOiJrCg4fJAx8pPDhesxtWw1PoU=;
	b=CkfJYXDPHiUKDF6aArpvOpPbzgWGxQBOSACZuKd0sC9HNZeIwepiETPTvUq30uwmCQ/JQN
	UWweBwGI8MmDmfSlifHM9dsVP9ToQby1FwExJ3TlSdWMi/flnE2swhBxiubEuYbE0cJsIW
	11CyTtvH5CSFBApHfVg5rNuBki1vPxU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-WkkOY9LuOrqdAcWTci_xIQ-1; Mon,
 10 Feb 2025 17:46:48 -0500
X-MC-Unique: WkkOY9LuOrqdAcWTci_xIQ-1
X-Mimecast-MFC-AGG-ID: WkkOY9LuOrqdAcWTci_xIQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C1491800873;
	Mon, 10 Feb 2025 22:46:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.113])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7316F19560A3;
	Mon, 10 Feb 2025 22:46:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 10 Feb 2025 23:46:19 +0100 (CET)
Date: Mon, 10 Feb 2025 23:46:15 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	mitchell.augustin@canonical.com, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v2] PCI: Batch BAR sizing operations
Message-ID: <20250210224615.GN32480@redhat.com>
References: <20250120182202.1878581-1-alex.williamson@redhat.com>
 <20250209154512.GA18688@redhat.com>
 <20250210093641.0be242ae.alex.williamson@redhat.com>
 <20250210195658.GK32480@redhat.com>
 <20250210200819.GL32480@redhat.com>
 <20250210134848.78a1ab4a.alex.williamson@redhat.com>
 <20250210221107.60d608ba@pumpkin>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210221107.60d608ba@pumpkin>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 02/10, David Laight wrote:
>
> On Mon, 10 Feb 2025 13:48:48 -0700
> Alex Williamson <alex.williamson@redhat.com> wrote:
>
> > On Mon, 10 Feb 2025 21:08:19 +0100
> > Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > > On 02/10, Oleg Nesterov wrote:
> > > >
> > > > On 02/10, Alex Williamson wrote:
> > > > >
> > > > > --- a/drivers/pci/probe.c
> > > > > +++ b/drivers/pci/probe.c
> > > > > @@ -345,7 +345,8 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
>
> You probably need __always_inline to have any chance of a compile-time
> test of howmany.

Can't really comment...

But note that nobody else reported this problem, so I guess the newer
compilers are smart enough? Not that I am sure we can rely on it...

> > > >
> > > > 	BUILD_BUG_ON(__builtin_constant_p(howmany) && howmany > PCI_STD_NUM_BARS);
>
> 	statically_true(howmany > PCI_STD_NUM_BARS)

Indeed.

Oleg.


