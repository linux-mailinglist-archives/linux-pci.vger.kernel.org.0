Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D321C8D29
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 16:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgEGOAS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 10:00:18 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36649 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgEGOAR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 10:00:17 -0400
Received: by mail-oi1-f196.google.com with SMTP id x7so4329391oic.3;
        Thu, 07 May 2020 07:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5obdS31sMzy2WravwryFoBjEaM1odMtdjQvUC4fHdms=;
        b=ExqIWMVZAOjojEW5hsissObp2SCh7jHDjDG24Iilnw7qY+g/oYElMsCpZNFPaBjBr3
         RExwSLsFg0nTmV2SgdfU+qm+GJhRX63LmGJyF9LE40/HY3icHnZz+tDEXPSPeMTDZVGz
         CxbWSpauAVOP3HAK7aOoVPpaS5mudOCf2kzppjue2Di7749KV5KNwuCQa5KtttgBLI6m
         lHQsLhrVDwVc1sjj7nbLJeq6FH3p9i65nEJKDqoTPM/pTNvyadyLKWKwJjeLpCKUEsk5
         QeyMrsGtCqIZf4NX8ofPoM9qST88aqNNMVfc/GKQ82FfBTiLbFQvi8jG6fSL+xKlbsHo
         XEPA==
X-Gm-Message-State: AGi0Pua3huMNP5HAD1fTp6cUS9fd+lYHto143BOWJ4oY4K7vva7rhd+g
        UZ14RYgIR1jALZiOFFFJ4Q==
X-Google-Smtp-Source: APiQypKzzBpzLKb19Oq6n42KnCLxq3n5Ag62OOoby5Ov/MPPD1ziCvGHjfHjs6PTZ8/5D6lB2YO3QA==
X-Received: by 2002:aca:d6c1:: with SMTP id n184mr6603818oig.126.1588860016614;
        Thu, 07 May 2020 07:00:16 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 60sm1113676oth.38.2020.05.07.07.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 07:00:15 -0700 (PDT)
Received: (nullmailer pid 22066 invoked by uid 1000);
        Thu, 07 May 2020 14:00:13 -0000
Date:   Thu, 7 May 2020 09:00:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, William Wu <william.wu@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 3/6] PCI: dwc: Skip allocating own MSI domain if using
 external MSI domain
Message-ID: <20200507140013.GA23957@bogus>
References: <1581574091-240890-1-git-send-email-shawn.lin@rock-chips.com>
 <1581574091-240890-4-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581574091-240890-4-git-send-email-shawn.lin@rock-chips.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 13, 2020 at 02:08:08PM +0800, Shawn Lin wrote:
> On some platform, external MSI domain is using instead of the one
> created by designware driver. For instance, if using GIC-V3-ITS
> as a MSI domain, we only need set msi-map in the devicetree but
> never need any bit in the designware driver to handle MSI stuff.
> So skip allocating its own MSI domain for that case.

A new field isn't needed. Just implement the msi_host_init() hook.

Rob
