Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52DD5463530
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 14:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbhK3NTT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 08:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhK3NTQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 08:19:16 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2E0C061574
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 05:15:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 77DB1CE19D8
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 13:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1803C53FC7;
        Tue, 30 Nov 2021 13:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638278151;
        bh=MMmBdPAZNAlMH/SpZK89ywvP+E58NwMbdWWPno6Efy8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QmEyxlkhgWis2WiahEJ7BHFVtK2IdtepzR0g0UHne858jqFEFHGtjBIq0Zk/nr4c1
         1iwIbOFTXUDpr1H2QKtwyrUadPAkkQ/zyW07IsqMxW98r13ntY7nO+bcF/Hv2mEfoo
         c3xCIk+vzPIp81EbUslWjugudkiy6ZW6NZAk9RTYoEkfiWwtKNZH3zr2TYnbm/LWrr
         f981Pcc/thdSEj81/8tGBC82Yw7/XKeGOEmGA1fVLN50d+X6LoLQ0GBFTRiw4a3b2j
         OcfcoQm8ew5iOynR7vA3a9ferr0Lk+vsE+oLg2f+vcfnM8pUmVPdcAahTvCVQZZPkx
         AuZBbdr8kBieg==
Date:   Tue, 30 Nov 2021 14:15:47 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 02/11] PCI: pci-bridge-emul: Add definitions for
 missing capabilities registers
Message-ID: <20211130141547.32e9d950@thinkpad>
In-Reply-To: <20211130124326.nbsqy5bgfgyccor5@pali>
References: <20211130123621.23062-1-kabel@kernel.org>
        <20211130123621.23062-3-kabel@kernel.org>
        <20211130124326.nbsqy5bgfgyccor5@pali>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 30 Nov 2021 13:43:26 +0100
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> This patch is old version which does not reflect all reserved bits. Few
> days ago I have sent new version of this patch in patch series with
> other pci-bridge-emul.c related fixes:
>=20
> https://lore.kernel.org/linux-pci/20211124155944.1290-4-pali@kernel.org/

Pali, Lorenzo, let us define priorities for Lorenzo:

I will send v3 of this series with this one patch replaced with new
version. This series will have the most priority for Lorenzo.

Afterwards let's send another version (v2) of
  PCI: pci-bridge-emul: Various fixes
with this patch removed (since it will be merged via aardvark).
This series will have second priority.

After that Lorenzo will look at mvebu patches.

Is that ok?

Marek
