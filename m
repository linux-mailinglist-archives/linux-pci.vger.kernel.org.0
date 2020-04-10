Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D729A1A493F
	for <lists+linux-pci@lfdr.de>; Fri, 10 Apr 2020 19:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgDJRiY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Apr 2020 13:38:24 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33909 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgDJRiX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2020 13:38:23 -0400
Received: by mail-oi1-f194.google.com with SMTP id 7so1125975oij.1;
        Fri, 10 Apr 2020 10:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n6yX0b8Hm0JPUuZWcgvM4ULeOvzJFOtIDNl+L5FLnKg=;
        b=fGURTeQRg4yuyxdWnhDgKaPJcSGLNC0X0/y4dBycuDf+nhPRk8byvTqjqE8h6JLRiZ
         4sgtN/OzTVb28X6h6WF+9RAcK/1+PeM0SyZZ71VoxRVm5/TuZ0Zmdm/tZRt5a/JUIoz+
         Phb7FWHg21tKb7tyCvxUkv90HYy4kB5dIZsJthtKyPmqoypekkc/4JYbxCRN7TG3d7St
         ATXARfYvnK/MGvFlobFk6ZEQUZaudEQ/sX23OShyih4XwvVAnMd/zHqYWIqWFymq5dRX
         qIuRdZCKcl130VvaVq9lrd3RBF3Tw/Ddgg5yxvUP8bRS41g8g6gRSeI98mkYVElQmOZf
         BCuA==
X-Gm-Message-State: AGi0Pub7rZKe831fTfwO/z6Lf6hVNXIL6JhWr/eb0khwR3HSTqwTgAJZ
        FEUwt0QDXDda0GrPu57Awg==
X-Google-Smtp-Source: APiQypLKMR+p1kanXyT4GdXxKgvLIIesn44nxyyn3jlU9qHM+24UxE9ucdA80WfebHRxZeQ5740vzg==
X-Received: by 2002:aca:3745:: with SMTP id e66mr3938591oia.153.1586540303586;
        Fri, 10 Apr 2020 10:38:23 -0700 (PDT)
Received: from rob-hp-laptop (ip-99-203-29-27.pools.spcsdns.net. [99.203.29.27])
        by smtp.gmail.com with ESMTPSA id e21sm1635967ooh.31.2020.04.10.10.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:38:22 -0700 (PDT)
Received: (nullmailer pid 24581 invoked by uid 1000);
        Fri, 10 Apr 2020 16:38:17 -0000
Date:   Fri, 10 Apr 2020 11:38:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: PCI: cadence: Deprecate
 inbound/outbound specific bindings
Message-ID: <20200410163817.GA24330@bogus>
References: <20200327104727.4708-1-kishon@ti.com>
 <20200327104727.4708-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327104727.4708-2-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 27 Mar 2020 16:17:25 +0530, Kishon Vijay Abraham I wrote:
> Deprecate cdns,max-outbound-regions and cdns,no-bar-match-nbits for
> host mode as both these could be derived from "ranges" and "dma-ranges"
> property. "cdns,max-outbound-regions" property would still be required
> for EP mode.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/pci/cdns,cdns-pcie-ep.yaml       |  2 +-
>  .../bindings/pci/cdns,cdns-pcie-host.yaml     |  3 +--
>  .../devicetree/bindings/pci/cdns-pcie-ep.yaml | 25 +++++++++++++++++++
>  .../bindings/pci/cdns-pcie-host.yaml          | 10 ++++++++
>  .../devicetree/bindings/pci/cdns-pcie.yaml    |  8 ------
>  5 files changed, 37 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
