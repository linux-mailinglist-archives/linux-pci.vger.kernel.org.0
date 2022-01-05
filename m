Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECDB48519B
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jan 2022 12:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbiAELHS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 06:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiAELHS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jan 2022 06:07:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1761C061761
        for <linux-pci@vger.kernel.org>; Wed,  5 Jan 2022 03:07:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93040B81A1C
        for <linux-pci@vger.kernel.org>; Wed,  5 Jan 2022 11:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2685EC36AE9;
        Wed,  5 Jan 2022 11:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641380835;
        bh=sTvjvc7SRhPO4NpWeCF5i9nrWPX91RVbSa286ZY+GSw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FqHWsXp22xTnGpizgEoVv9W8Q9FYvvrG0wU36dgoa32LxxhHgWKbJpFwxUAEVN5Ny
         h+N9Q/z54JY3H1O5n6X3tcCmIH50vhUDrYAPCnBI3SqP15EILp2C6dRKtPIbswedto
         7qJgk4TzLF13UMuUvT6T3MO4Pppxu/zWgmeNM4z1IiXkxLQlnv7uJ9u4Summvnr/Np
         Pld485erRUtuNyLXhgxWRPt/x0VF35IrHb5DqSh5DY6fGH8afLC1mBsmWGwWP0/uMl
         TJd99CMwbsurRqeHLZstykXyKNIRaNRRYvpj7k4HWgL6gGt6aAWtzMmMl7E9BACpEK
         yVV3jHm2Bru0A==
Date:   Wed, 5 Jan 2022 12:07:10 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org
Subject: Re: [PATCH 13/17] PCI: aardvark: Fix support for PME requester on
 emulated bridge
Message-ID: <20220105120710.2d44def8@thinkpad>
In-Reply-To: <20211208061851.31867-14-kabel@kernel.org>
References: <20211208061851.31867-1-kabel@kernel.org>
        <20211208061851.31867-14-kabel@kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed,  8 Dec 2021 07:18:47 +0100
Marek Beh=C3=BAn <kabel@kernel.org> wrote:

> +				dev_err_ratelimited(&pcie->pdev->dev, "unhandled ERR IRQ\n");

This should say "unhandled PME IRQ\n". Ah.
