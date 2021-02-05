Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1964031119E
	for <lists+linux-pci@lfdr.de>; Fri,  5 Feb 2021 20:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbhBESPb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Feb 2021 13:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhBESPB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Feb 2021 13:15:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFB8C06174A;
        Fri,  5 Feb 2021 11:56:45 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612555004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=idPdMlfFtOd6nu/dAAxfHP59IryvoVRGIpXe2hyAuVs=;
        b=ow+Om3SQik3ioekenXmBLtaF/BTnMtuA3WZSy0LWc/T9EmoiU6ZvqbhZzqZLBPxfHVP2Co
        iRW0KaQxHIfLwY1SWSFcfyos1LBliXFxh5gz5Phn/P5n2ZeyYktmJ4NiyHfsFznoQkpcuq
        StJ6iY4qNpLlOOoVu4Fu9HRCY/b4AaDoIUu8iete4yaf0vKsRAREBKal94JezXVF8mMxoz
        Xowtyn6/B5SEWrPDcUNXAO+REkWeLyAsI8RetaxyGiSWvz3pbj+2W7L2DSB+hTmb5r1TqF
        gvg+FgbCZX/Aj4rp20tZzdyob5vRA/o8bgwuZaAqE0lIEflkUCc3Deuc6eVp1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612555004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=idPdMlfFtOd6nu/dAAxfHP59IryvoVRGIpXe2hyAuVs=;
        b=ozBiqs2cwS2JeylxHhF20WMTKVtPLnWVgPdPfWVW0pYXi0pHaot81q2z3H2sn8oF4gZSom
        wUPlxIxD/N2FiTCA==
To:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, frederic@kernel.org,
        juri.lelli@redhat.com, abelits@marvell.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        peterz@infradead.org, davem@davemloft.net,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        stephen@networkplumber.org, rppt@linux.vnet.ibm.com,
        jinyuqi@huawei.com, zhangshaokun@hisilicon.com
Subject: Re: [Patch v4 1/3] lib: Restrict cpumask_local_spread to houskeeping CPUs
In-Reply-To: <18584612-868c-0f88-5de2-dc93c8638816@redhat.com>
References: <20200625223443.2684-1-nitesh@redhat.com> <20200625223443.2684-2-nitesh@redhat.com> <3e9ce666-c9cd-391b-52b6-3471fe2be2e6@arm.com> <20210127121939.GA54725@fuller.cnet> <87r1m5can2.fsf@nanos.tec.linutronix.de> <20210128165903.GB38339@fuller.cnet> <87h7n0de5a.fsf@nanos.tec.linutronix.de> <d2a4dc97-a9ed-e0e7-3b9c-c56ae46f6608@redhat.com> <20210129142356.GB40876@fuller.cnet> <18584612-868c-0f88-5de2-dc93c8638816@redhat.com>
Date:   Fri, 05 Feb 2021 20:56:43 +0100
Message-ID: <875z368f0k.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 29 2021 at 09:35, Nitesh Narayan Lal wrote:
> On 1/29/21 9:23 AM, Marcelo Tosatti wrote:
>>> I am not sure about the PCI patch as I don't think we can control that from
>>> the userspace or maybe I am wrong?
>> You mean "lib: Restrict cpumask_local_spread to housekeeping CPUs" ?
>
> No, "PCI: Restrict probe functions to housekeeping CPUs".

That part is fine because it just moves the probing to a work queue on a
housekeeping CPU. But that has nothing to do with the interrupt
spreading library.

Thanks,

        tglx
