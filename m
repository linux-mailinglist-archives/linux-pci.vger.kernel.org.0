Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D851C9C56
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 22:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgEGU1X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 16:27:23 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46828 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgEGU1W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 16:27:22 -0400
Received: by mail-oi1-f193.google.com with SMTP id c124so6202452oib.13;
        Thu, 07 May 2020 13:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uy7h/oO1ZYJDadGFilbbke7nBxNMMJV6xLNxqzehMYo=;
        b=uimifnne+SSHCKeUe+1TsKkl9/Zw9fOxtSNhpf88BDHJFMGHn4DbZfnpctS1v4sBOY
         ShKZoM+uKw9LkR+igfdpPKaLzHrrUBtTjUU46YDu6TpZ33t7QlC6kviWDYKWrh6I7kjw
         /9NMruiNTjhJOb5mcz+CQqAz397O3HXKScxFwdAEaOP4ChQ2xjpTWGX/ME6GgCy4IWNS
         6u3fS6HToCcGHCy8NYAQzUX9QcjL8mk9ex2Qyul1WT4+NyuF+r2IZw+Bqd/UJU7aUNwW
         D+g7WuxzDcpxOGPtSYAVx2rJefcMYvkmvStJecFI86Ka1XpxBzkma8KP8Dp6lW6M1OUH
         2ZFw==
X-Gm-Message-State: AGi0Pub51BzQCsrfBZB3x1lNE1CRDysC3NTV6IHQrkwRi8uvI1/uiJGu
        JmLr5nxjVXcsLm/JOo4x/M9DhRo=
X-Google-Smtp-Source: APiQypJBEMOxpjKXqiX/vqWu34ulYyApspuRFBGGG6vImSzpIfpujRKg4BAh+t3LxVSRwqCb+jWTbA==
X-Received: by 2002:aca:3cc6:: with SMTP id j189mr3237014oia.137.1588883240425;
        Thu, 07 May 2020 13:27:20 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r21sm1582379otg.67.2020.05.07.13.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 13:27:19 -0700 (PDT)
Received: (nullmailer pid 20405 invoked by uid 1000);
        Thu, 07 May 2020 20:27:19 -0000
Date:   Thu, 7 May 2020 15:27:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] PCI: cadence: Remove "cdns,max-outbound-regions"
 DT property
Message-ID: <20200507202718.GA20346@bogus>
References: <20200417114322.31111-1-kishon@ti.com>
 <20200417114322.31111-4-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417114322.31111-4-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 17 Apr 2020 17:13:21 +0530, Kishon Vijay Abraham I wrote:
> "cdns,max-outbound-regions" device tree property provides the
> maximum number of outbound regions supported by the Host PCIe
> controller. However the outbound regions are configured based
> on what is populated in the "ranges" DT property.
> 
> Avoid using two properties for configuring outbound regions and
> use only "ranges" property instead.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-host.c | 6 ------
>  drivers/pci/controller/cadence/pcie-cadence.h      | 2 --
>  2 files changed, 8 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
