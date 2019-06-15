Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB4D46D70
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jun 2019 03:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfFOBO4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 21:14:56 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41873 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfFOBO4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jun 2019 21:14:56 -0400
Received: by mail-oi1-f196.google.com with SMTP id g7so3267258oia.8
        for <linux-pci@vger.kernel.org>; Fri, 14 Jun 2019 18:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YXA5bt0DRqq3Y8upnzIrF6REEJIQ3rcT1NgkB5rI0Pk=;
        b=tJmg62m5f5wzjStc/29QDsRE/q4PtUR7a07UcT9A+LpofKKbxhtlmCVhtiJ8URAGLA
         9oK9DJH98vQawRs0h37hjqVTMVMJWvmn1NENWEvQcKiDXa/4ypd31CJaKcQrvB78GOhr
         Qbbk6j3mpA6d1cD9ylhgqzPJxlzijRmQqwiLfaMhhoWCiFA/gFjJw+5MiA0tc2pV/9+G
         Sl4Xc+lFQQumGmBwoeyeK0hlQsDN5BV8kkty0G0+AiFUxphY9dfVKR5wzwo5PVFTO/Jr
         4+9iaNMvBJSAm3MKHtVibI6ZPeuLK1e7+r9sLGzVfNA1FoAErnV7xkbqVG7OP5TKANBO
         dkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YXA5bt0DRqq3Y8upnzIrF6REEJIQ3rcT1NgkB5rI0Pk=;
        b=MF3wXiNYyvKgzm+s4FLngdhMHwfeviysD0VX4EelF2Ge1hZi4deT2H40GmLIxiEWRQ
         7wgn3rfM7rcpUg9XcqzPYExY0NYVC41plEFy+ud5bpY9WIpUKD9nMop05CUvzBkSsBYz
         QQYfL+SwUocwc1JWJH0KZSdyBpbf4tZdL5XQwQvlX5VBnNWH6hutj3QZZ75fsXTbqv8m
         1Cr0nLKn/EqougMTJ6gXlncxtYVo8ee5HK5WuUCAFQKIJ6RCtyKnEOZ3ehswoeyHSRAi
         JhXITRUIiTds3E/xtLRetdn16PsTVOWQu4CkwKfnCgK3UFqmLXjXn36izVJMXZ8TXKZX
         2yxg==
X-Gm-Message-State: APjAAAVeiJf8i71zDI48fTF5gaaJXM0Rpf2bNcEuTaDr42xPIw3NbQsg
        d5elMD3kHdKn2DlHCJ6HxFHBY5N6pLo/Yb2Nb0UtNw==
X-Google-Smtp-Source: APXvYqxqBHyqynWE7/sHeR/K8H8EClnUTPV3/T7OxCVIwp/PZVwUGw1nUJBb42vXH0k1fSGr8eACLhIRKFpd++U1+Gw=
X-Received: by 2002:aca:ec82:: with SMTP id k124mr3500913oih.73.1560561295806;
 Fri, 14 Jun 2019 18:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190613094326.24093-1-hch@lst.de> <CAPcyv4jBdwYaiVwkhy6kP78OBAs+vJme1UTm47dX4Eq_5=JgSg@mail.gmail.com>
 <20190614061333.GC7246@lst.de>
In-Reply-To: <20190614061333.GC7246@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 14 Jun 2019 18:14:45 -0700
Message-ID: <CAPcyv4jmk6OBpXkuwjMn0Ovtv__2LBNMyEOWx9j5LWvWnr8f_A@mail.gmail.com>
Subject: Re: dev_pagemap related cleanups
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, Linux MM <linux-mm@kvack.org>,
        nouveau@lists.freedesktop.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 13, 2019 at 11:14 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Jun 13, 2019 at 11:27:39AM -0700, Dan Williams wrote:
> > It also turns out the nvdimm unit tests crash with this signature on
> > that branch where base v5.2-rc3 passes:
>
> How do you run that test?

This is the unit test suite that gets kicked off by running "make
check" from the ndctl source repository. In this case it requires the
nfit_test set of modules to create a fake nvdimm environment.

The setup instructions are in the README, but feel free to send me
branches and I can kick off a test. One of these we'll get around to
making it automated for patch submissions to the linux-nvdimm mailing
list.

https://github.com/pmem/ndctl/blob/master/README.md
