Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA252F1FCD
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jan 2021 20:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403814AbhAKTuW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jan 2021 14:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389440AbhAKTuV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jan 2021 14:50:21 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FE6C061786;
        Mon, 11 Jan 2021 11:49:41 -0800 (PST)
Received: from lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3237B9A8;
        Mon, 11 Jan 2021 19:48:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3237B9A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1610394540; bh=EozPVlZIs3bnnXIKn7dDr0mmHi5XdirNCyxTvjIj9uE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PALuxSnoS8Zs3fpNgecTI09xiv7NwxbzGbThKLcbZn0OwLfz/f85HMLF4pkH+Bh0S
         xOCAT8x5kzdjC6DaeAl+tDwZWJD9xczHoB0533HMDlPJTc3LFjs1wjJBzapB8Lj8vJ
         Crekpj+OtXlgSOZa/iV7V0O2D99K/J+Sc3rIKlU3f3I5IkIAHU0JwkJwUSOAZ7R8bR
         xYE1zThYgmvHl+zg8I6vfwmqo3HLkwnwq+Y3JYXbY6JXOczglR/+NSPlDSqvH4Hsyv
         wJFZxlYSB/svsWGzxBKtsMTAuLhtbZdSvPEWmWRO4jXyrd34sKG6RlknO8ACwxc9ue
         REcwd7vi+LDWg==
Date:   Mon, 11 Jan 2021 12:48:58 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Joe Perches <joe@perches.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        bhelgaas@google.com, robh+dt@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, m-karicheri2@ti.com, songxiaowei@hisilicon.com,
        wangbinghui@hisilicon.com, amurray@thegoodpenguin.co.uk,
        sathyanarayanan.kuppuswamy@linux.intel.com, hkallweit1@gmail.com,
        rafael.j.wysocki@intel.com, rdunlap@infradead.org,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] Documentation: Replace lkml.org links with lore
Message-ID: <20210111124858.2b35982c@lwn.net>
In-Reply-To: <77cdb7f32cfb087955bfc3600b86c40bed5d4104.camel@perches.com>
References: <20200627103050.71712-1-grandmaster@al2klimov.de>
        <20200630180917.GA3455699@bjorn-Precision-5520>
        <20200630140417.3a2dba67@lwn.net>
        <77cdb7f32cfb087955bfc3600b86c40bed5d4104.camel@perches.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 10 Jan 2021 12:41:44 -0800
Joe Perches <joe@perches.com> wrote:

> Replace the lkml.org links with lore to better use a single source
> that's more likely to stay available long-term.

Makes sense to me...applied, thanks.

jon
