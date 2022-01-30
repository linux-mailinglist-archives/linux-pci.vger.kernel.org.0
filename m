Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DADD4A32FF
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jan 2022 02:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353635AbiA3BU0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Jan 2022 20:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353604AbiA3BU0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Jan 2022 20:20:26 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22D6C06173B
        for <linux-pci@vger.kernel.org>; Sat, 29 Jan 2022 17:20:25 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id m6so29674586ybc.9
        for <linux-pci@vger.kernel.org>; Sat, 29 Jan 2022 17:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=W5LenOWK+Asi/IRJktE/pV+nkUhUa2nycRViHzLQ+ic=;
        b=Aq5693Yiu7s4IjZy6JR3Qw91dy+XB9rKFZfaOjmRZXvihZldcvdahGA6/mYM0WTnRT
         MRp2px61vgDL283dbHGK3n3CvqskrUs0XVx/GyWzlqJza23Q17buwpfK4V02AtjpIFB1
         qK3r2HSj5Cw9wX7/S90mjd4iz0B+QZiFZGLnr2R1dgcIJxwJAVdI6x8VWjuzZlMTBOLW
         bdxCVQAZs1ZSU0aWFUs/Cuu1bxt2zILopoBFOEiODOqbKu0lEILlp+Huz4lk3FZ+Ikh9
         kBh/OwEVFfoMINh7ZWvgdFEN3JYz/jiDBi12RV2mJgRHaKoyrelGTZNYyFl6vRAPl4Dl
         62rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=W5LenOWK+Asi/IRJktE/pV+nkUhUa2nycRViHzLQ+ic=;
        b=Ji5YxT1k8JCi6ViazbFByN9iYp/pcmrF2sI0jXwWg8Cv8iKz+u+BACPRgYk/lgj1Tz
         cOqr5gOOsK163ca5IG0Au3/IlCe/OFvPQRP8ZG54nlnhZfJ4bpRc5KZCSGgZv3SBh0tg
         8EZsqs/2ylR5LJI+Qd57fFdbmUtb6Eg0ehD2UxdDxb8yu5pIDJP9P4riwbR4J9vuJU1w
         Dz0q7T+guTtY/KDubXjXJbhwm20m32Ju20QaWr01DYLT6i4aSv4KBjB7kV/xPeYZqpL2
         z68GWDfnXge4gCyfLKU8+eO4TP/J8FLPbBz7fsbbUIvOXK+4bVG37ShiPsjs+H5g6T5G
         vpXQ==
X-Gm-Message-State: AOAM533cZUsfmLKsrEhP8DQw6JqhGmY/7gAUjQrOrkR4LJPgrTk1lB0j
        p8Q2Mti0zg51hsIk+/pf3K9nMnrNPmwPxaq7DB8=
X-Google-Smtp-Source: ABdhPJyqL5BiH5c7aZdo1tjaqQqGBEW0n7VpTd5gZsUH6IgJMX1sY2fwYACUSkTV9G9TFIks1+ndJbO51hT+9jv0MVc=
X-Received: by 2002:a05:6902:4d2:: with SMTP id v18mr22134015ybs.257.1643505624996;
 Sat, 29 Jan 2022 17:20:24 -0800 (PST)
MIME-Version: 1.0
Sender: nmesomakalu01@gmail.com
Received: by 2002:a05:7000:c091:0:0:0:0 with HTTP; Sat, 29 Jan 2022 17:20:24
 -0800 (PST)
From:   Jackie James <jackiejames614@gmail.com>
Date:   Sun, 30 Jan 2022 01:20:24 +0000
X-Google-Sender-Auth: _pxmej8tbOSGVGxf5jPvGsijn6s
Message-ID: <CAHMQAuOimXRUN0O-tihGJvLfgyV--t9Bq0KLXc+NZip0ruv-jQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Gooday my beloved,

 I sent this mail praying it will get to you in a good condition of
health, since I myself are in a very critical health condition in
which I sleep every night without knowing if I may be alive to see the
next day. I bring peace and love to you. It is by the grace of God, I
had no choice than to do what is lawful and right in the sight of God
for eternal life and in the sight of man, for witness of God=E2=80=99s merc=
y
and glory upon my life. I am Mrs.James Jackie.a widow,I am suffering
from a long time brain tumor, It has defiled all forms of medical
treatment, and right now I have about a few months to leave, according
to medical experts.

 The situation has gotten complicated recently with my inability to
hear proper, am communicating with you with the help of the chief
nurse herein the hospital, from all indication my conditions is really
deteriorating and it is quite obvious that, according to my doctors
they have advised me that I may not live too long, Because this
illness has gotten to a very bad stage. I plead that you will not
expose or betray this trust and confidence that I am about to repose
on you for the mutual benefit of the orphans and the less privilege. I
have some funds I inherited from my late husband, the sum of ($
12,500,000.00 Dollars).Having known my condition, I decided to donate
this fund to you believing that you will utilize it the way i am going
to instruct herein.

 I need you to assist me and reclaim this money and use it for Charity
works, for orphanages and gives justice and help to the poor, needy
and widows says The Lord." Jeremiah 22:15-16.=E2=80=9C and also build schoo=
ls
for less privilege that will be named after my late husband if
possible and to promote the word of God and the effort that the house
of God is maintained. I do not want a situation where this money will
be used in an ungodly manner. That's why I'm taking this decision. I'm
not afraid of death, so I know where I'm going.
 I accept this decision because I do not have any child who will
inherit this money after I die. Please I want your sincerely and
urgent answer to know if you will be able to execute this project for
the glory of God, and I will give you more information on how the fund
will be transferred to your bank account. May the grace, peace, love
and the truth in the Word of God be with you and all those that you
love and care for.
I'm waiting for your immediate reply.
May God Bless you,
Respectfully.
Mrs.James Jackie
