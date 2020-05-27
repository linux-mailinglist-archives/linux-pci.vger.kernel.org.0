Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513A51E4365
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 15:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbgE0NUM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 May 2020 09:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0NUM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 May 2020 09:20:12 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7123EC08C5C1;
        Wed, 27 May 2020 06:20:12 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 5so1519801pjd.0;
        Wed, 27 May 2020 06:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dw32ouB6gQXzj8nA7ooTUjln7E5bWlES7f0YQFqrj/0=;
        b=pmSKiN7G0uupR6LhwkcM/0k5mAAcFfDG/oxnNb1Y5eSRQbbB6yoD7YV54eZdwve+8s
         8Q+/vtI3PneaTQnTDmbbh5lssT2QkQDc8jpyeWIoLOP56eljJTpHglqS0hUGlYzRk2U8
         SFewfaCvAHM8Sz1eMF/jHZO+Pcg8stht3QboP32VXEa6k9PXfRuE4QnkYBfOrX5dwCSS
         f9CyBPjE3ClgIbAyzOFEqX1ikJWUhwHJ3xpLAI5Kr1Cxpotw/K8UYvOQLnLDHcYWabUi
         n69SKl/rxtvSZXP0Xz8OAQTdj4UVfQuRK2gqrkb5QCTW9RLNaTQeVad9WDoHf6QIqKCP
         CArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dw32ouB6gQXzj8nA7ooTUjln7E5bWlES7f0YQFqrj/0=;
        b=X4EiQHfiLaAFOp8umIBS5cnmGNuWi1tnOZjG4I9Hktf8cPofsCthaAalVALbpLNxAW
         93ELCQtbkbsyOv2yvux0gqXYQu6XhSSRsWJUGMBywX+p/gOatBTRxLoI5UPOsqzqOXp7
         5n2v14BmLpNEcZQJx5n3bfFwfxeb+KbPI8zDpnibhurj0u29MPXOnm1pwC+LgwyQXcyt
         20aF5sWNMgY4eN4rS36fqUJy1W0ABVIub8M7VlRP5rSfHs+vTPx9uHQxZOB/EM7QSqLU
         uaT2rfwSZRnIgPnj/ClsskvkO/rQwI9IqK05kFwSnWH79v94M1XXoAf+p9FtY6a6Q9Lu
         2Hjw==
X-Gm-Message-State: AOAM533G+cLwR63sn4/Si6/LnxdsLS5jlRYZXmzTOQ3RjxVi1qAWoSy2
        RJzeceXqzHR3+ecjgzX0ZMUnZ4QI
X-Google-Smtp-Source: ABdhPJy3/WG2PX+nNjKnHY5uEmmZ8xLj7mfYO1XTs0pF/6Z80hUoc2d2cBTWcx02bl3IbwVyo7p2YQ==
X-Received: by 2002:a17:902:8c8c:: with SMTP id t12mr5944363plo.285.1590585611919;
        Wed, 27 May 2020 06:20:11 -0700 (PDT)
Received: from localhost ([144.34.194.82])
        by smtp.gmail.com with ESMTPSA id k12sm2083141pfg.177.2020.05.27.06.20.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 May 2020 06:20:11 -0700 (PDT)
Date:   Wed, 27 May 2020 21:20:05 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     "Chocron, Jonathan" <jonnyc@amazon.com>
Cc:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "pratyush.anand@gmail.com" <pratyush.anand@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "tjoseph@cadence.com" <tjoseph@cadence.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] PCI: controller: Remove duplicate error message
Message-ID: <20200527132005.GA7143@nuc8i5>
References: <20200526150954.4729-1-zhengdejin5@gmail.com>
 <1d7703d5c29dc9371ace3645377d0ddd9c89be30.camel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d7703d5c29dc9371ace3645377d0ddd9c89be30.camel@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 26, 2020 at 06:22:56PM +0000, Chocron, Jonathan wrote:
> On Tue, 2020-05-26 at 23:09 +0800, Dejin Zheng wrote:
> > CAUTION: This email originated from outside of the organization. Do
> > not click links or open attachments unless you can confirm the sender
> > and know the content is safe.
> > 
> > 
> > 
> > It will print an error message by itself when
> > devm_pci_remap_cfg_resource() goes wrong. so remove the duplicate
> > error message.
> > 
> 
> It seems like that in the first error case in
> devm_pci_remap_cfg_resource(), the print will be less indicative. Could
> you please share an example print log with the duplicate print?
>
Hi Jonathan:

Thank you very much for using your precious time to review my patch.

I did not have this log and just found it by review codes. the function
of devm_pci_remap_cfg_resource() is designed to handle error messages by
itself. and Its recommended usage is as follows in the function description
	
	base = devm_pci_remap_cfg_resource(&pdev->dev, res);
	if (IS_ERR(base))
		return PTR_ERR(base);

In fact, I think its error handling is clear enough, It just goes wrong
in three places, as follows:

void __iomem *devm_pci_remap_cfg_resource(struct device *dev,
                                          struct resource *res)
{
        resource_size_t size;
        const char *name;
        void __iomem *dest_ptr;

        BUG_ON(!dev);

        if (!res || resource_type(res) != IORESOURCE_MEM) {
                dev_err(dev, "invalid resource\n");
                return IOMEM_ERR_PTR(-EINVAL);
        }

        size = resource_size(res);
        name = res->name ?: dev_name(dev);

        if (!devm_request_mem_region(dev, res->start, size, name)) {
                dev_err(dev, "can't request region for resource %pR\n", res);
                return IOMEM_ERR_PTR(-EBUSY);
        }

        dest_ptr = devm_pci_remap_cfgspace(dev, res->start, size);
        if (!dest_ptr) {
                dev_err(dev, "ioremap failed for resource %pR\n", res);
                devm_release_mem_region(dev, res->start, size);
                dest_ptr = IOMEM_ERR_PTR(-ENOMEM);
        }

        return dest_ptr;
}

BR,
Dejin

> Thanks,
>    Jonathan
