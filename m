Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CEC360A89
	for <lists+linux-pci@lfdr.de>; Thu, 15 Apr 2021 15:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhDONdN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Apr 2021 09:33:13 -0400
Received: from mail-ej1-f43.google.com ([209.85.218.43]:33524 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhDONdN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Apr 2021 09:33:13 -0400
Received: by mail-ej1-f43.google.com with SMTP id g5so30187808ejx.0;
        Thu, 15 Apr 2021 06:32:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=crKPaAnmJDeEmrkUT4Tv6SoJrL3Vc/tvT6Rj7PQriYM=;
        b=NrHk/fY76Y2QPzl3VFilAavbDR4ip59NZ0yGVQXRBJZ5nFumrshXP8f/Jn9B2pZq2B
         VMl6l9HBjXkWPgrcD5Qq1pFbIfXpLCn/4dfzRWesiPDUR7s8TGKV87KVo7TGrov0CI9w
         UGnv6G8XZWsVlMtxDm3qWT6lhbAsyGR6WtJpdQ9AvnHMJu4tIRepqPCyKHV6eUHhCVS9
         V2CTYVa99WdFl+4M2FNjWxAR4b6Q+x/gEU7lBI3v3kECwHCVhEyEPfIR6Freq31X3epT
         cCTYViKKXO5DxvckC1G8qZNpujWCqol+SfhsHI7/zGEmI8r76I5waO4J/aQnPoIWijMD
         CZEQ==
X-Gm-Message-State: AOAM530Z8cRZzYwzMC/03w+vq3a0inwpMCrX3kUHDb6lLdM7xf46FO/r
        LE1pFGpEp58w01oXMoFNc/8=
X-Google-Smtp-Source: ABdhPJwM+p1u/d/NXhwhB9xG9flDnu7J68GeWEtvyiyBMq1h/IyzxdEo/x0yF9m7/y2gro1hh5B8uQ==
X-Received: by 2002:a17:906:85c1:: with SMTP id i1mr3504347ejy.216.1618493569174;
        Thu, 15 Apr 2021 06:32:49 -0700 (PDT)
Received: from client-192-168-1-100.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id d10sm1924472ejw.125.2021.04.15.06.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 06:32:48 -0700 (PDT)
Date:   Thu, 15 Apr 2021 15:32:46 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: remove unused function
Message-ID: <YHhAfkJC8g3U9Wjg@client-192-168-1-100.lan>
References: <1618475577-99198-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1618475577-99198-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

> Fix the following clang warning:
> 
> drivers/pci/controller/dwc/pcie-intel-gw.c:84:19: warning: unused
> function 'pcie_app_rd' [-Wunused-function].
[...]

Nice catch!  Thank you.

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

By the way, next time capitalise the subject line.

Krzysztof
