Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871B340B95D
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 22:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbhINUjv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 16:39:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233426AbhINUjs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Sep 2021 16:39:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FFA560FED;
        Tue, 14 Sep 2021 20:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631651910;
        bh=GwJPjD/GwPL/DwGjqr1yZKsemUFxl/JzTMaSJkQLQ4o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=udVS1LWhWGEmrVCAlNg1T51i1QJ9fV7/V9+31rOEYM+TFo7bqzgQSJKftSiSnGquJ
         bc7NkOA+RtugoEiW1JBRdCB6bugT99bspx1JipUa0A0HCeb+mpfXBcFKt4ZPtMakcM
         n4tjSGw8E+RcZm5PzEYzsPJOsQMukpryPkkZyQBgchaWH9VgOt6ohWyiPbuKAIpkVC
         ydz5F3bPI+lmiM73kKXqJ1lLMdoRIiFuT6Wk6EHcp4EqXgQJVE0pf/Fn2iCWZNQ7Oy
         wfB/+pD0+rdJEyOIsk2e2ApXCtmvrzUmfwW0VIEI0be6Zp54b559VoNWjbYhRZtOyX
         VqawGvTHrYXZQ==
Date:   Tue, 14 Sep 2021 15:38:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/4] PCI/sysfs: Move to kstrtobool() to handle user
 input
Message-ID: <20210914203829.GA1454594@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210706010622.3058968-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 06, 2021 at 01:06:19AM +0000, Krzysztof Wilczyński wrote:
> A common use case for many PCI sysfs objects is to either enable some
> functionality or trigger an action following a write to a given
> attribute where the value is written would be simply either "1" or "0"
> synonymous with either disabling or enabling something.
> 
> Parsing and validation of the input values are currently done using the
> kstrtoul() function to convert anything in the string buffer into an
> integer value - anything non-zero would be accepted as "enable" and zero
> simply as "disable".
> 
> For a while now, the kernel offers another function called kstrtobool()
> which was created to parse common user inputs into a boolean value, so
> that a range of values such as "y", "n", "1", "0", "on" and "off"
> handled in a case-insensitive manner would yield a boolean true or false
> result accordingly after the input string has been parsed.
> 
> Thus, move to kstrtobool() over kstrtoul() as it's a better fit for
> parsing user input, and it also implicitly offers a range check as only
> a finite amount of possible input values will be considered as valid.

If I understand correctly, a user could enable things by writing "5"
today, and if we switch to kstrbool(), that will no longer work.

I'm sure everything is *documented* such that one should write "1" or
other sensible values.  But I'm not sure there's benefit in adding new
restrictions.

Bjorn
