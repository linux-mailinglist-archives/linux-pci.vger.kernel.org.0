Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109183B1B9F
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 15:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhFWNzt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 09:55:49 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:42828 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhFWNzr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jun 2021 09:55:47 -0400
Received: by mail-ej1-f51.google.com with SMTP id bg14so4131363ejb.9;
        Wed, 23 Jun 2021 06:53:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xJccocnoRdorcslUAq9kb6AGcZBt5E/D2oTNxvA/DUE=;
        b=QWirZGqOn4x5bjIFEBJdvTlZx1redvBJXVAjbgNzQBr+JAdIGGKIURHSZGZ/o+fVj6
         hYNN9ctv8gbVTrDceCyuuZ6CFZftY2MdSJV1e+KzZZ1XshIa7xoyz4uQaiT6DeOGkuxi
         T1A91Pg5tFZvFn/iwziIe56+nigpM/6zW+Zn7eXVr1vtfjgGfwG76b7xHJwdBOBECHz7
         jIE3yOhPlEtou9FoxU9NZ8x5QAXm/PzdfQ49f14KuEqJs+zErfYQCvq+tM1++oTG7C1o
         rvcpLRIuNveJumB43JR6uyVMc9U304B3+Fic+cAuY2jOWpXXsqpu/M7YaJcGnjTW+Pe2
         WodA==
X-Gm-Message-State: AOAM532zEkJ+HFYqSNB2Qyvd2SQ18kR4S+OUQM/1tNKfpjU3tp+geqjM
        8ak8rNLe2O2spy3syBJEZRsAyMNpuRUbX15f8jE=
X-Google-Smtp-Source: ABdhPJx4MiPBQ7sojERe3xK7MmHDIA3eZ06CVhmxc0qfIKDm5CajmkayvlQvbc/hC7PnBccVzO+z/g==
X-Received: by 2002:a17:906:ce29:: with SMTP id sd9mr168698ejb.56.1624456408751;
        Wed, 23 Jun 2021 06:53:28 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id da28sm77961edb.0.2021.06.23.06.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 06:53:28 -0700 (PDT)
Date:   Wed, 23 Jun 2021 15:53:26 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        bharat.kumar.gogada@xilinx.com, Hyun Kwon <hyun.kwon@xilinx.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Ravi Kiran Gummaluri <rgummal@xilinx.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: xilinx-nwl: Enable the clock through CCF
Message-ID: <20210623135326.GA54420@rocinante>
References: <cover.1624454607.git.michal.simek@xilinx.com>
 <be603822953d0a815034a952b9c71bac642f22ae.1624454607.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be603822953d0a815034a952b9c71bac642f22ae.1624454607.git.michal.simek@xilinx.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Sasha for visibility]

Hi Michal,

Thank you for sending v2 so promptly!  And for all the extra changes and
fixes.  Much appreciated!

> Enable PCIE reference clock. There is no remove function that's why
> this should be enough for simple operation.
> Normally this clock is enabled by default by firmware but there are
> usecases where this clock should be enabled by driver itself.
> It is also good that clock user is recorded in clock framework.

Small nitpicks: it would be PCIe here in the above and in the error
message (this is as per [1]), and "use cases" also in the above. 

This can be corrected when the patch will be merged by either Bjorn or
Lorenzo, to avoid sending v3 unnecessarily, provided that they would
have a moment to do it, of course.

> Fixes: ab597d35ef11 ("PCI: xilinx-nwl: Add support for Xilinx NWL PCIe Host Controller")

Thank you!

Does it make sense for this change to be back-ported to stable and
long-term kernels?

I am asking to make sure we do the right thing here, as I can imagine
that older kernels (primarily because some folks could use, for example,
Ubuntu LTS releases for development) might often be used by people who
work with the Xilinx FPGAs and such.

[...]
> +	err = clk_prepare_enable(pcie->clk);
> +	if (err) {
> +		dev_err(dev, "can't enable pcie ref clock\n");
> +		return err;
> +	}
> +

As per the nitpick above, it would be "PCIe", but probably no need to
send v3 to correct this.

1. https://lore.kernel.org/linux-pci/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com/

	Krzysztof
