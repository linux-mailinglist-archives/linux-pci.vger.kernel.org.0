Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC75E5EB08
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 20:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfGCSBa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 14:01:30 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:47031 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfGCSB1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jul 2019 14:01:27 -0400
Received: by mail-qk1-f194.google.com with SMTP id r4so3476178qkm.13
        for <linux-pci@vger.kernel.org>; Wed, 03 Jul 2019 11:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a2vka/akssy/859dgmuGdTYFT4YH52SMxVHx2PN2EUA=;
        b=UR+mB33wfBhu3cMDn/7EBIfgFaGZRuvY/6J1fd9PhMgOfBQW4lCtf4aW4cWrAUOg/V
         ysDxZJU9vC+aEmT4cwhxTIl4TYXWNEvXLnwzfoSFoTPuhqs/gUxKo54FOzEU1qF6lBPO
         BDzC9RkbmXZgFl5C89Dr/DavME/J23LtilDnr6BOfCLfGcmh3h3ZqRvCwPxs52Z9/ShV
         88aK4465TTIaWrpxAOzvxt4Awc0wM1VxGtTmtNuDdYn6htswBnMWDqrfqYcoFAAtYDKN
         PK+3yzvEgZr3lVoSgy+/yjpH/TVAkGrizrHi9TWzWfIHt86MDzHjD59dYGp18SQRc4c1
         cphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a2vka/akssy/859dgmuGdTYFT4YH52SMxVHx2PN2EUA=;
        b=evf3rLtbDsc6o9EYYetx9olvG+BIAodSvi7/wTlcyn+DpSAhzW0o/M1Ss/5G8DhNam
         j0AwM0jqlcSRFpD4b8o2D9w4tT+DExpxCWi1O+NU3odDPcIRzB3+gM4yu2c6JXxMJsF1
         INJZDLjXI/iABV5baLOBheTIlsGNuiSDNc8MeFlj1lMAouArNH5lZrrVx44tYCy8xxGI
         /UM81aps447QuqSugTN1utK8V8xzvudeC6wjABiYU6SluS7EiMiiAdHtddU9B7CCAEO7
         EP2RkiDv0ZlOqb5VwSh/mhFy5QlAcYzxyFtorZ/2vBhTanlMT6nCfGJRaKw6JOVwKYkW
         24NA==
X-Gm-Message-State: APjAAAWLdYnDvJe4zrVeIaQC8xo7Con4UBJZpwY7rX8hdNSwyQkAaD8w
        tlK/YYt4SUyfrppsTwyWcMJ8Rg==
X-Google-Smtp-Source: APXvYqydaJsLmmJTIUtSU+kahyTjsnRgAp4YEYaGKvpkMDRvv9xpp1xwyaxLhy2xlOb2NB+ML08lUQ==
X-Received: by 2002:a37:a413:: with SMTP id n19mr30343855qke.98.1562176886317;
        Wed, 03 Jul 2019 11:01:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id u19sm1310165qka.35.2019.07.03.11.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jul 2019 11:01:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hijZN-0006oc-AR; Wed, 03 Jul 2019 15:01:25 -0300
Date:   Wed, 3 Jul 2019 15:01:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/22] mm: remove the legacy hmm_pfn_* APIs
Message-ID: <20190703180125.GA18673@ziepe.ca>
References: <20190701062020.19239-1-hch@lst.de>
 <20190701062020.19239-23-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701062020.19239-23-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 01, 2019 at 08:20:20AM +0200, Christoph Hellwig wrote:
> Switch the one remaining user in nouveau over to its replacement,
> and remove all the wrappers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
>  drivers/gpu/drm/nouveau/nouveau_dmem.c |  2 +-
>  include/linux/hmm.h                    | 36 --------------------------
>  2 files changed, 1 insertion(+), 37 deletions(-)

Christoph, I guess you didn't mean to send this branch to the mailing
list?

In any event some of these, like this one, look obvious and I could
still grab a few for hmm.git.

Let me know what you'd like please

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Thanks,
Jason
