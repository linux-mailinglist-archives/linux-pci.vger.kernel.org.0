Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443F02B8E74
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 10:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgKSJM2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Nov 2020 04:12:28 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:35748 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgKSJM1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Nov 2020 04:12:27 -0500
Received: by mail-wr1-f46.google.com with SMTP id k2so5658361wrx.2;
        Thu, 19 Nov 2020 01:12:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ghQatJV2M5BRcgigmzEkdEj1L3L/t40fnfIoSb+yJJM=;
        b=WnfyOxRwhV826cYSNurRxaYYLg6R9GjUALJuIF1Xx2W7AOZy/9qIZLda+2SOvDGfM0
         BVPqO73s2UgYW01Huag+UktCV4h3FmbLMJvuLy3n5GHfxV10iqOYgROe/PVJZoIrGh+F
         8X0klO49+r4p8OUWJE2k+bECN1hpH7vMDX1HdYc/3wZ5PFYavik8natlDRhzTtFZj2go
         h6J0s+2Cb4y0/YWdIDqeWJWfb92uWQB1r49tyww2D7SzwysgYtowrR3F6P0SpAeR1RIO
         JXIKRXA4sAndnPQIgEz48I/WmtIAGvW7rn6TJ593iOB9+Dqus2CK568G4admkWeuljTJ
         03jA==
X-Gm-Message-State: AOAM533bRClw6334T7ZL0kSe7EmPobvQ31tdWJR7gFpCZwjFq9KUnNjc
        SUsI2NXcpvPZgf4OAJ/iYtU=
X-Google-Smtp-Source: ABdhPJzzcgaiwcSqyP0kF1k1oISICrFDm+KRxUbhiFBADz8WMUdOrLoI5pRgpbX5hJStLDu/MkhukA==
X-Received: by 2002:a5d:514f:: with SMTP id u15mr8651782wrt.385.1605777146080;
        Thu, 19 Nov 2020 01:12:26 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id h15sm37495915wrw.15.2020.11.19.01.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 01:12:25 -0800 (PST)
Date:   Thu, 19 Nov 2020 10:12:24 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Decode PCIe 64 GT/s link speed
Message-ID: <X7Y2+DvRmAxvobtR@rocinante>
References: <aaaab33fe18975e123a84aebce2adb85f44e2bbe.1605739760.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aaaab33fe18975e123a84aebce2adb85f44e2bbe.1605739760.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Gustavo,

> PCIe r6.0, sec 7.5.3.18, defines a new 64.0 GT/s bit in the Supported
> Link Speeds Vector of Link Capabilities 2.

64 GT/s already, nice.
 
> This does not affect the speed of the link, which should be negotiated
> automatically by the hardware; it only adds decoding when showing the
> speed to the user.
> 
> This patch adds the decoding of this new speed, previously, reading the
> speed of a link operating at this speed showed "Unknown speed" instead
> of "64.0 GT/s".

Looks good!  Thank you for taking care about this.

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Krzysztof
