Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AAD625FAE
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 17:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbiKKQj1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 11:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbiKKQj0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 11:39:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E901EAC4;
        Fri, 11 Nov 2022 08:39:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E8506205E;
        Fri, 11 Nov 2022 16:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06AC4C433C1;
        Fri, 11 Nov 2022 16:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668184764;
        bh=51DZ/DhXy+o8eovZwCh/p1flVLy2+G6I4SyHU4iowK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b3fbS/O7BKscJ+M8MJ74btT9HHELO6n6NqYBnKLa9lSJ7SDJHvQMb7X7U9xRw6HY+
         OcD4Ns1Qxnedwal8xtlq0ri4t/1As6EizXlUI3045XOMdxaQ/PZevZ3gGzQGwSNJyz
         L4+n+asPryV4DpPC1znEAHqwa+2rL8mTVxyr4lTMKSXbfNkqUwdyknbNZzF86deUPA
         Ekvb3/sxJxbwmc99xPmCRFKYC1aubdoZYhrdz9t7DNma3PD/X+gbYEiNPAWICMC8YJ
         XhcitZFFrUjo5WvHjHT+DMBo9SecxD5zikrYLSEmMpxJEluccdskaQAjIJwQulLSNc
         S4jWJAHv37/ag==
Date:   Fri, 11 Nov 2022 18:39:19 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "Longpeng(Mike)" <longpeng2@huawei.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, jianjay.zhou@huawei.com,
        zhuangshengen@huawei.com, arei.gonglei@huawei.com,
        yechuan@huawei.com, huangzhichao@huawei.com, xiehong@huawei.com
Subject: Re: [RFC 0/4] pci/sriov: support VFs dynamic addition
Message-ID: <Y256ty6xGyUpkFn9@unreal>
References: <20221111142722.1172-1-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111142722.1172-1-longpeng2@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 10:27:18PM +0800, Longpeng(Mike) wrote:
> From: Longpeng <longpeng2@huawei.com>
> 
> We can enable SRIOV and add VFs by /sys/bus/pci/devices/..../sriov_numvfs, but
> this operation needs to spend lots of time if there has a large amount of VFs.      
>                                                             
> For example, if the machine has 10 PFs and 250 VFs per-PF, enable all the VFs
> concurrently would cost about 200-250ms. However most of them are not need to be
> used at the moment, so we can enable SRIOV first but add VFs on demand.

It is unclear what took 200-250ms, is it physical VF creation or bind of
the driver to these VFs?

If the latter, you can try with sriov_drivers_autoprobe set to true. This is how
ennoblement of large SR-IOV systems is done.

Also PCI spec declares "VF enable" bit, which is applicable to all VFs
associated to that PF, see section "9.3.3.3.1 VF Enable".

Thanks

> 
> This series introduces two interfaces:
> 1. sriov_numvfs_no_scan: enable SRIOV without add the VFs.
> 2. sriov_scan_vf_id: add a specific VF.
> 
> Longpeng (4):
>   pci/sriov: extract sriov_numvfs common helper
>   pci/sriov: add vf_bitmap to mark the vf id allocation
>   pci/sriov: add sriov_numfs_no_scan interface
>   pci/sriov: add sriov_scan_vf_id interface
> 
>  drivers/pci/iov.c | 162 +++++++++++++++++++++++++++++++++++++++++-----
>  drivers/pci/pci.h |   1 +
>  2 files changed, 148 insertions(+), 15 deletions(-)
> 
> -- 
> 2.23.0
> 
