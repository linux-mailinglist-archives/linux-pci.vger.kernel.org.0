Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF93E17BF94
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 14:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgCFNwN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 08:52:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:60856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgCFNwM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Mar 2020 08:52:12 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21AC32072A;
        Fri,  6 Mar 2020 13:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583502732;
        bh=2Ggr7Ey5zJuBdq/youVk3U+Ljlt8xJOdfRzMiDhckzg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CjxoisreNvo+KSMlMPy7akklYK40zx8pZyfkS4kBPLZgCMZ3rEdKRNdvEi9r/IMf/
         KQ6l99TLg7m7cwz3I8w+IwJypEh///j2m8DPdmwGbE5XcZoEsehcrOf/pVgEbJizTj
         /tz/daKqTA5jNuYKYGnt6iQbsm21p/uaTQ9NXQgw=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jADOc-00AaaS-CN; Fri, 06 Mar 2020 13:52:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 06 Mar 2020 13:52:10 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [patch 6/7] genirq: Provide interrupt injection mechanism
In-Reply-To: <20200306130623.990928309@linutronix.de>
References: <20200306130341.199467200@linutronix.de>
 <20200306130623.990928309@linutronix.de>
Message-ID: <772fa52c32de3ca3229d2df3a32cc643@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org, kbusch@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-03-06 13:03, Thomas Gleixner wrote:
> Error injection mechanisms need a half ways safe way to inject 
> interrupts as
> invoking generic_handle_irq() or the actual device interrupt handler
> directly from e.g. a debugfs write is not guaranteed to be safe.
> 
> On x86 generic_handle_irq() is unsafe due to the hardware trainwreck 
> which
> is the base of x86 interrupt delivery and affinity management.
> 
> Move the irq debugfs injection code into a separate function which can 
> be
> used by error injection code as well.
> 
> The implementation prevents at least that state is corrupted, but it 
> cannot
> close a very tiny race window on x86 which might result in a stale and 
> not
> serviced device interrupt under very unlikely circumstances.
> 
> This is explicitly for debugging and testing and not for production use 
> or
> abuse in random driver code.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...
