Return-Path: <linux-pci+bounces-28042-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FB5ABCB58
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 01:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79B03BBBCD
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 23:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACAE20CCF4;
	Mon, 19 May 2025 23:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QV+069+b"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1729F1DE4C8
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 23:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747696652; cv=none; b=E/r19DC1wfAhPfJMO4iOPGbsWzCOIq8D60JUizW1jDecypt5ofUSIkdPzxxnfL0LYUAcv+yXH7x0z6CPLQxjRBpz1V1KdxCV5FRNOMQFfm8VuK/1rxQar3FrovoxFQN8pbjh/33RPl3QvVF2OQdZ/1MNK9tVGdisRdAvSbrqkow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747696652; c=relaxed/simple;
	bh=55ZYTaT8FhZkUhoSUBYMxFmVPzxp4fF4+mTXu/Jyphw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rnNnccmC8mCYp8vvjlsmVBeXNnf06/zt3pzbsY6182gB3U2UG0ZDRgga0ck4g7v1im4N7xW8KgpwOWj2QKfpP3MBE+gyeO1F5nrawrmXYuLjNqe+aAfHOGJTvgI0ATzhcdPqODXYganPVt/R29eOrFhyE9Tv4UA267c6U2HwdJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QV+069+b; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-742c5f7a70bso2105613b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 16:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747696650; x=1748301450; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DmthD9gOjRMYbFYgwf7f3Pp9m7CO5reBPjPZv+5NJUo=;
        b=QV+069+b3eYszERQfclDdMSC9Sl6Ztu2kZJf56NNRpTxdqUxjWQjrOSZFL3PR5B7Q7
         bV5D6SVVbl/112QkdA2oOCxznq4iFCXqbvzFKtfE4cALfctS8LFh5CQLvyOMJdoW0bpq
         h4SmfPFW9OE9BxDNBZUO8k2ND3CcVNbo6SUl7iAKWPvQsy5jKMM65fH1YGry7iY3/znF
         ct69POPrO8opNixw/d35lMLui56FuEf23+dYGuiaPZJMr/tz9jihhp4nr1Tj7LUi7XZA
         43MDo7z17FHIs28CjpzyIYPV3xRdlZ2A3NiNrkboxUPD150je55Mrrjn0mxWVasCn/Mj
         Os0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747696650; x=1748301450;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DmthD9gOjRMYbFYgwf7f3Pp9m7CO5reBPjPZv+5NJUo=;
        b=wSV+yDks+sd2Asn/qqPGIK5n7dBbvsRBQS59MfuXvcYvVruK5A9O4bkxPB11TXGyUH
         L67MrQwWPlBlaTvxuIGAy47ksfuYJfgxADmSO0U0xLH0yGV+SUf8bbnKqMCNzE8mWTJE
         iM1oPp0SDbYqlbw0JCMC7eVTS00s40WAh8VQdUxSiwjXXzR2bqoHl8KRbf9X6xXCSCm8
         7SmI0LUTB9nGqIph8+4AoACdk7bHnlZoNiF72V+PxOIKgCryM0RWL3amJlpDwQmVUbKE
         F8l/kswccOxUUQbTPcjDsdLdiOIEJBhBRit7hkg9A8Ki4no22ltJGPygv+2KREAqrhNJ
         u7lg==
X-Forwarded-Encrypted: i=1; AJvYcCXBdAdCydAv7hevCg+1bRSXp5WuQ9mxXizhxVMVQjUP5KzMOYtHtNXWJ4eC/W9lCZHnnG40LQOBdHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRD4m5bg999d/bmT6Zy/D2qy2qFHrTcArVn1eMMNr7qeEBEEo/
	wTfrSNeB7cidY9seLl5aWVIoug9AgRk42ixHuhcfjdX21V1omkjpYqIC+XbJ6bI5dhrJLFET12Z
	2uQ==
X-Google-Smtp-Source: AGHT+IGHEcM9TKn9Xc+i00afYHv2TzrmaQimUBUqfrRdNBd15kPNJCmvHKHimXydU6G//VEGl/fNmC3mKA==
X-Received: from pfnj10.prod.google.com ([2002:aa7:83ca:0:b0:730:743a:f2b0])
 (user=wnliu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:391a:b0:740:a879:4f7b
 with SMTP id d2e1a72fcca58-742acd5115amr18271072b3a.18.1747696650122; Mon, 19
 May 2025 16:17:30 -0700 (PDT)
Date: Mon, 19 May 2025 23:17:28 +0000
In-Reply-To: <20250519213603.1257897-12-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250519213603.1257897-12-helgaas@kernel.org>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250519231728.2550572-1-wnliu@google.com>
Subject: [PATCH v6 11/16] PCI/AER: Check log level once and remember it
From: Weinan Liu <wnliu@google.com>
To: helgaas@kernel.org
Cc: Jonathan.Cameron@huawei.com, anilagrawal@meta.com, ben.fuller@oracle.com, 
	bhelgaas@google.com, dave.jiang@intel.com, drewwalton@microsoft.com, 
	ilpo.jarvinen@linux.intel.com, kaihengf@nvidia.com, 
	karolina.stolarek@oracle.com, kbusch@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, lukas@wunner.de, 
	mahesh@linux.ibm.com, martin.petersen@oracle.com, oohall@gmail.com, 
	pandoh@google.com, paulmck@kernel.org, rrichter@amd.com, sargun@meta.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, shiju.jose@huawei.com, 
	terry.bowman@amd.com, tony.luck@intel.com
Content-Type: text/plain; charset="UTF-8"


> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 315bf2bfd570..34af0ea45c0d 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -252,6 +252,7 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
>   else
>   info->severity = AER_NONFATAL;
>
> + info->level = KERN_WARNING;
>  return 1;
> }

I think the print level should be KERN_ERR for uncorrectable errors.


