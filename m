Return-Path: <linux-pci+bounces-21153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539D3A307F6
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 11:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 919553A761D
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 10:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF061F2C48;
	Tue, 11 Feb 2025 10:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYpN5m4H"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3536A1F2C47
	for <linux-pci@vger.kernel.org>; Tue, 11 Feb 2025 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739268344; cv=none; b=Bv37giCwMX3YHJ3y5R99nMOn/3XxKHeyzwjU8NrvdiDnRHlsQJH61kx/zMGZaQW9naCEVqCJGUSmbatZRkrYW7ZdXDcIrcMzClHK70fLj6jgXApMF20bkpWnu97ahLldxVQI7JHC5SrBhaR9+m2PYh9f+I0ZhsgEO38CzZW2KyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739268344; c=relaxed/simple;
	bh=PWborL2Xiewf+5rsqFUxTfxhJpEgZRzxt9gaBfriN7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeUa9o7sVRGt/Pi8kTm0mOuDYlPB6rWZA7LOkVRhof9LhAZzw9f1eY84LHDK+qj+7MpZskV/wAeVRk2M9c7hJbNuSEh1HWfgbeb/hN6oYqUY21U/tC2mNSNwnvbzEmWd2aAKi5wasgwlKhLSGQN/ijWkcfVlcgaI/HSHAkGcsVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eYpN5m4H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739268340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tAJtr1HH4lkV0GKTLI4BZ6Gnegvw6aWAt6UMczECWUc=;
	b=eYpN5m4H5FC7dERkGZKn5VxkEvc7UfdoHB4Y1dDs6Eu3mjlBkI2o38fLimPypan3nsFMCM
	jiLf2VVUVSE6FWP7dILRyEA/3HD0RaT7LjI/QW4qsdLBjty0U2ASAQO93CG5SWVFUU6KUf
	xXLOsE9ttUOLicoiOmorvzIOAJ4sjzs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-212-voibPgHBNimGez44YmpFZQ-1; Tue,
 11 Feb 2025 05:05:35 -0500
X-MC-Unique: voibPgHBNimGez44YmpFZQ-1
X-Mimecast-MFC-AGG-ID: voibPgHBNimGez44YmpFZQ
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE3B4195608C;
	Tue, 11 Feb 2025 10:05:33 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.197])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1D5941800365;
	Tue, 11 Feb 2025 10:05:30 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 11 Feb 2025 11:05:07 +0100 (CET)
Date: Tue, 11 Feb 2025 11:05:03 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, mitchell.augustin@canonical.com,
	ilpo.jarvinen@linux.intel.com,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH] PCI: Fix BUILD_BUG_ON usage for old gcc
Message-ID: <20250211100502.GA9174@redhat.com>
References: <20250210210109.3673582-1-alex.williamson@redhat.com>
 <20250210220010.GM32480@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210220010.GM32480@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 02/10, Oleg Nesterov wrote:
>
> On 02/10, Alex Williamson wrote:
> >
> > @@ -345,7 +345,8 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
> >  	unsigned int pos, reg;
> >  	u16 orig_cmd;
> >
> > -	BUILD_BUG_ON(howmany > PCI_STD_NUM_BARS);
> > +	BUILD_BUG_ON(__builtin_constant_p(howmany) &&
> > +		     howmany > PCI_STD_NUM_BARS);
>
> Thanks!
>
> Tested-by: Oleg Nesterov <oleg@redhat.com>

Just in case... I agree with David, statically_true() looks a bit
better and

	BUILD_BUG_ON(statically_true(howmany > PCI_STD_NUM_BARS));

also works for me, so if you decide to update this patch feel free
to keep my Tested-by.

Oleg.


