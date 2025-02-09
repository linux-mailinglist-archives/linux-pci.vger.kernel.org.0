Return-Path: <linux-pci+bounces-21038-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9F1A2DEE8
	for <lists+linux-pci@lfdr.de>; Sun,  9 Feb 2025 16:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE7C1654A6
	for <lists+linux-pci@lfdr.de>; Sun,  9 Feb 2025 15:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD281DED7B;
	Sun,  9 Feb 2025 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0/yGPf1"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163B91DFE14
	for <linux-pci@vger.kernel.org>; Sun,  9 Feb 2025 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739115950; cv=none; b=A47hsS0BEltF7qh587sPBAT0niK17CXoYYXyWUWmuJsMK+h14Z9QoF+aiI7uh1oYWDo2Ha0dxK1Qqw8aYXf4mKmFlhgfQb/IFg+ZBA88t/UBMVnEk9YjBhcY7otf2cJatqdZSofVPtXooavY9TLAEjdSIEHzJmf8m7pnIYVQ21U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739115950; c=relaxed/simple;
	bh=+qSUzoEzpB71iJSfpsLPnSpsEck/vsbtGG9WuxxwCRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvVDo3l6WDmUeWI9McYzhMFoh7W3tW2zz6sIxEuRrFRDPr9keham6CRgdqmfQmkxz7JGfIiZDVn17nwbZV6M6aCGxIm6XxNvCzuoT2br6kPqWUwVcNePkz9hSZLcsFCTRVrzT7xDvsO0x5Ym+T/fUNnbr7QYk4jk6g1R+y0+eLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M0/yGPf1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739115947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=THLgAH/YOe+Ks6Iu7IGbTNXjNtkhoFKRpRvq3b4R/0s=;
	b=M0/yGPf1f0ifaT1qujGHZ0c8oqRCDXQltOUQde1jAnKwpRTOEyNbEObjHL0BprctZ9eZtv
	4YdFGUDgNuzl4EYn7TUw9kWyIlS73ge9yvyhkrVN5rsOgKq2GN62kc4xhi22Iq/oaF7bRv
	ZsFS8CxQBO7K1DnVrsFrvjDosaV04+s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-TVoSvsflNYCBhZbUOzA0fg-1; Sun,
 09 Feb 2025 10:45:44 -0500
X-MC-Unique: TVoSvsflNYCBhZbUOzA0fg-1
X-Mimecast-MFC-AGG-ID: TVoSvsflNYCBhZbUOzA0fg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10F2518004A7;
	Sun,  9 Feb 2025 15:45:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.8])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6DE2719560A3;
	Sun,  9 Feb 2025 15:45:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  9 Feb 2025 16:45:16 +0100 (CET)
Date: Sun, 9 Feb 2025 16:45:12 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, mitchell.augustin@canonical.com,
	ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v2] PCI: Batch BAR sizing operations
Message-ID: <20250209154512.GA18688@redhat.com>
References: <20250120182202.1878581-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250120182202.1878581-1-alex.williamson@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 01/20, Alex Williamson wrote:
>
>  static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
>  {
> +	u32 rombar, stdbars[PCI_STD_NUM_BARS];
>  	unsigned int pos, reg;
> +	u16 orig_cmd;
> +
> +	BUILD_BUG_ON(howmany > PCI_STD_NUM_BARS);

FYI, I can't build the kernel after this patch:

	$ make drivers/pci/probe.o
	  UPD     include/config/kernel.release
	  UPD     include/generated/utsrelease.h
	  CALL    scripts/checksyscalls.sh
	  DESCEND objtool
	  INSTALL libsubcmd_headers
	  CC      drivers/pci/probe.o
	In file included from <command-line>:0:0:
	drivers/pci/probe.c: In function ‘pci_read_bases’:
	././include/linux/compiler_types.h:542:38: error: call to ‘__compiletime_assert_338’ declared with attribute error: BUILD_BUG_ON failed: howmany > PCI_STD_NUM_BARS
	  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
					      ^
	././include/linux/compiler_types.h:523:4: note: in definition of macro ‘__compiletime_assert’
	    prefix ## suffix();    \
	    ^
	././include/linux/compiler_types.h:542:2: note: in expansion of macro ‘_compiletime_assert’
	  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
	  ^
	./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
	 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
					     ^
	./include/linux/build_bug.h:50:2: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
	  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
	  ^
	drivers/pci/probe.c:348:2: note: in expansion of macro ‘BUILD_BUG_ON’
	  BUILD_BUG_ON(howmany > PCI_STD_NUM_BARS);

Yes, my gcc version 5.3.1 is very old, but according to Documentation/process/changes.rst
it should still be supported, the minimal version is 5.1.

Oleg.


