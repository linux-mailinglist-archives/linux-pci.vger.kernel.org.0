Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD66663A84
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 09:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbjAJIII (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 03:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbjAJIHT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 03:07:19 -0500
Received: from cmx-mtlrgo002.bell.net (mta-mtl-003.bell.net [209.71.208.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D5D193F3;
        Tue, 10 Jan 2023 00:07:16 -0800 (PST)
X-RG-CM-BuS: 0
X-RG-CM-SC: 0
X-RG-CM: Clean
X-Originating-IP: [70.54.80.171]
X-RG-Env-Sender: matt.fagnani@bell.net
X-RG-Rigid: 63B600CD009937F6
X-CM-Envelope: MS4xfCUGo27GhQgcr70sf442nrT2B06JG7JQm4Oo8WeAVI9/mwH+42A9EtzIcaAz/Z409dfEdYCjUrK/DxGZbrK4YAjwOkun/Ymxbn7R/AsKWZxR64kPD0kd
 cvjkrud2NELDAx2JCY1URQMKLYsVKv0heaods7dV9V30vwqcL3BO60Cz+uoPJzPtrkiUzGqzNzAxprKsvsheAcC7jOrvr2xD+kNKQJdg9NLdWHZaG3QyifnS
 C+JNo9k1yMAGDylXuTQUMvZPc4DnGhHXdat8ywuPXvFF43qQrI5CWSt3T/SGIrwln6/EUsoiWfJSQ2QmelgnNTSNx+JF+FV0k33ck/Vs5T4FVN78z2/HZ6wW
 qpDQyjYLlSlbtO6mZCUoicQ6u1nAlY1YY/U+JQS6wGya9etMUQAht3y2D1ta7xsOxyOhFNxyo3W8megGhMipVdC/LEd9eAnF06ecL73Y7xpgTShbwSdeUWOp
 ORE+y58BGvjcJzS6idZVZgkNQqbe+taPyuSOc0EC3VrZolI1LC40FpD1t6M=
X-CM-Analysis: v=2.4 cv=d6kzizvE c=1 sm=1 tr=0 ts=63bd1c9e
 a=I0QgvDUx5pjUA0xIX2H+Tw==:117 a=I0QgvDUx5pjUA0xIX2H+Tw==:17
 a=IkcTkHD0fZMA:10 a=5KLPUuaC_9wA:10 a=fc0oe9_eLKIsakoo4NEA:9
 a=QEXdDO2ut3YA:10
Received: from [192.168.2.10] (70.54.80.171) by cmx-mtlrgo002.bell.net (5.8.807) (authenticated as matt.fagnani@bell.net)
        id 63B600CD009937F6; Tue, 10 Jan 2023 03:06:54 -0500
Message-ID: <be2b2dfc-ed6c-f762-7e4c-9d22b13717fe@bell.net>
Date:   Tue, 10 Jan 2023 03:06:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101
 Firefox/110.0 Thunderbird/110.0a1
From:   Matt Fagnani <matt.fagnani@bell.net>
Subject: =?UTF-8?Q?Re=3A_=5Bregression=2C_bisected=2C_pci/iommu=5D_Bug=C2=A0?=
 =?UTF-8?Q?216865_-_Black_screen_when_amdgpu_started_during_6=2E2-rc1_boot_w?=
 =?UTF-8?Q?ith_AMD_IOMMU_enabled?=
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Vasant Hegde <vasant.hegde@amd.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info>
 <5aa0e698-f715-0481-36e5-46505024ebc1@bell.net>
 <aea57c5f-2d20-c589-ad44-a63f1133a3db@linux.intel.com>
 <157c4ca4-370a-5d7e-fe32-c64d934f6979@amd.com>
 <223ee6d6-70ea-1d53-8bc2-2d22201d8dde@bell.net>
 <6fff9d10-f77f-e55a-9020-8a1bd34cf508@amd.com> <Y7gs0zYKp/VXACBi@nvidia.com>
 <f96b1cf3-6865-663d-f1cd-466a71519b08@linux.intel.com>
Content-Language: en-US
In-Reply-To: <f96b1cf3-6865-663d-f1cd-466a71519b08@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Baolu,

I tried to apply your patch after checking out 6.2-rc3 and origin/master 
but there were there the following errors.

git apply amd-iommu-amdgpu-boot-crash-2.patch
error: patch failed: drivers/pci/ats.c:382
error: drivers/pci/ats.c: patch does not apply

I manually changed drivers/pci/ats.c as shown in the patch. I built 
6.2-rc3 + the patch. 6.2-rc3 with the patch had the same black screen 
problem when booting. I added rd.driver.blacklist=amdgpu on the kernel 
command line to prevent amdgpu from being started while the initramfs 
was in use, and the black screen happened later in the boot as I 
described in my previous email. The journal showed the same two warnings 
and null pointer dereference which made amdgpu crash as I reported.

Thanks,

Matt


