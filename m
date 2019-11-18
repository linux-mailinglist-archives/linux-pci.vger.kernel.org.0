Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A44D110094C
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2019 17:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfKRQfP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 11:35:15 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45785 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfKRQfN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Nov 2019 11:35:13 -0500
Received: by mail-pl1-f195.google.com with SMTP id w7so10067940plz.12
        for <linux-pci@vger.kernel.org>; Mon, 18 Nov 2019 08:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=0i62/Z6slWcYNvLCi/1NRq8OSXeaQ9afoBQGBDAQpB4=;
        b=QK+SXU6LH+2o7j9hjFyDYG1WuCYSj7pZbm9qyrJmWAcMMvRtJnV05lu0Cb1sTLlNqf
         1TkeLb22j8nSIopHwhuavGeZExy073Q0cIbnvPtOCqAcrG/Am0hlZcePuCWuEo5/K/Fl
         fC/jvrJXqPTL+M+w0oYh396piWj6R8vcoMfsFCiJUZD7txJjsi7dluwpbeptj/qHT3GN
         KayshveBJARbqU+RZEIqHegHHAm5vmcikUpa2sbwdOjOOLJ2RI30LC+IL0id/d1hqHzm
         cutu1N+eUHTTPSQ/AUIlrejPXs47yx4Unim2DuqoWNBHtamMs6YJ8fg5UFItpr4lVhbj
         15fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=0i62/Z6slWcYNvLCi/1NRq8OSXeaQ9afoBQGBDAQpB4=;
        b=G/HsNm0Lxij76KJTGwMiq8TRrnU0g0ANmh+vF5unCxforLkNU+x0s9MZkmWcaYN5bS
         iS5pULnwyQaifoRXz06DNuk+PnTDMCJRcJd3xI3xU7oXs4YAOyZ1AoDcDjORMvx/xGOr
         p3K76pUaEUyJYgB9v4p+I3DlPR4j/XvTVKLorxcXAXDJ5+XusVfXDShQ4SdfbPk1FMSW
         p6O6i1b0yWCev0fQWMhlfgGryrtLYlgfhVoM4aslwN73MeRlFxIAAr8lBtB0uzdJO/0y
         rJ/CzDw6G9iZ2OquX3jq7jz5x5oIgO+ck9OIQ6pcuNUeHSEIgyjl5ocmGNbwWRAKvtO9
         5nHg==
X-Gm-Message-State: APjAAAWEGuAIPNdzEjJ9+GY5AeYQRGMTBIz5vPG1djv4lJehc16liTMz
        cXRObVXPuu7YBvNyKhK7FnUsHqDw
X-Google-Smtp-Source: APXvYqzaSQ6u9pSlhPl8xKsCKW041CGIcNafMua+2M/xSn8qR1xflXgPPrLdUqsRXzl9r503iU1m1g==
X-Received: by 2002:a17:902:a417:: with SMTP id p23mr3927099plq.97.1574094912122;
        Mon, 18 Nov 2019 08:35:12 -0800 (PST)
Received: from SL2P216MB0105.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:22::5])
        by smtp.gmail.com with ESMTPSA id g20sm20217417pgk.46.2019.11.18.08.35.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 08:35:10 -0800 (PST)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     zhengbin <zhengbin13@huawei.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kgene@kernel.org" <kgene@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Han Jingoo <jingoohan1@gmail.com>
Subject: Re: [PATCH] PCI: exynos: Use PTR_ERR_OR_ZERO() to simplify code
Thread-Topic: [PATCH] PCI: exynos: Use PTR_ERR_OR_ZERO() to simplify code
Thread-Index: ATNoLWc1DEO/Zkzog7LMmcep5qWiqMRsAXR8
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Mon, 18 Nov 2019 16:35:06 +0000
Message-ID: <SL2P216MB01057BE74411EC7BE168E193AA4D0@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
References: <1574076480-50196-1-git-send-email-zhengbin13@huawei.com>
In-Reply-To: <1574076480-50196-1-git-send-email-zhengbin13@huawei.com>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/18/19, 6:20 AM, zhengbin wrote:
>
> Fixes coccicheck warning:
>
> drivers/pci/controller/dwc/pci-exynos.c:95:1-3: WARNING: PTR_ERR_OR_ZERO =
can be used
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>

Please write your full name correctly (First name + Second name).=20
If 'zhengbin' is just your first name, you have to add your second name.
Or, if  'zhengbin' is already your full name, please separate it with capit=
alized characters and spaces,
for example, 'Zheng Bin'.

> ---
>  drivers/pci/controller/dwc/pci-exynos.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>

[.....]
