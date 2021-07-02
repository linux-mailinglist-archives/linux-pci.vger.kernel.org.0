Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6CC3BA4C5
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jul 2021 22:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhGBUp3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jul 2021 16:45:29 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:40873 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbhGBUp3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jul 2021 16:45:29 -0400
Received: by mail-lj1-f171.google.com with SMTP id d25so14979132lji.7
        for <linux-pci@vger.kernel.org>; Fri, 02 Jul 2021 13:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wwFAE8l/C4zFxc7d7E3lrH3jbEGK/fQ5qtao/zfzSoA=;
        b=HnW5weQBMggFXbZwJWgjFV6ormdf2HzuWbQ2vEyesmK2pcN/FIW2xttY3jCDIGLyNt
         5O2cpdjfOEWOYDDgESNzUemflzIBIWETcGGdMH+yPjvRh5VzZRVOAjtcuo+JQLXvwPL6
         +83CM4LSd2J9Ajx5h++iJDlEUmkRq3hiuRA0ut2Ix8esJOSX9OuvbzenoWINbo3Gbqg3
         dGwAajgHlx36BXfxbRuqFekCLOD+qrrubnrS5fr/mzzQ3Nghc+XVZA/yQis/3ZBsXs3D
         pFPd28Nvt2oJaZ24pbT7o4YdmNcASwDn0D0rbcu2ziqF7xXYZyj3H3o/tHwBUJvS+zpl
         jQpg==
X-Gm-Message-State: AOAM532a4crjbEU2/0jYcvBj/mPw6xzU9Ohxb66P8HRY1J5k373WEfje
        13HzkpLti9+2NKubYRtL2og=
X-Google-Smtp-Source: ABdhPJy+g8+u9rbb3gEXKSB0acIR9Mjdm2d0NVvnKca/0vVtUpsrxeFiIzeit7dGcRkhLyNgffAPLQ==
X-Received: by 2002:a05:651c:2103:: with SMTP id a3mr868636ljq.218.1625258574836;
        Fri, 02 Jul 2021 13:42:54 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id y1sm364974ljc.29.2021.07.02.13.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 13:42:54 -0700 (PDT)
Date:   Fri, 2 Jul 2021 22:42:52 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Ray Jui <rjui@broadcom.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] PCI: iproc: Fix a non-compliant kernel-doc
Message-ID: <20210702204252.GA390418@rocinante>
References: <20210519183829.165982-1-kw@linux.com>
 <3623373c-b95c-344f-63c3-3eeeda623e90@infradead.org>
 <20210519224908.GA616654@rocinante.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210519224908.GA616654@rocinante.localdomain>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Randy,

[...]
> I will update everything accordingly.

Sorry for the delay!  I just sent a v3 of this patch.

	Krzysztof
