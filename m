Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C44E16BD36
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2020 10:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbgBYJZ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Feb 2020 04:25:29 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35894 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729891AbgBYJZ3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Feb 2020 04:25:29 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so2348606wma.1
        for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2020 01:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xXjKrsLdZZ8wwVwaLKEsCAigMvn6xhJRvLjeY9bym8I=;
        b=xSQI/AECo2FF/n1rzar450UsJu6LS++K752YYamCvDgC3gmDDtm//+VyDKm1Kbo2U6
         UGZi3S+eGAsV0JhiWc2Y+ce9bAn+BhCUIiuI6B59vwHIUTq6SUXNmlTzd15+Ahi5vRFG
         ukAPDmTylaGIN6SKk9F1PWSiE0RSVvcWjauHpIV3567yMuNz7dwqRHqE/6rGd5/HRMTP
         eH8jduDDQ5OHpK9lVCEJlTuHYN+7fQfK4nUzE+8LOZ/Mm/LwrJnTJ2SDMtvUVs3fepv6
         tBSVxhhsDR+XbgoksqEMbEYIIMKi+cx4SZ96EM24GLhZV/KdTnpP6eY2JcEYDfuCgCzQ
         cgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xXjKrsLdZZ8wwVwaLKEsCAigMvn6xhJRvLjeY9bym8I=;
        b=SvR67FtNF5LqiSP1CsGJYL4REVne5MG4brW3qFHZUKp/4o9BiYAOc39ehYFCHbMXa0
         i8nUYplCinmDqjFsbXLh2vmwTu7posel/JzRg7Z+bm3EQ/fFGesfLojtpFqS6s5lvvtJ
         nwnGOKwRlWquaq9YMzSty+uLRYCOfl35yvwgVN5F4Lamx0Oj0i5xZpQTK9Z/xdimaWr8
         BVnS4RjMV/mw5AnRcyzNsbE3SpTgcBxJW8KCDQqWihxlxTrKRNNyK1ugaHydkcnDJQ+v
         D4jf6qc77mEdP1MfYfDe+lQgHM4O2T2its5pQxEB3oeFOCkk808yAnuUdsqJJVquV+Bo
         ZK1A==
X-Gm-Message-State: APjAAAV/WxAlCRhXguxwvPW/L/hbEcUtUaplQ8QuKP33gi/8/rrXtoKH
        g+8fZ3CUbgUoiGgsphkwxnU43Q==
X-Google-Smtp-Source: APXvYqyRPbcxq+DpGxqy4QJ4Y+9sIc/9udtBlHtjdqBZpekzFx+Ms4VTHLdlkurRNx5P5V2Nn5l0Xg==
X-Received: by 2002:a7b:c204:: with SMTP id x4mr4229923wmi.20.1582622727153;
        Tue, 25 Feb 2020 01:25:27 -0800 (PST)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id x21sm3115712wmi.30.2020.02.25.01.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 01:25:26 -0800 (PST)
Date:   Tue, 25 Feb 2020 10:25:19 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Xu Zaibo <xuzaibo@huawei.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, mark.rutland@arm.com, kevin.tian@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        catalin.marinas@arm.com, robin.murphy@arm.com, robh+dt@kernel.org,
        zhangfei.gao@linaro.org, will@kernel.org, christian.koenig@amd.com
Subject: Re: [PATCH v4 03/26] iommu: Add a page fault handler
Message-ID: <20200225092519.GC375953@myrica>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-4-jean-philippe@linaro.org>
 <cb8b5a85-7f1a-8eb7-85bd-db2f553f066d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb8b5a85-7f1a-8eb7-85bd-db2f553f066d@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Zaibo,

On Tue, Feb 25, 2020 at 11:30:05AM +0800, Xu Zaibo wrote:
> > +struct iopf_queue *
> > +iopf_queue_alloc(const char *name, iopf_queue_flush_t flush, void *cookie)
> > +{
> > +	struct iopf_queue *queue;
> > +
> > +	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
> > +	if (!queue)
> > +		return NULL;
> > +
> > +	/*
> > +	 * The WQ is unordered because the low-level handler enqueues faults by
> > +	 * group. PRI requests within a group have to be ordered, but once
> > +	 * that's dealt with, the high-level function can handle groups out of
> > +	 * order.
> > +	 */
> > +	queue->wq = alloc_workqueue("iopf_queue/%s", WQ_UNBOUND, 0, name);
> Should this workqueue use 'WQ_HIGHPRI | WQ_UNBOUND' or some flags like this
> to decrease the unexpected
> latency of I/O PageFault here? Or maybe, workqueue will show an uncontrolled
> latency, even in a busy system.

I'll investigate the effect of these flags. So far I've only run on
completely idle systems but it would be interesting to add some
workqueue-heavy load in my tests.

Thanks,
Jean
