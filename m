Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06988667BB2
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jan 2023 17:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238942AbjALQoy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 11:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240609AbjALQnI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 11:43:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B368A1B5
        for <linux-pci@vger.kernel.org>; Thu, 12 Jan 2023 08:37:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90CEEB81E3B
        for <linux-pci@vger.kernel.org>; Thu, 12 Jan 2023 16:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4224C433F0;
        Thu, 12 Jan 2023 16:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673541464;
        bh=VP+bv1sIlCedADn+6h8q+hg8D0YmhUlHd70hQ4kpwqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tp2xL2fldgwI76fxNbq8SyuEBGy0mMY9UFtf2AzTBtgXpiGS0fca72EyKIQpFxmLO
         +lgFdQjZ2hrPIVxgWqrC9bJYa6lCCye9J4zXqjmAmBe4fmuPrP+In4XxRg2HynQ3tM
         GQx42cOEBLNrtF86gQXA6ttgrku/gsGM/M1Dijaaf5dt59VvnAtH/BSWLIZUYJ28Hn
         QCMKpqbHreTsp3msBGssTuKexCgOwhulGa9qF13wgwDapXGUiuPuV0f8aPB+6vJh4y
         RnhMSd7sxx77GU00EmydD5e90/M+DV1ZCd3tCsk8SS90/Q2MSlQbSpj10OyF/mTkkF
         3Tw/4O8j3H0Mw==
Date:   Thu, 12 Jan 2023 09:37:41 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Julian =?iso-8859-1?Q?Gro=DF?= <julian.g@posteo.de>
Cc:     linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: Regression in Kernel 6.0: System partially freezes with "nvme
 controller is down"
Message-ID: <Y8A3VftFnNT7wjl0@kbusch-mbp.dhcp.thefacebook.com>
References: <d5d8d106-acce-e20c-827d-1b37de2b2188@posteo.de>
 <0d3206be-fae8-4bbd-4b6c-a5d1f038356d@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d3206be-fae8-4bbd-4b6c-a5d1f038356d@posteo.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 11, 2023 at 10:11:22PM +0000, Julian Groß wrote:
> 
> Currently, I am using git bisect to narrow down the window of possible
> commits, but since the issue appears seemingly random, it will take many
> months to identify the offending commit this way.

Unfortunately bisect may be our best option. Link loss like that usually
is a problem below the nvme driver level.
