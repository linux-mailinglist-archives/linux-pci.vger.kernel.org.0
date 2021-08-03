Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5483DF843
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 01:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbhHCXKM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 19:10:12 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:41724 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbhHCXKM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Aug 2021 19:10:12 -0400
Received: by mail-ed1-f53.google.com with SMTP id x90so1128778ede.8;
        Tue, 03 Aug 2021 16:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=trQM0Hda030RDfLIu2oPMAoILMKZsnY/bU/76uuHF2k=;
        b=WpIwR/oLpVqzJ7QAFCfldsy7thyXRNoMBcyRSrETO9O7/hKSwDcCxAiPHHgyVcQ7GG
         SVEqN/AsgM3DmXxJfZxLxvij8G2u7AGJD5Zj11+ApSIVfbliSai5EcnjjPD9KADPVRuZ
         7AwWfAlfBkrWm0RLc0zCT3usRpl5NGZKglQgomApsr/rrU+CoJdCfvHoJJmIe5ljWWPJ
         VS/Xeuma3U1/mgHmNl7N9rJp3EQmmoOIW1b+s/QPQuugRFbO8FAXeyy4AHazsrIBUZN8
         2elbmCQ7LBiemM0zMw0IISSz1GEiPYAgCCfZnHt+PVw4yxSwiu8gUkWOsHiGxRhUQJ0L
         ob2Q==
X-Gm-Message-State: AOAM532BL8HTrLsuMWxmX8FxcH2Tz+JRmykTCTeMvwfKesAQd83PJC0t
        2WRkr38E09X1b0pFaqrZcQ4=
X-Google-Smtp-Source: ABdhPJxT+GbfrU9YXbQY7rBEwrAhYxRK4U8Xte6JjppSjmhiSgcjR6zfz5pWuK93JN0t3omly8SzeQ==
X-Received: by 2002:aa7:c489:: with SMTP id m9mr28666485edq.256.1628032198680;
        Tue, 03 Aug 2021 16:09:58 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id c13sm167217edv.93.2021.08.03.16.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 16:09:58 -0700 (PDT)
Date:   Wed, 4 Aug 2021 01:09:56 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] PCI: Always initialize dev in pciconfig_read
Message-ID: <20210803230956.GA65526@rocinante>
References: <20210803200836.500658-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210803200836.500658-1-nathan@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Nathan,

> drivers/pci/syscall.c:18:21: note: initialize the variable 'dev' to
> silence this warning
>         struct pci_dev *dev;
>                            ^
>                             = NULL
[...]

Nice catch!  Thank you for fixing and sorry that I miss this one!

	Krzysztof
