Return-Path: <linux-pci+bounces-16022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA249BC218
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 01:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153261C2131D
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 00:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6931FC3;
	Tue,  5 Nov 2024 00:43:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42415F9C0
	for <linux-pci@vger.kernel.org>; Tue,  5 Nov 2024 00:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730767396; cv=none; b=A4QDaW2Y6nKRYKdJOQa5FP4vss51Wc/2Ow93gqM3daOkI2lBzWj46c9yxn4EBSpZx2p56PIXWToD0mtWQpJOdpjWaIIpwOLDseoMhUU3xQiQ2Z1i329VhGpDr1RO9KIOFQwNPb2dQT0XZVy/50GEWisuXqPqPVx17OwOI4A4cB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730767396; c=relaxed/simple;
	bh=dbifxv7444fWBeKRuXhK2Z71V3qY7ySXwWfUQ2f4RsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvSZGhvO+5Zv5J+2U62rUWjK+E5qOOzJnDEjEmfN6k+b4pMervGFY+tMxBxLldIkhX1UUUzFOevsNXSUIb+2xVW+SRaSpWG87zak86g34cdoddyGKl4MEloIQ64kgmp5bIhL8Qq1XPBG+NATfLfick6sKawU+zFhJJQ1BvkU9nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c693b68f5so51740815ad.1
        for <linux-pci@vger.kernel.org>; Mon, 04 Nov 2024 16:43:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730767393; x=1731372193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gb7I/i+Bf5A7fkrQrykyEEsCkGmZPrixHzKxfh0HUU4=;
        b=A1cC5/hERkuu9dUBwLAAxODGxDk8lTrybAPCqMOGm6vLW/i7g5rNnQi8MrkjD7E1Jg
         mBh3XeDHl4ZhKmNEb2HZ28er8sXrZ+yzWAaT0Uh8npG67zIXy42B8deBkuxZxTm13K3n
         VMkC6rFFxzMsbiLZO9ChVSf5O1hbOZLwKiNwaX7nVrvpTwmoezTofBvOXIPgr9WO3dUX
         P30QAPHyNuv8Rr4QTLRSbF41BxTBJPsDLlE3tMuGgb4KNcArAOiTd+DEUiyanHSCnWM5
         uP9qI7/4KAU5Bctt6/D9I5UqcR94Wcla0tNGXQ18+bqhJRBi0+7UieQtJMD2TOYjoNMW
         QAOg==
X-Forwarded-Encrypted: i=1; AJvYcCUoLeqer5dUDld5ZU9u0owFvVxXVdnhLH4CJN5One5dV3l9qMQkj4HNGhKyc2KRRkxiWuoFhSChou8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLWO/jYfuSAeLZr30FGT1MMe7pam/wjprxHgDcg1r5u7Ai2tEU
	quqgG/jxLI3ABkSZJ3w1fCYLpM34wWs2F/45zSJAtp2x6v8n+e/v
X-Google-Smtp-Source: AGHT+IHLePeILWiA/IaG/zXA2yOzerF8FcPjvdRiTYMl5x3RpLBULr3xYH5FQnZlrmMCIAfsIgvu+A==
X-Received: by 2002:a17:902:d4c6:b0:20c:d2d9:765c with SMTP id d9443c01a7336-21103acd304mr260954225ad.15.1730767393324;
        Mon, 04 Nov 2024 16:43:13 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21105706979sm67062235ad.73.2024.11.04.16.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 16:43:12 -0800 (PST)
Date: Tue, 5 Nov 2024 09:43:11 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: 2564278112@qq.com, manivannan.sadhasivam@linaro.org, kishon@kernel.org,
	bhelgaas@google.com, cassel@kernel.org, Frank.Li@nxp.com,
	dlemoal@kernel.org, jiangwang@kylinos.cn, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci:endpoint Remove redundant returns
Message-ID: <20241105004311.GB1614659@rocinante>
References: <20241104133500.GD2504924@rocinante>
 <20241104234657.GA1446698@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104234657.GA1446698@bhelgaas>

Hello,

> > [+Cc linux-pci mailing list]
> 
> Where did this patch come from?  I don't see it on the mailing list,
> so there's no signed-off-by chain for it, and the Link in the commit
> doesn't go to the patch posting.

Patch for reference:

  From: Wang Jiang <jiangwang@kylinos.cn>
  
  We get 1 warnings when building kernel withW=1:
  296: FILE: ./drivers/pci/endpoint/functions/pci-epf-test.c:296:
  return;
  
  In fact, void function return statements are not generally useful.
  
  Signed-off-by: Wang Jiang <jiangwang@kylinos.cn>
  ---
   drivers/pci/endpoint/functions/pci-epf-test.c | 2 --
   1 file changed, 2 deletions(-)
  
  diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
  index 7c2ed6eae53a..cfdb38cd8cd7 100644
  --- a/drivers/pci/endpoint/functions/pci-epf-test.c
  +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
  @@ -291,8 +291,6 @@ static void pci_epf_test_clean_dma_chan(struct pci_epf_test *epf_test)
   
   	dma_release_channel(epf_test->dma_chan_rx);
   	epf_test->dma_chan_rx = NULL;
  -
  -	return;
   }
   
   static void pci_epf_test_print_rate(struct pci_epf_test *epf_test,
  -- 
  2.25.1

> Please post all PCI-related patches to linux-pci@vger.kernel.org.

Tentatively dropped.  I will wait for the author to post the patch again,
hopefully including the mailing list now.

Jiang, please resend your patch again adding the mailing list, so we can
pick it up.

The process to follow is outlined here:

  - https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Thank you!

	Krzysztof

