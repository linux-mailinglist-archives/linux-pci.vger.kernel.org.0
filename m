Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C62E318990
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 12:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhBKLdq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 06:33:46 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]:34368 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbhBKLa1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Feb 2021 06:30:27 -0500
Received: by mail-lj1-f173.google.com with SMTP id r23so6975055ljh.1;
        Thu, 11 Feb 2021 03:30:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tg4tfjNqZ3JeI2D8+BHIUKZaEi2EC2A1LyzDHLzlRZo=;
        b=VDD5V/03CsRFj4z76YLqNiNGlE9JafzBeJ7DaBgu5btTPiGeYVeLbxmkySKZ0SA325
         wdQRapMT0Nl0csvWYN5/I1yUbMO/uUuEEfiuAnfsodT0J6U8JWFIH3GN8B3tcSDF6PZ6
         /HGRLFjvvvzbAP5IA5osVPlKD+VY5G99RARQubSi16dm0aeNQEvoDGSgKNu4X+PBblfv
         8o84h4O8HhGuqV8zTDmdnVvCH7dEMwYgG1PaEXkAjyaihymF583Zrha2urz5ITsibOtG
         k47btYUkvDPnctTJYVjBv6WYIGSEzfOhpNt8/lBbAdlf2QZGRUYumFIZH7nJtX8iJZh3
         fO/Q==
X-Gm-Message-State: AOAM532bADaLFTNphub4oRBnqGTo6E6OsrvPj439gl0gkJduYASl6j/r
        43CiJ8hYmjgil6GB0P3jSi4=
X-Google-Smtp-Source: ABdhPJyJ8jEvQEW21cZvr69Fxe93/qzk2Sy2NUa/3aXHN43FPepK1Bz4Ymv/BqYrHWKMpIRzIpI+3g==
X-Received: by 2002:a2e:9cc4:: with SMTP id g4mr4833412ljj.0.1613042984792;
        Thu, 11 Feb 2021 03:29:44 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id b14sm618337lfi.164.2021.02.11.03.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 03:29:44 -0800 (PST)
Date:   Thu, 11 Feb 2021 12:29:43 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 3/6] misc: Add Synopsys DesignWare xData IP driver to
 Kconfig
Message-ID: <YCUVJ4TZRVfN1pEn@rocinante>
References: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
 <1b76d5e1a47bf3a30a863319587195037ac3e4d7.1613034397.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b76d5e1a47bf3a30a863319587195037ac3e4d7.1613034397.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Gustavo,

[...]
> +config DW_XDATA_PCIE
> +	depends on PCI
> +	tristate "Synopsys DesignWare xData PCIe driver"
> +	help
> +	  This driver allows controlling Synopsys DesignWare PCIe traffic
> +	  generator IP also known as xData, present in Synopsys Designware
> +	  PCIe Endpoint prototype.
[...]

To be consistent.  It would be "DesignWare" in the sentence above.

Krzysztof
