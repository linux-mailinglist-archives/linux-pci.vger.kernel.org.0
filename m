Return-Path: <linux-pci+bounces-38005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 926F9BD724C
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 05:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81A5188A490
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 03:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A5A306B14;
	Tue, 14 Oct 2025 03:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/FxF6Tg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92BB1E9B12
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 03:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411476; cv=none; b=NdRWRREYXNRMlpn9WVtn7bhzFt3/PhkWjZO4ESARSAisC/VO0cwuOIa3wuHeOZY8uZ04cP5HtK7BUWBM4qcGX0MS07ZEKOfvSTisGpejQqkoaOzDykYNX95x5gkHk4pOYlWXI63ImM24qdH31RAPAYgHfQGhYk/DWRaUUxfuq64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411476; c=relaxed/simple;
	bh=AoITs1wqt8aAhVY0I091KuuI/ljkUUxvtJM1zCbONRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIlEDZXU4f3DP70asPmxZDPNb1C3OkKFTnILdpy9oPTS1mt1RSfcpi6lorikBWntycNCqmQpt+FpRxTyJwZiRBQema2Z4Ujt+sOappCdD4kr74TVFW111i2Y/h0JezRNrQaZeeybVvhZAHWE27uwFRXS2DM35PUw27cDKgGMIvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/FxF6Tg; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-267facf9b58so27584535ad.2
        for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 20:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760411473; x=1761016273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6k3KTz7Y9+KW5n+gpTPceuWzpZVn6mG+hVFn/lUavp8=;
        b=Y/FxF6Tgj097QRHL6hhkNXpUozdWZ8ggzU+NztXJeBZIYp1YoZDnOaRthiu3NvUT8d
         RoguM2FxaiPnmxqcl5kSq1zPIoRCI6EZUf5kgkFiLr4Jrqi2uO4Bdazosw2GsU6Iem+i
         A4IMWSnOgCBZ6kKorBgauuK1nJLTLKCxFDK1/sUKZlj0OO3+PSdCvBTVw4nUlb3qYkyU
         3PxNoTAaWUv0EidW/doWyQwVk0WP9VtB71AV2huptlRby7QJ6L+TV0l9wFEoY+IYM8kc
         cXLIfurLIjcEHCqdgrq7b2B6vgMzGeubQidVzGHybzEyViuE3c2n7KkSYVZfqoGWqawd
         0WiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760411473; x=1761016273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6k3KTz7Y9+KW5n+gpTPceuWzpZVn6mG+hVFn/lUavp8=;
        b=S04jABozcT2BsInQZTm5Ms9fLaLCLWCpXiv9GhSs5obnpwSnca4uiAnbi+yeFQ73UC
         k2eU2yZR4mpQWifRYCYITJ0Q9Nyq5v7ZJ5vUycGF1j7YKJHYLs22fFuUkO6AN5cNicPy
         qhYKLPK85JQIQ4e94TkWy1BSajD05K6RVPSNhdKKWg6jdoWpz5S1ECYdcyzTRdTHi1A7
         I1gXp2cg6WbUMKne4NIqYR9+aYQs+0Af23A8kyFwW0R8qAAXcv4m3VuPq3CtfcTb6yHp
         83V6QAR+3EGKGNDq7MbFpYzQp1jNol4Y4xPXoejDdFp5hxfC7ff+Q6dMubqUsupCj7ql
         T7yg==
X-Forwarded-Encrypted: i=1; AJvYcCWyjwNIRd9rVJolTS8OiCYHcxF8+uoQxsuZFh9Y7XnUH7O1tUg5LpEPXGHgzpqYfEeaB+sdePTtpxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5fX02LemfK2qFU3ftvQKzY99D+bW8DSBBL521P4ud8bXnraMC
	xqqClyj1639oV8CXcbFP5by8z1ZXyz0pybcCOgm7uzojthGuCV8T8OlX
X-Gm-Gg: ASbGncsfdOJUiPDwCPs6+FI+ULC7Rx7Ng4txHFec/jQ4NwwpjavdvZwODh+s0ysS8xM
	gnRbztdmyby/s4fqtNEu3whR6eMlFhuAIVIQ8t2mQuGi6vhHAsH//qH8+TOSYuA2D8TTIRQVGDl
	hp1RnOXZJWfHLuXT1hSQwbE8fK4O5SXov8vgr8+xo04E6sxasXZY4W189MnIg2k9C+S4GhJHPla
	hrxuF+xj0jK+ouGx5Dy6Uze/OLvTpVal3aQuiNIAWGTvZkWtUHLBPTrorNx50zkP2uc25d9Ij6Q
	dTLz4mTiNbEjFZTMFlxnsiDtFxCMpYyJHvt3ACtBvSH00ZfrKKu3ApBG2oasJwCW86M41ljtoqO
	iVcASzg83WpTeU7E7edvKKDaemPH1D5jQmCLfmTH+8OHdG2XY79c=
X-Google-Smtp-Source: AGHT+IEAI5crpM0rkwfs84IFpYUj1SAc0WOkcFeG4RmoeP6kp6OgtglVN+kmKOKV/fjestJbTDGaAA==
X-Received: by 2002:a17:903:acb:b0:24b:270e:56cb with SMTP id d9443c01a7336-2902739b362mr290759145ad.27.1760411472917;
        Mon, 13 Oct 2025 20:11:12 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29034f3c700sm149274745ad.103.2025.10.13.20.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 20:11:12 -0700 (PDT)
Date: Tue, 14 Oct 2025 11:10:27 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Kenneth Crudup <kenny@panix.com>, Inochi Amaoto <inochiama@gmail.com>
Cc: tglx@linutronix.de, bhelgaas@google.com, unicorn_wang@outlook.com, 
	linux-pci@vger.kernel.org
Subject: Re: commit 54f45a30c0 ("PCI/MSI: Add startup/shutdown for per device
 domains") causing boot hangs on my laptop
Message-ID: <rs54cbdr5q75fowr5gduk25z66elq7k6chigptjzhi546qs7fe@qxbqi6bliwin>
References: <af5f1790-c3b3-4f43-97d5-759d43e09c7b@panix.com>
 <2hyxqqdootjw5yepbimacuuapfsf26c5mmu5w2jsdmamxvsjdq@gnibocldkuz5>
 <fb1f8015-b76d-4c12-9a92-7026cae41aae@panix.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb1f8015-b76d-4c12-9a92-7026cae41aae@panix.com>

On Mon, Oct 13, 2025 at 06:05:03PM -0700, Kenneth Crudup wrote:
> 
> Tested-By: Kenneth R. Crudup <kenny@panix.com>
> 
> 
> > Hi, can you test the following?
> > 
> > ```
> > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > index 1bd5bf4a6097..b4b62b9ccc45 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -192,6 +192,12 @@ static void vmd_pci_msi_enable(struct irq_data *data)
> >   	data->chip->irq_unmask(data);
> >   }
> > +static unsigned int vmd_pci_msi_startup(struct irq_data *data)
> > +{
> > +	vmd_pci_msi_enable(data);
> > +	return 0;
> > +}
> > +
> >   static void vmd_irq_disable(struct irq_data *data)
> >   {
> >   	struct vmd_irq *vmdirq = data->chip_data;
> > @@ -210,6 +216,11 @@ static void vmd_pci_msi_disable(struct irq_data *data)
> >   	vmd_irq_disable(data->parent_data);
> >   }
> > +static void vmd_pci_msi_shutdown(struct irq_data *data)
> > +{
> > +	vmd_pci_msi_disable(data);
> > +}
> > +
> >   static struct irq_chip vmd_msi_controller = {
> >   	.name			= "VMD-MSI",
> >   	.irq_compose_msi_msg	= vmd_compose_msi_msg,
> > @@ -309,6 +320,8 @@ static bool vmd_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
> >   	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
> >   		return false;
> > +	info->chip->irq_startup		= vmd_pci_msi_startup;
> > +	info->chip->irq_shutdown	= vmd_pci_msi_shutdown;
> >   	info->chip->irq_enable		= vmd_pci_msi_enable;
> >   	info->chip->irq_disable		= vmd_pci_msi_disable;
> >   	return true;
> > ```
> > 
> 
> -- 
> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County
> CA
> 

Great, I have sent a patch here 
https://lore.kernel.org/all/20251014014607.612586-1-inochiama@gmail.com/

Regards,
Inochi

