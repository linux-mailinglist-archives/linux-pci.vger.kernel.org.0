Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AFE2B8E6A
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 10:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgKSJKT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Nov 2020 04:10:19 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:34989 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgKSJKS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Nov 2020 04:10:18 -0500
Received: by mail-wm1-f52.google.com with SMTP id w24so6035831wmi.0
        for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2020 01:10:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gcBMvWNKXqqCpwFqL5JEnpU6lESB5PtkfY/98pOfNjs=;
        b=imUVv4b9XbW/lZdp3Ari9sLx+EcSEiL8p1DlEwtvvR7sbC5mfEYA1fbsKxlKNJ5NME
         gqiVm58QuqCGlo6RiosQjJgIyDnXOH9GJHn6ZHGE/cuci7mTumsap3emKbJclTEM0D4X
         YYkrHT01ZKO7TQlFLWkzxez7y6WKuU3izkvnY2XX0g32uz2bSnWuuZZ2k+NkDP1xBeWv
         1lA7F0sZbE5CRcASzLvapyZiNoDIQN7WlW+KstKzdHgGUgVePv4H0ZsrozTERNS6SBn/
         6ApLyOD9hMx17RhrgSFgR1/K/oHLlqxxHtMw11Lo8EqtXZqW8+ScEV9Fzd/kiHnadZb6
         q96w==
X-Gm-Message-State: AOAM533J6e7cJ24NbSFhvTm20SVlse/hnVJQ3X1HlAr8kTlURroYrfJ3
        CTgvpr49zUxzBfXAGVP8l1GdgYolzqr5llVs
X-Google-Smtp-Source: ABdhPJwB5lpS658hmgx5gidaCFzrZVQ5R/zUDZ0ps2DV6YjL+4P4kns0NW9L2Y82uHlRdzcheOQzaQ==
X-Received: by 2002:a1c:e3c1:: with SMTP id a184mr3413964wmh.88.1605777017222;
        Thu, 19 Nov 2020 01:10:17 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id w10sm39428654wra.34.2020.11.19.01.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 01:10:16 -0800 (PST)
Date:   Thu, 19 Nov 2020 10:10:15 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH] lspci: Add PCIe 6.0 data rate (64 GT/s) support
Message-ID: <X7Y2d4hlo9CgbH0B@rocinante>
References: <ad286025549e42030bc75ef9f99af9c92071a205.1605740212.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad286025549e42030bc75ef9f99af9c92071a205.1605740212.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Gustavo,

> This enables "lspci" to show PCIe 6.0 data rate (64 GT/s) properly
> according to the contents in register PCI_EXP_LNKCAP, PCI_EXP_LNKSTA
> and PCI_EXP_LNKCTL2.
[...]

Looks good!  Thank you for adding this.

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Krzysztof
