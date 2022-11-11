Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D85626524
	for <lists+linux-pci@lfdr.de>; Sat, 12 Nov 2022 00:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbiKKXHJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 18:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiKKXHI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 18:07:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A869A10043;
        Fri, 11 Nov 2022 15:07:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A186B8280A;
        Fri, 11 Nov 2022 23:07:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5A9C433C1;
        Fri, 11 Nov 2022 23:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668208025;
        bh=AtyavD70yq8p5n3eMQenR0qcYb2AOclvoplL63PZfxg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Z2T/nebNripLE2jgqC4NPNq7dEYBUxdPRp35UBsyyxz17ASisnasE89B6QgfLHwr5
         X5ifsCBsEiqTqgKLNRQr7RzDvrZfZkvkMNsRNM78n0xwcq9ZoKYofUfjMNXxZPrDAY
         3ootNH6aE+kUEYywHNfoB5K5VCC9pumOJkI0PFVHOUu38LvKUtkuzGxvP5+wqWC4Zf
         YNbydP7OMkKDlW5DqbnLxDdBhtoJG5YJrJ/IWFEz+sGP/D6ZSUlWpRCywMXJBAGsig
         45eAyckmQWt8KCuSgeU3RcFCtcgYk+rcRwmfUTDXcjq4jUQDFJwrqvj5nMCao/HpuP
         yTwB+tKo1+8Pg==
Date:   Fri, 11 Nov 2022 17:07:03 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Longpeng(Mike)" <longpeng2@huawei.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, jianjay.zhou@huawei.com,
        zhuangshengen@huawei.com, arei.gonglei@huawei.com,
        yechuan@huawei.com, huangzhichao@huawei.com, xiehong@huawei.com
Subject: Re: [RFC 0/4] pci/sriov: support VFs dynamic addition
Message-ID: <20221111230703.GA759162@bhelgaas>
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

When you respond to Leon's questions, please also spend a little time
to look at the iov.c history and coding style and follow it, so we
don't have to waste time commenting on or fixing trivial things.

For example, there are no previous subject lines for that file that
start with "pci/sriov".  Don't make up a new prefix; use what's been
done in the past.  And follow the style of capitalizing the first word
after the prefix.

There are a few comments that look like they are more than 80 columns.
Again unlike everything else in the file.

The PCIe spec spells it "SR-IOV", not "sriov".  Do the same in your
commit logs and comments.

Capitalize "VF" consistently.  I see "VF" and "vf" used randomly.

Sysfs changes require documention updates, e.g., in
Documentation/ABI/testing/sysfs-bus-pci.
