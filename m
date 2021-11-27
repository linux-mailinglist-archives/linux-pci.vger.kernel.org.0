Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6483A460001
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 16:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239855AbhK0QCD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Nov 2021 11:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhK0QAD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Nov 2021 11:00:03 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96343C06173E
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 07:56:48 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso18485054otj.11
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 07:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Wb8YLQANc5QRzYld+Cz8kvavn4ZutkCVadi3QcaIrpY=;
        b=Fr8KB/sNhZtkDGzfSVmsZExXWinvFjOR5Ko1s0uSScNTr6JbWF+c6kOdXOuGEu78t/
         sTWhm850HsnqnXtSfKwyIB4HrWGYTIzeWukDg6IeWRNpezYSD49PQfzoGlD6PQjieAyB
         pSAHdn5NJYglySEGVTBl/1y8ZKmTEdKy8lQ3j0O0kHjmByvIc2yDdDEF2FnWwBpTCW34
         DcQlY1WdnrO5vb7M0IQfdT12HoI8AOULQUc3uuFz0R240RakkIEGjQp1JlzCYI7woUYv
         g2u0SW59xe7NW0hnYQMpxHqWzvCluiqOZFImwB+GYHkIG61GjoeOYEDAMR01PEtUabBY
         31fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=Wb8YLQANc5QRzYld+Cz8kvavn4ZutkCVadi3QcaIrpY=;
        b=RCKBmBiN8jTVmOqxJ/PiLfp6fCpW2P6hZM0XkfIZElFTa0H3yVV3kiRnOuQd2+kIJd
         Fl1obNaAWkeYxX0Ro0yoHNk23gejPK9R+y87b2iexnEQEIdpZY5RsbfabJAIXSTodWfh
         qrOwuZykGed2dbQhRjFGTe3gEAea93SkdmavrRA+1dWmTWxY3w09VRb01AbW+4uGxAog
         ObgcrefrOdMLTLMhY1dkRz9NhaJwFB1eYEiocmIhgmLcB00N184+Guhs2BmNkMrKlPOk
         5pBklrbSg6gYZqMVaPu95b/AfBUa7IhSXGmBeBYP5jto6HYXwbRoI3VUXpkN4yNYi1U8
         3s8A==
X-Gm-Message-State: AOAM531376c06gZPb9pxGmJ+AyzUgBP93ijSO1tNSgdEuqRG5zDv/5SG
        EM6ir6Xxu/VNpjWSAFoYI9HntpfFKbgnjTLdMtk=
X-Google-Smtp-Source: ABdhPJyC4FU9InA+iNRnE7UKWy2E241xcgOzOpK0usEvm0hYnW+xsvUpfZ/Ort/5Izq0oxffd9V+nZRIshTvve6wvls=
X-Received: by 2002:a05:6830:4414:: with SMTP id q20mr35022514otv.14.1638028607854;
 Sat, 27 Nov 2021 07:56:47 -0800 (PST)
MIME-Version: 1.0
Sender: ericgloriapaul@gmail.com
Received: by 2002:a05:6830:231d:0:0:0:0 with HTTP; Sat, 27 Nov 2021 07:56:47
 -0800 (PST)
From:   DINA MCKENNA <dinamckennahowley@gmail.com>
Date:   Sat, 27 Nov 2021 15:56:47 +0000
X-Google-Sender-Auth: oDZTPG_LGnKAtM5QjQW-K-OPXz8
Message-ID: <CAApFGfSkyxaxfVfWatjQ=PKm1ZaCSagBin0cbA0uMjjw+UdwYg@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello my dear,.

 I sent this mail praying it will get to you in a good condition of
health, since I myself are in a very critical health condition in
which I sleep every night without knowing if I may be alive to see the
next day. I bring peace and love to you. It is by the grace of God, I
had no choice than to do what is lawful and right in the sight of God
for eternal life and in the sight of man, for witness of God=E2=80=99s merc=
y
and glory upon my life. I am Mrs. Dina. Howley Mckenna,. a widow. I am
suffering from a long time brain tumor, It has defiled all forms of
medical treatment, and right now I have about a few months to leave,
according to medical experts. The situation has gotten complicated
recently with my inability to hear proper, am communicating with you
with the help of the chief nurse herein the hospital, from all
indication my conditions is really deteriorating and it is quite
obvious that, according to my doctors they have advised me that I may
not live too long, Because this illness has gotten to a very bad
stage. I plead that you will not expose or betray this trust and
confidence that I am about to repose on you for the mutual benefit of
the orphans and the less privilege. I have some funds I inherited from
my late husband, the sum of ($ 11,000,000.00, Eleven Million Dollars).
Having known my condition, I decided to donate this fund to you
believing that you will utilize it the way i am going to instruct
herein. I need you to assist me and reclaim this money and use it for
Charity works therein your country  for orphanages and gives justice
and help to the poor, needy and widows says The Lord." Jeremiah
22:15-16.=E2=80=9C and also build schools for less privilege that will be
named after my late husband if possible and to promote the word of God
and the effort that the house of God is maintained. I do not want a
situation where this money will be used in an ungodly manner. That's
why I'm taking this decision. I'm not afraid of death, so I know where
I'm going. I accept this decision because I do not have any child who
will inherit this money after I die.. Please I want your sincerely and
urgent answer to know if you will be able to execute this project for
the glory of God, and I will give you more information on how the fund
will be transferred to your bank account. May the grace, peace, love
and the truth in the Word of God be with you and all those that you
love and care for.

I'm waiting for your immediate reply..

May God Bless you,
Mrs. Dina. Howley Mckenna.
