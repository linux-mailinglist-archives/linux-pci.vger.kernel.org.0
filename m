Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E703026C4DD
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 18:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgIPQHh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 12:07:37 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36025 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgIPQEk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2020 12:04:40 -0400
Received: by mail-io1-f67.google.com with SMTP id d190so8862466iof.3;
        Wed, 16 Sep 2020 09:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DzLg3ZfFwjb5ztn4qpshcHnu8BZ+evVJsI0I2BOv1lg=;
        b=RzSHJ8+56ZJO2IzemCfF6lqiL8JqGvgF6guI7sBDCvataTamlk+zLvdiavybspERQo
         FB/SrBYsakzc5pDgZm45awVZSQLWtq7+OI5i06+NfnxbZPo06zHH2F3Y51er34Qv2URX
         4yQBvBeDLWGuSjtG7T+j3aRLAi6O+c0hLsS1ZtPZ0P5uVXGmBaTt0RdEQY/M9MsUYIv4
         D+WKd0dL0bLY3TlaEvAbgdNqqtdz4sRf62Gr2gOdzsD3UfQbRO0W+BJ+T62UxVvFnDN5
         aUhMn3gifAaNpg3TZG7TY0LaIDNpFRybHp/yJM1YFW/0Bki4kjlDNsLRBPWbbJyLgi7B
         b/1Q==
X-Gm-Message-State: AOAM531JJY8ZUgSz9bY+ITulK40fVYgbJcqq1kLw9hr/bROKBqaFfeYL
        cID7fvuOaNV47u6QLq6jxHZRTbo0w1b7
X-Google-Smtp-Source: ABdhPJz+eZmBm1fA84xLrVeztI2UZvbXmOzM08dD6YdLXEvTuwJKtqpMZXzXcVPqUG9WujyLVxfY4g==
X-Received: by 2002:a92:dc43:: with SMTP id x3mr21323380ilq.199.1600269894014;
        Wed, 16 Sep 2020 08:24:54 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id o10sm11131350ilk.36.2020.09.16.08.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 08:24:53 -0700 (PDT)
Received: (nullmailer pid 3994973 invoked by uid 1000);
        Wed, 16 Sep 2020 15:24:51 -0000
Date:   Wed, 16 Sep 2020 09:24:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Jim Quinlan <jquinlan@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 04/10] PCI: brcmstb: Add suspend and resume pm_ops
Message-ID: <20200916152451.GB3991893@bogus>
References: <20200911175232.19016-1-james.quinlan@broadcom.com>
 <20200911175232.19016-5-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911175232.19016-5-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 11, 2020 at 01:52:24PM -0400, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> Broadcom Set-top (BrcmSTB) boards typically support S2, S3, and S5 suspend
> and resume.  Now the PCIe driver may do so as well.
> 
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 47 +++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
