Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E135F6A8D
	for <lists+linux-pci@lfdr.de>; Thu,  6 Oct 2022 17:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiJFP0a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 11:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiJFP0X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 11:26:23 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DE5BC463
        for <linux-pci@vger.kernel.org>; Thu,  6 Oct 2022 08:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=6Hn6Ee66CE6cPHbf2tkSYnH8VMRGntcwDmyAPrX66lY=; b=sH1PCnJiyJ8so92jgNRjQRi3sv
        udhXg5YuiiJBUPt8Ed1b1cUxcFQB4M7i5EejuT4DC7uIqubio3iIxXDDrkRJoZHZLvRH5Eaz4CWXd
        MPnzZZd3CgsoDM3lveV1Nt2K080pYaOQ61c7hyiYVmRwSeeOBLlc+QdemFObxNd6C7u6VrF1K2N48
        DeLzxgunOWwqDNDejW5HFf7zj96+xjlmE0QHMqqVlgRren4r1o0rEA+9G7XmCi8uNRnaOMTBbnpeY
        RqwucxLYk17ubd6Olc48nD5j1Ba+K6yNk9GGd7qpPdVDB+AwdyGn0AX7h1x17WHJ9FEQUzGo4B8yC
        4vn8RuhQ==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1ogSlN-001oWc-Pe; Thu, 06 Oct 2022 09:26:18 -0600
Message-ID: <a57803de-9356-810e-2cc3-fa06f08309d2@deltatee.com>
Date:   Thu, 6 Oct 2022 09:26:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-CA
To:     Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Cc:     linux-pci@vger.kernel.org, ramesh.errabolu@gmail.com
References: <5d3b257a-c125-fdd6-e29f-229e54679f45@deltatee.com>
 <20221006025653.3519854-1-Ramesh.Errabolu@amd.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20221006025653.3519854-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: Ramesh.Errabolu@amd.com, linux-pci@vger.kernel.org, ramesh.errabolu@gmail.com
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




On 2022-10-05 20:56, Ramesh Errabolu wrote:
> 
> Logan,
> 
> You are right about AMD devices connecting to buses [0000:16] and [0000:64].
> However I am unable to understand as to how you extend that to mean they
> belong to Intel 0x09A2.

Well the root bus in your tree is 09A2 and each of the 16 and 64 buses each 
have a 09A2. So it's my guess that 09A2 is the root complex it just shows 
up multiple times.

> Per my understanding I am expecting Root Complex enumerated as a device,
> with various other devices hanging off one or more ports/buses. In the
> PCIe device tree, I don't see that.
> 
> I see the [domain::bus] as the root of the AMD device. Furthermore I see
> Intel devices 0x09A2 hanging off the same domain::bus. I will take your
> word, but the way the root complex is reported could be less confusing.

Yup. Like I said, this is a bit strange. 

> If I could make a request, it will be very helpfulf for folks who don't
> dabble in this area with a simple cheat sheet plus write explaining with
> examples the various root complexes and the variou end-points hanging off
> of them.

I don't really know any more than you do here. You'd have to ask Intel what 
their newer topologies imply. They keep coming up with new ways to organize
things and its not clear what it means from a P2P perspective. 

But really what needs to happen is to verify P2PDMA works between ports and
find a way for the whitelist code to accept it if it does.

Logan
