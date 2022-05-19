Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476C052DE5D
	for <lists+linux-pci@lfdr.de>; Thu, 19 May 2022 22:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbiESU0L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 May 2022 16:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244750AbiESU0J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 May 2022 16:26:09 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4F725E91
        for <linux-pci@vger.kernel.org>; Thu, 19 May 2022 13:26:06 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id e78so10918271ybc.12
        for <linux-pci@vger.kernel.org>; Thu, 19 May 2022 13:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CWhUbhLhWfCrRC/uOMibPqgcUcH63A95cFj+bxrjJ6M=;
        b=tlBQXD0Z0G0bCVmfTuvwJ+4NyYHrFfWgzAOUy/kPLlGZ0K8ALe2zTF7b6Zo4T+rBi1
         9F33AaKTmaTnuzDFCN3PSaqBQXR4absSCcUOz3JLqXQNfta2NON6c1DTfFN9bUZzU1ES
         lqN5rwzplsHZcGpXDX9K3HNL9pnm24GNnxTY9ST2TCZLDK/GbG4tuqHAihEtr9Nadpcn
         ZhkDBYQKWawT7+oIQUCxm9K4f4z78QQsLRNrB9CqG4k0zR29JNHFrbo7y4qs5a8F+NO4
         cAAzyECwGvHJgqSZ42EYSLBsBySW70NVhuRHgKYK8L4yGHouUtHVxeKfuxW2cFzhmuBc
         KLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CWhUbhLhWfCrRC/uOMibPqgcUcH63A95cFj+bxrjJ6M=;
        b=vCIsNWaFzgHbnIZkRpC2XzATvJzhFhun5cW+0EK8WL0bvhGJ4ntQYYrQNJEaTJ52uT
         uY2FNHNqGPv7WyuCEyvuA2nQ0PDIX6I7U93T0YtvDnArAv6a9WNhXgHk7rwEjTBGZOiI
         2bRHp6sybMkjW9GcCDmKR6mJEkB+qSMrSRSrdvJ3aK7FP9uVQzUumswlITQJe2TTu6io
         OfKKzUdz/iIdWNO5v0v2bAtMAR+pjA0AvpVd8V/1IfJxHkrHD1TTDO3Qe0P8c0HH7fQg
         eZKgkgyveZE7hxrAppAvAovSEEefPzICSndMwbgBMCNqBfa5cdOWZOJujOPLFdWWnSvi
         vGBg==
X-Gm-Message-State: AOAM5305p6I3WsOfEYC31MqsQbv1HZjkbX+YwGxuiUG+W5MzvVpOS1hO
        4JbrtYeZ5qocpmYcGeOHQa0SiEf0kW4LuT/YzNYhDQ==
X-Google-Smtp-Source: ABdhPJzBx8hsUYv6eVxmbBnRHhXkhk32U8gz80sAEaPnGEmcYAfFvLs3YVewUbt7MRE5qYYUF3n6kUWKFJRMPquhRQk=
X-Received: by 2002:a25:2488:0:b0:64e:a74d:fc7e with SMTP id
 k130-20020a252488000000b0064ea74dfc7emr6409187ybk.563.1652991965243; Thu, 19
 May 2022 13:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211214221450.589884-1-luca@lucaceresoli.net>
 <CAL_Jsq+GQTcx1EGKHug2ZcDZufrKM-4k6PB0vQeTCTG42MHzvA@mail.gmail.com>
 <59a23c89-0810-eb28-acd9-7051ac34d438@lucaceresoli.net> <4579940c-27dc-733e-4022-ebea4671c839@lucaceresoli.net>
 <CAL_JsqJ5nr6xJoTv3A6UPMMDXhWKcwSEUA3ux3kK8OMWQxdc6w@mail.gmail.com>
 <YnvnNUrsCOUxMu8A@lpieralisi> <615718f9-151e-20fb-fcb0-56063ae61ca6@lucaceresoli.net>
 <CAGETcx9r4e9PkUFNZ+vUfqOSO5=e9apmBj0+DyOkKEvc4CnsLQ@mail.gmail.com> <ebd3f89b-3487-a610-7583-4ffda01a0dd6@lucaceresoli.net>
In-Reply-To: <ebd3f89b-3487-a610-7583-4ffda01a0dd6@lucaceresoli.net>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 19 May 2022 13:25:28 -0700
Message-ID: <CAGETcx-GWqV2Teq0ufK2946rtB7Q-5Y=uzLN_kMbZ+57Aq127A@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: dra7xx: Fix link removal on probe error
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, PCI <linux-pci@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 17, 2022 at 12:32 AM Luca Ceresoli <luca@lucaceresoli.net> wrote:
>
> Hi Saravana,
>
> On 14/05/22 05:46, Saravana Kannan wrote:
> > On Thu, May 12, 2022 at 7:07 AM Luca Ceresoli <luca@lucaceresoli.net> wrote:
> >>
> >> Hi Lorenzo,
> >>
> >> On 11/05/22 18:41, Lorenzo Pieralisi wrote:
> >>> On Sat, Jan 15, 2022 at 10:02:00AM -0600, Rob Herring wrote:
> >>>> +Saravana
> >>>>
> >>>> On Tue, Jan 11, 2022 at 4:35 AM Luca Ceresoli <luca@lucaceresoli.net> wrote:
> >>>>>
> >>>>> Hi Rob,
> >>>>>
> >>>>> On 16/12/21 10:08, Luca Ceresoli wrote:
> >>>>>> Hi Rob,
> >>>>>>
> >>>>>> thanks for the quick feedback!
> >>>>>>
> >>>>>> On 14/12/21 23:42, Rob Herring wrote:
> >>>>>>> On Tue, Dec 14, 2021 at 4:15 PM Luca Ceresoli <luca@lucaceresoli.net> wrote:
> >>>>>>>>
> >>>>>>>> If a devm_phy_get() calls fails with phy_count==N (N > 0), then N links
> >>>>>>>> have already been added by device_link_add() and won't be deleted by
> >>>>>>>> device_link_del() because the code calls 'return' and not 'goto err_link'.
> >>>>>>>>
> >>>>>>>> Fix in a very simple way by doing all the devm_phy_get() calls before all
> >>>>>>>> the device_link_add() calls.
> >>>>>>>>
> >>>>>>>> Fixes: 7a4db656a635 ("PCI: dra7xx: Create functional dependency between PCIe and PHY")
> >>>>>>>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> >>>>>>>> ---
> >>>>>>>>  drivers/pci/controller/dwc/pci-dra7xx.c | 2 ++
> >>>>>>>>  1 file changed, 2 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> >>>>>>>> index f7f1490e7beb..2ccc53869e13 100644
> >>>>>>>> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> >>>>>>>> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> >>>>>>>> @@ -757,7 +757,9 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
> >>>>>>>>                 phy[i] = devm_phy_get(dev, name);
> >>>>>>>>                 if (IS_ERR(phy[i]))
> >>>>>>>>                         return PTR_ERR(phy[i]);
> >>>>>>>> +       }
> >>>>>>>>
> >>>>>>>> +       for (i = 0; i < phy_count; i++) {
> >>>>>>>>                 link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
> >>>>>>>
> >>>>>>> I think this should happen automatically now with fw_devlink being
> >>>>>>> enabled by default. Can you try?
> >>>>>>
> >>>>>> Do you mean removal should be done automatically? I think they are not
> >>>>>> due to the DL_FLAG_STATELESS flag.
> >>>>>
> >>>>> I would love to have feedback because, as said, I think my patch is
> >>>>> correct, but if I'm wrong (which might well be) I have to drop patch 1
> >>>>> and rewrite patch 2 in a slightly more complex form.
> >>>>
> >>>> I mean that why do you need explicit dependency tracking here when
> >>>> dependencies on a PHY should happen automatically now. IOW, what is
> >>>> special about this driver and dependency?
> >>>
> >>> Any update on this patch ? I think patch 2 can be merged, please
> >>> let me know if this one can be dropped.
> >>
> >> Thanks for the feedback! You would say yes, you can merge patch 2,
> >> except it probably does not even apply as it is written in a way that is
> >> based on the changes in patch 1.
> >>
> >> I could rewrite patch 2 to not depend on patch 1 of course, but it
> >> wouldn't make code simpler, perhaps more complex. And moreover the
> >> hardware that I used to have access to has phy_count==1 so I could never
> >> test the failing case, and sadly now I have no access to that hardware.
> >
> > Hi Luca,
> >
> > The fw_devlink code to create device links from consumers to "phys"
> > suppliers is pretty well exercised. Most/all Android devices running
> > 5.10+ kernels (including Pixel 6) use fw_devlink=on to be able to boot
> > properly.
> >
> > So I'd be pretty confident in deleting the device_link_add/del() code
> > in drivers/pci/controller/dwc/pci-dra7xx.c. The device links should
> > already be there before the probe is even called.
> >
> > Also, if you want to check if the device links (even the 1 phy one you
> > have) are being created, you can look at /sys/class/devlink to see the
> > list of all device links that are currently present. You can delete
> > the code and then use this to check too.
>
> Thank you for your feedback. Unfortunately as I said I have no access to
> the hardware, and won't have anymore. I don't think it is a good idea to
> send a patch that I cannot test on real hardware, especially since it is
> for a generic hardware that thus might affect others. But I would be
> glad to review any such patch that might be sent, FWIW.

Just to make sure I'm on the same page. I thought you at least had a
device where phy_count = 1. But looks like you are saying you don't?

If all you want to check is "phys" have device links created for them
for whatever random DT device that has a "phys" property, then I can
test and confirm that for you on whatever platform I have. But if you
want a test specifically for the device that corresponds to the driver
you were fixing, then I can't. Let me know.

-Saravana

>
> --
> Luca
