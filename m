Return-Path: <linux-pci+bounces-19180-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1913D9FFF6C
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 20:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56EAC1882963
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 19:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4DA1B6D0B;
	Thu,  2 Jan 2025 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A66GKt40"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1421B6CF3
	for <linux-pci@vger.kernel.org>; Thu,  2 Jan 2025 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735846153; cv=none; b=cclVdJnIagKfPLQBTFd+BucJ9eGY/xaWaJkD/v8ou7iSs0QNtux2AGDnFY2oO3fihDpIBMsg1qnLk6KYlxLj/s6TZt5PPmg4igCCYaWc/+Ewh1ENVEAhulJFXoXmnhMZtnxAopSvmP14029dDjaMdKroA5OIxppgdwJb1HEQxgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735846153; c=relaxed/simple;
	bh=GWdEuXg3WUDZDGjGFdNsNR/oBNnu0D17oPDtWlVfFM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/z9pdBl+/3lYrXxS2/3IFsgp+e0d8O/5fs+aafxfAygPQ+0egHsxKe9ku2Tx6ScfeDgJMB2mQDhF4v3CsmGKfL245l3tLdZOrYyWY9Zzgr1Rzw6ya7j5S3N8nE6vPqKQafk4n8KFwGYf5kt933fVbXAaReWLYDD/xLNpWIbhlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A66GKt40; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735846149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PqrnXD3+1RR06iBvi9uXmFy/HWAjf6sbg1PXAd5cQdI=;
	b=A66GKt40aK7VZE+Eu8aorHg+GphnqyJMLrePGlYTeSvaMine1VJvwUF+H/h95nr1r61gT1
	4FB6sQBfo6wGuK3b/BffPohvECyGQIPLkCSTbd6uazP1m1km50xVPLz7dYnXiZY9CwACkc
	8a0x68rxu0uQH/ds04Rh9WJemEfLfhc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-ibhspsPeNZWMdppgc_egRA-1; Thu, 02 Jan 2025 14:29:04 -0500
X-MC-Unique: ibhspsPeNZWMdppgc_egRA-1
X-Mimecast-MFC-AGG-ID: ibhspsPeNZWMdppgc_egRA
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6dcd1e4a051so239937226d6.2
        for <linux-pci@vger.kernel.org>; Thu, 02 Jan 2025 11:29:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735846144; x=1736450944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqrnXD3+1RR06iBvi9uXmFy/HWAjf6sbg1PXAd5cQdI=;
        b=J8VlAbs+CWhPE84P0snW7T9aldkpHSbfIVDyCcKLKTgUxnGM+X5vApS/7jxhgJiKsT
         0Ohbu/UNaf5yTCZ++M6Y/I15Dot77NRh6APWORnEXQzz8CupE1TDhPJ+jrW/r3bw5iEI
         nBPdjL8K79XrcCc4Py2U/ECV44aIO/cf55CGPnpV3kR6Q72g86EvXl6W/iPIuDgbzqx3
         FnOrmr6Qlxvdyw6B6bdkuT+N7jc2zFONp9ODmXeAgm1L32r8fAgxuiaoKpIdCitBrKp1
         6Hb3XZ9JmGrn6utlMNslTjygSrlOmx6Sm0ivzcXv4O5uKmoECV/jZxcxXadrFJubpODx
         YR2w==
X-Forwarded-Encrypted: i=1; AJvYcCUryhXssIQxGEC+ZToiVzS19OV1ZwL8EpXRiedOygt23GfOYbPsHWNMi4Nw77LrpSTt29JcnCtsju0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrGdP1tbnLXg5xw8B6EdVhOI2jShPJihDdGhrCaXSPoGx71RIb
	fsFgZuHSVJGEVOlZLoKtWjcE4uJeNzzjVRRSf4qQsm4h89cBeSZuo7kymCZs/7ZruQ638ltZ9Dx
	ZpsMdEaIlWi1Nw4xvF38UpPwAIsgaYlCzQsQwY1bI1h8BoAZcvCm7WB9zgg==
X-Gm-Gg: ASbGncssQ7iU17/jBv9qxHat57vU/mubdwTDjESDontCUCauttfxCNj4PtvQotCD1M/
	wSq3r+4Mk/OcOy7CTkfm276Q9UaeIxQSkhv7Dec7Azx8GrrjhAXLKNJS9hKXosnTUfg0Bnl1en4
	LiIQZPsncOZIiEH7HiL/7/YmwKTm+UR20JPu4FD8ojyGeRmMdafyaHqrrO4snFMeZI6rk4a6pss
	E/PLfTywRqaxXOjnpQD6MEXCYGiRo7jB2Dqw7vYFbQWF7XHFLJMSpgkyzE4ll+Ih8WfvxWZExKX
	HRUqLSRGblEAA4EkbQ==
X-Received: by 2002:a05:6214:dca:b0:6d8:aa04:9a5d with SMTP id 6a1803df08f44-6dd2330bad3mr754637376d6.4.1735846144011;
        Thu, 02 Jan 2025 11:29:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpdC/2YXkIAOTi4K3SggAQlhXdABeSiWVvsv/qQ0FgTGnzpIL/OI93lXM53tLkNbD4XLXwkg==
X-Received: by 2002:a05:6214:dca:b0:6d8:aa04:9a5d with SMTP id 6a1803df08f44-6dd2330bad3mr754637166d6.4.1735846143772;
        Thu, 02 Jan 2025 11:29:03 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd4194937bsm100205756d6.95.2025.01.02.11.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 11:29:03 -0800 (PST)
Date: Thu, 2 Jan 2025 14:29:01 -0500
From: Peter Xu <peterx@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, precification@posteo.de,
	athul.krishna.kr@protonmail.com, regressions@lists.linux.dev
Subject: Re: [PATCH] vfio/pci: Fallback huge faults for unaligned pfn
Message-ID: <Z3bo_TNnwweOH5cp@x1n>
References: <20250102183416.1841878-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250102183416.1841878-1-alex.williamson@redhat.com>

On Thu, Jan 02, 2025 at 11:32:54AM -0700, Alex Williamson wrote:
> The PFN must also be aligned to the fault order to insert a huge
> pfnmap.  Test the alignment and fallback when unaligned.
> 
> Fixes: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219619
> Reported-by: Athul Krishna <athul.krishna.kr@protonmail.com>
> Reported-by: Precific <precification@posteo.de>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


