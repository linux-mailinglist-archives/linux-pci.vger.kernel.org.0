Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D62017BF6B
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 14:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCFNod (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 08:44:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:59280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgCFNod (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Mar 2020 08:44:33 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBEC32084E;
        Fri,  6 Mar 2020 13:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583502272;
        bh=bUG6thWj/kGv0A21YoypRJ0B8J5Q4vmy/Ag2Tif8t3s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GT/271kidB1iD89fIgVuEUeYZ+2Ow/EiMQcLULFaS3Lz02CJErXIyQAhNnporCvYV
         mwVoYbUTqSlJtV0opD06iAVdVImhGDWGIFQ9AmiK9vvPn4lLjJBHwX9/yX45/64bfp
         bXRN4MXO6j7ptwOWWFoE3zwo6WWPa/O497RA+OM8=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jADHD-00AaT3-3C; Fri, 06 Mar 2020 13:44:31 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 06 Mar 2020 13:44:31 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [patch 4/7] genirq: Add return value to check_irq_resend()
In-Reply-To: <20200306130623.775200917@linutronix.de>
References: <20200306130341.199467200@linutronix.de>
 <20200306130623.775200917@linutronix.de>
Message-ID: <5611ae0ee3a4f6c95cafc4fd782c111a@kernel.org>
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
> In preparation for an interrupt injection interface which can be used
> safely by error injection mechanisms. e.g. PCI-E/ AER, add a return 
> value
> to check_irq_resend() so errors can be propagated to the caller.
> 
> Split out the software resend code so the ugly #ifdef in 
> check_irq_resend()
> goes away and the whole thing becomes readable.
> 
> Fix up the caller in debugfs. The caller in irq_startup() does not care
> about the return value as this is unconditionally invoked for all
> interrupts and the resend is best effort anyway.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...
