Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04F0673A9D
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 14:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjASNnj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 08:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjASNng (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 08:43:36 -0500
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70427C844;
        Thu, 19 Jan 2023 05:43:34 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id u19so5728592ejm.8;
        Thu, 19 Jan 2023 05:43:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0A+XhGIxQLpGUQDYUIz3Czp9kHT/k7XRj/Cx2TSYIhM=;
        b=LN/3Xawan85iq4t3556gPVkXNi73cWSqN6AP6hGu/5Ees26vN44w6j1EBJd+C4jJaB
         P1CQxVBYEUWBTolsSjQYCbdsZO3IVtDYsUHxDEZTANbjKUKLt2MOLdJ5XwJUYx+mY4Il
         lFDcuTT94KBSlmVVKohqdE9GWvp9GkWIrxcGpKGCswT9IDpWCZDsbV3QfndhzrtGWOyX
         Xnc30coeLagxKP2Ca2jeBdZ6UjvAPKAsvXV+LQFzpsMYGjbOEUOnLEyAsHPT8Veq5/4y
         w+vE9nZq897OcQrNjSnmk+0GrHuKMdDSeBzX9eangLbykdSFjH9fAt9bMG+7uaojVZLJ
         /uKg==
X-Gm-Message-State: AFqh2kpEDVa5vQjWGcngrAq3UkDeAda2MunlNjcuzbDiMg+JVNhJPc0/
        aHd1BiJ5k7HY/zZ9VgtmYx5Qd86o0rJ4kDf1WQU=
X-Google-Smtp-Source: AMrXdXuAPeW0SzCf1VtCCrVidSKhYHc3/vFTWREXgBLbnSi0wVMVeYsMK9KUp5fxCn3sLHwwQLmI6kkSGEVTQkD39Bc=
X-Received: by 2002:a17:906:3283:b0:84d:4b8e:efc with SMTP id
 3-20020a170906328300b0084d4b8e0efcmr761067ejw.390.1674135813155; Thu, 19 Jan
 2023 05:43:33 -0800 (PST)
MIME-Version: 1.0
References: <20230119013602.607466-1-tianfei.zhang@intel.com> <Y8lGxqjuLS8NfJtg@kroah.com>
In-Reply-To: <Y8lGxqjuLS8NfJtg@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 Jan 2023 14:43:21 +0100
Message-ID: <CAJZ5v0jW28k5+CN_F4dLo=OzVVJEL+U=gW4bzeSPjU=j53BJKg@mail.gmail.com>
Subject: Re: [PATCH v1 00/12] add FPGA hotplug manager driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Tianfei Zhang <tianfei.zhang@intel.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-fpga@vger.kernel.org,
        lukas@wunner.de, kabel@kernel.org, mani@kernel.org,
        pali@kernel.org, mdf@kernel.org, hao.wu@intel.com,
        yilun.xu@intel.com, trix@redhat.com, jgg@ziepe.ca,
        ira.weiny@intel.com, andriy.shevchenko@linux.intel.com,
        dan.j.williams@intel.com, keescook@chromium.org, rafael@kernel.org,
        russell.h.weight@intel.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
        lee@kernel.org, matthew.gerlach@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 19, 2023 at 2:34 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 18, 2023 at 08:35:50PM -0500, Tianfei Zhang wrote:
> > This patchset introduces the FPGA hotplug manager (fpgahp) driver which
> > has been verified on the Intel N3000 card.
> >
> > When a PCIe-based FPGA card is reprogrammed, it temporarily disappears
> > from the PCIe bus. This needs to be managed to avoid PCIe errors and to
> > reprobe the device after reprogramming.
> >
> > To change the FPGA image, the kernel burns a new image into the flash on
> > the card, and then triggers the card BMC to load the new image into FPGA.
> > A new FPGA hotplug manager driver is introduced that leverages the PCIe
> > hotplug framework to trigger and manage the update of the FPGA image,
> > including the disappearance and reappearance of the card on the PCIe bus.
> > The fpgahp driver uses APIs from the pciehp driver. Two new operation
> > callbacks are defined in hotplug_slot_ops:
> >
> >   - available_images: Optional: available FPGA images
> >   - image_load: Optional: trigger the FPGA to load a new image
> >
> >
> > The process of reprogramming an FPGA card begins by removing all devices
> > associated with the card that are not required for the reprogramming of
> > the card. This includes PCIe devices (PFs and VFs) associated with the
> > card as well as any other types of devices (platform, etc.) defined within
> > the FPGA. The remaining devices are referred to here as "reserved" devices.
> > After triggering the update of the FPGA card, the reserved devices are also
> > removed.
> >
> > The complete process for reprogramming the FPGA are:
> >     1. remove all PFs and VFs except for PF0 (reserved).
> >     2. remove all non-reserved devices of PF0.
> >     3. trigger FPGA card to do the image update.
> >     4. disable the link of the hotplug bridge.
> >     5. remove all reserved devices under hotplug bridge.
> >     6. wait for image reload done via BMC, e.g. 10s.
> >     7. re-enable the link of hotplug bridge
> >     8. enumerate PCI devices below the hotplug bridge
> >
> > usage example:
> > [root@localhost]# cd /sys/bus/pci/slot/X-X/
> >
> > Get the available images.
> > [root@localhost 2-1]# cat available_images
> > bmc_factory bmc_user retimer_fw
> >
> > Load the request images for FPGA Card, for example load the BMC user image:
> > [root@localhost 2-1]# echo bmc_user > image_load
>
> Why is all of this tied into the pci hotplug code? Shouldn't it be
> specific to this one driver instead?  pci hotplug is for removing/adding
> PCI devices to the system, not messing with FPGA images.
>
> This feels like an abuse of the pci hotplug bus to me as this is NOT
> really a PCI hotplug bus at all, right?
>
> Or is it?  If so, then the slots should show up under the PCI device
> itself, not in /sys/bus/pci/slot/.  That location is there for old old
> stuff, we probably should move it one of these days as there's lots of
> special-cases in the driver core just because of that :(

I'm not sure if I can agree with this statement.

The slot here is what is registered via pci_hp_register(), isn't it?

There are multiple users of this in the tree, including ACPI-based PCI
hotplug, which is not really that old.

Are you saying that this should not be used?
