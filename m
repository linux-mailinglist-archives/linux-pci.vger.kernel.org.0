Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 602F85DA28
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 03:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfGCBDF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jul 2019 21:03:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727082AbfGCBDF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jul 2019 21:03:05 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F38A21904;
        Tue,  2 Jul 2019 22:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562106936;
        bh=c/MyoEL1y9iSRH8tUqhzcXV9ntk3My2ap/3Dn7awyKw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l01hbVKK1DS91crh+dWLCuA/4HwJhhjblV3ZmG7+ToSZt2H6+9chb5C6lWKcVbpZT
         6yf7b0ESc5qYx1xKDTnqLzeOjjZhZFZwE/7x1lR6/PQ/5qZQPNx1I+vWXKWbwacqes
         0uz8JuzySX1Z2Xp+A47oGKzrXsLwsUNXRd+bPFwo=
Date:   Tue, 2 Jul 2019 15:35:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@mellanox.com>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 16/25] device-dax: use the dev_pagemap internal refcount
Message-Id: <20190702153535.228365fea7f0063cceec96cd@linux-foundation.org>
In-Reply-To: <CAPcyv4h90DAVHbZ4bgvJwpfB8wr2K28oEes6HcdQOpf02+NL=g@mail.gmail.com>
References: <20190626122724.13313-17-hch@lst.de>
        <20190628153827.GA5373@mellanox.com>
        <CAPcyv4joSiFMeYq=D08C-QZSkHz0kRpvRfseNQWrN34Rrm+S7g@mail.gmail.com>
        <20190628170219.GA3608@mellanox.com>
        <CAPcyv4ja9DVL2zuxuSup8x3VOT_dKAOS8uBQweE9R81vnYRNWg@mail.gmail.com>
        <CAPcyv4iWTe=vOXUqkr_CguFrFRqgA7hJSt4J0B3RpuP-Okz0Vw@mail.gmail.com>
        <20190628182922.GA15242@mellanox.com>
        <CAPcyv4g+zk9pnLcj6Xvwh-svKM+w4hxfYGikcmuoBAFGCr-HAw@mail.gmail.com>
        <20190628185152.GA9117@lst.de>
        <CAPcyv4i+b6bKhSF2+z7Wcw4OUAvb1=m289u9QF8zPwLk402JVg@mail.gmail.com>
        <20190628190207.GA9317@lst.de>
        <CAPcyv4h90DAVHbZ4bgvJwpfB8wr2K28oEes6HcdQOpf02+NL=g@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 28 Jun 2019 12:14:44 -0700 Dan Williams <dan.j.williams@intel.com> wrote:

> I believe -mm auto drops patches when they appear in the -next
> baseline. So it should "just work" to pull it into the series and send
> it along for -next inclusion.

Yup.  Although it isn't very "auto" - I manually check that the patch
which turned up in -next was identical to the version which I had.  If
not, I go find out why...

