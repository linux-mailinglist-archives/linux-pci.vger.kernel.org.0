Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C4D496246
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 16:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381645AbiAUPp3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 10:45:29 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34236 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240481AbiAUPp3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 10:45:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1127B6198C
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 15:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5218BC340E3;
        Fri, 21 Jan 2022 15:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642779928;
        bh=xcLL27WiFPZcgaweuINg8zKUpr0fta4/WWhxH18Z5Xg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qHYDFjCdqI9Yl/sF1ifUuBMoYizVz1mmkC4rc7UuOzU/LtTaHyzFwioZ3nfmQTrfd
         1C92kMZ7zbFwb80rdykqteBg7GBGaO3hJTBHfCoVxpFeD5vrjBGJaSfYD8RPHy/vYy
         hm0gB8OivLd/PlfMzEhKf6adcPpkGIXlGBDxbAa9Wk8dRqF9dugxDgmJeFLDLK3IP7
         Zw6jvHPEfhCOGvu+X3Wctex6Spxk5Y6tS9trINePpzkfg+8EnY8GKUy1WUnoxU9Wyp
         1eLh/q1VE7+2MOZ6Q6uLuB6oZyL/dA9dGUkE43g+lSZ1H810Vj4SlvpnhnMP7XgkZB
         kAwkKJyRi8Rtw==
Received: by pali.im (Postfix)
        id D5FA1857; Fri, 21 Jan 2022 16:45:25 +0100 (CET)
Date:   Fri, 21 Jan 2022 16:45:25 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH pciutils 0/5] Support for PROGIF, REVID and SUBSYS
Message-ID: <20220121154525.p7pg3d6erkg2ek6f@pali>
References: <20220121135718.27172-1-pali@kernel.org>
 <mj+md-20220121.143358.16196.nikam@ucw.cz>
 <20220121151246.3tlf5jdyh6jxeauv@pali>
 <mj+md-20220121.151403.26105.nikam@ucw.cz>
 <20220121152657.xsq5f5u6odsumbwp@pali>
 <mj+md-20220121.152905.30983.nikam@ucw.cz>
 <20220121153504.yhpuztk6fza3sbnm@pali>
 <mj+md-20220121.153534.32322.nikam@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mj+md-20220121.153534.32322.nikam@ucw.cz>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 21 January 2022 16:38:50 Martin Mareš wrote:
> > And in case "class+subclass+prog_if" is available but "revision" is not
> > available and even it is not possible to read revision from config space
> > (because e.g. due to missing permissions or limitations of win backend)?
> 
> I bet that nobody will ever check if reading of something as basic as the
> revision ID succeeded. It can never fail on sane systems.
> 
> In such cases, just return a default value and log a warning.

Ok! Sorry for a longer discussion as it is only corner case, but it can
happen (probably more often happens on windows) and therefore needs to
be somehow handled in the code.
