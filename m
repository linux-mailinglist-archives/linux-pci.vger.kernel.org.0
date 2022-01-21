Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B8249622D
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 16:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381625AbiAUPfL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 10:35:11 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53288 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351194AbiAUPfJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 10:35:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72799B8204D
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 15:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C32C340E1;
        Fri, 21 Jan 2022 15:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642779307;
        bh=hTDBv1Suk/GGzitdriv+DT6bECkCdykuz4CaeDc7x2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nnbi4MSjjz/oqFoodYPiULjT4JAgOCl8Px2CeXd0JR2uOMZM+fF/Q9VzInINrsyze
         Tzop4JnPBaFiM4JkwBpkSw+biB7u+hbFKrOGwmUQ5mEoNrwpcbj5rZ2iMUa2T0iXfd
         /g/+iDc6qMU+uvn8jYH9iFWxeD2b55Yv063Vos2kaUrjOS3M1T3xpF2TwgZmFgGxuu
         ZwUuRrKE30N9/P2GfXHxZQKhXVJYC6ZeDq1g7PFl0AgAlaFgqk7+ciPrloUDKgEXrx
         mYkzm20Dp7ZsYA+IZyKHXpSPtTKthvCXYHpvY78nZBhb1NC9f076/RwxEGl3BFTtid
         LsK35fGvLhSHA==
Received: by pali.im (Postfix)
        id BCC39857; Fri, 21 Jan 2022 16:35:04 +0100 (CET)
Date:   Fri, 21 Jan 2022 16:35:04 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH pciutils 0/5] Support for PROGIF, REVID and SUBSYS
Message-ID: <20220121153504.yhpuztk6fza3sbnm@pali>
References: <20220121135718.27172-1-pali@kernel.org>
 <mj+md-20220121.143358.16196.nikam@ucw.cz>
 <20220121151246.3tlf5jdyh6jxeauv@pali>
 <mj+md-20220121.151403.26105.nikam@ucw.cz>
 <20220121152657.xsq5f5u6odsumbwp@pali>
 <mj+md-20220121.152905.30983.nikam@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mj+md-20220121.152905.30983.nikam@ucw.cz>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 21 January 2022 16:29:44 Martin Mareš wrote:
> > On Linux "class+subclass+prog_if" can be different than what is in
> > config registers and the purpose of this patch series with new fields is
> > to allow user to see difference in lspci.
> > 
> > On Windows access to real config space is not available for non-system
> > users.
> 
> Sure, I meant to read it from the config registers only if the back-end
> is unable to supply it.

And in case "class+subclass+prog_if" is available but "revision" is not
available and even it is not possible to read revision from config space
(because e.g. due to missing permissions or limitations of win backend)?
