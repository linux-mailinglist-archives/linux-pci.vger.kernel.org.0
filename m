Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7039E35840E
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 15:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhDHNCq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 09:02:46 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:36708 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhDHNCp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 09:02:45 -0400
Received: by mail-lf1-f49.google.com with SMTP id n138so3901904lfa.3
        for <linux-pci@vger.kernel.org>; Thu, 08 Apr 2021 06:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XLVBvTbjdQrDOuYaVaYl1hv7fUDquzNqGo1d7MLeoZM=;
        b=DvjtNWhhCrvaR+5pziihoKZ+IAqw2GyBORMRJH9UCFteFx6pqY3q8/7x+kuzYmu7oX
         lPOzkHcxw5xYK9EjkL2K6QMjDjaZqNBtF6aqEAXcq0n+BFiFn9XsznamUePBQLpsgHT0
         lFT/ZO4OZ3ZROr4m08DgWYuWPknCJKEdZoXaUTojjFBQeEwOJURh4UEkAzmklzu62eFY
         fv0Sck/vbd0NCvWSsoegcDgkPJQpX75FPqJ9J647pUwb+QWk7O/WDmzHbhYNZMwT0yk8
         c2k3Et25rUx4Aod+a046Xu8WJT6VLDDnMmMd534cZGwYv+IS/Be6hhcVTCpXMCKMyy99
         n1ig==
X-Gm-Message-State: AOAM530cv88Sq0K4ysHWJOxiZvFNKCU7pZkObf2pQqcxZ7Op36TK2lGb
        a5Ps33SQj1zjwnCXb6r3UXw=
X-Google-Smtp-Source: ABdhPJzGbw9hPbAnJkK4TzPp6rg/suo8ogrBls6XiU6/OI0GVDdH2Wyow9GlcKQcNNhch/Mq/FH/+w==
X-Received: by 2002:ac2:4e85:: with SMTP id o5mr6568639lfr.350.1617886952166;
        Thu, 08 Apr 2021 06:02:32 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id q8sm2823187lfc.223.2021.04.08.06.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 06:02:29 -0700 (PDT)
Date:   Thu, 8 Apr 2021 15:02:28 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     yangerkun <yangerkun@huawei.com>
Cc:     toan@os.amperecomputing.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        yukuai3@huawei.com
Subject: Re: [PATCH] PCI: xgene-msi: Remove redundant dev_err call in
 xgene_msi_probe()
Message-ID: <YG7+5M11XXIlWFFU@rocinante>
References: <20210408124745.1108948-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210408124745.1108948-1-yangerkun@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

[...]
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.

Just to add, the devm_ioremap_resource() internally calls
__devm_ioremap_resource() which is where error checking
and handling is actually having place.

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Erkun Yang<yangerkun@huawei.com>

A space is missing just before the e-mail port of the
"Signed-off-by", you might need to correct this.

Otherwise,

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Krzysztof
