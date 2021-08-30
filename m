Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5133FB29C
	for <lists+linux-pci@lfdr.de>; Mon, 30 Aug 2021 10:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbhH3IjJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Aug 2021 04:39:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235163AbhH3IjJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Aug 2021 04:39:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B97A61008;
        Mon, 30 Aug 2021 08:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630312696;
        bh=f1olFO82sWe3p2VCV3br/BgPMdDVvXBhDh6AZEmbolA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=o1jTbz9zk67cifEWsnTEQbmMDBdVGpA0VmbZGlHzrcWEDj4wTjeUAVX/cLfeqVrCB
         faK3f/dtv8L0ILJIcbKr31AM4AkunEAN+LRfe90lu918ueFWsPKYvsJ9EkEhkMdt2g
         voRk7sL6qtwUH29mBm3S7/gtUp8gZX+SEHYc5A6FYpQshEb2Y90vCxTiC/JacU2ByZ
         JAX9ShdTto56fCF/3lEDoB43Kt4FJN9sdV67yRZcOnYXFBe/r73NJcJ3wQm/mxfE4M
         6tnycN0lbv/hklIC1xQonjki9ETQgZ2rCl0NEDI+mQFtKKCAn1D/CSSh34/5Fc2vp4
         yc5nnYJ8BWpvg==
Message-ID: <5e0673edbdd793870738c6f5eeebd8ffca747e07.camel@kernel.org>
Subject: Re: [PATCH v3 4/4] MAINTAINERS: Widen brcmstb PCIe file scope
From:   nicolas saenz julienne <nsaenz@kernel.org>
To:     Jeremy Linton <jeremy.linton@arm.com>, linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, rjw@rjwysocki.net,
        lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 30 Aug 2021 10:38:11 +0200
In-Reply-To: <20210826071557.29239-5-jeremy.linton@arm.com>
References: <20210826071557.29239-1-jeremy.linton@arm.com>
         <20210826071557.29239-5-jeremy.linton@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2021-08-26 at 02:15 -0500, Jeremy Linton wrote:
> The brcmstb PCI hardware is now split across multiple files. Include
> them in the maintainers block.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Acked-by: Nicolas Saenz Julienne <nsaenz@kernel.org>

Regards,
Nicolas

