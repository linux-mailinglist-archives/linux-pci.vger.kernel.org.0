Return-Path: <linux-pci+bounces-33457-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34670B1C262
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 10:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D77EE3BF6E8
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 08:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A155C21A94F;
	Wed,  6 Aug 2025 08:46:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA181E0DE3;
	Wed,  6 Aug 2025 08:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754469963; cv=none; b=VP0xi+kmTSQ3RS59FKNgMkn/dmvysoKPTtVHBC8+golE9dAjH3OrLhYk/8DFlZMIwsqpVeHUiQzwputhkorLf8YW8mz5XsBsWznLe6ceRd1DDcFPy3FCrTl/a1ZN0U5uyXQlsWDuPo/odUVeFiHIGd1+CXiqWiPLCQ0gWvA6QYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754469963; c=relaxed/simple;
	bh=DMKHc/OcPpL/dIcwYvCZvK5qO/kk+G6il6zwvKHzlGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frR2ZUg5zZPchekfm17fFb5MsCD38Zr99w8/pt0JTJN6ZodN6zCBT7cS+o2iygIdcCiy7R0MZPfa2kLiYV7LS2VJfXNqRDRkp+JiMu6HuXj2ze2ww04h4D/yNKh2jd7oybN+HS26Eert/CPkC26d//pEe8TVsaBwWy3eKpmGUUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61592ff5df8so8339388a12.1;
        Wed, 06 Aug 2025 01:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754469960; x=1755074760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGdLgPBfdNd2lcOHu+m8zalmwEjID7ryVJYk/Ek3kTw=;
        b=xEvCw07Go2TjjWfW89sVD2KFL8Ho6rC5uHoTV28JmCFsraXu78JR3zIhef89kMK3rB
         OFTH7aBKv8XEjgbv+u+tEQyXFUWKp6XO7Kw+HS5XkFDytPsBw8as07wDW/xzn3Ud8on3
         0eaZE/erfcBNmVvSRYAzWLXPibSK5Bp65XMRffu6k7PSUNAvL1X7rzq0RWxvb3+75ct7
         U+pXDhs5Ko6OR3S5Frlzq405w6brrw9zo0L4e+rcad6qX5aS+oC0QvcsBV7V9jqIvIEV
         yfa7L4sV4j2yeUDLVUZQG8tOsn+vrAEtv66cfWhjeG90+Hjs1SMirlCCcbY18mgSvT2p
         lljA==
X-Forwarded-Encrypted: i=1; AJvYcCUZVwr3iEMtxuRZ3COM9fD13p7FPUWNOYgFpkzR+YoskufLGouSW8e5IExG/DG2hqatMb+80kOpzkDawqI=@vger.kernel.org, AJvYcCVKKVdZ2UGFPmpCdOhNNZqpsUgKTRY2SEXrlqWkp8PCBvSqP2zwTb+R4lBj1GwheYgpWVcQ0ZIBLsnI@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3sDSEx5++M+b/r4jf1fYLvZ3hWJsG7ChXV4ln42bCGejQ6jvQ
	Y/TWDUmYXNQ+6wCi/Vf+NGOa/eVDg8Ph210VvIQG9Oe37n6aaZ0i8xaM
X-Gm-Gg: ASbGnctOpuXu3TQ/sOf2yxYRxE/0VVh5Z4QSmGUiPqo+rWsezSTy2ccwBcWBkqgIkc2
	pFmD2vlD5iSKcCVoF5btZfaf/QkDCfzkLQ9vj7YhtglnbCQFVDpJxepw/HPaWgFOQL5wBNn5jp1
	S4DaoZ0gB98TTT+Rjppsb0SGguG+VfOObCnwNpdQ/9Y/XkzTXxz1QNXUFRvqr9hRxyf8GGUX7a/
	uuN23sp3++8aQbJ0rY+r3dhXelhhtQsTTSe0iSaJkIWpi/wBsHE9tRVIhhN246qvzmphS+vA2r+
	Z1tX9borIxoOMtimWNPW7yOwx+jAn65OJ/kUCeiIYbPiMIt2ZQCFlrrxuAFIiAHho5TfuN7tPLc
	wapPkY+le+ZvWkpmxZEZryzx5
X-Google-Smtp-Source: AGHT+IEgxGF83pTNvuz25yjpVEb2gIljmSEM8tHNjy6l5+Gv3v5isQ/xzUBDq6Js7w2Ab+lMighSsQ==
X-Received: by 2002:a50:f692:0:b0:612:b150:75f3 with SMTP id 4fb4d7f45d1cf-617960d0d02mr1098790a12.8.1754469959884;
        Wed, 06 Aug 2025 01:45:59 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6175ee53a1esm4253825a12.10.2025.08.06.01.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 01:45:59 -0700 (PDT)
Date: Wed, 6 Aug 2025 01:45:57 -0700
From: Breno Leitao <leitao@debian.org>
To: Ethan Zhao <etzhao1900@gmail.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Jon Pan-Doh <pandoh@google.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] PCI/AER: Check for NULL aer_info before ratelimiting in
 pci_print_aer()
Message-ID: <umpfhbh2eufgryjzngc7kyvjlqf3d6fgzftgeb44yf4bbtizb6@x7iqbksbbcot>
References: <20250804-aer_crash_2-v1-1-fd06562c18a4@debian.org>
 <50f6c23f-1f46-4be1-813a-c11f2db3ec4f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50f6c23f-1f46-4be1-813a-c11f2db3ec4f@gmail.com>

Hello Ethan,

On Wed, Aug 06, 2025 at 09:55:05AM +0800, Ethan Zhao wrote:
> On 8/4/2025 5:17 PM, Breno Leitao wrote:
> > Similarly to pci_dev_aer_stats_incr(), pci_print_aer() may be called
> > when dev->aer_info is NULL. Add a NULL check before proceeding to avoid
> > calling aer_ratelimit() with a NULL aer_info pointer, returning 1, which
> > does not rate limit, given this is fatal.
> > 
> > This prevents a kernel crash triggered by dereferencing a NULL pointer
> > in aer_ratelimit(), ensuring safer handling of PCI devices that lack
> > AER info. This change aligns pci_print_aer() with pci_dev_aer_stats_incr()
> > which already performs this NULL check.
> > 
> The enqueue side has lock to protect the ring, but the dequeue side no lock
> held.
> 
> The kfifo_get in
> static void aer_recover_work_func(struct work_struct *work)
> {
> ...
> while (kfifo_get(&aer_recover_ring, &entry)) {
> ...
> }
> should be replaced by
> kfifo_out_spinlocked()

The design seems not to need the lock on the reader side. There is just
one reader, which is the aer_recover_work. aer_recover_work runs
aer_recover_work_func(). So, if we just have one reader, we do not need
to protect the kfifo by spinlock, right?

In fact, the code documents it in the aer_recover_ring_lock.

	/*
	* Mutual exclusion for writers of aer_recover_ring, reader side don't
	* need lock, because there is only one reader and lock is not needed
	* between reader and writer.
	*/
	static DEFINE_SPINLOCK(aer_recover_ring_lock);

