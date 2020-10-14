Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C714228E368
	for <lists+linux-pci@lfdr.de>; Wed, 14 Oct 2020 17:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbgJNPjc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Oct 2020 11:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgJNPjb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Oct 2020 11:39:31 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD164C061755
        for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2020 08:39:31 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 188so3001106qkk.12
        for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2020 08:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GVSRcIp0I0zIMMHpeAma8VzsUJkCwVBLBnR5khFn778=;
        b=J1mIZQxhm5fHftfuwWi3TTtDmvA3oiPFRqtQtXU2kFvIUezY41h2MEVSzENfcYhdQt
         WCBkNPG308aWYxrq/WWrpjrdlUnLjq95gNOOI1V/NH/SGH8lKBfwFLV4AX87J6r4ZRCW
         FLT6s0hYTaJ2F/e3pB4PE9+IbJj/vBQis1tm5QsdRbSZhu5gJFoPzH1JMJ6tCjHZdqCr
         Cfpz92+ofqKRO595Fhceh1/GNSnrmWEnh2Aiuvo42kZ8SOLQWtgFEbyIJRjns+8y9m+8
         gYuNL2iOjknSQiN5k9RjZDTJXj6T0tkyyLgzlz1Sb/2aNdK6NlZcexDosnB0AxXzbfZn
         fJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GVSRcIp0I0zIMMHpeAma8VzsUJkCwVBLBnR5khFn778=;
        b=A24XV0Geyq87j9sTUPjE6rBcDeV7bGuALzWirzM5vIiY3B5gcdYDarb8KCzdZezH1P
         rT2fw0BalLvaZrW7Fc3+pgmDd7NFcAcJj+TmBQ0C9ZnQcXcb9cWfaz+2J6UY8LQFyYO5
         VRdw7DNJmU8yAZywyrapAvGc5MdFIrVavlrwLjb0WlIJa4wRCkvXmSlTVtilHIV9BS/5
         SfOywMqrNW8Xka2dPyV567PnLwD/+w1BI47/KASaWtMsn+sB0a/hRFY399wisLoPDkxt
         dso3YiRXBSsySgVv0lBgEazJgfsU2WCeufNKqv5qKp4M+CRb6zHvXamaqe6aD3JGeMFy
         iI1A==
X-Gm-Message-State: AOAM530CxU9fd5iPgT3d1VTK+9GLpf+Q41LKKd9bLRwirmQ9r98ypZt8
        fWCrc/P6fvCKWSGuLSm/5NF4oeXwzBXmiLHbQoo=
X-Google-Smtp-Source: ABdhPJz/z+fgK8MXqMea6R14Ei2MZCGgBsCY+WSsQNVjwm0pHoGg1esjof7jPr3q9sxEsnY2JuYhjewmgvqtk/RZX0A=
X-Received: by 2002:a05:620a:2054:: with SMTP id d20mr5347118qka.175.1602689970408;
 Wed, 14 Oct 2020 08:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZsnMd3SdnH2bchxfkR7_Ka1wDvu9Z592uaK3FFm4rszTw@mail.gmail.com>
 <20201014143646.GA3946160@bjorn-Precision-5520>
In-Reply-To: <20201014143646.GA3946160@bjorn-Precision-5520>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Wed, 14 Oct 2020 17:39:19 +0200
Message-ID: <CAA85sZuSAorUvLJ5KL6=OqpEgBuHc47hf3wdBX9u_pX9xpYCoQ@mail.gmail.com>
Subject: Re: [PATCH] Use maximum latency when determining L1 ASPM
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 14, 2020 at 4:36 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Oct 14, 2020 at 03:33:17PM +0200, Ian Kumlien wrote:
>
> > I'm actually starting to think that reporting what we do with the
> > latency bit could
> > be beneficial - i.e. report which links have their L1 disabled due to
> > which device...
> >
> > I also think that this could benefit debugging - I have no clue of how
> > to read the lspci:s - I mean i do see some differences that might be
> > the fix but nothing really specific without a proper message in
> > dmesg....
>
> Yeah, might be worth doing.  Probably pci_dbg() since I think it would
> be too chatty to be enabled all the time.

OK, will look in to it =)
