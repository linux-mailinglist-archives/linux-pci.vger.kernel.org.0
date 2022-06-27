Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6AA55C150
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 14:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbiF0NQR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jun 2022 09:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbiF0NQB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jun 2022 09:16:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF785AD;
        Mon, 27 Jun 2022 06:13:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FB39612AF;
        Mon, 27 Jun 2022 13:13:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5371CC3411D;
        Mon, 27 Jun 2022 13:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656335579;
        bh=KxQd/s6GCe+NWcPsgCZLFK40rFPNf7a/wVIlViwbl/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gUEh+UYZFfTXjVnNUnlNcOW6TiNlpvYR6c3SYIMVThWGemiWEGEzMvdDuSxWO2hlj
         69sOlsqRfkx2RuVENH9MRUFO2zGzns88JJdOf2BTZVkhsXlYPPh812OROviwzDp2+H
         3C8oLJU8WSEzjKAw4LjOosUp8Y1Rbj4AHKuCotU8=
Date:   Mon, 27 Jun 2022 15:12:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     helgaas@kernel.org, lorenzo.pieralisi@arm.com,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        jonathan.cameron@huawei.com, robin.murphy@arm.com,
        leo.yan@linaro.org, mark.rutland@arm.com, will@kernel.org,
        joro@8bytes.org, shameerali.kolothum.thodi@huawei.com,
        peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, john.garry@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-perf-users@vger.kernel.org, iommu@lists.linux-foundation.org,
        prime.zeng@huawei.com, liuqi115@huawei.com, james.clark@arm.com,
        zhangshaokun@hisilicon.com, linuxarm@huawei.com,
        alexander.shishkin@linux.intel.com,
        Yicong Yang <yangyicong@hisilicon.com>, acme@kernel.org
Subject: Re: [PATCH v9 0/8] Add support for HiSilicon PCIe Tune and Trace
 device
Message-ID: <Yrms2cI05O2yZRKU@kroah.com>
References: <20220606115555.41103-1-yangyicong@hisilicon.com>
 <af6723f1-c0c5-8af5-857c-af9280e705af@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af6723f1-c0c5-8af5-857c-af9280e705af@huawei.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 27, 2022 at 07:18:12PM +0800, Yicong Yang wrote:
> Hi Greg,
> 
> Since the kernel side of this device has been reviewed for 8 versions with
> all comments addressed and no more comment since v9 posted in 5.19-rc1,
> is it ok to merge it first (for Patch 1-3 and 7-8)?

I am not the maintainer of this subsystem, so I do not understand why
you are asking me :(

thanks,

greg k-h
