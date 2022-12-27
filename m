Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258B1657039
	for <lists+linux-pci@lfdr.de>; Tue, 27 Dec 2022 23:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiL0WcY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Dec 2022 17:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiL0WcX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Dec 2022 17:32:23 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1841007;
        Tue, 27 Dec 2022 14:32:22 -0800 (PST)
Message-ID: <d14ac29d-027a-08a7-c5c8-848a6920d4a2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1672180340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8WYNWbXfzoyFwDWcXKbRnpZVfJ9OY/dQehuzw7MIFM4=;
        b=nxndasFaXm1YuTov9pRzVioMIBfaE7p2g98O66Y8Apj2zP3SDDt8Ue7sfdUHydG/bkA21G
        Xl84HYUncFAeht0qOPgvRunRqOcm8MZhqimEbX4IBZHaczL/QcJZBTl880QWCKkvDrJPPV
        hZYJ5GM7yz4wGbCzfq1mJo0IgMz3WVo=
Date:   Tue, 27 Dec 2022 16:32:17 -0600
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: vmd: Do not disable MSI-X remapping in VMD 28C0
 controller
Content-Language: en-US
To:     Xinghui Li <korantwork@gmail.com>, Keith Busch <kbusch@kernel.org>
Cc:     nirmal.patel@linux.intel.com, lpieralisi@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
References: <20221222072603.1175248-1-korantwork@gmail.com>
 <3d1834d9-7905-1225-741a-f298dd5b8a8e@linux.dev>
 <Y6TSgGdCTvkwPiVg@kbusch-mbp.dhcp.thefacebook.com>
 <CAEm4hYUWf+Fx3FV7vNTc8+O9NSb0iQp75MTC6gra6XapXK=cxw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <CAEm4hYUWf+Fx3FV7vNTc8+O9NSb0iQp75MTC6gra6XapXK=cxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 12/23/2022 2:02 AM, Xinghui Li wrote:
> Keith Busch <kbusch@kernel.org> 于2022年12月23日周五 05:56写道：
>>
>> With 12 drives and only 6 CPUs, the bypass mode is going to get more irq
>> context switching. Sounds like the non-bypass mode is aggregating and
>> spreading interrupts across the cores better, but there's probably some
>> cpu:drive count tipping point where performance favors the other way.
> 
> We found that tunning the interrupt aggregation can also bring the
> drive performance back to normal.
> 
>> The fio jobs could also probably set their cpus_allowed differently to
>> get better performance in the bypass mode.
> 
> We used the cpus_allowed in FIO to fix 12 dirves in 6 different CPU.
> 
> By the way, sorry for emailing twice, the last one had the format problem.

The bypass mode should help in the cases where drives irqs (eg nproc) exceed
VMD I/O irqs. VMD I/O irqs for 28c0 should be min(63, nproc). You have
very few cpus for a Skylake system with that many drives, unless you mean you
are explicitly restricting the 12 drives to only 6 cpus. Either way, bypass mode
is effectively VMD-disabled, which points to other issues. Though I have also seen
much smaller interrupt aggregation benefits.
