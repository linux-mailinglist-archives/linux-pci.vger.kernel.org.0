Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEE3371081
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 04:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhECCWz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 May 2021 22:22:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230368AbhECCWz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 2 May 2021 22:22:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D0A061249;
        Mon,  3 May 2021 02:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620008523;
        bh=+9RJShCToImcgmcu2kcaufXjBbAW+pUORrOy9T4/d9k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ddg/QA9d1H5mfxNZeJ29hHjnXDpAu9Aza0pTo1yANCcjlSt1duSJegpdBql/Jlzyn
         p5vMqSDRwIOgCJzU3ehlNgt6cWN3vaOicTgSBgdy2evHftwyS2AaVgTa6Dg1JBQByw
         skO+EVpnROxd509wawqxnKA3USPjGfPNd/sw3wiT+jURoyzGmI/09Fq5Fe86nODBcH
         TXlIgaDUX/5TrNGK+Jw31b7l7MtdmEPVglcpo6EaSTnYLIYVPhkbBnW7a2Kf6LDi1v
         WSkJuHG3z/h0kq5ca/beFzA9M2xEf9R/sCFMz2f6O8zvkFvbpdqfWxTdRy49pRA/ro
         Z44ZgDUPvYi2A==
Subject: Re: [PATCH v5 1/2] PCI: Add support for a function level reset based
 on _RST method
To:     Shanker Donthineni <sdonthineni@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vikram Sethi <vsethi@nvidia.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>
References: <20210430232624.25153-1-sdonthineni@nvidia.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <439e6cc0-188d-997d-87e6-2b6d2af807bd@kernel.org>
Date:   Sun, 2 May 2021 22:22:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210430232624.25153-1-sdonthineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/30/2021 7:26 PM, Shanker Donthineni wrote:
> The _RST is a standard method specified in the ACPI specification. It
> provides a function level reset when it is described in the acpi_device
> context associated with PCI-device.
> 
> Implement a new reset function pci_dev_acpi_reset() for probing RST
> method and execute if it is defined in the firmware. The ACPI binding
> information is available only after calling device_add(), so move
> pci_init_reset_methods() to end of the pci_device_add().
> 
> The default priority of the acpi reset is set to below device-specific
> and above hardware resets.
> 
> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>

Reviewed-by: Sinan Kaya <okaya@kernel.org>
