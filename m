Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B89526254A
	for <lists+linux-pci@lfdr.de>; Wed,  9 Sep 2020 04:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgIICjk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Sep 2020 22:39:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50493 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729413AbgIICjj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Sep 2020 22:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599619177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+kOlksnHlL2YKiZmwkKZv4xGASnLuZsp0UtpeOcpuVA=;
        b=FEhYVhWKvpNylp8XFo5MO9xYzWotVCKRv18MVfZLrU2eBnnNWS+25xfK+v98WzZnlDofyq
        IjhhwER4jAsL+blpkbA0fc4w2K1cU/AyflxqOC3D9z2jeBZJqxXOYtxtPYEYtUg0HUgMlo
        Kf2nOs0bXdq5KxNYxffO/ifM3+AxZxo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-wAFVfAntNYSuExNRwqOGJQ-1; Tue, 08 Sep 2020 22:39:33 -0400
X-MC-Unique: wAFVfAntNYSuExNRwqOGJQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3353E8018AB;
        Wed,  9 Sep 2020 02:39:31 +0000 (UTC)
Received: from T590 (ovpn-12-76.pek2.redhat.com [10.72.12.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D8D1D5D9E8;
        Wed,  9 Sep 2020 02:39:22 +0000 (UTC)
Date:   Wed, 9 Sep 2020 10:39:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "Zhao, Haifeng" <haifeng.zhao@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "Zhang, ShanshanX" <shanshanx.zhang@intel.com>,
        "Jia, Pei P" <pei.p.jia@intel.com>
Subject: Re: [PATCH] Revert "block: revert back to synchronous request_queue
 removal"
Message-ID: <20200909023918.GA1473752@T590>
References: <20200908075047.5140-1-haifeng.zhao@intel.com>
 <20200908142128.GA3463@infradead.org>
 <MWHPR11MB1696A6C649BD434390418FE797260@MWHPR11MB1696.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1696A6C649BD434390418FE797260@MWHPR11MB1696.namprd11.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Haifeng,

On Wed, Sep 09, 2020 at 02:11:20AM +0000, Zhao, Haifeng wrote:
> Ming, Christoph,
>     Could you point out the patch aimed to fix this issue ? I would like to try it.   This issue blocked my other PCI patch developing and verification work, 
> I am not a BLOCK/NVMe expert, wouldn't to be trapped into other sub-system bugs, so just reported it for other expert's quick fix. 
> 

Please try the following patch:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cafe01ef8fcb248583038e1be071383530fe355a

Thanks,
Ming

