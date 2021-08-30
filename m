Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82043FB299
	for <lists+linux-pci@lfdr.de>; Mon, 30 Aug 2021 10:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbhH3Iit (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Aug 2021 04:38:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233318AbhH3Iis (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Aug 2021 04:38:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DF7960E90;
        Mon, 30 Aug 2021 08:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630312675;
        bh=3B3SoEmTflarKluqHHYcvM44FdDkesv4Sp6r40VRys8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZxFWC7k2SHXbugFjCEyHPE4sRsL+sPbahEQvSWmy522K2lk5VtMVo0W0JRcaTG5x9
         T0glpSbEXQroJM7NbJrHFl7kBdOlmi3vsRgpVN84NY8A+vCgr9hwNoarVPYUPpOKVg
         S3SORlWiMwR6oboaisC8MnJ3PPiPZzcTUoySubif7oejnyxZVPexve8O7KSIo2Y6om
         LlhQXSWNH0HTrL+vUIP6Q81joZ5k0CaWPx4kDk3NiWijRXrRlDDbtlBw6DrtiwhE+Q
         D3OPCH3qMAnyNb3Lo6kupoifYabdc+zlGk/atcG5WfOKN/GtdzOhCwj05QUQZmgmD7
         UW83JdkmsR+tw==
Message-ID: <56addfb6b446380543205ed1d71dd218b98154d8.camel@kernel.org>
Subject: Re: [PATCH v3 3/4] PCI/ACPI: Add Broadcom bcm2711 MCFG quirk
From:   nicolas saenz julienne <nsaenz@kernel.org>
To:     Jeremy Linton <jeremy.linton@arm.com>, linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, rjw@rjwysocki.net,
        lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 30 Aug 2021 10:37:51 +0200
In-Reply-To: <20210826071557.29239-4-jeremy.linton@arm.com>
References: <20210826071557.29239-1-jeremy.linton@arm.com>
         <20210826071557.29239-4-jeremy.linton@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2021-08-26 at 02:15 -0500, Jeremy Linton wrote:
> Now that there is a bcm2711 quirk, it needs to be enabled when the
> MCFG is missing. Use an ACPI namespace _DSD property
> "linux-ecam-quirk-id" as an alternative to the MCFG OEM.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Acked-by: Nicolas Saenz Julienne <nsaenz@kernel.org>

Regards,
Nicolas

