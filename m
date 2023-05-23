Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A353370E438
	for <lists+linux-pci@lfdr.de>; Tue, 23 May 2023 20:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbjEWSHR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 May 2023 14:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238180AbjEWSHP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 May 2023 14:07:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F0197
        for <linux-pci@vger.kernel.org>; Tue, 23 May 2023 11:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684865190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SG2XCSWG0GUXh4a7boUJOB62oZ1UHvd8/4f8ByVuALo=;
        b=PvZ9OxBkVWTEniYSyHUVHstt1vPWVkBruZtaRtRZ+N9UJf7nhjaX//iCsA8EBYprpZy5Aq
        KlzWn8boTx/XOcmd3Ozloxlv/HPNZk1U5fbgD5WWAn8N7qRQqjolmZsGaNyGEqDECmX6jW
        XcrqLxBs9lhaTR/rjRtIkf/hfjsdxvU=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-Aqkc340SOdenUmcEb_Xf-w-1; Tue, 23 May 2023 14:06:29 -0400
X-MC-Unique: Aqkc340SOdenUmcEb_Xf-w-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-76c56492fa0so7655339f.2
        for <linux-pci@vger.kernel.org>; Tue, 23 May 2023 11:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684865188; x=1687457188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SG2XCSWG0GUXh4a7boUJOB62oZ1UHvd8/4f8ByVuALo=;
        b=jc+wajGAxb/vwgFIwHxaD/+mjqLf/UQXaTgaVoIo/ArRZbQ50/F6dJVMHlpuno8x7H
         F/r9QU7GYKJnrkvZgfHdiNPSDgNl9z+lPVW63vAHmJsEzqjuFOElBasJz6hFKYgJH4c2
         UQeuJ6DRFEQngYbzE9ijAGM+pNei8YNSSCkWuEbcnAP808sbPW2orbjUDRXnl80tIshy
         BgNDa5qL52VRZGhatsccuk9zhHc4Fr1pMJelR6pKTExB3sKpz7p3KFmwinx1OKCjAm5q
         uswgMQKTICYPyJRJeCCtA07V1+p4uTkt1BQLZe1Af74uSDSU+ZgIKvzTIebw8Y+7A03j
         1P0Q==
X-Gm-Message-State: AC+VfDwMIY3GhV1I6ukCamFa78QoH6ZiKHEfr58riGBJ/CFYqhYNA5UH
        7tJjqSnargfKO+Exnp6/0M5YOPKDZnyXVeJimGoPqXj9WfJZSGwJJ39pGbHIyrq9bTykJb/T5ND
        9V6o34aUo6V87YGNGL/X7
X-Received: by 2002:a5d:9499:0:b0:774:8176:6e20 with SMTP id v25-20020a5d9499000000b0077481766e20mr2131561ioj.21.1684865188466;
        Tue, 23 May 2023 11:06:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6DtVEwkEI5aNETNJ3Rca8ixXfaH9IgtR2PLMVrIfsiDmIeMO0mu5OmcabBctnp3iipzNnDag==
X-Received: by 2002:a5d:9499:0:b0:774:8176:6e20 with SMTP id v25-20020a5d9499000000b0077481766e20mr2131554ioj.21.1684865188218;
        Tue, 23 May 2023 11:06:28 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id w8-20020a056638138800b0041658c1838asm2684880jad.81.2023.05.23.11.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 11:06:27 -0700 (PDT)
Date:   Tue, 23 May 2023 12:06:26 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, kvm@vger.kernel.org,
        linux-acpi@vger.kernel.org, Nirmal Patel <nirmal.patel@intel.com>
Subject: Re: [Bug 217472] New: ACPI _OSC features have different values in
 Host OS and Guest OS
Message-ID: <20230523120626.5b76d289.alex.williamson@redhat.com>
In-Reply-To: <ZGz2FQpHPKYgcc0+@bhelgaas>
References: <bug-217472-41252@https.bugzilla.kernel.org/>
        <ZGz2FQpHPKYgcc0+@bhelgaas>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 23 May 2023 12:21:25 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> Hi Nirmal, thanks for the report!
> 
> On Mon, May 22, 2023 at 04:32:03PM +0000, bugzilla-daemon@kernel.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=217472
> > ...  
> 
> > Created attachment 304301  
> >   --> https://bugzilla.kernel.org/attachment.cgi?id=304301&action=edit  
> > Rhel9.1_Guest_dmesg
> > 
> > Issue:
> > NVMe Drives are still present after performing hotplug in guest OS. We have
> > tested with different combination of OSes, drives and Hypervisor. The issue is
> > present across all the OSes.   
> 
> Maybe attach the specific commands to reproduce the problem in one of
> these scenarios to the bugzilla?  I'm a virtualization noob, so I
> can't visualize all the usual pieces.
> 
> > The following patch was added to honor ACPI _OSC values set by BIOS and the
> > patch helped to bring the issue out in VM/ Guest OS.
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/drivers/pci/controller/vmd.c?id=04b12ef163d10e348db664900ae7f611b83c7a0e
> > 
> > 
> > I also compared the values of the parameters in the patch in Host and Guest OS.
> > The parameters with different values in Host and Guest OS are:
> > 
> > native_pcie_hotplug
> > native_shpc_hotplug
> > native_aer
> > native_ltr
> > 
> > i.e.
> > value of native_pcie_hotplug in Host OS is 1.
> > value of native_pcie_hotplug in Guest OS is 0.
> > 
> > I am not sure why "native_pcie_hotplug" is changed to 0 in guest.
> > Isn't it OSC_ managed parameter? If that is the case, it should
> > have same value in Host and Guest OS.  
> 
> From your dmesg:
> 
>   DMI: Red Hat KVM/RHEL, BIOS 1.16.0-4.el9 04/01/2014
>   _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
>   _OSC: platform does not support [PCIeHotplug LTR DPC]
>   _OSC: OS now controls [SHPCHotplug PME AER PCIeCapability]
>   acpiphp: Slot [0] registered
>   virtio_blk virtio3: [vda] 62914560 512-byte logical blocks (32.2 GB/30.0 GiB)
> 
> So the DMI ("KVM/RHEL ...") is the BIOS seen by the guest.  Doesn't
> mean anything to me, but the KVM folks would know about it.  In any
> event, the guest BIOS is different from the host BIOS, so I'm not
> surprised that _OSC is different.

Right, the premise of the issue that guest and host should have the
same OSC features is flawed.  The guest is a virtual machine that can
present an entirely different feature set from the host.  A software
hotplug on the guest can occur without any bearing to the slot status
on the host.

> That guest BIOS _OSC declined to grant control of PCIe native hotplug
> to the guest OS, so the guest will use acpiphp (not pciehp, which
> would be used if native_pcie_hotplug were set).
> 
> The dmesg doesn't mention the nvme driver.  Are you using something
> like virtio_blk with qemu pointed at an NVMe drive?  And you
> hot-remove the NVMe device, but the guest OS thinks it's still
> present?
> 
> Since the guest is using acpiphp, I would think a hot-remove of a host
> NVMe device should be noticed by qemu and turned into an ACPI
> notification that the guest OS would consume.  But I don't know how
> those connections work.

If vfio-pci is involved, a cooperative hot-unplug will attempt to
unbind the host driver, which triggers a device request through vfio,
which is ultimately seen as a hotplug eject operation by the guest.
Surprise hotplugs of assigned devices are not supported.  There's not
enough info in the bz to speculate how this VM is wired or what actions
are taken.  Thanks,

Alex

