Return-Path: <linux-pci+bounces-33293-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77B9B18293
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 15:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA796587639
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 13:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9521C3F0C;
	Fri,  1 Aug 2025 13:35:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3373820F098;
	Fri,  1 Aug 2025 13:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754055326; cv=none; b=HGLgKmcMTIwuO35mx8TNJ3/vYUMJynqFS9vaUjDVQkrrqdgaBSPq6EyMNLG10yCU39EuPORo/8GCo41NtxZ/mwctZW3iFKCYbNLetfmcYSXTh45S7/DnkEM12oqqZ/dpxQxSZl6Po/kS5fKbBQ08uChZRzLjg7E5quiB1O8AAWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754055326; c=relaxed/simple;
	bh=6/ffmCQryBxPGzuCd61BaL33a2nWIzzMpE5fkx4W1Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjVe9b8+5eSoTKBdeMfJYnZzNi2nD43Lc9nXPmJ13fogeJbUz/IYxm98R8Ol7qrXqN6NmL4CCHunG/fbENtHPST10RBH99rHnQpW1O5CSW2j2hPN+BErtSgpSR25C7EzwJ8fmXW10OSmnS7kfzEAaFuFaQcH3Xhf01Mzoux4Z2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61589705b08so4377456a12.0;
        Fri, 01 Aug 2025 06:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754055323; x=1754660123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkJqOZY9gQx1B/fUNojYy6xv/Z20wG9/a8d364iwDag=;
        b=JjEek48lm/UydHd7DZVlF2F/2W6UQFpjYDdIw+j1UDj9RRWxfaqDorr43wEv9RUKUu
         rR5rJ0IcMAr0fe54VE/EPUhquqqewouvPHUN4pRt9dIl07tzSPFdNitc9bkn4oKQLGr8
         nOo/xqnKN5HWG5ekvmpGA7aZClzlY9IgwiWCGqtvit0b7yzhkbUe7W9WjpmxueZYJ5Bt
         0O6XNK/xOmpFmPmZ2hfJlrTmLTZKc9R8fuAMXOPa7S9zXQYBdskC4zREYJs+1Bg2skZn
         PjvQeXlb8PvJErTLY0LUPz5o3KHFQcu6UUzWWZF7CXBZ9W3WPScT8GDEm+jbZUvI9VhE
         cfiA==
X-Forwarded-Encrypted: i=1; AJvYcCVaAZX64afFlLviRU6FYaUi1GgjDAyh62O6DrZj2gIQTWHwbOk5DYDAp/B7deg4QlHXT0wuQxBSoZAL+YM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYSG1au6SgG4qghhESFWFsq7Bhdy1LK9hGdNsVf9itQv3jyTZa
	BLL5bqHwczwlXx8wxsrJByDCWcbrNLJoAq2rD0w4nwmb1tj6g6BwY1Hq
X-Gm-Gg: ASbGncu1KDOAvb+FzByeKvDDnj3nWbfabZsT0Fl/GEq0e+uwN5dBtWZa7klTCQ5j3L/
	GMjLMVeNI6irEIw0reK232P2Hdv0jzpge+66sQGXRojt6gNfTNpWdJFFYHKpuw/inkfM/1hI+bO
	xr8DznJMmv1vKldIr36R1lXEmYxHL/tYyJ0pB+4auN2S/LblDBP4ETL8zGqPdbt6yLnrzvaGjXt
	MDqbSnK95p3gY7NyfK1euS5ha1Y6VC4rPvK+A1KAwtGwx1HRcFfDgHDAFXPOA+jo6RRDh30uGfI
	IkeqhSKxDqErl0JLgVWpf69WmT4NYlT6J+kO0G8+xABKvYPaGEEBEl2UhNaHdZXs7V1MkKE2IQd
	Z6uAEkMs21OiVsds2YQ32H0Q=
X-Google-Smtp-Source: AGHT+IE6TimUKcL9EkqugmOrusVC7tsv5kIHhX4xmX8/o+AhqXrIgAFgHc7pfMLdutul6lrRmnEiPw==
X-Received: by 2002:a17:906:f595:b0:ae6:f564:18b5 with SMTP id a640c23a62f3a-af8fd728df1mr1397521766b.19.1754055323189;
        Fri, 01 Aug 2025 06:35:23 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c10asm290988466b.116.2025.08.01.06.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 06:35:22 -0700 (PDT)
Date: Fri, 1 Aug 2025 06:35:19 -0700
From: Breno Leitao <leitao@debian.org>
To: Bjorn Helgaas <helgaas@kernel.org>, pandoh@google.com
Cc: linux-pci@vger.kernel.org, 
	Karolina Stolarek <karolina.stolarek@oracle.com>, Weinan Liu <wnliu@google.com>, 
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller <ben.fuller@oracle.com>, 
	Drew Walton <drewwalton@microsoft.com>, Anil Agrawal <anilagrawal@meta.com>, 
	Tony Luck <tony.luck@intel.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Sargun Dhillon <sargun@meta.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Kai-Heng Feng <kaihengf@nvidia.com>, 
	Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>, 
	Terry Bowman <terry.bowman@amd.com>, Shiju Jose <shiju.jose@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Bjorn Helgaas <bhelgaas@google.com>, kernel-team@meta.com, gustavold@gmail.com
Subject: Re: [PATCH v8 18/20] PCI/AER: Ratelimit correctable and non-fatal
 error logging
Message-ID: <f5tby75ifujq2ka3ku76ezuzar4i7ok7a7etygygdpt2k6n4ar@wful3braajua>
References: <20250522232339.1525671-1-helgaas@kernel.org>
 <20250522232339.1525671-19-helgaas@kernel.org>
 <buduna6darbvwfg3aogl5kimyxkggu3n4romnmq6sozut6axeu@clnx7sfsy457>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <buduna6darbvwfg3aogl5kimyxkggu3n4romnmq6sozut6axeu@clnx7sfsy457>

On Fri, Aug 01, 2025 at 06:16:29AM -0700, Breno Leitao wrote:
> Hello Jon, Bjorn,
> 
> On Thu, May 22, 2025 at 06:21:24PM -0500, Bjorn Helgaas wrote:
> > @@ -790,6 +818,9 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
> >  	trace_aer_event(pci_name(dev), (status & ~mask),
> >  			aer_severity, tlp_header_valid, &aer->header_log);
> >  
> > +	if (!aer_ratelimit(dev, info.severity))
> > +		return;
> 
> I am seeing a kernel NULL pointer in the aer_ratelimit(), where
> dev->aer_info is NULL. This is happening on linus final 6.16 commit id.

Upon closer examination of the code, it appears we can replicate the
functionality of `pci_dev_aer_stats_incr()`, which is similarly invoked
within this code path.

commit 1b4ef90e8397eaf2bc4d0f8a2127d2d75c7ff5e0
Author: Breno Leitao <leitao@debian.org>
Date:   Fri Aug 1 06:32:26 2025 -0700

    PCI/AER: Check for NULL aer_info before ratelimiting in pci_print_aer()
    
    Similarly to pci_dev_aer_stats_incr(), pci_print_aer() may be called
    when dev->aer_info is NULL. Add a NULL check before proceeding to avoid
    calling aer_ratelimit() with a NULL aer_info pointer, returning 1, which
    does not rate limit, given this is fatal.
    
    This prevents a kernel crash triggered by dereferencing a NULL pointer
    in aer_ratelimit(), ensuring safer handling of PCI devices that lack
    AER info. This change aligns pci_print_aer() with pci_dev_aer_stats_incr()
    which already performs this NULL check.
    
    Signed-off-by: Breno Leitao <leitao@debian.org>
    Fixes: a57f2bfb4a5863 ("PCI/AER: Ratelimit correctable and non-fatal
    error logging")

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 70ac661883672..b5f96fde4dcda 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -786,6 +786,9 @@ static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
 
 static int aer_ratelimit(struct pci_dev *dev, unsigned int severity)
 {
+	if (!dev->aer_info)
+		return 1;
+
 	switch (severity) {
 	case AER_NONFATAL:
 		return __ratelimit(&dev->aer_info->nonfatal_ratelimit);

