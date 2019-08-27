Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0D99F2B7
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 20:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbfH0SyB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 14:54:01 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46349 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfH0SyA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2019 14:54:00 -0400
Received: by mail-ot1-f67.google.com with SMTP id z17so144416otk.13;
        Tue, 27 Aug 2019 11:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N7oNktNQAUJH+sUHR0NB6EzuIGhp5QVB1/RE4ZususQ=;
        b=U1+xEInR37D4PbXFBM/4nPkBzcRt/4uhJepXmOx94G72ERhAHWT9arpCoj5dBSMBCY
         gmjRDHC3C0CKRsqF7etqwzjThz0Dsz+u3ZxXZMQKdVAA+WtNxnhbGE103tKzbUIm3LXw
         9J7FpwbxX2ogRugbyc6iHArmZdLkjtwRMUyJXFQv69ISUPrl247DJJ3MH/S+6+CqXyF4
         DINxy1liwj6UytMzv3dgUd4KtIqd1rsFk0spzngdQohX5q6vSz/g2NxJ/eiEBztaA9hT
         Xf/oql/x5qgfZPkaEzs208QQvc1pplO/KJCw+AJS/3u6OBXtDR7Tbp/YO18HSvseokvj
         q4AQ==
X-Gm-Message-State: APjAAAUa2u+PjhS37vQ/4aI9d/wftE3u3frIna1V8obSBQ1gDMpunXcU
        dmxxPB1pJHimpfKF3pR3jw==
X-Google-Smtp-Source: APXvYqysJkT3ZlMc3kBvdVSqg7vjs4HFGv+NzrWjVBelfZ61WEOj5tO22xXj2jDmx/odK753dKDh+g==
X-Received: by 2002:a9d:390:: with SMTP id f16mr41363otf.93.1566932039790;
        Tue, 27 Aug 2019 11:53:59 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n32sm65214otn.61.2019.08.27.11.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 11:53:59 -0700 (PDT)
Date:   Tue, 27 Aug 2019 13:53:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Chocron <jonnyc@amazon.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        robh+dt@kernel.org, mark.rutland@arm.com, andrew.murray@arm.com,
        dwmw@amazon.co.uk, benh@kernel.crashing.org, alisaidi@amazon.com,
        ronenk@amazon.com, barakw@amazon.com, talel@amazon.com,
        hanochu@amazon.com, hhhawa@amazon.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jonnyc@amazon.com
Subject: Re: [PATCH v4 5/7] dt-bindings: PCI: Add Amazon's Annapurna Labs
 PCIe host bridge binding
Message-ID: <20190827185358.GA23134@bogus>
References: <20190821153545.17635-1-jonnyc@amazon.com>
 <20190821154745.31834-1-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821154745.31834-1-jonnyc@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 21 Aug 2019 18:47:43 +0300, Jonathan Chocron wrote:
> Document Amazon's Annapurna Labs PCIe host bridge.
> 
> Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
> ---
>  .../devicetree/bindings/pci/pcie-al.txt       | 46 +++++++++++++++++++
>  MAINTAINERS                                   |  3 +-
>  2 files changed, 48 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/pcie-al.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
