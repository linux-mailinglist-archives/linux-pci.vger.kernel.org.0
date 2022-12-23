Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BCF654B1D
	for <lists+linux-pci@lfdr.de>; Fri, 23 Dec 2022 03:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiLWCdl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Dec 2022 21:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiLWCdl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Dec 2022 21:33:41 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FFE15814
        for <linux-pci@vger.kernel.org>; Thu, 22 Dec 2022 18:33:36 -0800 (PST)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9BC5E44330
        for <linux-pci@vger.kernel.org>; Fri, 23 Dec 2022 02:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1671762813;
        bh=rETSzYOA6E7INCkniX10rZIL3JYXNCXVMVvHLlg9Eh4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=EZNBob6i1sGd2IQ8dfkf9TX8uvZwDe+4dGmOE3FPSI5IppWo7NPwyiuPm8HznrdAG
         93teW+diBZEs5fMiYjBnSYEo1DKEdrPvfla/zVhEJZVmreKp/pzB1qfxuVGzi3OUeM
         WSdhwICPRRt2MWPVbalzEFU5IhSoqPSdXZJloTuKlwZdQAQSrvmhpjpZMeoIWqRawo
         W3/Akq3OIcObaYtAsWd2rK0Ntygn6dTzIRS8N4Uj90mbMPDXt+XmWtzec0gVEBxRcI
         IoBDu8a9jf6uBF+nlprdumkoy9R8oO6JiLFwkpol1tLy37Oo9LP8s5GDlA2tGL4i+9
         JblsfSNj/3g0Q==
Received: by mail-pj1-f69.google.com with SMTP id om16-20020a17090b3a9000b002216006cbffso4151816pjb.3
        for <linux-pci@vger.kernel.org>; Thu, 22 Dec 2022 18:33:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rETSzYOA6E7INCkniX10rZIL3JYXNCXVMVvHLlg9Eh4=;
        b=0b7ertvm1xgfww90+AE4jAc/Zv52lpOFgrTYHcnSA4Jit9Yidi7/sjrfFQzS/tYLeY
         W23wRgGZ5dTDdXrY2tI6dtYHdTrtBi+LWxgEMSG6NucZRIC4Lc/37Wc/S8l/E3W4eZJP
         UXrgdoUNcPkNDSavfXUhfK6ObXYYrOVYbFFAeGjYj8W8b1KR3d+v2ODapiEhIoC+mrYX
         xgdCsRBKgWp/hEFmdwu9gVofwVkazuQdFQaleQBaLU0MQCxT3Ft+RPNSQu6/z6RpRx3Y
         hkHGMzvdwQJ22/WDrZekAnstIZSCgKg1Qd/a2idRq9EUE6RuE56GxRXeKnpvM6TAIkyT
         wJWw==
X-Gm-Message-State: AFqh2kracm56Cpesi4pC5h9uBtnZ5a3+NXN6+MXxfCqSilHmcPcI+52X
        KhyckdfNWR1muOd3XvGaEBT6HVd5ZyjpNQsOJip/b1651hFNCw36xlgH0DIWcN0+IY68gQyL2IV
        DeyanMWsEr+8nf3rh2/DUY/kryWblxlbHKwTgfkBMFvwtrJGw9TrB1g==
X-Received: by 2002:a17:90a:ce81:b0:21a:401:d2c0 with SMTP id g1-20020a17090ace8100b0021a0401d2c0mr780251pju.34.1671762812114;
        Thu, 22 Dec 2022 18:33:32 -0800 (PST)
X-Google-Smtp-Source: AMrXdXurupfFeEED1sKU3kzUIOTM4/y3HeeO8ihISfj3TlAKsRwZAPicHkwDyE2cN5v0Tv4ASgcAf776HaYgAnCZcRE=
X-Received: by 2002:a17:90a:ce81:b0:21a:401:d2c0 with SMTP id
 g1-20020a17090ace8100b0021a0401d2c0mr780248pju.34.1671762811690; Thu, 22 Dec
 2022 18:33:31 -0800 (PST)
MIME-Version: 1.0
References: <1573040408-3831-1-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1573040408-3831-1-git-send-email-jonathan.derrick@intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 23 Dec 2022 10:33:20 +0800
Message-ID: <CAAd53p5n05nPp84SreuMkjVYuvoK9D=GNjvbPNbhUV3yWVCLDQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] PCI: vmd: Reducing tail latency by affining to the
 storage stack
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jon,

On Wed, Nov 6, 2019 at 7:40 PM Jon Derrick <jonathan.derrick@intel.com> wrote:
>
> This patchset optimizes VMD performance through the storage stack by locating
> commonly-affined NVMe interrupts on the same VMD interrupt handler lists.
>
> The current strategy of round-robin assignment to VMD IRQ lists can be
> suboptimal when vectors with different affinities are assigned to the same VMD
> IRQ list. VMD is an NVMe storage domain and this set aligns the vector
> allocation and affinity strategy with that of the NVMe driver. This invokes the
> kernel to do the right thing when affining NVMe submission cpus to NVMe
> completion vectors as serviced through the VMD interrupt handler lists.
>
> This set greatly reduced tail latency when testing 8 threads of random 4k reads
> against two drives at queue depth=128. After pinning the tasks to reduce test
> variability, the tests also showed a moderate tail latency reduction. A
> one-drive configuration also shows improvements due to the alignment of VMD IRQ
> list affinities with NVMe affinities.

Is there any followup on this series? Because of
vmd_irq_set_affinity() always returning -EINVAL, so the system can't
perform S3 and CPU hotplug.

Bug filed here:
https://bugzilla.kernel.org/show_bug.cgi?id=216835

Kai-Heng

>
> An example with two NVMe drives and a 33-vector VMD:
> VMD irq[42]  Affinity[0-27,56-83]   Effective[10]
> VMD irq[43]  Affinity[28-29,84-85]  Effective[85]
> VMD irq[44]  Affinity[30-31,86-87]  Effective[87]
> VMD irq[45]  Affinity[32-33,88-89]  Effective[89]
> VMD irq[46]  Affinity[34-35,90-91]  Effective[91]
> VMD irq[47]  Affinity[36-37,92-93]  Effective[93]
> VMD irq[48]  Affinity[38-39,94-95]  Effective[95]
> VMD irq[49]  Affinity[40-41,96-97]  Effective[97]
> VMD irq[50]  Affinity[42-43,98-99]  Effective[99]
> VMD irq[51]  Affinity[44-45,100]    Effective[100]
> VMD irq[52]  Affinity[46-47,102]    Effective[102]
> VMD irq[53]  Affinity[48-49,104]    Effective[104]
> VMD irq[54]  Affinity[50-51,106]    Effective[106]
> VMD irq[55]  Affinity[52-53,108]    Effective[108]
> VMD irq[56]  Affinity[54-55,110]    Effective[110]
> VMD irq[57]  Affinity[101,103,105]  Effective[105]
> VMD irq[58]  Affinity[107,109,111]  Effective[111]
> VMD irq[59]  Affinity[0-1,56-57]    Effective[57]
> VMD irq[60]  Affinity[2-3,58-59]    Effective[59]
> VMD irq[61]  Affinity[4-5,60-61]    Effective[61]
> VMD irq[62]  Affinity[6-7,62-63]    Effective[63]
> VMD irq[63]  Affinity[8-9,64-65]    Effective[65]
> VMD irq[64]  Affinity[10-11,66-67]  Effective[67]
> VMD irq[65]  Affinity[12-13,68-69]  Effective[69]
> VMD irq[66]  Affinity[14-15,70-71]  Effective[71]
> VMD irq[67]  Affinity[16-17,72]     Effective[72]
> VMD irq[68]  Affinity[18-19,74]     Effective[74]
> VMD irq[69]  Affinity[20-21,76]     Effective[76]
> VMD irq[70]  Affinity[22-23,78]     Effective[78]
> VMD irq[71]  Affinity[24-25,80]     Effective[80]
> VMD irq[72]  Affinity[26-27,82]     Effective[82]
> VMD irq[73]  Affinity[73,75,77]     Effective[77]
> VMD irq[74]  Affinity[79,81,83]     Effective[83]
>
> nvme0n1q1   MQ CPUs[28, 29, 84, 85]
> nvme0n1q2   MQ CPUs[30, 31, 86, 87]
> nvme0n1q3   MQ CPUs[32, 33, 88, 89]
> nvme0n1q4   MQ CPUs[34, 35, 90, 91]
> nvme0n1q5   MQ CPUs[36, 37, 92, 93]
> nvme0n1q6   MQ CPUs[38, 39, 94, 95]
> nvme0n1q7   MQ CPUs[40, 41, 96, 97]
> nvme0n1q8   MQ CPUs[42, 43, 98, 99]
> nvme0n1q9   MQ CPUs[44, 45, 100]
> nvme0n1q10  MQ CPUs[46, 47, 102]
> nvme0n1q11  MQ CPUs[48, 49, 104]
> nvme0n1q12  MQ CPUs[50, 51, 106]
> nvme0n1q13  MQ CPUs[52, 53, 108]
> nvme0n1q14  MQ CPUs[54, 55, 110]
> nvme0n1q15  MQ CPUs[101, 103, 105]
> nvme0n1q16  MQ CPUs[107, 109, 111]
> nvme0n1q17  MQ CPUs[0, 1, 56, 57]
> nvme0n1q18  MQ CPUs[2, 3, 58, 59]
> nvme0n1q19  MQ CPUs[4, 5, 60, 61]
> nvme0n1q20  MQ CPUs[6, 7, 62, 63]
> nvme0n1q21  MQ CPUs[8, 9, 64, 65]
> nvme0n1q22  MQ CPUs[10, 11, 66, 67]
> nvme0n1q23  MQ CPUs[12, 13, 68, 69]
> nvme0n1q24  MQ CPUs[14, 15, 70, 71]
> nvme0n1q25  MQ CPUs[16, 17, 72]
> nvme0n1q26  MQ CPUs[18, 19, 74]
> nvme0n1q27  MQ CPUs[20, 21, 76]
> nvme0n1q28  MQ CPUs[22, 23, 78]
> nvme0n1q29  MQ CPUs[24, 25, 80]
> nvme0n1q30  MQ CPUs[26, 27, 82]
> nvme0n1q31  MQ CPUs[73, 75, 77]
> nvme0n1q32  MQ CPUs[79, 81, 83]
>
> nvme1n1q1   MQ CPUs[28, 29, 84, 85]
> nvme1n1q2   MQ CPUs[30, 31, 86, 87]
> nvme1n1q3   MQ CPUs[32, 33, 88, 89]
> nvme1n1q4   MQ CPUs[34, 35, 90, 91]
> nvme1n1q5   MQ CPUs[36, 37, 92, 93]
> nvme1n1q6   MQ CPUs[38, 39, 94, 95]
> nvme1n1q7   MQ CPUs[40, 41, 96, 97]
> nvme1n1q8   MQ CPUs[42, 43, 98, 99]
> nvme1n1q9   MQ CPUs[44, 45, 100]
> nvme1n1q10  MQ CPUs[46, 47, 102]
> nvme1n1q11  MQ CPUs[48, 49, 104]
> nvme1n1q12  MQ CPUs[50, 51, 106]
> nvme1n1q13  MQ CPUs[52, 53, 108]
> nvme1n1q14  MQ CPUs[54, 55, 110]
> nvme1n1q15  MQ CPUs[101, 103, 105]
> nvme1n1q16  MQ CPUs[107, 109, 111]
> nvme1n1q17  MQ CPUs[0, 1, 56, 57]
> nvme1n1q18  MQ CPUs[2, 3, 58, 59]
> nvme1n1q19  MQ CPUs[4, 5, 60, 61]
> nvme1n1q20  MQ CPUs[6, 7, 62, 63]
> nvme1n1q21  MQ CPUs[8, 9, 64, 65]
> nvme1n1q22  MQ CPUs[10, 11, 66, 67]
> nvme1n1q23  MQ CPUs[12, 13, 68, 69]
> nvme1n1q24  MQ CPUs[14, 15, 70, 71]
> nvme1n1q25  MQ CPUs[16, 17, 72]
> nvme1n1q26  MQ CPUs[18, 19, 74]
> nvme1n1q27  MQ CPUs[20, 21, 76]
> nvme1n1q28  MQ CPUs[22, 23, 78]
> nvme1n1q29  MQ CPUs[24, 25, 80]
> nvme1n1q30  MQ CPUs[26, 27, 82]
> nvme1n1q31  MQ CPUs[73, 75, 77]
> nvme1n1q32  MQ CPUs[79, 81, 83]
>
>
> This patchset applies after the VMD IRQ List indirection patch:
> https://lore.kernel.org/linux-pci/1572527333-6212-1-git-send-email-jonathan.derrick@intel.com/
>
> Jon Derrick (3):
>   PCI: vmd: Reduce VMD vectors using NVMe calculation
>   PCI: vmd: Align IRQ lists with child device vectors
>   PCI: vmd: Use managed irq affinities
>
>  drivers/pci/controller/vmd.c | 90 +++++++++++++++++++-------------------------
>  1 file changed, 39 insertions(+), 51 deletions(-)
>
> --
> 1.8.3.1
>
