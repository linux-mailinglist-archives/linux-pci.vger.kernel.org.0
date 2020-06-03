Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B551ED733
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 22:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgFCUGK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 16:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgFCUGK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jun 2020 16:06:10 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9ACC08C5C0;
        Wed,  3 Jun 2020 13:06:09 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y17so1187473plb.8;
        Wed, 03 Jun 2020 13:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8SckYXNhOKP0BM4U/XRIohhWa9dVky1cTtSkQiiBe80=;
        b=uDQClyiMo13aZBAA16EvaegKGeXXTqMzBafeDrgTYxQI1SqW3kHC0vsSMiZbXm0GdQ
         h5VBLUpgad+47wOfHO5NU/ZcQyktlo0Pfxi5/RI9d1zY4gWJcfzroLtWc7XaM1Wkk2QR
         ZWOBcSUJXdXfjZj4y2oaEyuXZG+OBW6nxOSzq0G+yIvrTdfp6Wqiz7mcI+XQ93Uxi67y
         rJbOLBFoeRhJi0z48N1D2/QAtfi/tw67xItYWFy7zaBupRd1JBcsai0jeeWsQ2L9Bv1Q
         9zkJ07cvf3dSf+uwSM5uKtM+rUCQUuByVB9gFrQEcbO0TTyKDjNjTpAwnurBK6jxABXA
         WAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8SckYXNhOKP0BM4U/XRIohhWa9dVky1cTtSkQiiBe80=;
        b=Z9iOq6Kw1plhbsgr5Sq/E95BGN1k6eES9pzVhZkjQFpHSFyV6JPXvY39876w0hXHIP
         LtU28u+ZqU1zflwIU5xtRNHMEhXMerMlaeRFDBpIFdVQQZzwcLxglYpX9yYS6Fk5TAj7
         gwd2FmO+uVK365VXIT7kByo5KrGgemN/WgoO4r3f5amj/0u0BHTRR+Egw3QIlspewmru
         0hriYblTeFEI9NlXs1fCgjDnFwP5lDNl4L+cpzl9z8UnTrMSJz6ueaJeVD64gTmBtD8G
         hFNuYuwFXxtdM+S9ZVrHci9RDk3i+z2dZVayM0EIUHSjqtYJRQxgjsQ7+g+Z04oTB4er
         Hl2g==
X-Gm-Message-State: AOAM532b84SOk91kvIjury3FGFhiKdfZ9m2lhxhYdQqlpkSfLg8meBqt
        211vghbxlLfD2U3QuIzM3WY9BVhf
X-Google-Smtp-Source: ABdhPJzBLNcFjE1l215XhZVkV8Fw5Vstqw5QjosgAfX+y7AzQZEZSayzQVNnNm5wirHbT9+qoXndpw==
X-Received: by 2002:a17:902:fe8b:: with SMTP id x11mr1383928plm.179.1591214769048;
        Wed, 03 Jun 2020 13:06:09 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p12sm2620073pfq.69.2020.06.03.13.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 13:06:08 -0700 (PDT)
Subject: Re: [PATCH v3 12/13] PCI: brcmstb: Set bus max burst size by chip
 type
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200603192058.35296-1-james.quinlan@broadcom.com>
 <20200603192058.35296-13-james.quinlan@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a3ec9783-5859-9729-e79a-e42b3ca02242@gmail.com>
Date:   Wed, 3 Jun 2020 13:06:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200603192058.35296-13-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/3/2020 12:20 PM, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> The proper value of the parameter SCB_MAX_BURST_SIZE varies per chip.  The
> 2711 family requires 128B whereas other devices can employ 512.  The
> assignment is complicated by the fact that the values for this two-bit
> field have different meanings;
> 
>   Value   Type_Generic    Type_7278

It looks like Type_Generic and Type_7278 should be swapped in this
description. Other than that:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> 
>      00       Reserved         128B
>      01           128B         256B
>      10           256B         512B
>      11           512B     Reserved
-- 
Florian
