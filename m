Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AC265F4D1
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 20:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjAETv2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 14:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235281AbjAETvX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 14:51:23 -0500
Received: from cmx-torrgo002.bell.net (mta-tor-002.bell.net [209.71.212.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FB718384;
        Thu,  5 Jan 2023 11:51:21 -0800 (PST)
X-RG-CM-BuS: 0
X-RG-CM-SC: 0
X-RG-CM: Clean
X-Originating-IP: [70.50.67.26]
X-RG-Env-Sender: matt.fagnani@bell.net
X-RG-Rigid: 63B725EB00005601
X-CM-Envelope: MS4xfHbVkB4MuMXoQjk1sixxFlIfbBI3/9mb+a24yvYfFZOqTuqmspkt218clGMWj2QnmrSCjp1aDW/R3f22rEKuVRUjv5Zb9zz2diA5P0D++/gEgzCv6Ovw
 Y8z7fbIk7Hjb2C4bUasDWjkHAyAUV23OH7jcPqpe7azX0a+WkgZUM55z3mICA1AequXSiH9qT4Gh7WKeW4/zX1ZabGeIhlCi/UvKXkr4bRfh8f/Uy8nmPxNX
 6d2JAMkqMgzk3dt1UWw8ROF1y+3Fl4m4xXANrEln0LYPCvGIdphhib693cP7wN5Ik0Rmi85mWLJLTFK8r0L4jIB5p5/RxcCGcsq7IfpAqILKm0/THe6NHUKd
 Bd6YndxO0SIypNijCeuABPL8zzLOvuAM0ypsOc+MOH/qqH0+3ik2luSug11a8az+LNRWZfyxHBLFtXtyF3A/AshDf/ZTFzYIP3v1VUNVFidtC4Oi4aP1Ge1a
 XdDNQxJenhU0cgnWUsc8quCKVK7UsWmazh45eA==
X-CM-Analysis: v=2.4 cv=DNZJoQBb c=1 sm=1 tr=0 ts=63b72a2c
 a=5bbZzBgFcFyHXceaIT16+A==:117 a=5bbZzBgFcFyHXceaIT16+A==:17
 a=IkcTkHD0fZMA:10 a=5KLPUuaC_9wA:10 a=JU2Wjajv5rFpccWKvaoA:9
 a=QEXdDO2ut3YA:10
Received: from [192.168.2.10] (70.50.67.26) by cmx-torrgo002.bell.net (5.8.807) (authenticated as matt.fagnani@bell.net)
        id 63B725EB00005601; Thu, 5 Jan 2023 14:51:08 -0500
Message-ID: <9f8bab1d-5f60-c962-3789-1b5ed8767076@bell.net>
Date:   Thu, 5 Jan 2023 14:51:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101
 Firefox/110.0 Thunderbird/110.0a1
Subject: =?UTF-8?Q?Re=3A_=5Bregression=2C_bisected=2C_pci/iommu=5D_Bug=C2=A0?=
 =?UTF-8?Q?216865_-_Black_screen_when_amdgpu_started_during_6=2E2-rc1_boot_w?=
 =?UTF-8?Q?ith_AMD_IOMMU_enabled?=
To:     Vasant Hegde <vasant.hegde@amd.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Joerg Roedel <jroedel@suse.de>,
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
 <6fff9d10-f77f-e55a-9020-8a1bd34cf508@amd.com>
Content-Language: en-US
From:   Matt Fagnani <matt.fagnani@bell.net>
In-Reply-To: <6fff9d10-f77f-e55a-9020-8a1bd34cf508@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I booted 6.2-rc2 + the patch four times with early kdump enabled and 
panicked the kernel. There weren't any kdump or dmesg files saved to 
/var/crash though. Nothing showed up in the journal from boots where the 
problem happened. The amdgpu crash happened before systemd-journald 
started from what I could tell. I tried to rebuild 
/boot/initramfs-6.2.0-rc2+kdump.img with amd_iommu=off added to the 
kernel command line with dracut, but an error that the kdumpbase module 
couldn't be found was shown. I read that a different dump capture kernel 
could be used with kdump, but I haven't figured out how to use that with 
early kdump yet. If anyone has ideas how to get the kdump and dmesg log, 
let me know. Thanks.

