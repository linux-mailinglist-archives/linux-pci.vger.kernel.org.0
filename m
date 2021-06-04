Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD66039B9F6
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 15:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhFDNkR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 09:40:17 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:43875 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhFDNkR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jun 2021 09:40:17 -0400
Received: by mail-qt1-f175.google.com with SMTP id c10so6944520qtx.10
        for <linux-pci@vger.kernel.org>; Fri, 04 Jun 2021 06:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hFfiaKSJj+MsPgijaTAyIXTI7ThvW7l6x3tonfCt1pY=;
        b=ICGNpG2jlxPT+khtaofssaOeXsDSOsnkFVlfv3svm19AvLbh/GZn6mBZNh0TCQRIVd
         z+Nmel497r+OQ5b7arvWeHyV33iobRuuuCLgVEbk1F10NFkDWSyvUOzEvi0iDcdA23sb
         FBIu0xHpBvchlcDfMj2VA6Pgz1IMpKEontR2NTidWmNkiUl18i7GBb53sreSUSUh14BK
         D9Pei8xBhqHAiDUYlhKvxqMY8JBgc0Gy36YerW2YJGhFcDJ/swxFg8NR5wbiuE+foVM5
         AOhwuZQuoOaa+AWpNZ6syCe4uzU0FAOPTmffm5+ztAQyXXbNbBgT9K8Xy0M0Hsn6Cpg2
         tIRg==
X-Gm-Message-State: AOAM531O491Hj5f0/wO4Hr/JdePlQdvQwVy4/Hy09ywfwHvGuDjX3BtM
        QjUVSEkxEnvYhYx4dxCI76k=
X-Google-Smtp-Source: ABdhPJwiSW2GYpqESt9ar7kcVej2W9Th+Us6M/ymrBAFMBYhGYD3Nzd8uOrFdD9PULqybx1Zaoc07g==
X-Received: by 2002:ac8:6898:: with SMTP id m24mr4703467qtq.8.1622813896976;
        Fri, 04 Jun 2021 06:38:16 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id j30sm3901466qki.60.2021.06.04.06.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 06:38:16 -0700 (PDT)
Date:   Fri, 4 Jun 2021 15:38:13 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
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
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 0/6] PCI/sysfs: Use sysfs_emit() and sysfs_emit_at()
 in "show" functions
Message-ID: <20210604133813.GA442452@rocinante.localdomain>
References: <20210603000112.703037-1-kw@linux.com>
 <20210604040749.GA2170475@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210604040749.GA2170475@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn,

[...]
> I applied these to pci/resource for v5.14, thanks!

Thank you!

[...]
> If we need to tweak the resource_alignment_param patch, I can just
> squash in incremental changes.

If you can pick the patch from the following:
  https://lore.kernel.org/linux-pci/20210604133230.983956-4-kw@linux.com/T/#u

Sorry for troubles!

	Krzysztof
