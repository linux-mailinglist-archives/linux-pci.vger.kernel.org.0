Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28EFB18E973
	for <lists+linux-pci@lfdr.de>; Sun, 22 Mar 2020 15:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgCVOuZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Mar 2020 10:50:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33491 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgCVOuZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Mar 2020 10:50:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id j1so3443054pfe.0;
        Sun, 22 Mar 2020 07:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VzpMsaGUucPpP6fSW/cSM6C+7riJcwDU7MFrk8qZK08=;
        b=A+wyUWCyuSGbBGYrVxL3lfpAMEm9Pw7lyM1JfznsrrtgMW/o6IzzRGitu4S4esNGpi
         8Ee78r+qIGkf45lpvlDrcRjhgDtARjTA/HFA3m2CHQISObO0vJqixQI6XTNulD+VxxMV
         Ac7RW9icnj4MN1AJfv6kTVT2sq84yKep5ghOOqZ2SHiCfj68EAKTIu46hbFFhLsNxk77
         dYvyOjYv8rHyGxlZ0IXpgt6Cz0Mj9A+eFS20jNm7RtLw9EaSHfJikcrDvlymvinrn+00
         ij8YnbvINbjAQsnoOdKd3n795yaUqPJ2ZdWZEC7tladhIE1FDzVAklYUGTR+Qj/9FrdU
         WHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=VzpMsaGUucPpP6fSW/cSM6C+7riJcwDU7MFrk8qZK08=;
        b=sh7tks2Gg3xPmigOsjnD4wInDsbWBIg2VF1z2e9FuAiRbsA4e061GmD6RP5fYeR0AG
         msxjK5oqIpLx+OWE9iDwUn3qWoUPkMrPEaqGJm5jEpSFXM169gnIwL4Cozl4iFKrdO55
         gFchvR4zlsezkv33cdnGJax9I8mXHWmrHn1AVbynRoTDIW9P5OnP0sV11RQPskgV2u6+
         fzwIat+2urd1eIkDaiaShgYt6piVoPQmdYxbamFjFQVVDyJL/hKC+kqRihOAOtey/Z3H
         SokBnAhJXPgNCn1XRaL6Sj1CxwDbMI0AUztozNAqpFmSLjmI+BPGlHNrG5WZFhQ6TSkE
         u5+w==
X-Gm-Message-State: ANhLgQ3ql6kWUYddEcUnCo1YTpYwayF9J/J7qKCVCvbiH49abanN1QP6
        oYb66S4pBoqOO12rd+eb700=
X-Google-Smtp-Source: ADFU+vsC3unH8wqa2M/Kjr8Fps9W1SvqISpzPCWWajii9wOO7dTp9OThgGswhR+FbVFnRd+cWKO23w==
X-Received: by 2002:a62:b613:: with SMTP id j19mr20415336pff.90.1584888623675;
        Sun, 22 Mar 2020 07:50:23 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p9sm9666063pgs.50.2020.03.22.07.50.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Mar 2020 07:50:22 -0700 (PDT)
Date:   Sun, 22 Mar 2020 07:50:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        andrew.murray@arm.com, kishon@ti.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V5 5/5] PCI: tegra: Add support for PCIe endpoint mode in
 Tegra194
Message-ID: <20200322145020.GA2040@roeck-us.net>
References: <20200303181052.16134-1-vidyas@nvidia.com>
 <20200303181052.16134-6-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303181052.16134-6-vidyas@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 03, 2020 at 11:40:52PM +0530, Vidya Sagar wrote:
> Add support for the endpoint mode of Synopsys DesignWare core based
> dual mode PCIe controllers present in Tegra194 SoC.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>

ERROR: modpost: "dw_pcie_ep_init" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
ERROR: modpost: "dw_pcie_ep_linkup" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
ERROR: modpost: "dw_pcie_ep_init_notify" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
ERROR: modpost: "dw_pcie_ep_init_complete" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!

Either the symbols must be exported, or the driver's Kconfig entry must be
bool, not tristate.

Guenter
