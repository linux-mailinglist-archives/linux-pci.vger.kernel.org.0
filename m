Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6FD4E1F15
	for <lists+linux-pci@lfdr.de>; Mon, 21 Mar 2022 03:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344212AbiCUCk1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Mar 2022 22:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238487AbiCUCk0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Mar 2022 22:40:26 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27121DA49
        for <linux-pci@vger.kernel.org>; Sun, 20 Mar 2022 19:39:01 -0700 (PDT)
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3D5DE3F21D
        for <linux-pci@vger.kernel.org>; Mon, 21 Mar 2022 02:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647830334;
        bh=iHeI4Li4UlP93b9NJtNDxcZHhK1vAIlk+zBGGpgqVZ0=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=t1xI6W8KL5Vxfi9VtzTcRJg0Ufi2yzqervORRIqYwXypA5HBp05IjNvYinf4d+du7
         VmrGkOTd5MYMtqITAdx5u6vrUFm1A6fuii63oJ/J9uiuZKnYMqvPm4J7J+fMVvbfm5
         TwIBceku8rCded4V+o3hfOVFMd0LTFXJCc+ZN0CC7XJ4uHTuZH+oRtDK8fe+U9mmQz
         4LoGyZsvLTJfTvXLlZ1fwAcu2+yc22rqC6JvTHYSEUgpdzofdqa5fItUEVkrMmp76B
         8L2a7uT3uhlubpoklhd7FWOd6hO3eXIPYP8DfTAgSlLQUKqsIpY/Kcfb5LotflWGwk
         AG5/epvYiscjA==
Received: by mail-ot1-f72.google.com with SMTP id n7-20020a9d4d07000000b005b2389a99cfso7280893otf.17
        for <linux-pci@vger.kernel.org>; Sun, 20 Mar 2022 19:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iHeI4Li4UlP93b9NJtNDxcZHhK1vAIlk+zBGGpgqVZ0=;
        b=yAf8NB2XJo+4gThv+hfsCjg81pkbgGfMVUI5b1LUkIXevHlAbayr/VDt/dhRLLOkNS
         nBpx7RRGt1pEtggYcHP8PVgQf5mgKsto/qpX7ae97t1ZHwNKZAbKup3lC/LBkG6wqGw4
         7sGBiqDoGWjuKQ2/uftn1Nm2njTaPTK4iqz/H9QdrvzJXQqmRdo/T8X/h/VWUsufAOo6
         +ovvYtM42hia6OFGpYCCDc4oaAyOVRSVdkY4tgCdQCjsOk+KcZWf+O2JXQb6toByqCsF
         tpTheDDGE6nTR76ZxgB3UvBD+ttPN2JTSmkKQgQUo/4WkhXXTg+DJKs6iktGM4vlvXPB
         hvqg==
X-Gm-Message-State: AOAM533QTnwthRimqzCSmo9uRfnbor+JfrKz5f6/n2Jrjrom2JoWkJLZ
        INj1DX25YBrk1kMF8QSYBdZMldhX7lq5bz9pDQI3p4KjOIFKQ4XSGPYe4wFt6do36LMR7VoOl0P
        ZmRcdMQXAbbgMTLbF5opo5i6CfHU1VqV8BxXjErww9e0g1bSQPUeu7w==
X-Received: by 2002:a05:6808:1a97:b0:2ec:a246:ad01 with SMTP id bm23-20020a0568081a9700b002eca246ad01mr12887368oib.54.1647830330726;
        Sun, 20 Mar 2022 19:38:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjDOKXSViaQfhEChkSFuWe9zr8ywxKQSBCSo0Be72wPBCEEfWDVVovfp/J+gN4VMKEQCAGYLCs/0mFC/qTjVg=
X-Received: by 2002:a05:6808:1a97:b0:2ec:a246:ad01 with SMTP id
 bm23-20020a0568081a9700b002eca246ad01mr12887355oib.54.1647830330410; Sun, 20
 Mar 2022 19:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220127025418.1989642-1-kai.heng.feng@canonical.com> <427f19c6-32f0-684e-5fdd-2e5ed192b71d@linux.intel.com>
In-Reply-To: <427f19c6-32f0-684e-5fdd-2e5ed192b71d@linux.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 21 Mar 2022 10:38:39 +0800
Message-ID: <CAAd53p6ZrFNhtKk=9wz8SF68jBuNajKgOzZFgHgKgd57Zp3pHg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI/AER: Disable AER service when link is in L2/L3
 ready, L2 and L3 state
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     bhelgaas@google.com, mika.westerberg@linux.intel.com,
        koba.ko@canonical.com, Russell Currey <ruscur@russell.cc>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Mar 20, 2022 at 4:38 AM Sathyanarayanan Kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 1/26/22 6:54 PM, Kai-Heng Feng wrote:
> > Commit 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in
> > hint") enables ACS, and some platforms lose its NVMe after resume from
>
> Why enabling ACS makes platform lose NVMe? Can you add more details
> about the problem?

I don't have a hardware analyzer, so the only detail I can provide is
the symptom.
I believe the affected system was sent Intel, and there wasn't any
feedback since then.

>
> > S3:
> > [   50.947816] pcieport 0000:00:1b.0: DPC: containment event, status:0x1f01 source:0x0000
> > [   50.947817] pcieport 0000:00:1b.0: DPC: unmasked uncorrectable error detected
> > [   50.947829] pcieport 0000:00:1b.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Receiver ID)
> > [   50.947830] pcieport 0000:00:1b.0:   device [8086:06ac] error status/mask=00200000/00010000
> > [   50.947831] pcieport 0000:00:1b.0:    [21] ACSViol                (First)
> > [   50.947841] pcieport 0000:00:1b.0: AER: broadcast error_detected message
> > [   50.947843] nvme nvme0: frozen state error detected, reset controller
> >
> > It happens right after ACS gets enabled during resume.
> >
> > There's another case, when Thunderbolt reaches D3cold:
> > [   30.100211] pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: 0000:00:1d.0
> > [   30.100251] pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> > [   30.100256] pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
> > [   30.100262] pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
> > [   30.100267] pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 08000052 00000000 00000000
> > [   30.100372] thunderbolt 0000:0a:00.0: AER: can't recover (no error_detected callback)
>
> no callback message means one or more devices in the given port does not
> support error handler. How is this related to ACS?

This case is about D3cold, not related to ACS.
And no error_detected is just part of the message. The whole AER
message is more important.

Kai-Heng

>
> > [   30.100401] xhci_hcd 0000:3e:00.0: AER: can't recover (no error_detected callback)
> > [   30.100427] pcieport 0000:00:1d.0: AER: device recovery failed
> >
> > So disable AER service to avoid the noises from turning power rails
> > on/off when the device is in low power states (D3hot and D3cold), as
> > PCIe spec "5.2 Link State Power Management" states that TLP and DLLP
> > transmission is disabled for a Link in L2/L3 Ready (D3hot), L2 (D3cold
> > with aux power) and L3 (D3cold).
> >
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=209149
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215453
> > Fixes: 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in hint")
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v2:
> >   - Wording change.
> >
> >   drivers/pci/pcie/aer.c | 31 +++++++++++++++++++++++++------
> >   1 file changed, 25 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index 9fa1f97e5b270..e4e9d4a3098d7 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -1367,6 +1367,22 @@ static int aer_probe(struct pcie_device *dev)
> >       return 0;
> >   }
> >
> > +static int aer_suspend(struct pcie_device *dev)
> > +{
> > +     struct aer_rpc *rpc = get_service_data(dev);
> > +
> > +     aer_disable_rootport(rpc);
> > +     return 0;
> > +}
> > +
> > +static int aer_resume(struct pcie_device *dev)
> > +{
> > +     struct aer_rpc *rpc = get_service_data(dev);
> > +
> > +     aer_enable_rootport(rpc);
> > +     return 0;
> > +}
> > +
> >   /**
> >    * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
> >    * @dev: pointer to Root Port, RCEC, or RCiEP
> > @@ -1433,12 +1449,15 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
> >   }
> >
> >   static struct pcie_port_service_driver aerdriver = {
> > -     .name           = "aer",
> > -     .port_type      = PCIE_ANY_PORT,
> > -     .service        = PCIE_PORT_SERVICE_AER,
> > -
> > -     .probe          = aer_probe,
> > -     .remove         = aer_remove,
> > +     .name                   = "aer",
> > +     .port_type              = PCIE_ANY_PORT,
> > +     .service                = PCIE_PORT_SERVICE_AER,
> > +     .probe                  = aer_probe,
> > +     .suspend                = aer_suspend,
> > +     .resume                 = aer_resume,
> > +     .runtime_suspend        = aer_suspend,
> > +     .runtime_resume         = aer_resume,
> > +     .remove                 = aer_remove,
> >   };
> >
> >   /**
>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
