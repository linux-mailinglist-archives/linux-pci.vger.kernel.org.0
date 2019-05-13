Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09FD81B9CD
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 17:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbfEMPWH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 11:22:07 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:32790 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbfEMPWH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 11:22:07 -0400
Received: by mail-oi1-f196.google.com with SMTP id m204so9647097oib.0;
        Mon, 13 May 2019 08:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G5tBDBp/DtV8SNXwtrPbsVe7Rc/q6YIIYxtmFnOVJDY=;
        b=km/pEZG4r/5983+BxmdDhpZUuw7sZzLhQtJIiuOwgNbBqg0QXdYW3BTEpUuTPAWJwO
         M6rd6xVyo7qmp81DnGRp9vOxTOXpC8Eomg2RKaFWl0Qjde35USIn63J4ypFDbvAxzFwE
         vjpaSAex+Wa/YZz+vtUFPAAbs/zJKRG/wfgVqRYs8PAAUL0Wg+sQ3NkapZxSV9UoXW2x
         utZ3DgWWQMjFDz6bD456cfzsrbS17IZsTA2LV4+Tt6q9cDDHl7F/9vA3DI1lhEpl/DP3
         QQAKg0fasKTAyEyMdbPUiKzS54NQJKXcjVIVC6sA+I/HHgk4hthPwnyLJBKq1VWinvCN
         MTZg==
X-Gm-Message-State: APjAAAU8JyTatQnQYOr8EdBurt0HAfFCMlmr7xIWoCYJEA8KoHcptc8u
        Yw3KaLkgqCFbAsXyOgHlDw==
X-Google-Smtp-Source: APXvYqyDyMqJLZVdVcByUg10Ow8jEEwxJKUk0RrIJEW9cbnuxfisOiumsiptzyIvhS1udws+DOn7Xg==
X-Received: by 2002:aca:ac43:: with SMTP id v64mr9672388oie.40.1557760926143;
        Mon, 13 May 2019 08:22:06 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o206sm5281587oih.48.2019.05.13.08.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 08:22:05 -0700 (PDT)
Date:   Mon, 13 May 2019 10:22:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, kishon@ti.com, catalin.marinas@arm.com,
        will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, vidyas@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V6 10/15] dt-bindings: PHY: P2U: Add Tegra194 P2U block
Message-ID: <20190513152204.GA20594@bogus>
References: <20190513050626.14991-1-vidyas@nvidia.com>
 <20190513050626.14991-11-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513050626.14991-11-vidyas@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 13 May 2019 10:36:21 +0530, Vidya Sagar wrote:
> Add support for Tegra194 P2U (PIPE to UPHY) module block which is a glue
> module instantiated one for each PCIe lane between Synopsys DesignWare core
> based PCIe IP and Universal PHY block.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes since [v5]:
> * Added Sob
> * Changed node name from "p2u@xxxxxxxx" to "phy@xxxxxxxx"
> 
> Changes since [v4]:
> * None
> 
> Changes since [v3]:
> * None
> 
> Changes since [v2]:
> * Changed node label to reflect new format that includes either 'hsio' or
>   'nvhs' in its name to reflect which UPHY brick they belong to
> 
> Changes since [v1]:
> * This is a new patch in v2 series
> 
>  .../bindings/phy/phy-tegra194-p2u.txt         | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
