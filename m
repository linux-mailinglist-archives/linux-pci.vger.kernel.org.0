Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AFA4BAAF7
	for <lists+linux-pci@lfdr.de>; Thu, 17 Feb 2022 21:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343609AbiBQU13 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Feb 2022 15:27:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343621AbiBQU1Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Feb 2022 15:27:25 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA26AA2F3
        for <linux-pci@vger.kernel.org>; Thu, 17 Feb 2022 12:27:10 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 195so5972242pgc.6
        for <linux-pci@vger.kernel.org>; Thu, 17 Feb 2022 12:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YlSG++D5GfAHgHmjCfrZ6D8LvYD5B7GrBUMzoffTqAU=;
        b=0nnNSqJcsLP1yRJd17NtCLezgX+a+VIHCjJ20hnNd2JMFcDtSMvlN0CG3hTnitJpkJ
         mjLos2PgtPfsEcRauZ0aOjlsH/2T4HEItSaK5hQLJ0pYMeiYHQESwlKIRpJ5waVMDe5Z
         9rpZx971pGiBljR2Lp2Kt6GdtyXIn5Hj4X8n/nT0EIHqr7QSgGVmYJ1YSxlaQu7gSMfn
         oxp27a52vIcy7rEX0Nz38CXd1wqqwuYYQc72P4G8MdOfeLGoXzx9byXk86sMyHOUuZTt
         PZ9hvu3g29Z8lox1XB01OnlOAfNbPPIpkUxm5LBE+l0v4WBVKY6/6RAsXKaaxhydwvTM
         WY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YlSG++D5GfAHgHmjCfrZ6D8LvYD5B7GrBUMzoffTqAU=;
        b=xiq4a8/eE2k3LIaxattaroYhn4P0/IEOJSNLZH4Y+iTL/E9bUYjr9gMSGZNo7IOer4
         1oWzfOHnMaLWpp5vx0AViQ2Php8lyjtoT7BRDBvQG0xb5fJMi1NxucudC2f4k/5WMJW4
         N384TT7jNrf8rKPNe4Q7Eck09GvPUHFlCVrwzZxzDJbmiDLabc2v1XWSbDGpSaTxuBhJ
         MhQPkJg6jSHBHyQSEFBbERStkdhBL8+eqjYcP6+YE3CeFvCMR9WYMKuj4kBr/Jtt57Xk
         wZaNPjZNUITg4tFVjDcEuNBeeI2og2YIPaSX9yLPas5EGCTqTEiumcB3Ndp8yC0KN2hL
         4M0A==
X-Gm-Message-State: AOAM531tEv8+iNccUqBGe7AtPH1uDmICHmpfFZYeYPoNKvpBOsELPpIN
        wfykiAV/oJiKeBfvyfqSOKMW4Rx8bBnPBjanRR/cVA==
X-Google-Smtp-Source: ABdhPJx+YcfS9D3lwIGA9Or9eXz4j+NNFWaYU15u8B4dembYmHz2ef6AeGrexxMajMjW5O5p6yWNlE7EexQ1nAFHaWQ=
X-Received: by 2002:a63:f011:0:b0:36c:2da3:32bc with SMTP id
 k17-20020a63f011000000b0036c2da332bcmr3689054pgh.40.1645129629655; Thu, 17
 Feb 2022 12:27:09 -0800 (PST)
MIME-Version: 1.0
References: <20220217171057.685705-1-ben.widawsky@intel.com>
 <20220217171931.740926-1-ben.widawsky@intel.com> <CAPcyv4i83TxCN_-Y3a5CuM2ng9bCAyLm53=wcHWutASd434gkg@mail.gmail.com>
 <20220217185811.qjct4dlnupgah7lh@intel.com>
In-Reply-To: <20220217185811.qjct4dlnupgah7lh@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 17 Feb 2022 12:26:58 -0800
Message-ID: <CAPcyv4in9Pby8X8ydCLH8SOhr3pjYM7UCAbTOHzuMkKmax8M=Q@mail.gmail.com>
Subject: Re: [PATCH v5 01/15] cxl/region: Add region creation ABI
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 17, 2022 at 10:58 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 22-02-17 09:58:04, Dan Williams wrote:
> > On Thu, Feb 17, 2022 at 9:19 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > Regions are created as a child of the decoder that encompasses an
> > > address space with constraints. Regions have a number of attributes that
> > > must be configured before the region can be activated.
> > >
> > > The ABI is not meant to be secure, but is meant to avoid accidental
> > > races. As a result, a buggy process may create a region by name that was
> > > allocated by a different process. However, multiple processes which are
> > > trying not to race with each other shouldn't need special
> > > synchronization to do so.
> > >
> > > // Allocate a new region name
> > > region=$(cat /sys/bus/cxl/devices/decoder0.0/create_region)
> > >
> > > // Create a new region by name
> > > while
> > > region=$(cat /sys/bus/cxl/devices/decoder0.0/create_region)
> > > ! echo $region > /sys/bus/cxl/devices/decoder0.0/create_region
> > > do true; done
> > >
> > > // Region now exists in sysfs
> > > stat -t /sys/bus/cxl/devices/decoder0.0/$region
> > >
> > > // Delete the region, and name
> > > echo $region > /sys/bus/cxl/devices/decoder0.0/delete_region
> > >
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
[..]
> > > +static void unregister_region(void *_cxlr)
> > > +{
> > > +       struct cxl_region *cxlr = _cxlr;
> > > +
> > > +       if (!test_and_set_bit(REGION_DEAD, &cxlr->flags))
> > > +               device_unregister(&cxlr->dev);
> >
> > I thought REGION_DEAD was needed to prevent double
> > devm_release_action(), not double unregister?
> >
>
> I believe that's correct, repeating what you said on our internal list:
>
> On 22-02-14 14:11:41, Dan Williams wrote:
>   True, you do need to solve the race between multiple writers racing to
>   do the unregistration, but that could be done with something like:
>
>   if (!test_and_set_bit(REGION_DEAD, &cxlr->flags))
>       device_unregister(&cxlr->dev);
>
> So I was just trying to implement what you said. Remainder of the discussion
> below...

That was in the context of moving the unregistration to a workqueue
and taking the device lock to validate whether the device has already
been unbound. In this case keeping the devm_release_action() inline in
the sysfs attribute the flag needs to protect against racing
devm_release_action(). I am not saying that a workqueue is now needed,
just clarifying the context of that suggestion.

[..]
> > > +
> > > +       return cxlr;
> > > +
> > > +err_out:
> > > +       put_device(dev);
> > > +       kfree(cxlr);
> >
> > This is a double-free of cxlr;
> >
>
> Because of release()? How does release get called if the region device wasn't
> added? Or is there something else?

->release() is always called at final put_device() regardless of
whether the device was registered with device_add() or not. I.e. see
all the other dev_set_name() error handling in the core that just does
put_device().
