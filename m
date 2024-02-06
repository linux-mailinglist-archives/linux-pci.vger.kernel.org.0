Return-Path: <linux-pci+bounces-3140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B97E84B194
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 10:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB9EE2819BC
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 09:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E8112D761;
	Tue,  6 Feb 2024 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7LPWBde"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C72612D148
	for <linux-pci@vger.kernel.org>; Tue,  6 Feb 2024 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707212924; cv=none; b=oJe4ZituuGOJmlND3kMBef8CxuDpqswarbSMtxAp0hJO1ivjzCu4byhwD6b7eSsCWiOPk7KFldXfQPUI5Y8G1ziG9jAe8+AQEXY71opTPxDYG9KZpz9W3xdXusRm9HxiiArhtiAQCq+Rd+XQaUxr/DFeXXtHrzgicm8d+nXxkNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707212924; c=relaxed/simple;
	bh=ZECXte5D6jxim+3xK4HKfAtIsgXPnPOa+pKdouz7m2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kHc3lMDq5+BkIcOvH4u8Vn6D99iwUhNd1e5Q21A80AhmbTC1t7RcwfcsFszpGp/EKieQY02Rz3Ull6kJZN/pqCjGQMU5sb++tJbKd550JQOQ3JaNQ/bdgiETnTzpN3EUntbfTmb4JLfwCSRN1/rAiNOKrdNtZItiYvLjKdSkZQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a7LPWBde; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707212921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZECXte5D6jxim+3xK4HKfAtIsgXPnPOa+pKdouz7m2A=;
	b=a7LPWBdeloZA9TdkhkxZyMRiiD/aA7JPfqBpfDnQOqiNYb2XXFdaiL5y2/doYsx8JFFlXq
	ddeQDGw540MpHBcqj6L5g5ZkDQKz7VfSsTKraaiw0amWNIVflnQBViJg5Z4vsJd77FFRjA
	SYcrUhvpS7pQK7GsycErpPGAY5WYV7E=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-LiEl-tM7MBKQd-NUDGraSg-1; Tue, 06 Feb 2024 04:48:40 -0500
X-MC-Unique: LiEl-tM7MBKQd-NUDGraSg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7816bea8d28so71323785a.0
        for <linux-pci@vger.kernel.org>; Tue, 06 Feb 2024 01:48:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707212919; x=1707817719;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZECXte5D6jxim+3xK4HKfAtIsgXPnPOa+pKdouz7m2A=;
        b=JbQyMT1hANHDarWf1flzD9B8lBsgFU0KZW2oA2qg2qjvInRnI+a4YQzxCC+1qPhYMQ
         ug2aqrJEiVdIV6pZmIGA5op6jbFUaaE/VWzIj0O0g8iZKuF/9hJkfvPTm16yZNTGNyA8
         7G/5P3xnp91ald0lnG4sYFcQYBskn4eve87/XFAaDjs38eQU45LTQJlmZ2SOySvntXmm
         3HQKEGRrANYsFCg1Y3kPG2ggkr29IiTuebB7g6L+WRpl8Yji+mVGeM6TUTdzDV2DtggK
         0a21+xfLQENjZKB5/Fe0hAk2jlKtOut2RZaS0CGvr6Tqeq0rw7EfvVMdey7SN9nKu+D6
         4HXw==
X-Gm-Message-State: AOJu0YxIoZMZdIegpUndVgHJefeo1O3YLDKpYcFfUOaotHh+v/2vbm6j
	yX1xFAb4+A72qDnsOSfpqxiB6bw9lbym6eEpXllgCIBe7geRBQf1FHR3Z+hoH37GAVc5/HsUvaW
	yJh9Qw1qpuTzPRCkN0PtO2FTtaxHCCsBZW/tcd4CMXanWWzF+KgcgjPgTt8YbKXua3Q==
X-Received: by 2002:a05:620a:a0a:b0:785:440c:88d9 with SMTP id i10-20020a05620a0a0a00b00785440c88d9mr3132315qka.26.1707212919012;
        Tue, 06 Feb 2024 01:48:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVZHwKbOSJItUHx/ikHRtM9wqEPD3H5+QvbQpwtzXtmamlTFpTYFt3g/syo8NgZPxdcW1S0Q==
X-Received: by 2002:a05:620a:a0a:b0:785:440c:88d9 with SMTP id i10-20020a05620a0a0a00b00785440c88d9mr3132299qka.26.1707212918799;
        Tue, 06 Feb 2024 01:48:38 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWrwQH0hQVhe0VPR2hZe1xCBNzOga+tBypyXg9hbQvH1pSJTdI7ZgtdHVcgn6rRQl+DcDxogftvodzYEPMJcaE1n9N7qNBFDS0DzHuY5qac4HvBPl4xY1ZKtO+OG4//zVUqXI6pu9szxT6PbFd+Mg3/Q9NK+yt1QHl673JhfVjN68a+gsIW7JBv8B72s99yHahQdNhMJQCacc10tltod0G851RTWM9eydTsNB65V+244gDRPrxEs38kkuQhc6VsRrfWU8+x+p2KzxN+bFCXjenbh5UvaUgCP/k6wcRaVPZrJmqidM9WzpAXS3w4drJCjsCrAcyPeFlYA3KX3DIPbbrQYBfaanGCJ0r+tQvk66smv+0XgnTtph+0swz1geuaMIoW0VbyW6unIY58owxDU/xoismXsKre7CN8N+hBbz5NFQwr1kx4d9KCg+tBBCw9KWPXRf+Msue1u9Zrurx3kdKYb5j5P+NtCZ28MKScxPbx7tshK/gRorlyHgmpvKz39Q2Wr9OKV7QbVqKcQsTDAwFBNc6/VzBZYuROo9rQkomBdVIQMrxdgleexKu8XRwurJTaACHsWiMlbACtt6c7Aqv5VstSx/I8wnE6bQ==
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id vr11-20020a05620a55ab00b007815c25b32bsm764188qkn.35.2024.02.06.01.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 01:48:38 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Onkarnarth <onkarnath.1@samsung.com>, rafael@kernel.org,
 lenb@kernel.org, bhelgaas@google.com, viresh.kumar@linaro.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
 r.thapliyal@samsung.com, maninder1.s@samsung.com, Onkarnath
 <onkarnath.1@samsung.com>
Subject: Re: [PATCH 2/2] kernel: sched: print errors with %pe for better
 readability of logs
In-Reply-To: <20240206051120.4173475-2-onkarnath.1@samsung.com>
References: <20240206051120.4173475-1-onkarnath.1@samsung.com>
 <CGME20240206051402epcas5p2ae3737fc0d71ba1d7a7f8bee90438ff2@epcas5p2.samsung.com>
 <20240206051120.4173475-2-onkarnath.1@samsung.com>
Date: Tue, 06 Feb 2024 10:48:33 +0100
Message-ID: <xhsmhh6ilhqj2.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 06/02/24 10:41, Onkarnarth wrote:
> From: Onkarnath <onkarnath.1@samsung.com>
>
> instead of printing errros as a number(%ld), it's better to print in string
> format for better readability of logs.
>
> Signed-off-by: Onkarnath <onkarnath.1@samsung.com>

I quick ripgrep tells me this is the only culprit in sched, so:

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


