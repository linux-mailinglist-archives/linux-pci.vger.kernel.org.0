Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC47A72E5C3
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jun 2023 16:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242723AbjFMOax convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 13 Jun 2023 10:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242923AbjFMOav (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Jun 2023 10:30:51 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C68E54;
        Tue, 13 Jun 2023 07:30:49 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-977c8baa86fso164779366b.0;
        Tue, 13 Jun 2023 07:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686666648; x=1689258648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YURfXoA9EnnMo68ZYKa4kiRuIo5moA7Y1uftgx6iJwA=;
        b=RCxGwVwZqxKK2xT2BmqG/yMKFvF7zFUqEc0W66xZjsvrK6xM/59T0182NoTwcgOvWC
         5aQpxM1ocCgUAm2EsJ9QJojh2tHT6aA/8/25X8ALdSC/EAB49HKUFHPFqejR6+St1XHn
         ycIJfYXTXunOBGHy2S0ZR3bKil9FEd6uSiBLw3u92Qrp+tsW2tfrdIJDrZ3bZ9MOOtJ9
         7q6YKIpbpkEH4+9CvlqoFhXamUN+uLaRsRj3wnXGVQ/vUWCb61A9Ygaxi2+KF9dBbZLV
         abUx/d4tmhRYagUFQufftF9cOqDBU9S44ojax/74uEw72S/eNZ2e5qQWP1ERi37ciIUw
         ozVg==
X-Gm-Message-State: AC+VfDxrbgMOm7pP9HUinAZxRPn4dW+vKBZZHwjbsOqkQJKJxrXLhPr5
        Ptx76jnn3kk//J9GkCTb1jlQwv2jgOwtapOsokA=
X-Google-Smtp-Source: ACHHUZ7hCEWJk93F76YlCbntVRHMehTTh0L+mXEP2lWbT0ryghEkQmiS61u5qbybIuq175LdkwHPhy73H/Ocs06GfBY=
X-Received: by 2002:a17:906:7a41:b0:975:942b:ee43 with SMTP id
 i1-20020a1709067a4100b00975942bee43mr11202017ejo.5.1686666647511; Tue, 13 Jun
 2023 07:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230609023038.61388-1-zhiren.chen@mediatek.com>
 <20230609114920.GA1242120@bhelgaas> <CAJZ5v0iiAGGuzjT1-ZmCaUT9CH4uXaDG9XQ1QmKbp-bnCjEF6w@mail.gmail.com>
 <f2b93387ab364758a14774e4310c80ae8a0daeab.camel@mediatek.com>
In-Reply-To: <f2b93387ab364758a14774e4310c80ae8a0daeab.camel@mediatek.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 13 Jun 2023 16:30:34 +0200
Message-ID: <CAJZ5v0iRY1PVbKHMpLxZozmK_hDvx+0SZrnbFWkDs_7O6D_fYw@mail.gmail.com>
Subject: Re: [PATCH] PCI:PM: Support platforms that do not implement ACPI
To:     =?UTF-8?B?WmhpcmVuIENoZW4gKOmZiOW/l+S7gSk=?= 
        <Zhiren.Chen@mediatek.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        =?UTF-8?B?SGFpanVuIExpdSAo5YiY5rW35YabKQ==?= 
        <haijun.liu@mediatek.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        =?UTF-8?B?TWluZ2NodWFuZyBRaWFvICjkuZTmmI7pl68p?= 
        <Mingchuang.Qiao@mediatek.com>,
        =?UTF-8?B?TGFtYmVydCBXYW5nICjnjovkvJ8p?= 
        <Lambert.Wang@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 13, 2023 at 9:57 AM Zhiren Chen (陈志仁)
<Zhiren.Chen@mediatek.com> wrote:
>
> On Fri, 2023-06-09 at 19:58 +0200, Rafael J. Wysocki wrote:
> >
> >  On Fri, Jun 9, 2023 at 1:49 PM Bjorn Helgaas <helgaas@kernel.org>
> > wrote:
> > >
> > > [+cc Rafael, linux-pm]
> > >
> > > On Fri, Jun 09, 2023 at 10:30:38AM +0800, Zhiren Chen wrote:
> > > > From: Zhiren Chen <Zhiren.Chen@mediatek.com>
> > > >
> > > > The platform_pci_choose_state function and other low-level
> > platform
> > > > interfaces used by PCI power management processing did not take
> > into
> > > > account non-ACPI-supported platforms. This shortcoming can result
> > in
> > > > limitations and issues.
> > > >
> > > > For example, in embedded systems like smartphones, a PCI device
> > can be
> > > > shared by multiple processors for different purposes. The PCI
> > device and
> > > > some of the processors are controlled by Linux, while the rest of
> > the
> > > > processors runs its own operating system.
> > > > When Linux initiates system-level sleep, if it does not consider
> > the
> > > > working state of the shared PCI device and forcefully sets the
> > PCI device
> > > > state to D3, it will affect the functionality of other processors
> > that
> > > > are currently using the PCI device.
> > > >
> > > > To address this problem, an interface should be created for PCI
> > devices
> > > > that don't support ACPI to enable accurate reporting of the power
> > state
> > > > during the PCI PM handling process.
> > > >
> > > > Signed-off-by: Zhiren Chen <Zhiren.Chen@mediatek.com>
> >
> > Something like the pci_platform_pm_ops introduced here had been there
> > for several years and the only users of it known to me were ACPI and
> > Intel MID, which is why it was dropped.
> >
> > I would like to see the platform code using these new callbacks in
> > the
> > first place.
> >
> I think that more and more embedded products will use PCI devices to
> achieve higher performance for data transfer, and these products may
> not necessarily support ACPI.
>
> When developing the Mediatek T8xx modem chip driver, I found that there
> was no good way for T8xx to skip D3 setting in certain PM scenarios.

Well, is there any code that you are planning to add to the mainline
Linux kernel that is going to use the proposed interface?

If not, the interface itself will not be useful in the mainline Linux kernel.
