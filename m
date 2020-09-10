Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82034264996
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 18:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgIJQWE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 12:22:04 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:35185 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgIJQVF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2020 12:21:05 -0400
Received: by mail-il1-f194.google.com with SMTP id l4so6227904ilq.2;
        Thu, 10 Sep 2020 09:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WFYcr99e9oKRQQf7M3oV3UjkunbVdfv+xqARYc/QMwo=;
        b=RfdpM6K180aMMTKEr5OuaedPXkQC4BrlVYWFptCu2MGXUNdQZLljVq9QpllfpMTKHO
         o/EmJKP9TSHS1kpd/im9E7UM7fIk8p1AnJYPMDoQ0C2aJ1FVevUh45zLUn+pHvnIZUcP
         +xm25cNg2pr03fN4unNSx4sQ+lQF8psk27Bp/65vYo1KDyCuTV2FsTyc0hNXASSxhgEW
         /Dq+2VY58vKn8Azek1P7PX/Y6dRb+AeLB7VnmWvML50DyGBSxrBIYEj3SFmQ02n4+A6w
         efzdF+Jn7Q87rA6qZYgpd/dFWn3pTEF4ZBdsUDrxROguu7J7s30a4SLrbhqD+PKXnB8e
         jBeQ==
X-Gm-Message-State: AOAM530e0/NRGaV7Q4GQzUzavhG78/L8oGn7f+hanNFEyjCfswSxnrjG
        8KWZcfUkdcGM47vaLBkjXg==
X-Google-Smtp-Source: ABdhPJyw+1I4LioOUAOgnWPGmGnsnWzBAy+MSWJLjUW62/qg+HPmpMSUN5zvFwwn5q5yTRgSBSJzBw==
X-Received: by 2002:a05:6e02:be6:: with SMTP id d6mr8553154ilu.76.1599754861486;
        Thu, 10 Sep 2020 09:21:01 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id z26sm3385107ilf.60.2020.09.10.09.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 09:21:00 -0700 (PDT)
Received: (nullmailer pid 471343 invoked by uid 1000);
        Thu, 10 Sep 2020 16:20:59 -0000
Date:   Thu, 10 Sep 2020 10:20:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        bcm-kernel-feedback-list@broadcom.com,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v11 09/11] PCI: brcmstb: Accommodate MSI for older chips
Message-ID: <20200910162059.GA471185@bogus>
References: <20200824193036.6033-1-james.quinlan@broadcom.com>
 <20200824193036.6033-10-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824193036.6033-10-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 24 Aug 2020 15:30:22 -0400, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> Older BrcmSTB chips do not have a separate register for MSI interrupts; the
> MSIs are in a register that also contains unrelated interrupts.  In
> addition, the interrupts lie in bits [31..24] for these legacy chips.  This
> commit provides common code for both legacy and non-legacy MSI interrupt
> registers.
> 
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 71 +++++++++++++++++++--------
>  1 file changed, 50 insertions(+), 21 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
