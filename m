Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF2E1ED770
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 22:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgFCUdI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 16:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFCUdG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jun 2020 16:33:06 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F49C08C5C0;
        Wed,  3 Jun 2020 13:33:04 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id d6so100430pjs.3;
        Wed, 03 Jun 2020 13:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tKK54s37lQCe/iastVr/8YgFF4Qz2iFi8Ru/giratfc=;
        b=cKQIjUAAnyVFabLs4fElfG3Cv10Qjq7ZEkJ+YkgCFBYDAf/VKYDrPtEJGWcTwbpzf3
         k1WrTOyUZU7Z+sfuK0xWmI8Zt6xnLEFwKGl/FiSLYPKkzvJUsWXZibRZ3JjnZeN10k6m
         ofA1mwaq/6iB2Jo96JCPlDBbCSK3Qj7xdBf5/MhmUpPn2cVycDd0y++a21AaFr+tiCc/
         fN4MVjiRnicjR18xshg8o1v0Rj5Ye1OU/JivxEHA5GlPyUZc4JkMjuU4xgHuxcyJAWi5
         0WVDVd8MBw57vbfs7ZstpWTMWnCjj+BHJz9pwjynbn+eL9sNGezQSjskxN8lK71vzsBn
         iz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tKK54s37lQCe/iastVr/8YgFF4Qz2iFi8Ru/giratfc=;
        b=Rz6HRar5Hd6RWv/4z35x0SbS5XHajA5PtGVKRmuDbEqCwYG5OdQ0Rgv8X/rO0oAace
         wubc75qE2BEiLnMKHYsc94D8Ns/25OVfFBenyKgNWzM65CKUFcYiFWYdGjKYPFys3XIN
         vbtsob1S57LFQxQK+tjVUCFaXbfFE+IQjQhWhHddiQeVu5sxPJIKAFW6usO8WJFDNXK1
         pDncmptbMh9CWp00jOsKZXaWCBKXZ006vqf6qRFTvnFPOQDWDy5gS0SCIBLkDnpfY1Sv
         yeCYrxV13Z+1j1Qy6haBG9jtQE1KFP+nrUonp4NpiMoMvYjJvdvUa3K/Mj0Dvf2GCR7J
         LL1g==
X-Gm-Message-State: AOAM533vR3Yxpiz8UUKPKjxKrEAqe75Yj62KYX4964hvDq3ng+hmooJP
        ke5OZ4ZoZAbK4KpC9FulY+aYZPCL
X-Google-Smtp-Source: ABdhPJyLkFbq2hs5iJJsfKh7chIJrewBYh8p9pOzBn1RZaK00q+ODcLjjar1be1cKhF/sxx4V04S/Q==
X-Received: by 2002:a17:902:9a43:: with SMTP id x3mr1496123plv.190.1591216383928;
        Wed, 03 Jun 2020 13:33:03 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 85sm2597077pfz.145.2020.06.03.13.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 13:33:03 -0700 (PDT)
Subject: Re: [PATCH v3 10/13] PCI: brcmstb: Set internal memory viewport sizes
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200603192058.35296-1-james.quinlan@broadcom.com>
 <20200603192058.35296-11-james.quinlan@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <40eda019-21a2-32ae-d0d7-6dc77f9d91f7@gmail.com>
Date:   Wed, 3 Jun 2020 13:33:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200603192058.35296-11-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/3/2020 12:20 PM, Jim Quinlan wrote:
> BrcmSTB PCIe controllers are intimately connected to the memory
> controller(s) on the SOC.  There is a "viewport" for each memory controller
> that allows inbound accesses to CPU memory.  Each viewport's size must be
> set to a power of two, and that size must be equal to or larger than the
> amount of memory each controller supports.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
