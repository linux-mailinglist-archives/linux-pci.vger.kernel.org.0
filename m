Return-Path: <linux-pci+bounces-7786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFFD8CD6BE
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 17:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4786528148F
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 15:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF5CB658;
	Thu, 23 May 2024 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="YoCSnA2R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830A31170F;
	Thu, 23 May 2024 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716477019; cv=none; b=luC/FCgmM7tuz1lVwAMiwSEvg3hv9dcI1OGTpmtr3VztH+4M0jfOiv/qvhyTRbxoqXzVHZiafjNq4CT87bHkFepRAxDq9NOT7NzDgtjchP94FlF6REXI1vQ2TmRqkFRmJ+gA/86abUFoeA+LBHb00olmH0E1pEylPRXBOosptdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716477019; c=relaxed/simple;
	bh=Gkdr0xJJMLFNvdvcWADbMhaYVTxlrzgLesPt6pnCC4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhI6MnWGH1McuRGi/pW+wL7vfLOzRYQ2XDkPnjG0MqqJO1ANBOgKE16TVLMoocuM8HxjMIrxSfyxdVO8Cmru+mBkffaZaihG4RdTSB3derB/VfegYywjD8wUu8EvmQgrVzzSdP7l3dpnMnr+Uw0hsiDkjDxRSL8MXbUhkBOFyv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=YoCSnA2R; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=VKYtOUQIklTbI09gSSmqwJj42+AhQw4Yicy/NLUXnzs=; b=YoCSnA2RFj/4ROon
	bPfV7469Btft13YOZleJG6i3GOvmXQa5XDHesXVcM2WdXrb4FBCpcJckmofOFaCeMt6MmdtOKaNab
	/2uo2X73uPdbtZdR9PRR82QZo54VsQoNaVV1rRfl3JGz5HsdsFtVPL64HHAfXu4UC5DgV5F5wMius
	7AT9ddsiJk4pgoFcIaWEgLWellbZLUWUxaTXzouQLXzLN7cuW1T44KyRHz+fMb5g2M5Ou/RQRrLSJ
	VRYjafelzWkspFVCdhuzQhKuNUt6Dk04EHkjoHja27Lcs6Fq/7/QB82XlKcow9xSyd8ypHM7fDSq0
	WulPOcA/SOcuwpz/ng==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sAA4z-002FMq-2W;
	Thu, 23 May 2024 15:10:05 +0000
Date: Thu, 23 May 2024 15:10:05 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: bhelgaas@google.com, rafael@kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: PCI: Remove unused struct 'acpi_handle_node'
Message-ID: <Zk9cTVvPoyzM4hYm@gallifrey>
References: <20240509000858.204114-1-linux@treblig.org>
 <20240509115750.000078ad@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240509115750.000078ad@Huawei.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 15:09:50 up 15 days,  2:23,  1 user,  load average: 0.02, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Jonathan Cameron (Jonathan.Cameron@Huawei.com) wrote:
> On Thu,  9 May 2024 01:08:58 +0100
> linux@treblig.org wrote:
> 
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > 'acpi_handle_node' is unused since
> > Commit 63f534b8bad9 ("ACPI: PCI: Rework acpi_get_pci_dev()")
> > Remove it.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> FWIW, indeed unused.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks; any idea who would pick this up?

Dave

> > ---
> >  drivers/acpi/pci_root.c | 5 -----
> >  1 file changed, 5 deletions(-)
> > 
> > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > index 58b89b8d950ed..59e6955e24edb 100644
> > --- a/drivers/acpi/pci_root.c
> > +++ b/drivers/acpi/pci_root.c
> > @@ -293,11 +293,6 @@ struct acpi_pci_root *acpi_pci_find_root(acpi_handle handle)
> >  }
> >  EXPORT_SYMBOL_GPL(acpi_pci_find_root);
> >  
> > -struct acpi_handle_node {
> > -	struct list_head node;
> > -	acpi_handle handle;
> > -};
> > -
> >  /**
> >   * acpi_get_pci_dev - convert ACPI CA handle to struct pci_dev
> >   * @handle: the handle in question
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

