Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA67E40F97D
	for <lists+linux-pci@lfdr.de>; Fri, 17 Sep 2021 15:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240570AbhIQNr0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Sep 2021 09:47:26 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:35616 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbhIQNr0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Sep 2021 09:47:26 -0400
Received: by mail-wm1-f50.google.com with SMTP id z184-20020a1c7ec1000000b003065f0bc631so10053440wmc.0;
        Fri, 17 Sep 2021 06:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jtV4/xfInTZf41NWH1So01AC4QPok5lP65WRPPuIhMw=;
        b=0XI6HZ4771LNlFMfB9+65T+kHzlpoqs1bV0ZTIrXAjSSHAcL0okY/XVGosxUYGTUeP
         h3G8DefVf3/Lk971yVyCu0SSUn4i4lu8Y2/ZNj9id+WDa4BYp4xrtZwM/euuZhjbmTUN
         /1x8fVMWuMCB29EMjXFqhazclC8CDE9Qbhq9kkwDUFSHEOESF8Zv0oXGDwym8v/7ksbV
         soUuYT9HnCZMhY99d5oUTMvzz8w5sFnUbcguc4SBu1tqchy/C7r5udaXrZ1rGfdcWhaA
         +XsVSavf1bfm/JELF/RZGNDiafgJ6slwE4O50eLXURPcRVHD4MA+OZPmUDlcjxRuvBcL
         Af6g==
X-Gm-Message-State: AOAM532YvEdMuTOiNTd2eUGDIHq+H9C5VIhfhBLUQjEeAVwe3LPkE10h
        V5fsSE1RizJm5n7850vEluQ=
X-Google-Smtp-Source: ABdhPJysNpzd0PvoIrDOBYNm30BKjCMBzyGPw0tVpVUIYKahLqzoPZ8Lk3lHWdX8wOjZ3Mrydn5X6g==
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr10652113wmk.51.1631886363285;
        Fri, 17 Sep 2021 06:46:03 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id e2sm6878747wra.40.2021.09.17.06.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 06:46:02 -0700 (PDT)
Date:   Fri, 17 Sep 2021 15:46:01 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     jonathan.derrick@intel.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com, helgaas@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PCI: vmd: Assign a number to each VMD controller
Message-ID: <20210917134601.GA1518947@rocinante>
References: <1631884404-24141-1-git-send-email-brookxu.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1631884404-24141-1-git-send-email-brookxu.cn@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi!

Very nice!

> If the system has multiple VMD controllers, the driver does not assign
> a number to each controller, so when analyzing the interrupt through
> /proc/interrupts, the names of all controllers are the same, which is
> not very convenient for problem analysis. Here, try to assign a number
> to each VMD controller.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof
