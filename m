Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036EB3CCCCA
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jul 2021 05:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbhGSDqP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 18 Jul 2021 23:46:15 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:43954 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbhGSDqP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 18 Jul 2021 23:46:15 -0400
Received: by mail-wr1-f43.google.com with SMTP id a13so20094354wrf.10;
        Sun, 18 Jul 2021 20:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ONoVQ5THxMhl7DPI15ZFDi8zxLFgdWafLvVkEUKpWG8=;
        b=SJMlUJ/O3c/KVMiispzCA4uwK66gpoK0mpIuqQyMiJzcgCdSEA6zSZ8IBVtOIE9lUc
         1X0/G49Q1afRtdwiskNCeym7bB5ijf4ZDf8aERF3UMtUjvWJtIjo3Cyo4uCMSfUHpH14
         UcXezIdFWRqVpzRutjRoz/kY+Je9HteqEJPbO/sEo5FFSfnB4RGnyD0KmfwJutJGv+2o
         NU9/qZKQ3SW7qyfSiZXT075hNeMNKixRCd2AHt/0UfZ/sIi7GgU8penlzDoFUsk24+Yz
         aybNssXBWwaH5F8pYCDBt6adcjqyrCwlV126v9t9Mj8iCFaNIkZuPKhjQYtB1wu2faZZ
         i3YQ==
X-Gm-Message-State: AOAM533xlMVSsm9hCTbD+I/rxM7dTcNphrTPzRfDPN7uKZ9AV3/CwHVP
        fr1plYxfXpIlYeSSdtW0cdI=
X-Google-Smtp-Source: ABdhPJzPLygmQU20lrZ/dL8xPW8ms/6wLuzh0S8mZOtMj2jxCMb2Mt6iyYqHdjrtq/VsSmke6KQCwQ==
X-Received: by 2002:a5d:5552:: with SMTP id g18mr1884088wrw.333.1626666195718;
        Sun, 18 Jul 2021 20:43:15 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id b15sm5575905wru.97.2021.07.18.20.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 20:43:15 -0700 (PDT)
Date:   Mon, 19 Jul 2021 05:43:13 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Use sysfs_emit() in "show" functions
Message-ID: <20210719034313.GA274232@rocinante>
References: <1626662666-15798-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1626662666-15798-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Hayashi-san,

Thank you for sending the patch over!

> Convert sprintf() in sysfs "show" functions to sysfs_emit() in order to
> check for buffer overruns in sysfs outputs.

Nice catch!

A small nitpick: what you are changing here are technically not sysfs
objects since all of these are related to configfs.  Having said that,
configfs shares the same semantics for normal attributes with sysfs, so
a maximum size of PAGE_SIZE applies here too, and thus sysfs_emit()
would work fine.

Thank you for taking care of this!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof
