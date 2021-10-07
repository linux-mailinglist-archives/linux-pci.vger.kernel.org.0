Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B34425351
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 14:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241261AbhJGMo7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 08:44:59 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:41656 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbhJGMo7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Oct 2021 08:44:59 -0400
Received: by mail-pg1-f175.google.com with SMTP id v11so5540779pgb.8
        for <linux-pci@vger.kernel.org>; Thu, 07 Oct 2021 05:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hHKXEKhbma9Zz4qn47NNdpYAgHY/k0KtHtMSD51mJAc=;
        b=D8pyMKRACUHUYqU/CrNis9WgITZ+yxqsCZvKF4AFXrK4Fce7dLkKJdfYpwkXkv5Wnc
         MO3z1YVMlGdIAeGf1jCSSKdaDQo0H69D18WhNm4vVxhUfFcBcdGlYwI/Bp2b43p7Gj17
         MTIaRZoP8OQ7GRSJQeirECxNxOa+9bXF3nVjjdisu6xhD8U/cukcIzlODmZMMMiaZ993
         kzd18FaGS41/0tVIGw63sYywQZV3SHLW/QOE3xDPi5pefdYl9OOmKgeB/Vd4ltHjeqbv
         8jFj/BKpzpPcpWf6aFxX3F4r5xEmBwgFNmvv98u/h2XqV7tVPpJ2ijfTs7vvg3x7MVOe
         n7mA==
X-Gm-Message-State: AOAM5315/fIiUIEr2Wu5801cTuExg4xlbLUjsde6ThWxFPN7JJ7gDSxz
        qHxdSiyHKrqrDrXbakZlTK3h7sk1Q1g=
X-Google-Smtp-Source: ABdhPJypI21Sv4zNqku3m8Er5/l1gzrYiWDR41czyzltN6j3Yo9UApyrCwx1eNFqpgk//1NkYJs15w==
X-Received: by 2002:a63:6e8d:: with SMTP id j135mr2837585pgc.116.1633610585297;
        Thu, 07 Oct 2021 05:43:05 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id t4sm18784359pfj.13.2021.10.07.05.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 05:43:05 -0700 (PDT)
Date:   Thu, 7 Oct 2021 14:42:56 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] PCI: visconti: Remove surplus dev_err() when using
 platform_get_irq_byname()
Message-ID: <YV7rUCNUsGjJPAAC@rocinante>
References: <20211007122848.3366-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211007122848.3366-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

[...]
> Changes in v2:
>   Remove unused "dev" variable following removal of the dev_err() as
>   reported by Intel's CI bot.

Apologies for causing you more work.  Especially, since you already applied
previous version to your "pci/dwc" branch.

	Krzysztof
