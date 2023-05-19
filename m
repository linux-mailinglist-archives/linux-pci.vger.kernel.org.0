Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0259E708DAD
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 04:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjESCMD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 May 2023 22:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjESCMB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 May 2023 22:12:01 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1419FE4A;
        Thu, 18 May 2023 19:11:59 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 5170B540B3A;
        Fri, 19 May 2023 02:11:59 +0000 (UTC)
Received: from pdx1-sub0-mail-a208.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B909554189B;
        Fri, 19 May 2023 02:11:58 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1684462318; a=rsa-sha256;
        cv=none;
        b=lFVuP0UoAneulIb7AnLiKzB/VWkoxfjRvq9wDf/gk5bJ0/rcRTYyHpH/RCpPhJl1iALLig
        jIq5PhCKmV8jrX5yowgbfX8NvUPZqRuxH0cNB6YdORheHKeCOn5J547NAy4R0ogBvUAMYJ
        u5GuLicKDmbbqa6WitM6R+0KA7BG9wwNdZ8E29aDbyL6NPNYU/GljD6b7v/zbkAWCqW6Hl
        hqsSRd1pLvsFcOms537k03oRCdCjSkEyBkl9xH0bcXJFiZCkgSCYpaCPCadPbnCx7gfiOP
        k4LSsgJE8zgAVzEseCnCWupQTZKhwh5O9p7tqtu8EOPXOUXqU7gQ9kd/AcwGYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1684462318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=UGS5YSwf/rGU2XZSGVPlNsADHYegr/4g6swrqUfHy7s=;
        b=7mShLIeClaqzPUCKIdjphAH2oWfX+GzrU/n0YYf5GZwnx6vBJGOz6Ud4sISM2FFCG8sl8Q
        6fA0t67d5XFZfEXlDgYKMRLtCiJTpLTzN7kWn7491KZ3Pl2u+AEaNvK34mXB711KlBME9t
        xeEGsFs5xgo2bLOw8lYwP11WKZq4TxmmwcrG2pccP/TTsJspxpaOopzyO52TBYIma1edIh
        uZ3rlsz3A3ndwiMOx/xgkMjJwidIzYl45rMtn6/mFjUOmuU4y7m/osfsrNZIrj3EibazMi
        TnR9uo4NkkvwQJAYBDmtnqSSOHK29gc80eTbecqV+m2fbBWL3ePRuYpWfgkA4A==
ARC-Authentication-Results: i=1;
        rspamd-5cdf8fd7d9-fw8rh;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Stupid-Trouble: 64a12e39217dfb73_1684462319114_247395351
X-MC-Loop-Signature: 1684462319113:2194989952
X-MC-Ingress-Time: 1684462319113
Received: from pdx1-sub0-mail-a208.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.127.59.19 (trex/6.8.1);
        Fri, 19 May 2023 02:11:59 +0000
Received: from offworld (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a208.dreamhost.com (Postfix) with ESMTPSA id 4QMr255946z9r;
        Thu, 18 May 2023 19:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1684462318;
        bh=UGS5YSwf/rGU2XZSGVPlNsADHYegr/4g6swrqUfHy7s=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=edgYCx8RTxJ0QaKA/sRny6kjo4yI+ie8V3T3tW3Jox9IGLLgUlCkCUW7GsXlG+fQt
         Dy7yqwu9j4WqawEvohkJsvU0mOTsv9Qd7SadnukmYuHAiZSmWE1qX5A6PuM/zoRbpm
         TBTJE4UzsqXG2EvTEN7GtbvfDe72pql0hx847aZO0IeAYYn6+ybr8QvRB4b8yJ4UiH
         vlCaeg3n9I70PEXabo2MdA9a7+MdQYUl8MiZukvF+LO9FKWqmHJY5CZ3vlLgqLzcFj
         w8FI+Ir/NVi31hL9ajSsQdWVlirdm4NCVOUg+SAuLbduizTKIzR134trbKguCnkJ5n
         kfq78sUTFUMdw==
Date:   Thu, 18 May 2023 18:38:46 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     LiuLele <liu.lele@qq.com>
Cc:     dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
        alison.schofield@intel.com, bhelgaas@google.com,
        bwidawsk@kernel.org, dan.j.williams@intel.com, helgaas@kernel.org,
        ira.weiny@intel.com, linux-acpi@vger.kernel.org,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, rostedt@goodmis.org,
        vishal.l.verma@intel.com
Subject: Re: CXL memory device not created correctly
Message-ID: <gbsxrcjtnf67jxpqmbn57nqoslpmjtuk2ycatmau3vfsmpvbrd@c2umpofn2hti>
References: <cec6a8f5-a284-4f46-1ada-4edd625a9a2e@intel.com>
 <tencent_D9D9D358330CA573E23D490C6EE13E0DC105@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <tencent_D9D9D358330CA573E23D490C6EE13E0DC105@qq.com>
User-Agent: NeoMutt/20230407
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 19 May 2023, LiuLele wrote:

>In my testing CXL device /sys/bus/cxl/devices/mem0  not created, and the get error messages :
>
>```
>cxl_pci 0000:0d:00.0: Failed to get interrupt for event Info log
>```
>
>My test environment is a qemu CXL emulator with qemu v8.0.0, Linux kernel v6.3.0.
>While with kernel 5.9.13,  /sys/bus/cxl/devices/mem0  can be created.

Yes, this can be annoying and would argue the probe should not error out.
Regardless, the actual qemu support is in Jonathan's tree:

https://gitlab.com/jic23/qemu/-/commit/a04e6476df363d1f6bc160577b30dda6564d3f67

Thanks,
Davidlohr
