Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C3C663249
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jan 2023 22:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238015AbjAIVJ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Jan 2023 16:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238100AbjAIVIx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2023 16:08:53 -0500
Received: from out-108.mta0.migadu.com (out-108.mta0.migadu.com [IPv6:2001:41d0:1004:224b::6c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1B026F4
        for <linux-pci@vger.kernel.org>; Mon,  9 Jan 2023 13:00:37 -0800 (PST)
Message-ID: <f05ee82a-4532-b12b-490f-904b946ff7b0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1673298035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mpz5QV62fd9Z/8dQCjZswuJCHVa8jPKuhq5d3gUONBY=;
        b=kjgDRTMPn7t5yVbfabYw3U4Bt86OfUO9sPG5HT3E7m0rSa22kXiU1LjNxmbaXzxeG5wCwC
        CwIoYRtI441fXya0QIcD1Dy5FSM5f3KcRh6qO/eaggEgJc1TrRwP4osowhvZwtMfH3jIO/
        1ui4TstB3NRV8yKFr3NDiPhKTs4WT58=
Date:   Mon, 9 Jan 2023 14:00:33 -0700
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: vmd: Do not disable MSI-X remapping in VMD 28C0
 controller
Content-Language: en-US
To:     Xinghui Li <korantwork@gmail.com>
Cc:     Keith Busch <kbusch@kernel.org>, nirmal.patel@linux.intel.com,
        lpieralisi@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xinghui Li <korantli@tencent.com>
References: <20221222072603.1175248-1-korantwork@gmail.com>
 <3d1834d9-7905-1225-741a-f298dd5b8a8e@linux.dev>
 <Y6TSgGdCTvkwPiVg@kbusch-mbp.dhcp.thefacebook.com>
 <CAEm4hYUWf+Fx3FV7vNTc8+O9NSb0iQp75MTC6gra6XapXK=cxw@mail.gmail.com>
 <d14ac29d-027a-08a7-c5c8-848a6920d4a2@linux.dev>
 <CAEm4hYXncuvL-Gk1aEZExrvkbx=N1aiOQNeNjFdB4443EbKNBA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <CAEm4hYXncuvL-Gk1aEZExrvkbx=N1aiOQNeNjFdB4443EbKNBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As the bypass mode seems to affect performance greatly depending on the specific configuration,
it may make sense to use a moduleparam to control it

I'd vote for it being in VMD mode (non-bypass) by default.

On 12/27/2022 7:19 PM, Xinghui Li wrote:
> Jonathan Derrick <jonathan.derrick@linux.dev> 于2022年12月28日周三 06:32写道：
>>
>> The bypass mode should help in the cases where drives irqs (eg nproc) exceed
>> VMD I/O irqs. VMD I/O irqs for 28c0 should be min(63, nproc). You have
>> very few cpus for a Skylake system with that many drives, unless you mean you
>> are explicitly restricting the 12 drives to only 6 cpus. Either way, bypass mode
>> is effectively VMD-disabled, which points to other issues. Though I have also seen
>> much smaller interrupt aggregation benefits.
> 
> Firstly，I am sorry for my words misleading you. We totally tested 12 drives.
> And each drive run in 6 CPU cores with 8 jobs.
> 
> Secondly, I try to test the drives with VMD disabled,I found the results to
> be largely consistent with bypass mode. I suppose the bypass mode just
> "bypass" the VMD controller.
> 
> The last one，we found in bypass mode the CPU idle is 91%. But in remapping mode
> the CPU idle is 78%. And the bypass's context-switchs is much fewer
> than the remapping
> mode's. It seems the system is watiing for something in bypass mode.
