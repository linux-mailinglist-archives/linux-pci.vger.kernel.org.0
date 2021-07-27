Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6667C3D8271
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 00:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhG0WW5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jul 2021 18:22:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231730AbhG0WW5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Jul 2021 18:22:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96CC660F6E;
        Tue, 27 Jul 2021 22:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627424576;
        bh=VIA7ByopduIbqMqMuEHkcD2asCYDJ/lb6j2Of7Nqwtg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VLEBUNuPe1ipFChimXQ9oSy2CXbIQ3YluBFRdzR2ryk/iTzIi4g645v9NkNYHR8T0
         LE/UQldu7zCmN1bxg7ZFpp/dHnsslb9lsbOzMOe0+6+UQXjwiir95DZB/J92FpE6Hq
         85DfuKBwleT8U/M63Y8N5H7+nHOyJOnhmaGy4YuKoFjFkutWjDzUjmPkfPR6DW1qAd
         z0WWy+I45wQQsmMvgbckzeGMbz5XWqug+D2Ujpb3GyijYM04ncKEuVhPsBefuV3nAf
         XHF/KCw7yW/Fnm6LBe7j14JiOIGC6JI/EjJotP2ME9hyCPbI/J6vCXMoOHVyRDQ2/o
         QJvqTO2Qb/v9Q==
Date:   Tue, 27 Jul 2021 17:22:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v10 8/8] PCI: Change the type of probe argument in reset
 functions
Message-ID: <20210727222255.GA751984@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210709123813.8700-9-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 09, 2021 at 06:08:13PM +0530, Amey Narkhede wrote:
> Introduce a new enum pci_reset_mode_t to make the context of probe argument
> in reset functions clear and the code easier to read.  Change the type of
> probe argument in functions which implement reset methods from int to
> pci_reset_mode_t to make the intent clear.

Not sure adding an enum and a PCI_RESET_MODE_MAX seems worth it to me.
It's really a boolean parameter, and I'd be happy to change it to a
bool.  But I don't think it's worth checking against
PCI_RESET_MODE_MAX unless we need more than two options.

> Add a new line in return statement of pci_reset_bus_function().

Drop this line, since I don't think it's correct and there's no need
to describe whitespace changes anyway.

> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Suggested-by: Krzysztof Wilczyński <kw@linux.com>
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>

> @@ -306,7 +306,7 @@ static int nitrox_device_flr(struct pci_dev *pdev)
>  		return -ENOMEM;
>  	}
>  
> -	pcie_reset_flr(pdev, 0);
> +	pcie_reset_flr(pdev, PCI_RESET_DO_RESET);
>  
>  	pci_restore_state(pdev);
>  

> @@ -526,7 +526,7 @@ static void octeon_destroy_resources(struct octeon_device *oct)
>  			oct->irq_name_storage = NULL;
>  		}
>  		/* Soft reset the octeon device before exiting */
> -		if (!pcie_reset_flr(oct->pci_dev, 1))
> +		if (!pcie_reset_flr(oct->pci_dev, PCI_RESET_PROBE))
>  			octeon_pci_flr(oct);
>  		else
>  			cn23xx_vf_ask_pf_to_do_flr(oct);

> +typedef enum pci_reset_mode {
> +	PCI_RESET_DO_RESET,
> +	PCI_RESET_PROBE,
> +	PCI_RESET_MODE_MAX,
> +} pci_reset_mode_t;
