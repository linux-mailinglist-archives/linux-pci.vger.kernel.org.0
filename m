Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFE55F57DB
	for <lists+linux-pci@lfdr.de>; Wed,  5 Oct 2022 17:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiJEPy5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Oct 2022 11:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJEPyz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Oct 2022 11:54:55 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265601180F
        for <linux-pci@vger.kernel.org>; Wed,  5 Oct 2022 08:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=J/TjVImG9EYPyzs4mcUCVepZm5aOnxDKEIC/gFb5VVE=; b=GxJtMZxE87d+NotYeKgQQ9oOxF
        IMDRDISjWdNpvdnrkUl9GsWze+Z6K+87V4m1k9l+I/PSyJD+seBUTbXUyLNcZ6x3ymQziNCVePxZJ
        A7izry7n1EBLCyRTcFLESzdDjqGO1i4Ybg6Z+qQepXxz00GGza3YOLyaYBZ/AlP4fPp1wvn6WBha7
        YAyQpXKhQj4dkjOi/nyA3yfSkAtUKG7r0E2w1ziPejn1lqQ/n3oI4PxYRayaoGwNREUUvUvDrVY/Q
        5oAeUbOVA/YGrDHiiiVh0xCF2UmHfiMLHAUnayGihI1kTwOaRyuPP0HMBYnb51ceCR+hR7bwUL99z
        P0ONHLiQ==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1og6jS-0010l1-JG; Wed, 05 Oct 2022 09:54:51 -0600
Message-ID: <5d3b257a-c125-fdd6-e29f-229e54679f45@deltatee.com>
Date:   Wed, 5 Oct 2022 09:54:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
To:     Ramesh Errabolu <ramesh.errabolu@gmail.com>
Cc:     linux-pci@vger.kernel.org
References: <CAFGSPrzM_pRZ-JEWimKYDPzv76t_Nw2Q6od19S_3dzbG_0-bDA@mail.gmail.com>
 <014978f9-9ab6-7ef5-25e3-905bf1f7516b@deltatee.com>
 <CAFGSPrz2ym5oEot9gLi3Z38PWS5A_wCFM4OWk36U_RazDMR67A@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <CAFGSPrz2ym5oEot9gLi3Z38PWS5A_wCFM4OWk36U_RazDMR67A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: ramesh.errabolu@gmail.com, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: Understanding P2P DMA related errors
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-10-04 22:42, Ramesh Errabolu wrote:
> Hi,
> 
> Thanks for taking a look at this. I will see if I can add 0x09A2 to the
> whitelist and see what happens. But could you clarify my reading of the
> device tree. In the tree I don't see an AMD device attached to the
> 0x09A2 device. Is that a misread on my part? Would appreciate it if you
> could shed light on this aspect.

The two AMD devices are connected to the [0000:16] and [0000:64] buses
respectively both are Intel 09a2. I'm not sure if the whitelist code
will handle this topology. You may need to make more substantial changes
to handle it. If adding the device to the white list doesn't work you
can try disabling the check. If that all works then we'll need to
somehow add support for this topology.

Logan
