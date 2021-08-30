Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256243FB0EA
	for <lists+linux-pci@lfdr.de>; Mon, 30 Aug 2021 07:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhH3Fvr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Aug 2021 01:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbhH3Fvr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Aug 2021 01:51:47 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E703AC061575
        for <linux-pci@vger.kernel.org>; Sun, 29 Aug 2021 22:50:53 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id i21so28727963ejd.2
        for <linux-pci@vger.kernel.org>; Sun, 29 Aug 2021 22:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=RzIkdEm5aJl66a3p0t6hmEQ+Qv+8MFJLxj5JlLxnEbs=;
        b=HTX9Qg+oTZ7qbYjJxOlnMfcCjzeO8PW543NLbRZpyHm61TfySy9Rj0KqzRh9w4m6Wf
         QtjCBi43u1IBcRHU+M5A4iODbAGFMGXmaIQMFv2OVVh+xueJxCunaTRWb1sjPGsGw25k
         Czo7DtmgVHlcv3bTXlS+Q1/C6LbICtkvE/71WLExZj5sblHkdYygk8T3YCpW9bV1UdxE
         68vFLBVEv5Dt2Joo5lvrKlwKbndYW4MNmgk64zGEoTk6yLmh8BNEHzQ1yAnhxDOn/X9n
         LLh4F0IONNwKor+2JHppGxkgDQZ3p+d8bGZZ34v/eVwxvOtQ4HBQJ0d0Pj+8WcV8qPYQ
         2r2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=RzIkdEm5aJl66a3p0t6hmEQ+Qv+8MFJLxj5JlLxnEbs=;
        b=PtsiPGTe6BY60EvPpCR0N0KnODdxN1Hi53vNvQsxQs9wKTG9J3kJkV/ldI/yIEygoS
         lSzNeuI+KVzhWgVdGUd1v+G0tlwhU/0FFtbkguCglTPUTxr+2/lKCvv9k6s5a2mBcaK9
         gcyDLcTdET8nxnF5MoASYwRkrcSLblq7pWDSWtJaBTc7wbZEh5nA9o3pezh7v0bb+G+D
         +3Lux9ReqCmV38QtqIFqP3aM6r2Kc2TRQmIlWRCa2Q7ceE3A/YYb9EDJsYdDXVwP2uuH
         E4UI68z0yWh+2qnKgR+KqvrKok2NzCsn6bEtaENHgoE4XKvnpRfnv6Yq4ywzEb53cp/3
         je+A==
X-Gm-Message-State: AOAM5338/aErd/Hw9zNWRTMe1BV66v3gL6TnGdB3bz8dgyyQfuhPzOEn
        i8uyuFuxQs+tAL/OXAdDAQ6o363IAEw51AguAlM=
X-Google-Smtp-Source: ABdhPJxQhbtFJCkQSoXqmwjTh/Kw0WnS/s7JmnqI0L3/3PVW3yzdU0becNDNu5NM5KGtNjh6wLQsfomR+J2SJ3/fPs0=
X-Received: by 2002:a17:906:1789:: with SMTP id t9mr23374412eje.61.1630302652444;
 Sun, 29 Aug 2021 22:50:52 -0700 (PDT)
MIME-Version: 1.0
Reply-To: godwinppter@gmail.com
Sender: godwinpeter2401@gmail.com
Received: by 2002:a54:3251:0:0:0:0:0 with HTTP; Sun, 29 Aug 2021 22:50:51
 -0700 (PDT)
From:   Godwin Pete <godwinnpeter@gmail.com>
Date:   Mon, 30 Aug 2021 07:50:51 +0200
X-Google-Sender-Auth: s7C7iPpagu-KvF61mzOLDaffwG4
Message-ID: <CAGyeThARSPiLYmOOZO-tpA3acto5cEa4y9ebjxoSQabyCqLGiA@mail.gmail.com>
Subject: For your information
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

I just want to use this little opportunity to inform you about my
success towards the transfer. I'm currently out of the country for an
investment with part of my share, after completing the transfer with
an Indian business man. But i will visit your country, next year.
After the completion of my project. Please, contact my secretary to
send you the (ATM) card which I've already credited with the sum of
($500,000.00). Just contact her to help you in receiving the (ATM)
card. I've explained everything to her before my trip. This is what I
can do for you because, you couldn't help in the transfer, but for the
fact that you're the person whom I've contacted initially, for the
transfer. I decided to give this ($500,000.00) as a compensation for
being contacted initially for the transfer. I always try to make the
difference, in dealing with people any time I come in contact with
them. I'm also trying to show that I'm quite a different person from
others whose may have a different purpose within them. I believe that
you will render some help to me when I, will visit your country, for
another investment there. So contact my secretary for the card, Her
contact are as follows,

Full name: Mrs, Jovita Dumuije,
Country: Burkina Faso
Email: jovitadumuije@gmail.com

Thanks, and hope for a good corporation with you in future.

Godwin Peter,
