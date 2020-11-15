Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6026D2B32B7
	for <lists+linux-pci@lfdr.de>; Sun, 15 Nov 2020 07:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgKOGi7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Nov 2020 01:38:59 -0500
Received: from mail-io1-f48.google.com ([209.85.166.48]:45927 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgKOGi6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Nov 2020 01:38:58 -0500
Received: by mail-io1-f48.google.com with SMTP id u21so13964691iol.12
        for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2020 22:38:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=621cyGWiiZs6Vj0tRrBiG0e3tmbixDYQfyQ4RYNoGzQ=;
        b=Y5hWaUFPk+Ervd1JbVAn/tx2we+dBd9khx8f/OrN9ecOuQXPIDtPrgu+MzuFIQ6RkX
         TEZ+wrlH/++RFiLiZtpD5xI4diovpxo/jxtSB1pUqKFjstliKdrJLdygYxqmaNfoXWUI
         jkBFbFa1t67cohDR0o2/plaUFJVMSe78drZr5VsoiSvAcpIqtiDNu3GczNQDHdBwu38h
         N5IhEXaSB4QMvSC/MksWv6VSQfeXxCocOsYH30Z570MmaZmh+6Jn7kyAndbI7wuY2S1/
         oh/dKnG8aotdMfTomjRsrXyohHUXxT1E7Xo9dJWAVEQuIJw9+mjJ7bgzWkutfia6mT6A
         qfXw==
X-Gm-Message-State: AOAM531VWBVwRwMMFumhsLqn1ktMiJ9er9d7S6gauynGtDczd76atRqJ
        krouxyIUtTJ/gR3+nhGB/Eo=
X-Google-Smtp-Source: ABdhPJzkUkX6mq0yEpqhSXi5gxBN3tSlcycL+i66WJnGUjMDqtEyFj0P8hLkfPhzIzjTag4eHuCf1A==
X-Received: by 2002:a02:cb8d:: with SMTP id u13mr7596743jap.110.1605422338235;
        Sat, 14 Nov 2020 22:38:58 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id v15sm8332186ile.37.2020.11.14.22.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 22:38:57 -0800 (PST)
Date:   Sun, 15 Nov 2020 07:38:54 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] Expose PCIe SSD Status LED Management DSM in sysfs
Message-ID: <X7DM/hTfyYdw2jlO@rocinante>
References: <20201110153735.58587-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201110153735.58587-1-stuart.w.hayes@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Stuart,

On 20-11-10 09:37:35, Stuart Hayes wrote:

[...]
> +
> +	scnprintf(buf, PAGE_SIZE, "%#x\n", dsm_output->state);
> +
> +	ACPI_FREE(out_obj);
> +
> +	return strlen(buf) > 0 ? strlen(buf) : -EIO;

Question to you - since scnprintf() returns the number of characters
written into a buffer, maybe it be possible to use this return value
instead of using strlen(), what do you think?

Krzysztof
