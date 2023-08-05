Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8140B770E9A
	for <lists+linux-pci@lfdr.de>; Sat,  5 Aug 2023 09:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjHEH6D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Aug 2023 03:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjHEH6C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Aug 2023 03:58:02 -0400
Received: from witt.link (witt.link [185.233.105.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B057101
        for <linux-pci@vger.kernel.org>; Sat,  5 Aug 2023 00:58:00 -0700 (PDT)
Received: from [10.0.0.117] (p5082aeb4.dip0.t-ipconnect.de [80.130.174.180])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by witt.link (Postfix) with ESMTPSA id B03842BEC34;
        Sat,  5 Aug 2023 09:57:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witt.link; s=dkim;
        t=1691222268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l10MIReqKRYQ6OVgbsKPzfLHQNgDz0DXcxYdN2CYvnw=;
        b=NmfshdRDR9vuBuQiRzH57PQiQLbrDwdBcoJjRFQxUh2na9YoRGNCM8t91f2Nq3P6wYOV/4
        GyAyNC1ScPNkzDtF7fdshfrJ9gyZMSmn5l5hpVEdv9remfmKv8R5GeVqoHJcPKbpTYUNwN
        1oaP+aGzvrAG0y+o9AMGGzV4MELm1i/aNXdY9nwjOvrXhoDi6I/0foWjae7Q6UjIjGQmOZ
        dQFc4X83+6+lX6KSik46gQoyEo3PCPxkiOaFy/JYkv+FwAJL5ffFqA+TTaj6VjsYgsRVPc
        u1lu7Jla9DfM98lj/1TG70QrRcLeNHYV4vRIQiPMoewhrpjkC8x1ocV+Azb+RA==
Message-ID: <5d5dc59d-0ce0-c98c-c6c8-f1d748a8d968@witt.link>
Date:   Sat, 5 Aug 2023 09:57:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] PCI/ASPM: Add back L1 PM Substate save and restore
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     david.e.box@linux.intel.com, Thomas Witt <kernel@witt.link>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        Koba Ko <koba.ko@canonical.com>, linux-pci@vger.kernel.org
References: <20230627204124.GA366188@bhelgaas>
 <20230628064637.GF14638@black.fi.intel.com>
 <650f68a1-8d54-a5ad-079b-e8aea64c5130@witt.link>
 <20230628105940.GK14638@black.fi.intel.com>
 <4b47ec58-dc34-1129-4a50-baf2b84b0f53@witt.link>
 <8af8d82dd0dc69851d0cfc41eba6e2acb22d2666.camel@linux.intel.com>
 <20230630104154.GS14638@black.fi.intel.com>
 <7efaf5d9-9469-9710-8a04-1483bc45c8b6@witt.link>
 <098da63daae434f6ac0d34ea5303ccd8fb0435c1.camel@linux.intel.com>
 <6673c6a1-16ba-aaa4-707a-70d92d9751f6@witt.link>
 <20230731150128.GK14638@black.fi.intel.com>
Content-Language: en-US
From:   Thomas Witt <thomas@witt.link>
In-Reply-To: <20230731150128.GK14638@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,NO_DNS_FOR_FROM,T_SPF_HELO_TEMPERROR,
        T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 31/07/2023 17:01, Mika Westerberg wrote:
> Hi Thomas,
> 
> Thanks for trying that. Did you manage to try out the S0ix script David
> suggested? That should show us hopefully what is draining the battery in
> s2idle.

Hi Mika,

I did, with -s it gives

Your system does not support low power S0 idle capability.
Isolation suggestion:
Please check BIOS low power S0 idle capability setting.

with -r on

Your system did not achieve the runtime PC10 state during screen ON

additionally, it encounters a syntax error:
./s0ix-selftest-tool.sh: line 1182: wc:: syntax error in expression 
(error token is ":")

with -r off, it tries xset which fails due to a lack of xserver.

Thomas
