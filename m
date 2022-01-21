Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88D34961D5
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 16:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351095AbiAUPMw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 10:12:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45654 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241694AbiAUPMw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 10:12:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39D73B81EDB
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 15:12:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4632C340E1;
        Fri, 21 Jan 2022 15:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642777969;
        bh=iK2mSj51iUyVS3HdWK/GkZdXSZrsaGGJ5Vv3H6Ly80Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E6twq7e4qRs2v4aeBq8GiDJ5NRI9eG/02Kj+VjiWLnwzo8Tcz4uJas+epMz9aCuM8
         4bpDU8QMPLDo6Kl5TroTS+gDmwkz833zWx+/iLS3wPCxLMgBUfmi70xTNk456+IpHh
         T2TmJqEYLih/y9mypGEYZh4a6lFie6M3CLfG/W8oPjVSjLTc/0cDmWy8nfwo0dI3lC
         38NnqA1Sg8hldWmBUWUFl2L2qUgs0OwI+JvWMPq1/kp6SSpYor1tDxa6PzlW+rgdOK
         ZKK8zHXJSvkJUFGStswdUDeghJPbLUPvZb5E9ImjKv01WcORlsLsrKWxlzT1gPfbWb
         D2CFJYCd7wRHw==
Received: by pali.im (Postfix)
        id C2AF2857; Fri, 21 Jan 2022 16:12:46 +0100 (CET)
Date:   Fri, 21 Jan 2022 16:12:46 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH pciutils 0/5] Support for PROGIF, REVID and SUBSYS
Message-ID: <20220121151246.3tlf5jdyh6jxeauv@pali>
References: <20220121135718.27172-1-pali@kernel.org>
 <mj+md-20220121.143358.16196.nikam@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mj+md-20220121.143358.16196.nikam@ucw.cz>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 21 January 2022 15:40:14 Martin Mareš wrote:
> Hello!
> 
> > libpci currently provides only access to bits [23:8] of class id via
> > dev->device_class member. Remaining bits [7:0] of class id can be only
> > accessed via reading config space.
> [...]
> 
> I really do not like the explosion of PCI_FILL_xxx flags for trivial things.
> 
> Add a single PCI_FILL_CLASS_EXT, which will fill the class, subclass,
> revision and programming interface.

Ok!

How to handle situation when "class+subclass+prog_if" is provided and
revision is not provided? What should libpci backends set in this case?
Because on both Linux and Windows systems are these information provided
separately. On Linux you can chmod 000 revision sysfs file and let class
sysfs file still readable. Windows can probably decide itself that it
would not report revision at all...

And what to do with subsystem ids? They are not part of
class/subclass/prog_if/revision fields and different devices have them
stored on different locations... And for PCI-to-PCI bridges they are
only optional and does not have to be present at all.
