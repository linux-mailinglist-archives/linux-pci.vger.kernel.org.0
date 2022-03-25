Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CCC4E6D26
	for <lists+linux-pci@lfdr.de>; Fri, 25 Mar 2022 05:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236938AbiCYEVA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Mar 2022 00:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiCYEU7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Mar 2022 00:20:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E585D46B0F;
        Thu, 24 Mar 2022 21:19:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80BC261889;
        Fri, 25 Mar 2022 04:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C059EC340E9;
        Fri, 25 Mar 2022 04:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648181965;
        bh=M+30WQWFiWcxarQLidDh8zL22qXkHedtyeYWaeVHqdk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=MzviDmJuZnlAlivadEOUaJX+unFykST9QGoLMglYB+8OA+JVvHCxs8vhOm7yAxSuw
         wqXgW9lmU6mrwCb+cjUGhRNoQxlCOGUCZFOttM0QzI+qYauC6dNW9dxhsdEtDmO/4m
         85gGWlBULP0K7N4k6yCGsu1/O9nqJsokjHE48r5VFFJ8dmE+A6e+msCch3QOVeabHY
         u17x/tCU1wHxHTDtjYThyz1K4KYzAZQYbIx/34jhz/plTcgVyg6+maJqDEyYAPtE1x
         81jFfYjAjrDt0NuldufpGjborSfarhuodqSrTqUJ1PoBRzEM0sJzr6T9fXZ/Vul6I5
         FVeNxbA40FR+Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220324010905.15589-4-Sergey.Semin@baikalelectronics.ru>
References: <20220324010905.15589-1-Sergey.Semin@baikalelectronics.ru> <20220324010905.15589-4-Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH 3/4] clk: baikal-t1: Move reset-controls code into a dedicated module
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?q?Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Date:   Thu, 24 Mar 2022 21:19:23 -0700
User-Agent: alot/0.10
Message-Id: <20220325041925.C059EC340E9@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please Cc reset maintainer on reset patches (Philipp Zabel <p.zabel@pengutr=
onix.de>)

Quoting Serge Semin (2022-03-23 18:09:04)
> Before adding the directly controlled resets support it's reasonable to
> move the existing resets control functionality into a dedicated object for
> the sake of the CCU dividers clock driver simplification. After the new
> functionality is added clk-ccu-div.c would have got to a mixture of the
> weakly dependent clocks and resets methods. Splitting the methods up into
> the two objects will make code easier to read especially seeing it isn't
> that hard to do.
>=20
> As before the CCU reset module will support the trigger-like CCU resets
> only, which are responsible for the AXI-bus, APB-bus and SATA-ref blocks
> reset. The assert/de-assert-capable reset controls support will be added
> in the next commit.
>=20
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
