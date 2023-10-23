Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07AC7D3DBE
	for <lists+linux-pci@lfdr.de>; Mon, 23 Oct 2023 19:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjJWRas (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Oct 2023 13:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbjJWRa2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Oct 2023 13:30:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A831FF6
        for <linux-pci@vger.kernel.org>; Mon, 23 Oct 2023 10:29:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4F3C433C7;
        Mon, 23 Oct 2023 17:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698082174;
        bh=2+hONU89DemXhRBKRzK5D1IJ54WGbWU18HcZam5AUhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q1GKrp8yyWW1ya6sXsQ16Xy3xZfZ1s0pVrmgvpfioRRt5f8Ru0ZlMykXvLQZlj60X
         RLMA/8K3/bcL0TtaYy5ASLUyCvO9kKzSWUufx3PvUOzeNMswxG24TPhwjOxsHr/RdJ
         zb4VDTUNsSl0X92FRYKRIGDn/tZN+CJMdWGSZ0Ha0avZqNTzpv6Ne6HPY//X4+Pw6N
         f99iqiqeq+mFveEqikIPQzGEiEQnB1GgIXuPquMoYqIi3Jd8y7SDFg+06Gn/gWd7O9
         vdZjCF96ai9+iucZHyfd0iJYbzGO1PkuudjaQjCIk+hvz8X5S2lvQj2eEliopyhlus
         imvnc87ZG9vbA==
Date:   Mon, 23 Oct 2023 18:29:29 +0100
From:   Will Deacon <will@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] PCI: host-generic: Convert to platform remove callback
 returning void
Message-ID: <20231023172929.GC4041@willie-the-truck>
References: <20231020092107.2148311-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231020092107.2148311-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 20, 2023 at 11:21:07AM +0200, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code.  However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> pci_host_common_remove() returned zero unconditionally. With that
> converted to return void instead, the generic pci host driver can be
> switched to .remove_new trivially.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pci/controller/pci-host-common.c  | 4 +---
>  drivers/pci/controller/pci-host-generic.c | 2 +-
>  include/linux/pci-ecam.h                  | 2 +-
>  3 files changed, 3 insertions(+), 5 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
