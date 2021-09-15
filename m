Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14A340BD06
	for <lists+linux-pci@lfdr.de>; Wed, 15 Sep 2021 03:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhIOBQ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 21:16:57 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:35670 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbhIOBQ5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Sep 2021 21:16:57 -0400
Received: by mail-lf1-f42.google.com with SMTP id m3so621738lfu.2
        for <linux-pci@vger.kernel.org>; Tue, 14 Sep 2021 18:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XfRXMjtlbOB9hT0VS81uKsSC2Ys4/4M5eqLtzjG70As=;
        b=T8qr+BIvBFL7Ht28UYD6b9NsJ+VltjXJDw0xDxAO54DZIOO50Z/ewroXGD6WmvtDoo
         SivmolnJNBIjjW8l94CdD6Qh8bDetITVF8y1Dz4ngm+Tg2ovYfdd+SfrRf3EVxYVD8rX
         W1jRRl7VeeqRo/IvbgYzXGu8tifsM3jJ7ixb09IiWeh12HHypNoJyZYhsMR8Wyc2QKJy
         1k3SywaSQ07j43Xf72BQLAai8QB7uLlten0PYqGtDVAXH1EOzjuiyBCso+lfELAWeLCh
         amkVzmXRQGJCsxWk3FQG7AEzv7uzBEvtBi4s5X6oCZBnFmOI5s3FbjoauXyfadGjaOP1
         JvWw==
X-Gm-Message-State: AOAM533AN9gtH8pcmHVxxowiRN/oYsz+rAVuxf66XKvP03/xh/lZMPRo
        MEqCdSB2QSgxzbw8H46wSdI=
X-Google-Smtp-Source: ABdhPJyg7dtyki5Bdmx60v9NRMnnXSm+u0S+yKdAG/KRlRDd/+MErwJeSMCyAwxZBEhn22o1BqwDkQ==
X-Received: by 2002:a05:6512:3991:: with SMTP id j17mr3914214lfu.280.1631668538069;
        Tue, 14 Sep 2021 18:15:38 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id a15sm1616653ljb.18.2021.09.14.18.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 18:15:37 -0700 (PDT)
Date:   Wed, 15 Sep 2021 03:15:36 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/4] PCI/sysfs: Check CAP_SYS_ADMIN before parsing user
 input
Message-ID: <20210915011536.GB1444093@rocinante>
References: <20210705212308.3050976-2-kw@linux.com>
 <20210914204014.GA1455147@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210914204014.GA1455147@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

[...]
> > Check if the "CAP_SYS_ADMIN" capability flag is set before parsing user
> > input as it makes more sense to first check whether the current user
> > actually has the right permissions before accepting any input from such
> > user.
> > 
> > This will also make order in which enable_store() and msi_bus_store()
> > perform the "CAP_SYS_ADMIN" capability check consistent with other
> > PCI-related sysfs objects that first verify whether user has this
> > capability set.
> 
> I like this one.  Can you rebase it to skip patch 1/4 (unless you
> convince me that 1/4 is safe)?

I will remove it, as per:
  https://lore.kernel.org/linux-pci/20210915011204.GA1444093@rocinante/T/#t

Thank you!

	Krzysztof
