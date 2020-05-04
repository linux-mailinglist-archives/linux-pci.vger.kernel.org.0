Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD821C3D4A
	for <lists+linux-pci@lfdr.de>; Mon,  4 May 2020 16:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgEDOjo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 10:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbgEDOjn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 May 2020 10:39:43 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970D1C061A0E
        for <linux-pci@vger.kernel.org>; Mon,  4 May 2020 07:39:43 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r26so9407970wmh.0
        for <linux-pci@vger.kernel.org>; Mon, 04 May 2020 07:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w4t0U+D/kp+A2G6So+DAelHTG97Zr7f3qIlp9fzkip4=;
        b=VT6A3yuhts/Sup1Aaf3TlojcaThJY4hOWcMYKaz7xPgexle4/kuynbkV7mgcUoEEbw
         Gn/CW2sYLNgTZA45X9XgPW8JrJWgoeIRF3BPeDrgJPKkGIcPRKop0Gyla7rJZz4Ol5w0
         2lpW0x79AXvLKOlbwqjWSR7H42s53C2/AzDy/RZEYO8aimi5hqvmtvnptqLq1VKbO7a3
         hJy0881ArJOTDVsdeKrk0ixZzwswHqdRYytNWMCWIzu3HYx7Dg6+cxeyEeodVUIodnze
         KcHOc3sN/muaK/jcXS+hiuhM9+aCpMI9of01BChv2AdZ+UxLwm0J0i0JNuUhT5jFaKLt
         cvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w4t0U+D/kp+A2G6So+DAelHTG97Zr7f3qIlp9fzkip4=;
        b=Dg3I6pz2ZCe4uTSCuMQhkBR7n4KInPLwGAECevi0oHdJukwVk0v6+Mzo/Z98W3sQVr
         c6i4o4j7iQPgLP+ZAizuaIM2PVmlk9Ek4TmD8/KxfsPSuy0HPgw5FHYfwU7BeIiwgzNg
         IYjVOKW2E4Ph/wSAJgz/X1e7xoNASqyM0YDn48Z0WQUOcT7KgiXox5tMq7hT66p1TgZ4
         Kvhq08dX+l8K3e7Ki/ZeekRCPwvhmKkt09Ce5DC8WsQrpi167Ur7+cHhAPiqLY6HN2Tp
         Ex+WblJIQYtAGOjojWHBIk5vNCBbDjQ3ykSLjS2T9NH9SAFjZopWWPu7SBPBqHZRJndg
         dvVQ==
X-Gm-Message-State: AGi0PubC1u0Zp6gQgMdGaqGHUhPYfX0R2CBep8DogqB1OfFpiD+c53JP
        m1mhWXFSUgCwaVP76aBTqD8OdQ==
X-Google-Smtp-Source: APiQypI2F7wsUGonQC0TZFKc5uxhIN4f0OL+bxJR0Xwpj7YciVqjrvdRQtQdeeCKgcaZ8I7mLJ+60A==
X-Received: by 2002:a1c:1d92:: with SMTP id d140mr14822175wmd.67.1588603182395;
        Mon, 04 May 2020 07:39:42 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id p190sm14130168wmp.38.2020.05.04.07.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 07:39:41 -0700 (PDT)
Date:   Mon, 4 May 2020 16:39:32 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
        will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        christian.koenig@amd.com, felix.kuehling@amd.com,
        zhangfei.gao@linaro.org, jgg@ziepe.ca, xuzaibo@huawei.com,
        fenghua.yu@intel.com, hch@infradead.org
Subject: Re: [PATCH v6 02/25] iommu/ioasid: Add ioasid references
Message-ID: <20200504143932.GC170104@myrica>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430143424.2787566-3-jean-philippe@linaro.org>
 <20200430113931.0fbf7a37@jacob-builder>
 <20200430134842.74e596b8@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430134842.74e596b8@jacob-builder>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 30, 2020 at 01:48:42PM -0700, Jacob Pan wrote:
> On Thu, 30 Apr 2020 11:39:31 -0700
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
> > > -void ioasid_free(ioasid_t ioasid)
> > > +bool ioasid_free(ioasid_t ioasid)
> > >  {
> Sorry I missed this in the last reply.
> 
> I think free needs to be unconditional since there is not a good way to
> fail it.
> 
> Also can we have more symmetric APIs, seems we don't have ioasid_put()
> in this patchset.

Yes I was thinking of renaming ioasid_free() to ioasid_put() but got lazy. 

> How about?
> ioasid_alloc()
> ioasid_free(); //drop reference, mark inactive, but not reclaimed if
> 		refcount is not zero.
> ioasid_get() // returns err if the ioasid is marked inactive by
> 		ioasid_free()

How does the caller know that the ioasid is in active/inactive state, and
not freed/reallocated?

> ioasid_put();// drop reference, reclaim if refcount is 0.

I'll add ioasid_put() for now. I'd like to avoid introducing the inactive
state in this patch, so shall I change the calls in the Intel driver to
ioasid_put(), and not introduce a new ioasid_free() for the moment?

Thanks,
Jean

