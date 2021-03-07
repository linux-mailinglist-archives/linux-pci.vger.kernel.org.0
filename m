Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361C0330354
	for <lists+linux-pci@lfdr.de>; Sun,  7 Mar 2021 18:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhCGR2e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Mar 2021 12:28:34 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:33791 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhCGR22 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Mar 2021 12:28:28 -0500
Received: by mail-oi1-f181.google.com with SMTP id a13so8583225oid.0;
        Sun, 07 Mar 2021 09:28:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FgL+9rKQ2SbYD82Zdufywe8UTaKB24r3GYmTSLgcyds=;
        b=dhJHmBLopzDz2rPazy+Bdt1rGgxu7zn9Y1LwCq0ZnmaddBno4Lxj1nueAhNKHr826u
         oFqPJXw1GJF/UHYqy3Im23ez6DRaACpgDLPAAZ2vsphFsVp8g2izaVmq+U1d2D04QN3q
         8yjAdw/s8FkzcaEPLzpodvNlyDHl9TMfnAj6nMsG3MceudfaCxvEKzBCJ7QzxiWaBSqw
         HunnIN/hxP26Ch2sBT7tudjVXESUUqs9F0KcDKqz6MrFUfs2wv1b0wWZwAITcoqD4xv6
         FCXG6QVkAfQ3ux1tzB6tX3hxgxz8+3ZuSEt1I4tngOgPBNUC+wR6SKYB9POCYWbuTvIf
         6Ayg==
X-Gm-Message-State: AOAM530wLhHASGPYy9f1qB7KvWw9nZiYesycggPme6joKKc80HKqHWfl
        kZ1GZ0RdLcbcMJRlxKY8m/kzWXtKg0V+iw==
X-Google-Smtp-Source: ABdhPJwMtx8qAEsYusdreSoBbQXAXX5w/wm8CzFxJh9VtYqwg9D85Td5bo7tYZq5lAcu+PcKLNsUZg==
X-Received: by 2002:aca:4b4d:: with SMTP id y74mr12544964oia.97.1615138107431;
        Sun, 07 Mar 2021 09:28:27 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id h7sm2165816otm.0.2021.03.07.09.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 09:28:26 -0800 (PST)
Date:   Sun, 7 Mar 2021 18:28:22 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Constify static structs
Message-ID: <YEUNNlmaZoF89jRl@rocinante>
References: <20210207221604.48910-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210207221604.48910-1-rikard.falkeborn@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rikard,

Thank you for sending the patch over!

> The only usage of them is to assign their address to the 'ops' field in
> the pcie_port and the dw_pcie_ep structs, both which are pointers to
> const. Make them const to allow the compiler to put them in read-only
> memory.
[...]

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Krzysztof
