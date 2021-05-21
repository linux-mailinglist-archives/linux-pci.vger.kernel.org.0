Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD1438C9D7
	for <lists+linux-pci@lfdr.de>; Fri, 21 May 2021 17:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbhEUPQK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 May 2021 11:16:10 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:33721 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhEUPQJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 May 2021 11:16:09 -0400
Received: by mail-lf1-f47.google.com with SMTP id c10so9203038lfm.0
        for <linux-pci@vger.kernel.org>; Fri, 21 May 2021 08:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+AU4U+LWIwRimGlHoLA97XtxBZDer30TIDgK6CSlStA=;
        b=s8v4bu19fXgguj3yASRINcCFbn0Ltqrq3qDK5aurrFg0M+js0akuxkbhAM/MWCnhEE
         H0K5kVAq/5QnTMXqoRt5ZVQ5a6AeURw4m5X0fzj4YOvdn1OGnCcFN7LiB1VPmPKluL+Z
         cHHrOQD0qlKgTMgrro/d+qH6gPkYoSUiGuIbR7x3eGlDDMy4NY0F0cF8gGpXUMWiP337
         VYMtpd4ciuvh5GLh2fwNHtGm70obYTfkfbIaOaVsGfBbze58A3BvM239nJNoGVLaAMKs
         QmkDdW/Oglw+gFWOK7QwCoyy3okSplOJi9O63YqoDmaMhOeMS5Y8ud7MEJa8CuTM9bW0
         SGoQ==
X-Gm-Message-State: AOAM5330JgsK9zf4gOX/2gcGWBNBPC4zBW7gG+ZeKL+MypO/RjsYLtdP
        Un9pIwP9SKbIQ32NiXYupMs=
X-Google-Smtp-Source: ABdhPJyI5ynNExs/OXE14H4YINebmKlft5DbQs8pZw+w5RAzs5rPslRgffmAUiWzCsF9JFo6kQR6zA==
X-Received: by 2002:a19:f607:: with SMTP id x7mr2593708lfe.111.1621610085533;
        Fri, 21 May 2021 08:14:45 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id d16sm648642lfm.202.2021.05.21.08.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 08:14:44 -0700 (PDT)
Date:   Fri, 21 May 2021 17:14:43 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Joe Perches <joe@perches.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 12/14] PCI: Fix trailing newline handling of
 resource_alignment_param
Message-ID: <20210521151443.GB39346@rocinante.localdomain>
References: <20210518034109.158450-1-kw@linux.com>
 <20210518034109.158450-12-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210518034109.158450-12-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Greg and Sasha for visibility]

Hi Bjorn and Logan,

[...]
> Fixes: e499081da1a2 ("PCI: Force trailing new line to resource_alignment_param in sysfs")
[...]

This probably would be a candidate for a back-port to stable and
long-term releases.  But, since the move to sysfs_emit()/sysfs_emit_at()
would be then irrelevant, I can split this patch so that it fixes the
issue first, and then other patch will move it to sysfs_emit(), so that
it would be easier to apply when back-porting.

Would this be fine with you Logan?  Especially since you already offered
your review.  I think Bjorn wouldn't mind the split either.

Do let me know folks, and I will change things accordingly.

	Krzysztof
