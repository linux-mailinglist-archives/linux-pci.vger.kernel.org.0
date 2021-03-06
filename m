Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAB432FE16
	for <lists+linux-pci@lfdr.de>; Sun,  7 Mar 2021 01:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhCFX7i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Mar 2021 18:59:38 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:43892 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhCFX72 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Mar 2021 18:59:28 -0500
Received: by mail-ed1-f48.google.com with SMTP id bd6so8930220edb.10;
        Sat, 06 Mar 2021 15:59:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RkKHuuou1fbGpv6ZIX+yWrf0LwYVGw6dLWgr4M+rjOs=;
        b=fqcvxAJTrQxBEbmFuzUiMRoHf7PMbOZuirBq6tqGl+9ue3VkAInI2JsUh6DmQqVWV6
         tEixwNB70DdA+KzrxOPu9rPF1ZIivP1zTVyLMZLNRozbZ5rrmXPzoTIw0YL66sGP3PkW
         9q06bP9pzbeOONNZiBFo8RMdqBQVQ5RzfA2O/iwBhO5yVRt1C41pvr+ujh9HA1z+tp/y
         MfPQRXUShVnIssh8P9ndb/OR076tPCmgdldV2Q/+Fq7NjNRBDTICH6JpfZevRmgcoqN/
         j2BuVnGkbym0qhvgs27VS5rIn+HELw1Y8DgWfDRx7vUGTTn7EIut2vhDH+BL4c8VctOv
         Ku+g==
X-Gm-Message-State: AOAM530sNewxeVvANZHWnSqF3iWMeYORG4+Wy6aDKO5vhwL0Ytniy5e3
        z8VxPWA8ENOBO0SCghKV66o=
X-Google-Smtp-Source: ABdhPJzk6nL/1JWmO3TqFeAiFFiv4yy/xlP13ujtxH1Rb7ZCSZp9sQDmIPnd5znlqdHb62miJ/hq5Q==
X-Received: by 2002:aa7:ce8a:: with SMTP id y10mr15884345edv.66.1615075167183;
        Sat, 06 Mar 2021 15:59:27 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id r5sm4350727eds.49.2021.03.06.15.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 15:59:26 -0800 (PST)
Date:   Sun, 7 Mar 2021 00:59:25 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Sandor Bodo-Merle <sbodomerle@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: iproc: Fix return value of
 iproc_msi_irq_domain_alloc()
Message-ID: <YEQXXXvgVjogSROE@rocinante>
References: <20210303142202.25780-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210303142202.25780-1-pali@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Pali,

> IRQ domain alloc function should return zero on success. Non-zero value
> indicates failure.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Fixes: fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
[...]

Nice catch!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Krzysztof
