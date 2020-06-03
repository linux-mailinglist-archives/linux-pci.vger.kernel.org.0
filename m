Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94CA1ECBA6
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 10:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgFCIiV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 04:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgFCIiV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jun 2020 04:38:21 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA94FC05BD43
        for <linux-pci@vger.kernel.org>; Wed,  3 Jun 2020 01:38:20 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n141so1359192qke.2
        for <linux-pci@vger.kernel.org>; Wed, 03 Jun 2020 01:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=gqwJomuBh7OM3abQd/8uUQAZ1haEzhtExZnsV2dw2NY=;
        b=ARzX+OqgCp8Qth6PfEwEudp2/3kd9ZnupvdbHTwCUfVfXfv7bN4NJMZngZxvq9EyGX
         enQqIinr3H3u328Uw85TT/hs4GEiQj4HglB66wXl5PzQ1tsiIkfQ7FQLQwaqhCXkHr32
         QYWbAUsJBjwMhTVzGQNJ7PYhluM5oGg04nd810fHpeo0UWfYWnsGcM/bTG8ax9Kgrkbt
         aE37ZpiyqWlqqN1ddwouogxXBlAsXztE3SphUl0w1yfp2tretDI7wsGjWfEpjjRADPUg
         TlZdS+ttTHSF8Fe7lJnKYfmvhPkwVIzD1baaxhhGLSjLgjWgTDXqNBo2lZNe1kqfTeDb
         1PIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=gqwJomuBh7OM3abQd/8uUQAZ1haEzhtExZnsV2dw2NY=;
        b=udukdQHJpc6dDrx4AZFumb5bbF2BEekL6Js9JiE8+YwTe4TGdGN67dSqe8KB6oRMNc
         ILhCZPscy8MraNCnnONBDM+QSz+jxtmLXGQHYNWEcj7NbzqU2hvwPJ2z5yGp1QyFEjY5
         PTPaf3RibvWAKXI4DL8QCUlprZanE9P2ff2As31hYXogBkx44QaZo8toGFOr3fq+2Qw0
         oK6emvSkXlLCzw+blwvXhudV7wjhX6d/oYfjp11s7NNTS3sRS2gMwmVfZVlMKm6f0I9V
         RqqMHBJmKGtpPVty2OJnEPY65LznpNu1lp//TsSbwd6JqKeD5VOE8OmrIUJYAIPdiv4m
         wULw==
X-Gm-Message-State: AOAM532ki07+5qOC6o2/SJZeDEPt2d2/jPNzIRrF9gGpvqAQg3WyZWeq
        1pVBqDnNn3Esfrvx0BqeW54UmEkCNYIxhsF3XjY=
X-Google-Smtp-Source: ABdhPJwwq8J2cuo9oiM9iCVqecxE3u4ru/fldOC3JJWH2w0QxEaF748DzUwkgzBNM9W/DBuAueMcx8/wPv1MLPAaRPc=
X-Received: by 2002:a37:9b81:: with SMTP id d123mr25027732qke.324.1591173500096;
 Wed, 03 Jun 2020 01:38:20 -0700 (PDT)
MIME-Version: 1.0
Reply-To: zaama250@gmx.us
Received: by 2002:a05:6214:12f4:0:0:0:0 with HTTP; Wed, 3 Jun 2020 01:38:19
 -0700 (PDT)
From:   HTA HTA <zama29647@gmail.com>
Date:   Wed, 3 Jun 2020 01:38:19 -0700
X-Google-Sender-Auth: C-q_29U2Tj7vNzhBBMCqJBqmNdo
Message-ID: <CAABzvm7qwF6GPaa6VXpLh_jYqUDFy=9Z6c3=B0XPx4hDgJMuxw@mail.gmail.com>
Subject: OK
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Greetings,

An oil business man made a fixed deposit of =E2=82=AC15 million Euros in my
bank branch where I am a director and he died with his entire family
in a plane crash leaving behind no next of  in/Business Partner. I
propose to present you as next of kin/ Business Partner to claim the
fund, if interested contact me with your full name, and telephone
number to reach you and most importantly, a confirmation of acceptance
from you.


Ahmed Zama
