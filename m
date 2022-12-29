Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F1465902F
	for <lists+linux-pci@lfdr.de>; Thu, 29 Dec 2022 19:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbiL2SNl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Dec 2022 13:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiL2SNk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Dec 2022 13:13:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB05813CD3;
        Thu, 29 Dec 2022 10:13:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99AA4B81A26;
        Thu, 29 Dec 2022 18:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304B2C433D2;
        Thu, 29 Dec 2022 18:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672337616;
        bh=usORqHciyFUalESiER55B7VFdgT4QAkx64KL27S0Gjs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oOle2ajE2r1i8AIwwtR4Xcv8pq8zt1WzFElaAb9R+2zB2NMsYC3M2vMAT6LU19EvA
         8GOb1NnBQEyGmafBrxNaPr5hQx8U0xGqwX5F3EwZEZnNkJpdetmeZ3ZVhf6LGJIY4r
         PlrrngObTMT2ad4b2jxY5Jmh6WQKdiCWECga8eP6JukGyuG/ap+YTaOJtua0iMMdBk
         z1oi6asC60n5CC4U+CfwSZF40Abl2Jpbl6uGYv3hNekZrZSb9FNIxQNqLuR1VGNOla
         IYTuW/xMIXCmrF21qEijQODtXr9gGCGQrAavV9cbF3TD8Wt1IYtp7P32CNFEiG4uQ8
         yyAb74VeWQudA==
Date:   Thu, 29 Dec 2022 12:13:34 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "mstowe@redhat.com" <mstowe@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Xiao Yang <yangx.jy@fujitsu.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: blktests failures with v5.19-rc1
Message-ID: <20221229181334.GA616694@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219112703.rlqdo33ncgmuowfm@shindev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 19, 2022 at 11:27:03AM +0000, Shinichiro Kawasaki wrote:
> Bjorn, FYI. This lockdep warning disappeared with kernel version
> v6.1. I bisected and found the commit 2d7f9f8c1815 ("kernfs: Improve
> kernfs_drain() and always call on removal.") avoided the issue. This
> commit touches kernfs_drain() and __kernfs_remove(), and modifies
> the condition to lock kernfs_rwsem. I think it explains why the
> lockdep disappeared. No longer need to work on this issue :)

Thanks for following up on this!

Bjorn
