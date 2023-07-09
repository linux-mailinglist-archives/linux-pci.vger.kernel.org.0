Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B0474C4B8
	for <lists+linux-pci@lfdr.de>; Sun,  9 Jul 2023 16:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjGIOqx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Jul 2023 10:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGIOqw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jul 2023 10:46:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D986120
        for <linux-pci@vger.kernel.org>; Sun,  9 Jul 2023 07:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688913964;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rc5pEAkZCy2ECM6uSNrjq0WgYGvE6IB/Rm8veJW6Wi4=;
        b=KxQD2+6dGpsfQpJcN5KMzLE2Jrnd6xU6YARY2/L37Qf+WCZK0HtjLI/yKLL4665oqYt8RK
        22+naFM8NvWM60CCAJiGLEZD496r8FSVRGrPvFSKL1P4CpErp0S3CrBInkHYgCjcQSLj0T
        vo28U3f1QFI2Kwr6oK1afDvc4Hh+VkI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-6waJYl3DOGylirob8I0oug-1; Sun, 09 Jul 2023 10:46:02 -0400
X-MC-Unique: 6waJYl3DOGylirob8I0oug-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-765986c0521so316997185a.3
        for <linux-pci@vger.kernel.org>; Sun, 09 Jul 2023 07:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688913962; x=1691505962;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rc5pEAkZCy2ECM6uSNrjq0WgYGvE6IB/Rm8veJW6Wi4=;
        b=G3QMSZt8Zo62DQbptuZ6ovy3XHBTWSOAa5o/H+ziYu4I16xo5fQqVkD9li7LUk4Uuh
         bFbQ/N96XNfRU4HoGJ0oYOQ8YitaFstHLEQtyzpSSU7AY8mTT8yi9k05CX9HSeTtHPdF
         kV1VWV2UdzZjA5zdUur4Bpuc5hXtnJ1KxFypPc3YlhWFQae8JrFodpQVbTqO7Q5WY42j
         D+cqTnTAih9Vj4N8+k6UHb/h08k+J7NzrEbTt8Y+q/4vVKjJs5fxwTcERi4ZC4JXQGj/
         sVXYqXGihUs4Vm9xDm7Tx+Wlc0HIRuDHt3Q/nn2ECWpSS74RIlYcY2+p96ib7qQhQk4Z
         KGaQ==
X-Gm-Message-State: ABy/qLbGpARbz36EGZINXJEk35wfxdqALePGulw4rm4vykJs2Nk0AiGQ
        /GOpCl97K9z7AIdrgejimGe6gx6WPOjyAKTgP4fvcC6XdzWreupPKmKLUb6y9fLp62BNxebNPTi
        BrrPV+oqZcRT3NKABXLcv
X-Received: by 2002:a05:622a:164d:b0:401:e0b4:a946 with SMTP id y13-20020a05622a164d00b00401e0b4a946mr10017013qtj.8.1688913962274;
        Sun, 09 Jul 2023 07:46:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGRaBEWc4t/nDfFSIRPOg2LQmoIdo+hOeGApPhQxZlQKyqMGftaOW+iWs0nJmA8oPuS/rZ1Tg==
X-Received: by 2002:a05:622a:164d:b0:401:e0b4:a946 with SMTP id y13-20020a05622a164d00b00401e0b4a946mr10016996qtj.8.1688913961912;
        Sun, 09 Jul 2023 07:46:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id bq22-20020a05622a1c1600b003f364778b2bsm3961935qtb.4.2023.07.09.07.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 07:46:01 -0700 (PDT)
Message-ID: <ea62fb9c-2ca2-ec03-6dbd-ff853930eb47@redhat.com>
Date:   Sun, 9 Jul 2023 16:45:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH] PCI/VPD: Add runtime power management to sysfs interface
Content-Language: en-US
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230707151044.1311544-1-alex.williamson@redhat.com>
 <08e455b0-31a6-b379-ba8b-b9a2c0962e22@redhat.com>
 <20230709072632.30c09f1e.alex.williamson@redhat.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230709072632.30c09f1e.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alex,

On 7/9/23 15:26, Alex Williamson wrote:
> On Sun, 9 Jul 2023 13:50:35 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> Hi Alex,
>>
>> On 7/7/23 17:10, Alex Williamson wrote:
>>> Unlike default access to config space through sysfs, the vpd read and
>>> write function don't actively manage the runtime power management state
>>> of the device during access.  Since commit 7ab5e10eda02 ("vfio/pci: Move
>>> the unused device into low power state with runtime PM"), the vfio-pci
>>> driver will use runtime power management and release unused devices to
>>> make use of low power states.  Attempting to access VPD information in
>>> this low power state can result in incorrect information or kernel
>>> crashes depending on the system behavior.
>>>
>>> Wrap the vpd read/write bin attribute handlers in runtime PM and take
>>> into account the potential quirk to select the correct device to wake.  
>> This much improved the situation as it is more difficult to hit the
>> issue. Unfortunately after tens of attempts I was still able to hit a
>> kernel crash. The console output does not mention the VPD anymore but
>> PCI power management events (PME).
> Does combining this with an extended D3hot wakeup for the device make
> any difference, such as a5a6dd262469 ("PCI/PM: Extend D3hot delay for
> NVIDIA HDA controllers")?  Thanks,
I added

static void quirk_qlogic_nic_pm(struct pci_dev *dev)
{
        dev_info(&dev->dev, "****** %s", __func__);
        quirk_d3hot_delay(dev, 20);
}
DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_QLOGIC, PCI_ANY_ID,
                              PCI_CLASS_NETWORK_ETHERNET, 8,
                              quirk_qlogic_nic_pm)

and checked it was called, but I can still hit after 10's of iterations

[  152.788557] Modules linked in: xt_CHECKSUM xt_MASQUERADE xt_conntrack
ipt_REJECT nf_reject_ipv4 nft_compat nft_chain_nat nf_nat nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 nf
_tables nfnetlink rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache netfs
bridge stp llc rfkill vfat fat qedr ib_uverbs vfio_pci ib_core
vfio_pci_core vfio_iommu_type1 crct10dif_c
e ghash_ce vfio i2c_smbus sha1_ce ipmi_ssif ipmi_devintf nfsd
ipmi_msghandler thunderx2_pmu auth_rpcgss nfs_acl lockd grace sunrpc
ip_tables xfs libcrc32c sg ixgbevf ast drm_km
s_helper qede i2c_algo_bit drm_shmem_helper qed drm ixgbe e1000e mpt3sas
nvme nvme_core sha2_ce sha256_arm64 raid_class scsi_transport_sas
nvme_common crc8 mdio gpio_xlp i2c_xl
p9xx dm_mirror dm_region_hash dm_log dm_mod fuse
[  152.854119] CPU: 112 PID: 1416 Comm: kworker/112:7 Not tainted
6.4.0-vpd-upstream+ #57
[  152.862024] Hardware name: GIGABYTE R181-T90-00/MT91-FS1-00, BIOS F34
08/13/2020
[  152.869406] Workqueue: events_freezable pci_pme_list_scan
[  152.874810] pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS
BTYPE=--)
[  152.881760] pc : pci_generic_config_read+0x64/0xd8
[  152.886549] lr : pci_generic_config_read+0x28/0xd8
[  152.891328] sp : ffff80008cb23cb0
[  152.894630] x29: ffff80008cb23cb0 x28: 0000000000000000 x27:
0000000000000000
[  152.901756] x26: 0000000000000000 x25: 0000000000000001 x24:
ffff80008cb23d76
[  152.908881] x23: ffff000806331800 x22: 0000000000000044 x21:
ffff80008232d4c8
[  152.916006] x20: ffff80008cb23d24 x19: 0000000000000002 x18:
0000000000000000
[  152.923130] x17: 0000000000000000 x16: 0000000000000000 x15:
0000000000000001
[  152.930255] x14: ffffffffffffffff x13: 0000000000000000 x12:
0101010101010101
[  152.937379] x11: 7f7f7f7f7f7f7f7f x10: fefefefefefefeff x9 :
ffff8000807b3938
[  152.944504] x8 : fefefefefefefeff x7 : 0000000000000018 x6 :
000000000000007f
[  152.951628] x5 : 0000000000000000 x4 : ffff800090000000 x3 :
0000000000000000
[  152.958752] x2 : 0000000000000044 x1 : 0000000000c01044 x0 :
ffff800090c01044
[  152.965878] Call trace:
[  152.968312]  pci_generic_config_read+0x64/0xd8
[  152.972745]  pci_bus_read_config_word+0x84/0xe8
[  152.977264]  pci_read_config_word+0x30/0x50
[  152.981435]  pci_check_pme_status+0x70/0xa8
[  152.985606]  pci_pme_list_scan+0x84/0x158
[  152.989604]  process_one_work+0x1ec/0x488
[  152.993616]  worker_thread+0x48/0x400
[  152.997267]  kthread+0x10c/0x120
[  153.000492]  ret_from_fork+0x10/0x20
[  153.004063] Code: 52800000 a94153f3 a8c27bfd d65f03c0 (79400000)
[  153.010146] ---[ end trace 0000000000000000 ]---
[  153.014751] Kernel panic - not syncing: synchronous external abort:
Fatal exception
[  153.022395] SMP: stopping secondary CPUs
[  154.081107] SMP: failed to stop secondary CPUs 112,194
[  154.086236] Kernel Offset: 0x190000 from 0xffff800080000000
[  154.091796] PHYS_OFFSET: 0x80000000
[  154.095272] CPU features: 0x01800000,0a0140a1,08004203
[  154.100398] Memory Limit: none
[  154.103440] ---[ end Kernel panic - not syncing: synchronous external
abort: Fatal exception ]---


Eric



>
> Alex
>
>  
>> [  168.616700] CPU: 0 PID: 1409 Comm: kworker/0:5 Not tainted
>> 6.4.0-vpd-upstream+ #56
>> [  168.624257] Hardware name: GIGABYTE R181-T90-00/MT91-FS1-00, BIOS F34
>> 08/13/2020
>> [  168.631639] Workqueue: events_freezable pci_pme_list_scan
>> [  168.637032] pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS
>> BTYPE=--)
>> [  168.643982] pc : pci_generic_config_read+0x64/0xd8
>> [  168.648763] lr : pci_generic_config_read+0x28/0xd8
>> [  168.653542] sp : ffff80008caebcb0
>> [  168.656844] x29: ffff80008caebcb0 x28: 0000000000000000 x27:
>> 0000000000000000
>> [  168.663969] x26: 0000000000000000 x25: 0000000000000000 x24:
>> ffff80008caebd76
>> [  168.671094] x23: ffff0008063fd800 x22: 0000000000000044 x21:
>> ffff80008232d4c8
>> [  168.678218] x20: ffff80008caebd24 x19: 0000000000000002 x18:
>> 00000000000040fc
>> [  168.685342] x17: 00000000000040f8 x16: 0000000000000000 x15:
>> 0000000000000001
>> [  168.692466] x14: ffffffffffffffff x13: 0000000000000000 x12:
>> 0101010101010101
>> [  168.699590] x11: 7f7f7f7f7f7f7f7f x10: fefefefefefefeff x9 :
>> ffff8000807b3938
>> [  168.706714] x8 : fefefefefefefeff x7 : 0000000000000018 x6 :
>> 000000000000007f
>> [  168.713838] x5 : 0000000000000000 x4 : ffff800090000000 x3 :
>> 0000000000000000
>> [  168.720962] x2 : 0000000000000044 x1 : 0000000000c00044 x0 :
>> ffff800090c00044
>> [  168.728086] Call trace:
>> [  168.730520]  pci_generic_config_read+0x64/0xd8
>> [  168.734953]  pci_bus_read_config_word+0x84/0xe8
>> [  168.739471]  pci_read_config_word+0x30/0x50
>> [  168.743642]  pci_check_pme_status+0x70/0xa8
>> [  168.747813]  pci_pme_list_scan+0x84/0x158
>> [  168.751811]  process_one_work+0x1ec/0x488
>> [  168.755810]  worker_thread+0x48/0x400
>> [  168.759461]  kthread+0x10c/0x120
>> [  168.762678]  ret_from_fork+0x10/0x20
>> [  168.766245] Code: 52800000 a94153f3 a8c27bfd d65f03c0 (79400000)
>> [  168.772326] ---[ end trace 0000000000000000 ]---
>> [  168.776931] Kernel panic - not syncing: synchronous external abort:
>> Fatal exception
>> [  168.784574] SMP: stopping secondary CPUs
>> [  169.831001] SMP: failed to stop secondary CPUs 0,199
>> [  169.835955] Kernel Offset: 0x190000 from 0xffff800080000000
>>
>>
>> Thanks
>>
>> Eric
>>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>>> ---
>>>  drivers/pci/vpd.c | 34 ++++++++++++++++++++++++++++++++--
>>>  1 file changed, 32 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
>>> index a4fc4d0690fe..81217dd4789f 100644
>>> --- a/drivers/pci/vpd.c
>>> +++ b/drivers/pci/vpd.c
>>> @@ -275,8 +275,23 @@ static ssize_t vpd_read(struct file *filp, struct kobject *kobj,
>>>  			size_t count)
>>>  {
>>>  	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
>>> +	struct pci_dev *vpd_dev = dev;
>>> +	ssize_t ret;
>>> +
>>> +	if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0) {
>>> +		vpd_dev = pci_get_func0_dev(dev);
>>> +		if (!vpd_dev)
>>> +			return -ENODEV;
>>> +	}
>>> +
>>> +	pci_config_pm_runtime_get(vpd_dev);
>>> +	ret = pci_read_vpd(vpd_dev, off, count, buf);
>>> +	pci_config_pm_runtime_put(vpd_dev);
>>> +
>>> +	if (dev != vpd_dev)
>>> +		pci_dev_put(vpd_dev);
>>>  
>>> -	return pci_read_vpd(dev, off, count, buf);
>>> +	return ret;
>>>  }
>>>  
>>>  static ssize_t vpd_write(struct file *filp, struct kobject *kobj,
>>> @@ -284,8 +299,23 @@ static ssize_t vpd_write(struct file *filp, struct kobject *kobj,
>>>  			 size_t count)
>>>  {
>>>  	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
>>> +	struct pci_dev *vpd_dev = dev;
>>> +	ssize_t ret;
>>> +
>>> +	if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0) {
>>> +		vpd_dev = pci_get_func0_dev(dev);
>>> +		if (!vpd_dev)
>>> +			return -ENODEV;
>>> +	}
>>> +
>>> +	pci_config_pm_runtime_get(vpd_dev);
>>> +	ret = pci_write_vpd(vpd_dev, off, count, buf);
>>> +	pci_config_pm_runtime_put(vpd_dev);
>>> +
>>> +	if (dev != vpd_dev)
>>> +		pci_dev_put(vpd_dev);
>>>  
>>> -	return pci_write_vpd(dev, off, count, buf);
>>> +	return ret;
>>>  }
>>>  static BIN_ATTR(vpd, 0600, vpd_read, vpd_write, 0);
>>>    

