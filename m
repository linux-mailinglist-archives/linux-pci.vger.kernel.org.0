Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC93275D77
	for <lists+linux-pci@lfdr.de>; Wed, 23 Sep 2020 18:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgIWQcF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 23 Sep 2020 12:32:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56006 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWQcE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2020 12:32:04 -0400
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kL7gW-0007R8-Vv
        for linux-pci@vger.kernel.org; Wed, 23 Sep 2020 16:32:01 +0000
Received: by mail-pl1-f197.google.com with SMTP id i6so348674plt.4
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2020 09:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1vu3RVWfaicSDRQ+g0gtPLuzJ9RQhK+defWMWWVa92E=;
        b=W4WrNSMpQhQb/7fVZhXhuBLp/qzq6UZMTti224iQNslTS7pxohrUmidEnsewX0bJ08
         tQuqJlp7SY1GrdYscfGoKYGbu/pUeRTc6Ys8JDC3if91B6819qTudM//fQfeFkzxmptX
         r979mcTaK7oT22ZfvkJV/5fl11llHrY6p5hag8EHfM1vnw707Vp3liXBJicMr/Mb8MCn
         Y2ejWDA/caF8WcJRWYNfmsHqgKcfB7NudtcxcbuqkuGExNHNscw1CQt9ePZNVd2Tj1BM
         2zj+5Ax99rTT110l4u2rGCBD/BVDZ5QlPlr7AnbxtNXhp6ubk4/9IzP0KLDyhrzE39D6
         KdvQ==
X-Gm-Message-State: AOAM533uAtSGOsKuOJTdR0ZM7nkkfVYGBZKSFhzsAR2hwy3vN56aK3kZ
        hkFODmbtfXAPTEEKoCa1fdA+A8e8dc2mHYjsYWSyhqyP+TIt+sPMektMQamTezxhIyZ4PARm6fv
        EjymhOlQgMujXWa5iEqAcNYk+k8x5d9CR4V2qmg==
X-Received: by 2002:a63:d242:: with SMTP id t2mr494082pgi.47.1600878719601;
        Wed, 23 Sep 2020 09:31:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1x8FfYg8hrB4ZdorxoPEkweMi6AgmxrmxRWXUYcoDPMEIweTW2plxS2GzleY2EMpMxY5P7w==
X-Received: by 2002:a63:d242:: with SMTP id t2mr494053pgi.47.1600878719204;
        Wed, 23 Sep 2020 09:31:59 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id x3sm367548pgg.54.2020.09.23.09.31.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2020 09:31:58 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 209149] New:
 "iommu/vt-d: Enable PCI ACS for platform opt in hint" makes NVMe config space
 not accessible after S3]
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200923160327.GA2267374@bjorn-Precision-5520>
Date:   Thu, 24 Sep 2020 00:31:53 +0800
Cc:     "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Rajat Jain <rajatja@google.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        iommu@lists.linux-foundation.org,
        "Jechlitschek, Christoph" <christoph.jechlitschek@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <6CD003F6-DDF4-4C57-AD9E-79C8AB5C01BF@canonical.com>
References: <20200923160327.GA2267374@bjorn-Precision-5520>
To:     Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+Cc Christoph]

> On Sep 24, 2020, at 00:03, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> [+cc IOMMU and NVMe folks]
> 
> Sorry, I forgot to forward this to linux-pci when it was first
> reported.
> 
> Apparently this happens with v5.9-rc3, and may be related to
> 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in hint"),
> which appeared in v5.8-rc3.
> 
> There are several dmesg logs and proposed patches in the bugzilla, but
> no analysis yet of what the problem is.  From the first dmesg
> attachment (https://bugzilla.kernel.org/attachment.cgi?id=292327):

AFAIK Intel is working on it internally.
Comet Lake probably needs ACS quirk like older generation chips.

> 
>  [   50.434945] PM: suspend entry (deep)
>  [   50.802086] nvme 0000:01:00.0: saving config space at offset 0x0 (reading 0x11e0f)
>  [   50.842775] ACPI: Preparing to enter system sleep state S3
>  [   50.858922] ACPI: Waking up from system sleep state S3
>  [   50.883622] nvme 0000:01:00.0: can't change power state from D3hot to D0 (config space inaccessible)
>  [   50.947352] nvme 0000:01:00.0: restoring config space at offset 0x0 (was 0xffffffff, writing 0x11e0f)
>  [   50.947816] pcieport 0000:00:1b.0: DPC: containment event, status:0x1f01 source:0x0000
>  [   50.947817] pcieport 0000:00:1b.0: DPC: unmasked uncorrectable error detected
>  [   50.947829] pcieport 0000:00:1b.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Receiver ID)
>  [   50.947830] pcieport 0000:00:1b.0:   device [8086:06ac] error status/mask=00200000/00010000
>  [   50.947831] pcieport 0000:00:1b.0:    [21] ACSViol                (First)
>  [   50.947841] pcieport 0000:00:1b.0: AER: broadcast error_detected message
>  [   50.947843] nvme nvme0: frozen state error detected, reset controller
> 
> I suspect the nvme "can't change power state" and restore config space
> errors are a consequence of the DPC event.  If DPC disables the link,
> the device is inaccessible.
> 
> I don't know what caused the ACS Violation.  The AER TLP Header Log
> might have a clue, but unfortunately we didn't print it.
> 
> Tangent:
> 
>  The fact that we didn't print the AER TLP Header log looks like
>  a bug in itself.  PCIe r5.0, sec 6.2.7, table 6-5, says many
>  errors, including ACS Violation, should log the TLP header.  But
>  aer_get_device_error_info() only reads the log for error bits in
>  AER_LOG_TLP_MASKS, which doesn't include PCI_ERR_UNC_ACSV.
> 
>  I don't think there's a "TLP Header Log Valid" bit, and it's ugly to
>  have to update AER_LOG_TLP_MASKS if new errors are added.  I think
>  maybe we should always print the header log.

I can attach TLP Header if there's a patch...

Kai-Heng

> 
> ----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org -----
> 
> Date: Fri, 04 Sep 2020 14:31:20 +0000
> From: bugzilla-daemon@bugzilla.kernel.org
> To: bjorn@helgaas.com
> Subject: [Bug 209149] New: "iommu/vt-d: Enable PCI ACS for platform opt in
> 	hint" makes NVMe config space not accessible after S3
> Message-ID: <bug-209149-41252@https.bugzilla.kernel.org/>
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=209149
> 
>            Bug ID: 209149
>           Summary: "iommu/vt-d: Enable PCI ACS for platform opt in hint"
>                    makes NVMe config space not accessible after S3
>           Product: Drivers
>           Version: 2.5
>    Kernel Version: mainline
>          Hardware: All
>                OS: Linux
>              Tree: Mainline
>            Status: NEW
>          Severity: normal
>          Priority: P1
>         Component: PCI
>          Assignee: drivers_pci@kernel-bugs.osdl.org
>          Reporter: kai.heng.feng@canonical.com
>        Regression: No
> 
> Here's the error:
> [   50.947816] pcieport 0000:00:1b.0: DPC: containment event, status:0x1f01
> source:0x0000
> [   50.947817] pcieport 0000:00:1b.0: DPC: unmasked uncorrectable error
> detected
> [   50.947829] pcieport 0000:00:1b.0: PCIe Bus Error: severity=Uncorrected
> (Non-Fatal), type=Transaction Layer, (Receiver ID)
> [   50.947830] pcieport 0000:00:1b.0:   device [8086:06ac] error
> status/mask=00200000/00010000
> [   50.947831] pcieport 0000:00:1b.0:    [21] ACSViol                (First)
> [   50.947841] pcieport 0000:00:1b.0: AER: broadcast error_detected message
> [   50.947843] nvme nvme0: frozen state error detected, reset controller
> 
> -- 
> You are receiving this mail because:
> You are watching the assignee of the bug.
> 
> ----- End forwarded message -----

