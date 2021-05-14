Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA62380A07
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 14:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhENNAq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 09:00:46 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:51893 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhENNAp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 May 2021 09:00:45 -0400
Received: by mail-wm1-f44.google.com with SMTP id u133so4723849wmg.1;
        Fri, 14 May 2021 05:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rju+o9Aajm1ncJmVfe9LBvPra3PbTVnQ4yeZB3yC1zA=;
        b=DYGLrI8b5P5wVBNqJvKlPVp0n5IcxM433RLLXOXIzXzhZJecUKfUZPyyxzgwcXojK5
         BfzjmfjZdtD2XBIk551Vs42NZpPybt3pDAAUm8DQtA9Ob/HWksqpFWsoH9ApL89HClsM
         JTDjJRzB1msfJYzZJ3OCQtEqvnVPa8IDVvW28/CherCmK/Md0YpZkv0wCpNKLDEfJzTD
         T60qYvh40rTv+7Ko8xuXe7fmaZXU4x2UNrbsRqcsyHqkxHI00cR0x1dOylBf573Ds+hj
         8Tijer14qz+fjjWb+rPPqWsi+RNNbVLxbzEpPkSGcf2lFpARzuf/brjWAdgHEJQDboPC
         /7rg==
X-Gm-Message-State: AOAM5339NEsLQP2VaUSnkMs+R4m+yirBwDSXKVBY1YTk4osghJAcbnP8
        /OgCJb/rrDv+gwsk8bAnJrGiyuCxS42UZoj0
X-Google-Smtp-Source: ABdhPJzQ9SpSJ+e+wCnztJ9hXrrcphBLuAxQKG15b7jG3dXPidwCpCRShgDRjfv4MqOYIjl3MX4U/Q==
X-Received: by 2002:a1c:2985:: with SMTP id p127mr50450896wmp.165.1620997172732;
        Fri, 14 May 2021 05:59:32 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id o129sm11877532wmo.22.2021.05.14.05.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:59:32 -0700 (PDT)
Date:   Fri, 14 May 2021 14:59:31 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     ryder.lee@mediatek.com, jianjun.wang@mediatek.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        matthias.bgg@gmail.com, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] PCI: mediatek-gen3: Add missing MODULE_DEVICE_TABLE
Message-ID: <20210514125931.GC9537@rocinante.localdomain>
References: <1620717091-108691-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1620717091-108691-1-git-send-email-zou_wei@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Zou,

> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
[...]

Thank you!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Krzysztof
