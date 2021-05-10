Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB74378237
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 12:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhEJKdV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 06:33:21 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:43743 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhEJKbU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 06:31:20 -0400
Received: by mail-lf1-f50.google.com with SMTP id x2so22563705lff.10
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 03:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C1bGqFoAr3Dm/nAsPYbR3i3yRqydV4li4lsV6x+0ahU=;
        b=suHvE6T1jtar2wDNXujCmvlusvPzz29xXPqNk3nnZMSZ+Jlu/cLuGC0hAcypGmwnDy
         xM9ztLI8eSvYEUkN5urhfPYBzV47mtZXKbHRrVcJP8SHTpuic4JZbq1QqgWPpGIy2sb8
         DR8MdHn2anSiAdviNSGWydEh/tIoMlxx5mjHsQXipPVxYZmZp+jEfkd+fH5Ln4smKlve
         lkgNZS148ANOxSOcxZqt3kMMOcoNWAQ4vBO9c3QeUdwCe/EreDlozaIjk2VgHFNXvFzy
         ja5J7TPdfQS7X68vL40LeqF9QXSUA3SmXN0NQJCJP1tYu42ihQ5l2XRmGSWfR+qgtTAG
         AkvQ==
X-Gm-Message-State: AOAM531Txmfuv4SCLqr2D9ww/ZzG5G7p86vvaebrsZbgR5hcxZg9/4Oy
        fKktb4/vJe05z7SmQfJXfZc=
X-Google-Smtp-Source: ABdhPJy6GbuSSAPp2pAx8zY67AVdFL8jT0JHBy6DiCzbVrHD4aswUk/VpnHqkQU4/IOS2CMNUPWApw==
X-Received: by 2002:a19:385c:: with SMTP id d28mr16254059lfj.13.1620642614189;
        Mon, 10 May 2021 03:30:14 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id w4sm3201658ljo.1.2021.05.10.03.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 03:30:13 -0700 (PDT)
Date:   Mon, 10 May 2021 12:30:12 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Oliver O'Halloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Joe Perches <joe@perches.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 01/11] PCI: Use sysfs_emit() and sysfs_emit_at() in
 "show" functions
Message-ID: <20210510103012.GA76437@rocinante.localdomain>
References: <20210510041424.233565-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210510041424.233565-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Joe for visibility]

[...]
>  	spin_lock(&resource_alignment_lock);
>  	if (resource_alignment_param)
> -		count = scnprintf(buf, PAGE_SIZE, "%s", resource_alignment_param);
> +		count = sysfs_emit(buf, "%s", resource_alignment_param);
>  	spin_unlock(&resource_alignment_lock);

Following the work that Joe did recently, see:

  https://lore.kernel.org/lkml/aa1819fa5faf786573df298e5e2e7d357ba7d4ad.camel@perches.com/

I think we ought to also add the missing newline to our sysfs_emit() and
sysfs_emit_at() users, like the one above and the following:

  drivers/pci/pci-sysfs.c
  540:	return sysfs_emit(buf, "%pOF", np);

To keep things correct and consistent.

Bjorn, I can follow-up with a small patch after this one, or send a v2,
or, if that would be OK with you, then you could fix it during merging,
provided you decide to merge things as-is.

Krzysztof
