Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BDA3F2542
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 05:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237998AbhHTD0F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Aug 2021 23:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbhHTD0E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Aug 2021 23:26:04 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C257FC061756
        for <linux-pci@vger.kernel.org>; Thu, 19 Aug 2021 20:25:27 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id b9so799829plx.2
        for <linux-pci@vger.kernel.org>; Thu, 19 Aug 2021 20:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tb+3c4sIXia8Tj7TXbcGSfKzAoHqBRtrMhGgnoxQz9c=;
        b=UlcCDs1covM/o5EVQkDUvKUq4BYzlVfj1O2NkuVwbGewbHLaYA1k7cDj99iuCJ4Hdr
         xqc/9D4LE2CQyZxqjlgvQYwYXY7f7d9Ln2txosp4PvwCHCGsanahVQNsdHVVTDpqy4Ph
         4gcyPp4AY4mgBwL4Naw3GS/5eoZXW4DEBE9Y7AilAJWtI+j4IvSR4gztQ4iuCR+l7Ya0
         wnJWFKfHLajnhyHepNgovu2GaEkbJs+34/1u9qZtpurbnl5UA47SCUUfskBIjfMaiGlC
         WlgX8qJGVA9wnFreDDWgmMokCHhor0vJxt511fs0jyPIhuo5R3qyJvUuDbf5x1+FLrpC
         sDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tb+3c4sIXia8Tj7TXbcGSfKzAoHqBRtrMhGgnoxQz9c=;
        b=R6YjHjAW6UdW0c7ZlLdZQJnDdXmWkm6UQhrICjd0uFcYZ58EUmQAyK5xdZ8bnMknPj
         CDPH36vm+cARNZcTMGDtGZ3SEBpkNxYZo4Spzb60g/AKQp8WQnoyCNEM+c6PQsALoMU5
         6aqckShuKbqWEZval9gBerCc0OAmmRAv+OaYKba5pd0vtaCVWDfIv444p3PL4K4kMafG
         pmW0pqlJC8gBnBl+4z8YiNNYzSAfM+AmjBei1Ilaj3bVe5KdU/oHhUIc2pFSplzvwW5v
         +6YeoJ8N03TVmro/C4qRgHq4WFg57NEfxLez+w9PUtxEEIoGwqiQTo2OaOLyVfQN9gvJ
         34tg==
X-Gm-Message-State: AOAM532XYQcAbZBhKtXiBGmxEpx7zjQe+n2aw4lBhNLV+bss40xe/16j
        ZK+sd19EcbzD0TKW4qu25+7SdQ==
X-Google-Smtp-Source: ABdhPJy5lEitPCHFg1OSUQG2byPt0M4/Vn2i9PLMWC8UpSbU447SdR7DBz6vRKpV6owBYA+uCyeJpQ==
X-Received: by 2002:a17:902:d3c5:b029:12d:32f2:8495 with SMTP id w5-20020a170902d3c5b029012d32f28495mr14949223plb.72.1629429927093;
        Thu, 19 Aug 2021 20:25:27 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:549a:ad5a:e5bd:8c8a])
        by smtp.gmail.com with ESMTPSA id u3sm9211597pjr.2.2021.08.19.20.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 20:25:26 -0700 (PDT)
Date:   Fri, 20 Aug 2021 11:25:23 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Wilczyski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        qizhong.cheng@mediatek.com, Ryan-JH.Yu@mediatek.com
Subject: Re: [PATCH] PCI: mediatek-gen3: Disable DVFSRC voltage request
Message-ID: <YR8go1l0Xnvvqn5E@google.com>
References: <20210819125939.21253-1-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819125939.21253-1-jianjun.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 19, 2021 at 08:59:39PM +0800, Jianjun Wang wrote:
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
