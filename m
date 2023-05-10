Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9AE6FE60B
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 23:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbjEJVSJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 May 2023 17:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjEJVSI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2023 17:18:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69FD2D57;
        Wed, 10 May 2023 14:18:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C82763187;
        Wed, 10 May 2023 21:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6407AC433D2;
        Wed, 10 May 2023 21:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683753486;
        bh=VCNTjcY6TGn4IZKxQIZHrLKokc7SqJrIfm9SgJpidDo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BWyVj5R5crj1X0h/tzLNbPQMGYGCApQJ5kRCDF9iOZZ9lF3Fp+CHSM21iDNb781N+
         /oBeDgWs9tv6+ceZoscB68UAWp21UV8XOuet+yCjrb2Z1jkYhasR6BFAKAkCBCajgN
         o62/6whNHyxsIfbAjsIoIXIV7I/g2ixsMCqKlp8k0jmWnbkZGGt+5Css3av785JZKd
         8TIiQkMOb61jibUqzq8mp4XmT79iEH6HP+VrCkd4IMdZl3xD5XXgV/YvCrDuMPQwT7
         mhThliUcuXvlT3MooemgJm1330hqZ16QiIUtyJt0eS+ae0FXHCqq2AqGwwfTJHqB2W
         L5DIftRr4QwBg==
Date:   Wed, 10 May 2023 16:18:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: rcar-host: add support for optional regulators
Message-ID: <ZFwKDDnWWDowYiIz@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVHydQUBD6+zyLneuczd-3ixFbcF5z0toxZmhePT+ShSw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 10, 2023 at 09:27:46AM +0200, Geert Uytterhoeven wrote:
> On Wed, May 10, 2023 at 8:59 AM Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
> ...

> >  static int rcar_pcie_probe(struct platform_device *pdev)
> >  {
> >         struct device *dev = &pdev->dev;
> >         struct rcar_pcie_host *host;
> >         struct rcar_pcie *pcie;
> >         u32 data;
> > -       int err;
> > +       int i, err;
> 
> unsigned int i?
> 
> >         struct pci_host_bridge *bridge;
> 
> The (lack of) reverse-Xmas-tree ordering is hurting my OCD, but that's
> not your fault...

I usually put things in order of use, with initializations from
parameters first.  Happily, that is often a pretty good approximation
of reverse-Xmas-tree, as it is here, so I'm all in favor of moving
"struct pci_host_bridge" up there :)

Bjorn
