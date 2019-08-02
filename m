Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC2A7F597
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2019 12:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbfHBK5J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Aug 2019 06:57:09 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34393 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfHBK5J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Aug 2019 06:57:09 -0400
Received: by mail-qt1-f194.google.com with SMTP id k10so4245311qtq.1;
        Fri, 02 Aug 2019 03:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gbCczoLQ3SfN/QknlFtlI1oZjr6VDEE47xsY4Nu8Wq0=;
        b=lWz+GiTqyzUdXZ2QUsj6ZjlPjd2O/9Yr36QQyS4sxOzeraueDCTdhgbLlYE/MOx6SP
         mc/2ytfSuTYkb3j6PglXwJ4c+5msHQGQfpfxYlzBpEG4QQB23yn6qWkOPQiXjoyQ2ihH
         FBlTw3qYPJGzQIlfnY8sSHRXSZPCzepN6bXy4j8kg4EqZswsR570yvBmv9gpvvjjGKjM
         s0driDwqiqbxpHmPoT6fNgT/DLZAO9LaHHR4BXULGmHL7NgvyJHEOU0ea+4IcQlsVJf/
         5uzSGhXBmvpwClZs5+lLHaE6j0u7cC5AuWv2+w6UCpQUby4oSsA/5mGnDdW1yIzJTj6v
         kddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gbCczoLQ3SfN/QknlFtlI1oZjr6VDEE47xsY4Nu8Wq0=;
        b=pJui242St5KyqZmFwYUj4q78aRH5zbLB7KGHTw5Lzq85mYTVwFMg+e2uLrhdd5wozl
         0hNfV36OOzoSgdTbQ2qfI1rQmIOhPVNx99aZzoBG12mOd8e+vDG/h7FYXgytzRwgfN1g
         zSxTJcuqrYSeRzn7sbmFYtJAMAlngWTkF4lvNiuNfPN27IYxP3MtTNLXKK1fsaotM9dL
         cHEVOjWr5UhOYOK+tCja17RZBCu4VGW33BSD0Tfh7JL910CBq3V/xkZDKVaORNEP/DvC
         ze2oBr3KiLoNZPtO8i0+25FNieKYMfIzYkq3FUntxnbRWaN5PjXLqX1cSwUcAtCQfb5N
         7zHw==
X-Gm-Message-State: APjAAAWbNhZ9KufJLoDeeqzn9Zg2/Ex2yJAfsgOm7ldZK4Mkdz7KeENb
        AmU5rlWKpdMht5QSYVYxQMyZiiJ3hZF/FwVX7NU=
X-Google-Smtp-Source: APXvYqyk/amv5snwY3YY8ik0L0m+wfK/xXhLmarWNDBSHnkTnN91CaAwYJ9G5+b6Q9FisLihTbbWP3ShvjkxrmZ+pGM=
X-Received: by 2002:ac8:53d4:: with SMTP id c20mr91961143qtq.121.1564743428175;
 Fri, 02 Aug 2019 03:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAGgoGu5FfLFzCf0QiAd8UcMrZ7gtLyapgT3TZ-Hx0dknWy4LMQ@mail.gmail.com>
 <CAGgoGu4zP_7QpKHiXSkLfkb=zHEezBzstVfjQMQ4CO60+YubCw@mail.gmail.com>
 <CAGgoGu7rot61LSgu2syOMq9Onx26_u3PEtS7pf_QNQRxOaifhg@mail.gmail.com>
 <20190801171725.GD151852@google.com> <743ef7fab5144df69bfc8673fff7f0f7@SVR-IES-MBX-03.mgc.mentorg.com>
In-Reply-To: <743ef7fab5144df69bfc8673fff7f0f7@SVR-IES-MBX-03.mgc.mentorg.com>
From:   Fawad Lateef <fawadlateef@gmail.com>
Date:   Fri, 2 Aug 2019 12:56:57 +0200
Message-ID: <CAGgoGu4ZZR3ZVD5mx_oJN_8gwNM4fa=of=erwM+P8P7zzaMDrQ@mail.gmail.com>
Subject: Re: Unhandled fault: imprecise external abort (0x1406) when loading
 xhci_pci.ko - uPD720202, PEX8605, iMX6Q and linux-4.19.25
To:     "Schmid, Carsten" <Carsten_Schmid@mentor.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Schmid,

On Fri, 2 Aug 2019 at 10:24, Schmid, Carsten <Carsten_Schmid@mentor.com> wrote:
>
> > >
> > > Facing kernel "Unhandled fault: imprecise external abort (0x1406)"
> > > when trying to load xhci_pci.ko module for uPD720202. Receiving this
> > > fault straight-away when driver trying to setup device.
> > >
> I had "imprecise external abort" on ARM systems in the following cases:
> - Subsystem that was accessed was not powered
> - Clock of accessed subsystem was turned off
> Maybe this enables you to find the true reason.
>

Thanks for suggestion. Going to verify these points.

> Can you try to disable runtime power management to check if it works?
>

I will try soon as currently don't have access to prototype board.

> Best regards
> Carsten
