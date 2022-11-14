Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEB86280D9
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 14:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237925AbiKNNKD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 08:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237926AbiKNNKA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 08:10:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0E02B257;
        Mon, 14 Nov 2022 05:09:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35EA4B80EC3;
        Mon, 14 Nov 2022 13:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DB3C433D7;
        Mon, 14 Nov 2022 13:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668431386;
        bh=PvEnW3/dgb7M6jyRtGbgsIRe0xMSAxEh0nhMeyYw5/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lc4hAJ6hEbiVSg63MZ8BNyOJdfgskIIT10tF9Aj6o2ynVUYIoJ/QXxTzmxwaqX+qq
         I9Ce0tq7bRrAuCp2qTapSUSXSNFbWnYlVQ9YjXTkbiFa9iyOuoFnLj8N4+stpWwULi
         Q7Eej9pYnrJfPK4vit2NCKvTUI9k0fx32UD0PnuS4QrLJePWei8m5AddgTTAZSqXSv
         EmtGfVSv/pQfEZNmwW76WCOWFFPmU+dDBb2wqlW7UhpD5xzvj6ErSV0lQ8MNJvT/yT
         iqrASAcH+7up4cr5aVLVDLzWTeffkkz+raCToTV/ywH2u3f34dYMyYIuGnXfe9GnZ0
         WFU5OTZUAJq3w==
Date:   Mon, 14 Nov 2022 15:09:42 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, jianjay.zhou@huawei.com,
        zhuangshengen@huawei.com, arei.gonglei@huawei.com,
        yechuan@huawei.com, huangzhichao@huawei.com, xiehong@huawei.com
Subject: Re: [RFC 0/4] pci/sriov: support VFs dynamic addition
Message-ID: <Y3I+Fs0/dXH/hnpL@unreal>
References: <20221111142722.1172-1-longpeng2@huawei.com>
 <Y256ty6xGyUpkFn9@unreal>
 <0b2202bf-18d3-b288-9605-279208165080@huawei.com>
 <Y3Hoi4zGFY4Fz1l4@unreal>
 <d7327d46-deb5-dc75-21c3-1f351d7da108@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7327d46-deb5-dc75-21c3-1f351d7da108@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 14, 2022 at 08:38:42PM +0800, Longpeng (Mike, Cloud Infrastructure Service Product Dept.) wrote:
> 
> 
> 在 2022/11/14 15:04, Leon Romanovsky 写道:
> > On Sun, Nov 13, 2022 at 09:47:12PM +0800, Longpeng (Mike, Cloud Infrastructure Service Product Dept.) wrote:
> > > Hi leon,
> > > 
> > > 在 2022/11/12 0:39, Leon Romanovsky 写道:
> > > > On Fri, Nov 11, 2022 at 10:27:18PM +0800, Longpeng(Mike) wrote:
> > > > > From: Longpeng <longpeng2@huawei.com>
> > > > > 
> > > > > We can enable SRIOV and add VFs by /sys/bus/pci/devices/..../sriov_numvfs, but
> > > > > this operation needs to spend lots of time if there has a large amount of VFs.
> > > > > For example, if the machine has 10 PFs and 250 VFs per-PF, enable all the VFs
> > > > > concurrently would cost about 200-250ms. However most of them are not need to be
> > > > > used at the moment, so we can enable SRIOV first but add VFs on demand.
> > > > 
> > > > It is unclear what took 200-250ms, is it physical VF creation or bind of
> > > > the driver to these VFs?
> > > > 
> > > It is neither. In our test, we already created physical VFs before, so we
> > > skipped the 100ms waiting when writing PCI_SRIOV_CTRL. And our driver only
> > > probes PF, it just returns an error if the function is VF.
> > 
> > It means that you didn't try sriov_drivers_autoprobe. Once it is set to
> > true, It won't even try to probe VFs.
> > 
> > > 
> > > The hotspot is the sriov_add_vfs (but no driver probe in fact) which is a
> > > long procedure. Each step costs only a little, but the total cost is not
> > > acceptable in some time-sensitive cases.
> > 
> > This is also cryptic to me. In standard SR-IOV deployment, all VFs are
> > created and configured while operator booted the machine with sriov_drivers_autoprobe
> > set to false. Once this machine is ready, VFs are assigned to relevant VMs/users
> > through orchestration SW (IMHO, it is supported by all orchestration SW).
> > 
> > And only last part (assigning to users) is time-sensitive operation.
> > 
> The VF creation and configuration are also time-sensitive in some cases, for
> example, the hypervisor live update case (such as [1]):
>  save VMs -> kexec -> restore VMs
> 
> After the new kernel starts, the VFs must be added into the system, and then
> assign the original VFs to the QEMU. This means we must enable all 2K+ VFs
> at once and increase the downtime.
> 
> If we can enable the VFs that are used by existing VMs then restore the VMs
> and enable other unused VFs at last, the downtime would be significantly
> reduced.
> 
> [1] https://static.sched.com/hosted_files/kvmforum2022/65/kvmforum2022-Preserving%20IOMMU%20states%20during%20kexec%20reboot-v4.pdf

Like it is written in presentation, the standard way of doing it is done
by VFIO live migration feature, where 2K+ VMs are migrated to another server
at the time first server is scheduled for maintenance.

However, even in live update case mentioned in the presentation, you
should disable ALL PFs/VFs and enable ALL PFs/VFs at the same time,
so you don't need per-VF id enable knob.

> 
> > > 
> > > What’s more, the sriov_add_vfs adds the VFs of a PF one by one. So we can
> > > mostly support 10 concurrent calls if there has 10 PFs.
> > 
> > I wondered, are you using real HW? or QEMU SR-IOV? What is your server
> > that supports such large number of VFs?
> > 
> Physical device. Some devices in the market support the large number of VFs,
> especially in the hardware offloading area, e.g DPU/IPU. I think the SR-IOV
> software should keep pace with times too.

Our devices (and Intel too) support many VFs too. The thing is that
servers are unlikely to be able to support 10 physical devices with 2K+
VFs. There are many limitations that will make such is not usable.
Like, global MSI-X pool and PCI bandwidth to support all these devices.

> 
> > BTW, Your change will probably break all SR-IOV devices in the market as
> > they rely on PCI subsystem to have VFs ready and configured.
> > 
> I see, but maybe this change could be a choice for some users.

It should come with relevant driver changes and very strong justification why
such functionality is needed now and can't be achieved by anything else
except user-facing sysfs.

I don't see anything in this presentation and discussion that supports
need of such UAPI.

Thanks

> 
> > Thanks
> > .
