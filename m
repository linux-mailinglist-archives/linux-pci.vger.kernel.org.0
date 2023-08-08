Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25676774224
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 19:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjHHRf4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 13:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbjHHRfd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 13:35:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAE797D5D
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 09:15:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 973FA62166
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 07:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7B1C433C8;
        Tue,  8 Aug 2023 07:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691481387;
        bh=neADDd1vZwFjQNQRa9xqHewGQOvBGcnQpVQrUa/in54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ndC3njM5PJwnLTcX9+AmJb3M8Hgb7ighXwFLymLrLJdYqH4cJJ+/0AthUWUBY4x0v
         jUf20uQoGpJkxRcaoc1zGRtcFyK5PZnVlLgz817hUjRswA3MZsxaiJqVSBfhGYIXui
         yr5h4uPJEuE7SnnDNQ40ppkWexA3ozkhzweUn6nAeUgXhioTFDavvb99IACszysG8K
         XdX4NueJUepSKi+sYkhK4GAnJghLsb8BoJeRnmjkPOU7Akt2STd2wqV+paBOgzmlBC
         w7HW8pbD/UVCYN58/EOue1PsWih4JSSZaI7LpQYJAuNgfWZ6NXuOWH4IUOLCu42TTB
         L3AyF1uQPDlHw==
Received: by pali.im (Postfix)
        id 15CB9687; Tue,  8 Aug 2023 09:56:24 +0200 (CEST)
Date:   Tue, 8 Aug 2023 09:56:23 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: mvebu: Mark driver as BROKEN
Message-ID: <20230808075623.lmhvotnzzjsz5r2o@pali>
References: <20230114164125.1298-1-pali@kernel.org>
 <ZMzicVQEyHyZzBOc@shell.armlinux.org.uk>
 <20230804134622.pmbymxtzxj2yfhri@pengutronix.de>
 <20230808072701.gx6apjnnrppv7sit@pali>
 <20230808073822.35vlao5bs6bo2b2n@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230808073822.35vlao5bs6bo2b2n@pengutronix.de>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 08 August 2023 09:38:22 Uwe Kleine-König wrote:
> Hello Pali,
> 
> On Tue, Aug 08, 2023 at 09:27:01AM +0200, Pali Rohár wrote:
> > On Friday 04 August 2023 15:46:22 Uwe Kleine-König wrote:
> > > On Fri, Aug 04, 2023 at 12:35:13PM +0100, Russell King (Oracle) wrote:
> > > > Uwe has a SATA controller for a bunch of disks in an Armada 370 based
> > > > NAS platform that is connected to PCIe, and removing PCIe support
> > > > effectively makes his platform utterly useless.
> > > 
> > > While this is true there is really a problem on my platform with
> > > accessing the hard disks via that pci controller and a 88SE9215 SATA
> > > controller. While it seems to work in principle, it's incredible slow.
> > 
> > Exactly those are things which randomly does not work.
> 
> I had this slow behaviour consistently on next-20230803 and
> next-20230804 was fine. I thought that meant that there was something
> fixed between these two trees. Do you suggest this is worth to
> investigate as it might just be some butterfly effect that made the
> problem go away?

These issues are there for a longer time, it started appearing after
5.15 lts version. And by your description it means that they were not
fixed yet.

> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |


