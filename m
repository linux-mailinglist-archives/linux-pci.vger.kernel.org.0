Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448E33809DE
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 14:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbhENMvi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 08:51:38 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:55919 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbhENMvh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 May 2021 08:51:37 -0400
Received: by mail-wm1-f49.google.com with SMTP id 8so1765653wmc.5
        for <linux-pci@vger.kernel.org>; Fri, 14 May 2021 05:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SESIfhMqYFc3E1CEVb69AU3q2QVBKoIo933+rDpEkME=;
        b=kbuPykgxvzHjYr/K3STZv3g/Jc0e+kpLQhvFCdHUXpwbqvtfDIuadeKfPSnpMUO5Gc
         i706xNLlSWvlrNZZWZrC10M0CG23lVLHMGmJyD7v6NXuJZv4HMmKAAkjURR9iwb7c0AQ
         6eVgtVLhexb5WBkOMRRMIRw+8QoKxPkN7bfoOJdF+eyVvVrLZdC2cLjydF3nQymfYo4N
         XIi2TGuOLRRhuIhioQhJG2SUhZi5VWVYynbi70u029igC9wjcjiM2RfzCez0euz/F2Z0
         PkCNUxAyqu3ZXOc1jT17wh6cB2uxhbPKIElrMNIxpybCDTq7qB2LStFrbUlcTZg3jbgp
         OA8g==
X-Gm-Message-State: AOAM532OFgb3qZ7pwzhtpOrxxwmdFsXGayKa6hIHOfuEe4shYKReVBRh
        hP/XtDv0tTAvLnTNzRJUOEw=
X-Google-Smtp-Source: ABdhPJwdJTGrh3otjExL57AmLpHA4p+9NsFBw+qkNWdaFfHvXjKX1tujGbSTlex5jlm1KFu/lzH3xw==
X-Received: by 2002:a05:600c:230f:: with SMTP id 15mr47572214wmo.19.1620996625621;
        Fri, 14 May 2021 05:50:25 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id s5sm5442644wmh.37.2021.05.14.05.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:50:25 -0700 (PDT)
Date:   Fri, 14 May 2021 14:50:23 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/1] PCI: mediatek: Remove redundant error printing in
 mtk_pcie_subsys_powerup()
Message-ID: <20210514125023.GA9537@rocinante.localdomain>
References: <20210511122453.6052-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210511122453.6052-1-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Zhen,

> When devm_ioremap_resource() fails, a clear enough error message will be
> printed by its subfunction __devm_ioremap_resource(). The error
> information contains the device name, failure cause, and possibly resource
> information.
> 
> Therefore, remove the error printing here to simplify code and reduce the
> binary size.
[...]

Thank you!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Krzysztof
