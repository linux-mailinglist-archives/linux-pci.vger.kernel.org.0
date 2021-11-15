Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586244516FB
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 22:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245676AbhKOV4x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 16:56:53 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:33605 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240642AbhKOVzf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 16:55:35 -0500
Received: by mail-wr1-f51.google.com with SMTP id d24so33521123wra.0;
        Mon, 15 Nov 2021 13:52:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q4hThK6GtsjlHOOGJI35jdUIgOrD1OAb5h6Q7wdYkbo=;
        b=3PhbRvAZBlrAUQdySf4SGgXopnO1o/oSUGDrIxWqct3P6PqaXi+DPaICiIG8IyD8Z9
         IppyMHbup0xhfp5S0yTdQso2xT8icPgBSCWp2l4odrPt2/IzVvEIS8L1lfCoM8MiVGS0
         N/sMlZhm/noclImN9fUkaQoF4u6Ohs7lyzrlRCzKQujtbqn0aW5XBdMScWEe1a8AfU1a
         uNASU4HyZsJmf449m/xsdeIugYnnfBQZZh7vdlJ9aVfmtq2ZA3fssgjJjKHtPVqRaNHh
         c50LrKUVHhay3c75uOfQuYabJargQvhJsx/c5gPVpSRg4j22CftZ0vYw5fFrcB4THZEU
         iUtg==
X-Gm-Message-State: AOAM530S/FMWagm60/g8bOf3C2HEFsHXX9MLEsRy6lOJv9PEelXqNkWy
        OEYEb9ggjy34R0nL3711du8=
X-Google-Smtp-Source: ABdhPJzv/re4V8SK3JuGe8MMrGr8JNmFWJFjReinOnLwVfMsMMVTxs39AnrMkpP5Mqeo+GbasCOeLg==
X-Received: by 2002:a5d:47a9:: with SMTP id 9mr2993644wrb.42.1637013156020;
        Mon, 15 Nov 2021 13:52:36 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id y6sm16477263wrh.18.2021.11.15.13.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 13:52:35 -0800 (PST)
Date:   Mon, 15 Nov 2021 22:52:34 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-mips@vger.kernel.org,
        tsbogend@alpha.franken.de, john@phrozen.org,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, Yanteng Si <siyanteng@loongson.cn>
Subject: Re: [PATCH 4/5] PCI: mt7621: Add missing 'MODULE_LICENSE()'
 definition
Message-ID: <YZLWojulc9La5gvr@rocinante>
References: <20211115070809.15529-1-sergio.paracuellos@gmail.com>
 <20211115070809.15529-5-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211115070809.15529-5-sergio.paracuellos@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

[...]
> ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pcie-mt7621.o
> 
> Fix this by adding 'MODULE_LICENSE()' to the driver.

To add for posterity, should someone stumble upon this in the future.  Lack
of MODULE_LICENSE() used to be a warning, but that has been changed quite
recently in the following commit:

  commit 1d6cd3929360 ("modpost: turn missing MODULE_LICENSE() into error")

	Krzysztof
