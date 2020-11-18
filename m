Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932C22B87CC
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 23:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgKRWgs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 17:36:48 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45817 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgKRWgs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Nov 2020 17:36:48 -0500
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1kfW4D-0002Ex-7e
        for linux-pci@vger.kernel.org; Wed, 18 Nov 2020 22:36:45 +0000
Received: by mail-ed1-f71.google.com with SMTP id s7so1500946eds.17
        for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2020 14:36:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R0i9MNzuHi9QhaiHbOL5epk3QC3RpHWnQN1IEYkXxcM=;
        b=I/vnl7Y4eERcEosg9vgl3TAizmgTJVTfTpBq3emJbLz6uysQ1iqRQ8xOtHEwNc/gzW
         bRHBV1pZEQ6PASNe9r6u9brQm/ct+F/B5zpJ8k5EW/cmmp0+MXNhGovAFEPJmrmMTqUi
         ujX3BB8DaNAwrJ4ha4V22fWu33r22PQtABfM8+XaVJTv+371VhYvJmOgk08Uk27taN0U
         Qy/LGTDoKmxcg9Qb+p3vjLIXbVGVhfkw4FbamuGhXvVHB8lKwxABMNwg0uR2f949K7aG
         q8FC9qkFHnYYKoIhqQJx/HGQoco/2SJOIB+P13EUdbErMpDPQ81Hi5OThoprNPG5afLe
         iFRw==
X-Gm-Message-State: AOAM532M1em+7He6/f/n0fkZbu/+4zC1jFBgNwBnJq/Ljju29rz0K/JL
        kBBucjpTKvTeN3Yd+rQMbYaI6Nb+lYE91ZqMkijlv4h2BT1r3J8ejsqIjUcdQR7cMvKT9HJ1mpO
        cUwlDfhLf++ru/XLY2/QQqcgurnGIoPve5oKPTqv0Ze4Zmjix0/VXzg==
X-Received: by 2002:a05:6402:114c:: with SMTP id g12mr27958854edw.167.1605739004883;
        Wed, 18 Nov 2020 14:36:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwZSeP14qhirFaFdR5GfKMqF/BnHjDrZDKcSJaRVXn+FktBZU5qRC4XC/uGhn8kvaBWA69sLuNNcwlZUcIdA74=
X-Received: by 2002:a05:6402:114c:: with SMTP id g12mr27958833edw.167.1605739004638;
 Wed, 18 Nov 2020 14:36:44 -0800 (PST)
MIME-Version: 1.0
References: <CAHD1Q_zS9Hs8mUsm=q0Ei0kQ+y+wQhkroD+M2eCPKo2xLO6hBw@mail.gmail.com>
 <20201118210516.GA76543@bjorn-Precision-5520>
In-Reply-To: <20201118210516.GA76543@bjorn-Precision-5520>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Wed, 18 Nov 2020 19:36:08 -0300
Message-ID: <CAHD1Q_yfFYrfAEHTA3mW25hK9DFFYnKQ2_1HCEnL4m=bc=rLfg@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>, lukas@wunner.de,
        linux-pci@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>,
        andi@firstfloor.org, "H. Peter Anvin" <hpa@zytor.com>,
        Baoquan He <bhe@redhat.com>, x86@kernel.org,
        Sinan Kaya <okaya@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Dave Young <dyoung@redhat.com>,
        Gavin Guo <gavin.guo@canonical.com>,
        Borislav Petkov <bp@alien8.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Guowen Shan <gshan@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Streetman <ddstreet@canonical.com>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks a lot Bjorn! I confess except for PPC64 Server machines, I
never saw other "domains" or segments. Is it common in x86 to have
that? The early_quirks() are restricted to the first segment, no
matter how many host bridges we have in segment 0000?

Thanks again!
