Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2824510516
	for <lists+linux-pci@lfdr.de>; Tue, 26 Apr 2022 19:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbiDZRSm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Apr 2022 13:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236951AbiDZRRD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Apr 2022 13:17:03 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9911A220CE
        for <linux-pci@vger.kernel.org>; Tue, 26 Apr 2022 10:13:54 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id g3so15961131pgg.3
        for <linux-pci@vger.kernel.org>; Tue, 26 Apr 2022 10:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=COISYBtLemURzEtVRJTSOaoU1kvxhQruqFG2UXo9XUw=;
        b=ICQKMM5VJ8dZCmZ5IDftKBD0tk2p/btzOGUR1kYXd/zFRS/EkvTLCpPCF1BWQ1lKzH
         Bqh4vxvd9/HnKEhvMjZIYnNj2yFTyCqWnJW+u9sWIKXgfunEJOyiAGcoiGom0Fjw4+ka
         PLtm7GIGMzzUN3ttrb56TQfPJKwV2PasGCyTFseghYcMYWl+0iS+YumxymWwxECcFY1g
         JRdSZQT+i9TCp8T5DDInsYfDjIyKVFo702VauqiPnw8KYNWqo4U3LUZim+g67CUif1E7
         I2M4VxY3Hs8iCvYzmtDEU4yfuI4Q/MIIivgirMZZUMt0ThznOwHSbGUBfWZwJDUpmo8/
         B/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=COISYBtLemURzEtVRJTSOaoU1kvxhQruqFG2UXo9XUw=;
        b=fpJmgK6oPctHYsFCEYYeYD4gZOrsFbqJoG3UWXsMyl5r1q1kQ1tkvbmHafzb1kDKX7
         PJT3pPm5qISftl7o1rcAq0vvai3zOIOYY7HaPUn3DeyNlVCMMSLceIzmVNY9HoXNRgXE
         fqSBm8bJrAfKUryi2WPoo8PThcxjEejvMem0MFo+O+MMVU47zSV9wSEXcx+p9USfiRic
         WohLn3zb2Cwub/63XCxOgInph/WPksYdqfZQoYpUCcAt5lhr2xBy+6O1aFz4RxijgVoM
         ox01Hg+jKRrztt6czoAqbdlU4BFQE6G7NKtrTDUgaxr321yT5tlkcZXQcJIlx4jzNekN
         gjiw==
X-Gm-Message-State: AOAM530oSJABFPMvqYt1b/2t2H8BtkZ4HFmvJKFLnLhBUvaqcrYnrmcU
        X3qhJxhE7ywPVJsPWTBEtPgmHpX347dzGDbchL+q0Q==
X-Google-Smtp-Source: ABdhPJw0Ra1dMBKYFZkjWanWW4cefxv2B97eXQvw3FrcmpDznbuhiQB1ig3w2zhaYU9CkF8BOrp7P30WHnRXgF9Udfk=
X-Received: by 2002:a62:fb0e:0:b0:505:fd9e:9218 with SMTP id
 x14-20020a62fb0e000000b00505fd9e9218mr26023121pfm.78.1650993233860; Tue, 26
 Apr 2022 10:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220426000640.3581446-1-rajatja@google.com> <030f48f4-44d7-c04c-a194-5f4999873ebe@arm.com>
In-Reply-To: <030f48f4-44d7-c04c-a194-5f4999873ebe@arm.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 26 Apr 2022 10:13:17 -0700
Message-ID: <CACK8Z6GEPTaQKbxeBqQuKbNmVkL1DoHDrKwDeosCeRXfHbD_=w@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] PCI/ACPI: Support Microsoft's "DmaProperty"
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Pavel Machek <pavel@denx.de>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 26, 2022 at 4:15 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-04-26 01:06, Rajat Jain via iommu wrote:
> > The "DmaProperty" is supported and currently documented and used by
> > Microsoft [link 1 below], to flag internal PCIe root ports that need
> > DMA protection [link 2 below]. We have discussed with them and reached
> > a common understanding that they shall change their MSDN documentation
> > to say that the same property can be used to protect any PCI device,
> > and not just internal PCIe root ports (since there is no point
> > introducing yet another property for arbitrary PCI devices). This helps
> > with security from internal devices that offer an attack surface for
> > DMA attacks (e.g. internal network devices).
> >
> > Support DmaProperty to mark DMA from a PCI device as untrusted.
> >
> > Link: [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-internal-pcie-ports-accessible-to-users-and-requiring-dma-protection
> > Link: [2] https://docs.microsoft.com/en-us/windows/security/information-protection/kernel-dma-protection-for-thunderbolt
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> > v6: * Take care of Bjorn's comments:
> >         - Update the commit log
> >         - Rename to pci_dev_has_dma_property()
> >         - Use acpi_dev_get_property()
> > v5: * Reorder the patches in the series
> > v4: * Add the GUID.
> >      * Update the comment and commitlog.
> > v3: * Use Microsoft's documented property "DmaProperty"
> >      * Resctrict to ACPI only
> >
> >   drivers/acpi/property.c |  3 +++
> >   drivers/pci/pci-acpi.c  | 21 +++++++++++++++++++++
> >   2 files changed, 24 insertions(+)
> >
> > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > index 12bbfe833609..bafe35c301ac 100644
> > --- a/drivers/acpi/property.c
> > +++ b/drivers/acpi/property.c
> > @@ -48,6 +48,9 @@ static const guid_t prp_guids[] = {
> >       /* Storage device needs D3 GUID: 5025030f-842f-4ab4-a561-99a5189762d0 */
> >       GUID_INIT(0x5025030f, 0x842f, 0x4ab4,
> >                 0xa5, 0x61, 0x99, 0xa5, 0x18, 0x97, 0x62, 0xd0),
> > +     /* DmaProperty for PCI devices GUID: 70d24161-6dd5-4c9e-8070-705531292865 */
> > +     GUID_INIT(0x70d24161, 0x6dd5, 0x4c9e,
> > +               0x80, 0x70, 0x70, 0x55, 0x31, 0x29, 0x28, 0x65),
> >   };
> >
> >   /* ACPI _DSD data subnodes GUID: dbb8e3e6-5886-4ba6-8795-1319f52a966b */
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index 3ae435beaf0a..d7c6ba48486f 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -1369,12 +1369,33 @@ static void pci_acpi_set_external_facing(struct pci_dev *dev)
> >               dev->external_facing = 1;
> >   }
> >
> > +static int pci_dev_has_dma_property(struct pci_dev *dev)
> > +{
> > +     struct acpi_device *adev;
> > +     const union acpi_object *obj;
> > +
> > +     adev = ACPI_COMPANION(&dev->dev);
> > +     if (!adev)
> > +             return 0;
> > +
> > +     /*
> > +      * Property also used by Microsoft Windows for same purpose,
> > +      * (to implement DMA protection from a device, using the IOMMU).
>
> Nit: there is no context for "same purpose" here, so this comment is
> more confusing than helpful. Might I suggest a rewording like:
>
>         /*
>          * Property used by Microsoft Windows to enforce IOMMU DMA
>          * protection for any device that the system might not fully
>          * trust; we'll honour it the same way.
>          */
>
> ?

Sure, will do.

>
> Personally I think it would have been more logical to handle this in
> pci_set_dma_untrusted(), but I see some of those implementation aspects
> have already been discussed, and Bjorn's preference definitely wins over
> mine here :)

Yes, this was discussed. The primary reason is that ACPI properties
for PCI devices are not available at the time pci_set_untrusted_dma()
is called.

Thanks & Best Regards,

Rajat

>
> Thanks,
> Robin.
>
> > +      */
> > +     if (!acpi_dev_get_property(adev, "DmaProperty", ACPI_TYPE_INTEGER,
> > +                                &obj) && obj->integer.value == 1)
> > +             return 1;
> > +
> > +     return 0;
> > +}
> > +
> >   void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
> >   {
> >       struct pci_dev *pci_dev = to_pci_dev(dev);
> >
> >       pci_acpi_optimize_delay(pci_dev, adev->handle);
> >       pci_acpi_set_external_facing(pci_dev);
> > +     pci_dev->untrusted |= pci_dev_has_dma_property(pci_dev); >      pci_acpi_add_edr_notifier(pci_dev);
> >
> >       pci_acpi_add_pm_notifier(adev, pci_dev);
