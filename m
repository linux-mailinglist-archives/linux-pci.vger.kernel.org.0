Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C14974236C
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jun 2023 11:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjF2JrI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jun 2023 05:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjF2JrG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jun 2023 05:47:06 -0400
Received: from witt.link (witt.link [185.233.105.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944D6E4C
        for <linux-pci@vger.kernel.org>; Thu, 29 Jun 2023 02:47:04 -0700 (PDT)
Received: from [10.0.0.117] (p5489d081.dip0.t-ipconnect.de [84.137.208.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by witt.link (Postfix) with ESMTPSA id 925592A0BC7;
        Thu, 29 Jun 2023 11:47:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witt.link; s=dkim;
        t=1688032021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mXrwk6OPA25L1dAdBnlGIsN1jegrsM6qTDE8dZA1k9o=;
        b=kQDfQTs7S+GdMUsMvEUsPPWqoEBJZXTFVuW3PElXTw4BjskhbIFYmwO03wgfSVp4obb5ou
        axRsX+TeaMo7aTTCLou+nhm3yu/wrg2HjKV3aQHGWVpA6zjFwrgNKH6KbQyGSfgcktIVTO
        Z+aYXDHuw/+fG4jsEEq8MZfxIbkJO4K3EFFJk/BbGAJFoeQqBlFITUHeWQMROg58tjjSYw
        5I/i3aCIqDxfYs/QdWUSZ8Kj6QlhUdLOfO94dw2D7BnWwgVLz/zitwgakthHVkgcc6rJwT
        KmE8g9soT+5e4dnCusLhErmjsqp+TDEG9xz8CVPTAYP5rM9ed4JF3StjOf23zQ==
Message-ID: <4b47ec58-dc34-1129-4a50-baf2b84b0f53@witt.link>
Date:   Thu, 29 Jun 2023 11:47:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] PCI/ASPM: Add back L1 PM Substate save and restore
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thomas Witt <kernel@witt.link>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        Koba Ko <koba.ko@canonical.com>, linux-pci@vger.kernel.org
References: <20230627100447.GC14638@black.fi.intel.com>
 <20230627204124.GA366188@bhelgaas>
 <20230628064637.GF14638@black.fi.intel.com>
 <650f68a1-8d54-a5ad-079b-e8aea64c5130@witt.link>
 <20230628105940.GK14638@black.fi.intel.com>
Content-Language: en-US
From:   Thomas Witt <thomas@witt.link>
In-Reply-To: <20230628105940.GK14638@black.fi.intel.com>
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

On 28/06/2023 12:59, Mika Westerberg wrote:
> I wonder if the patch actually helps here now because the reason we want
> to add it back is that it allows the CPU to enter lower power states and
> thus reducing the power consumption in S2idle too. Do you observe that
> when you have the patch applied?

No joy. I did not check what its actually doing, but the computer takes 
about 150mA over the charger at idle with screen off and 140mA in 
suspend. With mem_sleep set to "deep", it takes about 20mA in suspend. 
All with the battery at 100%, at 19.7V.

So I guess I want to keep the "deep" setting in my cmdline.

BR
Thomas

