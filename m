Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A215953BC94
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 18:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbiFBQcB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 12:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237085AbiFBQcA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 12:32:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A036522299;
        Thu,  2 Jun 2022 09:31:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4507EB82045;
        Thu,  2 Jun 2022 16:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19E4C385A5;
        Thu,  2 Jun 2022 16:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654187515;
        bh=o1/UE/2FwTyImP8FROwobph4vczO7LLicB4FbxHXr7A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UIKsVABSlpXDB38aEPeRquKYp3dPPsOF/LCpsU11H05idiT3aYRnCWYsJ9R2kXDYQ
         GIGb5zSnPtzMFEzZh67z/LoxnFkh2c6O3zp6OKHdQTo9lesDvCLaS4GsPalSO16ydv
         7o02kQ8JYdNsVzJFx8/Rrh9akGcttUELkYanUqXV2e6jRfjeFQKTV112XBc8sB7055
         ZeWBU8QVHDmS9mtJpQrD5yKc+qlyPHxfgYq6mjrVWLg5fSX4KOp/4QK6gcC9b6qt29
         LhQ4quilGSjD4w8nh5IoOA9Djd79noUc9lNoUf1QypERewVzw0PBeix7p6rc6oYDmg
         +mDBbvJKjsO8g==
Date:   Thu, 2 Jun 2022 11:31:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Conor.Dooley@microchip.com
Cc:     palmer@rivosinc.com, gregkh@linuxfoundation.org, arnd@arndb.de,
        akpm@linux-foundation.org, sboyd@kernel.org,
        linux-pci@vger.kernel.org, mturquette@baylibre.com,
        paul.walmsley@sifive.com, kw@linux.com, linux-clk@vger.kernel.org,
        aou@eecs.berkeley.edu, lorenzo.pieralisi@arm.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Daire.McNamara@microchip.com, Lewis.Hanly@microchip.com,
        Cyril.Jean@microchip.com, robh@kernel.org
Subject: Re: [PATCH v4 1/1] MAINTAINERS: add polarfire rng, pci and clock
 drivers
Message-ID: <20220602163152.GA22276@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fffa1761-9636-f6bc-fff3-54b6a60f5c8d@microchip.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 02, 2022 at 04:39:08AM +0000, Conor.Dooley@microchip.com wrote:
> On 02/06/2022 02:55, Palmer Dabbelt wrote:

> > I'm adding a bunch of subsystem maintainers just to check again.  I
> > don't have any problem with it, just not really a RISC-V thing and don't
> > wan to make a mess.  I've stashed it over at palmer/pcsoc-maintainers
> > for now.
> > 
> > Sorry if I'm being overly pedantic about this one...
> 
> I don't mind. Maybe this should go via Andrew next cycle or w/e?
> There's obviously no hurry etc

My turn to be overly pedantic :)  IMHO there's no benefit in delaying
MAINTAINERS updates.  There's zero risk, and delaying only means
people will miss out on bug reports and other things they should learn
about.

Bjorn
