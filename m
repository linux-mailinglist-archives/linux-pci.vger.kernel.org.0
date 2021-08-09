Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542B43E4632
	for <lists+linux-pci@lfdr.de>; Mon,  9 Aug 2021 15:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbhHINLN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Aug 2021 09:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbhHINLN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Aug 2021 09:11:13 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50751C0613D3
        for <linux-pci@vger.kernel.org>; Mon,  9 Aug 2021 06:10:52 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id k3so11358324ilu.2
        for <linux-pci@vger.kernel.org>; Mon, 09 Aug 2021 06:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=7Xq9jb2sUMv3xaNw7Q5Cgt7yCkc3M0xn16Wn4AtIDKI=;
        b=jlylg0ChOm7Bqigcudc7UV5pOzeOyy73qpe7dRwkvLZASCgxG+YqA/uIP0tFXCQPP7
         kn46unASBl3ZL+AdOUvIWCllW+a8uXh8jPc2yFlwJRMsSHUOvEAjcS+3NQ+S15vzHaj7
         uoqdbtLDJf1sYkVNOqHDnaXbFvYqjbH8qW1ISuDnOga8bi8ETLH1tYzO0JDPp7vQEoaP
         xwSv2QfYO2QzIZUU4mtRQwA39uEaD0pO9klL+84MWaFA1x86vx1+Pc6AeEE8Bro9LUJ6
         n1s9ooRBkWhLvmbvlKhs7etmC9dhIkPbo0xIPH0dhHU8U/4WEBSeeH68iGPEi3Aq0XG6
         oUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=7Xq9jb2sUMv3xaNw7Q5Cgt7yCkc3M0xn16Wn4AtIDKI=;
        b=NV3znVbAste6AvVwTPgvmkoK+9rBF/0O0j7nHeUtwah5m25mn9tktvti2BvEiqGz6e
         IZ2JHl0b/an5aeZnfyEVdnKk0hgrYF5HuymBe3nZJsVSkY79lHKQyry8hKuCUwt8Ed7E
         EZKH4YOMkq3MhmTP79odtReJc6JkJdqqhVbMMtQIssSapeDPYX4Aw+0htTy9GAlP2/pY
         4/XrNOcXCTcHQh4LgiNXLkPEEgpSgGS5pQEARwDjkc9cDGEgOeZIwJEEcN7cK03EA/UE
         +oW2i2sRTsQ4Q/foFnnYdbBTvVfOGTUIdPMQHgMulYzKrtyU3OXDbYYSMpbZbDbCaTEu
         Hw6A==
X-Gm-Message-State: AOAM533g0avtzkRHWeh7A6vejoSZl5HB5UUPc+prIBgpSxet4dH8Q1Sm
        CgAAO2fKb+GhEzOUU5/HWIJyjGCTARZexLCMiA==
X-Google-Smtp-Source: ABdhPJzu2C9U3/vuJ5mLU5+P4INYs7dnpAFXgC2RTOgt7mjgdv2X1uNSuJyrpOX//gn1taZQ74gIh+ynT5N7ptjnIb4=
X-Received: by 2002:a92:d84a:: with SMTP id h10mr261549ilq.55.1628514651815;
 Mon, 09 Aug 2021 06:10:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:fadb:0:0:0:0:0 with HTTP; Mon, 9 Aug 2021 06:10:51 -0700 (PDT)
Reply-To: nicolasbilly@yandex.com
From:   Nicolas Billy <kwaanya1@gmail.com>
Date:   Mon, 9 Aug 2021 13:10:51 +0000
Message-ID: <CA+04VFQ+Evf09siu2cDXKLqEttgfc9O7Oc+cVThb3TnwxzAacQ@mail.gmail.com>
Subject: Donations
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Attention: Beneficiary,

This is to officially inform you that we have been having meetings for
the past weeks now which ended Two days ago with Mr. John W. Ashe,
President of the 68th session of the UN General Assembly, Mr. David
R.Malpass. the World Bank President and Hon. Mrs. Christine Laggard
(IMF) Director General, in the meeting we talked about how to
compensate Scam victim's people and all the people that were affected
the most by this Coronavirus pandemic.

Your email address was successfully selected for this donation with others.

The United Nations have agreed to compensate you with the sum of
($150,000.00) One hundred and fifty thousand United States Dollars. We
have arranged your payment through WORLD ATM MASTERCARD which is the
latest instruction from the World Bank Group.

For the collection of your WORLD ATM MASTERCARD contact our
representative Rev. David Wood, send to him your contact address where
you want your MASTERCARD to be sent to you, like

1. Your Full Name: .........
2. Your Country and Your Delivery Home Address: ........
3. Your Telephone: ..............

His e-mail address: (ddavidwood1@yandex.com) He is a Canadian (UN)
representative Agent.

Thanks.
Tel: 1 513 452 4352.
Mr. Michael M=C3=B8ller Director-General of the United Nations Office
