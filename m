Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70853FB294
	for <lists+linux-pci@lfdr.de>; Mon, 30 Aug 2021 10:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbhH3IiA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Aug 2021 04:38:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233318AbhH3IiA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Aug 2021 04:38:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E907B60FF2;
        Mon, 30 Aug 2021 08:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630312626;
        bh=hOIIhqobCa1Hd7s4CncUFBVt2Lx0qCzIYHdJXKdIa/A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Yy0cQz9vDY/8cIxc+KkAoeMVY15Of4GaubfG6nXqacNDP+tYLWHcmgxFmaJsWpMsa
         8JfLW9tutqfKqKsVORMFvXVUyVHAb4QRb9rwzTfTHEiFvWb6A+400RTu7L5pG5CfWi
         gpcDGZpll8yEnLZ/2tlvD7h0ISGjFVRBBNkqhuHFrgoPV0fQFnZkadAdM8Gk/0+H2/
         MbzpfVqTEX9zGB0ouF9Pzz5sfrQfziGICdKJltGwbj4KEasEngFD0j04GTGmxGaoPb
         wxgAq7r6WDjrBP6X/5lqG237HOgZ+HfdyciCmC3VOo+TxREoRDh7Etnd77m8H9QkXQ
         wTZLsx/JOapQg==
Message-ID: <752472af4f659990ca46595dcc0a150cdcf71ba9.camel@kernel.org>
Subject: Re: [PATCH v3 1/4] PCI: brcmstb: Break register definitions into
 separate header
From:   nicolas saenz julienne <nsaenz@kernel.org>
To:     Jeremy Linton <jeremy.linton@arm.com>, linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, rjw@rjwysocki.net,
        lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 30 Aug 2021 10:37:01 +0200
In-Reply-To: <20210826071557.29239-2-jeremy.linton@arm.com>
References: <20210826071557.29239-1-jeremy.linton@arm.com>
         <20210826071557.29239-2-jeremy.linton@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2021-08-26 at 02:15 -0500, Jeremy Linton wrote:
> We are about to create a standalone ACPI quirk module for the
> bcmstb controller. Lets move the register definitions into a separate
> file so they can be shared between the APCI quirk and the normal
> host bridge driver.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Acked-by: Nicolas Saenz Julienne <nsaenz@kernel.org>

Regards,
Nicolas

