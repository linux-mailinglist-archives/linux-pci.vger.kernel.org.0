Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C426454FC
	for <lists+linux-pci@lfdr.de>; Wed,  7 Dec 2022 08:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiLGH57 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Dec 2022 02:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiLGH56 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2022 02:57:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C389527CC2;
        Tue,  6 Dec 2022 23:57:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DE78B815D4;
        Wed,  7 Dec 2022 07:57:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0A6C433C1;
        Wed,  7 Dec 2022 07:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670399874;
        bh=QIubHp3cNpcEzieEe4V2CpRX/GSoVpl49aRjbV0Dzzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I9rgaMxhx2b/hDw6MeXI4mKG8LxIMxeDPfrkmYjrT1bmz7ZzHbSiQ88zZ16wnLgnR
         d2fgfxoC2kl983o58Tc7k/qBRjtyAwMIfK1qZ8VLaeesGJ94K0VuW2vvetGPx7aIVl
         dZ40z0HCDvWHIZCwc5ffEcNZf7DPLQ+U76v8Dpuag63HkGrSukKfoZNhS04uFYAB/s
         meSmCgUwaNfvpHYVIQCZu7W5Xd/mV4GWOay4P8ix7HlEsvcGpaUF2ZQXADduaJNnMz
         72Flyg+CQk0wAJ7yiDX3xyjDtZWodhnUNkQR6z9deLqhil4SuUoHtJun2k0i6UfeaC
         jP6NZtFD3gn0A==
Received: by pali.im (Postfix)
        id 1447A9D7; Wed,  7 Dec 2022 08:57:51 +0100 (CET)
Date:   Wed, 7 Dec 2022 08:57:50 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] PCI: aardvark: switch to using
 devm_gpiod_get_optional()
Message-ID: <20221207075750.6usm4mgejtpcrktw@pali>
References: <Y3KMEZFv6dpxA+Gv@google.com>
 <Y4/s3227WQyGQiOI@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y4/s3227WQyGQiOI@google.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 06 December 2022 17:31:11 Dmitry Torokhov wrote:
> On Mon, Nov 14, 2022 at 10:42:25AM -0800, Dmitry Torokhov wrote:
> > Switch the driver to the generic version of gpiod API (and away from
> > OF-specific variant), so that we can stop exporting
> > devm_gpiod_get_from_of_node().
> > 
> > Acked-by: Pali Rohár <pali@kernel.org>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> > 
> > v2:
> >  - collected reviewed-by/acked-by tags
> >  - updated commit description to remove incorrect assumption of why
> >    devm_gpiod_get_from_of_node() was used in the first place
> > 
> > This is the last user of devm_gpiod_get_from_of_node() in the mainline
> > (next), it would be great to have it in so that we can remove the API in
> > the next release cycle.
> > 
> > Thanks!
> 
> Gentle ping on this one... I'd really like to remove
> [devm_]gpiod_get_from_of_node() API from 6.2.
> 
> Thanks.
> 
> -- 
> Dmitry

Hello Dmitry! You would need to wait with your change. There are more
important fixes and less important cleanups for this aardvark driver
which are waiting in the queue for longer time:
https://patchwork.kernel.org/project/linux-pci/list/?series=&submitter=&state=&q=aardvark&archive=&delegate=
