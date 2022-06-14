Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D964454BDE0
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 00:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245450AbiFNWuY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jun 2022 18:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbiFNWuX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2022 18:50:23 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD7E506F8;
        Tue, 14 Jun 2022 15:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=K06cy4ftvMNN6/+Qjnf/5vgBuTtP0J6DzqdCK9WsUOI=; b=FmyxPYiCy6LPqNgy08F9Vto/fp
        cp7ggecrBFPsKLFG84e67Key4i7kiU9H4VKcW6HNu3eIeILoR8PIvm2qPbLz9yyCe8rGRrXfDfe5G
        xXNxpABz1F0eiB3ErdneeBGUAJn7zFSHNUCwVlwQbO6r/nCrJhz6e4qErPYDY5885IUosm3ljI0cq
        vtQo0PHvkOYqnO4d8A5uko1zTm+GPCeTBq3Rt/DO0Fg5HyDDXgUpw2aTDv29XYdhimVMfLJgj7QB7
        BYPYlNCyU3ru4KjZAF69ktCGHMzcwLB/dsyFd4ky4LsY1l3MFjgVgCDeu4N3qmAoE2YowegdaMPp6
        3K6qAALA==;
Received: from [37.209.163.134] (helo=[172.16.74.119])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1o1FLx-001skf-M0; Wed, 15 Jun 2022 00:49:41 +0200
Message-ID: <6eae37ce-dd44-9c32-3f68-2b4e102dce8e@igalia.com>
Date:   Tue, 14 Jun 2022 19:49:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] x86/PCI: Revert: "Clip only host bridge windows for E820
 regions"
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220614151708.GA756100@bhelgaas>
 <5c8923df-3d89-c7be-690d-fbef2c53eeb6@redhat.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <5c8923df-3d89-c7be-690d-fbef2c53eeb6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14/06/2022 12:47, Hans de Goede wrote:
> [...]
> 
> Have you looked at the log of the failed boot in the Steam Deck kernel
> bugzilla? Everything there seems to work just fine and then the system
> just hangs. I think that maybe it cannot find its root disk, so maybe
> an NVME issue ?
> 

*Exactly* that - NVMe device is the root disk, it cannot boot since the
device doesn't work, hence no rootfs =)

Patch looks great from my side, thanks !
cheers,


Guilherme
