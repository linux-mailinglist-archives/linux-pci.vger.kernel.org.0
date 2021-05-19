Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156E238951D
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 20:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhESSOa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 14:14:30 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:35433 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhESSO3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 14:14:29 -0400
Received: by mail-lj1-f174.google.com with SMTP id f12so16704521ljp.2
        for <linux-pci@vger.kernel.org>; Wed, 19 May 2021 11:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Izc/tRRcUSggujOOu4QqDIfPNIqokvI/WDQ0Ssknjoo=;
        b=C9LrNugiX5lFiCS82loMUMkQggyZWJMXM1XFLkc8QzleIoOlZTF5te/zfWtUf6oAMe
         nfsgbCapa74ojYQf0Jd4zPxMJdh+NCESK4JpNzqVouw2f0qlLILqBNx7R4O2AQijH4Wx
         xweEaItkax+BAdQFHZZdReJLFZeNTPxrwFylvfmFZAv/xzAs3kW1rYHTDowY9daSNRVO
         eGcfRSp8pC+mFxSKI4enmyKD0SsOks6HIlAP9OUvl7F+W3wutG8sPdTs2jTnMFi2O6R9
         jwf8a1UHWUtF9yh5SrUz/wSvp+kbrvqkVRxtdMahGi8wz67mBRh0l5ctrqycmhFk+GyK
         LF/w==
X-Gm-Message-State: AOAM531noZnZbJn9jMka66b9YkI/fHzCr8iivx2XfbiEcFfbPihioXdj
        7DwsHBs1s3haougUZQsT7PY=
X-Google-Smtp-Source: ABdhPJwTvv1iqFSs2byDp7oikpdQmJhKTcNcbkNX2ZzErjrG5KggDeRlJunDyYjxXPR0Od0em3h9+Q==
X-Received: by 2002:a2e:9896:: with SMTP id b22mr289552ljj.329.1621447988387;
        Wed, 19 May 2021 11:13:08 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n7sm44574lft.65.2021.05.19.11.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 11:13:07 -0700 (PDT)
Date:   Wed, 19 May 2021 20:13:06 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Ray Jui <rjui@broadcom.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: iproc: Fix a non-compliant kernel-doc
Message-ID: <20210519181306.GA603045@rocinante.localdomain>
References: <20210519173556.163360-1-kw@linux.com>
 <c1c2de58-64bf-75b7-0976-fba906c58273@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1c2de58-64bf-75b7-0976-fba906c58273@infradead.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Randy,

[...]
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks.

Thank you for the review!  I am going to send v2 as I have noticed a few
other places where the kernel-doc is not formatted correctly, so that we
can resolve all of these at once, hopefully.

Krzysztof
