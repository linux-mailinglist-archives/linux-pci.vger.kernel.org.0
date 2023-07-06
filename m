Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE94D74A44B
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jul 2023 21:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjGFTOd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jul 2023 15:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjGFTOc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2023 15:14:32 -0400
Received: from witt.link (witt.link [185.233.105.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EB21BE9
        for <linux-pci@vger.kernel.org>; Thu,  6 Jul 2023 12:14:30 -0700 (PDT)
Received: from [10.0.0.117] (p5489d081.dip0.t-ipconnect.de [84.137.208.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by witt.link (Postfix) with ESMTPSA id AE97C2A15EA;
        Thu,  6 Jul 2023 21:14:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witt.link; s=dkim;
        t=1688670868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pUkhUulZJEqKyvZCO7Cg3VxOdS/Dvtw+26GFjrednvY=;
        b=qlVD6DeSfr0CtY7cedBr+VO0pbaGEdpeJHw13yXS4WiejH0IS4hwk6f5QXpIZFQS45i1yk
        TJaUJwlRmsWs8DntqZB/fcbrIbvDarM0DUOovQQZ7OLUcg5fUezwphDh7fP/l+PY58RhKU
        61v7ckBMg1YnpMnJzbznxNBz7WmjDcqVM7UyXihmHDbk4NsLkKic1wjSZips1aaruhcv5g
        ptDoEBNoC0niYVi+cMxLWBg2MzqU7V25b5sZYaAHgkEKK3wwyY1Hxdof1mPFVVjSKSiGOp
        eA47YfIXrHOaMh0Eni7R8CaZDS+kiNMZ4ZeOiCiUbnizi9BZ3I8k5u0btJWJNw==
Message-ID: <6673c6a1-16ba-aaa4-707a-70d92d9751f6@witt.link>
Date:   Thu, 6 Jul 2023 21:14:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] PCI/ASPM: Add back L1 PM Substate save and restore
To:     david.e.box@linux.intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Thomas Witt <kernel@witt.link>, Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        Koba Ko <koba.ko@canonical.com>, linux-pci@vger.kernel.org
References: <20230627100447.GC14638@black.fi.intel.com>
 <20230627204124.GA366188@bhelgaas>
 <20230628064637.GF14638@black.fi.intel.com>
 <650f68a1-8d54-a5ad-079b-e8aea64c5130@witt.link>
 <20230628105940.GK14638@black.fi.intel.com>
 <4b47ec58-dc34-1129-4a50-baf2b84b0f53@witt.link>
 <8af8d82dd0dc69851d0cfc41eba6e2acb22d2666.camel@linux.intel.com>
 <20230630104154.GS14638@black.fi.intel.com>
 <7efaf5d9-9469-9710-8a04-1483bc45c8b6@witt.link>
 <098da63daae434f6ac0d34ea5303ccd8fb0435c1.camel@linux.intel.com>
Content-Language: en-US
From:   Thomas Witt <thomas@witt.link>
In-Reply-To: <098da63daae434f6ac0d34ea5303ccd8fb0435c1.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 05/07/2023 22:53, David E. Box wrote:
> Mika is now out on extended vacation. We still need a solution that will enable
> the L1 substate save/restore without breaking your system. I'd like to try to
> get the power consumption lowered on your system while suspended with s2idle.
> The s0ix self test script will really help to tell us where to start. You can
> provide the results in the bugzilla.
> 
> The other thing we can do is find out why it only breaks under S3. It could be
> timing related, so I've attached another patch to the bugzilla to test this.
> 
> https://bugzilla.kernel.org/attachment.cgi?id=304553
> 
> Please let me know if it works. Thanks.
> 
> David

Hi David,

I tried your patch, and I see no difference from Mika's. Still not 
coming back from suspend.

Thomas
