Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3E9383B8C
	for <lists+linux-pci@lfdr.de>; Mon, 17 May 2021 19:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbhEQRpz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 13:45:55 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:36799 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbhEQRpx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 13:45:53 -0400
Received: by mail-wr1-f49.google.com with SMTP id c14so5525879wrx.3
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 10:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1xJsrGFsO/kpHa0x/GqMcGe+uNXmw2829mAM4URjK74=;
        b=QalQA0k6WDGWksWVd7ohjqsMx6EvRd2OX85zybDtwxajTmDZ7UFTOwYCYi96JSvsb/
         v7C1je5aH8IRQ9Sl5hG1vxWwImAyWlv0fiw8aS4TnSeOScdwMjyJ0Gl1tcxwCwAh5yQi
         34o3WXQCfrJFzySkMGmvUH/2Uh28B3/M9gEVcVArZfWJycRH1M0UsxbgHzK2gwoGgIs6
         uCPaOE7KpT+AMN1jSoX9cjPz3Sbc6RTKUVtJi56zizeOlgYjTEAyWixemtQBnPjJ4xia
         0M8grjlFDhkkMQ1NNbAZH2i7gMdrZdA6plUbz4QNWIHTnVHXd/ZorkI7l0Sm149AiSNk
         3wFw==
X-Gm-Message-State: AOAM5332xiiYf0SD1JpGxzjsU8xbOI/2aSlLgY3zN6scRphX88UUHAcr
        5w2xlcUkxB3MhbWosf2Fg1w=
X-Google-Smtp-Source: ABdhPJzT2r7sQeAsamGw6i7dzUA0bWMsvliwY5s/1lWt2smvT6jVQa7dTh/i6mIgfsxgYsYXWzprsQ==
X-Received: by 2002:a05:6000:1089:: with SMTP id y9mr1006825wrw.121.1621273475302;
        Mon, 17 May 2021 10:44:35 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id a129sm168731wmh.20.2021.05.17.10.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 10:44:34 -0700 (PDT)
Date:   Mon, 17 May 2021 19:44:33 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Joe Perches <joe@perches.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 01/14] PCI: Use sysfs_emit() and sysfs_emit_at() in
 "show" functions
Message-ID: <20210517174433.GA278212@rocinante.localdomain>
References: <20210515052434.1413236-1-kw@linux.com>
 <b3be37d4-5d98-474e-05ca-afce4782c359@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b3be37d4-5d98-474e-05ca-afce4782c359@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Logan,

> > The sysfs_emit() and sysfs_emit_at() functions were introduced to make
> > it less ambiguous which function is preferred when writing to the output
> > buffer in a device attribute's "show" callback [1].
> > 
> > Convert the PCI sysfs object "show" functions from sprintf(), snprintf()
> > and scnprintf() to sysfs_emit() and sysfs_emit_at() accordingly, as the
> > latter is aware of the PAGE_SIZE buffer and correctly returns the number
> > of bytes written into the buffer.
> > 
> > No functional change intended.
> > 
> > [1] Documentation/filesystems/sysfs.rst
> > 
> > Related to:
> >   commit ad025f8e46f3 ("PCI/sysfs: Use sysfs_emit() and sysfs_emit_at() in "show" functions")
> 
> I re-reviewed the whole series. It still looks good to me.
> 
> Very nice solution in patch 12 to the new line issue.
> 
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> 
> Thanks,

Thank you!

I will send v3 incorporating the style change as per Joe's suggestion
and carry-over your "Reviewed-by", if you don't mind, as it will be
a trivial change.

Krzysztof
