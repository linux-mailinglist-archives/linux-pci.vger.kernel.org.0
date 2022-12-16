Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00F464EF31
	for <lists+linux-pci@lfdr.de>; Fri, 16 Dec 2022 17:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiLPQeA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Dec 2022 11:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbiLPQdg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Dec 2022 11:33:36 -0500
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54886DFE;
        Fri, 16 Dec 2022 08:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=pkOah91FWw2zIXdbgJ+5cGA7IqUInyi1ED6BkRpVt2w=; b=X4d2AWuAO7i4v62BNt8er3HKQ2
        JxeZ6nhPuYVs/A13U4Fy+driLai4ChNoyypKRPbE7KprX3sApBIb8H2laNevBq1G0RHfiLIZhabm6
        sb4I22hw+M9rp98ruQ8cryLH+V8SFTsGlnZMQMKskIMsOD8CGp17or9948uySAXTlY9H2W09oLmTG
        xMggJcCDFlk9HD4XP0Le3Vkrzz/OrYg1Eh9kNJR2plK2BhQHXeDrQs6Z4TxG07Iy2bmvWBVyro/3L
        g8M9WmeNVHLk9Eyo+gURK7ciAm7H0MbF32lHlyrdh+ka+ecYw2WIyQhRJU9kRHJhWUepJZHLay+dG
        2bY9/IaA==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1p6DeD-009ppe-5F; Fri, 16 Dec 2022 09:33:24 -0700
Message-ID: <9fdae348-3416-6227-e059-5cd70369e4be@deltatee.com>
Date:   Fri, 16 Dec 2022 09:33:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-CA
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20221216162126.207863-1-helgaas@kernel.org>
 <20221216162126.207863-3-helgaas@kernel.org>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20221216162126.207863-3-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: helgaas@kernel.org, kurt.schwemmer@microsemi.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v2 2/2] PCI: switchtec: Return -EFAULT for copy_to_user()
 errors
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-12-16 09:21, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> switchtec_dev_read() didn't handle copy_to_user() errors correctly: it
> assigned "rc = -EFAULT", but actually returned either "size", -ENXIO, or
> -EBADMSG instead.
> 
> Update the failure cases to unlock mrpc_mutex and return -EFAULT directly.
> 
> Fixes: 080b47def5e5 ("MicroSemi Switchtec management interface driver")
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Looks good to me thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Logan
