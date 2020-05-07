Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1121C9B4D
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 21:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgEGToy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 15:44:54 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:46631 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgEGTox (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 15:44:53 -0400
Received: by mail-oo1-f67.google.com with SMTP id x16so1612063oop.13;
        Thu, 07 May 2020 12:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0knBIBoZa1fhrLfHhlBCmtkeQd++JrRt2MMqGHWeht4=;
        b=Id+sZt+Q7KtKxF6wBuntet0URgMgjhgyBP9w1OBfSktNIz0ImDgQg07WQqREO4/B9u
         zcPtgStd+1aKP3VOw/8R9g4teNp+vUsgPWtP4Gky/zw9yHaCTQlRYZtGFS/B6d9LLSo7
         fsCI+YSk9pap17tc93wdZC41FB9+KtyhU/t30H6gbfjc0VrYeUWn5uinlN/xUl+1Vozc
         ynYIu+ciDkeAYAVBvo2dHWNSbyrSoyc0UPoRDupvxQUV2DO1hWBQbkAQj+09mvp7Rfim
         RUlmYeDKsgtwvxgO74sUHYMsaAky5UPlevwqW4LIgScSY5ymIa9aRR0AFtK5kYPCHykZ
         90pQ==
X-Gm-Message-State: AGi0PuYb8sp/xbGrxvUblmCao0LoCSr9uowNvrWRd49wE1pGB8q1iXtQ
        K9aG1nZMzTJnuTA8s3NABg==
X-Google-Smtp-Source: APiQypKQ9hchUvLCeIFKV8nt8CxTJKxHp3QhpkCDcIIPl6JnFmMIu3D8onuZ4Ff/MLkNAMvH/ik6eg==
X-Received: by 2002:a4a:a54a:: with SMTP id s10mr13421411oom.73.1588880691546;
        Thu, 07 May 2020 12:44:51 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t186sm1646722oif.13.2020.05.07.12.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 12:44:50 -0700 (PDT)
Received: (nullmailer pid 26367 invoked by uid 1000);
        Thu, 07 May 2020 19:44:49 -0000
Date:   Thu, 7 May 2020 14:44:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Fix reporting GPIO error value
Message-ID: <20200507194449.GA26252@bogus>
References: <20200414102512.27506-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200414102512.27506-1-pali@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 14 Apr 2020 12:25:12 +0200, =?UTF-8?q?Pali=20Roh=C3=A1r?= wrote:
> Error code is stored in rp->reset_gpio and not in err variable.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  drivers/pci/controller/pci-tegra.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
