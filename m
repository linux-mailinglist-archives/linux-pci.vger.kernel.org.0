Return-Path: <linux-pci+bounces-21116-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA0EA2F9A2
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 20:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 772F4161C10
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 19:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F1125C6EC;
	Mon, 10 Feb 2025 19:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDYIxp9x"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D958F25C6E2
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 19:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739217455; cv=none; b=YumprCfd2xPPtoGCCXzTrNtysPXyzDtzvGM/4VeGKvq1VcAiXNbwPMBDFpyHkI5V5CHm9j3Z7RFJuhVR+d2k6LITskR0/+lL5lMgYdtkSM79lfS/2Pb5eSrN32YOkgOdezz/lUi9BHBN4SLgumsRJ7jd+LEybdI+nfu9NTOtDlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739217455; c=relaxed/simple;
	bh=Y/cfvNZcyxq6Z1G8Pn9QdNRGfrgu25kDzP3eVplL7eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyUCuzJk00rLPCSOaRDyJ3pbVtZHcLJv3Mh3BFPAIMMB8QCWDJgKprpp47cjfH5tT56RZiDl9bZcACXoWNW6KCXNbz9kiM7xjNHCk9bXW+2QGN02msrAA1fYqwcM2Jn49o2wugVBi+x06lJLgfqFOUk5Mtd228IiXY1W+1A6taI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QDYIxp9x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739217452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QdhG7I/har69g6q90thSTfaor/ZhqDqYV/JUod2UTNM=;
	b=QDYIxp9xqEFT0C9fszlkRaeYfTVhnoB+QZQpu7lQ4X10Tq9xW3qBxlv9xWrzFlKl5ZSmPL
	AzKDeFPjT44sgKyKXTioVpToqWb+52gJFczlynT2Y175Pm37xh9as+LhZcdQQ18Va8a8a7
	Qc/bS1kgU33y4fONQ3XUE2Ir0dr9pWI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-wCCU5uReNfSdrVYQNq3g4A-1; Mon,
 10 Feb 2025 14:57:31 -0500
X-MC-Unique: wCCU5uReNfSdrVYQNq3g4A-1
X-Mimecast-MFC-AGG-ID: wCCU5uReNfSdrVYQNq3g4A
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D42F1956094;
	Mon, 10 Feb 2025 19:57:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.113])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3946B3001D13;
	Mon, 10 Feb 2025 19:57:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 10 Feb 2025 20:57:02 +0100 (CET)
Date: Mon, 10 Feb 2025 20:56:59 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, mitchell.augustin@canonical.com,
	ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v2] PCI: Batch BAR sizing operations
Message-ID: <20250210195658.GK32480@redhat.com>
References: <20250120182202.1878581-1-alex.williamson@redhat.com>
 <20250209154512.GA18688@redhat.com>
 <20250210093641.0be242ae.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210093641.0be242ae.alex.williamson@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 02/10, Alex Williamson wrote:
>
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -345,7 +345,8 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
>  	unsigned int pos, reg;
>  	u16 orig_cmd;
>  
> -	BUILD_BUG_ON(howmany > PCI_STD_NUM_BARS);
> +	if (__builtin_constant_p(howmany))
> +		BUILD_BUG_ON(howmany > PCI_STD_NUM_BARS);

Or just

	BUILD_BUG_ON(__builtin_constant_p(howmany) && howmany > PCI_STD_NUM_BARS);

I dunno... Works for me in any case.

I don't know if this is "right" solution though, but I can't suggest
anything better.

Oleg.


