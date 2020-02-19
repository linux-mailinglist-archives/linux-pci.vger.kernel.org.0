Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76BDB165277
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2020 23:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgBSWY5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Feb 2020 17:24:57 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34831 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgBSWY5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Feb 2020 17:24:57 -0500
Received: by mail-oi1-f193.google.com with SMTP id b18so25521148oie.2;
        Wed, 19 Feb 2020 14:24:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bw/arhxO0zD6uxPv9B55JT/z9CSekm6k6Bmp/kVtLV0=;
        b=iDoyGV5c0sHKnm8fR8KkHHXF/ntWO0w46zg5ISA1UjqFbYZT6PWEJgNscnK/WbzFiq
         zST2+piKM7q4lOxSJE3idurDkXnWN9cSm6HbTejthJM8QihAnSXj8sXAo7xbKMTtaAS7
         R+WoTJmlNxUJkgnSnwOknoV1cqtrkw7YI9ZMijGBZoRy9hvljRb3nHsjSnn0202Hxko5
         ctpdzYwDrwk5IAm+qS6+AOz7vbKP3Y95XtDb/Qv/Y2j1gvtcBF4uxDIfF+BjDYotZnno
         20hfTkJf79AF5oeNR9v6EGFKZ/8u7aOzMtdKfUJeOVRhd5US+KM0S1fes2AIirl+AuPS
         hjwQ==
X-Gm-Message-State: APjAAAUGzG6jwCLUc/rfUKD8lpIHVFw6wRIecqwf7YvXqQxbHcZIFltT
        MvGzhud4J5MSdT4SGnsLUg==
X-Google-Smtp-Source: APXvYqzZzuIwDzmzfqhTKUe49az+Etwqyco/nG1nDw+t4D7VEkxMrWlgNAsahLPneOunxOSWnXEiHQ==
X-Received: by 2002:aca:d903:: with SMTP id q3mr6124909oig.12.1582151096719;
        Wed, 19 Feb 2020 14:24:56 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l80sm428436oib.37.2020.02.19.14.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 14:24:56 -0800 (PST)
Received: (nullmailer pid 16262 invoked by uid 1000);
        Wed, 19 Feb 2020 22:24:54 -0000
Date:   Wed, 19 Feb 2020 16:24:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, joro@8bytes.org,
        baolu.lu@linux.intel.com, linux-doc@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, corbet@lwn.net,
        mark.rutland@arm.com, liviu.dudau@arm.com, sudeep.holla@arm.com,
        guohanjun@huawei.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, dwmw2@infradead.org,
        amurray@thegoodpenguin.co.uk, frowand.list@gmail.com
Subject: Re: [PATCH 01/11] dt-bindings: PCI: generic: Add ats-supported
 property
Message-ID: <20200219222454.GA16221@bogus>
References: <20200213165049.508908-1-jean-philippe@linaro.org>
 <20200213165049.508908-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213165049.508908-2-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 13 Feb 2020 17:50:39 +0100, Jean-Philippe Brucker wrote:
> Add a way for firmware to tell the OS that ATS is supported by the PCI
> root complex. An endpoint with ATS enabled may send Translation Requests
> and Translated Memory Requests, which look just like Normal Memory
> Requests with a non-zero AT field. So a root controller that ignores the
> AT field may simply forward the request to the IOMMU as a Normal Memory
> Request, which could end badly. In any case, the endpoint will be
> unusable.
> 
> The ats-supported property allows the OS to only enable ATS in endpoints
> if the root controller can handle ATS requests. Only add the property to
> pcie-host-ecam-generic for the moment. For non-generic root controllers,
> availability of ATS can be inferred from the compatible string.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/host-generic-pci.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
