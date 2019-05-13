Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F70D1AF8F
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 06:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfEMEvD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 00:51:03 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39232 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfEMEvD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 00:51:03 -0400
Received: by mail-lj1-f196.google.com with SMTP id a10so1678421ljf.6
        for <linux-pci@vger.kernel.org>; Sun, 12 May 2019 21:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YlAcIbOm9cOOgJWgxxTvpeiMi7ci4Lup4RJ0/GgX7yI=;
        b=OmT7TNB7fSBbjYwVHvuyyI0Euklh0bh78yjpC+8k0cIf9x1gDJ5DldDKoRwEzwbbtN
         zAgGxR0TDLogIBSUIbtKlkjjX56300FtC4JSl6HRU7TsyJ3YQ2MLWK7UwTpxsV3+MfXP
         LCWe4Qopi0saHl8YqKH44y/cwHimNRscbttEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YlAcIbOm9cOOgJWgxxTvpeiMi7ci4Lup4RJ0/GgX7yI=;
        b=VPNFsLFjpbQds9rbvpCC3M1OH7bghfPjwmdIouKFTon7ohG5jWDbzvC/w60OtPyFxA
         CnYIyOakVhXWcU6R31GKcp+N27sm3ZBRIVwEJt8hvfQ4PIXgOZlky147HcsxhUVKYSww
         sLLiHmktsbizfRBIj+qK9ks3RQmfmDTVgBvbRPeAjDxoIYFDRgaMzgsBbcjcNuVpMSh7
         lJjeMxVW79jonQBgvjK4dl3vRgQ2VjqDA662XhsUaPscgCqcUU5HLy+8pDHC2bggYNmh
         bY853I46LPma1ru2a5yCNbjAY5DUKOEviT8SlE9Cm6Qf7yEe2sHwtHJteQk70piynTM1
         mEYQ==
X-Gm-Message-State: APjAAAXLxsmT33kOjbp5Xmkd2T0HwVyNyP8T2K1mPn3BY6g094uQ8pRm
        c+H4tsI+dKNcXpeRsheOng/6/AnJg7JMYhdtxsoXWLPxYa9RMwFdneROA5g9bGKvyUhO2AOY40m
        TaHc+IezqGIhFC6bTb/pCUcVi1fwjcA==
X-Google-Smtp-Source: APXvYqzRS8gfw06zJb1XTHSDLQ3jz8DDhNt+DpKglTt9FVeMc0yQUY0JnJTNVBWgaRbhcO6dQoORa09AOE8i9jp5MiM=
X-Received: by 2002:a2e:2b81:: with SMTP id r1mr11419826ljr.138.1557723061597;
 Sun, 12 May 2019 21:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <1557229516-6870-1-git-send-email-l.subrahmanya@mobiveil.co.in>
 <20190510134811.GG235064@google.com> <20190510163551.GH235064@google.com> <CAKnKUHHkRw3pLyeyMN6oA=nxtA0+sF2sJjBKiee17OZP_eFjFA@mail.gmail.com>
In-Reply-To: <CAKnKUHHkRw3pLyeyMN6oA=nxtA0+sF2sJjBKiee17OZP_eFjFA@mail.gmail.com>
From:   Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
Date:   Mon, 13 May 2019 10:20:50 +0530
Message-ID: <CAKnKUHHsDrecejdBFq8AGX=1BL948j7y4vcu-69i6vGAjqPyCw@mail.gmail.com>
Subject: Re: [PATCH 1/1] PCI: mobiveil: Update maintainers list
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Hou Zhiqiang <zhiqiang.hou@nxp.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Acked-by: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>

On Mon, May 13, 2019 at 10:03 AM Karthikeyan Mitran
<m.karthikeyan@mobiveil.co.in> wrote:
>
> Acked-by: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
>
> On Fri, May 10, 2019 at 10:05 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>> On Fri, May 10, 2019 at 08:48:11AM -0500, Bjorn Helgaas wrote:
>> > On Tue, May 07, 2019 at 07:45:16AM -0400, Subrahmanya Lingappa wrote:
>> > > Add Karthikeyan M and Z.Q. Hou as new maintainers of Mobiveil controller
>> > > driver.
>> > >
>> > > Signed-off-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
>> >
>> > I'd like to include this ASAP so patches get sent to the right place,
>> > and I want to make sure we spell the names and email addresses
>> > correctly.
>> >
>> > Zhiqiang, you consistently use "Hou Zhiqiang <Zhiqiang.Hou@nxp.com>"
>> > for sign-offs [1] (except for "Z.q. Hou" in email headers).  Can you
>> > ack that the updated patch below is correct for you?
>> >
>> > Karthikeyan, I don't see any email or commits from you yet, so I'd really
>> > like your ack along with the canonical name/email address you prefer.
>> > There is another Karthikeyan already in MAINTAINERS, so hopefully we can
>> > avoid any confusion.
>> >
>> > [1] git log --format="%an <%ae>" --author=[Zz]hiqiang
>>
>> I went ahead and applied the patch below for v5.2, but if you want to
>> tweak the names/addresses, I can update them if you tell me soon.
>>
>> > commit d260ff8d3353
>> > Author: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
>> > Date:   Tue May 7 07:45:16 2019 -0400
>> >
>> >     MAINTAINERS: Add Karthikeyan M and Hou Zhiqiang for Mobiveil PCI
>> >
>> >     Add Karthikeyan M and Hou Zhiqiang as new maintainers of Mobiveil
>> >     controller driver.
>> >
>> >     Link: https://lore.kernel.org/linux-pci/1557229516-6870-1-git-send-email-l.subrahmanya@mobiveil.co.in
>> >     Signed-off-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
>> >     [bhelgaas: update names/email addresses to match usage in git history]
>> >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> >
>> > diff --git a/MAINTAINERS b/MAINTAINERS
>> > index e17ebf70b548..42d7f44cc0e1 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -11880,7 +11880,8 @@ F:    include/linux/switchtec.h
>> >  F:   drivers/ntb/hw/mscc/
>> >
>> >  PCI DRIVER FOR MOBIVEIL PCIE IP
>> > -M:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
>> > +M:   Karthikeyan M <m.karthikeyan@mobiveil.co.in>
>> > +M:   Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>> >  L:   linux-pci@vger.kernel.org
>> >  S:   Supported
>> >  F:   Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
>
>
>

-- 
Mobiveil INC., CONFIDENTIALITY NOTICE: This e-mail message, including any 
attachments, is for the sole use of the intended recipient(s) and may 
contain proprietary confidential or privileged information or otherwise be 
protected by law. Any unauthorized review, use, disclosure or distribution 
is prohibited. If you are not the intended recipient, please notify the 
sender and destroy all copies and the original message.
