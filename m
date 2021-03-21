Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF285343379
	for <lists+linux-pci@lfdr.de>; Sun, 21 Mar 2021 17:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhCUQdU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Mar 2021 12:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhCUQdM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Mar 2021 12:33:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29774C061574
        for <linux-pci@vger.kernel.org>; Sun, 21 Mar 2021 09:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=czEYkjs02RLR7OqUXvj7zahX+mqU9KO5dmAgYTID9To=; b=dPW26Kp4PVbv/Uy8vl/OkSP8x9
        SotpH2BX0U+weKF3d0FwZ2Njh9DZXp4bZJuswDGC9d0+s6KGaGBKZQrN8M0Va4iy+RfDHjIWzrAVW
        /91lG41xwQLG7D701MQ3WilQp9u4yJ2agDzixkgHHa5lb0a0MO3yD2PdADS9Usau/OuBTvCDX9dT+
        LfIVt6aYunDUNzCYjtAKOvTXXaveK3Vsir7H2MKum0ofvKn+Gn51FzP7KqaT/1vSRIXjwu3tTeALE
        XO6rjjD1ZzNHKNAgoejHKONsDw3qycZcHAfQZcQ8ZO/YqXKz9QWizixPapld7AsJBGwXkm59bbhId
        QYy3fqNQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lO10S-007Jyq-8Q; Sun, 21 Mar 2021 16:32:49 +0000
Date:   Sun, 21 Mar 2021 16:32:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Martin Mares <mj@ucw.cz>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: Re: [PATCH] lspci: Don't report PCIe link downgrades for downstream
 ports
Message-ID: <20210321163248.GA1719932@casper.infradead.org>
References: <20210318170244.151240-1-helgaas@kernel.org>
 <20210321160905.gwmkkwhofdx657mp@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210321160905.gwmkkwhofdx657mp@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Mar 21, 2021 at 05:09:05PM +0100, Pali Rohár wrote:
> Different thing is when you have Gen2 PCIe Bridge which can operate at
> 5 GT/s but you connect only Gen1 PCIe card under it (which operates only
> at 2.5 GT/s).
> 
> In this case Root or Downstream port of PCIe Bridge is running at lower
> "downgraded" speed but card (on the upstream end of the link) is running
> at maximal speed (not downgraded).
> 
> So in this case proposed patch does not report "downgraded" state
> neither on Root/Downstream Bridge part nor on card part.
> 
> Is it correct? Should not lspci report in this case _somewhere_ that
> link is downgraded and is not running at the full speed?

I suppose it depends why you think it's important that "downgraded"
is reported.  If you want it to mean "you've plugged a slow card into a
port that's capable of more", then you're right.  If you want it to mean
"autonegotiation went wrong", then you actually don't want downgraded
to be reported in the scenarios you outlined.

Dmitry?  What did you /want/ it to mean?
