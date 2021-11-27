Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3174600EE
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 19:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbhK0ScW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Nov 2021 13:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355871AbhK0SaW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Nov 2021 13:30:22 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B20BC061574
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 10:25:40 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id w1so53048447edc.6
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 10:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=nSnzgrxddn0odJ+F4Pm2LVSoEistsw4jHMhtjB6XfyM=;
        b=NpDgKnu7IK84ST0BwNvauAZPvqfewrMrBSYU29meSTsGPPaD8mx7jSkHsY/1x+Co8j
         2iP5UY1Z7m/JZ+GFRjk931GMDGnm7+/bocdAXCeeVClXq1aus8j6NE7vXYbOqUQBk0T2
         s2rPEbaC2XHIwIYhR+eUaAuww8uXKTcUGXOL7HUTJyv8cDD+2wb0bhvoODjr557Ksl/q
         gLB7VgdPrnJUikPIZTGjQ0rCV8rT/XLGCaDRa/zzOUROHh6ipSav0xK4hUYfKOpcwVIP
         A0+WTB+dk8wdEjmoGFXqYm7u3j0qY6uGDU9ZJ+erkkvXuM24oqbj45xbOE3EiyP/DwK5
         /o7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=nSnzgrxddn0odJ+F4Pm2LVSoEistsw4jHMhtjB6XfyM=;
        b=YpUKvxILC+j03eDRKoHSfNG7KDDKsSVg6VZbZWZs5BX7wGSuPrcCzUgT3EYGRkkz28
         8MXUW6/I0XPHx0zb5r9N8dY9P4SkQJRhEsXKReGMfretlsu501rn7iN1Q0ojEF27M/yP
         iLyzRwk2Pr1sfY8HAnKdTyV5m6mt3XJiRwpk8QkD3kV+XzHdoi6Ls/8Ya6pyPtnEoGfr
         6korwBOeLk1F/GsUGTPHWdk1ebEr5UUYPzx+mqu120fot4yuHoCi2fmS1eDm2gGvOvaO
         U92pF0b2IVO88YZ/YfAxi7Tmz9c1/nNkT92as6MpBjx7ZPw3V49MVqGjs9qlU8sF6nGT
         24yQ==
X-Gm-Message-State: AOAM530cxJlc4kusbpbviNX1hMeLzzQBt1xBYeK1nK0YImO4BrKEJ/Ic
        XSEXbmjfZAKH+jNspSX9uTDigTFpT1vQLmdVYN8=
X-Google-Smtp-Source: ABdhPJypISIuOGr05q3DOnVjuXifmQlcPkmIlrYSN0Uois87TnAz7wjgGCfjaJNhM1ouXBODYoyaTAmH8qIqCx3uncg=
X-Received: by 2002:a05:6402:3590:: with SMTP id y16mr58552824edc.343.1638037538532;
 Sat, 27 Nov 2021 10:25:38 -0800 (PST)
MIME-Version: 1.0
Reply-To: gen.ireneduncan@gmail.com
Sender: afringawa121@gmail.com
Received: by 2002:a17:907:7da4:0:0:0:0 with HTTP; Sat, 27 Nov 2021 10:25:38
 -0800 (PST)
From:   Irene Duncan <gn.ireneduncan@gmail.com>
Date:   Sat, 27 Nov 2021 19:25:38 +0100
X-Google-Sender-Auth: m4W6IET8g-MxZqpMhD4CqvwrgD8
Message-ID: <CAG1-aHHNtBchMQU=uErGiZtn59XN5-8fmbXi-GFPE8i6g-B48A@mail.gmail.com>
Subject: With due respect
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

I am General Irene Duncan from the USA working in the US Army but
presently in Syria for a peacekeeping mission, I sincerely apologize
for intruding into your privacy. I have something very important to
discuss with you.

Some money in various currencies where discovered in barrels at a farm
house in the middle East during a rescue operation in Iraq War and it
was agreed by Sergeant Kenneth Buff and myself that some part of these
money be shared between us, I was given a total of ($5 Million US
Dollars) as my own share , I kept this money in a security company for
a long while now which i declared and deposit as my personal and
family treasure and it has been secured and protected for years now
with the security company.

Now, the WAR in Iraq is over, and all possible problems that could
have emanated from the shared money has been totally cleaned up and
all files closed, all what was discovered in the Middle East is no
more discussed, i am ready to retire from active services by the end
of next month, but, i need a trustworthy person that can help me take
possession of this funds and keep it safe while i work on my
retirement letter to join you so that we could discuss possible
business partnership together with the money.

I'll tell you what! No compensation can make up for the risk we are
taking with our lives.

I=E2=80=99m seeking your kind assistance to move the sum of US$5 Million
Dollars to you as long as you will assure me that the money will be
safe in your care until I complete my service here in (Syria ) before
the end of next month.

The most important thing is; =E2=80=9CCan I Trust you=E2=80=9D?As an office=
r on ACTIVE
DUTY I am not allowed to have access to money, therefore, I have
declared the content of the consignment as personal and my treasure. I
would like to deliver to you. You will be rewarded with 30% of this
funds for your assistance, all that I require is your mutual trust
between us. Don't betray me when you receive the consignment.

Sincerely,
General Irene Duncan
