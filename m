Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DC249F1DF
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 04:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242052AbiA1DaJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jan 2022 22:30:09 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:58636
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236369AbiA1DaJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jan 2022 22:30:09 -0500
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D2CA23F197
        for <linux-pci@vger.kernel.org>; Fri, 28 Jan 2022 03:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643340607;
        bh=o1I8UaIYrM6dC/0Rd0QRoVtyxyLa0HoViEvgtP4OM7I=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=nO5Y//XoBV+zNQYzMG8F9jNmJkui9O+/Cssc0Wltivpqo5x4By6tmVM7LBcd+rMl6
         MnQpukQqOw9X8FBmcpq/cIbXVgoj5UAP8pHyIlkAgHSPlDSBDi/dw/vMAnddXbwnwe
         61IgiU1OT5lKDJg+OL9Vo3ss1adKX+WCakDJrH83MSHgQl2QXiHRj6p1mCBUh7RoVd
         TvO+AHBS/UfQ1wqPpHjzEetjs0nKb1wSivtH0ch1W491DmlQTp9PWQ95Q+fFSVYK4u
         Wa1JElgtRYWw7BBjthmb2KvCnHq2pJTh15M7Gjcc58boe0r25tnNPeYss8hTqLPyJY
         ugCJL1p0DCS4A==
Received: by mail-oo1-f71.google.com with SMTP id l10-20020a4ac60a000000b002de84253574so2663030ooq.19
        for <linux-pci@vger.kernel.org>; Thu, 27 Jan 2022 19:30:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o1I8UaIYrM6dC/0Rd0QRoVtyxyLa0HoViEvgtP4OM7I=;
        b=7vERMtQbhbNoyT8e9WQpq2A+QiHpZ+TjoLU5OPu77dlSsz8MmLYJX0TeVftggon1zT
         5xgWXnL0uVs4tLqy6aWxGY4WN2HSgQ+4E89hFKP9OuIYa/VNRZ0GdePXth3X+W6tRnQ1
         sJXJDk8eF08klKX6VX1lD63wRUiyXFxcdR0llvaQ5xXByR4PpAVX+kDhv/qt4b5hfzPK
         WL06s7rUbdNaxxTnPFfp5qOvzYCillKpCBsQEN4PQGJPd75kJjmBU62KSRazxCTPxhR/
         t7GpsNwFkcVGE866JW5IAemxa2I/r0s4o1CiG6OSeSeZF0Qtoc8DEbyxPkZt+Rgi4nqz
         AB8g==
X-Gm-Message-State: AOAM5326stc6Nv33PrOlJzDd0AO4bF0XhKMwLQaXiAYYzyBbwjYkxFSC
        8SdxJ0i5tHG4x3+eo1wu64jqeYAOfYVnE+bw3sDLmxqZJm7LGZl0zetWUks+cGVU9Y+5cOp3TVD
        +/G/5gI717uRcnSjc7dzpC9pRM6mZLzoM+WDwxl9ln7JSPUkCEQYhxQ==
X-Received: by 2002:a05:6808:191a:: with SMTP id bf26mr9172616oib.111.1643340606601;
        Thu, 27 Jan 2022 19:30:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz1jv4J88ak1rDj6mbh78ua15nyVyq1aqhXCtXon2huqpabC8PnLCHWXFERGI5wRDEfkfYL3kiys1HJTFSdoOQ=
X-Received: by 2002:a05:6808:191a:: with SMTP id bf26mr9172601oib.111.1643340606215;
 Thu, 27 Jan 2022 19:30:06 -0800 (PST)
MIME-Version: 1.0
References: <20220127025418.1989642-1-kai.heng.feng@canonical.com>
 <0259955f-8bbb-1778-f234-398f1356db8b@linux.intel.com> <CAAd53p6+KPAJchh9Jx59Fkkj5FidSxsW0yHjLqooFjvu-Y9u7w@mail.gmail.com>
 <11891652-40c6-f111-46b7-e96d1729815e@linux.intel.com>
In-Reply-To: <11891652-40c6-f111-46b7-e96d1729815e@linux.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 28 Jan 2022 11:29:54 +0800
Message-ID: <CAAd53p5rNFBK8t7bK_Jdds2c4dXpWtEb10iTtsc4zQEjGrf-Pg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI/AER: Disable AER service when link is in L2/L3
 ready, L2 and L3 state
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     bhelgaas@google.com, mika.westerberg@linux.intel.com,
        koba.ko@canonical.com, Russell Currey <ruscur@russell.cc>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
        Joerg Roedel <jroedel@suse.de>, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 28, 2022 at 10:57 AM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> On 1/27/22 7:14 PM, Kai-Heng Feng wrote:
> > On Thu, Jan 27, 2022 at 3:01 PM Lu Baolu <baolu.lu@linux.intel.com> wrote:
> >>
> >> On 2022/1/27 10:54, Kai-Heng Feng wrote:
> >>> Commit 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in
> >>> hint") enables ACS, and some platforms lose its NVMe after resume from
> >>> S3:
> >>> [   50.947816] pcieport 0000:00:1b.0: DPC: containment event, status:0x1f01 source:0x0000
> >>> [   50.947817] pcieport 0000:00:1b.0: DPC: unmasked uncorrectable error detected
> >>> [   50.947829] pcieport 0000:00:1b.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Receiver ID)
> >>> [   50.947830] pcieport 0000:00:1b.0:   device [8086:06ac] error status/mask=00200000/00010000
> >>> [   50.947831] pcieport 0000:00:1b.0:    [21] ACSViol                (First)
> >>> [   50.947841] pcieport 0000:00:1b.0: AER: broadcast error_detected message
> >>> [   50.947843] nvme nvme0: frozen state error detected, reset controller
> >>>
> >>> It happens right after ACS gets enabled during resume.
> >>>
> >>> There's another case, when Thunderbolt reaches D3cold:
> >>> [   30.100211] pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: 0000:00:1d.0
> >>> [   30.100251] pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> >>> [   30.100256] pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
> >>> [   30.100262] pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
> >>> [   30.100267] pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 08000052 00000000 00000000
> >>> [   30.100372] thunderbolt 0000:0a:00.0: AER: can't recover (no error_detected callback)
> >>> [   30.100401] xhci_hcd 0000:3e:00.0: AER: can't recover (no error_detected callback)
> >>> [   30.100427] pcieport 0000:00:1d.0: AER: device recovery failed
> >>>
> >>> So disable AER service to avoid the noises from turning power rails
> >>> on/off when the device is in low power states (D3hot and D3cold), as
> >>> PCIe spec "5.2 Link State Power Management" states that TLP and DLLP
> >>> transmission is disabled for a Link in L2/L3 Ready (D3hot), L2 (D3cold
> >>> with aux power) and L3 (D3cold).
> >>>
> >>> Bugzilla:https://bugzilla.kernel.org/show_bug.cgi?id=209149
> >>> Bugzilla:https://bugzilla.kernel.org/show_bug.cgi?id=215453
> >>> Fixes: 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in hint")
> >>
> >> I don't know what this fix has to do with the commit 50310600ebda.
> >
> > Commit 50310600ebda only exposed the underlying issue. Do you think
> > "Fixes:" tag should change to other commits?
> >
> >> Commit 50310600ebda only makes sure that PCI ACS is enabled whenever
> >> Intel IOMMU is on. Before this commit, PCI ACS could also be enabled
> >> and result in the same problem. Or anything I missed?
> >
> > The system in question didn't enable ACS before commit 50310600ebda.
>
> This commit exposed the issue on your configuration doesn't mean the
> fix should be back ported as far as that commit. I believe if you add
> intel-iommu=on in the kernel parameter, the issue still exists even you
> revert commit 50310600ebda or checkout a tag before it.

That's true.

I guess it's better to drop the "Fixes:" tag.

Bjorn, should I send another version of it?

Kai-Heng

>
> Best regards,
> baolu
