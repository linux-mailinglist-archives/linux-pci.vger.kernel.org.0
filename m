Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A8F330E92
	for <lists+linux-pci@lfdr.de>; Mon,  8 Mar 2021 13:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCHMmT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 07:42:19 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:47041 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhCHMlt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Mar 2021 07:41:49 -0500
Received: by mail-ot1-f54.google.com with SMTP id r24so1924387otq.13;
        Mon, 08 Mar 2021 04:41:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wnjJEWltJxnJAS7ei51frqp+Gqe5iNLU9Hb1KDN2mDM=;
        b=hFkhvhUWz2hpzsNweXVFf0S6s0yjFiCzhgnKa6x0UD9tyB8tL+WwnlOu1JYCPTB9KE
         C9sUDBv9NQpMg4i82IIvC7z1WorLchpEk1BCj6Q4i92ZsBR+CZHnaSH3WqXZrq6NiyyN
         dvwxatr8PucMS5OOJy8XVGCsRZqeDgp6tKYj2iOuDanfE6dR0Q4KXf66fu1d0GLBk0JX
         3CY8oPFMpyEJmM2sr8ah4qH3PNuVCuuXS9iLYCxtV5QPvFLSzAP9nS69rP8b/bsktW20
         CNdq35vtDdPPROWgC8+WSVKIz9OPcc5Pke6N/Aa3kkRE40jseS/1j7M0IK2iXJNTG0UA
         Nhtg==
X-Gm-Message-State: AOAM531/PaFt4cMm8Qke93YiAM1YN3I38RBx3qxBOFiMc4/fF3ujmSgC
        oPZcdD+aofgOHDQCCD2BJY0=
X-Google-Smtp-Source: ABdhPJwfXf5Dyz9lBOLyRB5b3y9JqeZ/Pe0VayBp9T/qQE0m9Bo68UMlMXaE6ohpRRyd3DpOKlUr/A==
X-Received: by 2002:a05:6830:4121:: with SMTP id w33mr18914200ott.361.1615207308640;
        Mon, 08 Mar 2021 04:41:48 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id y83sm2385499oig.15.2021.03.08.04.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 04:41:48 -0800 (PST)
Date:   Mon, 8 Mar 2021 13:41:44 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     'Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] PCI: microchip: Make some symbols static
Message-ID: <YEYbiCPCDTdbQheu@rocinante>
References: <20210308094842.3588847-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210308094842.3588847-1-weiyongjun1@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

[...]
> Reported-by: Hulk Robot <hulkci@huawei.com>
[...]

I am curious.  Anything else of interest did this robot reported under
the PCI tree?

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Thank you!

Krzysztof
