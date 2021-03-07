Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F44330375
	for <lists+linux-pci@lfdr.de>; Sun,  7 Mar 2021 18:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhCGRzC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Mar 2021 12:55:02 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:35744 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhCGRyX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Mar 2021 12:54:23 -0500
Received: by mail-wr1-f48.google.com with SMTP id l12so9003477wry.2;
        Sun, 07 Mar 2021 09:54:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hQIrCN/YRAQaIM0XHUHOXnwhCxwofjceFx6bnlKYcVQ=;
        b=JQLWnYiI9eNiPXkQ3ZMFrqo9C0HiWopDj68hHCfS+Gou62ZklbFHN1v8tsQAK8U7H2
         6YCwE8YBcn2HIuuil/aFrUFcZOeEb60IFRke9oR9a9ftTUum2N3vZEd9pqNZ+uJ0Wcv/
         4r6uWp2hYVoLawxfjWo2dEcFD/R9oz6NKPo8AJB8ZcjbVR62iW9c9o7gB9iWa2N/8vYi
         VyRWXix+XM3RJlHW+geCUw16ahBBHKEMd4oD3V2p/y/ehmuEPf6IqEs2KJ9/R+g49h0r
         e++uzgazJO8jQsz9vHfUoVj+hqpngMXJsCMahk5+6TfSxdTCQcqMMqz6I5BxdWk9uQKY
         2qag==
X-Gm-Message-State: AOAM531FZ4laC6oYeI1pOly+4TrffLXpG5N3RR3nYavccsUUGVmBp7FJ
        S7CsCZFQU1e+0ACDvho5YxLUK5f0MaCC3A==
X-Google-Smtp-Source: ABdhPJz5KR1N4kt9T40oQb6XmR22tL4GpbMr1j5JwlYg5uCoOO6M++s7e6nap4mofmUQ5H87wsXTqg==
X-Received: by 2002:adf:cf11:: with SMTP id o17mr10432794wrj.391.1615139662504;
        Sun, 07 Mar 2021 09:54:22 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id b15sm14734557wmd.41.2021.03.07.09.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 09:54:22 -0800 (PST)
Date:   Sun, 7 Mar 2021 18:54:20 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, wangzhou1@hisilicon.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] PCI: set dma-can-stall for HiSilicon chip
Message-ID: <YEUTTEHYx0ZxB3Ia@rocinante>
References: <1610960316-28935-1-git-send-email-zhangfei.gao@linaro.org>
 <1610960316-28935-4-git-send-email-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1610960316-28935-4-git-send-email-zhangfei.gao@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

[...]
> Property dma-can-stall depends on patchset
> https://lore.kernel.org/linux-iommu/20210108145217.2254447-1-jean-philippe@linaro.org/
[...]

If you plan to post another version of this patch to include the above
link into the commit message or reference to the commit itself, as
Jean-Philippe's series can already be included in the mainline (since it
has been a while now from when this series was originally posted), then
I have a favour to ask - would you also be able to also capitalise the
subject line (so that it's consistent) and change "chip" to "chips"
since there are two you mention in the commit message.

Thank you!

Krzysztof
