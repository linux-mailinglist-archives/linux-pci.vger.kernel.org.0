Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956483782FF
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 12:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhEJKl0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 06:41:26 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:41695 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhEJKiT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 06:38:19 -0400
Received: by mail-ej1-f54.google.com with SMTP id zg3so23759697ejb.8;
        Mon, 10 May 2021 03:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ug3AdZaoLVVLJj8pY6BgmKmKBqKVZuDXwrXQ2bHIYQk=;
        b=I+guoFS/CRxoHM56MzrgM04TJN0qy+dyqeba5vsKolKO76uIeu+H/wjv/g9j+56J2X
         WH33fLOswEEg0OkZrARHUNtH4Yw8Pk1rAh4MX1d0nDDWWpUwSWpdmKuqPRDSUQj1gEst
         Qv4Q9oxxwkYwg+QQRSni/abUpMAmwQ2EYQej9u06vXxAF4nyatydhKgsVAQOQXQ9aFZx
         IRGAt9WeiWlfpF5B0iHuTXGUfhpzFf188Rpc+3VvJM7MsRqkGoUB8gUWOKmgWP9IMgUq
         Z1lksygQiYgemn/819O47Y3UzS1Y8c1ygQZXvystUmWAi+FWEPy10TUB5x4+2afp4Xwl
         0WcQ==
X-Gm-Message-State: AOAM531qdk0FnbJyGr9nDpSEfuM8rytLq55GTl+MqYJ3ICcKD/912IO9
        3S3yUPLsp/L/WVXw+cKFh1k=
X-Google-Smtp-Source: ABdhPJwtTa+7TiMBjoanT3utg/RL+UohXwsw3xleowEgWhc46mReRiEDwgVERzqp0fg8UXgoBnU2eg==
X-Received: by 2002:a17:906:f909:: with SMTP id lc9mr24259532ejb.164.1620643033381;
        Mon, 10 May 2021 03:37:13 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id d9sm10980851eds.68.2021.05.10.03.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 03:37:13 -0700 (PDT)
Date:   Mon, 10 May 2021 12:37:11 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 43/53] docs: PCI: acpi-info.rst: avoid using UTF-8 chars
Message-ID: <20210510103711.GA78809@rocinante.localdomain>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
 <94842f2c0062c71b53144e55c648ec18fdde8eca.1620641727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94842f2c0062c71b53144e55c648ec18fdde8eca.1620641727.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mauro,

> While UTF-8 characters can be used at the Linux documentation,
> the best is to use them only when ASCII doesn't offer a good replacement.
> So, replace the occurences of the following UTF-8 characters:
> 
> 	- U+00a0 (' '): NO-BREAK SPACE
> 	- U+2013 ('–'): EN DASH
> 	- U+2019 ('’'): RIGHT SINGLE QUOTATION MARK
[...]

Thank you!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Krzysztof
