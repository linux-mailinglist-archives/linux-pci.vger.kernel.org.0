Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E011360A8B
	for <lists+linux-pci@lfdr.de>; Thu, 15 Apr 2021 15:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbhDONeN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Apr 2021 09:34:13 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:35643 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhDONeM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Apr 2021 09:34:12 -0400
Received: by mail-ed1-f44.google.com with SMTP id x4so28112876edd.2;
        Thu, 15 Apr 2021 06:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SSHZ8ASZ8DRw8jREYb3zRX+5WakuAAWffZqSH6D5XcA=;
        b=A8/iAYndnkxKqza23pBGyjNSU9MC+7G9GxUkMBR5Gdi/bHxyGUyQZPCVE0Z/Wfv/y9
         qU0X2ZpYYnIs4nSvZU/oxQaLrQPtvLE41B60F8sAKxlvHLEpeG6qfjkhGVOhK95mGAOM
         A8HmuhISd6FyESWk5RQ6e9NBVOm2aB/S8JpRuwwQjmO3rYdXc30UXIJjlbFgnKK25Ffn
         w1q37RTMOHpcVc5sNT/60etb+ro4ZOTT3pE3J0x+b9cwGJMVA7Zb8iKHh467vocQMyLa
         qOXw/L+zmZBcdUe2oJlbvAFlam77UAxh8MTZf/crhLUDw8Q+rauzmKf2x3S25jmhwQ7T
         nXHQ==
X-Gm-Message-State: AOAM53148A+CJXT87cdcnrU7n6WF0gsi8ilwI1LaP1ZjCqVU8jqDF4Du
        xBz//LWTpfKpcUP0DLPneqSrfR3K0f4NgYZW
X-Google-Smtp-Source: ABdhPJxqL7Iawd1PNIq+XHHrlzkiRZQObpq2+dcThWSZ1dRpal8yhxYAxpV+6SHjulvoSJng6lEn5A==
X-Received: by 2002:a05:6402:26c9:: with SMTP id x9mr4198773edd.322.1618493627588;
        Thu, 15 Apr 2021 06:33:47 -0700 (PDT)
Received: from client-192-168-1-100.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id dj8sm2532397edb.86.2021.04.15.06.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 06:33:46 -0700 (PDT)
Date:   Thu, 15 Apr 2021 15:33:45 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: shpchp: remove unused function
Message-ID: <YHhAuTowc1I57mAJ@client-192-168-1-100.lan>
References: <1618475422-96531-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1618475422-96531-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

> Fix the following clang warning:
> 
> drivers/pci/hotplug/shpchp_hpc.c:177:20: warning: unused function
> 'shpc_writeb' [-Wunused-function].
[...]

Nice catch!  Thank you.

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

By the way, next time capitalise the subject line.

Krzysztof
