Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3D42858DC
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 08:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgJGGyz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 02:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJGGyz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2020 02:54:55 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26F4C061755
        for <linux-pci@vger.kernel.org>; Tue,  6 Oct 2020 23:54:54 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j2so817738wrx.7
        for <linux-pci@vger.kernel.org>; Tue, 06 Oct 2020 23:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yV5AkaFIVg+Yi3ixHGvhAiRB15tgFTDYhQclUATgZhM=;
        b=DaUOvxS2baB+WsthNTl4GhU1HgjUAnfHCdOiQSRHle8Jib0em9a5gVlZWhkljZMldX
         /ZYpWBdSIdWcdQBl+usF0/I6UnapkS0OL/0SI/wnlCJ4LKd5tJAtd4iOyStsVgsCtaW1
         ufEyHznBicgVue0wYNbAVIuztugJla2pUN7UUKzn6FYWIrLwbbaUmWk9xfC+hL+eYSwA
         GeKZJX536oj0Yj+DocHZ1zjzg2zU4zw8uwKTDOSOi8N4EtblMq2kF1EuKqEPQ0tBNXBg
         HDNwVizZ2xr5+wkGdlgT3l8uA22ByJXw/JdEQNhqZvh5rf65F1Z8AS3bMA4vKaUqVEJv
         Npqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yV5AkaFIVg+Yi3ixHGvhAiRB15tgFTDYhQclUATgZhM=;
        b=Aga+ehuSu9Xk3jzV5dQk+MQfhSzzWGRlLWXM6Q3/GKszl+II1Jl3hSCfhneWMLPClG
         Z+5jqMxAemOK6/U9THXD349SftoX7JblCcOBGN1TzHbE7vk4lUPIKb0Aqolq7zIPIJBW
         js//ru2Lk5TVHUOz227hpPWzC4aOd1WMkQ3Wt+0SI3wF0oCGjfxbPcvMgL/HXAWjKanw
         MVM44Dh54MomgkFeeUhIJ1v9TQniJpKpVTYq/Ibf96ohLkkJQawtAclC+aXEi8r3ae7m
         HHTMeJ9yhz8oOa7Rdz3TA2Xb9tWPN0JJaJv/AqH4zofMNfsg7CAlrwpcUFr7ECH/hAsA
         BkmA==
X-Gm-Message-State: AOAM532V97DiejbjX8K5Z44SII4tQrckfCZtfAky200ew+M8swdmdc0h
        YexD/l7IPqTJIFUvt+UUFhbT4fQmhnENxVrH
X-Google-Smtp-Source: ABdhPJwLqYg8vIlX/I+U3N0KaVXMtiFm1z+Pi+eWTyNxdyBLnzqtb//QVQxvRxj2/tHkP31vn/ozcQ==
X-Received: by 2002:adf:a3c3:: with SMTP id m3mr1744527wrb.70.1602053693510;
        Tue, 06 Oct 2020 23:54:53 -0700 (PDT)
Received: from dell ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id g83sm1346727wmf.15.2020.10.06.23.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 23:54:52 -0700 (PDT)
Date:   Wed, 7 Oct 2020 07:54:51 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, dvhart@infradead.org,
        andy@infradead.org, bhelgaas@google.com, hdegoede@redhat.com,
        alexey.budankov@linux.intel.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V8 1/5] PCI: Add defines for Designated Vendor-Specific
 Extended Capability
Message-ID: <20201007065451.GB6148@dell>
References: <20201007005118.GA3230211@bjorn-Precision-5520>
 <dcaea6b4e1d5b4a452c304fadb034b7b1e1c40af.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dcaea6b4e1d5b4a452c304fadb034b7b1e1c40af.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 06 Oct 2020, David E. Box wrote:

> On Tue, 2020-10-06 at 19:51 -0500, Bjorn Helgaas wrote:
> > On Tue, Oct 06, 2020 at 03:45:54PM -0700, David E. Box wrote:
> > > Hi Bjorn,
> > > 
> > > This patch has been acked and unchanged for weeks. Is it possible
> > > to
> > > get this pulled into next? We have SIOV and CXL related work that
> > > is
> > > using these definitions. Thanks.
> > 
> > I acked it because I expected you to merge it along with the rest of
> > the series.
> > 
> > I guess I could merge this patch via the PCI tree if you really want,
> > but that ends up being a hassle because we have to worry about which
> > order things get merged to Linus' tree.  Better if the whole series
> > is
> > merged via the same tree.
> 
> Agreed. The hope is that this series is ready for the next merge window
> but no ack yet on V8. And if the series does not make it I'd like this
> patch to at least get in.

If Bjorn is happy to take this patch so late in the release cycle then
please go ahead.  The other patches are due for v5.11.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
