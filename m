Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED5034B20A
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 23:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhCZWPY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 18:15:24 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:41506 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhCZWPR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 18:15:17 -0400
Received: by mail-wm1-f52.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso3742396wmi.0;
        Fri, 26 Mar 2021 15:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=quVE0WXN2dW3u57qVidMnV0S6DB+ccRjTK3ulEhufMY=;
        b=AHnh5zExfyYh53uct4ePYJiX+Wg1eUXhG1ftOhOu0ASa/ibpTkLsAcJYHi3BqNR5Ij
         1cWzUQ/NDV86jkvPJSdgjRVb4tzZ9dfPeRK8VtWLVqGO4QHUMxl2hpRbXxbueJiIq+2t
         YOtJ4OnRd75jIoyM/iGdnij7rsIOsKwiJvVWLmCtSdKKMKkHhuZ1AANreGTYkw96oJIG
         V7cZKXdNeMZf84Kwvo14tg6xzx66XuCP3j8Vsmn9PRa/w5iEzb7OOQqjZvTyK5plgt3d
         sLMFIjcv+RPCc7q/bdvIhoHbCmWMXPZ+OMB8N6o446oBIpl+9FzSTaPiK8EUcSVQvWpi
         FtGQ==
X-Gm-Message-State: AOAM531wv5s5yMWmYywixBxWIWr4reQjH2H8KYhgwIwX3kJHzc0BFNZP
        G10gnGVmJxVUjaVRL3cH3NI=
X-Google-Smtp-Source: ABdhPJwJpYYpKJJ7WbVu79dOT5V+3IC/DDkoERx73/BdpL2XjCPIix6QqssL2u068fu7izd+l4conA==
X-Received: by 2002:a05:600c:224e:: with SMTP id a14mr14685630wmm.57.1616796916105;
        Fri, 26 Mar 2021 15:15:16 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id o2sm4441658wmr.10.2021.03.26.15.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 15:15:15 -0700 (PDT)
Date:   Fri, 26 Mar 2021 23:15:14 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: remove redundant initialization of
 pointer dev
Message-ID: <YF5c8gVi6fOnfiv3@rocinante>
References: <20210326190909.622369-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210326190909.622369-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Colin,

> The pointer dev is being initialized with a value that is
> never read and it is being updated later with a new value.  The
> initialization is redundant and can be removed.
[...]
> -	struct device *dev = epf->epc->dev.parent;
> +	struct device *dev;
>  	struct pci_epf_bar *epf_bar;
>  	struct pci_epc *epc;

Thank you!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Krzysztof
