Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C9F64BCB3
	for <lists+linux-pci@lfdr.de>; Tue, 13 Dec 2022 20:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbiLMTEe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Dec 2022 14:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236808AbiLMTE3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Dec 2022 14:04:29 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF625FD6;
        Tue, 13 Dec 2022 11:04:28 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id e205so679905oif.11;
        Tue, 13 Dec 2022 11:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pAmD3HvupURpgv7pZG1Uiki7htJikhDFSjZ/f4oUH14=;
        b=i/o6UuxRb9RuBT5u9wgon2HsMtguZNnBEOjohuBJPY2Pdcq7FOBwX9iiC9d3N3A2au
         ST+nIK6rVFtLeXteK0ydoBAl16cO5g81oIpAcNtoN6WrGnRSnsMjggty4cMd4RHn59se
         Eb1PKhvSQrzfehUONp4G4sV1loUPqmyo7KCvUumKXzeLRZ0CYWjxs58CHkfAMY2x8ysL
         zVK6AVt1MOrh1TKJk8xXtsq5XeMz0zM4sK7MLWBTYP5+YxOvsuAv0wMPSDpbwPOTRKmu
         luHbsSR++qQSaYSEjb6moygr/IT7KRjZE5qEaH4f9p40ppzUM+CN5K4HzOe/BDWuv9uw
         cW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pAmD3HvupURpgv7pZG1Uiki7htJikhDFSjZ/f4oUH14=;
        b=ssP1zUMQzDHn9otLnRZWFFqEXBO0VilUGvrNvDAlUPpWBfToHFYEk7lbHby+t0Zzjv
         /908Wc5/cBYU5WbOj8KNnhLwPJAaLKipA1vFfY7+QqMP4ZiXQhu8+9Bb2QrIDB7yS5/o
         boSbaZNRy8e+tXjcM+OZqZLMJcbp5PUkurvsLPs89kBq2pA7KoFXze+fKwnj9zbdiYPD
         jLmomHye3xav+TbtklAs/shQDESZ1Zsm5/mB0cGVRR86k5ghBAZ5BjgOh4jT2AGgqRbt
         TNjwXqU0uqt8KGsutlCRkCKRQKsx5lzEPMRDCZMfRTyYLKMPrYAtw5LsCM42PhKiInRn
         QNjA==
X-Gm-Message-State: ANoB5pnjv9DBGuMo7ZsyUgW6/fOZq/JhZLdHNLlREpuxu+zarnuO2k9i
        jues52VyR6uuBAwDfzoGjKE=
X-Google-Smtp-Source: AA0mqf4EqnxkDxpMcs+hMCgwcKcR0H9YmqROKjV/WbKPiIqIhLdGYnHEl/n0LbJr1XZMZvSeewPsjQ==
X-Received: by 2002:aca:1911:0:b0:35e:2553:f006 with SMTP id l17-20020aca1911000000b0035e2553f006mr8603217oii.9.1670958267725;
        Tue, 13 Dec 2022 11:04:27 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bx16-20020a0568081b1000b0035ea65a56cesm1264569oib.22.2022.12.13.11.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 11:04:27 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 13 Dec 2022 11:04:25 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
Subject: Re: [patch V3 09/33] genirq/msi: Add range checking to
 msi_insert_desc()
Message-ID: <20221213190425.GA3943240@roeck-us.net>
References: <20221124230505.073418677@linutronix.de>
 <20221124232325.798556374@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124232325.798556374@linutronix.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Fri, Nov 25, 2022 at 12:25:59AM +0100, Thomas Gleixner wrote:
> Per device domains provide the real domain size to the core code. This
> allows range checking on insertion of MSI descriptors and also paves the
> way for dynamic index allocations which are required e.g. for IMS. This
> avoids external mechanisms like bitmaps on the device side and just
> utilizes the core internal MSI descriptor storxe for it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---

This patch results in various s390 qemu test failures.
There is a warning backtrace

   12.674858] WARNING: CPU: 0 PID: 1 at kernel/irq/msi.c:167 msi_ctrl_valid+0x2a/0xb0

followed by

[   12.684333] virtio_net: probe of virtio0 failed with error -34

and Ethernet interfaces don't instantiate.

When trying to instantiate virtio-pci and booting from it, I see
the same warning backtrace followed by

[    9.943123] virtio_blk: probe of virtio0 failed with error -34

and a crash.

A typical backtrace is

[   12.674858] WARNING: CPU: 0 PID: 1 at kernel/irq/msi.c:167 msi_ctrl_valid+0x2a/0xb0
[   12.675108] Modules linked in:
[   12.675346] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G                 N 6.1.0-03225-g764822972d64 #1
[   12.675512] Hardware name: QEMU 8561 QEMU (KVM/Linux)
[   12.675648] Krnl PSW : 0704c00180000000 00000000001ec4c6 (msi_ctrl_valid+0x2e/0xb0)
[   12.675853]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
[   12.675987] Krnl GPRS: 00000000435318a9 0000000000000000 00000000035510a0 0000000000000000
[   12.676069]            0000000000000000 000000000000ffff 0000000000000000 0000037fffb1b6c0
[   12.676151]            0000000000000000 0000037fffb1b658 0000000000000000 0000037fffb1b658
[   12.676232]            0000000002ae4100 00000000035510a0 0000037fffb1b568 0000037fffb1b538
[   12.677127] Krnl Code: 00000000001ec4b8: 58303000		l	%r3,0(%r3)
[   12.677127]            00000000001ec4bc: ec3c000f017f	clij	%r3,1,12,00000000001ec4da
[   12.677127]           #00000000001ec4c2: af000000		mc	0,0
[   12.677127]           >00000000001ec4c6: a7280000		lhi	%r2,0
[   12.677127]            00000000001ec4ca: b9840022		llgcr	%r2,%r2
[   12.677127]            00000000001ec4ce: ebbff0a00004	lmg	%r11,%r15,160(%r15)
[   12.677127]            00000000001ec4d4: c0f400714f1a	brcl	15,0000000001016308
[   12.677127]            00000000001ec4da: b9160033		llgfr	%r3,%r3
[   12.677743] Call Trace:
[   12.677835]  [<00000000001ec4c6>] msi_ctrl_valid+0x2e/0xb0
[   12.677943]  [<00000000001ec58a>] msi_domain_free_descs+0x42/0x120
[   12.678024]  [<00000000001ecaf0>] msi_domain_free_msi_descs_range+0x38/0x48
[   12.678103]  [<00000000009db7ae>] __pci_enable_msix_range+0x44e/0x710
[   12.678186]  [<00000000009d9da4>] pci_alloc_irq_vectors_affinity+0xa4/0x120
[   12.678268]  [<00000000009f5888>] vp_request_msix_vectors+0xb8/0x208
[   12.678348]  [<00000000009f5f24>] vp_find_vqs_msix+0x254/0x2f0
[   12.678428]  [<00000000009f6016>] vp_find_vqs+0x56/0x1f8
[   12.678508]  [<00000000009f4e4e>] vp_modern_find_vqs+0x3e/0x90
[   12.678587]  [<0000000000ad8c14>] virtnet_find_vqs+0x244/0x3e8
[   12.678669]  [<0000000000ad9268>] virtnet_probe+0x4b0/0xca8
[   12.678748]  [<00000000009ed6b4>] virtio_dev_probe+0x1ec/0x418
[   12.678826]  [<0000000000a3c246>] really_probe+0xd6/0x480
[   12.678906]  [<0000000000a3c7a0>] driver_probe_device+0x40/0xf0
[   12.678985]  [<0000000000a3d0e4>] __driver_attach+0xbc/0x228
[   12.679065]  [<0000000000a396c0>] bus_for_each_dev+0x80/0xb8
[   12.679143]  [<0000000000a3b38e>] bus_add_driver+0x1d6/0x260
[   12.679222]  [<0000000000a3dc10>] driver_register+0xa8/0x170
[   12.679312]  [<00000000017b8848>] virtio_net_driver_init+0x88/0xc0

This worked fine in v6.1 and earlier kernels. Bisect log attached.

Guenter

---
# bad: [764822972d64e7f3e6792278ecc7a3b3c81087cd] Merge tag 'nfsd-6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
# good: [830b3c68c1fb1e9176028d02ef86f3cf76aa2476] Linux 6.1
git bisect start 'HEAD' 'v6.1'
# good: [01f3cbb296a9ad378167c01758c99557b5bc3208] Merge tag 'soc-dt-6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect good 01f3cbb296a9ad378167c01758c99557b5bc3208
# bad: [e2ed78d5d9ca07a2b9d158ebac366170a2d3083d] Merge tag 'linux-kselftest-kunit-next-6.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
git bisect bad e2ed78d5d9ca07a2b9d158ebac366170a2d3083d
# bad: [045e222d0a9dcec152abe0633f538cafd965b12b] Merge tag 'pm-6.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect bad 045e222d0a9dcec152abe0633f538cafd965b12b
# good: [f10bc40168032962ebee26894bdbdc972cde35bf] Merge tag 'core-debugobjects-2022-12-10' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good f10bc40168032962ebee26894bdbdc972cde35bf
# bad: [9d33edb20f7e6943250d6bb96ceaf2368f674d51] Merge tag 'irq-core-2022-12-10' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 9d33edb20f7e6943250d6bb96ceaf2368f674d51
# good: [c459f11f32a022d0f97694030419d16816275a9d] genirq/msi: Remove unused alloc/free interfaces
git bisect good c459f11f32a022d0f97694030419d16816275a9d
# bad: [d51a15af37ce8cf59e73de51dcdce3c9f4944974] irqchip/gic-v2m: Mark a few functions __init
git bisect bad d51a15af37ce8cf59e73de51dcdce3c9f4944974
# bad: [4d5a4ccc519ab0a62e220dc8dcd8bc1c5f8fee10] x86/apic/msi: Remove arch_create_remap_msi_irq_domain()
git bisect bad 4d5a4ccc519ab0a62e220dc8dcd8bc1c5f8fee10
# good: [26e91b75bf6108550035355c835bf0c93c885b61] genirq/msi: Provide msi_match_device_domain()
git bisect good 26e91b75bf6108550035355c835bf0c93c885b61
# bad: [15c72f824b32761696b1854500bb3dedccbbb45a] PCI/MSI: Add support for per device MSI[X] domains
git bisect bad 15c72f824b32761696b1854500bb3dedccbbb45a
# bad: [877d6c4e93f5091bfa52549bde8fb9ce71d6f7e5] PCI/MSI: Split __pci_write_msi_msg()
git bisect bad 877d6c4e93f5091bfa52549bde8fb9ce71d6f7e5
# bad: [36db3d9003ea85217b357a658cf7b37920c2c38e] genirq/msi: Add range checking to msi_insert_desc()
git bisect bad 36db3d9003ea85217b357a658cf7b37920c2c38e
# first bad commit: [36db3d9003ea85217b357a658cf7b37920c2c38e] genirq/msi: Add range checking to msi_insert_desc()
