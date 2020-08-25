Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD1725234F
	for <lists+linux-pci@lfdr.de>; Wed, 26 Aug 2020 00:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgHYWF3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Aug 2020 18:05:29 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:39969 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgHYWF3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Aug 2020 18:05:29 -0400
Received: by mail-il1-f195.google.com with SMTP id p18so90502ilm.7;
        Tue, 25 Aug 2020 15:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yr8pBKNlRBBu/zVmrZurbm8nwnQCAlAISsxv0Pfzf/I=;
        b=r4Sp/zAeiKPw/MRxiQSMziiLH+ZPG7fIazX1ngR0NlypPQlPPY7X0OOlQbq11TMYRL
         DMb9nrfBVUauF06OkU0QNTvvurGWnLL9r5RIKWbCD/YqhDWo2Vd+t5ynXoK8gEJUy+v+
         54VIVC47ppcPIAX4hAGT72ZzR21BSEyXu16VZ8tJqZlPTfHmaU3SmiAMOSreD1KpJFhL
         ks1K3V9SwPb3baz9AdnpNcsANHCF3QeNrnLTej4/rS3TfyG/9PdOA51fuYGtLxvcPI2y
         aCNgE+u8Qni8LjjIXUgZY9yNYszw8Jjgylc8wG1+dwpauoavx3kWyd9pzU2xF3flN7v/
         F0/w==
X-Gm-Message-State: AOAM53031SXNdidfJdwv7V3J3VlVsRQv1WGZAi7t9bRPKMcTRuVHPy/y
        714Wd6E7lZtrJtWsGOsPxvTYS4M7du7T
X-Google-Smtp-Source: ABdhPJxOmo+9qg9pF8+1gjfj0EnflJQ6hmc5SfUGFqzzf966Oud70qdfbnoCRy8B38rIr9FQ7Tt2aw==
X-Received: by 2002:a92:dccd:: with SMTP id b13mr9418297ilr.12.1598393128429;
        Tue, 25 Aug 2020 15:05:28 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id h13sm58819iob.33.2020.08.25.15.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 15:05:27 -0700 (PDT)
Received: (nullmailer pid 1423326 invoked by uid 1000);
        Tue, 25 Aug 2020 22:05:26 -0000
Date:   Tue, 25 Aug 2020 16:05:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daire.McNamara@microchip.com
Cc:     linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, david.abdurachmanov@gmail.com
Subject: Re: [PATCH v15 1/2] dt-bindings: PCI: microchip: Add Microchip
 PolarFire host binding
Message-ID: <20200825220526.GA1423268@bogus>
References: <954a9f86bbfe929bc37653f1e616e8acff8b4bd8.camel@microchip.com>
 <9228b6315ba92e9e74b3f6484df6f4957ec4faae.camel@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9228b6315ba92e9e74b3f6484df6f4957ec4faae.camel@microchip.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 19 Aug 2020 16:32:01 +0000, Daire.McNamara@microchip.com wrote:
> Add device tree bindings for the Microchip PolarFire PCIe controller
> when configured in host (Root Complex) mode.
> 
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> ---
>  .../bindings/pci/microchip,pcie-host.yaml     | 93 +++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
