Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4B2320F7A
	for <lists+linux-pci@lfdr.de>; Mon, 22 Feb 2021 03:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhBVCim (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Feb 2021 21:38:42 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:36612 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhBVCim (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Feb 2021 21:38:42 -0500
Received: by mail-wm1-f53.google.com with SMTP id a207so12994126wmd.1;
        Sun, 21 Feb 2021 18:38:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WQh8VCQevRvNmuRhsDtQ7nIEzMD2gLxTk3f4V+L1aEc=;
        b=TbgLsDqOFoShi2rsDCzPefhfqxiCLUAguPUCcDPDvp6xQ6HPW7k7PuvVSpGTU1+4ZC
         pudpohAWaY5KmRIWUvjkr2yuZTCODOHf0g5/9Jt4KgEfSIkMvPm5bsTTbGFRaSEXDuQb
         WwdliVMe2M2IdxGVTtYBOn9EN0pUggvWadE0HcUW6csV8WJLRAgUcQOPJmliiBshbDGd
         zs9PB+6xmt7r00hOkI4M0aYsb5SzPr0B+quixXy3PZEc6RfjvjFN8/iwNNU5oEdldvZC
         Eh+/qWuwZFssbOUTG0/eIOpSK8n22S9CHvlyhiMv+PFUrZ3yuAmbjjvl1rTzaYlz1XCs
         AwUg==
X-Gm-Message-State: AOAM5335v+sfk0zzpy0qfFTaPFAvI9R1pOeK9UVjxxYPNVHakkII2f3C
        wN04AfKcUv4ob+9AbAJ8nfs=
X-Google-Smtp-Source: ABdhPJyYa0OSAEf9Hv486ErFQ9KxIaLDKDhIt9gQZs03ZhTS6GCiMeEAtagI9mrNDmC8zYJNgQcF6g==
X-Received: by 2002:a1c:7301:: with SMTP id d1mr17923444wmb.33.1613961480554;
        Sun, 21 Feb 2021 18:38:00 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id f2sm26344434wrt.7.2021.02.21.18.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 18:38:00 -0800 (PST)
Date:   Mon, 22 Feb 2021 03:37:59 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Simon Xue <xxm@rock-chips.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v4 1/2] dt-bindings: rockchip: Add DesignWare based PCIe
 controller
Message-ID: <YDMZB94qMkpOx38Q@rocinante>
References: <20210127022406.820975-1-xxm@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210127022406.820975-1-xxm@rock-chips.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Simon,

[...]
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)

The driver is only based on GPL v2.0, should this be the same, or is
there a reason for dual-license?

[...]
> +title: DesignWare based PCIe RC controller on Rockchip SoCs
[...]

What does the "RC" here stands for?  Would it be "Rockchip"?  If so,
then perhaps dropping it would be fine to do, as rest of the title
mentions "Rockchip SoCs"."  What do you think?

Krzysztof
