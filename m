Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A093670EE
	for <lists+linux-pci@lfdr.de>; Wed, 21 Apr 2021 19:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237934AbhDURJh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Apr 2021 13:09:37 -0400
Received: from mail-ej1-f46.google.com ([209.85.218.46]:46008 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244656AbhDURJW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Apr 2021 13:09:22 -0400
Received: by mail-ej1-f46.google.com with SMTP id sd23so55942250ejb.12
        for <linux-pci@vger.kernel.org>; Wed, 21 Apr 2021 10:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2u0dG2JNcCnry3EwNpOQKAnohFE6c51ipPehUYmSgok=;
        b=AZ3YPiH9vMoMjq/a2PBPvdeSqp2EROcefLJtjt9NL941a5vNaiDl873G+YlAe1jS2C
         2OrMrLIUlvJWsMUf6fEtCplHzNfD7tPhThAX6b0wqFfXOIxv1Jcn/J25ySlDV6WmgFXp
         X3y1TzWTyP/b3D8pHt7Jqn7OusFcF2RgosjLn9W90Maw+RBNFquqrQMRBxIRWncBA6hB
         IZE+BhwXHmCwOvd3XDj92eZvKfDZ8a4Uy8GyrssWo+0OTqx1axiCXtYbS2sWM5d/IfBY
         8sPYF7gMeCIR2qRoDJw80bwj9nx9ZbEanyMBSIXKYI174Oz3rc1TGlvt8QIeX/V6w5ev
         OH8Q==
X-Gm-Message-State: AOAM531MQ70IIkVFGRxwxQSJajMrNS8x2hUA9JncdIBPKWF8YWP5B0vl
        G/jlsuVUE6DbvTnZl8PA7aVqVelYbyEfC4HWPmQ=
X-Google-Smtp-Source: ABdhPJzb14hFpRdK0QPgCOT6Ysa5z+RF5UtVAfZEvXuCPidOHZfmRodUP0zMDJ8W2GR/HAtwC/AQdg==
X-Received: by 2002:a17:907:2ccf:: with SMTP id hg15mr33759039ejc.219.1619024926674;
        Wed, 21 Apr 2021 10:08:46 -0700 (PDT)
Received: from client-192-168-1-100.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id t1sm72423eju.88.2021.04.21.10.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 10:08:46 -0700 (PDT)
Date:   Wed, 21 Apr 2021 19:08:45 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Siyu Jin <jinsiyu940203@163.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: rockchip: Fix timeout in
 rockchip_pcie_host_init_port()
Message-ID: <YIBcHRbcP4CbR96o@client-192-168-1-100.lan>
References: <20210421083115.30213-1-jinsiyu940203@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210421083115.30213-1-jinsiyu940203@163.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Thank you for sending the patch over!

By the way, this is v2?  If so, then it would be "[PATCH v2]", but not
a big deal.

A few nitpicks.

> In function rockchip_pcie_host_init_port(), it defines a timeout
> value of 500ms to wait for pcie training. However, it is not enough
> for samsung PM953 SSD drive and realtek RTL8111F network adapter,
> which leads to the following errors:

It would be "PCIe" not "pcie", and "Samsung" and "Realtek" so that these
are properly capitalised.

> 	[    0.879663] rockchip-pcie f8000000.pcie: PCIe link training gen1 timeout!
> 	[    0.880284] rockchip-pcie f8000000.pcie: deferred probe failed
> 	[    0.880932] rockchip-pcie: probe of f8000000.pcie failed with error -110

Normally, the time stamp is better removed as it's not very useful.

> The pcie spec only defines the min time of training, not the max
> one. So set a proper timeout value is important. Change the value
> to 1000ms will fix this bug.
[...]

Again, it would be "PCIe" here.  Also, since you are mentioning the PCI
specification, would you be able to provide either a quote or a location
(standard revision, chapter, page, etc.) from the PCI SIG?

Additionally, if this change fixes a previous commit, then it might be
prudent to include the "Fixes:" field referring to it, as it's customary
to do so - a link to a relevant Bugzilla (https://bugzilla.kernel.org/)
would also be fine, if there is anything.

Other than that,

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>


Krzysztof
