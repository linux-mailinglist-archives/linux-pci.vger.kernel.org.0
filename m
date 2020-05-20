Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625221DC1E1
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 00:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgETWMI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 18:12:08 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38623 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbgETWMI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 18:12:08 -0400
Received: by mail-io1-f66.google.com with SMTP id d7so5138552ioq.5;
        Wed, 20 May 2020 15:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TrpuUenHVc45xYnWry+XkSkEe/vvRn8TLqlEqWx18Fo=;
        b=RG0S6N1+rZiJAZGOOxY8ENRhgEHICZSBSLuyQLnANYFDot63k8AizeUFTkd3Q8/8uo
         ZMYqSRNDl5d1bWLemSkEAGJNQsMZauMd7tY94XRosg3YkSIbhNdx+Nt1HvB0GRX6UoIy
         123pOadwGQYusezzJHCtYRVxCoU3K18JXzm5olyPAy4adl3JJJeo9oOZvRH7th1MPa27
         MiJM7ty2ZF0GgXghHU2Go9dy5GYjwpAKrk9b9gsKeugKqqgvb6UU8z2VHmjIETs1BmsQ
         g3CmZE0+zumNvpOboEC32wYXo3q27LKDL2DV0BPjEnbgsWP0qRb0e5YvuLpTcjwNF3c5
         TXFg==
X-Gm-Message-State: AOAM530FJ6zoZZXJCblWr6HoplGXa9Sv1bMbG2GjZXkeBIWnyRRbgiCe
        8lpVbwQgt+3ZLrnLUnRtVA==
X-Google-Smtp-Source: ABdhPJw2KEWNCuaWXpnBG7wbgtBlN5A5qfeRytczstHIJYtrHxbmTOwSrrw1+LHUYr7gGkNzEBG1ZQ==
X-Received: by 2002:a02:5807:: with SMTP id f7mr1213350jab.118.1590012727297;
        Wed, 20 May 2020 15:12:07 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id t75sm2084101ild.4.2020.05.20.15.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 15:12:06 -0700 (PDT)
Received: (nullmailer pid 691599 invoked by uid 1000);
        Wed, 20 May 2020 22:12:05 -0000
Date:   Wed, 20 May 2020 16:12:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tom Joseph <tjoseph@cadence.com>, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 13/14] misc: pci_endpoint_test: Add J721E in
 pci_device_id table
Message-ID: <20200520221205.GA691565@bogus>
References: <20200506151429.12255-1-kishon@ti.com>
 <20200506151429.12255-14-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506151429.12255-14-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 6 May 2020 20:44:28 +0530, Kishon Vijay Abraham I wrote:
> Add J721E in pci_device_id table so that pci-epf-test can be used
> for testing PCIe EP in J721E.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/misc/pci_endpoint_test.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
