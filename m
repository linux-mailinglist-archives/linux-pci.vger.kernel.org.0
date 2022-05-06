Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02BC51DE52
	for <lists+linux-pci@lfdr.de>; Fri,  6 May 2022 19:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444170AbiEFR1h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 May 2022 13:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444167AbiEFR1f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 May 2022 13:27:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E5123BD2;
        Fri,  6 May 2022 10:23:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C92A3620B2;
        Fri,  6 May 2022 17:23:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6385C385A8;
        Fri,  6 May 2022 17:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651857831;
        bh=nXZ3Q1jTbaZ/sK8x9V920nhEF4T7dJ3ktr0gnhCZATw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OfYs4mRhp6lLGqo13sQacwVW9iittAZ7SAI7kb+r6hxxdi/apElxndNV2zhleIjOa
         R19ikT+HJLadc/9Ye9/w48Cbh2j2zDiXP1448RufOjTjoKrwQLOpaYs7svQda8uNHl
         1yp0T2hge2QaBesrUXtuFaOu7mz+e+agAvK9ixsfGkCLNaHFlC3+EC8Cd5CNeCOX3J
         v498ZxqcSIobrgKGg/YVtjgFYXl3l/djT+e/iwLJwUmjgvQDs6QaZFv0sqApMzlbYU
         uRHapzwdExq7H7WLMD+rjjwqt1kgyHR0gJHvZWb9+1I3CwwnqPnicF0+eHdFs1YRp5
         atMpv+P/D1hUQ==
Date:   Fri, 6 May 2022 12:23:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Peng Liu <liupeng256@huawei.com>
Cc:     bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
        akpm@linux-foundation.org, logang@deltatee.com,
        martin.oliveira@eideticom.com, thunder.leizhen@huawei.com,
        axboe@kernel.dk, kch@nvidia.com, ming.lei@redhat.com,
        shinichiro.kawasaki@wdc.com, mcgrof@kernel.org,
        jiangguoqing@kylinos.cn, jpittman@redhat.com, dave@stgolabs.net,
        wangkefeng.wang@huawei.com, linux-block@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] include/linux/nodemask.h: create node_available()
 helper
Message-ID: <20220506172348.GA543299@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506015801.757918-2-liupeng256@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Subject line convention looks like "numa: ..."

On Fri, May 06, 2022 at 01:58:00AM +0000, Peng Liu wrote:
> Lots of code dose
               does

> 	node != NUMA_NO_NODE && !node_online(node)
> or
> 	node == NUMA_NO_NODE || node_online(node)
> so create node_available to do this to simplify code.
            node_available()

I'm not really sure what meaning "node_available" conveys, though.
Probably just because I don't understand NUMA.

Should the test for NUMA_NO_NODE be folded into node_state() or
node_online() directly instead of adding a new node_available()
interface?

NUMA_NO_NODE is -1.  It's not clear to me that node_state()/
node_isset()/test_bit() would do the right thing given -1.  I doubt
all node_online() callers ensure they don't pass NUMA_NO_NODE.

> --- a/include/linux/nodemask.h
> +++ b/include/linux/nodemask.h
> @@ -70,6 +70,7 @@
>   *
>   * int node_online(node)		Is some node online?
>   * int node_possible(node)		Is some node possible?
> + * int node_available(node)		Is some node available(online or NUMA_NO_NODE)?

Existing file generally fits in 80 columns; follow that lead unless
you have a really good reason.  E.g., maybe this?

  + * int node_available(node)		Node online or NUMA_NO_NODE
