Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E9A47F660
	for <lists+linux-pci@lfdr.de>; Sun, 26 Dec 2021 11:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhLZKGJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Dec 2021 05:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhLZKGJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Dec 2021 05:06:09 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B249C06173E
        for <linux-pci@vger.kernel.org>; Sun, 26 Dec 2021 02:06:09 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id f18-20020a17090aa79200b001ad9cb23022so11851617pjq.4
        for <linux-pci@vger.kernel.org>; Sun, 26 Dec 2021 02:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=iVpNSBcLPppcmFw94cwVnbMVd3rC0DLaBZDsWUncoHI=;
        b=WhWytwtW2CqFuibQeVgPIDYdFtohuuAOZC7xRUed7C1kl0z8apCIkdkUl/vQ/mGVlR
         OCgni30XIW/xJQtfldKqFX/m0c6GAefk1nTmS1pDiruNBdefE8JctnjAqJ+gSSt5mw0W
         VVC3M7lPv7A3f+6MEZ7Q+Z4+oVWl5Sib9uzHRjD02f7evUgbqFIHUQTlDTkKsK4ll3uS
         EmmynR3eaEcnIAZOlyIgOFQjo4U2/FBlfY1R16JL0hJ3ok6DSKc0NFBVLjxWj+fisMhE
         xT15FCMbU7lCojEkTLhMzblo3L2C+Sv7cNX4GJI2hJnewmQdDfptlFnLLwSjArE3e4wK
         oMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=iVpNSBcLPppcmFw94cwVnbMVd3rC0DLaBZDsWUncoHI=;
        b=2ioltCoBBNghuC9vbPQvGCEp+EKqk75uxSr3pbOdWI/EzapA24I8uvUTNdzkOlIdrn
         1UwFiez33BkXFQWkUvrr8U/CxYL75/DN9Yc2vyNz1Bq3tooPM67ysLssDGduByLgCMDU
         +8+ekUPyfwXQ05v9PhcclLIwEbyzKXNhdvjVsfNSN4JLCSLDBrSND9oIO+6N180xadFi
         yRoVGsmym5U482Wa1h9777qdh7xKsRJNJ8NJschHxQSIHgjWHO/qwqwg8FHmqIFHuvmI
         l5zX8WqSoKobzsBFw3jZyoanoHN6oLPS5+jHH/G5O8gllQLdxxE0l/1qTJvCkHoLa5mW
         +sIw==
X-Gm-Message-State: AOAM533BbQj34FNxn2OSmg3rOeTdvuRuidxbyH9rTt3dckxCM94aqwCR
        bHiX39uFb/heINFBWoqkM36vR+9Ngt11x8PdJ5o=
X-Google-Smtp-Source: ABdhPJzhwzbZGpQGAcm8UfDacy9F7FPGrrO/wtTfwSRk1piP4Cj+ksLW5d2KC56E2X9CawP7mySYved6xObuxKbMdWQ=
X-Received: by 2002:a17:903:249:b0:143:c077:59d3 with SMTP id
 j9-20020a170903024900b00143c07759d3mr13377825plh.26.1640513168484; Sun, 26
 Dec 2021 02:06:08 -0800 (PST)
MIME-Version: 1.0
Reply-To: skwnogo@gmail.com
Sender: jyuyuipd@gmail.com
Received: by 2002:a05:6a10:fda6:0:0:0:0 with HTTP; Sun, 26 Dec 2021 02:06:07
 -0800 (PST)
From:   Muskwe Sanogo <dnipttssw@gmail.com>
Date:   Sun, 26 Dec 2021 10:06:07 +0000
X-Google-Sender-Auth: hH6eiIezQt80n5Sm1s6o4wliYAM
Message-ID: <CAARwSp2BAMqcsNHmjj_2jL2RL6rsbA+38SoVnLS1KJT1W22x+A@mail.gmail.com>
Subject: Greetings Please confirm if you received the invitation
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With due respect to your personality and much sincerity of this
purpose, I make this contact with you believing that you can be of
great assistance to me. I'm Mr. Muskwe Sanogo,  I'm the Chairman of
FOREIGN PAYMENTS CONTRACT AWARD COMMITTEE and also I currently hold
the post of Internal Audit Manager of our bank in Branch, Please see
this as a confidential message and do not reveal it to another person
because it=E2=80=99s a top secret.

We are imposition to reclaim and inherit the sum of US $(38,850,000
Million ) without any trouble, from a dormant account which remains
unclaimed since 10 years the owner died. This is a U.S Dollars account
and the beneficiary died without trace of his family to claim the
fund.

Upon my personal audit investigation into the details of the account,
I find out that the deceased is a foreigner, which makes it possible
for you as a foreigner no matter your country to lay claim on the
balance as the Foreign Business Partner or Extended Relative to the
deceased, provided you are not from here.

Your integrity and trustworthiness will make us succeed without any
risk. Please if you think that the amount is too much to be
transferred into your account, you have the right to ask our bank to
transfer the fund into your account bit by bit after approval or you
double the account. Once this fund is transferred into your account,
we will share the fund accordingly. 45%, for you, 45%, for me, 5%, had
been mapped out for the expense made in this transaction, 5% as a free
will donation to charity and motherless babies homes in both our
countries as sign of breakthrough and more blessings.


If you are interested to help without disappointment or breach of
trust, reply me, so that I will guide you on the proper banking
guidelines to follow for the claim. After the transfer, I will fly to
your country for sharing of funds according to our agreement.

Assurance: Note that this transaction will never in any way harm or
foiled your good post or reputation in your country, because
everything will follow legal process.

I am looking forward to hear from you soonest.please reply me via:
skwnogo@gmail.com
Yours faithfully,
Mr. Muskwe Sanogo
