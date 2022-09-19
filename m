Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE555BD3BF
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 19:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiISRcn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 13:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiISRcm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 13:32:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238FD31DC2;
        Mon, 19 Sep 2022 10:32:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1AEF61BD4;
        Mon, 19 Sep 2022 17:32:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE097C433C1;
        Mon, 19 Sep 2022 17:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663608760;
        bh=TB+0gRSIN5rcKrjh40MuTk8n8S3NBnRNudCQ11g3VQY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=O0pmtZQoaOtjsmjSOBs8DglqGNou81tOxyfEbcewNAAhJntyY/ukqaKZpN2xNC6GP
         tS3s9K9ayax6mIIcNAVRTzkFymC6+r47W+ZVjfeJpgInWCg7bdvQZWK+OylIKmk7Kw
         HvtKXvYFQZCcPYskb5yJSQ8O1WNzqKrRBSeHkHOVAOpeCj+0vyQvY+SmYfrMc6LrI5
         iSHHzfSHrIrm8Orx94SzEKUj1UaJPgNW2cwLCHi7pYe67n2yNhq8TAK/G8SJE3JbGv
         JaiTD6X7YtyRAn2klgr5xoZM2qGXwynR99CewVitDEQJk+DB8cIYxJpmerQFp9x4iW
         Zzs2bZQ2StdQw==
Date:   Mon, 19 Sep 2022 12:32:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     acme@kernel.org, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, leo.yan@linaro.org,
        james.clark@arm.com, will@kernel.org, mathieu.poirier@linaro.org,
        mark.rutland@arm.com, suzuki.poulose@arm.com,
        jonathan.cameron@huawei.com, john.garry@huawei.com,
        mike.leach@linaro.org, gregkh@linuxfoundation.org,
        lorenzo.pieralisi@arm.com, shameerali.kolothum.thodi@huawei.com,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-perf-users@vger.kernel.org, prime.zeng@huawei.com,
        zhangshaokun@hisilicon.com, linuxarm@huawei.com,
        yangyicong@hisilicon.com, liuqi6124@gmail.com
Subject: Re: [PATCH v13 3/3] perf tool: Add support for parsing HiSilicon
 PCIe Trace packet
Message-ID: <20220919173238.GA1014074@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919090045.6778-4-yangyicong@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 19, 2022 at 05:00:45PM +0800, Yicong Yang wrote:
> From: Qi Liu <liuqi115@huawei.com>
> 
> Add support for using 'perf report --dump-raw-trace' to parse PTT packet.
> 
> Example usage:
> 
> Output will contain raw PTT data and its textual representation, such
> as:
> 
> 0 0 0x5810 [0x30]: PERF_RECORD_AUXTRACE size: 0x400000  offset: 0
> ref: 0xa5d50c725  idx: 0  tid: -1  cpu: 0
> .
> . ... HISI PTT data: size 4194304 bytes
> .  00000000: 00 00 00 00                                 Prefix
> .  00000004: 08 20 00 60                                 Header DW0
> .  00000008: ff 02 00 01                                 Header DW1
> .  0000000c: 20 08 00 00                                 Header DW2
> .  00000010: 10 e7 44 ab                                 Header DW3
> .  00000014: 2a a8 1e 01                                 Time
> .  00000020: 00 00 00 00                                 Prefix
> .  00000024: 01 00 00 60                                 Header DW0
> .  00000028: 0f 1e 00 01                                 Header DW1
> .  0000002c: 04 00 00 00                                 Header DW2
> .  00000030: 40 00 81 02                                 Header DW3
> .  00000034: ee 02 00 00                                 Time

This is great!  Is there a way to actually decode the TLP headers?
E.g., something along the lines of what this does?
https://github.com/NetTLP/wireshark-nettlp/blob/master/plugins/nettlp.lua

If there is, it might be nice if the commit log included a hint about
how to do more decoding.

Bjorn
