Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68DC3670BB
	for <lists+linux-pci@lfdr.de>; Wed, 21 Apr 2021 18:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244483AbhDUQ5s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Apr 2021 12:57:48 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49]:46067 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244466AbhDUQ5s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Apr 2021 12:57:48 -0400
Received: by mail-ej1-f49.google.com with SMTP id sd23so55889389ejb.12;
        Wed, 21 Apr 2021 09:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VprZ1v1eR/PVW56oSc4CCRlyP5XCo5aWjnBcMg7fMKk=;
        b=AjJ2N08JOg1KwxBb+6cbJ176jOqGK73SApBWsVqqLg2UIpS7q3fD6DkV8L7JNBvLhy
         XZxlONUxMK61LK+PENM2sgXVNTeJ3ChhXVeTduy0mNHo1ZXWSuTwtD7b3ExVkjgPsQfh
         Rc7FeitMVdM1O52yb1nH6wbimmrm+FTHpg23pTgDBB0eFT/7GgTEukl5N9tjP+8epeao
         z5yFzyR+hfu6vfhXaB5d9tpHSI6a//icCVoSHv2UtuEcco4qc7LC6Pe4+4REwJU1G8/n
         Zpr4eaXfSGsrS/YC7BaVXMPqxCRh7ADokWpbXfLYz2X+fjsudRH87pvJAyoGm1ALGTH8
         0wcQ==
X-Gm-Message-State: AOAM532qN1KeAwOXhQjqnDCp3wMrx07yBO0oZ5x5mPR1gTL16KvULf3b
        Clz9ikGzlsO5x1vJq1cix2c=
X-Google-Smtp-Source: ABdhPJzG6MX3jb/UygsnaDSyOf4HbRocn7udptX3A8B2u/9FGdNyegf6EPXMGSurwPhGKuef5d/sAw==
X-Received: by 2002:a17:906:134d:: with SMTP id x13mr34102150ejb.61.1619024232717;
        Wed, 21 Apr 2021 09:57:12 -0700 (PDT)
Received: from client-192-168-1-100.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id i2sm48897ejv.99.2021.04.21.09.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 09:57:12 -0700 (PDT)
Date:   Wed, 21 Apr 2021 18:57:11 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Prike Liang <Prike.Liang@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajat Jain <rajatja@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bixuan Cui <cuibixuan@huawei.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: fix unused variable warning
Message-ID: <YIBZZ7EvA1CUk0vb@client-192-168-1-100.lan>
References: <20210421140436.3882411-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210421140436.3882411-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Bixuan]

Hi Arnd,

> The function was introduced with a variable that is never referenced:
> 
> drivers/pci/quirks.c: In function 'quirk_amd_nvme_fixup':
> drivers/pci/quirks.c:312:25: warning: unused variable 'rdev' [-Wunused-variable]
> 
> Fixes: 9597624ef606 ("nvme: put some AMD PCIE downstream NVME device to simple suspend/resume path")
[...]

A simialr patch was sent recently, as per:

  https://lore.kernel.org/linux-pci/20210417114258.23640-1-cuibixuan@huawei.com/

Other than that,

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Krzysztof
