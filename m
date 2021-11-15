Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCED451718
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 23:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349651AbhKOWFI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 17:05:08 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:40865 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347660AbhKOWCo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 17:02:44 -0500
Received: by mail-pf1-f180.google.com with SMTP id z6so16228202pfe.7;
        Mon, 15 Nov 2021 13:59:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UFAP1oAnn6MbmB29dQFqbnJScGDdm0DPgaEWvP1J3gI=;
        b=s4/3y5GvzP6CWc9qRKnPcg/EidAPU4FrmzhCNxVXq0uCTS7nKk0aHySrrJ4FdW1tkr
         0wTX5oMniVlxvHGkOUGcI1+gi0c2K18/A8RIabrpSVvtNF+e5SW9fL8Y/rnmHgU2cY7o
         FTL1vwdNz815M15p2LeucfBoduHcBCoJljU4treGsDMta6dP+w6wXWrsmbv0IZYwn/mv
         3yCHr1ZFFAhZdaXNvqUZYWhj3KDaK+/VHdf+942VzZI+LqS2gNB0PI033w5aVZFJFHwH
         10ML1JaExHndJ3SppK0tTRTC7lbb/Vw8oRh44I1qHjfszpaIL+Ox2XelIu1EP7vJ1yGF
         mp7w==
X-Gm-Message-State: AOAM531Dy4GZ6QE5BW3aYS2MhWe0LHf4oXhZkBZcmFoOQbBHvie7/jn5
        wqD3wo2UilRVlQllLHG9xgbqAohiivJqGRsM
X-Google-Smtp-Source: ABdhPJyrq/k7SU2twBKgDghx/9so0FeU56V5XYnp9oXw45iCn7Cn5LgJKV1NXVlWubHAkaSh/pXgAQ==
X-Received: by 2002:a65:670d:: with SMTP id u13mr1440890pgf.251.1637013587668;
        Mon, 15 Nov 2021 13:59:47 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id na13sm288559pjb.11.2021.11.15.13.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 13:59:47 -0800 (PST)
Date:   Mon, 15 Nov 2021 22:59:34 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v4] PCI: rcar: Check if device is runtime suspended
 instead of __clk_is_enabled()
Message-ID: <YZLYRjZxTclKX9mJ@rocinante>
References: <20211115204641.12941-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211115204641.12941-1-marek.vasut@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+CC Adding Sasha for visibility]

Hi Marek,

Thank you for taking care about this.  I am adding Sasha since this is
something we should most likely port to stable and long-term kernels,
especially since this isn't a new driver.

[...]
> - * Static copy of bus clock pointer, so we can check whether the clock
> - * is enabled or not.
> + * Static copy of pcie device pointer, so we can check whether the
> + * device is runtime suspended or not.

A small nitpick: it would be "PCIe" in the above comment.  However,
probably not worth sending another version just for this.

	Krzysztof
