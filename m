Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDAE2380A44
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 15:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbhENNSP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 09:18:15 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:44813 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbhENNSP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 May 2021 09:18:15 -0400
Received: by mail-wm1-f48.google.com with SMTP id 82-20020a1c01550000b0290142562ff7c9so1446869wmb.3
        for <linux-pci@vger.kernel.org>; Fri, 14 May 2021 06:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FBNyUsdjHhwK7690GdvUe748qMEUiBC+ZSsg1b7xtNc=;
        b=M7U0B7ss3bEcv5JQEZYYIuwZUS3C/vZT4JGWNyvVBAifXv1SrYmDonYTIF9noaNMx7
         RiYLVwKfsm3I13+pSo1wZnMDGBQj7PyKpeoqQrpsWFQTOCXbrJAc+DVwvlk+jOh7El+p
         wrGp2ASMQrjznbrHBfrqCPrw0nJd9Naf/Qz+3hDm4luQ8KVKza/R7VyLG7eok+wvCCUz
         s35lEl0PwPQmIq1KrmpSNYDOH/sg39mlF/7i6SIpy5QewlYGJG6UQR6U2FCvLM2Zqxwy
         TCeLt0jr4xo1MbRDPxSRGwIOLyllxXGxxjPdX5NoceXnAw8+c+yKeS8G6giM9ACAv34d
         hIkw==
X-Gm-Message-State: AOAM531tsUtnAOrYOV3uGKKJJRDMKAixVrwxMLJkiQ8njghxYYOP6p/G
        lgYulECsKqRZZSzMyelAofA=
X-Google-Smtp-Source: ABdhPJz3MVDPwZbRkIB1+P7WNY2kuKSp6xAm8vvBFhCcnAe6/ayLk9VHrDFh0NhpR1/o2vNiGMwW9g==
X-Received: by 2002:a05:600c:4e8e:: with SMTP id f14mr7115269wmq.65.1620998223083;
        Fri, 14 May 2021 06:17:03 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id c5sm1819652wrw.36.2021.05.14.06.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 06:17:02 -0700 (PDT)
Date:   Fri, 14 May 2021 15:17:01 +0200
From:   Krzysztof Wilczy??ski <kw@linux.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/portdrv: Use link bandwidth notification
 capability bit
Message-ID: <20210514131701.GE9537@rocinante.localdomain>
References: <20210512213314.7778-1-stuart.w.hayes@gmail.com>
 <20210514130303.GD9537@rocinante.localdomain>
 <20210514130845.GA26314@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210514130845.GA26314@wunner.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas,

[...]
> > I was wondering - is this fix connected to an issue filled in Bugzilla
> > or does it fix a known commit that introduced this problem?  Basically,
> > I am trying to see whether a "Fixes:" would be in order.
> 
> The fix is for a driver which has been removed from the tree (for now),
> including in stable kernels.  The fix will prevent an issue that will
> occur once the driver is re-introduced (once we've found a way to
> overcome the issues that led to its removal).  A Fixes tag is thus
> uncalled for.

Thank you for adding more details.  Much appreciated.

Krzysztof
