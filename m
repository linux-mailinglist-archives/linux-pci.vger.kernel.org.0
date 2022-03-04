Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91154CD59F
	for <lists+linux-pci@lfdr.de>; Fri,  4 Mar 2022 14:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235968AbiCDN4p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Mar 2022 08:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239173AbiCDN4m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Mar 2022 08:56:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E79B1B8FC8
        for <linux-pci@vger.kernel.org>; Fri,  4 Mar 2022 05:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646402152;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QPWIp0sQmTP3HApGBB8ym38KTT9fOuLCB6okmKYuF40=;
        b=XTHq53JDvIZyIZ6p3KOzTbMvKTLWtmRqsVb48ak9DYFh0xEiuxafFqAyZATWNmz+fRiZu3
        NoYA8WmcFuOPxNI47QcAA9VQK1PPGR+Mn91Cmy70rga+nTx/V0iLmS2mVjlG1dAY7Hnzi3
        m0KhZ4eMeJN9ee0TSuDuZPq6qiM4c5w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-bt2t8hxgMM2o-pB7GNQGGQ-1; Fri, 04 Mar 2022 08:55:51 -0500
X-MC-Unique: bt2t8hxgMM2o-pB7GNQGGQ-1
Received: by mail-wm1-f69.google.com with SMTP id l2-20020a1ced02000000b0038482a47e7eso2839755wmh.5
        for <linux-pci@vger.kernel.org>; Fri, 04 Mar 2022 05:55:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=QPWIp0sQmTP3HApGBB8ym38KTT9fOuLCB6okmKYuF40=;
        b=0zmumJWMYpoos6xiy0ZrYZf3dQI0DNF0co1aZaWr6PCBGXJFaafu5NtBx0OtHf6JiW
         VHjejTyg/G1Upj4QnlWU9UWFyZqxGRR105TTbmEqvFvheAGRHq+WhX72e6OB0svcsXqF
         1vz3CTKbAGaz71F7c41BvvOAZfQkSc4el4q162Wq8LE8vBqEuBGgwHFoi/wWJ4GkSyJF
         ugk68iDlm7rVyodIDpgdnYJ/s/sN10z66+k2sPZwzQBWdG6zzpgQAUH3zJnnfLQ6OrfN
         Cvg1zGzHU2aE0JbfNbDWpdP3sflEu7bWukAazGth5nHU+afzIiv13nLpnWnUB9XOgBFq
         RIYQ==
X-Gm-Message-State: AOAM531P4rJ07SeI4a1RbOOaCsnFNuIt2VGjIF10t30RVri+Mk+tswv6
        o4dBJEbPvZ+xPjbDK+5JN9PBOqm3cy6nRrM7YN5fn96QTdqrCt4EmgZiu+B/qI5MXLqwYk2QWdf
        vhyOkLctI9+R+RrLjxomL
X-Received: by 2002:a05:6000:15cf:b0:1f0:44b9:b916 with SMTP id y15-20020a05600015cf00b001f044b9b916mr8971050wry.86.1646402150004;
        Fri, 04 Mar 2022 05:55:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz37GW0eYMmhzDC8Bw8HScH/vx+QGCD7Wqeg6Mo3LcpV8MchkeDSAHiRDo/oQwFe6JNh/ax7g==
X-Received: by 2002:a05:6000:15cf:b0:1f0:44b9:b916 with SMTP id y15-20020a05600015cf00b001f044b9b916mr8971026wry.86.1646402149735;
        Fri, 04 Mar 2022 05:55:49 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c4f8f00b003842f011bc5sm8462562wmq.2.2022.03.04.05.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 05:55:49 -0800 (PST)
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v7 01/11] iommu: Add DMA ownership management interfaces
To:     Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Cc:     Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, rafael@kernel.org,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Li Yang <leoyang.li@nxp.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220228005056.599595-1-baolu.lu@linux.intel.com>
 <20220228005056.599595-2-baolu.lu@linux.intel.com>
 <c75b6e04-bc1b-b9f6-1a44-bf1567a8c19d@redhat.com>
 <7a3dc977-0c5f-6d88-6d3a-8e49bc717690@linux.intel.com>
 <1648bc97-a0d3-4051-58d0-e24fa9e9d183@arm.com>
From:   Eric Auger <eric.auger@redhat.com>
Message-ID: <350a8e09-08a9-082b-3ad1-b711c7d98d73@redhat.com>
Date:   Fri, 4 Mar 2022 14:55:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1648bc97-a0d3-4051-58d0-e24fa9e9d183@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Robin,

On 3/4/22 1:22 PM, Robin Murphy wrote:
> On 2022-03-04 10:43, Lu Baolu wrote:
>> Hi Eric,
>>
>> On 2022/3/4 18:34, Eric Auger wrote:
>>> I hit a WARN_ON() when unbinding an e1000e driver just after boot:
>>>
>>> sudo modprobe -v vfio-pci
>>> echo vfio-pci | sudo tee -a
>>> /sys/bus/pci/devices/0004:01:00.0/driver_override
>>> vfio-pci
>>> echo 0004:01:00.0 | sudo tee -a  /sys/bus/pci/drivers/e1000e/unbind
>>>
>>>
>>> [  390.042811] ------------[ cut here ]------------
>>> [  390.046468] WARNING: CPU: 42 PID: 5589 at drivers/iommu/iommu.c:3123
>>> iommu_device_unuse_default_domain+0x68/0x100
>>> [  390.056710] Modules linked in: vfio_pci vfio_pci_core vfio_virqfd
>>> vfio_iommu_type1 vfio xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT
>>> nf_reject_ipv4 nft_compat nft_chain_nat nf_nat nf_conntrack
>>> nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink bridge stp llc rfkill
>>> sunrpc vfat fat mlx5_ib ib_uverbs ib_core acpi_ipmi ipmi_ssif
>>> ipmi_devintf ipmi_msghandler cppc_cpufreq drm xfs libcrc32c
>>> mlx5_core sg
>>> mlxfw crct10dif_ce tls ghash_ce sha2_ce sha256_arm64 sha1_ce sbsa_gwdt
>>> e1000e psample sdhci_acpi ahci_platform sdhci libahci_platform
>>> qcom_emac
>>> mmc_core hdma hdma_mgmt dm_mirror dm_region_hash dm_log dm_mod fuse
>>> [  390.110618] CPU: 42 PID: 5589 Comm: tee Kdump: loaded Not tainted
>>> 5.17.0-rc4-lu-v7-official+ #24
>>> [  390.119384] Hardware name: WIWYNN QDF2400 Reference Evaluation
>>> Platform CV90-LA115-P120/QDF2400 Customer Reference Board, BIOS
>>> 0ACJA570
>>> 11/05/2018
>>> [  390.132492] pstate: a0400005 (NzCv daif +PAN -UAO -TCO -DIT -SSBS
>>> BTYPE=--)
>>> [  390.139436] pc : iommu_device_unuse_default_domain+0x68/0x100
>>> [  390.145165] lr : iommu_device_unuse_default_domain+0x38/0x100
>>> [  390.150894] sp : ffff80000fbb3bc0
>>> [  390.154193] x29: ffff80000fbb3bc0 x28: ffff03c0cf6b2400 x27:
>>> 0000000000000000
>>> [  390.161311] x26: 0000000000000000 x25: 0000000000000000 x24:
>>> ffff03c0c7cc5720
>>> [  390.168429] x23: ffff03c0c2b9d150 x22: ffffb4e61df223f8 x21:
>>> ffffb4e61df223f8
>>> [  390.175547] x20: ffff03c7c03c3758 x19: ffff03c7c03c3700 x18:
>>> 0000000000000000
>>> [  390.182665] x17: 0000000000000000 x16: 0000000000000000 x15:
>>> 0000000000000000
>>> [  390.189783] x14: 0000000000000000 x13: 0000000000000030 x12:
>>> ffff03c0d519cd80
>>> [  390.196901] x11: 7f7f7f7f7f7f7f7f x10: 0000000000000dc0 x9 :
>>> ffffb4e620b54f8c
>>> [  390.204019] x8 : ffff03c0cf6b3220 x7 : ffff4ef132bba000 x6 :
>>> 00000000000000ff
>>> [  390.211137] x5 : ffff03c0c2b9f108 x4 : ffff03c0d51f6438 x3 :
>>> 0000000000000000
>>> [  390.218255] x2 : ffff03c0cf6b2400 x1 : 0000000000000000 x0 :
>>> 0000000000000000
>>> [  390.225374] Call trace:
>>> [  390.227804]  iommu_device_unuse_default_domain+0x68/0x100
>>> [  390.233187]  pci_dma_cleanup+0x38/0x44
>>> [  390.236919]  __device_release_driver+0x1a8/0x260
>>> [  390.241519]  device_driver_detach+0x50/0xd0
>>> [  390.245686]  unbind_store+0xf8/0x120
>>> [  390.249245]  drv_attr_store+0x30/0x44
>>> [  390.252891]  sysfs_kf_write+0x50/0x60
>>> [  390.256537]  kernfs_fop_write_iter+0x134/0x1cc
>>> [  390.260964]  new_sync_write+0xf0/0x18c
>>> [  390.264696]  vfs_write+0x230/0x2d0
>>> [  390.268082]  ksys_write+0x74/0x100
>>> [  390.271467]  __arm64_sys_write+0x28/0x3c
>>> [  390.275373]  invoke_syscall.constprop.0+0x58/0xf0
>>> [  390.280061]  el0_svc_common.constprop.0+0x160/0x164
>>> [  390.284922]  do_el0_svc+0x34/0xcc
>>> [  390.288221]  el0_svc+0x30/0x140
>>> [  390.291346]  el0t_64_sync_handler+0xa4/0x130
>>> [  390.295599]  el0t_64_sync+0x1a0/0x1a4
>>> [  390.299245] ---[ end trace 0000000000000000 ]---
>>>
>>>
>>> I put some traces in the code and I can see that
>>> iommu_device_use_default_domain() effectively is called on
>>> 0004:01:00.0 e1000e device on pci_dma_configure() but at that time
>>> the iommu group is NULL:
>>> [   10.569427] e1000e 0004:01:00.0: ------ ENTRY pci_dma_configure
>>> driver_managed_area=0
>>> [   10.569431] e1000e 0004:01:00.0: ****
>>> iommu_device_use_default_domain ENTRY
>>> [   10.569433] e1000e 0004:01:00.0: ****
>>> iommu_device_use_default_domain no group
>>> [   10.569435] e1000e 0004:01:00.0: pci_dma_configure
>>> iommu_device_use_default_domain returned 0
>>> [   10.569492] e1000e 0004:01:00.0: Adding to iommu group 3
>>>
>>> ^^^the group is added after the
>>> iommu_device_use_default_domain() call
>>> So the group->owner_cnt is not incremented as expected.
>>
>> Thank you for reporting this. Do you have any idea why the driver is
>> loaded before iommu_probe_device()?
>
> Urgh, this is the horrible firmware-data-ordering thing again. The
> stuff I've been saying about having to rework the whole .dma_configure
> mechanism in the near future is to fix this properly.
>
> The summary is that in patch #4, calling
> iommu_device_use_default_domain() *before* {of,acpi}_dma_configure is
> currently a problem. As things stand, the IOMMU driver ignored the
> initial iommu_probe_device() call when the device was added, since at
> that point it had no fwspec yet. In this situation,
> {of,acpi}_iommu_configure() are retriggering iommu_probe_device()
> after the IOMMU driver has seen the firmware data via .of_xlate to
> learn that it it actually responsible for the given device.

thank you for providing the info. Hope this is something Lu can work around.

Thanks!

Eric
>
> Robin.
>

