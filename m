Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF31D70DE
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 10:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfJOIUm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 04:20:42 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44438 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfJOIUm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2019 04:20:42 -0400
Received: by mail-ot1-f65.google.com with SMTP id 21so16124756otj.11;
        Tue, 15 Oct 2019 01:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X0OIrA720x+aDqrTqdN+5ag6q1BbkecqENaXJV6YsTQ=;
        b=V3Mgap19ZaURZpOwEaYH2av4/SNFhmcklNrV/lpnzysAFaRPISirzTRBarISsjM/D9
         o/fwMD+0yGVwVQbrrK7CYrtOQWZgEzvLBxVJFxiIuzxGGBRYJ0k6cRhcTNGl0iv6Mj9C
         AwzdoWpGPWy3Xsnq7S6VzLdQAtycKxXlbGoQpWeQO1UYq1Q3ZNzc4c3AwIB2tbrSZQ+P
         D7njqroghd4noAwt2CMqXAHnBX342mHd2/kmqPOlK6RlOvTLaY3QOvxkXILmJ//jsb2X
         q7UL4isLzH/V7MM9VKch9GxbI+IPwomhxQa7sS0KHbkHhTYPlIJ71yy2oAnRrtoiQ+nb
         XE9w==
X-Gm-Message-State: APjAAAXruq4XjPkezyUBav1AMSsv01U/xbBtDhUdV8Ja+v11s3cdDWJw
        df0VIXIxMbL2tM1F7Cd90E9oDMPJqNm1GIpi3tM=
X-Google-Smtp-Source: APXvYqxCVgqWHDr4+LFcWfZ0MfOsz6lGzoPw9ZwtG9f2jjSZEvZAKIktmnMZIzUaU1PCNCBBaH3SAN3yCwj+Z96Fwew=
X-Received: by 2002:a9d:459b:: with SMTP id x27mr26564657ote.167.1571127641248;
 Tue, 15 Oct 2019 01:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190927090202.1468-1-drake@endlessm.com> <CAD8Lp44TYxrMgPLkHCqF9hv6smEurMXvmmvmtyFhZ6Q4SE+dig@mail.gmail.com>
 <3118349.722IRLjr4b@kreacher> <5720276.eiOaOx1Qyb@kreacher> <CAD8Lp45rKeLs5xSvS9ffs+G0D5iLMn5-MWypqCKWCn0jGdfGHQ@mail.gmail.com>
In-Reply-To: <CAD8Lp45rKeLs5xSvS9ffs+G0D5iLMn5-MWypqCKWCn0jGdfGHQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Oct 2019 10:20:29 +0200
Message-ID: <CAJZ5v0jCzGrijtfnVz8jq0-QRhETau9rzvEt4jiXtwWauV9vPQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: PM: Fix pci_power_up()
To:     Daniel Drake <drake@endlessm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 15, 2019 at 7:11 AM Daniel Drake <drake@endlessm.com> wrote:
>
> On Mon, Oct 14, 2019 at 7:25 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > Since there is no reason for that difference to exist, modify
> > pci_power_up() to follow pci_set_power_state() more closely and
> > invoke __pci_start_power_transition() from there to call the
> > platform firmware to power up the device (in case that's necessary).
> >
> > Fixes: db288c9c5f9d ("PCI / PM: restore the original behavior of pci_set_power_state()")
> > Reported-by: Daniel Drake <drake@endlessm.com>
> > Link: https://lore.kernel.org/linux-pm/CAD8Lp44TYxrMgPLkHCqF9hv6smEurMXvmmvmtyFhZ6Q4SE+dig@mail.gmail.com/T/#m21be74af263c6a34f36e0fc5c77c5449d9406925
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > Daniel, please test this one.
>
> This one is working too, thanks

Thank you!

Bjorn, any concerns?
