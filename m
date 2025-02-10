Return-Path: <linux-pci+bounces-21126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFB7A2FC90
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 23:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D45C163828
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 22:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB06264605;
	Mon, 10 Feb 2025 22:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+ZUGNGW"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C776264604
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 22:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739224849; cv=none; b=CyLX6rgRnugenq8gW7mf4nbam2mMwnsuD6RJYv8ch5hRrxh+y+qhBDFpcq53J71OnCAmRDAaUE7nRuO0efMq50ZdyhEgqIRuCybGtT6pxMO0eA3sWrrs0rsZXsqox0dSgZfNO1bpczYleymXHPihHpRdBRZuXnYszx8MTnDPx9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739224849; c=relaxed/simple;
	bh=+WluA0xnKuBmfhcAa0XR5IEiiJO6LVqmX2L4ngoGzwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6MCoeH/aQWCHKFRveRSVgTrvgYQYZYw/OWQpPevv8TGlGCN4x604eKFvMzCKYgEPMBx6KHlCQyZgCtTUaAcyyfgv+xxl0spRZF8q7qz6HoUnFwQ87CQrGhi3AweDRWbiPCufD56xBDalTi6ZOxyDev4+JxDc3ygn/y71LH2XUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+ZUGNGW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739224847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8WNMbBmkgrizNiFSxnkLHSnpFN7pJOa4G7ZThdR/z1w=;
	b=N+ZUGNGWZ9pWEMP0Wmktw5h0Skt5/rzQfRNBrneWnSICX2Clo/b3gdQ2kG6uE4bd8fYv3H
	dxp+U+BmAGmHTxtyxsktiXQEmA8OXk1RD1Pf0qQUkPjLjdL1c1SVG642eGqw4f/TtfI34g
	n+BOHgKqv6tSV1QpaVMNOhrRCrfqGmg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-Qv7tLn07OPi66lCIFPpuwA-1; Mon,
 10 Feb 2025 17:00:43 -0500
X-MC-Unique: Qv7tLn07OPi66lCIFPpuwA-1
X-Mimecast-MFC-AGG-ID: Qv7tLn07OPi66lCIFPpuwA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FD50180036F;
	Mon, 10 Feb 2025 22:00:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.113])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8F48830001AB;
	Mon, 10 Feb 2025 22:00:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 10 Feb 2025 23:00:15 +0100 (CET)
Date: Mon, 10 Feb 2025 23:00:11 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, mitchell.augustin@canonical.com,
	ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH] PCI: Fix BUILD_BUG_ON usage for old gcc
Message-ID: <20250210220010.GM32480@redhat.com>
References: <20250210210109.3673582-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210210109.3673582-1-alex.williamson@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 02/10, Alex Williamson wrote:
>
> As reported in the below link, it seems older versions of gcc cannot
> determine that the howmany variable is known for all callers.  Include
> a test so that newer compilers can still enforce this sanity check and
> older compilers can still work.
>
> Fixes: 4453f360862e ("PCI: Batch BAR sizing operations")
> Link: https://lore.kernel.org/all/20250209154512.GA18688@redhat.com
> Reported-by: Oleg Nesterov <oleg@redhat.com>
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
  ^^^^^^^^^^^^

Well, thanks, but I didn't ;)

> @@ -345,7 +345,8 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
>  	unsigned int pos, reg;
>  	u16 orig_cmd;
>  
> -	BUILD_BUG_ON(howmany > PCI_STD_NUM_BARS);
> +	BUILD_BUG_ON(__builtin_constant_p(howmany) &&
> +		     howmany > PCI_STD_NUM_BARS);

Thanks!

Tested-by: Oleg Nesterov <oleg@redhat.com>


