Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D007A685E
	for <lists+linux-pci@lfdr.de>; Tue, 19 Sep 2023 17:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjISPwv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 19 Sep 2023 11:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjISPwu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2023 11:52:50 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65309C
        for <linux-pci@vger.kernel.org>; Tue, 19 Sep 2023 08:52:44 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5769a4d011cso325284eaf.0
        for <linux-pci@vger.kernel.org>; Tue, 19 Sep 2023 08:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695138764; x=1695743564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNUl6+nNucaY1dQ/CAONQomJVNWTljkCY0sco+4NaWg=;
        b=mAojXhY/7TU+RajQaeE3ehafEvQmccGY949vV7rkbt0Wby/TEkBzGGE1L0/TzEYNtD
         1LfuK1hfpp2WU1J05vN21zwI1Jd56DkMYC97Toa1XEUQHu+iIf8M7Ll7aFzRgB0Lt1+5
         rpZaWZ/aGvE1hQYeJ9r3+V7mMUOXz7dHZ++iYKnokduG4/RvkWzLG4FcvjbOWKoospyZ
         bAOdVEB8urV5TRSVpZAG7w1LHZhdgnA0lT4Of5sKQyfHnIQpsdsXHLqWs8NOLynz5L/o
         06j/X0t9BuvjYB7xLNdc+2R50u6FhCDlDRAU7hleMkLDvCvoAVvMFEURcPojj9S56x5X
         3+Ww==
X-Gm-Message-State: AOJu0YxCDxshQCu73MZT8gxJa33EAQ++mrQ6Zc/5KHSMep0S7GsYO5Ky
        bGJu/SRuozNsdBHDN0sqrCGZr/77SWVcodw8Z+E=
X-Google-Smtp-Source: AGHT+IFfVYkisVcm7ff7KHAULXtij/X9RoTCu6QBXP6Gw6Jj8tNGff7XSoxzLHifkD3H5px8lMh1SOsqYRUvudQf23k=
X-Received: by 2002:a4a:dc93:0:b0:573:4a72:6ec with SMTP id
 g19-20020a4adc93000000b005734a7206ecmr12613999oou.1.1695138764078; Tue, 19
 Sep 2023 08:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAAd53p45+jxCE-tnr-Mb2YOnDwppv7GYmp+usYehO87s33qpjg@mail.gmail.com>
 <20230919143446.GA226696@bhelgaas>
In-Reply-To: <20230919143446.GA226696@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Sep 2023 17:52:33 +0200
Message-ID: <CAJZ5v0jCrYA8UX8OXLgv1NLZGRevYHdOBu8FN0i+HHi8+XDuxw@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: vmd: Do not change the BIOS Hotplug setting on
 VMD rootports
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Patel, Nirmal" <nirmal.patel@linux.intel.com>,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 19, 2023 at 4:34 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Sep 19, 2023 at 11:31:57AM +0800, Kai-Heng Feng wrote:
> > On Wed, Sep 13, 2023 at 8:50 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > [snipped]
> > > Hmm.  In some ways the VMD device acts as a Root Port, since it
> > > originates a new hierarchy in a separate domain, but on the upstream
> > > side, it's just a normal endpoint.
> > >
> > > How does AER for the new hierarchy work?  A device below the VMD can
> > > generate ERR_COR/ERR_NONFATAL/ERR_FATAL messages.  I guess I was
> > > assuming those messages would terminate at the VMD, and the VMD could
> > > generate an AER interrupt just like a Root Port.  But that can't be
> > > right because I don't think VMD would have the Root Error Command
> > > register needed to manage that interrupt.
> >
> > VMD itself doesn't seem to manage AER, the rootport that "moved" from
> > 0000 domain does:
> > [ 2113.507345] pcieport 10000:e0:06.0: AER: Corrected error received:
> > 10000:e1:00.0
> > [ 2113.507380] nvme 10000:e1:00.0: PCIe Bus Error: severity=Corrected,
> > type=Physical Layer, (Receiver ID)
> > [ 2113.507389] nvme 10000:e1:00.0:   device [144d:a80a] error
> > status/mask=00000001/0000e000
> > [ 2113.507398] nvme 10000:e1:00.0:    [ 0] RxErr                  (First)
>
> Oh, I forgot how VMD works.  It sounds like there *is* a Root Port
> that is logically below the VMD, e.g., (from
> https://bugzilla.kernel.org/show_bug.cgi?id=215027):
>
>   ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-e0])
>   acpi PNP0A08:00: _OSC: platform does not support [AER]
>   acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME PCIeCapability LTR]
>   pci  0000:00:0e.0: [8086:467f] type 00         # VMD
>   vmd  0000:00:0e.0: PCI host bridge to bus 10000:e0
>   pci 10000:e0:06.0: [8086:464d] type 01         # Root Port to [bus e1]
>   pci 10000:e1:00.0: [144d:a80a] type 00         # Samsung NVMe
>
> So ERR_* messages from the e1:00.0 Samsung device would terminate at
> the e0:06.0 Root Port.  That Root Port has an AER Capability with Root
> Error Command/Status/Error Source registers.
>
> > > But if VMD just passes those messages up to the Root Port, the source
> > > of the messages (the Requester ID) won't make any sense because
> > > they're in a hierarchy the Root Port doesn't know anything about.
> >
> > Not sure what's current status is but I think Nirmal's patch is valid
> > for both our cases.
>
> So I think the question is whether that PNP0A08:00 _OSC applies to
> domain 10000.  I think the answer is "no" because the platform doesn't
> know about the existence of domain 10000, and it can't access config
> space in that domain.

Well, the VMD device itself is there in domain 0000, however, and sure
enough, the platform firmware can access its config space.

> E.g., if _OSC negotiated that the platform owned AER in domain 0000, I
> don't think it would make sense for that to mean the platform *also*
> owned AER in domain 10000, because the platform doesn't know how to
> configure AER or handle AER interrupts in that domain.

I'm not sure about this.

AFAICS, domain 10000 is not physically independent of domain 0000, so
I'm not sure to what extent the above applies.

> Nirmal's patch ignores _OSC for hotplug, but keeps the _OSC results
> for AER, PME, and LTR.  I think we should ignore _OSC for *all* of
> them.
>
> That would mean reverting 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on
> PCIe features") completely, so of course we'd have to figure out how
> to resolve the AER message flood a different way.

I agree with the above approach, however.
