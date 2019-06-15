Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8C347184
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jun 2019 20:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfFOSJV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 Jun 2019 14:09:21 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40679 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfFOSJV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 Jun 2019 14:09:21 -0400
Received: by mail-ot1-f65.google.com with SMTP id e8so4705253otl.7
        for <linux-pci@vger.kernel.org>; Sat, 15 Jun 2019 11:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cb0Hmo2zAZrYDyoCgAidl3UeL9kc8+XrLoGdt6CrXZE=;
        b=EY/IUPVbu+1KTXp5GI53vNwR2z9Nvu64XsQUizbEMMU+aGYsXWtd2lTzv6Rx3V/2OG
         ZCHaTlatz8Y6DgkD78CATBQ1yUSjk/05HpPEqetVEj/+F5+Kom/9e7XbdGpDgyQQCBnL
         yj7evXXPdyreGRqDjU90YAS5Z/xg/+W8t5onIf68LdBa/3dqW/rLtaWBvtaURMP28S5L
         ACzapU9ov4J0F0u3SlQrs+vm8YDjsJurYg/jGuJheOXTmxVlf3qQXGWQIp1J0v1wmtf3
         4CKVxNLpNlkzY6vy0HsyUqk2Hkklo6bAEUB4ced5+znlBd2UCAgiXhA0LcanxooGfjdt
         jtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cb0Hmo2zAZrYDyoCgAidl3UeL9kc8+XrLoGdt6CrXZE=;
        b=XsLWbCvj7IRgDx2mWsltaN0yjGjCp2zGdAb7ejKcDP/ZTqAPX6KTFCQQX0n5VkXvQm
         iSdUZ1CfnB/SGxiHNvgMz0PByYVtwFars0EuNdl5o9Yc2yo32iuHIe4eGMoL1hi2xoYG
         4fM7ruIBDF8FUMNG8GqSyz+QyZ7uH1FwnQjyRXDI+5WKF3WDJW1JJBfi3vz4hcqAO8/f
         +DgGiHjWgavzA7jhsKiUN5IrjNnTby6C/m2i08eRWXTyC8b49dgeemiXxbTdQw8MQNNp
         NNI8RLIzVNkPr6Yna3dDK1swWjXI2IPM+vNv0APNDInxkKcv8V9N+1/galhicCBs+Rj+
         azqg==
X-Gm-Message-State: APjAAAWoMXxQqK/sHKtv+DZlCo1wBXOdnS1fnRzqdbyWCLFyl+c40Skp
        oA/7z+WWa3ANvYzMvUqAR40s13Xr1+8IOKBgEtt5YQ==
X-Google-Smtp-Source: APXvYqxK2ja20GipaVbp7qq4Oaf290msf2s3XleRazQ4mdHqmcalk7o8VyutGF6B5iu+bOwCwwdJPEhdvYDhbnFupMs=
X-Received: by 2002:a9d:7a9a:: with SMTP id l26mr44930666otn.71.1560622160642;
 Sat, 15 Jun 2019 11:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190613094326.24093-1-hch@lst.de> <CAPcyv4jBdwYaiVwkhy6kP78OBAs+vJme1UTm47dX4Eq_5=JgSg@mail.gmail.com>
 <20190614061333.GC7246@lst.de> <CAPcyv4jmk6OBpXkuwjMn0Ovtv__2LBNMyEOWx9j5LWvWnr8f_A@mail.gmail.com>
 <20190615083356.GB23406@lst.de>
In-Reply-To: <20190615083356.GB23406@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 15 Jun 2019 11:09:09 -0700
Message-ID: <CAPcyv4jkDC3hRt_pj1e8j_OmzJ-wdumy-o1bN0ab=JVE_gfKdg@mail.gmail.com>
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

On Sat, Jun 15, 2019 at 1:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Jun 14, 2019 at 06:14:45PM -0700, Dan Williams wrote:
> > On Thu, Jun 13, 2019 at 11:14 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > On Thu, Jun 13, 2019 at 11:27:39AM -0700, Dan Williams wrote:
> > > > It also turns out the nvdimm unit tests crash with this signature on
> > > > that branch where base v5.2-rc3 passes:
> > >
> > > How do you run that test?
> >
> > This is the unit test suite that gets kicked off by running "make
> > check" from the ndctl source repository. In this case it requires the
> > nfit_test set of modules to create a fake nvdimm environment.
> >
> > The setup instructions are in the README, but feel free to send me
> > branches and I can kick off a test. One of these we'll get around to
> > making it automated for patch submissions to the linux-nvdimm mailing
> > list.
>
> Oh, now I remember, and that was the bummer as anything requiring modules
> just does not fit at all into my normal test flows that just inject
> kernel images and use otherwise static images.

Yeah... although we do have some changes being proposed from non-x86
devs to allow a subset of the tests to run without the nfit_test
modules: https://patchwork.kernel.org/patch/10980779/

...so this prompts me to go review that patch.
