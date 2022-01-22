Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C85F49698A
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jan 2022 04:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiAVDKm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 22:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiAVDKl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 22:10:41 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23565C06173B
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 19:10:41 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id p7so13106795uao.6
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 19:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=nf1KJx5plPkdmbWsgOwhevvdc0FZ9b6aZ3IYebJs8Ow=;
        b=Vs3sjIUIAbrvzecMAA0XFkvNed9q2Pp3LkEVE7JyQE515NzLngoTiuACbCWZEjUlJg
         F6wZ6BRm+P6rpYzP/4j34koU7bmyeQHI6hn8YbXtwWbt2RqVYHWEMFuyU4vAoYUmRQUV
         9/IRRgXIA8YJKcQVG72c7wMFoShpvDZo01BjgbyW0Y/JoSXl+KZBQo8wyWOb8B3yf3LW
         0La6FRLntfDpc+tK2lYczbB7G1j+e+jsvfCq3CfE9No0v4ohGJj+6lFB5s2NoQcw8cLT
         rY+dS2+S40Y0wxhRfx+NViXhUsE42czYwjWax+dvO/3m22/6XgHoYFXhiVAuecLnXxVf
         lhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=nf1KJx5plPkdmbWsgOwhevvdc0FZ9b6aZ3IYebJs8Ow=;
        b=11Y6ZlTlwFUhQ9fvLBzbYr8erBENS2+IYr42y9GoTGiQ/BxUIcjf2Aqbu8YUErMMDE
         UwmUlNaiYpmvgCNXbSZ5tWfqp+LiJUINtAInz4qvbnKhODZLgqX0ayDltGK4QKhFuCty
         7LWE+oJR5Xb/4TPTofQZo7GiSQjV+dt/d/6pdKcj65l9YDeiMYeY7SO7eVq4zUBv+R5m
         YT/s2KOEmLiHaTMyS/vQvT6CxMdh7ySyzXdzmuWVU6RiOTVcN+1Zu01eqBeuhbGbfWEY
         KaHWuATEDnOrA56c864v5DBejoqetpdx4PijwTzGke05CVle3WpWDGG8UomCmAGbyoAw
         XcMA==
X-Gm-Message-State: AOAM533R1fTPlti1rj/8MjofRO2pdZU7GnYATIofVNBdE4hR1O/IFQ3V
        4ahmK4CayWP7DneZQ4y9teq55wpMqEdgQHuwVEc=
X-Google-Smtp-Source: ABdhPJz9JRMxZabK2ncimu2niul0MrFqswXj1igmcyq4P4UGHG7kNB+3R+ePCNZ3qf7Q+j3PE+s94AYQdnyh+Tr3o5Y=
X-Received: by 2002:a05:6102:956:: with SMTP id a22mr2808595vsi.49.1642821040051;
 Fri, 21 Jan 2022 19:10:40 -0800 (PST)
MIME-Version: 1.0
Sender: mcdonnalouise@gmail.com
Received: by 2002:a59:6705:0:b0:27d:58af:878f with HTTP; Fri, 21 Jan 2022
 19:10:39 -0800 (PST)
From:   Jackie Fowler <jackiefowler597@gmail.com>
Date:   Sat, 22 Jan 2022 03:10:39 +0000
X-Google-Sender-Auth: G-hXbcA3Q4MgKKVNf2ae_wokW6M
Message-ID: <CAPVGnmVs_c_yzLCWNOS5oZY6OMpaYrdWDenNaknqr-EW+a+oqw@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Greetings dear sir/madam,

 I sent this mail praying it will get to you in a good condition of
health, since I myself are in a very critical health condition in
which I sleep every night without knowing if I may be alive to see the
next day. I bring peace and love to you. It is by the grace of God, I
had no choice than to do what is lawful and right in the sight of God
for eternal life and in the sight of man, for witness of God=E2=80=99s merc=
y
and glory upon my life. I am Mrs.FowlerJackie.a widow,I am suffering
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
Best Regards.
Mrs.Jackie Fowler.
