Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22DA4A7869
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 20:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbiBBTAS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 14:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiBBTAR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Feb 2022 14:00:17 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E33C06173B
        for <linux-pci@vger.kernel.org>; Wed,  2 Feb 2022 11:00:17 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id x3so70733pll.3
        for <linux-pci@vger.kernel.org>; Wed, 02 Feb 2022 11:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4isSqbjIiFBKB0YhPF3MY13YBs9ngbw9fXsP/sC2OwI=;
        b=Ct5cXfPg60pPdCPtLRezYHEIJZRJzQMO0tQR9toTBdmFA7wAa8vAkRzGbzi7e1cVzV
         4OlOkoQitoXSkIB19zzjoMdKVJDzP3S90IQd5y6yIuwEAK33MAm5gtP9SQCY/DI3zZ9l
         jdDCbUJRTVgFN8uUTt3KNTmmh/QIhJEY5ALyEySnfvvsy3pSDAg7+R9RAxzYYy07VYON
         8vbi4j9BjDVaPRpJBOoHotdPuQ3XIkM9gSBzLhmjSSerkSp6lnv+OzSVPwupDKXFolnb
         V/LPTxRV288926Qqj07vFEo+4UY80q1XnqdlWPsU5H6ymkcNUGz+BGF1RI9rWR+ng2LF
         hCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4isSqbjIiFBKB0YhPF3MY13YBs9ngbw9fXsP/sC2OwI=;
        b=VWFEN6MJGHd/hhZyBXh5mNsNXjJhpgxeaeB8XSzt/YusZOCU24Aq92ayoH7BmWJebF
         t9SzkgnT4215wbjHb8R8wbGywXy57k1QnAmbZJBvNbyhz57u4JUGybjYsE7koE/BGhcR
         aWAIWJoGP6L53I5PTVMgLVYNdsR8m1VivQ3aBQjZhHw60IEahR1LU+xgNb4/rDiQKhQB
         CR1g/RxngS8ibssDWfU1BUzSPoqzPbnqdV+3vHhup8NH+B7XlN2AJTN4BopxWJfvfUWK
         OBF1X9ZcNDnDQeQHkCqPDRimsAX4jTbtGfAE1vEOTXhMZGfIlQ/+1t+v5I45QWQXiHX5
         E1pg==
X-Gm-Message-State: AOAM532s2LaPLbYM4oKd2+nLFU7VA9HVcwTfzVhGmUAqUhmrfni7MrVk
        ahSfpKygf/Mn8qV/JGN1w33CSK85b0t69+Gzp6ZcbQ==
X-Google-Smtp-Source: ABdhPJwjSpULGdMXY6QJM9mho3fUsdFet5Eq9CPfBdbgrPDenf1+RjAo/hY6moD7rw6fNqkwRijjl+x8Y9qazITPY7g=
X-Received: by 2002:a17:90b:1bcc:: with SMTP id oa12mr9529293pjb.93.1643828417205;
 Wed, 02 Feb 2022 11:00:17 -0800 (PST)
MIME-Version: 1.0
References: <20220128002707.391076-1-ben.widawsky@intel.com>
 <20220128002707.391076-2-ben.widawsky@intel.com> <CAPcyv4h53gj9vETFcj_RebW+Zt=q+1yOmMo9CpyzHdABanpPRg@mail.gmail.com>
 <CAPcyv4hj=1=+8UvqzSZqJ12ef1F15Hpzud7YjJpz7dZa0=9=QQ@mail.gmail.com>
 <20220202182604.oangkxomx3npmobl@intel.com> <20220202182811.ivupsaeogyiwl5so@intel.com>
 <20220202184813.euepn3m2twpybpoc@intel.com>
In-Reply-To: <20220202184813.euepn3m2twpybpoc@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 2 Feb 2022 11:00:04 -0800
Message-ID: <CAPcyv4hTRVuO=gVDe1ePTOaC3HiKKD7a00Zxz1uBLakfYFEtsw@mail.gmail.com>
Subject: Re: [PATCH v3 01/14] cxl/region: Add region creation ABI
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, patches@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 2, 2022 at 10:48 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 22-02-02 10:28:11, Ben Widawsky wrote:
> > On 22-02-02 10:26:06, Ben Widawsky wrote:
> > > On 22-01-28 10:59:26, Dan Williams wrote:
> > > > On Fri, Jan 28, 2022 at 10:14 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > > > [..]
> > > > > Here is that put_device() I was expecting, that kfree() earlier was a
> > > > > double-free it seems.
> > > > >
> > > > > Also, I would have expected a devm action to remove this. Something like:
> > > > >
> > > > > struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> > > > >
> > > > > cxl_device_lock(&port->dev);
> > > > > if (port->dev.driver)
> > > > >     devm_cxl_add_region(port->uport, cxld, id);
> > >
> > > I assume you mean devm_cxl_delete_region(), yes?
> > >
> > > > > else
> > > > >     rc = -ENXIO;
> > > > > cxl_device_unlock(&port->dev);
> > > > >
> > > > > ...then no matter what you know the region will be unregistered when
> > > > > the root port goes away.
> > > >
> > > > ...actually, the lock and ->dev.driver check here are not needed
> > > > because this attribute is only registered while the cxl_acpi driver is
> > > > bound. So, it is safe to assume this is protected as decoder remove
> > > > synchronizes against active sysfs users.
> > >
> > > I'm somewhat confused when you say devm action to remove this. The current auto
> > > region deletion happens when the ->release() is called. Are you suggesting when
> > > the root decoder is removed I delete the regions at that point?
> >
> > Hmm. I went back and looked and I had changed this functionality at some
> > point... So forget I said that, it isn't how it's working currently. But the
> > question remains, are you suggesting I delete in the root decoder
> > unregistration?
>
> I think it's easier if I write what I think you mean.... Here are the relevant
> parts:
>
> devm_cxl_region_delete() is removed entirely.
>
> static void unregister_region(void *_cxlr)
> {
>         struct cxl_region *cxlr = _cxlr;
>
>         device_unregister(&cxlr->dev);
> }
>
>
> static int devm_cxl_region_add(struct cxl_decoder *cxld, struct cxl_region *cxlr)
> {
>         struct cxl_port *port = to_cxl_port(cxld->dev.parent);
>         struct device *dev = &cxlr->dev;
>         int rc;
>
>         rc = dev_set_name(dev, "region%d.%d:%d", port->id, cxld->id, cxlr->id);
>         if (rc)
>                 return rc;
>
>         rc = device_add(dev);
>         if (rc)
>                 return rc;
>
>         return devm_add_action_or_reset(&cxld->dev, unregister_region, cxlr);

Decoders can't host devm actions. The host for this action would need
to be the parent port.

> }
>
> static ssize_t delete_region_store(struct device *dev,
>                                    struct device_attribute *attr,
>                                    const char *buf, size_t len)
> {
>         struct cxl_decoder *cxld = to_cxl_decoder(dev);
>         struct cxl_region *cxlr;
>
>         cxlr = cxl_find_region_by_name(cxld, buf);
>         if (IS_ERR(cxlr))
>                 return PTR_ERR(cxlr);
>
>         devm_release_action(dev, unregister_region, cxlr);

Yes, modulo the same comment as before that the decoder object is not
a suitable devm host. This also needs a solution for the race between
these 2 actions:

echo "ACPI0017:00" > /sys/bus/platform/drivers/cxl_acpi/unbind
echo $region > /sys/bus/cxl/devices/$decoder/delete_region
