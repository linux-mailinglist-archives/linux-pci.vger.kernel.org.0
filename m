Return-Path: <linux-pci+bounces-21117-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54612A2F9B7
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 21:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B8E3A5B4B
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 20:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183E324C67E;
	Mon, 10 Feb 2025 20:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A9XaiGCH"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABE224BCFD
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 20:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739218138; cv=none; b=FmkUqcWAUKMnGPs1oG9Hs3OJPZt85ZNjgo7+M5MFbZs3bfNM209CKyauY9ajGzAvvmnS4RFTiQMZG4pyWSv1KHKvDpa+NuXVxKRuKfksdXbqvW9lqhZSr4doQNNYbnlGUhejNCjZrdhlUyiVGYoeKVw+X4nciSf84WCMcLDfFeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739218138; c=relaxed/simple;
	bh=yBbYMBadCXT0kaevdazzwYvBDUOb8j9NDpwULSbXHAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxQMF044FiEDIcHVCcyHfDHWQUGC69q+PQz/254O8yfmW1R7HXWecvtjlExjwYc7Ls/0vmwxcSpZC+oKYEL6x/0Tn+ByNROGbfXoSmuekvo/QgSMVHkS0R8c7fT7ylo80pU9w6v+1MQJjbBWE0A1YWn3/wBGKHTQOlHlUcaEPh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A9XaiGCH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739218134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=33qRbDaL39Ei5gBDRIf8L9n5D2Vc2pGydYaJ7tW4WTc=;
	b=A9XaiGCHfL2hqye1VVLFN2rRTpFD6/zRR0os330B548Q0adC+MRTYG4m/qXm6bMssRAHd/
	/UaWELnXlrK/OtGnBIopKZ4q3t5UB+kNxtXikDCPBdOogiMejOhOpu7Y58nMGprHGs2ao6
	fZqaB0oBXMqJ7Vg0LysYekFEbHDzn7Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-eO4fuNYsO_Orgdd-QdYTEA-1; Mon,
 10 Feb 2025 15:08:51 -0500
X-MC-Unique: eO4fuNYsO_Orgdd-QdYTEA-1
X-Mimecast-MFC-AGG-ID: eO4fuNYsO_Orgdd-QdYTEA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3ADF718004A7;
	Mon, 10 Feb 2025 20:08:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.113])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A6FC630001AB;
	Mon, 10 Feb 2025 20:08:47 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 10 Feb 2025 21:08:23 +0100 (CET)
Date: Mon, 10 Feb 2025 21:08:19 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, mitchell.augustin@canonical.com,
	ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v2] PCI: Batch BAR sizing operations
Message-ID: <20250210200819.GL32480@redhat.com>
References: <20250120182202.1878581-1-alex.williamson@redhat.com>
 <20250209154512.GA18688@redhat.com>
 <20250210093641.0be242ae.alex.williamson@redhat.com>
 <20250210195658.GK32480@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210195658.GK32480@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 02/10, Oleg Nesterov wrote:
>
> On 02/10, Alex Williamson wrote:
> >
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -345,7 +345,8 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
> >  	unsigned int pos, reg;
> >  	u16 orig_cmd;
> >
> > -	BUILD_BUG_ON(howmany > PCI_STD_NUM_BARS);
> > +	if (__builtin_constant_p(howmany))
> > +		BUILD_BUG_ON(howmany > PCI_STD_NUM_BARS);
>
> Or just
>
> 	BUILD_BUG_ON(__builtin_constant_p(howmany) && howmany > PCI_STD_NUM_BARS);
>
> I dunno... Works for me in any case.
>
> I don't know if this is "right" solution though,

I mean, atm I simply don't know if with the newer compiler
__builtin_constant_p(howmany) will be true in this case.

Oleg.


