Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D100C529B36
	for <lists+linux-pci@lfdr.de>; Tue, 17 May 2022 09:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241870AbiEQHmD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 03:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238993AbiEQHk4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 03:40:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963774991E;
        Tue, 17 May 2022 00:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 076FC60F9A;
        Tue, 17 May 2022 07:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56093C34100;
        Tue, 17 May 2022 07:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652773220;
        bh=1GMphxsy6bjIVoh6DDdhoMypOAa7uTUskHeD6nHAIPE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Cch60QK8tAM5c/5Iy4d62l3BI0i33ugZf01GCElZ/fCQt+cpLoBlCECy7annnP7ie
         JZ4qm1WMhig5wLBn/NJU4Miv2WhsNKaRUAxfyAt03vxAJNn1YXKaiz72X/t0nQ8Qp2
         7CXoROJMcovsWMtuMIxpBtGd32RCnbjAiDf2HNPdC0r2c0wFoFqdSXD6idmvx9j0O1
         1VALm0VpJPhykgWCo16l8uBFN7hXQWxD3k+cVDSFliLBEggIxyMaio4PDQWVsfrt1v
         ksPEWRQcA3izP2JC3PBPO8flmtd3hzd1zvMEnkmmVgblz26kV4TleoUl7Y8gy0SABJ
         AZzzeWbvjA/7A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220512211431.r23r6daua36lty7d@mobilestation>
References: <20220503205722.24755-1-Sergey.Semin@baikalelectronics.ru> <20220512001156.x6kqyhi3vjjpqch6@mobilestation> <20220512152705.GA2506@lpieralisi> <20220512171150.GA164627@thinkpad> <20220512211431.r23r6daua36lty7d@mobilestation>
Subject: Re: [PATCH v3 0/4] clk: Baikal-T1 DDR/PCIe resets and some xGMAC fixes
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?q?Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>
Date:   Tue, 17 May 2022 00:40:18 -0700
User-Agent: alot/0.10
Message-Id: <20220517074020.56093C34100@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Serge Semin (2022-05-12 14:14:31)
> On Thu, May 12, 2022 at 10:41:50PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, May 12, 2022 at 04:27:05PM +0100, Lorenzo Pieralisi wrote:
> > > So in short, this series has to go through the usual clock tree review
> > > process.
> > >=20
>=20
> I do know the normal procedure. But if patches concern different
> subsystems but for some reason inter-depended somehow it's ok to merge
> them in via a single repo. In my case the platform clock driver has
> been updated in a way so to support the reset-controls utilized in the
> PCIe driver altered in another patchset. So I didn't want to leave the
> kernel not working in the framework of my platform on any git hash
> state. That's why I asked to merge the patchsets in via the same repo.
> The kernel would be still buildable though.
>=20

Is it going to be broken if I merge the clk patches through clk tree?
Has it ever worked? Does the kernel still boot, just PCIe fails if the
patches are applied?
