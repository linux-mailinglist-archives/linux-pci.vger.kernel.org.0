Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596D32784F9
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 12:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbgIYKW2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 06:22:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45767 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727132AbgIYKW1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Sep 2020 06:22:27 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601029346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FIrDkYdRBbVhi3DlgkbBKaCC5KZCzUdxrIcyXtujywg=;
        b=WCg5RZZ+4EPphcYF5Zc8L25rio9ikwsJzIZZks4MQjeQcpSauuq7Omw60DRxKZ4y8JbQg/
        ZPk+ijHpE2wP8wsBBWbAPk/vgw4pX6qBQkyCWqCKUDZYprJKIlNoVHgqshGecAeVCqpKQJ
        oyUQQ8wNHP15ji8nhRpjnsLAaLW5Www=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-W58zwvivOE64SJCa44Cpsw-1; Fri, 25 Sep 2020 06:22:25 -0400
X-MC-Unique: W58zwvivOE64SJCa44Cpsw-1
Received: by mail-wm1-f69.google.com with SMTP id t10so656903wmi.9
        for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2020 03:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FIrDkYdRBbVhi3DlgkbBKaCC5KZCzUdxrIcyXtujywg=;
        b=tS58exF1TmIpy2pXPOM8AJnlAFi4AUavCk6wXnXt88SynE9DCIGXJ7KaAcwLX15vCV
         AG9ihWrpfYLUivDbzLKb2rSan48WOcm2Qty+L1NY/XswOqgUfmVV3jG8XOAUoEdM+8/7
         vvy5uLzCUjFn/b0iWu0ru8X08Rz/UWxRmtmPwxWcw4TXzIIjq0Ni9qp1cjoZIbAq63Rq
         j+wUyIpDAnYFCEn0E0cPjVJeVz3zxYbfQek2rpyZ5oooBD0i/AKHogS9FfsWunRqGu4a
         itepjiATDbQFyvA0/6oO332A2BbxiV3chQ3JwsDcyMkc27U1hWTt1Ko5xy9nnL+J4v5X
         JUrQ==
X-Gm-Message-State: AOAM5323rpvVT8eHtozrCI53JJc9K/guAtQ4ne6gDyTdPQwcRIlCWiRN
        cmeloB6qBKuVyyTzl/4WBesIWmheMNIlEfI/ejsY83BS+gXnhJ9i3YPvgYNwB44V4sADMcyMWy5
        wVLgDR6zpI0/Ej9a7JE5R
X-Received: by 2002:a1c:9a57:: with SMTP id c84mr2311712wme.136.1601029344134;
        Fri, 25 Sep 2020 03:22:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/J1hHVBw+R8oMJc/+peFSRFq7cwzBLkEQMc+s1atOIZTdN1uBg5mFmmxkcJWGpJb6G3bMjg==
X-Received: by 2002:a1c:9a57:: with SMTP id c84mr2311686wme.136.1601029343977;
        Fri, 25 Sep 2020 03:22:23 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
        by smtp.gmail.com with ESMTPSA id c14sm2297007wrv.12.2020.09.25.03.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 03:22:23 -0700 (PDT)
Date:   Fri, 25 Sep 2020 06:22:20 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Auger Eric <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20200925062122-mutt-send-email-mst@kernel.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
 <20200924045958-mutt-send-email-mst@kernel.org>
 <20200924092129.GH27174@8bytes.org>
 <20200924053159-mutt-send-email-mst@kernel.org>
 <20200924100255.GM27174@8bytes.org>
 <20200924083918-mutt-send-email-mst@kernel.org>
 <20200924125046.GR27174@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924125046.GR27174@8bytes.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 24, 2020 at 02:50:46PM +0200, Joerg Roedel wrote:
> On Thu, Sep 24, 2020 at 08:41:21AM -0400, Michael S. Tsirkin wrote:
> > But this has nothing to do with Linux.  There is also no guarantee that
> > the two committees will decide to use exactly the same format. Once one
> > of them sets the format in stone, we can add support for that format to
> > linux. If another one is playing nice and uses the same format, we can
> > use the same parsers. If it doesn't linux will have to follow suit.
> 
> Or Linux decides to support only one of the formats, which would then be
> ACPI.
> 
> Regards,
> 
> 	Joerg

It's really up to hypervisors not guests, linux as a guest can for sure
refuse to work somewhere, but that's normally not very attractive.

-- 
MST

