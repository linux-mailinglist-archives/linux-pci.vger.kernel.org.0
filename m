Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6404633E8C4
	for <lists+linux-pci@lfdr.de>; Wed, 17 Mar 2021 06:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhCQFIm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Mar 2021 01:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhCQFIj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Mar 2021 01:08:39 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCBFC061760
        for <linux-pci@vger.kernel.org>; Tue, 16 Mar 2021 22:08:39 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id si25so539749ejb.1
        for <linux-pci@vger.kernel.org>; Tue, 16 Mar 2021 22:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pv2yezDm+OU1IwjHViObXuXM6jS96QK+HsvkkHL/Q5o=;
        b=DfqtEoS9iPmdCsX0MXQEqdmijl38E1rCAibyWZeVHBaRtlbsDXLyrsoUNks4WptZDG
         TWLOpbbNHjSlXFKqO2rR5B/VcgD0mdVbY3NroL6/ZCZkePAJbZaPOWNEG9mf0IZ0qGqS
         kU3dvBpBeWTunXFp+vwGsudP2Tqp5YD4M5/JVoPUFwxaImiQqYDVn3EdCEV0sJiUl3Kq
         C5inECa8LS1He9A9nXKUzgNLjqFHpLmyMCmaoC1tLBRochiQ3NYN/lKL1CbKYsf/vJ2g
         uSWn6K+Q2MZKwMVHYnERxidqo3ZofpVbQGmIuQ1G5Gz3uBqB/qMl2ctt3CsvZcoQJxXi
         Jwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pv2yezDm+OU1IwjHViObXuXM6jS96QK+HsvkkHL/Q5o=;
        b=jseoYfQZGSCSizE86uDTy0d0VJM0hv73GFDjiR/coeHcJr/RJ+seJPk5zhanWOUAMs
         aYtI1qEn878Mg8pltEO824u7+QTBj8kcGow/frkLS1ZuM8Uf5GqmQ9Mv7Pro8GTC8ca1
         Y+XWX17GnR0nWkHPXarrPMr+y+UdHzkjEubZlOUFSGG8uCD7tvbbVk6ehF0waPwpPlWK
         ktrSvARQ2V0pNmOC+mYULoe7j/4HuJLzPD80dVuGCbF7B5fMdFOrEl1GsaI8/DJm8dCE
         CBKQllGy8RjycBktxxc/QogYXBXbWcROno7wOMExXzS+Y7J8BBXvjg1vz2eJoH2WnBhr
         657w==
X-Gm-Message-State: AOAM533kS3Hpb/z/pzrRZjTXc6wR+cxfy/nxe5PuW6KjQBt7KYF8usPk
        G5H5ZiatAlscsA6ZTZQhOV20nydBK64o+E5ANAh5gQ==
X-Google-Smtp-Source: ABdhPJzryCmh9QnpOO6F4CXA3aPysqNfVvdhNg2GVfoTFNfx3YnPlF3w4C6wApPhh2voqdNm9GBdAEjuPyCeCuc8PmQ=
X-Received: by 2002:a17:906:2bc3:: with SMTP id n3mr5091663ejg.418.1615957717730;
 Tue, 16 Mar 2021 22:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <59cb30f5e5ac6d65427ceaadf1012b2ba8dbf66c.1615606143.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210317041342.GA19198@wunner.de>
In-Reply-To: <20210317041342.GA19198@wunner.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 16 Mar 2021 22:08:31 -0700
Message-ID: <CAPcyv4jxTcUEgcfPRckHqrUPy8gR7ZJsxDaeU__pSq6PqJERAQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PCI: pciehp: Skip DLLSC handling if DPC is triggered
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>, knsathya@kernel.org,
        Sinan Kaya <okaya@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 16, 2021 at 9:14 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Fri, Mar 12, 2021 at 07:32:08PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > +     if ((events == PCI_EXP_SLTSTA_DLLSC) && is_dpc_reset_active(pdev)) {
> > +             ctrl_info(ctrl, "Slot(%s): DLLSC event(DPC), skipped\n",
> > +                       slot_name(ctrl));
> > +             ret = IRQ_HANDLED;
> > +             goto out;
> > +     }
>
> Two problems here:
>
> (1) If recovery fails, the link will *remain* down, so there'll be
>     no Link Up event.  You've filtered the Link Down event, thus the
>     slot will remain in ON_STATE even though the device in the slot is
>     no longer accessible.  That's not good, the slot should be brought
>     down in this case.

Can you elaborate on why that is "not good" from the end user
perspective? From a driver perspective the device driver context is
lost and the card needs servicing. The service event starts a new
cycle of slot-attention being triggered and that syncs the slot-down
state at that time.

>
> (2) If recovery succeeds, there's a race where pciehp may call
>     is_dpc_reset_active() *after* dpc_reset_link() has finished.
>     So both the DPC Trigger Status bit as well as pdev->dpc_reset_active
>     will be cleared.  Thus, the Link Up event is not filtered by pciehp
>     and the slot is brought down and back up even though DPC recovery
>     was succesful, which seems undesirable.

The hotplug driver never saw the Link Down, so what does it do when
the slot transitions from Link Up to Link Up? Do you mean the Link
Down might fire after the dpc recovery has completed if the hotplug
notification was delayed?
